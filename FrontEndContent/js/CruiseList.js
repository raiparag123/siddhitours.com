var CruiseList = [];
var CompanyList = [];
var Country = [];
var url = "CruiseList.aspx";
var filter = []
var flag = 0;
var DateList = [];
var datestring = "";
var cruiseId = "";
var currencyFlag = "1";
var cruiseDlr = [];
$(document).ready(function () {
    $("#nav").removeClass(".affix-top");
    $("#nav").removeAttr("data-spy");
    $("#ddlcountry").change(function (e) {
        flag = 1;
        var icon = "";
        if (currencyFlag == 1) {
            icon = "₹";
        }
        else {
            icon = "$";
        }
        var value = $("#ddlcountry option:selected").val();
        if (value != "0") {
            if (currencyFlag == 1) {
                filter = jQuery.grep(CruiseList, function (n, idx) {
                    return CruiseList[idx][4] == value;
                });
            }
            else {
                filter = jQuery.grep(cruiseDlr, function (n, idx) {
                    return cruiseDlr[idx][4] == value;
                });
            }
        }
        else {
            filter = CruiseList;
        }
        bindFilterTour(filter,icon);
    });

    currencyFlag = $("#currValue").val();
    if (currencyFlag == 1) {
        $("input[name='currency'][value=INR]").attr('checked', 'checked');
    }
    else {
        $("input[name='currency'][value=DOLLAR]").attr('checked', 'checked');
    }


    $("#popular").click(function (e) {
        e.preventDefault();
        
        if (flag == 1) {
            filter.sort(function (a, b) {
                var a1 = a[0], b1 = b[0];
                if (a1 == b1) return 0;
                return a1 < b1 ? 1 : -1;
            });
            bindFilterTour(filter);
        }
        else {
            if (currencyFlag == 1) {
                CruiseList.sort(function (a, b) {
                    var a1 = a[0], b1 = b[0];
                    if (a1 == b1) return 0;
                    return a1 < b1 ? 1 : -1;
                });
                bindFilterTour(CruiseList);
            }
            else {
                CruiseDlr.sort(function (a, b) {
                    var a1 = a[0], b1 = b[0];
                    if (a1 == b1) return 0;
                    return a1 < b1 ? 1 : -1;
                });
                bindFilterTour(CruiseDlr);
            }
        }
    });

    $("#high").click(function (e) {
        var icon = "";
        if (currencyFlag == 1) {
            icon = "₹";
        }
        else {
            icon = "$";
        }
        e.preventDefault();
        if (flag == 1) {
            filter.sort(function (a, b) {
                var a1 = a[6], b1 = b[6];
                if (a1 == b1) return 0;
                return a1 < b1 ? 1 : -1;
            });
            bindFilterTour(filter, icon);
        }
        else {
            if (currencyFlag == 1) {
                CruiseList.sort(function (a, b) {
                    var a1 = a[6], b1 = b[6];
                    if (a1 == b1) return 0;
                    return a1 < b1 ? 1 : -1;
                });
                bindFilterTour(CruiseList, icon);
            }
            else {
                cruiseDlr.sort(function (a, b) {
                    var a1 = a[6], b1 = b[6];
                    if (a1 == b1) return 0;
                    return a1 < b1 ? 1 : -1;
                });
                bindFilterTour(cruiseDlr, icon);
            }
        }

    });

    $("#low").click(function (e) {
        e.preventDefault();
        var icon = "";
        if (currencyFlag == 1) {
            icon = "₹";
        }
        else {
            icon = "$";
        }
        if (flag == 1) {
            filter.sort(function (a, b) {
                var a1 = a[6], b1 = b[6];
                if (a1 == b1) return 0;
                return a1 > b1 ? 1 : -1;
            });
            bindFilterTour(filter, icon);
        }
        else {
            if (currencyFlag == 1) {
                CruiseList.sort(function (a, b) {
                    var a1 = a[6], b1 = b[6];
                    if (a1 == b1) return 0;
                    return a1 > b1 ? 1 : -1;
                });

                bindFilterTour(CruiseList,icon);
            }
            else {
                cruiseDlr.sort(function (a, b) {
                    var a1 = a[6], b1 = b[6];
                    if (a1 == b1) return 0;
                    return a1 > b1 ? 1 : -1;
                });

                bindFilterTour(cruiseDlr,icon);
            }
        }

    });

    $("#Company").on('click', '.company', function (e) {
        e.preventDefault();
        var a = $(this).attr("id");
        //console.log(a);
        if (currencyFlag == 1) {
            filter = jQuery.grep(CruiseList, function (n, idx) {
                return CruiseList[idx][7] == a;
            });
            bindFilterTour(filter,"₹");
        }
        else {
            filter = jQuery.grep(cruiseDlr, function (n, idx) {
                return cruiseDlr[idx][7] == a;
            });
            bindFilterTour(filter,"$");

        }

        
    });

    $("input[name='currency").change(function (e) {
        //$('#form').bootstrapValidator('validate');
        var value = $("input[name='currency']:checked").val();
        var sendValue = ""
        if (value == 'INR') {
            sendValue = 1;
            currencyFlag = 1;
            BindTour();
        }
        else {
            sendValue = 0;
            currencyFlag = 0;
            BindTour();
        }
        $.ajax({
            type: "POST",
            url: "Default.aspx/SetSession",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ Value: sendValue }),
            dataType: "json",
            success: function (msg) {
                if (msg.d != "") {


                }
            },
            Error: function (x, e) {
                alert(msg.d);
            }
        });
       
    });




    getCompanyList();
    getTourList();
});

