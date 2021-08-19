var url = "";
var PortArr = [];
var PortTable = null;
var PortId = 0;

$(document).ready(function () {
    $("#title").text("Port Master");
    url = window.location.href;
    $("#btnEdit").hide();
    $("#btnCancel").hide();
    GetPortNames();

    $("#btnsubmit").click(function (e) {
        e.preventDefault();
        $("#PortMessage").html("");

        var portName = $("#txtPortName").val();
        if (portName.trim() != "") {
            InsertPortName(portName);
        }
        else {
            $("#PortMessage").html("Please enter Port Name");
            return false;
        }
    });

    $("#btnEdit").click(function (e) {
        $("#PortMessage").html("");
        e.preventDefault();
        updatePortName();
        $("#btnEdit").hide();
        $("#btnsubmit").show();
        $("#btnCancel").hide();
    });

    $("#btnCancel").click(function (e) {
        e.preventDefault();
        $("#txtPortName").val('');
        $("#PortMessage").val('');
        $("#btnEdit").hide();
        $("#btnsubmit").show();
        $("#btnCancel").hide();
    });

    $("#btnConfirm").click(function (e) {
        $("#PortMessage").html("");
        e.preventDefault();
        DeletePort();
        $("#deleteModal").modal('hide');

    });
});



function InsertPortName(portName) {
    $.ajax({
        type: "POST",
        url: url + "/InsertPortName",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ Name: portName }),
        dataType: "json",
        success: function (msg) {
            var data = JSON.parse(msg.d);
            console.log(data);
            if (data != "") {
                if (data == "1") {
                    $("#txtPortName").val('');
                    GetPortNames();
                    $("#SuccessStatus").text("Port name added Successfully");
                    $("#modal-success").modal("show");
                }
                else {
                    $("#PortMessage").html("Port name already Exist");
                }
            }
            else {
                $("#FailureStatus").text("Error while inserting Port name");
                $("#modal-danger").modal("show");
            }
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while inserting Port name");
            $("#modal-danger").modal("show");
        }
    });
}

function GetPortNames() {
    $.ajax({
        type: "POST",
        url: url + "/GetPortNames",
        contentType: "application/json; charset=utf-8",

        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
                mapPort(jsonObj);
            }
            else {
                PortArr = null;
            }
            bindPort();
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function mapPort(obj) {
    PortArr = $.map(obj, function (el) {
        return {
            0: el.PortId,
            1: el.NAME
        }
    });
}

function bindPort() {
    if (PortTable != null) {
        PortTable.fnDestroy();
        $("#tblPort").empty();
    }
    PortTable = $("#tblPort").dataTable({
        "data": PortArr,
        "bDestroy": true,
        "bPaginate": true,

        'autoWidth': false,
        //"aaSorting": [[1, "asc"]],
        searching: true,

        "columnDefs": [
            { "targets": [0], "searchable": false, "visible": false, "sortable": true, "title": "Port id", "className": "col-xs-1" },
            { "targets": [1], "searchable": true, "sortable": true, "title": "Port Name", "className": "col-xs-1" },
            {
                "targets": [2], "searchable": true, "title": "Edit/Delete", "className": "col-xs-1",
                "render": function (data, type, row) {
                    return "<div class='pull-left'><a id = 'edit-" + row[0] + "' class='set-alert' href=''><i class='fa fa-pencil-square' aria-hidden='true'></i></a></div><div class='pull-right' style='padding-right:10px;font-size:18px;'><a  id = 'clear-" + row[0] + "'  href='' class= 'set-alert'><i class='fa fa-times-circle' aria-hidden='true'></i></a></div>";
                }
            }
        ]
    });
    bindTableEvents(PortTable);
}

function bindTableEvents(PortTable) {
    $("#tblPort").on("click", ".set-alert", function (e) {
        $("#PortMessage").html("");

        e.preventDefault();
        var rowid = $(this).attr("id");

        var trip = rowid.split("-");

        PortId = trip[1];
        var triparr = $.grep(PortArr, function (val, idx) {
            return PortArr[idx][0] == PortId
        });

        if (trip[0] == "edit") {

            $("#txtPortName").val(triparr[0][1]);

            $("#btnsubmit").hide();
            $("#btnEdit").show();
            $("#btnCancel").show();
        }
        else {
            $("#PortName").html(triparr[0][1]);
            $("#deleteModal").modal("show");
        }
    });

}

function updatePortName() {
    $("#PortMessage").html("");
    var Comp_name = $("#txtPortName").val();

    if (Comp_name == "") {
        $("#PortMessage").html("Please enter Port Name");
        return false;
    }
    if (Comp_name.trim() != "") {
        $.ajax({
            type: "POST",
            url: url + "/UpdatePortName",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ PortId: PortId, Name: Comp_name }),
            dataType: "json",
            success: function (msg) {
                if (msg.d != "") {
                    if (msg.d == "1") {
                        $("#SuccessStatus").text("Port name updated Successfully");
                        $("#modal-success").modal("show");
                        $("#txtPortName").val('');
                        GetPortNames();
                    }
                    else {
                        $("#PortMessage").html("Port name already Exist");
                    }
                }
                else {
                    $("#FailureStatus").text("Error while updating Port name");
                    $("#modal-danger").modal("show");
                }

            },
            Error: function (x, e) {
                $("#FailureStatus").text("Error while updating Port name");
                $("#modal-danger").modal("show");
            }
        });
    }
}

function DeletePort() {
    $.ajax({
        type: "POST",
        url: url + "/DeletePort",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ PortId: PortId }),
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {
                    $("#SuccessStatus").text("Port name deleted Successfully");
                    $("#modal-success").modal("show");
                    GetPortNames();
                }
            }
            else {
                $("#FailureStatus").text("Error while deleting Port name");
                $("#modal-danger").modal("show");
            }
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while deleting Port name");
            $("#modal-danger").modal("show");
        }
    });
}