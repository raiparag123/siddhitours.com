var url = "trending.aspx";
var tripList = [];
var trendList = [];
var grplist=[];
var trendTable = null;
var trendid = "";
var dupId = 0;
var dupSeq = 0;
$(document).ready(function () {
    $("#title").text("Trending Master");
    getTourPackage();
    getTrending();
    $("#TrenMessage").html("");
    $("#btnUpdate").hide();
    $("#btnSubmit").show();
    $("#btnSubmit").click(function (e) {
        e.preventDefault();
        $("#TrenMessage").html("");
        //getTrending();
        var trend = $("#ddltrend option:selected").val();
        var grp = $("#txtgrp").val();
      //  var package = $("#ddlpackage").val();
        var selMulti = $.map($("#ddlpackage option:selected"), function (el, i) {
            return $(el).text();
        });

        var package =  selMulti.join(",");

        var duplicateSeq = $.grep(trendList, function (val, idx) {
            return trendList[idx][1] == trend 
        });
        var duplicateGrp = $.grep(trendList, function (val, idx) {
            return trendList[idx][2] == grp 
        });
        if (trend == "0") {
            $("#TrenMessage").html("Please select Trending sequence");
            return false;
        }
        else if (grp == "") {
            $("#TrenMessage").html("Please enter group name");
            return false;
        }
        else if (package == "0") {
            $("#TrenMessage").html("Please select the package");
            return false;
        }
        else if (duplicateSeq.length > 0) {
            $("#TrenMessage").html("Sequence already exist");
            return false;


        }
        else if (duplicateGrp.length > 0) {
            $("#TrenMessage").html("Group already exist");
            return false;
        }
        else {
            SubmitData();
        }
    });

    $("#btnconfirm").click(function (e) {
        e.preventDefault();
        DeleteTrend();
    });

    $("#btnUpdate").click(function (e) {
        e.preventDefault();
        $("#TrenMessage").html("");
        var trend = $("#ddltrend option:selected").val();
        var grp = $("#txtgrp").val();
        var selMulti = $.map($("#ddlpackage option:selected"), function (el, i) {
            return $(el).text();
        });

        var package =  selMulti.join(",");
        var duplicateSeq = $.grep(trendList, function (val, idx) {
            return trendList[idx][1] == trend && trendList[idx][0] != trendid
        });
        var duplicateGrp = $.grep(trendList, function (val, idx) {
            return trendList[idx][2] == grp.toUpperCase() && trendList[idx][0] != trendid
        });
        if (trend == "0") {
            $("#TrenMessage").html("Please select Trending sequence");
            return false;
        }
        else if (grp == "") {
            $("#TrenMessage").html("Please enter group name");
            return false;
        }
        else if (package == "0") {
            $("#TrenMessage").html("Please select the package");
            return false;
        }
        
        else if (duplicateSeq.length > 0) {
            dupId = duplicateSeq[0][0];
            dupSeq = duplicateSeq[0][1];
            $("#updateModal").modal('show');


        }
        else if (duplicateGrp.length > 0) {
            $("#TrenMessage").html("Group already exist");
            return false;
        }
        else {
            updateTrend();
        }

    })

    $("#btnupdateConfirm").click(function (e) {
        e.preventDefault();
        updateTrend();
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


function SubmitData() {
    var trend = $("#ddltrend option:selected").val();
    var grp = $("#txtgrp").val();
    var selMulti = $.map($("#ddlpackage option:selected"), function (el, i) {
        return $(el).text();
    });

    var package =  selMulti.join(",");

    $.ajax({
        type: "POST",
        url: url + "/InsertTrending",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ Trend: trend, group: grp, Package: package }),
        success: function (msg) {
            if (msg.d != "") {
                $("#ddltrend").selectpicker('refresh');
                $("#ddltrend").selectpicker('val','0');
                $("#txtgrp").val('');

                $("#ddlpackage").selectpicker('refresh');
                $("#ddlpackage").selectpicker('val', '0');
                $("#SuccessStatus").text("Trending data inserted  Successfully");
                $("#modal-success").modal("show");
                getTrending();

            }
            else {
                $("#FailureStatus").text("Error while inserting trending data");
                $("#modal-danger").modal("show");
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function updateTrend() {
    var trend = $("#ddltrend option:selected").val();
    var grp = $("#txtgrp").val();
    var selMulti = $.map($("#ddlpackage option:selected"), function (el, i) {
        return $(el).text();
    });

    var package =  selMulti.join(",");

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: url + "/UpdateTrend",

        data: JSON.stringify({ Trend: trend, Grp: grp, Package: package, Trendid: trendid, OldId: dupId, oldseq: dupSeq }),
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {

                $("#SuccessStatus").text("Trending data updated  Successfully");
                $("#modal-success").modal("show");
                $("#ddltrend").selectpicker('refresh');
                $("#ddltrend").selectpicker('val', '0');
                $("#txtgrp").val('');

                $("#ddlpackage").selectpicker('refresh');
                $("#ddlpackage").selectpicker('val', '0');
                $("#btnUpdate").hide();
                $("#btnSubmit").show();
                getTrending();

            }
            else {
                $('#ddlTourPackage').append("<option value=0>Select</option>")
                $("#FailureStatus").text("Error while inserting trending data");
                $("#modal-danger").modal("show");
            }

        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while inserting trending data");
            $("#modal-danger").modal("show");
        }
    });

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
            alert(msg.d);
        }
    });
}


function getTrending() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: url + "/getTrending",

        // data: JSON.stringify({ LOCATION: Location, title:Title }),
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {

                var jsonObj = JSON.parse(msg.d);
                mapTrending(jsonObj);
                

            }
            else {
                trendList = [];
            }
            bindTrending();
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}



