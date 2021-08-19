var tourid = "";
var ItenaryId = "";
var itenarylist = [];
var itenaryTable = null;
var day = "";
var duplicatelist = [];
var Url = "ItenaryMaster.aspx";
var flag = "";
var queryFlag = "";
var days;
var editdropdown = [];
var fileExtension = ["jpg", "jpeg", "png"];
$(document).ready(function () {
    $("#modaloverlay").hide();
    $("#tripMessage").html("");
    $("#title").text("Itenary Detail Master");
    tourid = GetParameterValues("Tourid");
    queryFlag = GetParameterValues("Flag");
    days = GetParameterValues("Days");
    getItenaryImages();
    ItenaryId = GetParameterValues("Itenaryid");
    $("#btnSubmit").hide();
    $("#btnUpdate").hide();


    if (tourid != undefined && days != undefined && queryFlag=="A") {
        $("#daydiv").show();
        //bindDaysDropdown();
        $("#btnSubmit").show();
        $("#btnUpdate").hide();
    }
    else {
        $("#daydiv").hide();
        $("#btnSubmit").hide();
        $("#btnUpdate").show();
    }
    //else if (tourid != undefined && ItenaryId != undefined) {

    //    $("#btnSubmit").hide();
    //    $("#btnUpdate").show();
    //    $("#daydiv").hide();
       
    //    var triparr = $.grep(itenarylist, function (val, idx) {
    //        return itenarylist[idx][0] == ItenaryId
    //    });
    //    $("#detail").val(triparr[0][2]);

    //}
    $("#btnSubmit").click(function (e) {
        $("#tripMessage").html("");
        e.preventDefault();
        InsertData();
    });

    $("#btnUpdate").click(function (e) {
        $("#tripMessage").html("");
        e.preventDefault();
        UpdateData();
    });
    

    $("#btnConfirm").click(function (e) {
        e.preventDefault();
        // ValidateDataTab1();
        DeleteTrip();

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

function fillData() {
    if (tourid != undefined && ItenaryId != undefined && queryFlag.toUpperCase() == "U") {

        //$("#btnSubmit").hide();
        //$("#btnUpdate").show();
        //$("#daydiv").hide();

        var triparr = $.grep(itenarylist, function (val, idx) {
            return itenarylist[idx][0] == ItenaryId
        });
        if (triparr.length > 0) {
            $("#detail").val(triparr[0][2]);
        }
    }
}

function GetParameterValues(param) {
    var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for (var i = 0; i < url.length; i++) {
        var urlparam = url[i].split('=');
        if (urlparam[0] == param) {
            return urlparam[1];
        }
    }
}  

function InsertData() {
    flag = "A";
    var day = $("#ddlDay option:selected").val().trim();
    var detail = $("#detail").val().trim();
    var file = $("#day-image").val().trim();
    if (day == "0") {
        $("#tripMessage").html("Please Select Itenary Day");
        return false;
    }
    else if (jQuery.inArray(day, editdropdown) != -1) {
        $("#tripMessage").html("Itenary already exist fot the day");
    }
    else if (detail == "") {
        $("#tripMessage").html("Please Enter Itenary Detail");
        return false;
    }
    else if (file == "") {
        $("#tripMessage").html("Please select the file");
    }
    else {
        var fileupload = $("#day-image").get(0);
        var uploadedfiles = fileupload.files;

        for (var i = 0; i < uploadedfiles.length; i++) {

            var ext = uploadedfiles[i].name.split('.').pop().toLowerCase();
            if (jQuery.inArray(ext, fileExtension) == '-1') {
                $("#tripMessage").html("select a valid file");
                return false;

            }

        }


        var fromdata = new FormData();
        for (var i = 0; i < uploadedfiles.length; i++) {

            fromdata.append(uploadedfiles[i].name, uploadedfiles[i]);

        }

        showMainProcessing();
        $(".collapse").css("display", "block");
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            url: Url+"/InsertData",

            data: JSON.stringify({ TourId: tourid, Detail: detail, Day: day }),
          
            success: function (msg) {
                if (msg != "") {
                    var jsonobj = msg.d.split("_");
                    if (jsonobj[0] == "1") {
                        ItenaryId = jsonobj[1];
                        UploadImage();
                    }
                }
                else {

                }

            },
            Error: function (x, e) {
                alert(msg.d);
            }
        });
        
    }
}

function UpdateData() {
    flag = "E";
    var detail = $("#detail").val();
    var file = $("#day-image").val();
    var valid = false;
    if (day == "0") {
        $("#tripMessage").html("Please Select Itenary Day");
        return false;
    }
    else {
        valid = true;
    }
    if (detail == "") {
        $("#tripMessage").html("Please Enter Itenary Detail");
        return false;
    }
    else if (file != "") {
        var fileupload = $("#day-image").get(0);
        var uploadedfiles = fileupload.files;

        for (var i = 0; i < uploadedfiles.length; i++) {

            var ext = uploadedfiles[i].name.split('.').pop().toLowerCase();
            if (jQuery.inArray(ext, fileExtension) == '-1') {
                alert("select a valid file");
                return false;

            }

        }

    }
    else {
        valid = true;
    }

    if (valid == true) {
        showMainProcessing();
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            url: Url + "/UpdateData",

            data: JSON.stringify({ itenaryid: ItenaryId, Detail: detail }),

            success: function (msg) {
                if (msg != "") {
                    var jsonobj = msg.d;

                    UploadImage();

                }
                else {

                }

            },
            Error: function (x, e) {
                alert(msg.d);
            }
        });
    }
    

}

