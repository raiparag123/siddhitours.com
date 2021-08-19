var placeList = [];
var tripList = [];

var CountryList = [];
var StateList = [];
var CityList = [];
var url = "B2B.aspx";
var B2b = [];
var B2bTable = null;
var BusinessId = "";
var tourid = "";
var fileExtension = ["jpg", "jpeg", "png"];
var triparr = [];
var duplicateList = [];
var bbList = [];
var imageid = "";
var tripImageList = [];
var tripImageTable = null;
$(document).ready(function () {
    $("#modaloverlay").hide();
    $("#title").text("Business Master");
    getCountryList();
    getStateList();
    getPlaceList();
  
   
    tourid = GetParameterValues("TourId");
    setInterval(getBusinessTour(),5000);
     if (tourid != undefined) {
         //    fillData(tourid);
         $("#btnSubmit").hide();
         $("#btnUpdate").show();
     }
     else {
         $("#btnSubmit").show();
         $("#btnUpdate").hide();
     }
    $("#ddlcountry").change(function (e) {
        var countryid = $("#ddlcountry option:selected").val().replace("_", " ");
        var filterarr = jQuery.grep(StateList, function (n, i) {
            return (StateList[i][2] == countryid);

        });
        $("#ddlstate").empty();
        var filtervalue = "";
        for (var i = 0; i <= filterarr.length - 1; i++) {
            filtervalue += "<option value=" + filterarr[i][1].replace(" ","_") + ">" + filterarr[i][1] + "</option>";
        }
        $("#ddlstate").append("<option value=0>Select</option>");
        $("#ddlstate").append(filtervalue);

    });

    $("#ddlstate").change(function (e) {
        var stateid = $("#ddlstate option:selected").val().replace("_", " ");
        var filterarr = jQuery.grep(CityList, function (n, i) {
            return (CityList[i][2] == stateid);

        });
        $("#ddlcity").empty();
        var filtervalue = "";
        for (var i = 0; i <= filterarr.length - 1; i++) {
            filtervalue += "<option value=" + filterarr[i][1] + ">" + filterarr[i][1] + "</option>";
        }
        $("#ddlcity").append("<option value=0>Select</option>");
        $("#ddlcity").append(filtervalue);

    });

    $("#btnSubmit").click(function (e) {
        e.preventDefault();
        //validateData();
        $("#BTBMessage").html("");
        InsertBusinessTour();
    });

    $("#btnUpdate").click(function (e) {
        e.preventDefault();
        $("#BTBMessage").html("");
        UpdateBusinessTour();
    });

    $("#btnConfirm").click(function (e) {
        e.preventDefault();
        // ValidateDataTab1();
        $("#BTBMessage").html("");
        DeleteTrip();

    });

    $("#confirmImage").click(function (e) {
        e.preventDefault();
        $("#BTBMessage").html("");
        DeleteImage();
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

function DeleteImage() {
    $.ajax({
        type: "POST",
        url: url + "/DeleteTripImages",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ ImageId: imageid }),
        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {
                    $("#SuccessStatus").text("Image deleted Successfully");
                    $("#modal-success").modal("show");
                    GetTripImages(BusinessId);
                }

                //$("#invalid_cred").text("Login Success");


            }
            else {
                tripImageList = null;
            }
            BindTripImages();
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while deleting image");
            $("#modal-danger").modal("show");
        }
    });
}



function fillData(tourid) {
     triparr = $.grep(B2b, function (val, idx) {
        return B2b[idx][0] == tourid
    });

    $("#title-name").val(triparr[0][1]);
    $("#cost").val(triparr[0][2]);
  
    var searchString = "";
  //  $("#inclusion").val(triparr[0][3]);
  
    
    $('#ddlcountry').select2('val', [triparr[0][4]]);
    $('#ddlstate').select2('val', [triparr[0][5]]);
    $('#ddlcity').select2('val', [triparr[0][6]]);
   

}


function DeleteTrip() {
    $.ajax({
        type: "POST",
        url: url + "/DeleteTrip",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ TripID: BusinessId }),
        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                $("#SuccessStatus").text("Business tour deleted Successfully");
                $("#modal-success").modal("show");
                getBusinessTour();

            }
            else {
                $("#FailureStatus").text("Error while deleting business tour");
                $("#modal-danger").modal("show");
            }
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while deleting business tour");
            $("#modal-danger").modal("show");
        }
    });
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

function getBusinessTour() {
    $.ajax({
        type: "POST",
        url: url + "/getBusinessTour",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                mapBusinessTour(jsonobj);
               

            }
            else {
                B2b = null;
            }
            bindBusinessTour();
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });

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

                //$("#invalid_cred").text("Login Success");
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