function getCompanyList() {
    $.ajax({
        type: "POST",
        url: url + "/getCompanyList",
        contentType: "application/json; charset=utf-8",

        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
                mapCompanyList(jsonObj);
                BindCompany();
                //$("#Businesstour").show();
                //$("#no-tour").hide();
            }
            else {
                $("#Businesstour").hide();
                $("#no-tour").show();
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function mapCompanyList(obj) {
    CompanyList = $.map(obj, function (el) {
        return {
            0: el.CompanyId,
            1: el.ImagePath
        }
    });

    //$.each(CruiseList, function (i) {
    //    Country.push(CruiseList[i][4]);
    //})
    //Country = jQuery.unique(Country);

    //BindDropdown();
}

function BindCompany() {
    var strData = "";
    $("#Company").empty();
    //$("#cruiseList").addClass('row');
    if (CompanyList.length > 0) {
        var imgno = 1;
        $.each(CompanyList, function (i) {

            strData +=  '<div class="item">' +
                        '<div class="panel panel-default">'+
						'<div class="panel-body"><a href="#" class="company" id="'+ CompanyList[i][0] +'">'+
						'<img src="'+ CompanyList[i][1] +'" class="img-responsive"></a>' +
						'</div>' +
						'</div>' +
						'</div>';
        });
        $("#Company").append(strData);
        //$("#Company").append("</div>");
        var carousel = $("#Company");
        carousel.trigger('destroy.owl.carousel');
        carousel.find('.owl-stage-outer').children().unwrap();
        carousel.removeClass("owl-center owl-loaded owl-text-select-on");

        carousel.html(strData);

        //reinitialize the carousel (call here your method in which you've set specific carousel properties)
        carousel.owlCarousel({
            center: true,
            loop: true,
            autoPlay: 3000,
            margin: 10,
            dots: true,
            responsive: {
                600: {
                    items: 5
                }
            }
        });

        $('.next').click(function () {
            carousel.trigger('next.owl.carousel');
        })
        $('.prev').click(function () {
            carousel.trigger('prev.owl.carousel');
        })
    }
}

function getTourList() {
    $.ajax({
        type: "POST",
        url: url + "/getTourList",
        contentType: "application/json; charset=utf-8",

        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var obj = msg.d.split("~");
                var jsonObj = JSON.parse(obj[0]);
                var datelist = JSON.parse(obj[1]);
                mapTourList(jsonObj);
                mapDates(datelist);
                //window.setTimeout(BindTour(), 5000);
                setTimeout(function () { BindTour() }, 1000);
                $("#Businesstour").show();
                $("#no-tour").hide();
            }
            else {
                $("#Businesstour").hide();
                $("#no-tour").show();
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function mapDates(obj) {
    DateList = $.map(obj, function (el) {
        return {
            0: el.DATE,
            1: el.CRUISEID
          
        }
    });
}
function mapTourList(obj) {
    CruiseList = $.map(obj, function (el) {
        return {
            0: el.CRUISEID,
            1: el.CRUISENAME,
            2: el.TITLE,
            3: el.IMAGEPATH,
            4: el.LOCATION,
            5: el.DAYS,
            6: el.PRICE,
            7: el.CompanyId,
            8:el.COMPANYIMAGE
        }
    });

    cruiseDlr = $.map(obj, function (el) {
        return {
            0: el.CRUISEID,
            1: el.CRUISENAME,
            2: el.TITLE,
            3: el.IMAGEPATH,
            4: el.LOCATION,
            5: el.DAYS,
            6: el.PRICE,
            7: el.CompanyId,
            8: el.COMPANYIMAGE
        }
    });

    $.each(cruiseDlr, function (i) {
        var gp_from = "INR";
        var gp_to = "USD";
        var gp_amount = CruiseList[i][6];
         $.getJSON("http://www.geoplugin.net/currency_converter.gp?jsoncallback=?", { from: gp_from, to: gp_to, amount: gp_amount },
            function (output) {
                cruiseDlr[i][6] = Math.round(output.to.amount);
            });
    });

    $.each(CruiseList, function (i) {
        Country.push(CruiseList[i][4]);
      
    })
    Country = jQuery.unique(Country);
    
    BindDropdown();
}


function BindDropdown() {
    if (Country.length > 0) {
        strCountry = "";
        //strCountry="<option value=0>Select</option>"
        $.each(Country, function (i) {
            strCountry += "<option value=" + Country[i] + ">" + Country[i] + "</option>"
        });
        $("#ddlcountry").append(strCountry);
    }

    

}

function BindTour() {
    var strData = "";
    var date = "";
    $("#cruiseList").empty();
    $("#cruiseList").addClass('row');
    if (CruiseList.length > 0) {
        var imgno = 0;
        if (currencyFlag == 1) {
            $.each(CruiseList, function (i) {
                var filter = jQuery.grep(DateList, function (n, idx) {
                    return DateList[idx][1] == CruiseList[i][0];
                });
                if (DateList.length > 0) {
                   
                    if (filter.length > 0) {
                        date = "";
                        $.each(filter, function (e) {
                            var value = moment(filter[e][0], 'YYYY/MM/DD');
                            date += '<div class="sail-date" id=' + CruiseList[i][0] + '_' + moment(filter[e][0]).format("DD-MMM-YYYY") + '>' +
                                '<p class="date-no">' + moment(filter[e][0]).date() + '</p>' +
                                '<p class="date-month">' + moment(filter[e][0]).format('MMM') + '</p>' +
                                ' </div>';
                        });
                    }
                }
                $("#cruiseList").append( '<div class="col-sm-6 col-md-4">' +
                    '<div class="panel panel-default">' +
                    '<div class="panel-body">' +
                    '<img src="' + CruiseList[i][3] + '" class="img-responsive"></img>' +
                    '</div>' +
                    '<div class="panel-heading">' +
                    '<div class="row">' +
                    '<div class="col-xs-9 title-1">' +
                    '<h5><span class="days-cruise">' + CruiseList[i][5] + ' days</span> ' + CruiseList[i][2] + '</h5>' +
                    '</div>'+
                    '<div class="col-xs-3 title-1">' +
                    '<img src="' + CruiseList[i][8] + '" class="img-responsive client-name-box">' +
                    '</div>' +
                    '</div>' +
                    '<div class="row">' +
                    '<div class="col-sm-12">' +
                    '<div class="date-slider" id="date-slider">' +

                    date +

                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '<hr>' +
                    '<div class="row">' +
                    //'<div class="col-sm-6 title-price">' +
                    //'<h5 class="hidden">₹ ' + CruiseList[i][6] + '</h5>' +
                    //' </div>' +
                    '<div class="col-sm-12 detail-button text-center">' +
                    '<a id="View-' + CruiseList[i][0]+'" href="CruiseDetail.aspx?CruiseId=' + CruiseList[i][0] + '&Date=' + moment(filter[0][0]).format("DD-MMM-YYYY")+'" class="btn btn-danger btn-sm viewcruise" >View Details</a>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>');
                //if (i != 0) {
                //    if (i == 2) {
                //        $("#cruiseList").append("</div><div class='row sub-title'>");
                //        imgno = i + 3;
                //    }
                //    if (i == imgno) {
                //        $("#cruiseList").append("</div><div class='row sub-title'>");
                //        imgno = i + 3;
                //    }
                //}
            });
            //$("#cruiseList").append(strData);
            $("#cruiseList").append("</div>");
            $('.date-slider').not('.slick-initialized').slick({ slidesToShow: 5, slidesToScroll: 5, dots: false });
            $('.date-slider').find('[index="0"]').addClass('slick-selected');
            bindEvent();
        }
        else {
            var imgno = 0;
            $.each(cruiseDlr, function (i) {                
              // var gp_from = "INR";
              //  var gp_to = "USD";
              // var gp_amount = CruiseList[i][6];
              //var a=  $.getJSON("http://www.geoplugin.net/currency_converter.gp?jsoncallback=?", { from: gp_from, to: gp_to, amount: gp_amount },
              //     function (output) {
              //          cruiseDlr[i][6] = Math.round(output.to.amount);
                if (DateList.length > 0) {
                    var filter = [];
                             filter = jQuery.grep(DateList, function (n, idx) {
                                return DateList[idx][1] == cruiseDlr[i][0];
                            });
                             if (filter.length > 0) {
                                 date = "";
                                $.each(filter, function (e) {
                                    var value = moment(filter[e][0], 'YYYY/MM/DD');
                                    date += '<div class="sail-date" id=' + cruiseDlr[i][0] + '_' + moment(filter[e][0]).format("DD-MMM-YYYY") + '>' +
                                        '<p class="date-no">' + moment(filter[e][0]).date() + '</p>' +
                                        '<p class="date-month">' + moment(filter[e][0]).format('MMM') + '</p>' +
                                        ' </div>';
                                });
                            }
                        }
               
                $("#cruiseList").append('<div class="col-sm-6 col-md-4">' +
                            '<div class="panel panel-default">' +
                            '<div class="panel-body">' +
                            '<img src="' + cruiseDlr[i][3] + '" class="img-responsive"></img>' +
                            '</div>' +
                            '<div class="panel-heading">' +
                            '<div class="row">' +
                            '<div class="col-xs-9 title-1">' +
                            '<h5><span class="days-cruise">' + cruiseDlr[i][5] + ' days</span> ' + cruiseDlr[i][2] + '</h5>' +
                            '</div>' +
                            '<div class="col-xs-3 title-1">' +
                            '<img src="' + cruiseDlr[i][8] + '" class="img-responsive client-name-box">' +
                            '</div>' +
                            '</div>' +
                            '<div class="row">' +
                            '<div class="col-sm-12">' +
                            '<div class="date-slider" id="date-slider">' +

                            date +

                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '<hr>' +
                            '<div class="row">' +
                            //'<div class="col-sm-6 title-price">' +
                            //'<h5 class="hidden">$ ' + cruiseDlr[i][6] + '</h5>' +
                            //' </div>' +
                            '<div class="col-sm-12 detail-button text-center">' +
                            '<a id="View-' + cruiseDlr[i][0]  + '" href="CruiseDetail.aspx?CruiseId=' + cruiseDlr[i][0] + '&Date=' + moment(filter[0][0]).format("DD-MMM-YYYY") +'" href="#" class="btn btn-danger btn-sm viewcruise" >View Details</a>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                          '</div>');
                        //if (i != 0) {
                        //    if (i == 2) {
                        //        $("#cruiseList").append("</div><div class='row sub-title'>");
                        //        imgno = i + 3;
                        //    }
                        //    if (i == imgno) {
                        //        $("#cruiseList").append("</div><div class='row sub-title'>");
                        //        imgno = i + 3;
                        //    }
                        //}
                        //$("#cruiseList").append(strData);
                        $("#cruiseList").append("</div>");
                        $('.date-slider').not('.slick-initialized').slick({ slidesToShow: 5, slidesToScroll: 5, dots: false });
                        $('.date-slider').find('[index="0"]').addClass('slick-selected');
                        bindEvent();
                   //});
            });
        }
        
        
       
    }
}

function bindFilterTour(filter,icon) {
    var strData = "";
    var strDate = "";
    $("#cruiseList").empty();
    $("#cruiseList").addClass('row');
    if (filter.length > 0) {
        
            var imgno = 0;
            $.each(filter, function (i) {

                if (DateList.length > 0) {
                    var date = jQuery.grep(DateList, function (n, idx) {
                        return DateList[idx][1] == filter[i][0];
                    });

                    if (date.length > 0) {
                        strDate = "";
                        $.each(date, function (e) {
                            var value = moment(date[e][0], 'YYYY/MM/DD');
                            strDate += '<div class="sail-date" id=' + filter[i][0] + '_' + moment(date[e][0]).format("DD-MMM-YYYY") + '>' +
                                '<p class="date-no">' + moment(date[e][0]).date() + '</p>' +
                                '<p class="date-month">' + moment(date[e][0]).format('MMM') + '</p>' +
                                ' </div>';
                        });
                    }
                    }
                $("#cruiseList").append('<div class="col-sm-6 col-md-4">' +
                    '<div class="panel panel-default">' +
                    '<div class="panel-body">' +
                    '<img src="' + filter[i][3] + '" class="img-responsive"></img>' +
                    '</div>' +
                    '<div class="panel-heading">' +
                    '<div class="row">' +
                    '<div class="col-xs-9 title-1">' +
                    '<h5><span class="days-cruise">' + filter[i][5] + ' days</span> ' + filter[i][2] + '</h5>' +
                    '</div>' +
                    '<div class="col-xs-3 title-1">' +
                    '<img src="' + filter[i][8] + '" class="img-responsive client-name-box">' +
                    '</div>' +
                    '</div>' +
                    '<div class="row">' +
                    '<div class="col-sm-12">' +
                    '<div class="date-slider" id="date-slider">' +

                    strDate +

                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '<hr>' +
                    '<div class="row">' +
                    //'<div class="col-sm-6 title-price">' +
                    //'<h5 class="hidden">' + icon + filter[i][6] + '</h5>' +
                    //' </div>' +
                    '<div class="col-sm-12 detail-button text-center">' +
                    '<a id="View-' + filter[i][0] + '" href="CruiseDetail.aspx?CruiseId=' + filter[i][0] + '&Date=' + moment(date[0][0]).format("DD-MMM-YYYY") + '" class="btn btn-danger btn-sm viewcruise" >View Details</a>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>');
                //if (i != 0) {
                //    if (i == 2) {
                //        $("#cruiseList").append("</div><div class='row sub-title'>");
                //        imgno = i + 3;
                //    }
                //    if (i == imgno) {
                //        $("#cruiseList").append("</div><div class='row sub-title'>");
                //        imgno = i + 3;
                //    }
                //}
            });
            //$("#cruiseList").append(strData);
            $("#cruiseList").append("</div>");
            $('.date-slider').not('.slick-initialized').slick({ slidesToShow: 5, slidesToScroll: 5, dots: false });
            $('.date-slider').find('[index="0"]').addClass('slick-selected');
            bindEvent();

        }
        else {
            $("#cruiseList").append("<h1 align='center'>No Cruise Deal Found</h1>");
        }
}


function bindEvent() {
    $('.sail-date').on('click', function () {
        var data = ($(this).attr("id")).split("_");
        cruiseId = data[0];
        datestring = data[1];
        $("View-" + data[0]).attr
        $("#View-" + data[0]).attr('href', 'CruiseDetail.aspx?CruiseId=' + data[0] + '&Date=' + data[1] + '');

    });
    //$('.viewcruise').on('click', function () {
    //    window.location.href = "CruiseDetail.aspx?CruiseId=" + cruiseId + "&Date=" + datestring;
    //});
}