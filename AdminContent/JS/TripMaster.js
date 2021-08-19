var url = "TripMaster.aspx";
var CountryList = [];
var StateList = [];
var CityList = [];
var TripType = [];
var themeList = [];
var tripid = "";
var inputFromDate = "";
var inputToDate = "";
var TripMasterList = [];
var tripImageList = [];
var tripImageTable = null;
var TripMasterTable = null;
var duplicateList = [];
var fileExtension = ["jpg", "jpeg", "png"];
var flag = "";
var imageid = "";
var totalDays = "";

$(document).ready(function () {

   

   
   // url = window.location.href;
    $("#modaloverlay").hide();
    tourid = GetParameterValues("TourId");
    if (tourid != undefined) {
        $("#btnfinish").hide();
        $("#btnUpdate").show();
        flag = "E";
    }
    else {
        flag = "A";
        $("#btnfinish").show();
        $("#btnUpdate").hide();
    }
    $("#title").text("Tour Master");
    getCountryList();
   // getStateList();
   // getPlaceList();
   // GetTripType();
   // getThemeList();
   // getTripMaster();
   

    $("#ddlcountry").change(function (e) {        
        var countryid = $("#ddlcountry option:selected").val();
        countryid.replace("_", " ");
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
        $("#ddlstate").selectpicker('refresh');


    });

    $("#ddlstate").change(function (e) {
        var stateid = $("#ddlstate option:selected").val().replace("_"," ");
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
        $("#ddlcity").selectpicker('refresh');

    });

    $("#ddltour").change(function (e) {
        var type = $("#ddltour option:selected").text();
        if (type.toUpperCase() != 'GROUP')
        {
            $("#seat-no").val('');
            $("#seat-no").attr("disabled", true);
            $("#reservation").attr("disabled", true);
        }
        else {
            $("#seat-no").removeAttr("disabled");
            $("#reservation").removeAttr("disabled");
        }

    });

    $("#tour-cost").keydown(function (e) {
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
            // Allow: Ctrl+A, Command+A
            (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) ||
            // Allow: home, end, left, right, down, up
            (e.keyCode >= 35 && e.keyCode <= 40)) {
            // let it happen, don't do anything
            return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }

        
    });

    $("#seat-no").keydown(function (e) {
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
            // Allow: Ctrl+A, Command+A
            (e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) ||
            // Allow: home, end, left, right, down, up
            (e.keyCode >= 35 && e.keyCode <= 40)) {
            // let it happen, don't do anything
            return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });

    $("#btnConfirm").click(function (e) {
       e.preventDefault();
       // ValidateDataTab1();
        DeleteTrip();

    });

    $("#btnTab1").click(function (e) {
       // e.preventDefault();
        //ValidateDataTab1();
        //InsertTab2();

    });

    $("#btnTour").click(function (e) {
        // e.preventDefault();
        window.location.href = "/adminPages/ItenaryMaster.aspx?Tourid = " + tripid + "&Days=" + triparr[0][11] + "&Flag=E";

    });

    $("#btnCancel").click(function (e) {
        // e.preventDefault();
        window.location.href = "/adminPages/TripMaster.aspx";

    });

   
    $("#btnfinish").click(function (e) {
        e.preventDefault();
        InsertAlldata();

    });

    $("#btnUpdate").click(function (e) {
        e.preventDefault();
        UpdateAllData();

    })
    $("#confirmImage").click(function (e) {
        e.preventDefault();
        DeleteImage();
    });


    $('#reservation').daterangepicker(
        {
           

            
            showDropdowns: true,
            opens: 'left',
            minDate: moment().subtract('year', 50).format("DD-MMM-YY"),
           
        },
        function (start, end) {
            $('#reservation span').html(start.format('DD-MMM-YY') + ' - ' + end.format('DD-MMM-YY'));
            inputFromDate = start.format('DD-MMM-YY');
            inputToDate = end.format('DD-MMM-YY');
        }
    );
    slider();
   
});

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}

