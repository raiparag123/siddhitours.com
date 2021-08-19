var CityList = [];
var VehicleList = [];
var RentList = [];
var RentTable = null;
var url = "RentCar.aspx";
var rentid = "";
var queryId = "";
var rentArr = [];
var flag = "";
var fileExtension = ["jpg", "jpeg", "png"];
$(document).ready(function () {
    $("#title").text("Rent Master");
    $("#modaloverlay").hide();
    $("#btnSubmit").show();
    $("#btnUpdate").hide();
    $("#btnCancel").hide();
    queryId = GetParameterValues("Rentid");
    if (queryId != undefined) {
        $("#btnSubmit").hide();
        $("#btnUpdate").show();
        $("#btnCancel").show();
    }
    getRentList();
    getPlaceList();
    getVehicleList();
   

    $("#btnSubmit").click(function (e) {
        e.preventDefault();
        $("#RentMessage").html("");
        var location = $("#ddlcity option:selected").text();
        var type = $("#ddlvehicle option:selected").val();
        var name = $("#vehicle-name").val();
        var cost = $("#cost").val();
        var image = $("#pd-image").val();
        var description = $("#ContentPlaceHolder1_Description").val();
        var terms = $("#ContentPlaceHolder1_terms").val();
        var ext = image.split('.').pop().toLowerCase();
        
        if (location == "0") {
            $("#RentMessage").html("Please select the location");
            return false;
        }
        else if (type == "0") {
            $("#RentMessage").html("Please select the Vehicle type");
            return false;
        }
        else if (name == "") {
            $("#RentMessage").html("Please enter the vehicle name");
            return false;
        }
        else if (cost == "") {
            $("#RentMessage").html("Please enter the cost");
            return false;
        }
        else if (description == "") {
            $("#RentMessage").html("please enter the description");
            return false;
        }
        else if (terms == "") {
            $("#RentMessage").html("Please enter the terms and conditons");
            return false;
        }
        else if (image == "") {
            $("#RentMessage").html("Please select the image to upload");
        }
        else if (jQuery.inArray(ext, fileExtension) == '-1') {
            $("#RentMessage").html("select a valid file");
            return false;

        }
        else {
            InsertData();
        }

    });

    $("#btnUpdate").click(function (e) {
        e.preventDefault();
        var location = $("#ddlcity option:selected").text();
        var type = $("#ddlvehicle option:selected").val();
        var name = $("#vehicle-name").val();
        var cost = $("#cost").val();
        var image = $("#pd-image").val();
        var description = $("#ContentPlaceHolder1_Description").val();
        var terms = $("#ContentPlaceHolder1_terms").val();
        var ext = image.split('.').pop().toLowerCase();

        if (location == "0") {
            $("#RentMessage").html("Please select the location");
            return false;
        }
        else if (type == "0") {
            $("#RentMessage").html("Please select the Vehicle type");
            return false;
        }
        else if (name == "") {
            $("#RentMessage").html("Please enter the vehicle name");
            return false;
        }
        else if (cost == "") {
            $("#RentMessage").html("Please enter the cost");
            return false;
        }
        else if (description == "") {
            $("#RentMessage").html("please enter the description");
            return false;
        }
        else if (terms == "") {
            $("#RentMessage").html("Please enter the terms and conditons");
            return false;
        }
        else if (image != "") {

            if (jQuery.inArray(ext, fileExtension) == '-1') {
                $("#RentMessage").html("select a valid file");
                return false;
            }
            else {
                UpdateData();
            }
        }
        else {
            UpdateData();
        }
    });

    $("#btnCancel").click(function (e) {
        e.preventDefault();
        $("#ddlcity").selectpicker('val', '0');
        $("#ddlcity").selectpicker('refresh');
        $("#ddlvehicle").selectpicker('val', '0');
        $("#ddlvehicle").selectpicker('refresh');
        $("#vehicle-name").val('');
        $("#cost").val('');
        $("#ContentPlaceHolder1_Description").val('');
        $("#ContentPlaceHolder1_terms").val('');

        window.location.href = "/adminPages/rentcar.aspx";
    

    });

    $("#btnConfirm").click(function (e) {
        e.preventDefault();
        deleteData();

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

function GetParameterValues(param) {
    var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for (var i = 0; i < url.length; i++) {
        var urlparam = url[i].split('=');
        if (urlparam[0] == param) {
            return urlparam[1];
        }
    }
}  

function fillData() {
    rentArr = $.grep(RentList, function (val, idx) {
        return RentList[idx][0] == queryId
    });
    if (rentArr.length > 0) {
        flag = "E";
        rentid = queryId;
        $("#vehicle-name").val(rentArr[0][3]);
        $("#cost").val(rentArr[0][5]);
        var a = rentArr[0][6];
       // $("#Description").val(a);
        //$("#terms").val(rentArr[0][7]);

    }
}

function UpdateData() {
    var location = $("#ddlcity option:selected").text();
    var type = $("#ddlvehicle option:selected").val();
    var name = $("#vehicle-name").val();
    var cost = $("#cost").val();
    var description = $("#ContentPlaceHolder1_Description").val();
    var terms = $("#ContentPlaceHolder1_terms").val();

    showMainProcessing();

    $.ajax({
        type: "POST",
        url: url + "/UpdateRent",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ Location: location, VehicleType: type, Name: name, cost: cost, Description: description, Terms: terms, RentId: rentid }),
        success: function (msg) {
            if (msg.d != "") {
                //  var jsonobj = JSON.parse(msg.d);
                var obj = msg.d;
                
                if (obj == "1") {
                    UploadRentImages();
                }

                //$("#invalid_cred").text("Login Success");


            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });

}

function deleteData() {
    $.ajax({
        type: "POST",
        url: url + "/DeleteRent",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ RentId: rentid }),
        success: function (msg) {
            if (msg.d != "") {

                $("#SuccessStatus").text("Data deleted  Successfully");
                $("#modal-success").modal("show");

                //$("#invalid_cred").text("Login Success");


            }
            else {
                $("#FailureStatus").text("Error while deleting data");
                $("#modal-danger").modal("show");
            }
            getRentList();
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function getRentList() {
    $.ajax({
        type: "POST",
        url: url + "/getRentList",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                mapRentList(jsonobj);


                //$("#invalid_cred").text("Login Success");


            }
            else {
                RentList = [];
            }
            BindRent();
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function mapRentList(jsonobj) {
    RentList = $.map(jsonobj, function (el) {
        return {
            0: el.RENTID,
            1: el.LOCATION,
            2: el.VEHICLETYPE,
            3: el.VEHICLENAME,
            4:el.IMAGEPATH,
            5: el.COST,
            6: el.DESCRIPTION,
            7: el.TERMS
           



        }
    });
}

function BindRent(){

    RentTable = $("#RentTbl").dataTable({
        "data": RentList,
        "bDestroy": true,
        "bPaginate": true,
        "paging": true,
        'autoWidth': false,
        //"aaSorting": [[1, "asc"]],


        "pageLength": 10,
        searching: true,
        "columnDefs": [
            { "targets": [0], "searchable": false, "visible": false, "sortable": true, "title": "Rent id", "className": "col-xs-1" },
            { "targets": [1], "searchable": true, "visible": true, "sortable": false, "title": "Location", "className": "col-xs-1" },
            { "targets": [2], "searchable": true, "sortable": true, "title": "Vehicle Type", "className": "col-xs-1" },

            { "targets": [3], "searchable": true, "sortable": true, "title": "Vehicle Name", "className": "col-xs-1" },
            {
                "targets": [4], "searchable": true, "sortable": true, "title": "Images", "className": "col-xs-1",
                "render": function (data, type, row) {
                    return "<img src=" + row[4] + " width=75% />"
                }
            },
            {
                "targets": [5], "searchable": true, "sortable": true, "title": "Cost", "className": "col-xs-1"
               
                
            },
            {
                "targets": [6], "searchable": false, "title": "Edit/Delete", "className": "col-sm-1",
                "render": function (data, type, row) {
                    return "<div class='pull-left'><a id = 'edit-" + row[0] + "' class='set-alert2' href=''><i class='fa fa-pencil-square' aria-hidden='true'></i></a></div><div class='pull-right' style='padding-right:10px;font-size:18px;'><a  id = 'clear-" + row[0] + "'  href='' class= 'set-alert2'><i class='fa fa-times-circle' aria-hidden='true'></i></a></div>";
                }
            }
        ]
    });
    bindTableEvents(RentTable);
    if (queryId != undefined) {
        fillData();
        // setTimeout(, 2000);
        window.setTimeout(function () {
            $("#ddlcity").selectpicker('refresh');
            $("#ddlvehicle").selectpicker('refresh');
            $("#ddlcity").selectpicker('val', rentArr[0][1]);
            $("#ddlvehicle").selectpicker('val', rentArr[0][2]);
        }, 1000);
     

    }
} 

function bindTableEvents(RentTable) {
    $("#RentTbl").on("click", '.set-alert2', function (e) {
        e.preventDefault();
        var rowid = $(this).attr("id");

        var trip = rowid.split("-");

        rentid = trip[1];
        var triparr = $.grep(RentList, function (val, idx) {
            return RentList[idx][0] == rentid
        });

        if (trip[0] == "edit") {

            window.location.href = "/adminPages/rentcar.aspx?Rentid=" + rentid;


        }
        else {
          
            $("#deleteRent").modal("show");
        }
    });

   
}

function InsertData() {
    var location = $("#ddlcity option:selected").text();
    var type = $("#ddlvehicle option:selected").val();
    var name = $("#vehicle-name").val();
    var cost = $("#cost").val();
    var description = $("#ContentPlaceHolder1_Description").val();
    var terms = $("#ContentPlaceHolder1_terms").val();
    showMainProcessing();
    $.ajax({
        type: "POST",
        url: url + "/InsertRent",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ Location: location, VehicleType: type, Name: name, cost: cost, Description: description, Terms: terms }),
        success: function (msg) {
            if (msg.d != "") {
              //  var jsonobj = JSON.parse(msg.d);
                var obj = msg.d.split("_");
                rentid = obj[1];
                if (obj[0] == "1") {
                    UploadRentImages();
                }

                //$("#invalid_cred").text("Login Success");


            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });

}

function getPlaceList() {
    $.ajax({
        type: "POST",
        url: url + "/getCityList",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                mapPlaceList(jsonobj);
                BindCityDropDown();

                //$("#invalid_cred").text("Login Success");


            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });

}

function getVehicleList() {
    $.ajax({
        type: "POST",
        url: url + "/getVehicleList",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                mapVehicleList(jsonobj);
                BindVehicleDropDown();

                //$("#invalid_cred").text("Login Success");


            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });

}


function mapPlaceList(jsonobj) {
    CityList = $.map(jsonobj, function (el) {
        return {
            0: el.CITYID,
            1: el.CITYNAME,
            2: el.STATENAME


        }
    });
}

function BindCityDropDown() {
    var appendvalue = "";
    $("#ddlcity").empty();
    for (var i = 0; i <= CityList.length - 1; i++) {
        appendvalue += "<option value=" + CityList[i][1] + ">" + CityList[i][1] + "</option>";
    }
    $("#ddlcity").append("<option value=0>Select</option>");
    $("#ddlcity").append(appendvalue);
    $("#ddlcity").selectpicker('refresh');
}

function mapVehicleList(jsonobj) {
    VehicleList = $.map(jsonobj, function (el) {
        return {
            0: el.VEHICLEID,
            1: el.VEHICLENAME

        }
    });
}

function BindVehicleDropDown() {
    var appendvalue = "";
    $("#ddlvehicle").empty();
    for (var i = 0; i <= VehicleList.length - 1; i++) {
        appendvalue += "<option value=" + VehicleList[i][0] + ">" + VehicleList[i][1] + "</option>";
    }
    $("#ddlvehicle").append("<option value=0>Select</option>");
    $("#ddlvehicle").append(appendvalue);
    $("#ddlvehicle").selectpicker('refresh');
}

function UploadRentImages() {
    var uploadfiles = $("#pd-image").get(0);
  
    var uploadedfiles = uploadfiles.files;
    var fromdata = new FormData();
    for (var i = 0; i < uploadedfiles.length; i++) {

        fromdata.append(uploadedfiles[i].name, uploadedfiles[i]);

    }

    $("#modaloverlay").show()
    $(".collapse").css("display", "block");

    move();

    $.ajax({
        type: "POST",
        contentType: false,
        processData: false,
        url: "RentImageHandler.ashx?RentId=" + rentid,

        data: fromdata,
        dataType: "json",
        success: function (msg) {

            if (msg != "") {
                if (msg == 1 || msg == -1) {
                    $("#myBar").css("width", "100%")
                    $(".collapse").css("display", "none");
                    $("#ddlcity").selectpicker('val', '0');
                    $("#ddlcity").selectpicker('refresh');
                    hideMainProcessing();
                   // $("#SuccessStatus").text("Data inserted  Successfully");
                   // $("#modal-success").modal("show");
                    
                    if (flag == "E") {
                        window.location.href = "/adminpages/Rentcar.aspx";
                    }

                }
                else if (msg == "0") {
                    $("#myBar").css("width", "100%")
                    $(".collapse").css("display", "none");
                    $("#FailureStatus").text("Error while inserting data");
                    $("#modal-danger").modal("show");
                }
                window.location.href = "Rentcar.aspx";
                getRentList();
                $("#ddlcity").selectpicker('val', '0');
                $("#ddlcity").selectpicker('refresh');
                $("#ddlvehicle").selectpicker('val', '0');
                $("#ddlvehicle").selectpicker('refresh');
                $("#vehicle-name").val('');
                $("#cost").val('');
                $("#ContentPlaceHolder1_Description").val('');
                $("#ContentPlaceHolder1_terms").val('');

            }
            else {
                hideMainProcessing();
                $("#FailureStatus").text("Error while inserting data");
                $("#modal-danger").modal("show");
            }
            
          
        },
        Error: function (x, e) {
            hideMainProcessing();
            $("#FailureStatus").text("Error while inserting data");
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