function UploadImage() {
    var uploadfiles = $("#day-image").get(0);
    
    var uploadedfiles = uploadfiles.files;
    var fromdata = new FormData();
    for (var i = 0; i < uploadedfiles.length; i++) {

        fromdata.append(uploadedfiles[i].name, uploadedfiles[i]);

    }
    $(".collapse").css("display", "block");
    move();

    $.ajax({
        type: "POST",
        contentType: false,
        processData: false,
        url: "ItenaryImage.ashx?ItnenaryId=" + ItenaryId,

        data: fromdata,
        dataType: "json",
        success: function (msg) {
            if (msg != -1) {
                if (msg == 1 || msg == 0) {
                    $("#myBar").css("width","100%")
                    $(".collapse").css("display", "none");
                    $("#detail").empty();
                    $("#ddlDay option:selected").val("0");
                    $("#SuccessStatus").text("Itenary  inserted  Successfully");
                    $("#modal-success").modal("show");
                    //if (flag == "E") {
                    //    window.location.href = "/adminPages/ItenaryMaster.aspx?Tourid=" + tourid;
                    //}
                    var $el = $('#day-image');
                    $el.wrap('<form>').closest('form').get(0).reset();
                    $el.unwrap();
                    getItenaryImages();
                    if (queryFlag.toUpperCase() == "A" || queryFlag.toUpperCase() == "E") {
                        if (queryFlag.toUpperCase() == "A" || queryFlag.toUpperCase() == "E") {
                            var length = itenarylist.length + 1;
                            if (length == days) {
                                window.location.href = "tripMaster.aspx"
                            }
                        }
                        else {
                            location.reload();
                        }
                       
                    }
                    hideMainProcessing();
                      
                     
                }
             
            }
            else {
                $("#myBar").style("width", "100%")
                hideMainProcessing();
                $("#FailureStatus").text("Error while inserting itenary detail");
                $("#modal-danger").modal("show");
                location.reload();
            }
        
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while inserting itenary detail");
            $("#modal-danger").modal("show");
        }
    });
}

