var CountryList = [];
var StateList = [];
var CityList = [];
var CountryTable = null;
var StateTable = null;
var CityTable = null;
var AllDataTable = null;
var countryid = "";
var stateid = "";
var cityid = "";

$(document).ready(function () {
    url = window.location.href;
    $("#title").text("Location Master");
    getCountryList();
    getStateList();
    getPlaceList();
    $("#btnCountry").show();
    $("#btnCountryEdit").hide();
    $("#btnCountryCancel").hide();

    $("#btnStateEdit").hide();
    $("#btnStateCancel").hide();

    $("#btnCityEdit").hide();
    $("#btnCityCancel").hide();


    $("#btnCountry").click(function (e) {
        e.preventDefault();
        insertCountry();
    });

    $("#btnCountryEdit").click(function (e) {
        e.preventDefault();
        EditCountry();
    });

    $("#btnStateEdit").click(function (e) {
        e.preventDefault();
        EditState();
    });

    $("#btnCityEdit").click(function (e) {
        e.preventDefault();
        EditPlace();
    });


    $("#btnConfirmCountry").click(function (e) {
        e.preventDefault();
        DeleteCountry();
    });

    $("#btnConfirmState").click(function (e) {
        e.preventDefault();
        DeleteState();
    });

    $("#btnConfirmCity").click(function (e) {
        e.preventDefault();
        DeleteCity();
    });

    $("#btnCountryCancel").click(function (e) {

        e.preventDefault();
        $("#country-name").val('');
        countryid = "";
        $("#btnCountry").show();
        $("#btnCountryEdit").hide();
        $("#btnCountryCancel").hide();
        $("#countryMessage").html("");
    });

    $("#btnStateCancel").click(function (e) {

        e.preventDefault();
        bindCountryDropdown();
        $("#state-name").val('');
        stateid = "";
        $("#btnState").show();
        $("#btnStateEdit").hide();
        $("#btnStateCancel").hide();
        $("#stateMessage").html("");
    });


    $("#btnCityCancel").click(function (e) {

        e.preventDefault();
        $("#place-name").val('');
        bindCountryDropdown();
        BindStateDropDown();
        cityid = "";
        $("#btnCity").show();
        $("#btnCityEdit").hide();
        $("#btnCityCancel").hide();
        $("#placeMessage").html("");
    });




    
    $("#btnState").click(function (e) {
        e.preventDefault();
        insertState();
    });

    $("#btnCity").click(function (e) {
        
        insertPlace();
        e.preventDefault();
    });

    $("#ddlcountry2").change(function (e) {
        var countryid = $("#ddlcountry2 option:selected").val();
        var filterarr = jQuery.grep(StateList, function (n, i) {
            return (StateList[i][3] == countryid);
            
        });
        $("#ddlstate").empty();
        var filtervalue = "";
        for (var i = 0; i <= filterarr.length - 1; i++) {
            filtervalue += "<option value=" + filterarr[i][0] + ">" + filterarr[i][2] + "</option>";
        }
        $("#ddlstate").append(filtervalue);

    });

   
});

function insertCountry() {
    $("#countryMessage").html("");
    var Country = $("#country-name").val();

    if (Country.trim() == "") {
        $("#countryMessage").html("Please Enter Country Name");
        return false;
    }

    $.ajax({
        type: "POST",
        url: url + "/insertCountry",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        data: JSON.stringify({ CountryName: Country.trim() }),

        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {
                    $("#country-name").val('');
                    $("#SuccessStatus").text("Country inserted Successfully");
                    $("#modal-success").modal("show");
                    getCountryList();
                   
                    //$("#invalid_cred").text("Login Success");
                }
                else {
                    $("#FailureStatus").text("Country already exist");
                    $("#modal-danger").modal("show");    
                }
               
            }
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Country already exist");
            $("#modal-danger").modal("show");
        }
    });

}

