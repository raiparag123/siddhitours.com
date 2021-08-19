var url = "MailDetail.aspx";
var detail = [];

$(document).ready(function () {
    $("#title").text("Mail Detail");
    GetMailDetail();

    $("#btnEdit").click(function (e) {
        e.preventDefault();
        UpdateDetail();
    });
});


function UpdateDetail() {
    $("#EmailMessage").html("");
    var displayName = $("#txtDisplay").val();
    if (displayName.trim() == "") {
        $("#EmailMessage").html("Please enter display name");
        return false;
    }
    var emailId = $("#txtEmail").val();
    if (emailId.trim() == "") {
        $("#EmailMessage").html("Please enter email id");
        return false;
    }
    var expr = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    var valid = expr.test(emailId);//.toString();
    if (valid == false) {
        $("#EmailMessage").html("Please enter valid e-mail address");
        return false;
    }

    $.ajax({
        type: "POST",
        url: url + "/UpdateMailDetail",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({
            DisplayName: displayName, EmailId: emailId
        }),
        success: function (msg) {
            if (msg.d == "1") {
                $("#SuccessStatus").text("Mail details updated successfully");
                $("#modal-success").modal("show");
            }
            else {
                $("#FailureStatus").text("Error while updating mail details");
                $("#modal-danger").modal("show");
            }
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while updating mail details");
            $("#modal-danger").modal("show");
        }
    });
}

function GetMailDetail() {
    $.ajax({
        type: "POST",
        url: url + "/GetMailDetail",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
                mapMail(jsonObj);
            }
            else {
                TripTypeArr = null;
            }
            BindDetail();
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while updating mail details");
            $("#modal-danger").modal("show");
        }
    });
}

function mapMail(obj) {
    detail = $.map(obj, function (el) {
        return {
            0: el.DisplayName,
            1: el.EMailId
        }
    });
}

function BindDetail()
{
    $("#txtDisplay").val(detail[0][0]);
    $("#txtEmail").val(detail[0][1]);
}