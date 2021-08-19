var username = "";
var pass = "";
var url = "login.aspx";
$(document).ready(function () {
    //getrate();
    $("#modaloverlay").hide();
   // url = window.location.href;
    if ($("#hdnflag").val() == "1") {
        var user = $("#user").val();
        var pass = $("#pass").val();
        $("#txtUserName").val(user);
        $("#txtPassword").val(pass);
        $("#rememberme").attr("checked");
        $('input[name="check"]')[0].checked = true;
    }
    $("#btnSubmit").click(function (e) {
        e.preventDefault();
        checkLogin();
    });
    $("#reset_pwd").click(function (e) {
        e.preventDefault();
        ResetPwd();
    });
});

    
function getrate() {
    var gp_from ="INR";
    var gp_to = "USD";
    var gp_amount = 10000;
    $.getJSON("http://www.geoplugin.net/currency_converter.gp?jsoncallback=?", { from: gp_from, to: gp_to, amount: gp_amount },
        function (output) {
         alert(output.from.symbol + output.from.amount + " = " + output.to.symbol + output.to.amount);
        });
    
}


function checkLogin() {
    var username = $("#txtUserName").val();
    if (username == "") {
        $("#txtUserName").css("border", "1px solid red");
        return false;
    }
    else {
        $("#txtUserName").css("border", "");
    }
    var pass = $("#txtPassword").val();
    if (pass == "") {
      
        $("#txtPassword").css("border", "1px solid red");
        return false;
    }
    else {
        $("#txtPassword").css("border", "");
    }
   // $('#myForm').validator()
    var flag=""  
    if ($("#rememberme").is(":checked")) {
        flag = "1";
    }
    else {
        flag = "0";
    }


    $("#processing-bar-holder").removeClass("collapse");
    $("#modaloverlay").show();

    $.ajax({
        type:"POST",
        url: url+"/checkLogin",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        data: JSON.stringify({ userid: username, password: pass, Flag: flag }),
        
        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {
                  
                    window.location.href = "/AdminPages/default.aspx";
                    //$("#invalid_cred").text("Login Success");
                }
                else {
                    $("#invalid_cred").text("Invalid Credenatials");
                    $("#modal1").modal("show");
                }
                $("#processing-bar-holder").addClass("collapse");
                $("#modaloverlay").hide();
            }
            else {
                $("#invalid_cred").text("Invalid Credenatials");
                $("#modal1").modal("show");
                $("#processing-bar-holder").addClass("collapse");
                $("#modaloverlay").hide();
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function ResetPwd() {
    $.ajax({
        type: "POST",
        url: url + "/ResetPassword",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {
                    $("#invalid_cred").text("Mail has been sent to your registered email id.");
                    $("#modal1").modal("show");
                    //$("#invalid_cred").text("Login Success");
                }
                else {
                   // $("#invalid_cred").text("Invalid Creditials");
                }
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}
