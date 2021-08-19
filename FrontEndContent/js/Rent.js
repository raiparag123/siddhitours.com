var url = "Rent.aspx";
var RentList = [];
var locationList = [];
var vehicle = [];
var rentid = "";
var filter = [];
var flag = "";
var currencyFlag = "1";

var RentDlr = [];
$(document).ready(function () {

    $("#nav").removeClass(".affix-top");
    $("#nav").removeAttr("data-spy");
    getRentList();
    getPlaceList();
    getVehicleList();
    currencyFlag = $("#currValue").val();
    if (currencyFlag == 1) {
        $("input[name='currency'][value=INR]").attr('checked', 'checked');
    }
    else {
        $("input[name='currency'][value=DOLLAR]").attr('checked', 'checked');
    }

    $(document).on("click", ".rentmsg", function (e) {
        e.preventDefault();
        var id = $(this).attr("id").split("_");
        rentid = id[1];
        var info = jQuery.grep(RentList, function (n, idx) {
            return RentList[idx][0] == rentid;
        });
        if (id[0] == "View") {
            $("#myModalLabel").text(info[0][3])
            $("#desc").modal("show");
            $("#description").html(info[0][6]);
            $("#Term").html(info[0][7]);
        }
        else {
            $("#div-email").show();
            $("#success").hide();
            $("#myModal1").modal("show");
            $("#vehicle option[value=" + info[0][2] + "]").attr("selected", "selected");
        }
    });

    $("#selectCountry").change(function (e) {
        e.preventDefault();
        var countryid = $("#selectCountry option:selected").val();
        var Vehicle = $("#selectVehicle option:selected").val();
        bindFilter(countryid, Vehicle);
    });

    $("#selectVehicle").change(function (e) {
        e.preventDefault();
        var countryid = $("#selectCountry option:selected").val();
        var Vehicle = $("#selectVehicle option:selected").val();
        bindFilter(countryid, Vehicle);
    });

    $("#btnSubmit").click(function (e) {
        e.preventDefault();
        SendMail();
    });

    $("#popular").click(function (e) {

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
                    var a1 = a[0], b1 = b[0];
                    if (a1 == b1) return 0;
                    return a1 < b1 ? 1 : -1;
                });
                BindRentTour(filter,icon);
        }
        else {
            if (currencyFlag == 1) {

                RentList.sort(function (a, b) {
                    var a1 = a[0], b1 = b[0];
                    if (a1 == b1) return 0;
                    return a1 < b1 ? 1 : -1;
                });
                BindRentTour(RentList, icon);
            }
            else {
                RentDlr.sort(function (a, b) {
                    var a1 = a[0], b1 = b[0];
                    if (a1 == b1) return 0;
                    return a1 < b1 ? 1 : -1;
                });
                BindRentTour(RentDlr, icon);
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
               // var a1 = a[5], b1 = b[5];
                var a1 = a[5].toFixed(0), b1 = b[5].toFixed(0);
                if (a1 == b1) return 0;
                return a1 < b1 ? 1 : -1;
            });
            BindRentTour(filter,icon);
        }
        else {
            if (currencyFlag == 1) {
                RentList.sort(function (a, b) {
                    //var a1 = a[5], b1 = b[5];
                    var a1 = a[5].toFixed(0), b1 = b[5].toFixed(0);
                    if (a1 == b1) return 0;
                    return a1 > b1 ? 1 : -1;
                });
                BindRentTour(RentList,icon);
            }
            else {
                RentDlr.sort(function (a, b) {
                    var a1 = a[5].toFixed(0), b1 = b[5].toFixed(0);
                   // var a1 = a[5], b1 = b[5];
                    if (a1 == b1) return 0;
                    return a1 > b1 ? 1 : -1;
                });
                BindRentTour(RentDlr,icon);
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
                var a1 = a[5], b1 = b[5];
                if (a1 == b1) return 0;
                return a1 < b1 ? 1 : -1;
            });
            BindRentTour(filter,icon);
        }
        else {
            if (currencyFlag == 1) {
                RentList.sort(function (a, b) {
                    //var a1 = a[5], b1 = b[5];
                    var a1 = a[5].toFixed(0), b1 = b[5].toFixed(0);
                    if (a1 == b1) return 0;
                    return a1 < b1 ? 1 : -1;
                });
                BindRentTour(RentList,icon);
            }
            else {
                RentDlr.sort(function (a, b) {
                    var a1 = a[5].toFixed(0), b1 = b[5].toFixed(0);
                    // var a1 = a[5], b1 = b[5];
                    if (a1 == b1) return 0;
                    return a1 < b1 ? 1 : -1;
                });
                BindRentTour(RentDlr,icon);
            }
        }
    });

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
        BindRent();
    });

});