function getItenaryImages() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        url: Url+"/GetItenaryData",

        data: JSON.stringify({ TourId: tourid }),

        success: function (msg) {
            if (msg.d != "") {
                var obj = JSON.parse(msg.d);
                mapItenary(obj);
                if (days != undefined) {
                    setTimeout( bindDaysDropdown(),1000);
                }
            }
            else {

            }
            bindItenary();

        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function mapItenary(obj) {
    itenarylist = $.map(obj.Table, function (el) {
        return {
            0: el.ITENARYID,
            1: el.DAY,
            2: el.DAYDETAIL,
            3: el.IMAGEPATH,
            4: el.TOURID


        }
        
    });
    if (itenarylist.length > 0) {
        for (var i = 0; i <= itenarylist.length - 1; i++) {
            editdropdown.push(itenarylist[i][1]);
        }
    }

    
}
function bindItenary() {

    setTimeout(fillData(), 2000);

    itenaryTable = $("#tblTripMaster").dataTable({
        "data": itenarylist,
        "bDestroy": true,
        "bPaginate": true,

        'autoWidth': false,
        //"aaSorting": [[1, "asc"]],
        searching: true,
        "columnDefs": [
            { "targets": [0], "searchable": false, "visible": false, "sortable": true, "title": "itenary id", "className": "col-xs-1" },
            { "targets": [1], "searchable": true, "visible": true, "sortable": false, "title": "Day", "className": "col-xs-1 text-center" },
            { "targets": [2], "searchable": true, "visible": false,"type":"image","sortable": true, "title": "Detail" },
           
            {
                "targets": [3], "searchable": true, "sortable": false, "title": "Image",
                render: function (data, type, row) {
                    return "<img src=" + row[3] + " width=20% />"
                }
            },

            {
                "targets": [4], "searchable": false, "title": "Edit/Delete", "className": "col-xs-1",
                "render": function (data, type, row) {
                    return "<div class='pull-left'><a id = 'edit-" + row[0] + "' class='set-alert2' href=''><i class='fa fa-pencil-square' aria-hidden='true'></i></a></div><div class='pull-right' style='padding-right:10px;font-size:18px;'><a  id = 'clear-" + row[0] + "'  href='' class= 'set-alert2'><i class='fa fa-times-circle' aria-hidden='true'></i></a></div>";
                }
            }
        ]
    });
    bindTableEvents(itenaryTable)
}

function bindTableEvents(TripMasterTable) {
    $("#tblTripMaster").on("click",".set-alert2", function (e) {
        e.preventDefault();
        var rowid = $(this).attr("id");

        var trip = rowid.split("-");

        ItenaryId = trip[1];
        var triparr = $.grep(itenarylist, function (val, idx) {
            return itenarylist[idx][0] == ItenaryId
        });

        tourid = triparr[0][4];
        day = triparr[0][1];

        if (trip[0] == "edit") {

            window.location.href = "/adminPages/itenaryMaster.aspx?Tourid=" + tourid + "&Itenaryid=" + ItenaryId+"&Flag=U";
           


        }
        else {
            $("#tripname").text(triparr[0][1]);
            $("#deleteTrip").modal("show");
        }
    });
}


function DeleteTrip() {
    $.ajax({
        type: "POST",
        url: Url + "/DeleteTrip",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ ItenaryID:ItenaryId }),
        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                $("#SuccessStatus").text("Itenary  deleted  Successfully");
                $("#modal-success").modal("show");
                getItenaryImages();

            }
            else {
                $("#FailureStatus").text("Error while deleting itenary detail");
                $("#modal-danger").modal("show");
            }
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while deleting itenary detail");
            $("#modal-danger").modal("show");
        }
    });
}


function bindDaysDropdown() {
    
    var appendvalue = "";
    $("#ddlDay").empty();
    $("#ddlDay").append("<option value=0>Select</option>");
    //if (queryFlag.toUpperCase() == "E" || queryFlag.toUpperCase() == "U") {
        for (var j = 1; j <= days; j++) {
            if (jQuery.inArray(j, editdropdown) == -1) {
                appendvalue += "<option value=" + j + ">" + j + "</option>";
            }
        }
   // }
        //for (var i = 1; i <= days; i++) {
        //    appendvalue += "<option value=" + i + ">" + i + "</option>";
        //}
        if (appendvalue == "") {
            $("#daydiv").hide();
            $("#btnUpdate").show();
            $("#btnSubmit").hide();
        }
        else {
            $("#daydiv").show();
            $("#btnUpdate").hide();
            $("#btnSubmit").show();
        }
  //  }
   // else {
   // for (var i = 1; i <= days; i++) {
            //appendvalue += "<option value=" + i + ">" + i + "</option>";
   //     }
    //}
    $("#ddlDay").append(appendvalue);
}
function showMainProcessing() {

    $('#modaloverlay').show();

}
function hideMainProcessing() {
    $('#modaloverlay').hide();

}