function EditCountry () {
    $("#countryMessage").html("");
    var Country = $("#country-name").val();

    if (Country == "") {
        $("#countryMessage").html("Please Enter Country Name");
        return false;
    }

    $.ajax({
        type: "POST",
        url: url + "/EditCountry",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        data: JSON.stringify({ CountryName: Country.trim(), countryId: countryid }),

        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {
                    $("#country-name").val('');
                    countryid = "";
                    $("#btnCountry").show();
                    $("#btnCountryEdit").hide();
                    $("#btnCountryCancel").hide();
                    $("#SuccessStatus").text("Country updated Successfully");
                    $("#modal-success").modal("show");
                    getCountryList();

                    //$("#invalid_cred").text("Login Success");
                }
                else {
                    $("#FailureStatus").text("Country already exist");
                    $("#modal-danger").modal("show");    
                }
            }
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while updating country");
            $("#modal-danger").modal("show");    
        }
    });
}

function DeleteCountry() {
    $("#countryMessage").html("");

    $.ajax({
        type: "POST",
        url: url + "/DeleteCountry",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        data: JSON.stringify({countryId: countryid }),

        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {
                   // $("#country-name").val('');
                   // countryid = "";
                    $("#SuccessStatus").text("Country deleted Successfully");
                    $("#modal-success").modal("show");
                    $("#deleteCountry").modal("hide");
                    getCountryList();
                    //getStateList();
                    //getPlaceList();

                    //$("#invalid_cred").text("Login Success");
                }
                else {
                    $("#FailureStatus").text("Error while deleting country");
                    $("#modal-danger").modal("show");
                }
            }
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while deleting country");
            $("#modal-danger").modal("show");
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
               BindCountryList();
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });

}

function bindCountryDropdown() {
    var appendvalue = "";
    $("#ddlCountry").empty();
    $("#ddlcountry2").empty();
   
    for (var i = 0; i <= CountryList.length - 1; i++) {
        appendvalue += "<option value=" + CountryList[i][0] + ">" + CountryList[i][1] + "</option>";
    }
    $("#ddlCountry").append("<option value=0>Select Country</option>")
    $("#ddlcountry2").append("<option value=0>Select Country</option>")
    $("#ddlCountry").append(appendvalue);
    $("#ddlcountry2").append(appendvalue);
}

function mapCountryList(jsonobj) {

    CountryList = $.map(jsonobj, function (el) {
        return {
            0: el.COUNTRYID,
            1: el.COUNTRYNAME

        }
    });
}

function BindCountryList() {
    if (CountryTable != null) {
        $("#tblCountry").empty();
    }
    CountryTable = $("#tblCountry").dataTable({
        "data": CountryList,
        "bDestroy": true,
        "bPaginate": true,

        'autoWidth': false,
        //"aaSorting": [[1, "asc"]],
        searching: true,
        "columnDefs": [
            { "targets": [0], "searchable": false, "visible": false, "sortable": true, "title": "Country id", "className": "col-xs-1" },
            { "targets": [1], "searchable": true, "sortable": true, "title": "Country", "className": "col-xs-1" },
            {
                "targets": [2], "searchable": true, "title": "Edit/Delete", "className": "col-xs-1",
                "render": function (data, type, row) {
                    return "<div class='pull-left'><a id = 'edit-" + row[0] + "' class='set-alert' href=''><i class='fa fa-pencil-square' aria-hidden='true'></i></a></div><div class='pull-right' style='padding-right:10px;font-size:18px;'><a  id = 'clear-" + row[0] + "'  href='' class= 'set-alert'><i class='fa fa-times-circle' aria-hidden='true'></i></a></div>";
                }
            }
        ]
    });
    bindCountryEvents(CountryTable);
}

