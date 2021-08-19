var url = "";
var AboutUs = [];
$(document).ready(function () {
    url ="Aboutus.aspx";
    $("#title").text("About Us Master");
    //getAboustUs();

    $("#btnSubmit").click(function (e) {
        e.preventDefault();
        InsertAboutUs();

    });

    $("#close").click(function (e) {
        window.location.href = "aboutus.aspx";
    });

});


function InsertAboutUs() {
    var contentData = $("#ContentPlaceHolder1_aboutus").val();
    if (contentData == "") {
       // alert("Please enter data");
        $("#lblmessage").html("Please enter data");
        return false;
    }
    else {
        $("#lblmessage").html("");

        $.ajax({
            type: "POST",
            url: url + "/UpdateAboutUs",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ Content: contentData }),
            dataType: "json",
            success: function (msg) {
                if (msg.d != "") {
                    UploadAboutUsImages();
                    getAboustUs();
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
}

function getAboustUs() {
    $.ajax({
        type: "POST",
        url: url + "/getAboutUs",
        contentType: "application/json; charset=utf-8",

        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
                mapAboutUs(jsonObj);
                bindAboutUs();
            }
            else {

            }

        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while updating data");
            $("#modal-danger").modal("show");
        }
    });
}

function mapAboutUs(obj) {
    AboutUs = $.map(obj, function (el) {
        return {
            0: el.ABOUTCONTENT

        }
    });
}

function bindAboutUs() {
    $("#aboutus").html(AboutUs[0][0]);
}

function UploadAboutUsImages() {
    var uploadfiles = $("#about-image").get(0);
    var uploadedfiles = uploadfiles.files;

    if (uploadedfiles.length > 0) {
        var fromdata = new FormData();
        for (var i = 0; i < uploadedfiles.length; i++) {

            fromdata.append(uploadedfiles[i].name, uploadedfiles[i]);
        }
        $("#modaloverlay").show()
        $(" .collapse").css("display", "block");

        move();

        $.ajax({
            type: "POST",
            contentType: false,
            processData: false,
            url: "AboutUsHandler.ashx",

            data: fromdata,
            dataType: "json",
            success: function (msg) {
                if (msg != "" && msg == "1") {
                    $("#modaloverlay").hide()
                    $(" .collapse").css("display", "none");
                    $("#SuccessStatus").text("Data updated successfully");
                    $("#modal-success").modal("show");
                }
                else {
                    $("#FailureStatus").text("Error while updating about us detail");
                    $("#modal-danger").modal("show");
                }
            },
            Error: function (x, e) {
                $("#FailureStatus").text("Error while updating about us detail");
                $("#modal-danger").modal("show");
            }
        });
    }
    else {
        $("#SuccessStatus").text("Data updated successfully");
        $("#modal-success").modal("show");
    }
}

function move() {
    var elem = document.getElementById("myBar");
    $('.bg-holder').css("display", "block");
    var width = 1;
    var id = setInterval(frame, 10);
    function frame() {
        if (width > 90) {
            clearInterval(id);
        } else {
            width++;
            elem.style.width = width + '%';
        }
    }
}