var TripTypeArr = [];
var TripTypeTable = null;
var url = "";
var TripId = "";
var duplicate = [];
$(document).ready(function () {
    url = window.location.href;
    $("#title").text("Tour Category Master");
    GetTripType();
    $("#btnEdit").hide();
    $("#btnCancel").hide();
    $("#addSecurity").click(function (e) {
        $("#TourMessage").html("");
        e.preventDefault();
        $("#myModal").modal('show');
        $("#btnsubmit").show();
        $("#btnEdit").hide();
    });

    $("#btnsubmit").click(function (e) {
        $("#tripMessage").html("");
        e.preventDefault();
        var tripType = $("#txtTripType").val();
        if (tripType.trim() != "") {
            if (jQuery.inArray(tripType.toUpperCase().trim(), duplicate) != -1) {
                $("#tripMessage").html("Category already Exist");
            }
            else {
                InsertTripType(tripType.trim());
            }
        }
        else {
            $("#tripMessage").html("Please enter Trip Category");
        }
    });



    $("#btnEdit").click(function (e) {
        $("#TourMessage").html("");
        e.preventDefault();
        updateTripType();
        $("#myModal").modal('hide');
        $("#btnEdit").hide();
        $("#btnsubmit").show();
        $("#btnCancel").hide();

    });
    $("#btnCancel").click(function (e) {
        e.preventDefault();
        $("#txtTripType").val('');
        $("#btnEdit").hide();
        $("#btnsubmit").show();
        $("#btnCancel").hide();
    });

    $("#btnConfirm").click(function (e) {
        $("#TourMessage").html("");
        e.preventDefault();
        DeleteTripType();
        $("#deleteModal").modal('hide');

    });

});



function InsertTripType(triptype) {
    $.ajax({
        type: "POST",
        url: url + "/InsertTripType",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ Type: triptype.trim() }),
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {
                    $("#txtTripType").val('');
                    $("#SuccessStatus").text("Tour category inserted Successfully");
                    $("#modal-success").modal("show");
                    GetTripType();
                }
            }
            else {
                $("#FailureStatus").text("Error while inserting tour category");
                $("#modal-danger").modal("show");
            }

        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while inserting tour category");
            $("#modal-danger").modal("show");
        }
    });
}

function updateTripType() {
    $("#tripMessage").html("");
    var type_name = $("#txtTripType").val();

    if (type_name == "") {
        $("#tripMessage").html("Please enter trip type");
        return false;
    }

    $.ajax({
        type: "POST",
        url: url + "/UpdateTripType",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ Type: TripId, TripType: type_name.trim() }),
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {
                    $("#SuccessStatus").text("Tour category updated Successfully");
                    $("#modal-success").modal("show");
                    $("#txtTripType").val('');
                    GetTripType();
                }
            }
            else {
                $("#FailureStatus").text("Error while updating tour category");
                $("#modal-danger").modal("show");
            }

        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while updating tour category");
            $("#modal-danger").modal("show");
        }
    });
}

function DeleteTripType() {
    $.ajax({
        type: "POST",
        url: url + "/DeleteTripType",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ Type: TripId }),
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {
                    $("#SuccessStatus").text("Tour category deleted Successfully");
                    $("#modal-success").modal("show");
                    GetTripType();
                }
            }
            else {
                $("#FailureStatus").text("Error while deleting tour category");
                $("#modal-danger").modal("show");
            }

        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while deleting tour category");
            $("#modal-danger").modal("show");
        }
    });
}

function GetTripType() {
    $.ajax({
        type: "POST",
        url: url + "/GetTripType",
        contentType: "application/json; charset=utf-8",

        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
                mapTripType(jsonObj);
                
            }
            else {
                TripTypeArr = null;
            }
            bindTripType();
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}
function mapTripType(obj) {
    TripTypeArr = $.map(obj, function (el) {
        return {
            0: el.TYPEID,
            1: el.TYPENAME

        }
    });
    for (var i = 0; i <= TripTypeArr.length - 1; i++) {
        duplicate.push(TripTypeArr[i][1]);
    }
   
}

function bindTripType() {
    if (TripTypeTable != null) {
        TripTypeTable.fnDestroy();
        $("#tblTripType").empty();
    }
    TripTypeTable = $("#tblTripType").dataTable({
        "data": TripTypeArr,
        "bDestroy": true,
        "bPaginate": true,

        'autoWidth': false,
        //"aaSorting": [[1, "asc"]],
        searching: true,

        "columnDefs": [
            { "targets": [0], "searchable": false, "visible": false, "sortable": true, "title": "Type id", "className": "col-xs-1" },
            { "targets": [1], "searchable": true, "sortable": true, "title": "Trip Type", "className": "col-xs-1" },
            {
                "targets": [2], "searchable": true, "title": "Edit/Delete", "className": "col-xs-1",
                "render": function (data, type, row) {
                    return "<div class='pull-left'><a id = 'edit-" + row[0] + "' class='set-alert' href=''><i class='fa fa-pencil-square' aria-hidden='true'></i></a></div><div class='pull-right' style='padding-right:10px;font-size:18px;'><a  id = 'clear-" + row[0] + "'  href='' class= 'set-alert'><i class='fa fa-times-circle' aria-hidden='true'></i></a></div>";
                }
            }
        ]
    });
    bindTableEvents(TripTypeTable);
}

function bindTableEvents(TripTypeTable) {
    $("#tblTripType").on("click", ".set-alert", function (e) {
        $("#tripMessage").html("");

        e.preventDefault();
        var rowid = $(this).attr("id");

        var trip = rowid.split("-");

        TripId = trip[1];
        var triparr = $.grep(TripTypeArr, function (val, idx) {
            return TripTypeArr[idx][0] == TripId
        });

        if (trip[0] == "edit") {

            $("#txtTripType").val(triparr[0][1]);

            $("#btnsubmit").hide();
            $("#btnEdit").show();
            $("#btnCancel").show();
        }
        else {
            $("#tripName").html(triparr[0][1]);
            $("#deleteModal").modal("show");
        }
    });

}