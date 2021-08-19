var Visa = [];
var url = "visa.aspx";
var country = [];
var visaid = "";
var filter = "";
var flag = "";
var currencyFlag = "1";
var categoryId = "";
var VisaDlr = [];
var UsdValue;
$(document).ready(function (e) {
    $("#nav").removeClass(".affix-top");
    $("#nav").removeAttr("data-spy");
     UsdValue = dlrValue();
    getCountry();
    getVisa();

    $(document).on("click", ".alert", function (e) {
        e.preventDefault();
        var id = $(this).attr("id").split("_");
        visaid = id[1];
        var info = jQuery.grep(Visa, function (n, idx) {
            return Visa[idx][0] == visaid;
        });
        if (id[0] == "View") {
            $("#desc").modal("show");
            $("#visaname").html(info[0][2] + " Visa")
            $("#docreq").html(info[0][3])
        }
        else {
            $("#div-email").show();
            $("#success").hide();
            $("#myModal1").modal("show");
            // $("#myModalLabel").text(info[0][3])
            $("#selectVisa option[value=" + info[0][1] + "]").attr("selected", "selected");
        }
    });

    $("#btnSubmit").click(function (e) {
        e.preventDefault();
       // $('#form').bootstrapValidator('validate');
        SendMail();

    });


    $("#selectCountry").change(function (e) {
        e.preventDefault();
        var countryid = $("#selectCountry option:selected").val();
        var icon = "";
        if (countryid > 0) {
            flag = 1;
            if (currencyFlag == 1) {
                filter = jQuery.grep(Visa, function (n, idx) {
                    return Visa[idx][1] == countryid;
                });
                icon = "₹";
            }
            else {
                filter = jQuery.grep(VisaDlr, function (n, idx) {
                    return VisaDlr[idx][1] == countryid;
                });
                icon = "$";
            }
            $("#VisaData").empty();
           
            if (filter.length > 0) {
                $("#VisaData").addClass('row');
                var imgno = 0;
                $.each(filter, function (i) {
                    $("#VisaData").append('<div class="col-sm-3">' +
                        '<div class="panel panel-default">' +
                        '<div class="panel-body">' +
                        '<img src=' + filter[i][4] + ' class="img-responsive">' +
                        '</div>' +
                        '<div class="panel-heading text-center">' +
                        '<div class="row">' +
                        '<div class="col-sm-6 title-1">' +
                        '<h4>' + filter[i][2] + '</h4>' +
                        '</div>' +
                        '<div class="col-sm-6 title-price">' +
                        '<h4>₹' + filter[i][5] + '</h4>' +
                        '</div>' +
                        '</div>' +
                        '<div class="row">' +
                        '<div class="col-sm-6 detail-button">' +
                        '<button class="btn btn-danger btn-sm alert" id=View_' + filter[i][0] + ' data-toggle="modal" >View Details</button>' +
                        '</div>' +
                        '<div class="col-sm-6 contact-button">' +
                        '<button class="btn btn-success btn-sm alert" id=Contact_' + filter[i][0] + ' data-toggle="modal">Contact Us</button>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>');
                    //if (i != 0) {
                    //    if (i == 2) {
                    //        $("#VisaData").append("</div><div class='row sub-title'>");
                    //        imgno = i + 3;
                    //    }
                    //    if (i == imgno) {
                    //        $("#VisaData").append("</div><div class='row sub-title'>");
                    //        imgno = i + 3;
                    //    }
                    //}
                    


                });
                $("#VisaData").append("</div>");
            }
            else {
                $("#VisaData").append("<h1>No Data found</h1>");
            }
        }
        else {
            BindVisa();
        }
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
            BindFilterVisa(filter,icon);
        }
        else {
            if (CurrencyFlag == 1) {
                Visa.sort(function (a, b) {
                    var a1 = a[0], b1 = b[0];
                    if (a1 == b1) return 0;
                    return a1 < b1 ? 1 : -1;
                });
                BindFilterVisa(Visa,icon);
            }
            else {
                VisaDlr.sort(function (a, b) {
                    var a1 = a[0], b1 = b[0];
                    if (a1 == b1) return 0;
                    return a1 < b1 ? 1 : -1;
                });
                BindFilterVisa(VisaDlr, icon);
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
                var a1 = a[5], b1 = b[5];
                if (a1 == b1) return 0;
                return a1 < b1 ? 1 : -1;
            });
            BindFilterVisa(filter,icon);
        }
        else {
            if (currencyFlag == 1) {
                Visa.sort(function (a, b) {
                    var a1 = a[5], b1 = b[5];
                    var a1 = Math.round(a[5].replace(",", "")), b1 = Math.round(b[5].replace(",", ""));
                    if (a1 == b1) return 0;
                    return a1 < b1 ? 1 : -1;
                });
                BindFilterVisa(Visa, icon);
            }
            else {
                VisaDlr.sort(function (a, b) {
                    var a1 = a[5], b1 = b[5];
                    var a1 = Math.round(a[5].replace(",", "")), b1 = Math.round(b[5].replace(",", ""));
                    if (a1 == b1) return 0;
                    return a1 < b1 ? 1 : -1;
                });
                BindFilterVisa(VisaDlr, icon);
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
                return a1 > b1 ? 1 : -1;
            });
            BindFilterVisa(filter);
        }
        else {
            if (currencyFlag == 1) {
                Visa.sort(function (a, b) {
                    var a1 = a[5], b1 = b[5];
                    var a1 = Math.round(a[5].replace(",", "")), b1 = Math.round(b[5].replace(",", ""));
                    if (a1 == b1) return 0;
                    return a1 > b1 ? 1 : -1;
                });
                BindFilterVisa(Visa, icon);
            }
            else {
                VisaDlr.sort(function (a, b) {
                    var a1 = a[5], b1 = b[5];
                    var a1 = Math.round(a[5].replace(",", "")), b1 = Math.round(b[5].replace(",", ""));
                    if (a1 == b1) return 0;
                    return a1 > b1 ? 1 : -1;
                });
                BindFilterVisa(VisaDlr, icon);
            }
        }

    });

    currencyFlag = $("#currValue").val();
    if (currencyFlag == 1) {
        $("input[name='currency'][value=INR]").attr('checked', 'checked');
    }
    else {
        $("input[name='currency'][value=DOLLAR]").attr('checked', 'checked');
    }
    


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
        BindVisa();
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

});


