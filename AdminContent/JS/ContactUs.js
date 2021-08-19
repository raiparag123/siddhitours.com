var Address = "";
var Phone1 = "";
var Phone2 = "";
var email = "";
var google = "";
var fb = "";
var insta = "";
var url = "ContactUs.aspx"
var whatsapp1 = 0;
var whatsapp2 = 0;
var contactus = [];

$(document).ready(function () {
    $("#title").text("Contact Us Master");
    getContactus();
    $("#CntMessage").html("");
    $("#btnSave").click(function (e) {
        e.preventDefault();
        $("#CntMessage").html("");
        ValidateData();

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

function ValidateData() {
    $("#CntMessage").html("");
    Address = $("#ContentPlaceHolder1_address").val();
    Phone1 = $("#ph1").val();
    Phone2 = $("#ph2").val();
    email = $("#email-id").val();
    google = $("#google-link").val();
    fb = $("#facebook").val();
    insta = $("#insta").val();
    if ($('#whatsapp1').is(":checked")) {
        whatsapp1 = 1;
    }
    else {
        whatsapp1 = 0;
    }

    if ($('#whatsapp2').is(":checked")) {
        whatsapp2 = 1;
    }
    else {
        whatsapp2 = 0;
    }
    var valid = false;
    if (Address == "") {
        $("#CntMessage").html("Please enter the addresss");
       return false;
    }
    else { valid = true; }

    if (Phone1 == "") {
        $("#CntMessage").html("Pleaase enter first mobile number");
        return false;
    }
    else { valid = true; }

    if (Phone2 == "") {
        $("#CntMessage").html("Please enter second mobile number");
        return false;
    }
    else { valid = true; }

    if (email == "") {
        $("#CntMessage").html("Please enter email id");
        return false;
    }
    else { valid = true; }

    if (google == "") {
        $("#CntMessage").html("Please Enter google map link");
        return false;
    }
    else { valid = true; }
    if (fb == "") {
        $("#CntMessage").html("Please enter facebook link");
        return false;
    }
    else { valid = true; }

    if (insta == "") {
        $("#CntMessage").html("Please enter instagram link");
        return false;
    }
    else { valid = true; }

    if (valid == true) {
        InsertContactDetails();
    }
}

function InsertContactDetails() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: url + "/InsertAddressDetail",

        data: JSON.stringify({
            address: Address, mobile1: Phone1, mobile2: Phone2, Email: email, googlemap: google, FB: fb, Insta: insta, wtapps1: whatsapp1, wtapps2: whatsapp2
        }),
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {
                    $("#SuccessStatus").text("Data updated successfully");
                    $("#modal-success").modal("show");
                    getContactus();
                }
            }
            else {
                $("#FailureStatus").text("Error while updating data");
                $("#modal-danger").modal("show");
            }


        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while updating data");
            $("#modal-danger").modal("show");
        }
    });
}

function getContactus() {
    $("#CntMessage").html("");
    $.ajax({
        type: "POST",
        url: url + "/getContactUs",
        contentType: "application/json; charset=utf-8",

        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
                mapContactUs(jsonObj);
                BindContactUs();

            }
            else {

            }

        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while loading data");
            $("#modal-danger").modal("show");
        }
    });
}


function mapContactUs(obj) {
    contactus = $.map(obj, function (el) {
        return {
            0: el.ADDRESS_DATA,
            1: el.PHONE1,
            2: el.PHONE2,
            3: el.EMAIL,
            4: el.ISWHATSAPP1,
            5: el.ISWHATSAPP2,
            6: el.GOOGLEMAPLINK,
            7: el.FB,
            8: el.INSTAGRAM

        }
    });
}

function BindContactUs() {
   // $("#address").val(contactus[0][0]);
    
    $("#ph1").val(contactus[0][1]);
    $("#ph2").val(contactus[0][2]);
    $("#email-id").val(contactus[0][3]);
    $("#google-link").val(contactus[0][6]);
    $("#facebook").val(contactus[0][7]);
    $("#insta").val(contactus[0][8]);
    if (contactus[0][4] == true) {
        $('#whatsapp1').attr("checked", true)
    }
    if (contactus[0][5] == true) {
        $('#whatsapp2').attr("checked", true)
    }
    //if ($('#whatsapp1').is(":checked")) {
    //    whatsapp1 = 1;
    //}
    //else {
    //    whatsapp1 = 0;
    //}

    //if ($('#whatsapp2').is(":checked")) {
    //    whatsapp2 = 1;
    //}
    //else {
    //    whatsapp2 = 0;
    //}
}