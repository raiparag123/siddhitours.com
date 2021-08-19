var confpass = "";
var newpass = "";
var url = "";
$(document).ready(function () {
    url = window.location.href;
    $("#btnSubmit").click(function (e) {
        e.preventDefault();
        ResetPassword();
    });
 
});


function ResetPassword() {
    newpassword = $("#newpassword").val();
    confpass = $("#confpassword").val();
    if (newpassword == confpass) {
        $.ajax({
            type: "POST",
            url: url + "/ResetPass",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ password: newpassword }),
            dataType: "json",
            success: function (msg) {
                if (msg.d != "") {
                    if (msg.d == "1") {
                        $("#newpassword").val('');
                        $("#confpassword").val('');
                        alert("password reset successfully");
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
    else {
        alert("Password does not match");
    }
}