var CompanyArr = [];
var CompanyTable = null;
var url = "";
var CompId = "";
var duplicate = [];
var fileExtension = ["jpg", "jpeg", "png"];

$(document).ready(function () {
    url = window.location.href;
    $("#title").text("Company Master");
    GetCompanyName();
    $("#btnEdit").hide();
    $("#btnCancel").hide();
    $("#addSecurity").click(function (e) {
        $("#CompanyMessage").html("");
        e.preventDefault();
        $("#myModal").modal('show');
        $("#btnsubmit").show();
        $("#btnEdit").hide();
    });

    $("#btnsubmit").click(function (e) {
        $("#CompanyMessage").html("");
        e.preventDefault();

        var uploadfiles = $("#pd-image").get(0);
        var uploadedfiles = uploadfiles.files;
        if (uploadedfiles.length < 1) {
            $("#CompanyMessage").html("Select a file to upload ");
            return false;
        }
        for (var i = 0; i < uploadedfiles.length; i++) {
            var ext = uploadedfiles[i].name.split('.').pop().toLowerCase();
            if (jQuery.inArray(ext, fileExtension) == '-1') {
                $("#CompanyMessage").html("Select a valid file");
                return false;
            }
        }
        
        var compName = $("#txtCompanyName").val();
        if (compName.trim() != "") {
            //if (jQuery.inArray(compName.toUpperCase(), duplicate) != -1) {
            //    $("#CompanyMessage").html("Category already Exist");
            //}
            //else {
                InsertCompanyName(compName);
            //}
        }
        else {
            $("#CompanyMessage").html("Please enter Company Name");
        }
    });



    $("#btnEdit").click(function (e) {
        $("#CompanyMessage").html("");
        e.preventDefault();
        updateCompanyName();
        $("#myModal").modal('hide');
        $("#btnEdit").hide();
        $("#btnsubmit").show();
        $("#btnCancel").hide();

    });
    $("#btnCancel").click(function (e) {
        e.preventDefault();
        $("#txtCompanyName").val('');
        $("#CompanyMessage").val('');
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

    $("#btnSuccessClose").click(function (e) {
        e.preventDefault();
        $("#CompanyMessage").val("");
        $("#txtCompanyName").val("");
    });

});

function InsertCompanyName(CompName) {
    $.ajax({
        type: "POST",
        url: url + "/InsertCompanyName",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ Name: CompName }),
        dataType: "json",
        success: function (msg) {
            debugger
            var data = JSON.parse(msg.d).split('_');
            //console.log(data);
            if (data != "") {
                if (data[0] == "1") {
                    CompId = data[1];
                    UploadCompanyImages();
                    $("#txtCompanyName").val('');
                    GetCompanyName();
                }
                else {
                    $("#CompanyMessage").html("Company name already Exist");
                }
            }
            else {
                $("#FailureStatus").text("Error while inserting Company name");
                $("#modal-danger").modal("show");
            }
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while inserting Company name");
            $("#modal-danger").modal("show");
        }
    });
}

function UploadCompanyImages() {
    debugger
    var uploadfiles = $("#pd-image").get(0);
    var uploadedfiles = uploadfiles.files;

    if (uploadedfiles.length > 0) {
        var fromdata = new FormData();
        for (var i = 0; i < uploadedfiles.length; i++) {

            fromdata.append(uploadedfiles[i].name, uploadedfiles[i]);
        }
        //$("#modaloverlay").show()
        //$(" .collapse").css("display", "block");

        //move();

        $.ajax({
            type: "POST",
            contentType: false,
            processData: false,
            url: "CompanyHandler.ashx?CompId=" + CompId,

            data: fromdata,
            dataType: "json",
            success: function (msg) {
                $("#modaloverlay").hide()
                $(" .collapse").css("display", "none");
                $("#SuccessStatus").text("Company name added Successfully");
                $("#modal-success").modal("show");
                $("#pd-image").val("");
            },
            Error: function (x, e) {
                $("#FailureStatus").text("Error while inserting cruise details");
                $("#modal-danger").modal("show");
            }
        });
    }
    else {
        $("#SuccessStatus").text("Company name added Successfully");
        $("#modal-success").modal("show");
    }
}