function bindFilter(countryid, Vehicle) {
    var icon = "";
    if (currencyFlag == 1) {
        icon = "₹";
    }
    else {
        icon = "$";
    }
    if (countryid == 0 && Vehicle == 0) {
        if (currencyFlag == 1) {
            filter = RentList;
        }
        else {
            filter = RentDlr;
        }
        
        flag = 1;

    }
    else {
        if (Vehicle == 0) {
            flag = 1;
            if (currencyFlag == 1) {
                filter = jQuery.grep(RentList, function (n, idx) {
                    return RentList[idx][1] == countryid;
                });
            }
            else {
                filter = jQuery.grep(RentDlr, function (n, idx) {
                    return RentDlr[idx][1] == countryid;
                });
            }
            
        }

        if (countryid == 0) {
            if (currencyFlag == 1) {
                flag = 1;
                filter = jQuery.grep(RentList, function (n, idx) {
                    return RentList[idx][2] == Vehicle;
                });
            }
            else {
                flag = 1;
                filter = jQuery.grep(RentDlr, function (n, idx) {
                    return RentDlr[idx][2] == Vehicle;
                });
            }
        }

        if (countryid != 0 && Vehicle != 0) {
            if (currencyFlag == 1) {
                flag = 1;
                filter = jQuery.grep(RentList, function (n, idx) {
                    return RentList[idx][2] == Vehicle && RentList[idx][1] == countryid;
                });
            }
            else {
                flag = 1;
                filter = jQuery.grep(RentDlr, function (n, idx) {
                    return RentDlr[idx][2] == Vehicle && RentDlr[idx][1] == countryid;
                });
            }
        }
    }
    $("#Rent").html("");
   
    if (filter.length > 0) {
        var imgno = 0;
        $.each(filter, function (i) {
            $("#Rent").append('<div class="col-sm-6 col-md-4">' +
                '<div class="panel panel-default">' +
                '<div class="panel-body">' +
                '<img src="' + filter[i][4] + '" class="img-responsive">' +
                '<span class="label label-danger">' + icon + filter[i][5] + '/hour</span>' +
                '</div>' +
                '<div class="panel-heading text-center">' +
                '<div class="row">' +
                '<div class="col-sm-6 title-1">' +
                '<h4>' + filter[i][3] + '</h4>' +
                '</div>' +
                '<div class="col-sm-6 title-price">' +
                //'<h4>₹ 2500 / 100kms</h4>'+
                '</div>' +
                '</div>' +
                '<div class="row">' +
                '<div class="col-sm-6 detail-button">' +
                '<button class="btn btn-danger btn-sm rentmsg" id="View_' + filter[i][0] + '" data-toggle="modal" data-target="#myModal">View Details</button>' +
                '</div>' +
                '<div class="col-sm-6 contact-button">' +
                '<button class="btn btn-success btn-sm rentmsg" id="Contact_' + filter[i][0] + ' "data-toggle="modal" data-target="#myModal1">Contact Us</button>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>');
            $("#Rent").append("</div>");
        });
    }
    else {
        $("#Rent").html("<h1>No data found</h1>");
    }
}