function bindCountryEvents(CountryTable) {
    $("#tblCountry").on("click", ".set-alert", function (e) {
        $("#countryMessage").html("");
        e.preventDefault();
        var rowid = $(this).attr("id");

        var country = rowid.split("-");

        countryid = country[1];
        var countryarr = $.grep(CountryList, function (val, idx) {
            return CountryList[idx][0] == countryid
        });

        if (country[0] == "edit") {

            $("#country-name").val(countryarr[0][1]);
            
            $("#btnCountry").hide();
            $("#btnCountryCancel").show();
            $("#btnCountryEdit").show();
        }
        else {
            
            $("#CountryName").html(countryarr[0][1]);
            $("#deleteCountry").modal("show");
        }
    });
}
function insertState() {
    $("#stateMessage").html("");
    var Country = $("#ddlCountry option:selected").val();
    var state = $("#state-name").val();
    if (Country == "0") {
        $("#stateMessage").html("Please select Country Name");
        return false;
    }
    else {
        $("#stateMessage").html("");
    }
    if (state.trim() == "") {
        $("#stateMessage").html("Please enter City Name");
        return false;
    }
    else {
        $("#stateMessage").html("");
    }

    $.ajax({
        type: "POST",
        url: url + "/insertState",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        data: JSON.stringify({ CountryId: Country, StateName: state.trim() }),

        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {
                    $("#state-name").val('');
                    bindCountryDropdown();
                    $("#SuccessStatus").text("City inserted successfully");
                    $("#modal-success").modal("show");
                    getStateList();

                    //$("#invalid_cred").text("Login Success");
                }
                else {
                    $("#FailureStatus").text("City already exist");
                    $("#modal-danger").modal("show");
                }
            }
        },
        Error: function (x, e) {
            $("#FailureStatus").text("City already exist");
            $("#modal-danger").modal("show");
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

               // BindStateDropDown();
                //$("#invalid_cred").text("Login Success");


            }
            else {
                StateList = null;
            }
            BindStateDropDown();
            BindStateList();
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });

}

function EditState() {
    $("#stateMessage").html("");

    var state = $("#state-name").val();
    var Country = $("#ddlCountry option:selected").val();

    if (state == "") {
        $("#stateMessage").html("Please enter City Name");
        return false;
    }

    $.ajax({
        type: "POST",
        url: url + "/EditState",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        data: JSON.stringify({ CountryName: Country.trim(), StateId: stateid,StateName:state.trim() }),

        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {
                    $("#state-name").val('');
                    stateid = "";
                    $("#btnState").show();
                    $("#btnStateEdit").hide();
                    $("#btnStateCancel").hide();
                    $("#SuccessStatus").text("City updated successfully");
                    $("#modal-success").modal("show");
                    getStateList();

                    //$("#invalid_cred").text("Login Success");
                }
                else {
                    $("#FailureStatus").text("City already exist");
                    $("#modal-danger").modal("show");
                }
            }
        },
        Error: function (x, e) {
            $("#FailureStatus").text("City already exist");
            $("#modal-danger").modal("show");
        }
    });
}