//$(window).on('load', function () {
//    //if (tourid != undefined) {
//    fillData(tourid);//, 5000);
//    //}
//});

function GetParameterValues(param) {
    var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for (var i = 0; i < url.length; i++) {
        var urlparam = url[i].split('=');
        if (urlparam[0] == param) {
            return urlparam[1];
        }
    }
}  

function slider() {
    var navListItems = $('div.setup-panel div a'),
        allWells = $('.setup-content'),
        allNextBtn = $('.nextBtn');

    allWells.hide();

    navListItems.click(function (e) {
        e.preventDefault();

        var $target = $($(this).attr('href')),
            $item = $(this);
        var valid = true;
        var id = $target.attr("id");
        if (id == "step-2" || id == "btntab2") {
            valid = ValidateDataTab1();

        }
        else if (id == "step-3" || id == "btnTab3") {
            valid = ValidateDataTab2();
        }
        else if (id == "step-4" || id == "btnTab4") {
            valid = ValidateDataTab3();
        }

        if (valid == true) {
            if (!$item.hasClass('disabled')) {
                navListItems.removeClass('btn-success').addClass('btn-default');
                $item.addClass('btn-success');
                allWells.hide();
                $target.show();
                $target.find('input:eq(0)').focus();
            }
            }
            
    });

    allNextBtn.click(function () {
        var id = $(this).attr("id");
        var valid;
        if (id == "step-1" || id == "btnTab1") {
            valid = ValidateDataTab1();
        }
        else if (id == "step-2" || id == "btntab2") {
            valid = ValidateDataTab2();

        }
        else if (id == "step-3" || id == "btnTab3") {
            valid = ValidateDataTab3();
        }
        else {
            valid = ValidateTab4();
        }
        var curStep = $(this).closest(".setup-content"),
            curStepBtn = curStep.attr("id"),
            nextStepWizard = $('div.setup-panel div a[href="#' + curStepBtn + '"]').parent().next().children("a"),
            curInputs = curStep.find("input[type='text'],input[type='url']"),

            isValid = valid;

        $(".form-group").removeClass("has-error");
        for (var i = 0; i < curInputs.length; i++) {
            if (!curInputs[i].validity.valid) {
                isValid = false;
                $(curInputs[i]).closest(".form-group").addClass("has-error");
            }
        }

        if (isValid) nextStepWizard.removeAttr('disabled').trigger('click');
    });

    $('div.setup-panel div a.btn-success').trigger('click');

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
                    GetTripImages(tripid);
                }

                //$("#invalid_cred").text("Login Success");


            }
            else {
                tripImageList = null;
            }
            getTripMaster();
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}
function fillData(tourid) {
    triparr = $.grep(TripMasterList, function (val, idx) {
        return TripMasterList[idx][0] == tourid
    });
    var locationstring = "";
    var state = triparr[0][15];
    $("#title-name").val(triparr[0][1]);
   // $("#ddlcountry option:selected").val(triparr[0][14]);
    $("#ddlcountry").selectpicker('val', triparr[0][14]);
    $("#ddlstate").selectpicker('val', state);
    $("#ddlcity").selectpicker('val', triparr[0][16]);
    $("#tour-cost").val(triparr[0][3]);
    $("#ddltour").selectpicker('val', triparr[0][2]);
    $("#seat-no").val(triparr[0][11]);
    inputFromDate = triparr[0][10];
    $("#reservation").data('daterangepicker').setStartDate(moment(inputFromDate).format("MM/DD/YYYY"));
   
    inputToDate = triparr[0][5];
    $("#reservation").data('daterangepicker').setEndDate(moment(inputToDate).format("MM/DD/YYYY"));
   // if (triparr[0][13] != "" && triparr[0][5] != null) { 
    var values = triparr[0][13].split(",");
    $('#ddlTheme').selectpicker('refresh');
    $('#ddlTheme').selectpicker('val', values);
  
    //i = 0, size = values.length;
    //for (i; i < size; i++) {
      
    //    $("#ddlTheme option[value='" + values[i] + "']").attr("selected", i);
    //   // $("#ddlTheme").selectpicker("refresh");
    //}

//}
  
             $("#no-of-days").val(triparr[0][12]);
          //   $("#ContentPlaceHolder1_inclusion").val(triparr[0][7]);
          //   $("#ContentPlaceHolder1_Exclusion").val(triparr[0][6]);
             var isactive = triparr[0][9];

             //if (isactive == "ACTIVE") {
             //    $('#activate').attr("checked", "checked")
             //}
                

}