function mapTrending(jsonobj) {
    trendList = $.map(jsonobj, function (el) {
        return {
            0: el.TRENDINGID,
            1: el.SEQUENCEID,
            2: el.GROUPNAME,
            3:el.PACKAGES

        }
    });


   
}

function bindTrending() {
    trendTable = $("#tbltrend").dataTable({
        "data": trendList,
        "bDestroy": true,
        "bPaginate": true,

        'autoWidth': false,
        //"aaSorting": [[1, "asc"]],
        searching: true,

        "columnDefs": [
            { "targets": [0], "searchable": false, "visible": false, "sortable": true, "title": "Banner id", "className": "col-xs-1" },
            { "targets": [1], "searchable": true, "sortable": true, "title": "Sequence id", "className": "col-xs-1" },
            { "targets": [2], "searchable": true, "sortable": true, "title": "Group name", "className": "col-xs-1" },
            { "targets": [3], "searchable": true, "sortable": true, "title": "Package", "className": "col-xs-1" },
            {
                "targets": [4], "searchable": true, "title": "Delete", "className": "col-xs-1",
                "render": function (data, type, row) {
                    return "<div class='pull-left'><a id = 'edit-" + row[0] + "' class='set-alert' href=''><i class='fa fa-pencil-square' aria-hidden='true'></i></a></div><div class='pull-right' style='padding-right:10px;font-size:18px;'><a  id = 'clear-" + row[0] + "'  href='' class= 'set-alert'><i class='fa fa-times-circle' aria-hidden='true'></i></a></div>";
                }
            }
        ]
    });
    bindTableEvents(trendTable);
}

function mapTourList(jsonobj) {
    tripList = $.map(jsonobj, function (el) {
        return {
            0: el.TRIPID,
            1: el.TITLE

        }
    });
}

function bindTour() {
    $('#ddlpackage').empty();
    var appendvalue = "";
    for (var i = 0; i <= tripList.length - 1; i++) {
        appendvalue += "<option value=" + tripList[i][1] + ">" + tripList[i][1] + "</option>";
    }
    $('#ddlpackage').append("<option value=0>Select</option>")
    $('#ddlpackage').append(appendvalue);
    $('#ddlpackage').selectpicker('refresh');



}

function bindTableEvents(trendTable) {
    $("#tbltrend").on("click", ".set-alert", function (e) {
        e.preventDefault();
        var rowid = $(this).attr("id");

        var tour = rowid.split("-");
        dupSeq = 0;
        dupSeq = 0;
        trendid = tour[1];
        var triparr = $.grep(trendList, function (val, idx) {
            return trendList[idx][0] == trendid
        });
        if (tour[0] == "edit") {
            $("#ddltrend").selectpicker('refresh');
           // $("#ddltrend option:selected").val(triparr[0][1]);
            $("#ddltrend").selectpicker('val', triparr[0][1]);
            $("#txtgrp").val(triparr[0][2]);
            $("#ddlpackage").selectpicker('refresh');
            $("#ddlpackage").selectpicker('val', "["+triparr[0][3]+"]");
            $("#btnSubmit").hide();
            $("#btnUpdate").show();
        }
        else {
            $("#trend").text(triparr[0][2])
            $("#deleteModal").modal("show");
        }

    });
}

    function DeleteTrend() {
        $.ajax({
            type: "POST",
            url: url + "/DeleteTrend",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ Trendid: trendid }),
            dataType: "json",
            success: function (msg) {
                if (msg.d != "") {
                    if (msg.d == "1") {
                        $("#SuccessStatus").text("Trending data deleted  Successfully");
                        $("#modal-success").modal("show");
                        getTrending();
                    }
                }
                else {
                    $("#FailureStatus").text("Error while deleting trending data");
                    $("#modal-danger").modal("show");
                }

            },
            Error: function (x, e) {
                alert(msg.d);
            }
        });

}