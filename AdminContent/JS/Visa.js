var CountryList = [];
var VisaList = [];
var VisaTable = null;
var Visaid = "";
var fileExtension = ["jpg", "jpeg", "png"];
var url = "visa.aspx";

$(document).ready(function () {
    //url = window.location.href;
    $("#modaloverlay").hide();
    $("#visamessage").html("");
    Visaid = GetParameterValues("visaid");
    if (Visaid != undefined) {
        $("#btnVisa").hide();
        $("#btnEditVisa").show();
        $("#btnCancelVisa").show();

    }
    else {
        $("#btnVisa").show();
        $("#btnEditVisa").hide();
        $("#btnCancelVisa").hide();
    }
    getCountryList();
    getVisaList();
    $("#title").text("Visa");
    //$('.textarea').wysihtml5();

    

    $("#btnVisa").click(function (e) {
        e.preventDefault();
        InsertVisa();
    });

    $("#btnEditVisa").click(function () {
        e.preventDefault();
        EditVisa();
    });
    
    $("#close").click(function () {
        e.preventDefault();
        window.location.href = "visa.aspx";
    });

    $("#btnConfirmVisa").click(function (e) {
        e.preventDefault();
        DeleteVisa();
    });


    $("#btnCancelVisa").click(function (e) {
        e.preventDefault();
        window.location.href = "visa.aspx";
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

function GetParameterValues(param) {
    var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for (var i = 0; i < url.length; i++) {
        var urlparam = url[i].split('=');
        if (urlparam[0] == param) {
            return urlparam[1];
        }
    }
}  



function getCountryList() {
    $.ajax({
        type: "POST",
        url: url + "/getCountryList",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                mapCountryList(jsonobj);
                bindCountryDropdown();
            }
            else {
                CountryList = null;
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function mapCountryList(jsonobj) {
    CountryList = $.map(jsonobj, function (el) {
        return {
            0: el.COUNTRYID,
            1: el.COUNTRYNAME
        }
    });
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
function bindCountryDropdown() {
    var appendvalue = "";
    $("#ddlCountry").empty();
    $("#ddlCountry").append("<option value=0>Select Country</option>");
    for (var i = 0; i <= CountryList.length - 1; i++) {
        appendvalue += "<option value=" + CountryList[i][0] + ">" + CountryList[i][1] + "</option>";
    }
    $("#ddlCountry").append(appendvalue);
    if (Visaid != undefined) {
        $("#ddlCountry option:selected").val()
    }
}

function InsertVisa() {
    

    var CountryId = $("#ddlCountry option:selected").val();
    if (CountryId == "0") {
        $("#visamessage").html("Please select the country");
        return false;
    }
    var cost = $("#cost").val();
    if (cost.trim() == "") {
        $("#visamessage").html("Please enter cost");
        return false;
    }
    else if (cost.trim() <= 0) {
        $("#visamessage").html("Please enter cost greater than Zero");
        return false;
    }
   

    var DocReq = $("#ContentPlaceHolder1_DocReq").val();
    var ext = $("input[type='file']").val().split('.').pop().toLowerCase();
    
    if (DocReq == "") {
        $("#visamessage").html("Please enter document required");
        return false;
    }
    else if (jQuery.inArray(ext, fileExtension) == '-1') {
        $("#visamessage").html("Select a valid file");
        return false;
    }

    $(".collapse").css("display", "block");
    move();
    showMainProcessing();

    $.ajax({
        type: "POST",
        url: url + "/InsertVisa",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ CountryId: CountryId, Cost: cost, DocReq: DocReq }),

        success: function (msg) {
            
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
              
                var Id = msg.d;
                console.log(Id);
                UploadFile(Id);
                getVisaList();
            }
            else {
                CountryList = null;
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function UploadFile(Id) {
    var uploadfiles = $('#UploadDoc').get(0);
    var uploadedfiles = uploadfiles.files;
    var fromdata = new FormData();
    for (var i = 0; i < uploadedfiles.length; i++) {
        fromdata.append(uploadedfiles[i].name, uploadedfiles[i]);
    }

    $.ajax({
        type: "POST",
        contentType: false,
        processData: false,
        url: "VisaHandler.ashx?VisaId=" + Id,
        data: fromdata,
        dataType: "json",
        success: function (msg) {
            if (msg != "") {
                $("#myBar").css("width", "100%")
                $(".collapse").css("display", "none");
                if (msg == 1) {
                    $("#SuccessStatus").text("Visa Data  inserted  Successfully");
                    $("#modal-success").modal("show");
                    window.location.href = "visa.aspx";
                    getVisaList();
                }
                else {
                    $("#FailureStatus").text("Error while inserting visa data");
                    $("#modal-danger").modal("show");
                }
            }
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while inserting visa data");
            $("#modal-danger").modal("show");
        }
    });

}

function EditVisa() {
    var CountryId = $("#ddlCountry option:selected").val();
    if (CountryId == "0") {
        $("#visamessage").html("Please select the country");
        return false;
    }
    var cost = $("#cost").val();
    if (cost.trim() == "") {
        $("#visamessage").html("Please enter cost");
        return false;
    }
    else if (cost.trim() <= 0) {
        $("#visamessage").html("Please enter cost greater than Zero");
        return false;
    }


    var DocReq = $("#ContentPlaceHolder1_DocReq").val();
    var ext = $("input[type='file']").val().split('.').pop().toLowerCase();
    if (jQuery.inArray(ext, fileExtension) == '-1') {
        $("#visamessage").html("Select a valid file");
        return false;
    }

    $.ajax({
        type: "POST",
        url: url + "/UpdateVisa",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ CountryId: CountryId, Cost: cost, DocReq: DocReq, VisaId: Visaid }),

        success: function (msg) {
            debugger
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                var Id = msg.d;
                console.log(Id);
                UploadFile(Id);
                getVisaList();
            }
            
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function getVisaList() {
    $.ajax({
        type: "POST",
        url: url + "/GetVisaList",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                mapVisaList(jsonobj);
               
            }
            else {
                VisaList = null;
            }
            BindVisaList();
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function mapVisaList(jsonobj) {
    VisaList = $.map(jsonobj, function (el) {
        return {
            0: el.VisaId,
            1: el.CountryId,
            2: el.CountryName,
            3: el.Cost,
            4: el.DocumentRequirment
        }
    });
}

function BindVisaList() {

    if (VisaTable != null) {
        VisaTable.fnDestroy();
        $("#tblVisa").empty();
    }

    VisaTable = $("#tblVisa").dataTable({
        "data": VisaList,
        "bDestroy": true,
        "bPaginate": true,
        'autoWidth': false,
        searching: true,
        "columnDefs": [
            { "targets": [0], "searchable": false, "visible": false, "sortable": true, "title": "Visa id", "className": "col-xs-1" },
            { "targets": [1], "searchable": false, "visible": false, "sortable": true, "title": "Country Id", "className": "col-xs-1" },
            { "targets": [2], "searchable": true, "sortable": true, "title": "Country Name", "className": "col-xs-1" },
            { "targets": [3], "searchable": true, "sortable": true, "title": "Cost", "className": "col-xs-1" },
            //{ "targets": [4], "searchable": true, "sortable": true, "title": "Documents Required", "className": "col-xs-1" },
            {
                "targets": [4], "searchable": true, "title": "Edit/Delete", "className": "col-xs-1",
                "render": function (data, type, row) {
                    return "<div class='pull-left'><a id = 'edit-" + row[0] + "' class='set-alert' href=''><i class='fa fa-pencil-square' aria-hidden='true'></i></a></div><div class='pull-right' style='padding-right:10px;font-size:18px;'><a  id = 'clear-" + row[0] + "'  href='' class= 'set-alert'><i class='fa fa-times-circle' aria-hidden='true'></i></a></div>";
                }
            }
        ]
    });
    BindVisaEvents(VisaList);
    if (Visaid != undefined) {
        var VisaArr = $.grep(VisaList, function (val, idx) {
            return VisaList[idx][0] == Visaid
        });
        $("#ddlCountry option:selected").text(VisaArr[0][2]);
        $("#cost").val(VisaArr[0][3]);
    }

}

function BindVisaEvents(VisaList) {

    $(".set-alert").on("click", function (e) {
        debugger
        //$("#countryMessage").html("");
        e.preventDefault();
        var rowid = $(this).attr("id");

        var visa = rowid.split("-");

        Visaid = visa[1];
        var VisaArr = $.grep(VisaList, function (val, idx) {
            return VisaList[idx][0] == Visaid
        });

        if (visa[0] == "edit") {

            $("#ddlCountry option:selected").text(VisaArr[0][2]);
            $("#cost").val(VisaArr[0][3]);
            $("#DocReq").val(VisaArr[0][4])
            window.location.href = "visa.aspx?visaid="+Visaid;
            $("#btnVisa").hide();
            $("#btnEditVisa").show();
            $("#btnCancelVisa").show();
        }
        else {

            //$("#CountryName").html(VisaArr[0][1]);
            $("#deleteVisa").modal("show");
        }
    });
}

function DeleteVisa() {
    $("#stateMessage").html("");
    $.ajax({
        type: "POST",
        url: url + "/DeleteVisa",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        data: JSON.stringify({ Visaid: Visaid }),

        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {

                    $("#SuccessStatus").text("Visa Data  deleted  Successfully");
                    $("#modal-success").modal("show");
                    getVisaList();

                   
                }
                else {
                    $("#FailureStatus").text("Error while deleting visa data");
                    $("#modal-danger").modal("show");
                }
            }
        },
        Error: function (x, e) {
            //alert(msg.d);
            $("#FailureStatus").text("Error while deleting visa data");
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