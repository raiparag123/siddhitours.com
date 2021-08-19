var TripList = [];
var Country = [];
var City = [];
var url = "Trip.aspx";
var flag = 0;
var filter = [];
var currencyFlag = "1";
var categoryId = "";
var Tourarray = [];
var country = "";
$(document).ready(function (e) {
    $("#nav").removeClass(".affix-top");
    $("#nav").removeAttr("data-spy");
    categoryId = GetParameterValues("CategoryId");
    package = GetParameterValues("Package");
    Title = GetParameterValues("Title");
    Search = GetParameterValues("Search");
    currencyFlag = $("#currValue").val();
    if (currencyFlag == 1) {
        $("input[name='currency'][value=INR]").attr('checked', 'checked');
    }
    else {
        $("input[name='currency'][value=DOLLAR]").attr('checked', 'checked');
    }
    $("input[name='currency']:checked").val();


    $("input[name='currency").change(function (e) {
        //$('#form').bootstrapValidator('validate');
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
    });




    if (categoryId != undefined) {
        getTourList(categoryId);
    }
    else if (package != undefined) {
        if (currencyFlag == 1) {
            getTourListPackageWise(package);
        }
        else {
            var gp_from = "USD";
            var gp_to = "INR";
            var gp_amount = package.replace(",","");
            $.getJSON("http://www.geoplugin.net/currency_converter.gp?jsoncallback=?", { from: gp_from, to: gp_to, amount: gp_amount },
                function (output) {
                    var value = output.to.amount.replace(",", "");
                    getTourListPackageWise(Math.round(value));
                });
        }
    }
    else if (Title != undefined) {
        getTourListTitleWise(Title.replace("$", " "));
    }
    else if (Search != undefined) {
        getTourListSearchWise(Search);
    }
    else {
        getTourWihtoutCase();
    }
    

    $("#ddlcountry").change(function (e) {
        flag = 1;
        var value = $("#ddlcountry option:selected").val();
        //var cityValue = $("#ddlCity option:selected").val();
        var icon = "";
        country = value;


        if (value == "0") { //&& cityValue == "0"

            if (currencyFlag == 1) {
                filter = TripList
                icon = "₹";
                bindFilterTour(filter, icon);
            }
            else {
                filter = Tourarray;
                icon = "$";
                bindFilterTour(filter, icon);
            }
        }
        else {
            if (currencyFlag == 1) {
                filter = jQuery.grep(TripList, function (n, idx) {
                    if (value == "0") {
                        return TripList[idx][4];
                    }
                    else {
                        return TripList[idx][4] == value;
                    }
                });
                icon = "₹";
                bindFilterTour(filter, icon);
               
            }
            else {
                filter = jQuery.grep(Tourarray, function (n, idx)
                {
                    if (value == "0") {
                        return Tourarray[idx][4];
                    }
                    else {
                        return Tourarray[idx][4] == value;
                    }
                });
                icon = "$";
            }
            bindFilterTour(filter,icon);
        }
        BindStateDropDown();       
    });


    $("#ddlCity").change(function (e) {
        flag = 1;
        var value = $("#ddlCity option:selected").val();
        var countryValue = $("#ddlcountry option:selected").val();
        var icon = "";
       
        if (value == "0" && countryValue == "0") {
            
            if (currencyFlag == 1) {
                filter = TripList
                icon = "₹";
                bindFilterTour(filter, icon);
            }
            else {
                filter = Tourarray;
                icon = "$";
                bindFilterTour(filter, icon);
            }
        }
        else if(value != "0") {
            if (currencyFlag == 1) {
                filter = jQuery.grep(TripList, function (n, idx) {
                    return TripList[idx][5] == value;
                });
                icon = "₹";
                bindFilterTour(filter,icon);
            }
            else {
                filter = jQuery.grep(Tourarray, function (n, idx) {
                    return Tourarray[idx][5] == value;
                });
                icon = "$";
                bindFilterTour(filter, icon);
            }
        }

    });


    $("#popular").click(function (e) {
        e.preventDefault();
        if (currencyFlag == 1) {

            icon = "₹";

        }
        else {

            icon = "$";

        }
        if (flag == 1) {
            filter.sort(function (a, b) {
                var a1 = a[0], b1 = b[0];
                if (a1 == b1) return 0;
                return a1 < b1 ? 1 : -1;
            });
            bindFilterTour(filter,icon);
        }
        else {
            if (currencyFlag == 1) {
                TripList.sort(function (a, b) {
                    var a1 = a[0], b1 = b[0];
                    if (a1 == b1) return 0;
                    return a1 < b1 ? 1 : -1;
                });
                bindFilterTour(TripList, icon);
            }
            else {
                Tourarray.sort(function (a, b) {
                    var a1 = a[0], b1 = b[0];
                    if (a1 == b1) return 0;
                    return a1 < b1 ? 1 : -1;
                });
                bindFilterTour(Tourarray, icon);
            }


        }
    });

    $("#high").click(function (e) {
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
                var a1 = Math.round(a[8].replace(",", "")), b1 = Math.round(b[8].replace(",", ""));
                if (a1 == b1) return 0;
                return a1 < b1 ? 1 : -1;
            });
            bindFilterTour(filter,icon);
        }
        else {
            if (currencyFlag == 1) {
                TripList.sort(function (a, b) {
                    var a1 = Math.round(a[8].replace(",", "")), b1 = Math.round(b[8].replace(",", ""));
                    if (a1 == b1) return 0;
                    return a1 < b1 ? 1 : -1;
                });
                bindFilterTour(TripList,icon);
            }
            else {
                Tourarray.sort(function (a, b) {
                    var a1 = Math.round(a[8].replace(",", "")), b1 = Math.round(b[8].replace(",", ""));
                    if (a1 == b1) return 0;
                    return a1 < b1 ? 1 : -1;
                });
                bindFilterTour(Tourarray,icon);
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
                var a1 = Math.round(a[8].replace(",", "")), b1 = Math.round(b[8].replace(",", ""));
                if (a1 == b1) return 0;
                return a1 > b1 ? 1 : -1;
            });
            bindFilterTour(filter, icon);
        }
        else {
            if (currencyFlag == 1) {
                TripList.sort(function (a, b) {
                    var a1 = Math.round(a[8].replace(",", "")), b1 = Math.round(b[8].replace(",", ""));
                    if (a1 == b1) return 0;
                    return a1 > b1 ? 1 : -1;
                });
                bindFilterTour(TripList, icon);
            }
            else {
                Tourarray.sort(function (a, b) {
                    var a1 = Math.round(a[8].replace(",", "")), b1 = Math.round(b[8].replace(",", ""));
                    if (a1 == b1) return 0;
                    return a1 > b1 ? 1 : -1;
                });
                bindFilterTour(Tourarray, icon);
            }
        }

    });
    
    getStateList();

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