function DeleteState() {
    $("#stateMessage").html("");

    $.ajax({
        type: "POST",
        url: url + "/DeleteState",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        data: JSON.stringify({ Stateid: stateid }),

        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {
                    // $("#country-name").val('');
                    // countryid = "";
                    getStateList();
                    //getPlaceList();
                    $("#SuccessStatus").text("City deleted successfully");
                    $("#modal-success").modal("show");
                    $("#deleteCountry").modal("hide");
                    
                    //$("#invalid_cred").text("Login Success");
                }
                else {
                    //alert("Country already exist")
                    $("#FailureStatus").text("Error while deleting City");
                    $("#modal-danger").modal("show");
                }
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}



function mapStateList(jsonobj) {
    StateList = $.map(jsonobj, function (el) {
        return {
            0: el.STATEID,
            1: el.COUNTRYNAME,
            2: el.STATENAME,
            3: el.COUNTRYID


        }
    });
}

function BindStateList() {
    if (StateTable != null) {
        StateTable.fnDestroy();
        $("#tblState").empty();
    }
    StateTable = $("#tblState").dataTable({
        "data": StateList,
        "bDestroy": true,
        "bPaginate": true,

        'autoWidth': false,
        //"aaSorting": [[1, "asc"]],
        searching: true,
        "columnDefs": [
            { "targets": [0], "searchable": false, "visible": false, "sortable": true, "title": "State id", "className": "col-xs-1" },
            { "targets": [1], "searchable": true, "sortable": true, "title": "Country Name", "className": "col-xs-1" },
            { "targets": [2], "searchable": true, "sortable": true, "title": "City Name", "className": "col-xs-1" },
            {
                "targets": [3], "searchable": true, "title": "Edit/Delete", "className": "col-xs-1",
                "render": function (data, type, row) {
                    return "<div class='pull-left'><a id = 'edit-" + row[0] + "' class='set-alert1' href=''><i class='fa fa-pencil-square' aria-hidden='true'></i></a></div><div class='pull-right' style='padding-right:10px;font-size:18px;'><a  id = 'clear-" + row[0] + "'  href='' class= 'set-alert1'><i class='fa fa-times-circle' aria-hidden='true'></i></a></div>";
                }
            }
        ]
    });

    bindStateEvents(StateTable)
}

function BindStateDropDown() {
    var appendvalue = "";
    $("#ddlstate").empty();
    $("#ddlstate").append("<option value=0>Select City</option>")
    for (var i = 0; i <= StateList.length - 1; i++) {
        appendvalue += "<option value=" + StateList[i][0] + ">" + StateList[i][2] + "</option>";
    }

    $("#ddlstate").append(appendvalue);
}

function bindStateEvents(StateTable) {
    $("#tblState").on("click", ".set-alert1", function (e) {
        $("#stateMessage").html("");

        e.preventDefault();
        var rowid = $(this).attr("id");

        var state = rowid.split("-");

        stateid = state[1];
        var statearr = $.grep(StateList, function (val, idx) {
            return StateList[idx][0] == stateid
        });

        if (state[0] == "edit") {

            $("#state-name").val(statearr[0][2]);
            $("#ddlCountry option[value=" + statearr[0][3]+"]").attr("selected",true);
            $("#btnState").hide();
            $("#btnStateCancel").show();
            $("#btnStateEdit").show();
        }
        else {
            
            $("#StateName").html(statearr[0][2]);
            $("#deleteState").modal("show");
        }
    });
}

function insertPlace() {
    $("#placeMessage").html("");

    var Country = $("#ddlcountry2 option:selected").val();
    var state = $("#ddlstate option:selected").val();
    var city = $("#place-name").val();
    if (Country == "") {
        $("#placeMessage").html("Please Select Country Name");
    }
    if (state == "0") {
        $("#placeMessage").html("Please Select City Name");
    }
    if (city.trim() == "") {
        $("#placeMessage").html("Please Enter Place Name");
        return false;
    }

    $.ajax({
        type: "POST",
        url: url + "/insertCity",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        data: JSON.stringify({ CountryId: Country, StateName: state.trim(), CityName: city.trim() }),

        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {
                    $("#place-name").val('');
                    bindCountryDropdown();
                    BindStateDropDown();
                    $("#ddlcountry2 option[value=0]").attr("selected", true);
                    $("#ddlstate option[value=0]").attr("selected", true);
                    $("#SuccessStatus").text("City inserted successfully");
                    $("#modal-success").modal("show");
                    getPlaceList();

                    //$("#invalid_cred").text("Login Success");
                }
                else {
                   // alert("Place already exist in the list")
                    $("#FailureStatus").text("Place already exist");
                    $("#modal-danger").modal("show");
                }
            }
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while deleting place");
            $("#modal-danger").modal("show");
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

                //$("#invalid_cred").text("Login Success");


            }
            else {
                CityList = null;
            }
            BindPlaceList();
            BindAllData();
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });

}

function EditPlace() {
    $("#placeMessage").html("");

    var state = $("#ddlstate option:selected").val();
    var Country = $("#ddlCountry2 option:selected").val();
    var city = $("#place-name").val();

    if (city == "") {
        $("#placeMessage").html("Please Enter Place Name");
        return false;
    }

    $.ajax({
        type: "POST",
        url: url + "/EditPlace",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        data: JSON.stringify({ StateId: state, CityName: city.trim(), CityId: cityid }),

        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {
                    $("#place-name").val('');
                    bindCountryDropdown();
                    BindStateDropDown();
                    $("#btnCity").show();
                    $("#btnCityEdit").hide();
                    $("#btnCityCancel").hide();
                    $("#SuccessStatus").text("Place updated successfully");
                    $("#modal-success").modal("show");
                    getPlaceList();

                    //$("#invalid_cred").text("Login Success");
                }
                else {
                    $("#FailureStatus").text("Error while updating Place");
                    $("#modal-danger").modal("show");
                }
            }
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while updating Place");
            $("#modal-danger").modal("show");
        }
    });
}