function dlrValue() {
    var value = "";
    var gp_from = "INR";
    var gp_to = "USD";
    var gp_amount = 1;
    $.getJSON("http://www.geoplugin.net/currency_converter.gp?jsoncallback=?", { from: gp_from, to: gp_to, amount: gp_amount },
        function (output) {
            value= output.to.amount;
        });
    return value;
}
function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}
function SendMail() {
    var visa = $("#selectVisa option:selected").text();
    var email = $("#inputEmail").val();
    var phone = $("#phoneno").val();
    


    $.ajax({
        type: "POST",
        url: url+"/SendMail",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ Visa:visa,Email: email, Phone: phone }),
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

function getCountry() {
    $.ajax({
        type: "POST",
        url: url + "/getCountry",
        contentType: "application/json; charset=utf-8",

        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
                mapCountry(jsonObj);
                BindCountry();

            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}
function mapCountry(jsonObj) {
    country = $.map(jsonObj, function (el) {
        return {
           
            0: el.COUNTRYID,
            1: el.COUNTRYNAME
      
        }
    })

}

    function BindCountry() {
        $("#selectCountry").empty();
    var strcountry = "";
    var strvisa=""
    strcountry = "<option value=0 selected>Select</option>";
    $.each(country, function (i) {
        strcountry += "<option value="+country[i][0]+">"+country[i][1]+"</option>";
    });
    $("#selectCountry").append(strcountry);

    $.each(country, function (i) {
        strvisa += "<option value=" + country[i][0] + ">" + country[i][1] + " Visa </option>";
    });

    $("#selectVisa").append(strvisa);
}


function getVisa() {
    $.ajax({
        type: "POST",
        url: url + "/getVisa",
        contentType: "application/json; charset=utf-8",

        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
               mapVisa(jsonObj);
               setTimeout(function(){ BindVisa()},1000);
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function mapVisa(jsonObj) {
    Visa = $.map(jsonObj, function (el) {
        return {
            0: el.VISAID,
            1: el.COUNTRYID,
            2: el.COUNTRYNAME,
            3: el.DOC,
            4: el.IMAGEPATH,
            5: el.COST
        }
    });

    VisaDlr = $.map(jsonObj, function (el) {
        return {
            0: el.VISAID,
            1: el.COUNTRYID,
            2: el.COUNTRYNAME,
            3: el.DOC,
            4: el.IMAGEPATH,
            5: el.COST
        }
    });

    $.each(VisaDlr, function (i) {
        var gp_from = "INR";
        var gp_to = "USD";
        var gp_amount = Visa[i][5];
        $.getJSON("http://www.geoplugin.net/currency_converter.gp?jsoncallback=?", { from: gp_from, to: gp_to, amount: gp_amount },
            function (output) {
                VisaDlr[i][5] = output.to.amount;               
            });
    });
}


function BindVisa() {

    $("#VisaData").empty();
    if (currencyFlag == 1) {
        $("#VisaData").addClass('row');
        var imgno = 0;
        $.each(Visa, function (i) {
            $("#VisaData").append('<div class="col-sm-6 col-md-4 col-lg-3">' +
                '<div class="panel panel-default">' +
                '<div class="panel-body">' +
                '<img src=' + Visa[i][4] + ' class="img-responsive">' +
                '</div>' +
                '<div class="panel-heading text-center">' +
                '<div class="row">' +
                '<div class="col-xs-6 title-1">' +
                '<h4>' + Visa[i][2] + '</h4>' +
                '</div>' +
                '<div class="col-xs-6 title-price">' +
                '<h4 class="rupee-font">₹' + Visa[i][5] + '</h4>' +
                '</div>' +
                '</div>' +
                '<div class="row">' +
                '<div class="col-xs-6 detail-button">' +
                '<button class="btn btn-danger btn-sm alert" id=View_' + Visa[i][0] + ' data-toggle="modal" >View Details</button>' +
                '</div>' +
                '<div class="col-xs-6 contact-button">' +
                '<button class="btn btn-success btn-sm alert" id=Contact_' + Visa[i][0] + ' data-toggle="modal">Contact Us</button>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>');
        });
        $("#VisaData").append("</div>");
    }
    else {
        $("#VisaData").addClass('row');
        var imgno = 0;
        $.each(VisaDlr, function (i) {
            //var gp_from = "INR";
            //var gp_to = "USD";
            //var gp_amount = Visa[i][5];
            //$.getJSON("http://www.geoplugin.net/currency_converter.gp?jsoncallback=?", { from: gp_from, to: gp_to, amount: gp_amount },
            //    function (output) {
            //        VisaDlr[i][5] = output.to.amount;
                        $("#VisaData").append('<div class="col-sm-6 col-md-4 col-lg-3">' +
                        '<div class="panel panel-default">' +
                        '<div class="panel-body">' +
                        '<img src=' + VisaDlr[i][4] + ' class="img-responsive">' +
                        '</div>' +
                        '<div class="panel-heading text-center">' +
                        '<div class="row">' +
                        '<div class="col-xs-6 title-1">' +
                        '<h4>' + VisaDlr[i][2] + '</h4>' +
                        '</div>' +
                        '<div class="col-sm-6 title-price">' +
                        '<h4 class="rupee-font">$' + VisaDlr[i][5] + '</h4>' +
                        '</div>' +
                        '</div>' +
                        '<div class="row">' +
                        '<div class="col-xs-6 detail-button">' +
                        '<button class="btn btn-danger btn-sm alert" id=View_' + VisaDlr[i][0] + ' data-toggle="modal" >View Details</button>' +
                        '</div>' +
                        '<div class="col-xs-6 contact-button">' +
                        '<button class="btn btn-success btn-sm alert" id=Contact_' + VisaDlr[i][0] + ' data-toggle="modal">Contact Us</button>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>');                    
                    if (i == VisaDlr.length) {
                        $("#VisaData").append("</div>");
                    }
                //});
           
        });
    }
}

function BindFilterVisa(arr,icon) {
    $("#VisaData").empty();
    $("#VisaData").addClass('row');
    var imgno = 0;
    $.each(arr, function (i) {
        $("#VisaData").append('<div class="col-sm-3">' +
            '<div class="panel panel-default">' +
            '<div class="panel-body">' +
            '<img src=' + arr[i][4] + ' class="img-responsive">' +
            '</div>' +
            '<div class="panel-heading text-center">' +
            '<div class="row">' +
            '<div class="col-sm-6 title-1">' +
            '<h4>' + arr[i][2] + '</h4>' +
            '</div>' +
            '<div class="col-sm-6 title-price">' +
            '<h4 class="rupee-font">'+icon + arr[i][5] + '</h4>' +
            '</div>' +
            '</div>' +
            '<div class="row">' +
            '<div class="col-sm-6 detail-button">' +
            '<button class="btn btn-danger btn-sm alert" id=View_' + arr[i][0] + ' data-toggle="modal" >View Details</button>' +
            '</div>' +
            '<div class="col-sm-6 contact-button">' +
            '<button class="btn btn-success btn-sm alert" id=Contact_' + arr[i][0] + ' data-toggle="modal">Contact Us</button>' +
            '</div>' +
            '</div>' +
            '</div>' +
            '</div>' +
            '</div>');
        //if (i != 0) {
        //    if (i == 3) {
        //        $("#VisaData").append("</div><div class='row sub-title'>");
        //        imgno = i + 4;
        //    }
        //    if (i == imgno) {
        //        $("#VisaData").append("</div><div class='row sub-title'>");
        //        imgno = i + 4;
        //    }
        //}


    });
    $("#VisaData").append("</div>");
}