function getRentList() {
    $.ajax({
        type: "POST",
        url: url + "/getRent",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                mapRentList(jsonobj);
            }
            else {
                RentList = [];
            }
            setTimeout(function(){ BindRent()},1000);
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function mapRentList(jsonobj) {
    RentList = $.map(jsonobj, function (el) {
        return {
            0: el.RENTID,
            1: el.LOCATION,
            2: el.VEHICLETYPE,
            3: el.VEHICLENAME,
            4: el.IMAGEPATH,
            5: el.COST,
            6: el.DESCRIPTION,
            7: el.TERMS,
            8: el.BRAND
        }
    });

    RentDlr = $.map(jsonobj, function (el) {
        return {
            0: el.RENTID,
            1: el.LOCATION,
            2: el.VEHICLETYPE,
            3: el.VEHICLENAME,
            4: el.IMAGEPATH,
            5: el.COST,
            6: el.DESCRIPTION,
            7: el.TERMS,
            8: el.BRAND
        }
    });

    $.each(RentList, function (i) {
        var gp_from = "INR";
        var gp_to = "USD";
        var gp_amount = RentList[i][5];
        $.getJSON("http://www.geoplugin.net/currency_converter.gp?jsoncallback=?", { from: gp_from, to: gp_to, amount: gp_amount },
            function (output) {
                RentDlr[i][5] = Math.round(output.to.amount);
            });
    });
}


function getPlaceList() {
    $.ajax({
        type: "POST",
        url: url + "/getLocation",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                mapPlaceList(jsonobj);
                BindCityDropDown();
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });

}

function getVehicleList() {
    $.ajax({
        type: "POST",
        url: url + "/getVehicle",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                mapVehicleList(jsonobj);
                BindVehicleDropDown();
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });

}


function mapPlaceList(jsonobj) {
    locationList = $.map(jsonobj, function (el) {
        return {
            0: el.LOCATION
        }
    });
}

function BindCityDropDown() {
    var appendvalue = "";
    $("#selectCountry").empty();
    for (var i = 0; i <= locationList.length - 1; i++) {
        appendvalue += "<option value=" + locationList[i][0] + ">" + locationList[i][0] + "</option>";
    }
    $("#selectCountry").append("<option value=0>Select</option>");
    $("#selectCountry").append(appendvalue);
   
}

function mapVehicleList(jsonobj) {
    vehicle = $.map(jsonobj, function (el) {
        return {
            0: el.VEHICLEID,
            1: el.VEHICLENAME
        }
    });
}

function BindVehicleDropDown() {
    var appendvalue = "";
    $("#selectVehicle").empty();
    $("#vehicle").empty();
    $("#selectVehicle").empty();
    for (var i = 0; i <= vehicle.length - 1; i++) {
        appendvalue += "<option value=" + vehicle[i][0] + ">" + vehicle[i][1] + "</option>";
    }
    $("#selectVehicle").append("<option value=0>Select</option>");
    $("#selectVehicle").append(appendvalue);
    $("#vehicle").append(appendvalue);
}


function BindRent() {
    $("#Rent").empty();
    if (currencyFlag == 1) {
        $("#Rent").addClass('row');

        var imgno = 0;
        $.each(RentList, function (i) {
            $("#Rent").append('<div class="col-sm-6 col-md-4">' +
                '<div class="panel panel-default">' +
                '<div class="panel-body">' +
                '<img src="' + RentList[i][4] + '" class="img-responsive">' +
                '<span class="label label-danger">' + RentList[i][1] +'</span>' +
                '</div>' +
                '<div class="panel-heading text-center">' +
                '<div class="row">' +
                '<div class="col-sm-6 title-1">' +
                '<h4>' + RentList[i][8] + '</h4>' +
                '</div>' +
                '<div class="col-sm-6 title-price">' +
                '<h4 class="rupee-font">₹' + RentList[i][5] + '/ 100kms</h4>'+
                '</div>' +
                '</div>' +
                '<div class="row">' +
                '<div class="col-sm-6 detail-button">' +
                '<button class="btn btn-danger btn-sm rentmsg" id="View_' + RentList[i][0] + '" data-toggle="modal" data-target="#myModal">View Details</button>' +
                '</div>' +
                '<div class="col-sm-6 contact-button">' +
                '<button class="btn btn-success btn-sm rentmsg" id="Contact_' + RentList[i][0] + ' "data-toggle="modal" data-target="#myModal1">Contact Us</button>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>');
            $("#Rent").append("</div>");

        });
    }
    else {
        var imgno = 0;
        $.each(RentList, function (i) {
            //var gp_from = "INR";
            //var gp_to = "USD";
            //var gp_amount = RentList[i][5];
            //$.getJSON("http://www.geoplugin.net/currency_converter.gp?jsoncallback=?", { from: gp_from, to: gp_to, amount: gp_amount },
            //    function (output) {
            //        RentDlr[i][5] = Math.round(output.to.amount);
                    $("#Rent").append('<div class="col-sm-6 col-md-4">' +
                        '<div class="panel panel-default">' +
                        '<div class="panel-body">' +
                        '<img src="' + RentDlr[i][4] + '" class="img-responsive">' +
                        '<span class="label label-danger">' + RentDlr[i][1] + '</span>' +
                        '</div>' +
                        '<div class="panel-heading text-center">' +
                        '<div class="row">' +
                        '<div class="col-xs-6 title-1">' +
                        '<h4>' + RentDlr[i][8] + '</h4>' +
                        '</div>' +
                        '<div class="col-xs-6 title-price">' +
                        '<h4 class="rupee-font">$' + RentDlr[i][5] + '/ 100kms</h4>'+
                        '</div>' +
                        '</div>' +
                        '<div class="row">' +
                        '<div class="col-xs-6 detail-button">' +
                        '<button class="btn btn-danger btn-sm rentmsg" id="View_' + RentDlr[i][0] + '" data-toggle="modal" data-target="#myModal">View Details</button>' +
                        '</div>' +
                        '<div class="col-xs-6 contact-button">' +
                        '<button class="btn btn-success btn-sm rentmsg" id="Contact_' + RentDlr[i][0] + ' "data-toggle="modal" data-target="#myModal1">Contact Us</button>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>');
                    //if (i != 0) {
                    //    if (i == 2) {
                    //        $("#Rent").append("</div><div class='row sub-title'>");
                    //        imgno = i + 3;
                    //    }
                    //    if (i == imgno) {
                    //        $("#Rent").append("</div><div class='row sub-title'>");
                    //        imgno = i + 3;
                    //    }
                    //}
                    $("#Rent").append("</div>");
                //});
            
        });
    }
}

function BindRentTour(arr,icon) {
    $("#Rent").empty();
    $("#Rent").addClass('row');

    var imgno = 0;
    $.each(arr, function (i) {
        $("#Rent").append('<div class="col-sm-6 col-md-4">' +
            '<div class="panel panel-default">' +
            '<div class="panel-body">' +
            '<img src="' + arr[i][4] + '" class="img-responsive">' +
            '<span class="label label-danger">' + arr[i][1] + '</span>' +
            '</div>' +
            '<div class="panel-heading text-center">' +
            '<div class="row">' +
            '<div class="col-xs-6 title-1">' +
            '<h4>' + arr[i][8] + '</h4>' +
            '</div>' +
            '<div class="col-sm-6 title-price">' +
            '<h4 class="rupee-font">' + icon + arr[i][5] + '/ 100kms</h4>'+
            '</div>' +
            '</div>' +
            '<div class="row">' +
            '<div class="col-xs-6 detail-button">' +
            '<button class="btn btn-danger btn-sm rentmsg" id="View_' + arr[i][0] + '" data-toggle="modal" data-target="#myModal">View Details</button>' +
            '</div>' +
            '<div class="col-xs-6 contact-button">' +
            '<button class="btn btn-success btn-sm rentmsg" id="Contact_' + arr[i][0] + ' "data-toggle="modal" data-target="#myModal1">Contact Us</button>' +
            '</div>' +
            '</div>' +
            '</div>' +
            '</div>' +
            '</div>');
        //if (i != 0) {
        //    if (i == 2) {
        //        $("#Rent").append("</div><div class='row sub-title'>");
        //        imgno = i + 3;
        //    }
        //    if (i == imgno) {
        //        $("#Rent").append("</div><div class='row sub-title'>");
        //        imgno = i + 3;
        //    }
        //}
        $("#Rent").append("</div>");

    });
}


function SendMail() {
    var rent = $("#vehicle option:selected").text();
    var email = $("#inputEmail").val();
    var phone = $("#phoneno").val();



    $.ajax({
        type: "POST",
        url: url + "/SendMail",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ Rent: rent, Email: email, Phone: phone }),
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                $("#div-email").hide();
                $("#success").show();

                $("#inputEmail").val('');
                $("#phoneno").val('');


            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}