function DeleteCity() {
    $("#placeMessage").html("");

    $.ajax({
        type: "POST",
        url: url + "/DeletePlace",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        data: JSON.stringify({ CityId: cityid }),

        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {
                    // $("#country-name").val('');
                    // countryid = "";
                    $("#SuccessStatus").text("Place deleted successfully");
                    $("#modal-success").modal("show");
                    $("#deleteCity").modal("hide");
                    getPlaceList();

                    //$("#invalid_cred").text("Login Success");
                }
                else {
                    //alert("Country already exist")
                    $("#FailureStatus").text("Error while deleting Place");
                    $("#modal-danger").modal("show");
                }
            }
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while deleting Place");
            $("#modal-danger").modal("show");
        }
    });
}

function mapPlaceList(jsonobj) {
    CityList = $.map(jsonobj, function (el) {
        return {
            0: el.CITYID,
            1: el.COUNTRYNAME,
            2: el.STATENAME,
            3: el.CITYNAME,
            4: el.STATEID,
            5: el.COUNTRYID



        }
    });
}

function BindPlaceList() {
    if (CityTable != null) {
        $("#tblcity").empty();
    }
    CityTable = $("#tblcity").dataTable({
        "data": CityList,
        "bDestroy": true,
        "bPaginate": true,

        'autoWidth': false,
        //"aaSorting": [[1, "asc"]],
        searching: true,
        "columnDefs": [
            { "targets": [0], "searchable": false, "visible": false, "sortable": true, "title": "City id", "className": "col-xs-1" },
            { "targets": [1], "searchable": true, "sortable": true, "title": "Country Name", "className": "col-xs-1" },
            { "targets": [2], "searchable": true, "sortable": true, "title": "City Name", "className": "col-xs-1" },
            { "targets": [3], "searchable": true, "sortable": true, "title": "Place Name", "className": "col-xs-1" },
            {
                "targets": [4], "searchable": true, "title": "Edit/Delete", "className": "col-xs-1",
                "render": function (data, type, row) {
                    return "<div class='pull-left'><a id = 'edit-" + row[0] + "' class='set-alert2' href=''><i class='fa fa-pencil-square' aria-hidden='true'></i></a></div><div class='pull-right' style='padding-right:10px;font-size:18px;'><a  id = 'clear-" + row[0] + "'  href='' class= 'set-alert2'><i class='fa fa-times-circle' aria-hidden='true'></i></a></div>";
                }
            }
        ]
    });
    bindCityEvents(CityTable)
}

function bindCityEvents(CityTable) {
    $("#tblcity").on("click", ".set-alert2", function (e) {
        $("#placeMessage").html("");
        e.preventDefault();
        var rowid = $(this).attr("id");

        var city = rowid.split("-");

        cityid = city[1];
        var cityarr = $.grep(CityList, function (val, idx) {
            return CityList[idx][0] == cityid
        });

        if (city[0] == "edit") {

            $("#place-name").val(cityarr[0][3]);
            $("#ddlcountry2 option[value=" + cityarr[0][5] + "]").attr("selected", true);
            $("#ddlstate option[value=" + cityarr[0][4] + "]").attr("selected", true);
            $("#btnCity").hide();
            $("#btnCityCancel").show();
            $("#btnCityEdit").show();
        }
        else {
           
            $("#CityName").html(cityarr[0][3]);
            $("#deletecity").modal("show");
        }
    });
}

function BindAllData() {
    if (AllDataTable != null) {
        $("#tblAllDestination").empty();
    }
    AllDataTable = $("#tblAllDestination").dataTable({
        "data": CityList,
        "bDestroy": true,
        "bPaginate": true,

        'autoWidth': false,
        //"aaSorting": [[1, "asc"]],
        searching: true,
        "columnDefs": [
            { "targets": [0], "searchable": false, "visible": false, "sortable": true, "title": "City id", "className": "col-xs-1" },
            { "targets": [1], "searchable": true, "sortable": true, "title": "Country Name", "className": "col-xs-1" },
            { "targets": [2], "searchable": true, "sortable": true, "title": "City Name", "className": "col-xs-1" },
            { "targets": [3], "searchable": true, "sortable": true, "title": "Place Name", "className": "col-xs-1" }
            
        ]
    });
}