function GetCompanyName() {
    $.ajax({
        type: "POST",
        url: url + "/GetCompanyNames",
        contentType: "application/json; charset=utf-8",

        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
                mapCompany(jsonObj);
            }
            else {
                CompanyArr = null;
            }
            bindCompany();
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function updateCompanyName() {
    $("#CompanyMessage").html("");
    var Comp_name = $("#txtCompanyName").val();

    if (Comp_name == "") {
        $("#CompanyMessage").html("Please enter Company Name");
        return false;
    }
    if (Comp_name.trim() != "") {
        //if (jQuery.inArray(Comp_name.toUpperCase(), duplicate) != -1) {
        //    $("#CompanyMessage").html("Category already Exist");
        //}
        //else {
            $.ajax({
                type: "POST",
                url: url + "/UpdateComapanyName",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ CompId: CompId, Name: Comp_name }),
                dataType: "json",
                success: function (msg) {
                    if (msg.d != "") {
                        if (msg.d == "1") {
                            //$("#SuccessStatus").text("Company name updated Successfully");
                            //$("#modal-success").modal("show");
                            UploadCompanyImages();
                            $("#txtTripType").val('');
                            GetCompanyName();
                        }
                        else {
                            $("#CompanyMessage").html("Company name already Exist");
                        }
                    }
                    else {
                        $("#FailureStatus").text("Error while updating Company name");
                        $("#modal-danger").modal("show");
                    }

                },
                Error: function (x, e) {
                    $("#FailureStatus").text("Error while updating Company name");
                    $("#modal-danger").modal("show");
                }
            });
        //}
    }
    
}

function DeleteTripType() {
    $.ajax({
        type: "POST",
        url: url + "/DeleteTripType",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ CompId: CompId }),
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {
                    $("#SuccessStatus").text("Company name deleted Successfully");
                    $("#modal-success").modal("show");
                    GetCompanyName();
                }
            }
            else {
                $("#FailureStatus").text("Error while deleting company name");
                $("#modal-danger").modal("show");
            }
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while deleting company name");
            $("#modal-danger").modal("show");
        }
    });
}

function mapCompany(obj) {
    CompanyArr = $.map(obj, function (el) {
        return {
            0: el.CompanyId,
            1: el.NAME
        }
    });
    for (var i = 0; i <= CompanyArr.length - 1; i++) {
        duplicate.push(CompanyArr[i][1]);
    }

}

function bindCompany() {
    if (CompanyTable != null) {
        CompanyTable.fnDestroy();
        $("#tblCompany").empty();
    }
    CompanyTable = $("#tblCompany").dataTable({
        "data": CompanyArr,
        "bDestroy": true,
        "bPaginate": true,

        'autoWidth': false,
        //"aaSorting": [[1, "asc"]],
        searching: true,

        "columnDefs": [
            { "targets": [0], "searchable": false, "visible": false, "sortable": true, "title": "Company id", "className": "col-xs-1" },
            { "targets": [1], "searchable": true, "sortable": true, "title": "Company Name", "className": "col-xs-1" },
            {
                "targets": [2], "searchable": true, "title": "Edit/Delete", "className": "col-xs-1",
                "render": function (data, type, row) {
                    return "<div class='pull-left'><a id = 'edit-" + row[0] + "' class='set-alert' href=''><i class='fa fa-pencil-square' aria-hidden='true'></i></a></div><div class='pull-right' style='padding-right:10px;font-size:18px;'><a  id = 'clear-" + row[0] + "'  href='' class= 'set-alert'><i class='fa fa-times-circle' aria-hidden='true'></i></a></div>";
                }
            }
        ]
    });
    bindTableEvents(CompanyTable);
}

function bindTableEvents(CompanyTable) {
    $("#tblCompany").on("click", ".set-alert", function (e) {
        $("#CompanyMessage").html("");

        e.preventDefault();
        var rowid = $(this).attr("id");

        var trip = rowid.split("-");

        CompId = trip[1];
        var triparr = $.grep(CompanyArr, function (val, idx) {
            return CompanyArr[idx][0] == CompId
        });

        if (trip[0] == "edit") {

            $("#txtCompanyName").val(triparr[0][1]);

            $("#btnsubmit").hide();
            $("#btnEdit").show();
            $("#btnCancel").show();
        }
        else {
            $("#CompanyName").html(triparr[0][1]);
            $("#deleteModal").modal("show");
        }
    });

}