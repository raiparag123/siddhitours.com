var flag = "";
var url = "PopularDestination.aspx";
var DestinationList = [];
var destinationTable = null;
var placeList = [];
var popularId = "";
var fileExtension = ["jpg", "jpeg" ,"png"];
$(document).ready(function () {
    //url = window.location.href;
    $("#modaloverlay").hide();
    $("#title").text("Popular Destination Master");
    $("#btnEdit").hide();
    $("#btnCancel").hide();
    $("#btnSubmit").show();
    GetpopularDestination();
    getDestinationList();
    $("#btnSubmit").click(function (e) {
        $("#popDestMessage").html("");
        e.preventDefault();
        flag = "A";
        var ext = $("input[type='file']").val().split('.').pop().toLowerCase();
        if ($("#title-name").val().trim() == "") {
            $("#popDestMessage").html("Please Enter Title");
            return false;
        }

        if ($("#ddlLocation").val() == "0") {
            $("#popDestMessage").html("Please Select Location");
            return false;
        }

        if (jQuery.inArray(ext, fileExtension) == '-1') {
            $("#popDestMessage").html("select a valid file");
            return false;           
        }
        else {
            InsertDestination();
        }
        });

    $("#btnEdit").click(function (e) {
        $("#popDestMessage").html("");

        e.preventDefault();
        flag = "E";
        InsertDestination();
        $("#btnEdit").hide();
        $("#btnCancel").hide();
        $("#btnSubmit").show();
    });


    $("#btnCancel").click(function (e) {
        $("#popDestMessage").html("");
        e.preventDefault();
        bindDestinationPlace();
        $("#title-name").val('');
       
        $("#btnEdit").hide();
        $("#btnCancel").hide();
        $("#btnSubmit").show();
    });

    $("#btnConfirm").click(function (e) {
        $("#popDestMessage").html("");
        e.preventDefault();

        deletePlace();
        $("#deletePlace").modal("hide");
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

function getDestinationList() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: url + "/getDestinationPlace",

        // data: JSON.stringify({ LOCATION: Location, title:Title }),
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {

                var jsonObj = JSON.parse(msg.d);
                mapDestinationPlace(jsonObj);
                bindDestinationPlace();

            }
            else {

            }

        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function mapDestinationPlace(jsonobj) {
    placeList = $.map(jsonobj , function (el) {
        return {
            0: el.NAME
           
        }
    });
}

function bindDestinationPlace() {
    $("#ddlLocation").empty();
    var appendvalue = "";
    $("#ddlLocation").append("<option value=0>Select Location</option>")
    for (var i = 0; i < placeList.length - 1; i++) {
        appendvalue += "<option value=" + placeList[i][0] + ">" + placeList[i][0] + "</option>";
    }
    $("#ddlLocation").append(appendvalue);
}

function GetpopularDestination() {
     $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: url+"/getDestination",

       // data: JSON.stringify({ LOCATION: Location, title:Title }),
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                
                var jsonObj = JSON.parse(msg.d);
                MapDestination(jsonObj);
              
                
            }
            else {
                DestinationList = null;
            }
            bindDestination();
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function MapDestination(jsonObj) {
   
    DestinationList = $.map(jsonObj, function (el) {
        return {
            0: el.PPID,
            1: el.IMAGEID,
            2: el.LOCATIONID,
            3: el.TITLE,
            4: el.IMAGEPATH
        }
    });
}

function bindDestination() {
    if (destinationTable != null) {
        $("#tblDestination").empty();
    }
    destinationTable = $("#tblDestination").dataTable({
        "data": DestinationList,
        "bDestroy": true,
        "bPaginate": true,

        'autoWidth': false,
        //"aaSorting": [[1, "asc"]],
        searching: true,
        "columnDefs": [
            { "targets": [0], "searchable": false, "visible": false, "sortable": true, "title": "Popular id", "className": "col-xs-1" },
            { "targets": [1], "searchable": false, "visible": false, "sortable": false, "title": "Image id", "className": "col-xs-1" },
            { "targets": [2], "searchable": true, "sortable": true, "title": "Location", "className": "col-xs-1" },
            { "targets": [3], "searchable": true, "sortable": true, "title": "Title", "className": "col-xs-1" },
            {
                "targets": [4], "searchable": true, "sortable": false, "title": "Image", "className": "col-xs-1 text-center",
                render: function (data, type, row) {
                    return "<img src="+row[4]+" width=75% />"
                }
            },
            
            {
                "targets": [5], "searchable": false, "title": "Edit/Delete", "className": "col-xs-1",
                "render": function (data, type, row) {
                    return "<div class='pull-left'><a id = 'edit-" + row[0] + "' class='set-alert2' href=''><i class='fa fa-pencil-square' aria-hidden='true'></i></a></div><div class='pull-right' style='padding-right:10px;font-size:18px;'><a  id = 'clear-" + row[0] + "'  href='' class= 'set-alert2'><i class='fa fa-times-circle' aria-hidden='true'></i></a></div>";
                }
            }
        ]
    });
    bindTableEvents(destinationTable);
}

function bindTableEvents(destinationTable) {
    $("#tblDestination").on("click", ".set-alert2", function (e) {
        $("#popDestMessage").html("");
        e.preventDefault();
        var rowid = $(this).attr("id");

        var place = rowid.split("-");

        popularId = place[1];
        var cityarr = $.grep(DestinationList, function (val, idx) {
            return DestinationList[idx][0] == popularId
        });

        if (place[0] == "edit") {
            $("#ddlLocation option[value=" + cityarr[0][2] + "]").attr("selected", "selected");
            $("#title-name").val(cityarr[0][3]);
            $("#btnEdit").show();
            $("#btnSubmit").hide();
            $("#btnCancel").show();
           
        }
        else {
            $("#placename").val(cityarr[0][3]);
            $("#deletePlace").modal("show");
        }
    });
}
function InsertDestination() {
    showMainProcessing();
    $(".collapse").css("display", "block");
    move();
    var uploadfiles = $("input[type='file']").get(0);
    var Location = $("#ddlLocation option:selected").text();
    var Title = $("#title-name").val();
    var uploadedfiles = uploadfiles.files;
    var fromdata = new FormData();
    for (var i = 0; i < uploadedfiles.length; i++) {

        fromdata.append(uploadedfiles[i].name, uploadedfiles[i]);

    }

    // $.ajax({
    //    type: "POST",
    //    contentType: "application/json; charset=utf-8",
    //    url: "PopularDestination.aspx/InsertDestination",

    //    data: JSON.stringify({ LOCATION: Location, title:Title }),
    //    dataType: "json",
    //    success: function (msg) {
    //        if (msg.d != "") {
    //            if (msg.d == "1") {
    //                $("#txtTripType").val('');
    //                GetTripType();
    //            }
    //        }
    //        else {

    //        }

    //    },
    //    Error: function (x, e) {
    //        alert(msg.d);
    //    }
    //});


    $.ajax({
        type: "POST",
        contentType: false,
        processData: false,
        url: "PopularDestinationHandler.ashx?locationid=" + Location + "&Title=" + Title + "&Flag=" + flag + "&popularid=" + popularId,

        data: fromdata,
        dataType: "json",
        success: function (msg) {
            if (msg != "") {
                if (msg == 1) {
                    $("#title-name").val('');
                    bindDestinationPlace();
                    $("#myBar").css("width", "100%")
                    $(".collapse").css("display", "none");
                     $("#SuccessStatus").text("Popular Destination  inserted  Successfully");
                $("#modal-success").modal("show");
                GetpopularDestination();
                location.reload();  
                }
            }
            else {
                $("#myBar").css("width", "100%")
                $(".collapse").css("display", "none");
                $("#FailureStatus").text("Error while inserting popular destination");
                $("#modal-danger").modal("show");
            }
            hideMainProcessing();
        },
        Error: function (x, e) {
            $("#myBar").css("width", "100%")
            $(".collapse").css("display", "none");
            $("#FailureStatus").text("Error while inserting popular destination");
            $("#modal-danger").modal("show");
            hideMainProcessing();
        }


    });

}

function deletePlace() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: url + "/deletePlace",

        data: JSON.stringify({ popid: popularId}),
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {

                GetpopularDestination();
                $("#SuccessStatus").text("Popular Destination  deleted  Successfully");
                $("#modal-success").modal("show");
            }
            else {
                $("#FailureStatus").text("Error while deleting popular destination");
                $("#modal-danger").modal("show");
            }

        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while deleting popular destination");
            $("#modal-danger").modal("show");
        }
    });
}

function showMainProcessing() {

    $('#modaloverlay').show();

}
function hideMainProcessing() {
    $('#modaloverlay').hide();

}