function getStateList() {
    $.ajax({
        type: "POST",
        url: url + "/getStateList",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                mapStateList(jsonobj);

                BindStateDropDown();
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

function mapCountryList(jsonobj) {

    CountryList = $.map(jsonobj, function (el) {
        return {
            0: el.COUNTRYID,
            1: el.COUNTRYNAME

        }
    });
}


function mapStateList(jsonobj) {
    StateList = $.map(jsonobj, function (el) {
        return {
            0: el.STATEID,

            1: el.STATENAME,
            2: el.COUNTRYNAME


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
function mapBusinessTour(jsonobj) {
    B2b = $.map(jsonobj, function (el) {
        return {
            0: el.BUSINESSID,
            1: el.BUSINESSTITLE,
            2: el.COST,
            3: el.INCLUSION,
            4: el.COUNTRY,
            5: el.STATE,
            6: el.CITY


        }
    });
   
    for (var i = 0; i <= B2b.length - 1; i++) {
        var value = B2b[i][1].toUpperCase();
        duplicateList.push(value);
    }

    for (var i = 0; i <= B2b.length - 1; i++) {
        var value = B2b[i][1].toUpperCase();

        bbList.push([ value, B2b[i][0] ]);
    }
}

function bindBusinessTour() {
   

    if (B2bTable != null) {
        B2bTable.fnDestroy();
        $("#tableBusiness").empty();
    }
    B2bTable = $("#tableBusiness").dataTable({
        "data": B2b,
            "bDestroy": true,
                "bPaginate": true,
                    "paging": true,
                        'autoWidth': false,
                         
                            "pageLength": 10,
                                searching: true,
                                    "columnDefs": [
                                        { "targets": [0], "searchable": false, "visible": false, "sortable": true, "title": "Tour id", "className": "col-xs-1" },
                                        { "targets": [1], "searchable": true, "visible": true, "sortable": false, "title": "Tour Title", "className": "col-xs-1" },
                                        { "targets": [2], "searchable": true, "sortable": true, "title": "Cost", "className": "col-xs-1" },

                                        {
                                            "targets": [3], "searchable": true, "sortable": true, "title": "View Images", "className": "col-xs-1",
                                            "render": function (data, type, row) {
                                                return "<div class='pull-left'><a id = 'view-" + row[0] + "' class='view' href=''>View Images</div>"
                                            }
                                        },
                                        //{ "targets": [4], "searchable": true, "sortable": true, "title": "Tri", "className": "col-xs-1" },
                                        {
                                            "targets": [4], "searchable": false, "title": "Edit/Delete", "className": "col-sm-1",
                                            "render": function (data, type, row) {
                                                return "<div class='pull-left'><a id = 'edit-" + row[0] + "' class='set-alert2' href=''><i class='fa fa-pencil-square' aria-hidden='true'></i></a></div><div class='pull-right' style='padding-right:10px;font-size:18px;'><a  id = 'clear-" + row[0] + "'  href='' class= 'set-alert2'><i class='fa fa-times-circle' aria-hidden='true'></i></a></div>";
                                            }
                                        }
                                    ]
    });
    bindTableEvents(B2bTable);

    if (tourid != undefined) {
        setTimeout(fillData(tourid), 2000);
    }
       
}

function bindCountryDropdown() {
    var appendvalue = "";
    $("#ddlcountry").empty();
    for (var i = 0; i <= CountryList.length - 1; i++) {
        appendvalue += "<option value=" + CountryList[i][1].replace(" ","_") + ">" + CountryList[i][1] + "</option>";
    }
    $("#ddlcountry").append("<option value=0>Select</option>");

    $("#ddlcountry").append(appendvalue);
   
   
    
}

function BindStateDropDown() {
    var appendvalue = "";
    $("#ddlstate").empty();
    for (var i = 0; i <= StateList.length - 1; i++) {
        appendvalue += "<option value=" + StateList[i][1].replace(" ","_") + ">" + StateList[i][1] + "</option>";
    }
    $("#ddlstate").append("<option value=0>Select</option>");
    $("#ddlstate").append(appendvalue);

    
}

function BindCityDropDown() {
    var appendvalue = "";
    $("#ddlcity").empty();
    for (var i = 0; i <= CityList.length - 1; i++) {
        appendvalue += "<option value=" + CityList[i][1] + ">" + CityList[i][1] + "</option>";
    }
    $("#ddlcity").append("<option value=0>Select</option>");
    $("#ddlcity").append(appendvalue);
   
}

function InsertBusinessTour() {
    var locationstring = "";
    var title = $("#title-name").val();
    var cost = $("#cost").val();
    var file = $("#pd-image").val();
    var ext = $("#pd-image").val().split('.').pop().toLowerCase();
    var searchString = "";
    var inclusion = $("#ContentPlaceHolder1_inclusion").val();
    var country = $("#ddlcountry option:selected").val().replace("_"," ");
    var state = $("#ddlstate option:selected").val().replace("_", " ");
    var city = $("#ddlcity option:selected").val();

    var duplicate = $.grep(duplicateList, function (val, idx) {
        return duplicateList[idx] == title.toUpperCase().trim()
    });
    var uploadfiles = $("#pd-image").get(0);
    var uploadedfiles = uploadfiles.files;
    if (uploadedfiles.length < 1) {
        $("#BTBMessage").html("Select a file to upload ");
        return false;
    }

    for (var i = 0; i < uploadedfiles.length; i++) {

        var ext = uploadedfiles[i].name.split('.').pop().toLowerCase();
        if (jQuery.inArray(ext, fileExtension) == '-1') {
            $("#BTBMessage").html("select a valid file");
            return false;

        }

    }


    if (title == "") {
        //$("#title-name").css("border","1px solid red");
        $("#BTBMessage").html("Please Enter The title");
        return false;
    }
    else if (duplicate.length > 0) {
        $("#BTBMessage").html("Title already exist");
        return false;
    }
    else {
       
    }

    if (cost == "") {
        $("#BTBMessage").html("Please enter the cost");
        return false;
    }


    


    if (country == "0" && state == "0" && city == "0") {
        $("#BTBMessage").html("Please select any one of Country , State or City");
        return false;
    }
    

    if (inclusion == "") {
        $("#BTBMessage").html("Please enter inclusion/exclusion for the tour.");
        return false;
    }

    if (city != 0) {
        locationstring += city;
        if (state != 0) {
            locationstring += "," + state;

        }
        if (country != 0) {
            locationstring += "," + country;
        }

    }
    else if (state != 0) {
        locationstring += state;
        if (country != 0) {
            locationstring += "," + country;
        }
    }
    else {
        locationstring += country;
    }

    showMainProcessing();
    $.ajax({
        type: "POST",
        url: url + "/InsertTripDetail",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ Title: title, Cost: cost, location: locationstring, Inclusion: inclusion, Country: country, State: state,City:city }),
        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = msg.d.split("_");
                if (jsonobj[0] == "1") {
                    BusinessId = jsonobj[1];
                    UploadBusinessImages();
                    
                }



                //$("#invalid_cred").text("Login Success");


            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });

}

function UpdateBusinessTour() {
    var locationstring = "";
    var title = $("#title-name").val();
    var cost = $("#cost").val();
    var file = $("#pd-image");
    var searchString = "";
    var inclusion = $("#ContentPlaceHolder1_inclusion").val();
    var country = $("#ddlcountry option:selected").val().replace("_", " ");
    var state = $("#ddlstate option:selected").val().replace("_", " ");
    var city = $("#ddlcity option:selected").val();

    var duplicate = $.grep(bbList, function (val, idx) {
        return bbList[idx][1] == title.toUpperCase().trim() && bbList[idx][0] != tourid
    });
    var uploadfiles = $("#pd-image").get(0);
    var uploadedfiles = uploadfiles.files;

    for (var i = 0; i < uploadedfiles.length; i++) {

        var ext = uploadedfiles[i].name.split('.').pop().toLowerCase();
        if (jQuery.inArray(ext, fileExtension) == '-1') {
            $("#BTBMessage").html("select a valid file");
            return false;

        }

    }


    if (title == "") {
        $("#BTBMessage").html("Please Enter The title");
        return false;
    }
    else if (duplicate.length > 0) {
        $("#BTBMessage").html("Title already exist");
        return false;
    }
    else {

    }

    if (cost == "") {
        $("#BTBMessage").html("Please enter the cost");
        return false;
    }





    if (country == "0" && state == "0" && city == "0") {
        $("#BTBMessage").html("Please select any one of Country , State or City");
        return false;
    }


    if (inclusion == "") {
        $("#BTBMessage").html("Please enter inclusion/exclusion for the tour.");
        return false;
    }




    if (city != 0) {
        locationstring += city;
        if (state != 0) {
            locationstring += "," + state;

        }
        if (country != 0) {
            locationstring += "," + country;
        }

    }
    else if (state != 0) {
        locationstring += state;
        if (country != 0) {
            locationstring += "," + country;
        }
    }
    else {
        locationstring += country;
    }

    showMainProcessing();

    $.ajax({
        type: "POST",
        url: url + "/UpdateTripDetail",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ Title: title, Cost: cost, location: locationstring, Inclusion: inclusion, Country: country, State: state, City: city, TourId: tourid }),
        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = msg.d;
                if (jsonobj[0] == "1") {
                    BusinessId = tourid;
                    if (uploadedfiles.length == 0) {
                        $("#SuccessStatus").text("BusinessTour updated Successfully");
                        $("#modal-success").modal("show");
                    }
                    else {
                        UploadBusinessImages();
                    }
                    window.location.href = "/adminPages/B2B.aspx";
                }



                //$("#invalid_cred").text("Login Success");


            }
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while updating business tour");
            $("#modal-danger").modal("show");
        }
    });
}

function bindTableEvents(B2bTable) {
    $("#tableBusiness").on("click",".set-alert2", function (e) {
        e.preventDefault();
        var rowid = $(this).attr("id");

        var trip = rowid.split("-");

        BusinessId = trip[1];
        var triparr = $.grep(B2b, function (val, idx) {
            return B2b[idx][0] == BusinessId
        });

        if (trip[0] == "edit") {
            var locationstring = "";
            window.location.href="/AdminPages/B2B.aspx?TourId=" + BusinessId;
        }
        else {
            $("#tripname").text(triparr[0][1]);
            $("#deleteTrip").modal("show");
        }
    });

    $("#tableBusiness").on("click",".view", function (e) {
        e.preventDefault();
        var rowid = $(this).attr("id");

        var trip = rowid.split("-");

        BusinessId = trip[1];
        GetTripImages(BusinessId);
        $("#Image").modal("show");
    });
}
function UploadBusinessImages() {
    var uploadfiles = $("#pd-image").get(0);
    var Location = $("#ddlLocation option:selected").val();
    var Title = $("#title-name").val();
    var uploadedfiles = uploadfiles.files;
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
        url: "B2B.ashx?BusinessId=" + BusinessId,

        data: fromdata,
        dataType: "json",
        success: function (msg) {
            if (msg != "") {
                if (msg == 1) {
                    $("#myBar").css("width", "100%")
                    $(".collapse").css("display", "none");
                    $("#title-name").val('');
                    $("#SuccessStatus").text("BusinessTour inserted Successfully");
                    $("#modal-success").modal("show");
                    hideMainProcessing();
                    //getBusinessTour();
                    window.location.href = url;
                }
            }
            else {
                $("#myBar").css("width", "100%")
                $(".collapse").css("display", "none");
                $("#FailureStatus").text("Error while inserting business tour");
                $("#modal-danger").modal("show");
            }
            hideMainProcessing();
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while inserting business tour");
            $("#modal-danger").modal("show");
            hideMainProcessing();
        }
    });
}

