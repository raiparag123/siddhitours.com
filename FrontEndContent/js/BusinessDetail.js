var BusinessDetail = [];
var OtherBusiness = [];
var url = "BusinessTourDetail.aspx";
var OtherTour = [];
var currencyFlag = "1";
var DollarOther = [];

var Tourarray = [];
$(document).ready(function (e) {
    $("#nav").removeClass(".affix-top");
    $("#nav").removeAttr("data-spy");
    var id = GetParameterValues("BusinessId");
    currencyFlag = $("#currValue").val();
    getDetail(id);
    if (currencyFlag == 1) {
        $("input[name='currency'][value=INR]").attr('checked', 'checked');
    }
    else {
        $("input[name='currency'][value=DOLLAR]").attr('checked', 'checked');
    }
    $("input[name='currency']").change(function () {
        var value = $("input[name='currency']:checked").val();
        var sendValue = ""
        if (value == 'INR') {
            sendValue = 1;
            currencyFlag = 1;
        }
        else {
            sendValue = 0;
            currencyFlag = 0;
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
        BindTour();
        bindOtherTour();
    });
});

function GetParameterValues(param) {
    var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for (var i = 0; i < url.length; i++) {
        var urlparam = url[i].split('=');
        if (urlparam[0] == param) {
            return urlparam[1];
        }
    }
}  


function getDetail(id) {

    $.ajax({
        type: "POST",
        url: url + "/getTourDetail",
        contentType: "application/json; charset=utf-8",
       
        dataType: "json",
       
        data: JSON.stringify({ businessId: id }),
        success: function (msg) {
            if (msg.d != "") {
                var Obj = msg.d.split("~");
                
                var jsonObj = JSON.parse(Obj[0]);
                var jsonObj1 = JSON.parse(Obj[1]);
                if (jsonObj.length > 0) {
                    mapTourList(jsonObj);
                    BindTour();
                }
                else {

                }

                if (jsonObj1.length > 0) {
                    mapOtherTour(jsonObj1);
                    bindOtherTour();
                }
                else {

                }
                
                
                


            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });

}

function mapTourList(obj) {
    BusinessList = $.map(obj, function (el) {
        return {
            0: el.BUSINESSID,
            1: el.TITLE,
            2: el.COST,
            3: el.IMAGEPATH,
            4: el.COUNTRY,
            5: el.STATE,
            6: el.CITY,
            7: el.INCLUSION
           


        }
    });

    Tourarray = $.map(obj, function (el) {
        return {
            0: el.BUSINESSID,
            1: el.TITLE,
            2: el.COST,
            3: el.IMAGEPATH,
            4: el.COUNTRY,
            5: el.STATE,
            6: el.CITY,
            7: el.INCLUSION



        }
    });

  
}

function mapOtherTour(obj) {
    OtherTour = $.map(obj, function (el) {
        return {
            0: el.BUSINESSID,
            1: el.TITLE,
            2: el.COST,
            3: el.IMAGEPATH


        }
    });

    DollarOther = $.map(obj, function (el) {
        return {
            0: el.BUSINESSID,
            1: el.TITLE,
            2: el.COST,
            3: el.IMAGEPATH


        }
    });

}

function BindTour() {
    if (currencyFlag == 1) {
        $("#cost").text("₹" + BusinessList[0][2]);
    }
    else {
        var gp_from = "INR";
        var gp_to = "USD";
        var gp_amount = BusinessList[0][2];
        $.getJSON("http://www.geoplugin.net/currency_converter.gp?jsoncallback=?", { from: gp_from, to: gp_to, amount: gp_amount },
            function (output) {
                Tourarray[0][2] = output.to.amount;
                $("#cost").text("$" + Tourarray[0][2]);
            });
            
    }
        $("#title").text(BusinessList[0][1]);
        
        $("#Detail").html(BusinessList[0][7]);
        strData = "";
        strTotalSlide = "";
        $(".carousel-indicators").empty();
        $("#businessImages").empty();
        $.each(BusinessList, function (i) {
            strData += '<div class="item">' +
                '<img src=' + BusinessList[i][3] + ' alt= "..." >' +

                '</div >';

            strTotalSlide += '<li data-target="#carousel-example-generic" data-slide-to=' + i + '></li>';

        });
        $("#indicators").append(strTotalSlide);
        $("#businessImages").append(strData);


        $('.item').first().addClass('active');
        $('.carousel-indicators > li').first().addClass('active');
        // $("#myCarousel").carousel();
        $('#carousel-example-generic').carousel();

    
}

function bindOtherTour() {
    if (currencyFlag == 1) {
        strOther = "";
        $.each(OtherTour, function (i) {


            strOther += '<div class="item">' +
                '<div class="panel panel-default" >' +
                '<div class="panel-body">' +
                '<img src=' + OtherTour[i][3] + ' class="img-responsive">' +
                '</div>' +
                '<div class="panel-heading text-center">' +
                '<div class="row">' +
                '<div class="col-sm-6 title-1">' +
                '<h4>' + OtherTour[i][1] + '</h4>' +
                '</div>' +
                '<div class="col-sm-6 title-price">' +
                '<h4 class="rupee-font">₹' + OtherTour[i][2] + '</h4>' +
                '</div>' +
                '</div>' +
                '<div class="row">' +
                '<div class="col-sm-12 detail-button">' +
                '<a href=BusinessTourDetail.aspx?BusinessId=' + OtherTour[i][0] + '  class="btn btn-danger btn-sm" >View Details</a>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div >'
        });

        var carousel = $("#otherTour");
        carousel.trigger('destroy.owl.carousel');
        carousel.find('.owl-stage-outer').children().unwrap();
        carousel.removeClass("owl-center owl-loaded owl-text-select-on");

        carousel.html(strOther);

        //reinitialize the carousel (call here your method in which you've set specific carousel properties)


        carousel.owlCarousel({
            center: true,
            loop: true,
            margin: 10,
            responsive: {
                0: {
                    items: 1
                }
            }
        });
        $('.next').click(function () {
            owl.trigger('next.owl.carousel');
        })
        $('.prev').click(function () {
            owl.trigger('prev.owl.carousel');
        })
    }
    else {

        strOther = "";
        $.each(DollarOther, function (i) {

            var gp_from = "INR";
            var gp_to = "USD";
            var gp_amount = OtherTour[i][2];
            $.getJSON("http://www.geoplugin.net/currency_converter.gp?jsoncallback=?", { from: gp_from, to: gp_to, amount: gp_amount },
                function (output) {
                    DollarOther[i][2] = output.to.amount;
                   


                    strOther += '<div class="item">' +
                        '<div class="panel panel-default" >' +
                        '<div class="panel-body">' +
                        '<img src=' + DollarOther[i][3] + ' class="img-responsive">' +
                        '</div>' +
                        '<div class="panel-heading text-center">' +
                        '<div class="row">' +
                        '<div class="col-sm-6 title-1">' +
                        '<h4>' + DollarOther[i][1] + '</h4>' +
                        '</div>' +
                        '<div class="col-sm-6 title-price">' +
                        '<h4 class="rupee-font">$' + DollarOther[i][2] + '</h4>' +
                        '</div>' +
                        '</div>' +
                        '<div class="row">' +
                        '<div class="col-sm-12 detail-button">' +
                        '<a href=BusinessTourDetail.aspx?BusinessId=' + DollarOther[i][0] + '  class="btn btn-danger btn-sm" >View Details</a>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div >';

                    var carousel = $("#otherTour");
                    carousel.trigger('destroy.owl.carousel');
                    carousel.find('.owl-stage-outer').children().unwrap();
                    carousel.removeClass("owl-center owl-loaded owl-text-select-on");

                    carousel.html(strOther);

                    //reinitialize the carousel (call here your method in which you've set specific carousel properties)


                    carousel.owlCarousel({
                        center: true,
                        loop: true,
                        margin: 10,
                        responsive: {
                            0: {
                                items: 1
                            }
                        }
                    });
                    $('.next').click(function () {
                        owl.trigger('next.owl.carousel');
                    })
                    $('.prev').click(function () {
                        owl.trigger('prev.owl.carousel');
                    })
                });

        });
        //var carousel = $("#otherTour");
        //carousel.trigger('destroy.owl.carousel');
        //carousel.find('.owl-stage-outer').children().unwrap();
        //carousel.removeClass("owl-center owl-loaded owl-text-select-on");

        //carousel.html(strOthers);

        ////reinitialize the carousel (call here your method in which you've set specific carousel properties)


        //carousel.owlCarousel({
        //    center: true,
        //    loop: true,
        //    margin: 10,
        //    responsive: {
        //        0: {
        //            items: 1
        //        }
        //    }
        //});
        //$('.next').click(function () {
        //    owl.trigger('next.owl.carousel');
        //})
        //$('.prev').click(function () {
        //    owl.trigger('prev.owl.carousel');
        //})


    }

    
}