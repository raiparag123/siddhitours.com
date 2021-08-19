
var url = "MasterPage.master";
var category = [];
var CurrencyFlag = 1;
var contactUs = [];

$(document).ready(function () {
    bindMenu();
    GetFooter();
    $("#submit").click(function (e) {
        //$('#form').bootstrapValidator('validate');

        e.preventDefault();
        SendMail();
    });

    $("input[name='currency']").change(function (e) {
        //$('#form').bootstrapValidator('validate');
        var value = $("input[name='currency']:checked").val();
        var sendValue = "";
        if (value == 'INR') {
            sendValue = 1;
        }
        else {
            sendValue = 0;
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


    $("#search").autocomplete({
        source: function (request, response) {
            var param = { prefixText: $('#search').val() };
            $.ajax({
                url: "../Default.aspx/GetSearchTrip",
                data: JSON.stringify(param),
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataFilter: function (data) { return data; },
                success: function (data) {
                    console.log(JSON.stringify(data));
                    response($.map(data.d, function (item) {
                        return {
                            value: item
                        }
                    }))
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    // var err = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(err.Message)
                    // console.log("Ajax Error!");    
                }
            });
        },
        minLength: 2//This is the Char length of inputTextBox    
    });


    $("#btnsearch").click(function (e) {
        e.preventDefault();
        var searchValue = $("#search").val();
        window.location.href = "/FrontendPages/Trip.aspx?Search=" + searchValue;

    });
    

});

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}

function bindMenu() {


    $.ajax({
        type: "POST",
        url: "Default.aspx/GetMenu",
        contentType: "application/json; charset=utf-8",

        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
                category = $.map(jsonObj, function (el) {
                    return {
                        0: el.TYPEID,
                        1: el.TYPENAME


                    }
                });
                strdata = "";
                $.each(category, function (i) {
                    // $("#category").append("<li><a ref='' href='tour.aspx?CategoryId=" + category[i][0] + ">" + category[i][1] + "</li>");
                    $("#category").append("<li><a rel='external' href='../Frontendpages/trip.aspx?CategoryId=" + category[i][0] + "'>" + category[i][1] + "</li>");
                });
                //strdata);
                $("#category").append("<li><a rel='external' href='../Frontendpages/Trending.aspx'>Trending</li>");

            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function SendMail() {

    var name = $("#name").val();
    var email = $("#email").val();
    var phone = $("#phone").val();
    var message = $("#message").val();


    $.ajax({
        type: "POST",
        url: "Default.aspx/SendMail",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ Name: name, Email: email, Phone: phone, Message: message }),
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                $("#name").val('');
                $("#email").val('');
                $("#phone").val('');
                $("#message").val('');

            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function getrate(from, to, amt) {
    var gp_from = from;
    var gp_to = to;
    var gp_amount = amt;
    $.getJSON("http://www.geoplugin.net/currency_converter.gp?jsoncallback=?", { from: gp_from, to: gp_to, amount: gp_amount },
        function (output) {
            return output.to.amount;
        });

}

function GetFooter() {
    $.ajax({
        type: "POST",
        url: "Default.aspx/GetContactUs",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        //async: false,
        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                mapContactUs(jsonobj);
                BindContactUs();
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function mapContactUs(jsonobj) {
    contactUs = $.map(jsonobj, function (el) {
        return {
            0: el.Email,
            1: el.FB,
            2: el.Instagram,
            3: el.Phone1,
            4: el.Phone2,
            5: el.IsWhatsapp1,
            6: el.IsWhatsapp2
        }
    });
}
function BindContactUs() {
    //console.log(contactUs);
    $("#FooteremailId").html(contactUs[0][0]);
    if (contactUs[0][5] == true) {
        $("#Footerwhats1").removeAttr("class", "fa-phone");
        $("#Footerwhats1").attr("class", "fa fa-whatsapp");
    }
    $("#Footermob1").html(contactUs[0][3]);
    if (contactUs[0][6] == true) {
        $("#Footerwhats2").removeAttr("class", "fa-phone");
        $("#Footerwhats2").attr("class", "fa fa-whatsapp");
    }
    $("#Footermob2").html(contactUs[0][4]);
    $("#fb").attr("href",contactUs[0][1]);
    $("#insta").attr("href",contactUs[0][2]);
}