function getTourList(categoryId) {
    $.ajax({
        type: "POST",
        url: url + "/getTourList",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ Category: categoryId }),
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
                mapTourList(jsonObj);
                BindTour();
                $("#tripfound").show();
                $("#no-trip").hide();

            }
            else {
                $("#tripfound").hide();
                $("#no-trip").show();
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function getTourListPackageWise(package) {
    $.ajax({
        type: "POST",
        url: url + "/getTourListPackagewise",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ Package: package }),
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
                mapTourList(jsonObj);
                BindTour();
                $("#tripfound").show();
                $("#no-trip").hide();

            }
            else {
                $("#tripfound").hide();
                $("#no-trip").show();
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}


function getTourListTitleWise(title) {
    $.ajax({
        type: "POST",
        url: url + "/getTourListTitlewise",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ Title: title }),
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
                mapTourList(jsonObj);
                BindTour();
                $("#tripfound").show();
                $("#no-trip").hide();

            }
            else {
                $("#tripfound").hide();
                $("#no-trip").show();
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function getTourListSearchWise(search) {
    $.ajax({
        type: "POST",
        url: url + "/getTourListSearchwise",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({
            Search: search
        }),
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
                mapTourList(jsonObj);
                BindTour();
                $("#tripfound").show();
                $("#no-trip").hide();

            }
            else {
                $("#tripfound").hide();
                $("#no-trip").show();
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function getTourWihtoutCase() {
    $.ajax({
        type: "POST",
        url: url + "/getTourWithoutCase",
        contentType: "application/json; charset=utf-8",
       
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
                mapTourList(jsonObj);
                BindTour();
                $("#tripfound").show();
                $("#no-trip").hide();

            }
            else {
                $("#tripfound").hide();
                $("#no-trip").show();
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}


function mapTourList(obj) {
    TripList = $.map(obj, function (el) {
        return {
            0: el.TRIPID,
            1: el.TRIPTITLE,
            2: el.TRIPTHEME,
            3: el.TRIPDAYS,
            4: el.COUNTRY,
            5: el.STATE,
            6: el.CITY,
            7: el.TRIPLOCATION,
            8: el.TRIPCOST,
            9: el.IMAGEPATH




        }
    });

    Tourarray = $.map(obj, function (el) {
        return {
            0: el.TRIPID,
            1: el.TRIPTITLE,
            2: el.TRIPTHEME,
            3: el.TRIPDAYS,
            4: el.COUNTRY,
            5: el.STATE,
            6: el.CITY,
            7: el.TRIPLOCATION,
            8: el.TRIPCOST,
            9: el.IMAGEPATH




        }
    });

    $.each(TripList, function (i) {
        Country.push(TripList[i][4]);
       // State.push(BusinessList[i][5]);
        //City.push(TripList[i][5]);
    })
    Country = jQuery.unique(Country);
   
    //City = jQuery.unique(City);
    BindDropdown();
}

function BindDropdown() {
    if (Country.length > 0) {
        strCountry = "";
        //strCountry="<option value=0>Select</option>"
        $.each(Country, function (i) {
            if (Country[i] != 0) {
                strCountry += "<option value=" + Country[i] + ">" + Country[i] + "</option>"
            }
        });
        $("#ddlcountry").append(strCountry);
    }

    //if (State.length > 0) {
    //    strState = "";
    //    //strCountry="<option value=0>Select</option>"
    //    $.each(State, function (i) {
    //        strState += "<option value=" + State[i] + ">" + State[i] + "</option>"
    //    });
    //    $("#ddlState").append(strState);
    //}

    //if (City.length > 0) {
    //    strCity = "";
    //    //strCountry="<option value=0>Select</option>"
    //    $.each(City, function (i) {
    //        if (City[i] != "0") {
    //            strCity += "<option value=" + City[i] + ">" + City[i] + "</option>"
    //        }
    //    });
    //    $("#ddlCity").append(strCity);
    //}

}

function BindTour() {
    var from = "";
    var to = "";
    if (currencyFlag == 1) {
   
        if (TripList.length > 0) {
            $("#tripList").empty();
            var strdata = "";
            $("#tripList").addClass("row");
            $.each(TripList, function (i) {
                var theme = TripList[i][2].split(',');
                var location = TripList[i][7].split(',');
                var themestyle = "";
                var LocString = "";
                var Location = "";


                var night = parseInt(TripList[i][3]) - 1;
                $.each(theme, function (e) {
                    themestyle += '<a href="#" class="btn btn-primary btn-xs">' + theme[e] + '</a>   ';
                });
                if (TripList[i][4] != 0) {
                    LocString += TripList[i][4];
                }

                if (TripList[i][5] != 0) {
                    LocString += ' <i class="fa fa-arrow-right"></i>' + TripList[i][5];
                }

                if (TripList[i][6] != 0) {
                    LocString += ' <i class="fa fa-arrow-right"></i>' + TripList[i][6];
                }

                //$.each(location, function (a) {
                Location += '<a href="#" class="btn btn-defaut btn-sm">' + LocString + '</a> ';
                // });


                strdata += '<div class="col-sm-12 tour-packages">' +
                    '<div class="panel panel-default">' +
                    '<div class="panel-body">' +
                    '<div class="row">' +
                    '<div class="col-sm-3 first-sec">' +
                    '<img src=' + TripList[i][9] + ' class="img-responsive">' +
                    '</div>' +
                    '<div class="col-sm-6 mid-sec">' +
                    '<h4>' + TripList[i][1] + '</h4>' +
                    '<span class="duration-info">' + night + ' Nights /' + TripList[i][3] + ' Days</span>' +
                    '<h4>' + themestyle + '</h4>' +
                    '<h4>' + Location + '</h4>' +
                    '</div>' +
                    '<div class="col-sm-3 text-center last-sec">' +

                    '<h4 class="tour-main-price rupee-font">₹' + TripList[i][8] + '</h4>' +
                    '<a href="TripDetail.aspx?Tripid=' + TripList[i][0] + '" class="btn btn-danger"> View Details</a>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +

                    '</div>';
            });
            $("#tripList").append(strdata);
        }
    }
    else {
        $("#tripList").empty();
        //Tourarray = TripList;
        $.each(Tourarray, function (i) {


            var gp_from = "INR";
            var gp_to = "USD";
            var gp_amount = TripList[i][8];
            $.getJSON("http://www.geoplugin.net/currency_converter.gp?jsoncallback=?", { from: gp_from, to: gp_to, amount: gp_amount },
                function (output) {
                    Tourarray[i][8] = output.to.amount;
                    var theme = Tourarray[i][2].split(',');
                    var location = Tourarray[i][7].split(',');
                    var themestyle = "";
                    var LocString = "";
                    var Location = "";
                    var night = parseInt(Tourarray[i][3]) - 1;

                    $.each(theme, function (e) {
                        themestyle += '<a href="#" class="btn btn-primary btn-xs">' + theme[e] + '</a>   ';
                    });
                    if (Tourarray[i][4] != 0) {
                        LocString += Tourarray[i][4];
                    }

                    if (TripList[i][5] != 0) {
                        LocString += ' <i class="fa fa-arrow-right"></i>' + Tourarray[i][5];
                    }

                    if (TripList[i][6] != 0) {
                        LocString += ' <i class="fa fa-arrow-right"></i>' + Tourarray[i][6];
                    }

                    //$.each(location, function (a) {
                    Location += '<a href="#" class="btn btn-defaut btn-sm">' + LocString + '</a> ';
                    // });


                    $("#tripList").append( '<div class="col-sm-12 tour-packages">' +
                        '<div class="panel panel-default">' +
                        '<div class="panel-body">' +
                        '<div class="row">' +
                        '<div class="col-sm-3 first-sec">' +
                        '<img src=' + Tourarray[i][9] + ' class="img-responsive">' +
                        '</div>' +
                        '<div class="col-sm-6 mid-sec">' +
                        '<h4>' + Tourarray[i][1] + '</h4>' +
                        '<span class="duration-info">' + night + ' Nights /' + Tourarray[i][3] + ' Days</span>' +
                        '<h4>' + themestyle + '</h4>' +
                        '<h4>' + Location + '</h4>' +
                        '</div>' +
                        '<div class="col-sm-3 text-center last-sec">' +

                        '<h4 class="tour-main-price rupee-font">$' + Tourarray[i][8] + '</h4>' +
                        '<a href="TripDetail.aspx?Tripid=' + Tourarray[i][0] + '" class="btn btn-danger"> View Details</a>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +

                        '</div>');
                });

            
        });
    }
}


function bindFilterTour(filterarr,icon) {
    $("#tripList").empty();
    if (filterarr.length > 0) {
        var strdata = "";
        $("#tripList").addClass("row");
        $.each(filterarr, function (i) {
            var theme = filterarr[i][2].split(',');
            var location = filterarr[i][7].split(',');
            var themestyle = "";
            var LocString = "";
            var Location = "";


            var night = parseInt(filterarr[i][3]) - 1;
            $.each(theme, function (e) {
                themestyle += '<a href="#" class="btn btn-primary btn-xs">' + theme[e] + '</a>   ';
            });
            if (filterarr[i][4] != 0) {
                LocString += filterarr[i][4];
            }

            if (filterarr[i][5] != 0) {
                LocString += ' <i class="fa fa-arrow-right"></i>' + filterarr[i][5];
            }

            if (filterarr[i][6] != 0) {
                LocString += ' <i class="fa fa-arrow-right"></i>' + filterarr[i][6];
            }

            //$.each(location, function (a) {
            Location += '<a href="#" class="btn btn-defaut btn-sm">' + LocString + '</a> ';
            // });


            strdata += '<div class="col-sm-12 tour-packages">' +
                '<div class="panel panel-default">' +
                '<div class="panel-body">' +
                '<div class="row">' +
                '<div class="col-sm-3 mid-sec">' +
                '<img src=' + filterarr[i][9] + ' class="img-responsive">' +
                '</div>' +
                '<div class="col-sm-6 mid-sec">' +
                '<h4>' + filterarr[i][1] + '</h4>' +
                '<span class="duration-info">' + night + ' Nights /' + filterarr[i][3] + ' Days</span>' +
                '<h4>' + themestyle + '</h4>' +
                '<h4>' + Location + '</h4>' +
                '</div>' +
                '<div class="col-sm-3 text-center last-sec">' +

                '<h4 class="tour-main-price rupee-font">'+icon + filterarr[i][8] + '</h4>' +
                '<a href="TripDetail.aspx?Tripid=' + filterarr[i][0] + '" class="btn btn-danger"> View Details</a>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>' +

                '</div>';
        });
        $("#tripList").append(strdata);
    } else {
        $("#tripList").append("<h1>No Data Found</h1>");
        $("#tripList").append("</div>");
    }
}

function getStateList() {
    $.ajax({
        type: "POST",
        url: url + "/getStateList",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                mapStateList(jsonobj);
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function mapStateList(jsonobj) {
    City = $.map(jsonobj, function (el) {
        return {
            0: el.STATEID,
            1: el.STATENAME,
            2: el.COUNTRYNAME
        }
    });
}

function BindStateDropDown() {
    var appendvalue = "";
    $("#ddlCity").empty();
    for (var i = 0; i <= City.length - 1; i++) {
        if (country == City[i][2]) {
            appendvalue += "<option value=" + City[i][1].replace(" ", "_") + ">" + City[i][1] + "</option>";
        }
    }
    $("#ddlCity").append("<option value=0>Select</option>");
    $("#ddlCity").append(appendvalue);
    //$("#ddlCity").selectpicker('refresh');
}