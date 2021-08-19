var placeList = [];
var tripList = [];
var url = "";
var BannerList = [];
var BannerTable = null;
var BannerId = "";
var fileExtension = ["jpg", "jpeg", "png"];

$(document).ready(function () {
    $("#homeMessage").html("");
    url = window.location.href;
    $("#title").text("Home Banner Master");
    getHomeBanner();
    getDestination();
    getTourPackage();
    //$("#ContentPlaceHolder1_btnSubmit").click(function (e) {
    //    e.preventDefault();
    //    ValidateData()

       
    //});

    $("#btnconfirm").click(function (e) {
        $("#homeMessage").html("");
        e.preventDefault();
        DeleteBanner();
    })
});

function validateData() {
    $("#homeMessage").html("");
    var String = "";

    var ext = $("input[type='file']").val().split('.').pop().toLowerCase();
    var Destination = $('#ddlDestination option:selected').text();
    var Package = $('#ddlTourPackage option:selected').val();

    if (jQuery.inArray(ext, fileExtension) == '-1') {
        $("#homeMessage").html("Select a valid file");
        return false;
    }

    //if (Destination == "0" && Package == "0") {
    //    $("#homeMessage").html("Please Select any one of Destination or Package")
    //    return false;
    //}
    //else if (Destination != "0" && Package != "0") {
    //    $("#homeMessage").html("Please Select any one of Destination or Package")
    //    return false;
    //}
    //else {
        if (Destination != "0") {
            String = "../Frontendpages/Trip.aspx?Search=" + Destination;
        }
        else if (Package != "0") {
            String = "../Frontendpages/TripDetail.aspx?Tripid=" + Package;
        }
        $("#ContentPlaceHolder1_hdnDestination").val(String);
        //  return true;
    //}
}

function getDestination() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: url + "/getDestination",

        // data: JSON.stringify({ LOCATION: Location, title:Title }),
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
                mapDestination(jsonObj);
                bindDestinationPlace();
            }
            else {
            }
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while loading home banner");
            $("#modal-danger").modal("show");
        }
    });
}

function mapDestination(jsonobj) {
    placeList = $.map(jsonobj, function (el) {
        return {
            0: el.NAME

        }
    });
}

function bindDestinationPlace() {
    $('#ddlDestination').empty();
    var appendvalue = "";
    for (var i = 0; i < placeList.length - 1; i++) {
        appendvalue += "<option value=" + placeList[i][0] + ">" + placeList[i][0] + "</option>";
    }
    $('#ddlDestination').append("<option value=0>Select</option>")
    $('#ddlDestination').append(appendvalue);
}

function getTourPackage() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: url + "/getDestinationTour",

        // data: JSON.stringify({ LOCATION: Location, title:Title }),
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {

                var jsonObj = JSON.parse(msg.d);
                mapTourList(jsonObj);
                bindTour();
            }
            else {
                $('#ddlTourPackage').append("<option value=0>Select</option>")
            }
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while loading tour package");
            $("#modal-danger").modal("show");
        }
    });
}


function mapTourList(jsonobj) {
    tripList = $.map(jsonobj, function (el) {
        return {
            0: el.TRIPID,
            1:el.TITLE

        }
    });
}

function bindTour() {
    $('#ddlTourPackage').empty();
    var appendvalue = "";
    for (var i = 0; i < tripList.length - 1; i++) {
        appendvalue += "<option value=" + tripList[i][0] + ">" + tripList[i][1] + "</option>";
    }
    $('#ddlTourPackage').append("<option value=0>Select</option>")
    $('#ddlTourPackage').append(appendvalue);



}

function getHomeBanner() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: url + "/getHomeBanner",

        // data: JSON.stringify({ LOCATION: Location, title:Title }),
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {

                var jsonObj = JSON.parse(msg.d);
                mapHomelist(jsonObj);     
            }
            else {
                BannerList = null;
                $('#ddlTourPackage').append("<option value=0>Select</option>")
            }
            bindBanner();
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while loading home banner");
            $("#modal-danger").modal("show");
        }
    });
}

function mapHomelist(jsonObj) {
    BannerList = $.map(jsonObj, function (el) {
        return {
            0: el.BANNERID,
            1: el.IMAGEPATH

        }
    });
}

function bindBanner() {
    if (BannerTable != null) {
        $("#tblHomeBanner").empty();
        BannerTable.fnDestroy();
        
    }
    BannerTable = $("#tblHomeBanner").dataTable({
        "data": BannerList,
        "bDestroy": true,
        "bPaginate": true,

        'autoWidth': false,
        //"aaSorting": [[1, "asc"]],
        searching: true,

        "columnDefs": [
            { "targets": [0], "searchable": false, "visible": false, "sortable": true, "title": "Banner id", "className": "col-xs-1" },
            {
                "targets": [1], "searchable": true, "sortable": true, "title": "Image", "className": "col-xs-1",
                render: function (data, type, row) {
                    return "<img src=" + row[1] + " width=50% />"
                }
            },
            {
                "targets": [2], "searchable": true, "title": "Delete", "className": "col-xs-1",
                "render": function (data, type, row) {
                    return "<div class='pull-right' style='padding-right:10px;font-size:18px;'><a  id = 'clear-" + row[0] + "'  href='' class= 'set-alert'><i class='fa fa-times-circle' aria-hidden='true'></i></a></div>";
                }
            }
        ]
    });
    bindTableEvents(BannerTable);
}

function bindTableEvents(BannerTable) {
    $("#tblHomeBanner").on("click", ".set-alert", function (e) {
        $("#homeMessage").html("");
        e.preventDefault();
        var rowid = $(this).attr("id");

        var tour = rowid.split("-");

        BannerId = tour[1];
        var triparr = $.grep(BannerList, function (val, idx) {
            return BannerList[idx][0] == BannerId
        });

       
        $("#BannerName").html(triparr[0][1]);
            $("#deleteModal").modal("show");
       
    });
}

function DeleteBanner() {
    $.ajax({
        type: "POST",
        url: url + "/DeleteBanner",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ bannerid: BannerId }),
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {
                    getHomeBanner();
                    $("#SuccessStatus").text("Home Banner deleted  Successfully");
                    $("#modal-success").modal("show");
                }
            }
            else {
                $("#FailureStatus").text("Error while deleting home banner");
                $("#modal-danger").modal("show");
            }

        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while deleting home banner");
            $("#modal-danger").modal("show");
        }
    });
}