function InsertAlldata() {
    ValidateDataTab1();
    ValidateDataTab2();
    ValidateDataTab3();
    debugger
    var locationstring = "";
    var title = $("#title-name").val().trim();
    var country = $("#ddlcountry option:selected").val().trim().replace("_", " ");
    var state = $("#ddlstate option:selected").val().trim().replace("_", " ");
    var city = $("#ddlcity option:selected").val().trim();
    var cost = $("#tour-cost").val().trim();
    var tourtype = $("#ddltour option:selected").val().trim();
    var seat = $("#seat-no").val().trim();
    var fromDate = inputFromDate;
    var todate = inputToDate;
    if (seat == "")
    {
        seat = 0;
    }
    if (fromDate == "") {
        fromDate = moment().format("DD-MMM-YYYY");
        todate = moment().format("DD-MMM-YYYY");
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
    var selMulti = $.map($("#ddlTheme option:selected"), function (el, i) {
        return $(el).text();
    });

  
    var overview = $("#ContentPlaceHolder1_txtOverview").val().trim();
    var theme = selMulti.join(", ");
    var totalDays = $("#no-of-days").val().trim();
    var inclusion = $("#ContentPlaceHolder1_inclusion").val().trim();
    var exclusion = $("#ContentPlaceHolder1_Exclusion").val().trim();
    var isactive;
    //if ($('#activate').is(":checked")) {
        isactive = 1;
    //}
    //else {
    //    isactive = 0;
    //}
    $.ajax({
        type: "POST",
        url: url + "/InsertTripDetail",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({
            Title: title, Location: locationstring, Cost: cost, Tour: tourtype, TourSeat: seat, TourDate: fromDate, Theme: theme, OverView: overview,
            Inclusion: inclusion, Status: isactive, Exclusion: exclusion, ToDate: todate, Days: totalDays, Country: country, State: state, City: city
        }),
        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = msg.d.split("_");
                if (jsonobj[0] == "1") {
                    tripid = jsonobj[1];
                    UploadTripImages();

                    getTripMaster();
                   
                  
                }
                
                

                //$("#invalid_cred").text("Login Success");


            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function UpdateAllData() {
    var locationstring = "";
    var title = $("#title-name").val().trim();
    var country = $("#ddlcountry option:selected").val().trim().replace("_", " ");
    var state = $("#ddlstate option:selected").val().trim().replace("_", " ");
    var city = $("#ddlcity option:selected").val().trim();
    var cost = $("#tour-cost").val().trim();
    var tourtype = $("#ddltour option:selected").val().trim();
    var seat = $("#seat-no").val().trim();
    var fromDate = inputFromDate;
    var todate = inputToDate;
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
    var selMulti = $.map($("#ddlTheme option:selected"), function (el, i) {
        return $(el).text();
    });

    if(seat == "")
    {
        seat = 0;
    }
    if (fromDate == "")
    {
        fromDate = moment().format("DD-MMM-YYYY");
        todate = moment().format("DD-MMM-YYYY");
    }
    var overview = $("#ContentPlaceHolder1_txtOverview").val().trim();
    var theme = selMulti.join(", ");
    var totalDays = $("#no-of-days").val();
    var inclusion = $("#ContentPlaceHolder1_inclusion").val().trim();
    var exclusion = $("#ContentPlaceHolder1_Exclusion").val().trim();
    var isactive;
    //if ($('#activate').is(":checked")) {
        isactive = 1;
    //}
    //else {
    //    isactive = 0;
    //}
    $.ajax({
        type: "POST",
        url: url + "/UpdateTripDetail",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({
            Title: title, Location: locationstring, Cost: cost, Tour: tourtype, TourSeat: seat, TourDate: fromDate, Theme: theme, OverView: overview,
            Inclusion: inclusion, Status: isactive, Exclusion: exclusion, ToDate: todate, Days: totalDays, Country: country, State: state, City: city, TourId:tourid
        }),
        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = msg.d;
                if (jsonobj == "1") {
                    tripid = tourid;
                     UploadTripImages();
                    


                }



                //$("#invalid_cred").text("Login Success");


            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}



function DeleteTrip() {
    $.ajax({
        type: "POST",
        url: url + "/DeleteTrip",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ TripID: tripid }),
        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                $("#SuccessStatus").text("Tour deleted Successfully");
                $("#modal-success").modal("show");
                //bindDaysDropdown();
                getTripMaster();

            }
            else {
                $("#FailureStatus").text("Error while deleting tour");
                $("#modal-danger").modal("show");
            }
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while deleting tour");
            $("#modal-danger").modal("show");
        }
    });
}

function getTripMaster() {
    $.ajax({
        type: "POST",
        url: url + "/getTripMaster",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                mapTripMaster(jsonobj);
                BindTripMaster();

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

function mapTripMaster(jsonobj) {
    TripMasterList = $.map(jsonobj, function (el) {
        return {
            0: el.TRIPID,
            1: el.TRIPTITLE,
            2: el.TYPEID,
            3: el.TRIPCOST,
            4: el.TRIPOVERVIEW ,
            5: el.TODATE,
            6: el.TRIPEXCLUSION,
            7: el.TRIPINCLUSION,
            8: el.TRIPLOCATION,
            9: el.STATUS,
            10: el.FROMDATE,
            11: el.SEAT,
            12: el.TRIPDAYS,
            13: el.TRIPTHEME,
            14: el.COUNTRY,
            15: el.STATE,
            16: el.CITY

        }
    });

    for (var i = 0; i <= TripMasterList.length-1; i++) {
        duplicateList.push([TripMasterList[i][1], TripMasterList[i][0]]);
    }
}

function BindTripMaster() {
   

    TripMasterTable = $("#tblTripMaster").dataTable({
        "data": TripMasterList,
        "bDestroy": true,
        "bPaginate": true,
        "paging": true,
        'autoWidth': false,
        //"aaSorting": [[1, "asc"]],
      
       
        "pageLength": 10,
        searching: true,
        "columnDefs": [
            { "targets": [0], "searchable": false, "visible": false, "sortable": true, "title": "Tour id", "className": "col-xs-1" },
            { "targets": [1], "searchable": true, "visible": true, "sortable": false, "title": "Tour Title", "className": "col-xs-1" },
            { "targets": [2], "searchable": true, "sortable": true, "title": "Category", "className": "col-xs-1" },
          
            { "targets": [3], "searchable": true, "sortable": true, "title": "Cost(in Rs)", "className": "col-xs-1" },
            {
                "targets": [4], "searchable": true, "sortable": true, "title": "View Images", "className": "col-xs-1",
                "render": function (data, type, row) {
                    return "<div class='pull-left'><a id = 'view-" + row[0] + "' class='view' href=''>View Images</div>"
                }
            },
            {
                "targets": [5], "searchable": false, "title": "Edit Itenary", "className": "col-sm-1",
                "render": function (data, type, row) {
                    return "<div class='pull-left'><a id = 'itenary-" + row[0] + "' class='set-alert2' href=''><i class='fa fa-pencil-square' aria-hidden='true'></i></a></div>";
                }
            }, 
            {
                "targets": [6], "searchable": false, "title": "Edit/Delete", "className": "col-sm-1",
                "render": function (data, type, row) {
                    return "<div class='pull-left'><a id = 'edit-" + row[0] + "' class='set-alert2' href=''><i class='fa fa-pencil-square' aria-hidden='true'></i></a></div><div class='pull-right' style='padding-right:10px;font-size:18px;'><a  id = 'clear-" + row[0] + "'  href='' class= 'set-alert2'><i class='fa fa-times-circle' aria-hidden='true'></i></a></div>";
                }
            } 
        ]
    });
    bindTableEvents(TripMasterTable);
    if (tourid != undefined) {
    window.setTimeout(function () {

        fillData(tourid)
    }, 1000);
     
         }
    
}

function bindTableEvents(TripMasterTable) {
    $("#tblTripMaster").on("click",'.set-alert2', function (e) {
        e.preventDefault();
        var rowid = $(this).attr("id");

        var trip = rowid.split("-");

        tripid = trip[1];
        var triparr = $.grep(TripMasterList, function (val, idx) {
            return TripMasterList[idx][0] == tripid
        });

        if (trip[0] == "edit") {
           // fillData(tripid);
            window.location.href = "/adminPages/tripmaster.aspx?TourId=" + tripid;
        

        }
        else if (trip[0] == "itenary") {
            window.location.href = "/adminPages/itenaryMaster.aspx?Tourid=" + tripid + "&Days=" + triparr[0][12] + "&Flag=E";
        }
        else {
            $("#tripname").text(triparr[0][1]);
            $("#deleteTrip").modal("show");
        }
    });

    $("#tblTripMaster").on("click",".view", function (e) {
        e.preventDefault();
        var rowid = $(this).attr("id");
     
        var trip = rowid.split("-");

        tripid = trip[1];
        GetTripImages(tripid);
        $("#Image").modal("show");
    });
}
function GetTripImages(tripid) {
    $.ajax({
        type: "POST",
        url: url + "/getTripImages",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ Tripid: tripid }),
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

//progress bar after submitting
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

function UploadTripImages() {
    var uploadfiles = $("#tp-image").get(0);
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
        url: "TripImageHandler.ashx?TripId=" + tripid,

        data: fromdata,
        dataType: "json",
        success: function (msg) {
            if (msg != "") {

                if (msg == 1) {
                    $("#title-name").val('');
                    $(" .collapse").css("display", "none");
                    $("#SuccessStatus").text("Tour inserted Successfully");
                    $("#modal-success").modal("show");
                    window.location.href = "/adminpages/ItenaryMaster.aspx?Tourid=" + tripid + "&Days=" + totalDays + "&Flag=A";
                    getTripMaster();


                }
                else if (msg == "0") {
                    $("#FailureStatus").text("Error while inserting tour");
                    $("#modal-danger").modal("show");
                }
            }
            else {

            }
            if (flag == "E") {
                $(" .collapse").css("display", "none");
                $("#UpdateTrip").modal("show");
            }
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while inserting tour");
            $("#modal-danger").modal("show");
        }
    });
}

function bindDayEvent() {
    $(".boxLimit").on("click", function (e) {
        var rowid = $(this).attr("id");
        rowid = rowid.split("_");
        var boxid = rowid[1];
        $("#day").text(boxid);
        $("#modal-default").modal("show");
    });
}

function ValidateDataTab1() {
    $("#tab1").html("");
    var title = $("#title-name").val();
    var country = $("#ddlcountry option:selected").val().replace("_", " ");
    var state = $("#ddlstate option:selected").val().replace("_", " ");
    var city = $("#ddlcity option:selected").val();
    var cost = $("#tour-cost").val();
    var tourtype = $("#ddltour option:selected").val();
    var seat = $("#seat-no").val();

    var valid="";
    if (flag == "E") {
        var duplicate = $.grep(duplicateList, function (val, idx) {
            return duplicateList[idx][0] == title.toUpperCase() && duplicateList[idx][0] != tourid
        });
    }
    else {
        var duplicate = $.grep(duplicateList, function (val, idx) {
            return duplicateList[idx] == title.toUpperCase()
        });
    }
    if (title == "") {
        $("#tab1").html("Please Enter the title");
        return false;
    }
    else if (duplicate.length > 0) {
        $("#tab1").html("Title already exist");
    }
    else {
        valid = true;
    }
    if (country == "0" && state == "0" && city == "0") {
        $("#tab1").html("Please select any one of Country , State or City");
        return false;
    }
    else {
        valid = true;
    }

    if (cost == "") {
        $("#tab1").html("Please enter tour cost");
        return false;
    }
    else {
        valid = true;
    }
    var typeName = $("#ddltour option:selected").text();
    if (tourtype == "") {
        $("#tab1").html("Please select the tour type");
        return false;
    }
    else {
        valid = true;
    }
    if (typeName.toUpperCase() == "GROUP" && seat == "") {
        $("#tab1").html("Please enter no of seat");
        return false;
    }
    else {
        seat = 0;
        valid = true;
    }

    if (typeName.toUpperCase() == "GROUP") {
        if (inputFromDate == "" || inputToDate == "") {
            $("#tab1").html("Please select dates for the tour");
            return false;
        }
        else {
            valid = true;
        }
    }
    else {
        inputFromDate = "";
        inputToDate = "";
    }
    return valid;
}

function ValidateDataTab2() {
    $("#tab2").html("")
    var theme = $("#ddlTheme option:selected").val();
    var overview = $("#ContentPlaceHolder1_txtOverview").val();
    var valid = "";
    if (theme == undefined) {
        $("#tab2").html("Please select the theme");
        return false;
    }
    else {
        valid = true;
    }

    if (overview == "") {
        $("#tab2").html("Please enter overview of the tour");
        return false;
    }
    else {
        valid = true;
    }
    return valid;
}

function ValidateDataTab3() {
    $("#tab3").html("");
     totalDays = $("#no-of-days").val();
    var inclusion = $("#ContentPlaceHolder1_inclusion").val();
    var exclusion = $("#ContentPlaceHolder1_Exclusion").val();
    var valid = "";
    if (totalDays == "") {
        $("#tab3").html("Please enter total days of the tour");
        return false;
    }
    else {
        valid = true;
    }
    if (inclusion == "") {
        $("#tab3").html("Please Enter Inclusion for the trip");
        return false;
    }
    else {
        valid = true;
    }

    if (exclusion == "") {
        $("#tab3").html("Please Enter Exclusion for the trip")
    }
    else {
        valid = true;
    }
    return valid;
}


function ValidateTab4() {
    $("#tab3").html("");
    var uploadfiles = $("#pd-image").get(0);
    var uploadedfiles = uploadfiles.files;

    for (var i = 0; i < uploadedfiles.length; i++) {

        var ext = uploadedfiles[i].name.split('.').pop().toLowerCase();
        if (jQuery.inArray(ext, fileExtension) == '-1') {
            $("#tab3").html("select a valid file");
            return false;

        }

    }
}

function InsertTab1() {
    var locationstring = "";
    var title = $("#title-name").val();
    var country = $("#ddlcountry option:selected").val().replace("_", " ");
    var state = $("#ddlstate option:selected").val().replace("_", " ");
    var city = $("#ddlcity option:selected").val();
    var cost = $("#tour-cost").val();
    var tourtype = $("#ddltour option:selected").val();
    var seat = $("#seat-no").val();
    var tripDate = "";//$("reservation").val();
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
        locationstring +=  country;
    }
    
    $.ajax({
        type: "POST",
        url: url + "/InsertTab1",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ Title: title, Location: locationstring, Cost: cost, Tour: tourtype, TourSeat: seat, TourDate: tripDate }),
        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = msg.d.split("_");
                tripid = jsonobj[1];
               

                //$("#invalid_cred").text("Login Success");


            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function InsertTab2() {
    var selMulti = $.map($("#ddlTheme option:selected"), function (el, i) {
        return $(el).text();
    });

    //$('#activate').is(":checked")
    var overview = $("#txtOverview").val();
    var theme = selMulti.join(", ");

    $.ajax({
        type: "POST",
        url: url + "/InsertTab2",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ TripId: tripid, Theme: theme, Overview: overview }),
        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = msg.d.split("_");
                tripid = jsonobj[1];


                //$("#invalid_cred").text("Login Success");


            }
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
        async: false,
        success: function (msg) {
            if (msg.d != "") {
               
                var jsonobj = JSON.parse(msg.d);
                mapCountryList(jsonobj);
               
                //$("#invalid_cred").text("Login Success");
                bindCountryDropdown();
                getStateList();

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
        async: false,
        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                mapStateList(jsonobj);
                
                BindStateDropDown();
                //$("#invalid_cred").text("Login Success");

                getPlaceList();
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
        async: false,
        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                mapPlaceList(jsonobj);
                BindCityDropDown();
               
                //$("#invalid_cred").text("Login Success");
                

            }
            GetTripType();
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });

}

function getThemeList() {
    $.ajax({
        type: "POST",
        url: url + "/getThemeList",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                mapThemeList(jsonobj);

                //$("#invalid_cred").text("Login Success");
                bindThemeDropdown();
             
            }
            else {
                CountryList = null;
            }
            getTripMaster();
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });

}

function mapThemeList(jsonobj) {
    themeList = $.map(jsonobj, function (el) {
        return {
            0: el.THEMEID,
            1: el.THEMENAME

        }
    });
}
function bindThemeDropdown() {
    var appendvalue = "";
    $("#ddlTheme").empty();
    for (var i = 0; i <= themeList.length - 1; i++) {
        appendvalue += "<option value=" + themeList[i][1] + ">" + themeList[i][1] + "</option>";
    }
  
    $("#ddlTheme").append(appendvalue);
    $("#ddlTheme").selectpicker('refresh');

}

function mapTripImages(obj) {
    tripImageList = $.map(obj, function (el) {
        return {
            0: el.TRIPID,
            1: el.TRIPIMAGEID,
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
                    return "<img src=" + row[2] + " width=50% />"
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


function bindCountryDropdown() {
    var appendvalue = "";
    $("#ddlcountry").empty();
    for (var i = 0; i <= CountryList.length - 1; i++) {
        appendvalue += "<option value=" + CountryList[i][1].replace(" ","_") + ">" + CountryList[i][1] + "</option>";
    }
    $("#ddlcountry").append("<option value=0>Select</option>");
    $("#ddlcountry").append(appendvalue);
    $("#ddlcountry").selectpicker('refresh');
   
}

function BindStateDropDown() {
    var appendvalue = "";
    $("#ddlstate").empty();
    for (var i = 0; i <= StateList.length - 1; i++) {
        appendvalue += "<option value=" + StateList[i][1].replace(" ", "_") + ">" + StateList[i][1] + "</option>";
    }
    $("#ddlstate").append("<option value=0>Select</option>");
    $("#ddlstate").append(appendvalue);
    $("#ddlstate").selectpicker('refresh');
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


function GetTripType() {
    $.ajax({
        type: "POST",
        url: url + "/GetTripType",
        contentType: "application/json; charset=utf-8",
        async:false,
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
                mapTripType(jsonObj);
                bindTripType();
               
            }
            else {

            }
            getThemeList();

        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}
function mapTripType(obj) {
    TripType = $.map(obj, function (el) {
        return {
            0: el.TYPEID,
            1: el.TYPENAME

        }
    });
}

function bindTripType() {
    var appendvalue = "";
    $("#ddltour").empty();
    for (var i = 0; i <= TripType.length - 1; i++) {
        appendvalue += "<option value=" + TripType[i][0] + ">" + TripType[i][1] + "</option>";
    }
    $("#ddltour").append("<option value=0>Select</option>");
    $("#ddltour").append(appendvalue);
    $("#ddltour").selectpicker('refresh');
}

function showMainProcessing() {
    
    $('#modaloverlay').show();
   
}
function hideMainProcessing() {
    $('#modaloverlay').hide();
   
}