function GetTripImages(BusinessId) {
    $.ajax({
        type: "POST",
        url: url + "/getTripImages",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ Tripid: BusinessId }),
        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                mapTripImages(jsonobj);


                //$("#invalid_cred").text("Login Success");


            }
            else {
                tripImageList = null;
            }
            BindTripImages();
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}
function mapTripImages(obj) {
    tripImageList = $.map(obj, function (el) {
        return {
            0: el.TOURID,
            1: el.BUSINESSIMAGEID,
            2: el.IMAGEPATH


        }
    });
}

function BindTripImages() {
    if (tripImageTable != null) {
        tripImageTable.fnDestroy();
        $("#tableImages").empty();
    }
    tripImageTable = $("#tableImages").dataTable({
        "data": tripImageList,
        "bDestroy": true,
        "bPaginate": true,
        "paging": true,
        'autoWidth': false,
        //"aaSorting": [[1, "asc"]],


        "pageLength": 10,
        searching: true,
        "columnDefs": [
            { "targets": [0], "searchable": false, "visible": false, "sortable": true, "title": "Tour id", "className": "col-xs-1" },
            { "targets": [1], "searchable": true, "visible": false, "sortable": false, "title": "Image Id", "className": "col-xs-1" },
            {
                "targets": [2], "searchable": true, "sortable": true, "title": "Image", "className": "col-xs-1",
                render: function (data, type, row) {
                    return "<img src=" + row[2] + " width=75% />"
                }
            },


            {
                "targets": [3], "searchable": false, "title": "Edit/Delete", "className": "col-sm-1",
                "render": function (data, type, row) {
                    return "<div class='pull-right' style='padding-right:10px;font-size:18px;'><a  id = 'clear-" + row[1] + "'  href='' class= 'clearImage'><i class='fa fa-times-circle' aria-hidden='true'></i></a></div>";
                }
            }
        ]
    });
    bindImageEvents(tripImageTable);
}

function bindImageEvents() {
    $("#tableImages").on("click",".clearImage", function (e) {
        e.preventDefault();
        var rowid = $(this).attr("id");

        var trip = rowid.split("-");

        imageid = trip[1];

        $("#deleteImage").modal("show");
    });
}

function showMainProcessing() {

    $('#modaloverlay').show();

}
function hideMainProcessing() {
    $('#modaloverlay').hide();

}

function Reset()
{
    $("#title-name").val("");
    $("#cost").val("");

    var searchString = "";
    $("#inclusion").val("");


    $('#ddlcountry').select2('val', [triparr[0][4]]);
    $('#ddlstate').select2('val', [triparr[0][5]]);
    $('#ddlcity').select2('val', [triparr[0][6]]);
}