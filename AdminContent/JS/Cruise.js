var url = "CruiseMaster.aspx";
var CountryList = [];
var CompanyList = [];
var OnboardList = [];
var fileExtension = ["jpg", "jpeg", "png"];
var CruiseId = "";
var Interior = 1;
var Ocean = 2;
var Balcony = 3;
var Suite = 4;
var TableData = [];
var IntCounter = 1;
var OcnCounter = 1;
var BalCounter = 1;
var SuiCounter = 1;
var ItenaryCount = 1;
var IsvalidInt = false;
var IsvalidOcn = false;
var IsvalidBal = false;
var IsvalidSui = false;
var IsvalidIten = false;
var loopIntTill = 1;
var loopOcnTill = 1;
var loopBalTill = 1;
var loopSuiTill = 1;
var loopItenTill = 1;
var Grosston = 1;
var NoOfPass = 2;
var SLength = 3;
var Decks = 4;
var AvgSpeed = 5;
var Crew = 6;
var NoOfState = 7;
var SWidth = 8;
var CruiseMasterTable = null;
var CruiseMasterList = [];
var CruiseImageList = [];
var CruiseImageTable = null;
var imageid = 0;
var tab1 = [];
var tab2 = [];
var tab3 = [];
var tab4 = [];
var tab5 = [];
var tab6 = [];
var flag = "";

var isDateAdded = 1;
var tempDateArray = []
var TempTableArray = [];
var dataCount = 1;
var editId;
$(document).ready(function () {
    $("#modaloverlay").hide();
    $("#title").text("Cruise Master");
    $("#btnUpdateTemp").hide();
    CruiseId = GetParameterValues("CruiseId");
    if (CruiseId != undefined) {
        $("#btnUpdate").show();
        $("#btnfinish").hide();
       // $("#newcruise").hide();
        flag = "U";
    }
    else {
        $("#btnUpdate").hide();
        $("#btnfinish").show();
    }
    getCompanyList();
    getCountryList();
    GetOnBoardActivites();
    $("#btnConfirm").click(function (e) {
        e.preventDefault();
        DeleteCruise();
    });
    
    $("#AddRowInt").click(function (e) {
        if (loopIntTill > 1) {
            ValidateCabinInterior();
        }
        if (loopIntTill == 1 || IsvalidInt == true) {
            $('#tbl-Int > tbody:last-child').append('<tr><td style="text-align:center"><span id="Int_' + loopIntTill + '">' + IntCounter + '</span></td><td><input type="text" id="Int_startdt_' + loopIntTill + '" class="form-control daterange-picker" readonly="true"/></td><td><input type="text" id="Int_enddt_' + loopIntTill + '" class="form-control daterange-picker" readonly="true"/></td><td><input type="text" id="Int_Price_' + loopIntTill + '" class="form-control integer"/></td><td style="text-align:center"><span class="set-alert2" id="Int_del_' + loopIntTill + '" onClick="removeRowInt(this);"><i class="fa fa-times-circle"></i></span></td><td style="display:none"><span id="Int_Cabin_Price_' + loopIntTill + '">0</span></td></tr>');
            IntCounter++;
            loopIntTill++;
            AssignDatePicker();
            AssignValidateNumber();
        }
    });
    if (CruiseId != undefined) {
        $("#AddRowInt").click();
    }



    $("#btnfinish").click(function (e) {
        e.preventDefault();
        InsertAllData();
    });

    //$("#btnfinish").click(function (e) {
    //    e.preventDefault();
    //    InsertAllData();
    //});

    $("#btnUpdate").click(function (e) {
        e.preventDefault();
        InsertAllData();
    });

    $("#InteriorCheck").change(function () {
        if (this.checked) {
            $("#interiorDiv").addClass("hidden").removeClass("hidden");
        }
        else {
            $("#interiorDiv").addClass("hidden");
        }
    });
    $("#OceanCheck").change(function () {
        if (this.checked) {
            $("#OceanDiv").addClass("hidden").removeClass("hidden");
        }
        else {
            $("#OceanDiv").addClass("hidden");
        }
    });
    $("#balconyCheck").change(function () {
        if (this.checked) {
            $("#BalconyDiv").addClass("hidden").removeClass("hidden");
        }
        else {
            $("#BalconyDiv").addClass("hidden");
        }
    });
    $("#SuiteCheck").change(function () {
        if (this.checked) {
            $("#SuiteDiv").addClass("hidden").removeClass("hidden");
        }
        else {
            $("#SuiteDiv").addClass("hidden");
        }
    });

    $("#confirmImage").click(function (e) {
        e.preventDefault();
        DeleteImage();
    });

    $("#close").click(function () {
        window.location.href = url;
    });

    $("#allCheck").change(function () {
        if (this.checked) {
            $(".allCabin").prop('checked', true);
            $("#interiorDiv").addClass("hidden").removeClass("hidden");
            $("#OceanDiv").addClass("hidden").removeClass("hidden");
            $("#BalconyDiv").addClass("hidden").removeClass("hidden");
            $("#SuiteDiv").addClass("hidden").removeClass("hidden");
        }
        else {
            $(".allCabin").prop('checked', false);
            $("#interiorDiv").addClass("hidden");
            $("#OceanDiv").addClass("hidden");
            $("#BalconyDiv").addClass("hidden");
            $("#SuiteDiv").addClass("hidden");

        }
    });

    $("#btnAddDDates").click(function (e) {
        e.preventDefault();
        $("#inpFromDate").val("");
         $("#inpToDate").val("");
         $("#txtMainPrice").val("");
         $("#InteriorCheck").prop("checked", false);
         $("#intPrice").val("");
         $("#OceanCheck").prop("checked", false);
         $("#OceanPrice").val("");
         $("#balconyCheck").prop("checked", false);
         $("#BalPrice").val("");
         $("#SuiteCheck").prop("checked", false);
         $("#SuitePrice").val("");
         $("#btnaddTempData").show();
         $("#btnUpdateTemp").hide();
        $("#CabinData").modal("show");
    });
    $("#btnaddTempData").click(function (e) {
        //tempDateArray = [];
        //var dataCount = 1;
        var valid = validateNewtable();
        if (valid == 1) {
            var fromdt = $("#inpFromDate").val();
            var Todt = $("#inpToDate").val();
            var mainPrice = $("#txtMainPrice").val();

            TempTableArray.push({ from: fromdt, ToDate: Todt, Price: mainPrice, id: dataCount })
            if ($("#InteriorCheck").prop("checked")) {
                var price = $("#intPrice").val();
                tempDateArray.push({ from: fromdt, to: Todt, cabinid: 1, MainCost: mainPrice, Price: price, CabId: 0, Id: dataCount });
            }
            if ($("#OceanCheck").prop("checked")) {
                var price = $("#OceanPrice").val();
                tempDateArray.push({ from: fromdt, to: Todt, cabinid: 2, MainCost: mainPrice, Price: price, CabId: 0, Id: dataCount });
            }

            if ($("#balconyCheck").prop("checked")) {
                var price = $("#BalPrice").val();
                tempDateArray.push({ from: fromdt, to: Todt, cabinid: 3, MainCost: mainPrice, Price: price, CabId: 0, Id: dataCount });
            }

            if ($("#SuiteCheck").prop("checked")) {
                var price = $("#SuitePrice").val();
                tempDateArray.push({ from: fromdt, to: Todt, cabinid: 4, MainCost: mainPrice, Price: price, CabId: 0, Id: dataCount });
            }
            var DateTable = $("#tblDates tbody");
            // DateTable.empty();
            // for (var i = 0; i <= TempTableArray.length - 1; i++) {


            DateTable.append("<tr><td class='hidden'>" + dataCount + "</td>" + "<td>" + fromdt + "</td><td>" + Todt + "</td><td>" + mainPrice + "</td>" +
                "<td><span style='cursor:pointer' class='Editrow' id='editrow-" + dataCount + "'><i class='fa fa-pencil-square'></i></span></td> <td><span style='cursor:pointer' class='deleterow' id='delete-" + dataCount + "'><i class='fa fa-times-circle'></i></span></td></tr > ");
            dataCount++;
            //}

            $("#CabinData").modal("hide");
        }
    });

    $("#tblDates ").on("click", ".deleterow", function () {
        var DeleteArr = [];
        var idStr = this.closest("span").id;
        var id = idStr.split("-");
        this.closest("tr").remove();
        DeleteArr = jQuery.grep(TempTableArray, function (value) {
            return value["id"] == id[1];
        });
        TempTableArray = jQuery.grep(TempTableArray, function (value) {
            return value["id"] != id[1];
        });
        tempDateArray = jQuery.grep(tempDateArray, function (value) {
            return value["Id"] != id[1];
        });
        if (flag = "U") {
            var from = DeleteArr[0]["from"];
            var to = DeleteArr[0]["ToDate"];
            DeleteCruiseDate(CruiseId,from,to);
            this.closest("tr").remove();
        }
        else {
            this.closest("tr").remove();
        }
      
       // dataCount--;


        

    })

    $("#tblDates ").on("click", ".Editrow", function () {
        $("#InteriorCheck").prop("checked", false);
        $("#intPrice").val("");
        $("#OceanCheck").prop("checked", false);
        $("#OceanPrice").val("");
        $("#balconyCheck").prop("checked", false);
        $("#BalPrice").val("");
        $("#SuiteCheck").prop("checked", false);
        $("#SuitePrice").val("");
        var idStr = this.closest("span").id;
        var id = idStr.split("-");
        editId = id[1];
        var tabledates = [];
        var dateArr = [];
        tabledates = jQuery.grep(TempTableArray, function (value) {
            return value["id"] == id[1];
        });
        dateArr = jQuery.grep(tempDateArray, function (value) {
            return value["Id"] == id[1];
        });

        $("#inpFromDate").val(moment(tabledates[0]["from"]).format("DD-MMM-YYYY"));
        $("#inpToDate").val(moment(tabledates[0]["ToDate"]).format("DD-MMM-YYYY"));
        $("#txtMainPrice").val(tabledates[0]["Price"]);
        
        $.each(dateArr, function (i) {
            if (dateArr[i]["cabinid"] == 1) {
                $("#InteriorCheck").prop("checked", true);
                $("#intPrice").val(dateArr[i]["Price"]);

            }
            
            if (dateArr[i]["cabinid"] == 2) {
                $("#OceanCheck").prop("checked", true);
                $("#OceanPrice").val(dateArr[i]["Price"]);

            }
            
            if (dateArr[i]["cabinid"] == 3) {
                $("#balconyCheck").prop("checked", true);
                $("#BalPrice").val(dateArr[i]["Price"]);

            }
            
            if (dateArr[i]["cabinid"] == 4) {
                $("#SuiteCheck").prop("checked", true);
                $("#SuitePrice").val(dateArr[i]["Price"]);

            }
            
        });
        $("#btnaddTempData").hide();
        $("#btnUpdateTemp").show();
        $("#CabinData").modal("show");



    })

    $("#btnUpdateTemp").click(function (e) {

        e.preventDefault();
        var valid = validateoldtable();
        if (valid == 1) {
            var fromdt = $("#inpFromDate").val();
            var Todt = $("#inpToDate").val();
            var mainPrice = $("#txtMainPrice").val();
           
            if (flag == "U") {
                
                for (var i in tempDateArray) {
                    if (tempDateArray[i].Id == editId) {
                        tempDateArray[i].from = fromdt;
                        tempDateArray[i].to = Todt;
                        tempDateArray[i].MainCost = mainPrice;
                       // tempDateArray[i].Price = mainPrice;
                        if (tempDateArray[i].cabinid == 1) {
                            tempDateArray[i].Price = $("#intPrice").val();
                        }
                        else if (tempDateArray[i].cabinid == 2) {
                            tempDateArray[i].Price = $("#OceanPrice").val();
                        }
                        else if (tempDateArray[i].cabinid == 3) {
                            tempDateArray[i].Price = $("#BalPrice").val();
                        }
                        else {
                            tempDateArray[i].Price = $("#SuitePrice").val();
                        }

                       // break; //Stop this loop, we found it!
                    }
                }

            }
            else {
                tempDateArray = jQuery.grep(tempDateArray, function (value) {
                    return value["Id"] != editId;
                });

                if ($("#InteriorCheck").prop("checked")) {
                    var price = $("#intPrice").val();
                    tempDateArray.push({ from: fromdt, to: Todt, cabinid: 1, MainCost: mainPrice, Price: price, CabId: 0, Id: editId });
                }
                if ($("#OceanCheck").prop("checked")) {
                    var price = $("#OceanPrice").val();
                    tempDateArray.push({ from: fromdt, to: Todt, cabinid: 2, MainCost: mainPrice, Price: price, CabId: 0, Id: editId });
                }

                if ($("#balconyCheck").prop("checked")) {
                    var price = $("#BalPrice").val();
                    tempDateArray.push({ from: fromdt, to: Todt, cabinid: 3, MainCost: mainPrice, Price: price, CabId: 0, Id: editId });
                }

                if ($("#SuiteCheck").prop("checked")) {
                    var price = $("#SuitePrice").val();
                    tempDateArray.push({ from: fromdt, to: Todt, cabinid: 4, MainCost: mainPrice, Price: price, CabId: 0, Id: editId });
                }
            }

            for (var i in TempTableArray) {
                if (TempTableArray[i].id == editId) {
                    TempTableArray[i].from = fromdt;
                    TempTableArray[i].ToDate = Todt;
                    TempTableArray[i].Price = mainPrice;
                    //break; //Stop this loop, we found it!
                }
            }
            var DateTable = $("#tblDates tbody");
            DateTable.empty();
            $.each(TempTableArray, function (i) {
                DateTable.append("<tr><td class='hidden'>" + TempTableArray[i]["id"] + "</td>" + "<td>" + TempTableArray[i]["from"] + "</td><td>" + TempTableArray[i]["ToDate"] + "</td><td>" + TempTableArray[i]["Price"] + "</td>" +
                    "<td><span style='cursor:pointer' class='Editrow' id='editrow-" + TempTableArray[i]["id"] + "'><i class='fa fa-pencil-square'></i></span></td> <td><span style='cursor:pointer' class='deleterow' id='delete-" + TempTableArray[i]["id"] + "'><i class='fa fa-times-circle'></i></span></td></tr > ");

            });
            $("#CabinData").modal("hide");
        }
    });
    //changes for date picker selector
    //$("#btnAddDDates").click(function (e) {
    //    e.preventDefault();
    //    var fromdate = $("#inpFromDate").val();
    //    var todate = $("#inpToDate").val();
    //    var isChecked = $("input:checkbox[name=cabin]:checked").val()
    //    var IsInterior = $("#InteriorCheck").prop("checked");
    //    var IsOcean = $("#OceanCheck").prop("checked");
    //    var IsBalcony = $("#balconyCheck").prop("checked");
    //    var IsSuite = $("#SuiteCheck").prop("checked");
    //    var isValid = "";

    //    if (fromdate == "") {
    //        $("#dateMsg").html("Please select Start Date");
    //        IsvalidInt = false;
    //        return IsvalidInt;
    //        return false;
    //    }


    //    else if (todate == "") {
    //        $("#dateMsg").html("Please select End Date ");
    //        IsvalidInt = false;

    //        return false;
    //    }
    //    else if (moment(fromdate) < moment()) {
    //        $("#dateMsg").html("Start date should be greater than current date ");
    //        IsvalidInt = false;

    //        return false;
    //    }

    //    else if (moment(fromdate) > moment(todate)) {
    //        $("#dateMsg").html("Start date should be smaller then End date");

    //        return false;
    //    }
    //    else if (isChecked == undefined) {
    //        $("#dateMsg").html("Please select cabin for the cruise");
    //        return false;
    //    }
    //    else {
    //        $("#dateMsg").html("");
    //    }


    //    //if (loopIntTill > 1) {
    //    //    ValidateCabinInterior();

    //    //}
    //    //if (loopOcnTill > 1) {
    //    //    ValidateCabinOcean();
    //    //}

    //    //if (loopBalTill > 1) {
    //    //    ValidateCabinBal();
    //    //}

    //    //if (loopSuiTill > 1) {
    //    //    ValidateCabinSuite();
    //    //}

    //    // if (isDateAdded == 1 || (IsvalidInt == true && IsvalidBal == true && IsvalidOcn == true && IsvalidSui == true)) {

    //    if (IsInterior == true) {

    //        $('#tbl-Int > tbody:last-child').append('<tr><td style="text-align:center"><span id="Int_' + loopIntTill + '">' + IntCounter + '</span></td><td><input type="text" id="Int_startdt_' + loopIntTill + '" class="form-control daterange-picker" readonly="true"/></td><td><input type="text" id="Int_enddt_' + loopIntTill + '" class="form-control daterange-picker" readonly="true"/></td><td><input type="text" id="Int_Price_' + loopIntTill + '" class="form-control integer"/></td><td style="text-align:center"><span class="set-alert2" id="Int_del_' + loopIntTill + '" onClick="removeRowInt(this);"><i class="fa fa-times-circle"></i></span></td><td style="display:none"><span id="Int_Cabin_Price_' + loopIntTill + '">0</span></td></tr>');

    //        $("#Int_startdt_" + loopIntTill).val(fromdate);
    //        $("#Int_enddt_" + loopIntTill).val(todate)
    //        IntCounter++;
    //        loopIntTill++;
    //    }
    //    if (IsOcean == true) {
    //        $('#tbl-Ocean > tbody:last-child').append('<tr><td style="text-align:center"><span id="Ocn_' + loopOcnTill + '">' + OcnCounter + '</span></td><td><input type="text" id="Ocn_startdt_' + loopOcnTill + '" class="form-control daterange-picker" readonly="true"/></td><td><input type="text" id="Ocn_enddt_' + loopOcnTill + '" class="form-control daterange-picker" readonly="true"/></td><td><input type="text" id="Ocn_Price_' + loopOcnTill + '" class="form-control integer"/></td><td style="text-align:center"><span class="set-alert2" id="Ocn_del_' + loopOcnTill + '" onClick="removeRowOcn(this);"><i class="fa fa-times-circle"></i></span></td><td style="display:none"><span id="Ocn_Cabin_Price_' + loopOcnTill + '">0</span></td></tr>');
    //        $("#Ocn_startdt_" + loopOcnTill).val(fromdate);
    //        $("#Ocn_enddt_" + loopOcnTill).val(todate)
    //        OcnCounter++;
    //        loopOcnTill++;
    //    }

    //    if (IsBalcony == true) {
    //        $('#tbl-Bal > tbody:last-child').append('<tr><td style="text-align:center"><span id="Bal_' + loopBalTill + '">' + BalCounter + '</span></td><td><input type="text" id="Bal_startdt_' + loopBalTill + '" class="form-control daterange-picker" readonly="true"/></td><td><input type="text" id="Bal_enddt_' + loopBalTill + '" class="form-control daterange-picker" readonly="true"/></td><td><input type="text" id="Bal_Price_' + loopBalTill + '" class="form-control integer"/></td><td style="text-align:center"><span class="set-alert2" id="Bal_del_' + loopBalTill + '" onClick="removeRowBal(this);"><i class="fa fa-times-circle"></i></span></td><td style="display:none"><span id="Bal_Cabin_Price_' + loopBalTill + '">0</span></td></tr>');
    //        $("#Bal_startdt_" + loopBalTill).val(fromdate);
    //        $("#Bal_enddt_" + loopBalTill).val(todate)
    //        BalCounter++;
    //        loopBalTill++;
    //    }
    //    if (IsSuite == true) {

    //        $('#tbl-Sui > tbody:last-child').append('<tr><td style="text-align:center"><span id="Sui_' + loopSuiTill + '">' + SuiCounter + '</span></td><td><input type="text" id="Sui_startdt_' + loopSuiTill + '" class="form-control daterange-picker" readonly="true"/></td><td><input type="text" id="Sui_enddt_' + loopSuiTill + '" class="form-control daterange-picker" readonly="true"/></td><td><input type="text" id="Sui_Price_' + loopSuiTill + '" class="form-control integer"/></td><td style="text-align:center"><span class="set-alert2" id="Sui_del_' + loopSuiTill + '" onClick="removeRowSui(this);"><i class="fa fa-times-circle"></i></span></td><td style="display:none"><span id="Sui_Cabin_Price_' + loopSuiTill + '">0</span></td></tr>');
    //        $("#Sui_startdt_" + loopSuiTill).val(fromdate);
    //        $("#Sui_enddt_" + loopSuiTill).val(todate)
    //        SuiCounter++;
    //        loopSuiTill++;
    //    }
    //    AssignValidateNumber();
    //    // }
    //    isDateAdded++;
    //    $("#btntab2").attr("disabled", false);
    //    $("input:checkbox[name=cabin]").prop("checked", false);
    //});
    $(document).keypress(function (event) {

        var keycode = (event.keyCode ? event.keyCode : event.which);
        if (keycode == '13') {
            event.preventDefault();
            return false;
        }

    });

  


    $("#AddRowOcean").click(function () {
        if (loopOcnTill > 1) {
            ValidateCabinOcean();
        }
        if (loopOcnTill == 1 || IsvalidOcn == true) {
            $('#tbl-Ocean > tbody:last-child').append('<tr><td style="text-align:center"><span id="Ocn_' + loopOcnTill + '">' + OcnCounter + '</span></td><td><input type="text" id="Ocn_startdt_' + loopOcnTill + '" class="form-control daterange-picker" readonly="true"/></td><td><input type="text" id="Ocn_enddt_' + loopOcnTill + '" class="form-control daterange-picker" readonly="true"/></td><td><input type="text" id="Ocn_Price_' + loopOcnTill + '" class="form-control integer"/></td><td style="text-align:center"><span class="set-alert2" id="Ocn_del_' + loopOcnTill + '" onClick="removeRowOcn(this);"><i class="fa fa-times-circle"></i></span></td><td style="display:none"><span id="Ocn_Cabin_Price_' + loopOcnTill + '">0</span></td></tr>');
            OcnCounter++;
            loopOcnTill++;
            AssignDatePicker();
            AssignValidateNumber();
        }
    });
    if (CruiseId != undefined) {
        $("#AddRowOcean").click();
    }

    $("#AddRowBal").click(function () {
        if (loopBalTill > 1) {
            ValidateCabinBal();
        }
        if (loopBalTill == 1 || IsvalidBal == true) {
            $('#tbl-Bal > tbody:last-child').append('<tr><td style="text-align:center"><span id="Bal_' + loopBalTill + '">' + BalCounter + '</span></td><td><input type="text" id="Bal_startdt_' + loopBalTill + '" class="form-control daterange-picker" readonly="true"/></td><td><input type="text" id="Bal_enddt_' + loopBalTill + '" class="form-control daterange-picker" readonly="true"/></td><td><input type="text" id="Bal_Price_' + loopBalTill + '" class="form-control integer"/></td><td style="text-align:center"><span class="set-alert2" id="Bal_del_' + loopBalTill + '" onClick="removeRowBal(this);"><i class="fa fa-times-circle"></i></span></td><td style="display:none"><span id="Bal_Cabin_Price_' + loopBalTill + '">0</span></td></tr>');
            BalCounter++;
            loopBalTill++;
            AssignDatePicker();
            AssignValidateNumber();
        }
    });
    if (CruiseId != undefined) {
        $("#AddRowBal").click();
    }
    $("#AddRowSui").click(function () {
        if (loopSuiTill > 1) {
            ValidateCabinSuite();
        }
        if (loopSuiTill == 1 || IsvalidSui == true) {
            $('#tbl-Sui > tbody:last-child').append('<tr><td style="text-align:center"><span id="Sui_' + loopSuiTill + '">' + SuiCounter + '</span></td><td><input type="text" id="Sui_startdt_' + loopSuiTill + '" class="form-control daterange-picker" readonly="true"/></td><td><input type="text" id="Sui_enddt_' + loopSuiTill + '" class="form-control daterange-picker" readonly="true"/></td><td><input type="text" id="Sui_Price_' + loopSuiTill + '" class="form-control integer"/></td><td style="text-align:center"><span class="set-alert2" id="Sui_del_' + loopSuiTill + '" onClick="removeRowSui(this);"><i class="fa fa-times-circle"></i></span></td><td style="display:none"><span id="Sui_Cabin_Price_' + loopSuiTill + '">0</span></td></tr>');
            SuiCounter++;
            loopSuiTill++;
            AssignDatePicker();
            AssignValidateNumber();
        }
    });
    if (CruiseId != undefined) {
        $("#AddRowSui").click();
    }
    $("#AddRowIten").click(function () {
        if (loopItenTill > 1) {
            ValidateItenDetails();
        }
        if (loopItenTill == 1 || IsvalidIten == true) {
            $('#tbl-Iten > tbody:last-child').append('<tr><td style="text-align:center"><span id="Iten_' + loopItenTill + '">' + ItenaryCount + '</span></td><td><input type="text" id="Iten_Detail_' + loopItenTill + '" class="form-control"/></td><td><input type="text" id="Iten_Arrival_' + loopItenTill + '" class="form-control"/></td><td><input type="text" id="Iten_Depart_' + loopItenTill + '" class="form-control"/></td><td style="text-align:center"><span class="set-alert2" id="Iten_del_' + loopItenTill + '" onClick="removeRowIten(this);"><i class="fa fa-times-circle"></i></span></td><td style="display:none"><span id="Iten_Cur_' + loopItenTill + '">0</span></td></tr>');
            ItenaryCount++;
            loopItenTill++;
        }
    });
    $("#AddRowIten").click();

    $("#btntab1").click(function () {
        var isValid = ValidateCruiseDetails();
        if (isValid == true) {
            var href = $('#2').attr('href');
            window.location.href = href;
        }
    });

    $("#btntab2").click(function () {
        var valid = "";
        if (tempDateArray.length == 0) {
            $("#dateMsg").html("Please Enter the Cabin Pricing");
            valid = true;
            return false;
        }

        setTimeout(function () {
            if (valid==true) {
                var href2 = $('#3').attr('href');
                window.location.href = href2;
            }
        }, 1000);

        //if (loopIntTill == 1 && loopOcnTill == 1 && loopBalTill == 1 && loopSuiTill == 1) {
        //    var fromdate = $("#inpFromDate").val();
        //    var todate = $("#inpToDate").val();
        //    var isChecked = $("input:checkbox[name=cabin]:checked").val()
        //    var IsInterior = $("#InteriorCheck").prop("checked");
        //    var IsOcean = $("#OceanCheck").prop("checked");
        //    var IsBalcony = $("#balconyCheck").prop("checked");
        //    var IsSuite = $("#SuiteCheck").prop("checked");
        //    var isValid = "";

        //    if (fromdate == "") {
        //        $("#dateMsg").html("Please select Start Date");
        //        IsvalidInt = false;
        //        return IsvalidInt;
        //        return false;
        //    }


        //    else if (todate == "") {
        //        $("#dateMsg").html("Please select End Date ");
        //        IsvalidInt = false;

        //        return false;
        //    }
        //    else if (moment(fromdate) < moment()) {
        //        $("#dateMsg").html("Start date should be greater than current date ");
        //        IsvalidInt = false;

        //        return false;
        //    }

        //    else if (moment(fromdate) > moment(todate)) {
        //        $("#dateMsg").html("Start date should be smaller then End date");

        //        return false;
        //    }
        //    else if (isChecked == undefined) {
        //        $("#dateMsg").html("Please select cabin for the cruise");
        //        return false;
        //    }
        //    else {
        //        $("#dateMsg").html("");
        //    }
        //}


        //var int;
        //var ocn;
        //var bal;
        //var sui;
        //if (loopIntTill > 1) {
        //    int = ValidateCabinInterior();
        //}
        //else {
        //    int = true;
        //}
        //if (loopOcnTill > 1) {
        //    ocn = ValidateCabinOcean();
        //}
        //else {
        //    ocn = true;
        //}
        //if (loopBalTill > 1) {
        //    bal = ValidateCabinBal();
        //}
        //else {
        //    bal = true;
        //}
        //if (loopSuiTill > 1) {
        //    sui = ValidateCabinSuite();
        //}
        //else {
        //    sui = true;
        //}

        
    });

    $("#btnTab4").click(function () {
        var OnBoard = [];
        $.each($("input[name='Chk']:checked"), function () {
            OnBoard.push($(this).val());
        });
        //console.log(OnBoard);
    });

    AssignValidateNumber();
    AssignDatePicker();
    Silder();
    getCruiseMaster();
});
function DeleteCruise() {
    $.ajax({
        type: "POST",
        url: url + "/DeleteCruise",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ CruiseId: CruiseId }),
        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {
                    debugger
                    getCruiseMaster();
                }
            }
            else {
                $("#FailureStatus").text("Error while deleting cruise details");
                $("#modal-danger").modal("show");
            }
            /// BindCruiseImages();
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while deleting cruise details");
            $("#modal-danger").modal("show");
        }
    });
}

function DeleteCruiseDate(cruiseid, from, to) {
    $.ajax({
        type: "POST",
        url: url + "/DeleteCabinDate",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ CruiseId: CruiseId, FromDate:from,ToDate:to }),
        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {
                  
                   
                }
            }
            else {
                $("#FailureStatus").text("Error while deleting cruise details");
                $("#modal-danger").modal("show");
            }
            /// BindCruiseImages();
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while deleting cruise details");
            $("#modal-danger").modal("show");
        }
    });
}

function validateNewtable() {
     var fromdate = $("#inpFromDate").val();
     var todate = $("#inpToDate").val();
     var mainPrice = $("#txtMainPrice").val();
        var isChecked = $("input:checkbox[name=cabin]:checked").val()
        var IsInterior = $("#InteriorCheck").prop("checked");
        var IsOcean = $("#OceanCheck").prop("checked");
        var IsBalcony = $("#balconyCheck").prop("checked");
        var IsSuite = $("#SuiteCheck").prop("checked");
        var isValid = "";

        if (fromdate == "") {
            $("#errmsgfordates").html("Please select Start Date");
            IsvalidInt = false;
            return IsvalidInt;
            return false;
        }


        else if (todate == "") {
            $("#errmsgfordates").html("Please select End Date ");
            IsvalidInt = false;

            return false;
        }
        else if (moment(fromdate) < moment()) {
            $("#errmsgfordates").html("Start date should be greater than current date ");
            IsvalidInt = false;

            return false;
        }

        else if (moment(fromdate) > moment(todate)) {
            $("#errmsgfordates").html("Start date should be smaller then End date");

            return false;
        }
        else if (mainPrice.trim() == "") {
            $("#errmsgfordates").html("Please enter main price for the cruise");
            return false;
        }
        else if (isChecked == undefined) {
            $("#errmsgfordates").html("Please select cabin for the cruise");
            return false;
        }
        else {
            $("#errmsgfordates").html("");
            isValid= 1;
        }
        var duplicateDates = $.grep(TempTableArray, function (value) {
            return value["from"] == fromdate && value["ToDate"] == todate;
        })

        if (duplicateDates.length > 0) {
            $("#errmsgfordates").html("Cruise is already added for these dates");
            return false;
        }
        else {
            $("#errmsgfordates").html("");
            isValid = 1;
        }
       

        if (IsInterior == true) {
            var price = $("#intPrice").val();
            var uploadfiles = $("#Int-image").get(0);
            var uploadedfiles = uploadfiles.files;
            if (uploadedfiles.length < 1 && flag != "U") {
                $("#errmsgfordates").html("Select a file to upload for Interior");
                isValid = 0;
                return false;
            }
            else {
                isValid = 1;
            }
            if (price.trim() == "") {
                $("#errmsgfordates").html("Please enter price for interior cabin");
                isValid = 0;
                return false;
            }
            else {
                isValid = 1;
            }
        }
        if (IsOcean == true) {
            var price = $("#OceanPrice").val();
            if (price.trim() == "") {
                $("#errmsgfordates").html("Please enter price for ocean cabin");
                isValid = 0;
                return false;
            }
            else {
                isValid = 1;
            }
            var uploadfiles = $("#Ocn-image").get(0);
            var uploadedfiles = uploadfiles.files;
            if (uploadedfiles.length < 1 && flag != "U") {
                $("#errmsgfordates").html("Select a file to upload for Interior");
                isValid = 0;
                return false;
            }
            else {
                isValid = 1;
            }
        }
        if (Balcony == true) {
            $("#BalPrice").val();
            if (price.trim() == "") {
                $("#errmsgfordates").html("Please enter price for balcony cabin");
                isValid = 0;
                return false;
            }
            else {
                isValid = 1;
            }
            var uploadfiles = $("#Bal-image").get(0);
            var uploadedfiles = uploadfiles.files;
            if (uploadedfiles.length < 1 && flag != "U") {
                $("#errmsgfordates").html("Select a file to upload for Interior");
                isValid = 0;
                return false;
            }
            else {
                isValid = 1;
            }
        }
        if (IsSuite == true) {
            var price = $("#SuitePrice").val();
            if (price.trim() == "") {
                $("#errmsgfordates").html("Please enter price for suite cabin");
                isValid = 0;
                return false;
            }
            else {
                isValid = 1;
            }
            var uploadfiles = $("#Sui-image").get(0);
            var uploadedfiles = uploadfiles.files;
            if (uploadedfiles.length < 1 && flag != "U") {
                $("#errmsgfordates").html("Select a file to upload for Interior");
                isValid = 0;
                return false;
            }
            else {
                isValid = 1;
            }
        }
        return isValid;
}

function validateoldtable() {
    var valid;
    var fromdate = $("#inpFromDate").val();
    var todate = $("#inpToDate").val();
    var mainPrice = $("#txtMainPrice").val();
    var isChecked = $("input:checkbox[name=cabin]:checked").val()
    var IsInterior = $("#InteriorCheck").prop("checked");
    var IsOcean = $("#OceanCheck").prop("checked");
    var IsBalcony = $("#balconyCheck").prop("checked");
    var IsSuite = $("#SuiteCheck").prop("checked");
    var isValid = 1;

    if (fromdate == "") {
        $("#errmsgfordates").html("Please select Start Date");
        IsvalidInt = false;
        isValid = 0;
        return false;
    }


    else if (todate == "") {
        $("#errmsgfordates").html("Please select End Date ");
        IsvalidInt = false;
        isValid = 0;
        return false;
    }
    else if (moment(fromdate) < moment()) {
        $("#errmsgfordates").html("Start date should be greater than current date ");
        IsvalidInt = false;
        isValid = 0;
        return false;
    }

    else if (moment(fromdate) > moment(todate)) {
        $("#errmsgfordates").html("Start date should be smaller then End date");
        isValid = 0;
        return false;
    }
    else if (mainPrice.trim() == "") {
        $("#errmsgfordates").html("Please enter main price for the cruise");
        isValid = 0;
        return false;
    }
    else if (isChecked == undefined) {
        $("#errmsgfordates").html("Please select cabin for the cruise");
        isValid = 0;
        return false;
    }
    else {
        $("#errmsgfordates").html("");
    }
    var duplicateDates = $.grep(TempTableArray, function (value) {
        return value["from"] == fromdate && value["ToDate"] == todate && value["id"]!=editId;
    })

    if (duplicateDates.length > 0) {
        $("#errmsgfordates").html("Cruise is already added for these dates");
        return false;
    }
    else {
        $("#errmsgfordates").html("");
        isValid = 1;
    }
    if (IsInterior == true) {
        var price = $("#intPrice").val();
        if (price.trim() == "") {
            $("#errmsgfordates").html("Please enter price for interior cabin");
            isValid = 0;
            return false;

        }
    }
    if (IsOcean == true) {
        var price = $("#OceanPrice").val();
        if (price.trim() == "") {
            $("#errmsgfordates").html("Please enter price for ocean cabin");
            isValid = 0;
            return false;
        }
    }
    if (Balcony == true) {
        $("#BalPrice").val();
        if (price.trim() == "") {
            $("#errmsgfordates").html("Please enter price for balcony cabin");
            isValid = 0;
            return false;
        }
    }
    if (IsSuite == true) {
        var price = $("#SuitePrice").val();
        if (price.trim() == "") {
            $("#errmsgfordates").html("Please enter price for suite cabin");
            isValid = 0;
            return false;
        }
    }
    return isValid;
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

function Silder() {
    var navListItems = $('div.setup-panel div a'),
        allWells = $('.setup-content'),
        allNextBtn = $('.nextBtn');

    allWells.hide();

    navListItems.click(function (e) {
        e.preventDefault();

        var $target = $($(this).attr('href')),
            $item = $(this);
        var valid = true;
        var id = $target.attr('id');
        if (id == "step-2" || id == "btntab2") {
           
            valid = ValidateCruiseDetails();
        }
        else if (id == "step-3" || id == "btnTab3") {

            //valid = ValidateCabinInterior();
            //if (valid == true) {
            //    valid = ValidateCabinOcean();
            //    if (valid == true) {
            //        valid = ValidateCabinBal();
            //        if (valid == true) {
            //            valid = ValidateCabinSuite();
            //        }
            //    }
            //}

            if (tempDateArray.length == 0) {
                valid = false;
            }
            else {
                valid = true;
            }
            //if (loopIntTill > 1) {
            //    valid = ValidateCabinInterior();
            //}
            
            //if (loopOcnTill > 1) {
            //    valid = ValidateCabinOcean();
            //}
           
            //if (loopBalTill > 1) {
            //    valid = ValidateCabinBal();
            //}
           
            //if (loopSuiTill > 1) {
            //    valid = ValidateCabinSuite();
            //}
           

        }
        else if (id == "step-4" || id == "btnTab4" || id == "step-5" || id == "btnTab5" || id == "step-6" || id == "btnTab6") {
            valid = ValidateItenDetails();
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
            valid = ValidateCruiseDetails();
        }
        else if (id == "step-2" || id == "btntab2") {
            //valid = true;

            //valid = ValidateCabinInterior();
            //if (valid == true) {
            //    valid = ValidateCabinOcean();
            //    if (valid == true) {
            //        valid = ValidateCabinBal();
            //        if (valid == true) {
            //            valid = ValidateCabinSuite();
            //        }
            //    }
            //}
            if (tempDateArray.length == 0) {
                valid = false;
            }
            else {
                valid = true;
            }
        }
        else if (id == "step-3" || id == "btnTab3" || id == "step-4" || id == "btnTab4" || id == "step-5" || id == "btnTab5") {
            valid = ValidateItenDetails();
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

function AssignValidateNumber() {
    $(".integer").keypress(function (e) {
        //if the letter is not digit then display error and don't type anything
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            return false;
        }
    });
}

function AssignDatePicker() {
    $(".daterange-picker").datepicker({
        format: 'dd-M-yyyy'
    });
}

function InsertAllData() {

    //$.when(ValidateCruiseDetails()).done(function (val1) {
    //    if (val1 == true) {
    //        $.when(ValidateCabinInterior()).done(function (val2_1) {
    //            if (val2_1 == true) {
    //                alert('1');
    //            }
    //            else
    //                alert('f2');
    //        });
    //    }
    //    else {
    //        alert('fail');
    //    }
    //});
    ValidateCruiseDetails();
    ValidateCabinInterior();
    ValidateCabinOcean();
    ValidateCabinBal();
    ValidateCabinSuite();
    ValidateItenDetails();

    var title = $("#title-name").val();
    var days = $("#days").val();
    var nights = $("#nights").val();
    var aliasName = $("#detail-for").val();
    var company = $("#ddlCompany option:selected").val();
    var source = $("#ddlSourceCountry option:selected").text();
    var destination = $("#ddlDestinationCountry option:selected").text();
    var CrDetaulInclusion = $("#ContentPlaceHolder1_inclusion").val();
    var CrDetailExclusion = $("#ContentPlaceHolder1_exclusion").val();
    var tax = $("#tax").val();
    var gratAbFive = $("#GratAbFive").val();
    var gratChild = $("#GratChild").val();

    if (company == undefined) {
        company = 0;
    }

    if (flag == "U") {
        $.ajax({
            type: "POST",
            url: url + "/UpdateCruiseDetail",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: JSON.stringify({
                CruiseId: CruiseId, Title: title, days: days, nights: nights, AlisaName: aliasName, Company: company, Tax: tax, GAdult: gratAbFive, GChild: gratChild, Source: source, Destination: destination, Inclusion: CrDetaulInclusion, Exclusion: CrDetailExclusion
            }),
            success: function (msg) {
                if (msg.d != null) {
                    //var jsonobj = JSON.parse(msg.d).split('_');
                    //CruiseId = jsonobj[1];
                    UploadCruiseImages();

                }
            },
            Error: function (x, e) {
                alert(msg.d);
            }
        });
    }
    else {
        $.ajax({
            type: "POST",
            url: url + "/InsertCruiseDetail",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: JSON.stringify({
                Title: title, days: days, nights: nights, AlisaName: aliasName, Company: company, Tax: tax, GAdult: gratAbFive, GChild: gratChild, Source: source, Destination: destination, Inclusion: CrDetaulInclusion, Exclusion: CrDetailExclusion
            }),
            success: function (msg) {
                if (msg.d != null) {
                    var jsonobj = JSON.parse(msg.d).split('_');
                    CruiseId = jsonobj[1];
                    UploadCruiseImages();

                }
            },
            Error: function (x, e) {
                alert(msg.d);
            }
        });
    }
}
function getCompanyList() {
    $.ajax({
        type: "POST",
        url: url + "/getCompanyList",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (msg) {
            if (msg.d != "") {

                var jsonobj = JSON.parse(msg.d);
                mapCompanyList(jsonobj);
                bindCompanyDropdown();
            }
            else {
                CompanyList = null;
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function mapCompanyList(jsonobj) {

    CompanyList = $.map(jsonobj, function (el) {
        return {
            0: el.CompanyId,
            1: el.CompanyName
        }
    });
}

function bindCompanyDropdown() {
    var appendvalue = "";
    $("#ddlCompany").empty();
    for (var i = 0; i <= CompanyList.length - 1; i++) {
        appendvalue += "<option value=" + CompanyList[i][0] + ">" + CompanyList[i][1] + "</option>";
    }
    $("#ddlCompany").append("<option value=0>Select</option>");
    $("#ddlCompany").append(appendvalue);
    $("#ddlCompany").selectpicker('refresh');
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
                bindSourceCountryDropdown();
                bindDestinationCountryDropdown();
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
            0: el.PortId,
            1: el.PortName

        }
    });
}

function mapOnboardList(jsonobj) {

    OnboardList = $.map(jsonobj, function (el) {
        return {
            0: el.OnboardCategoryId,
            1: el.COnboardId,
            2: el.CategoryName

        }
    });
}

function bindSourceCountryDropdown() {
    var appendvalue = "";
    $("#ddlSourceCountry").empty();
    for (var i = 0; i <= CountryList.length - 1; i++) {
        appendvalue += "<option value=" + CountryList[i][1] + ">" + CountryList[i][1] + "</option>";
    }
    $("#ddlSourceCountry").append("<option value=0>Select</option>");
    $("#ddlSourceCountry").append(appendvalue);
    $("#ddlSourceCountry").selectpicker('refresh');
}

function bindDestinationCountryDropdown() {
    var appendvalue = "";
    $("#ddlDestinationCountry").empty();
    for (var i = 0; i <= CountryList.length - 1; i++) {
        appendvalue += "<option value=" + CountryList[i][1] + ">" + CountryList[i][1] + "</option>";
    }
    $("#ddlDestinationCountry").append("<option value=0>Select</option>");
    $("#ddlDestinationCountry").append(appendvalue);
    $("#ddlDestinationCountry").selectpicker('refresh');
}

function ValidateCruiseDetails() {
    $("#CruiseDetailMsg").html("");

    var title = $("#title-name").val();
    if (title == "") {
        $("#CruiseDetailMsg").html("Please Enter Title");
        return false;
    }
    var days = $("#days").val();
    if (days == "") {
        $("#CruiseDetailMsg").html("Please Enter No.of Days");
        return false;
    }
    if (days <= 0) {
        $("#CruiseDetailMsg").html("Days should be greater than zero");
        return false;
    }
    var nights = $("#nights").val();
    if (nights == "") {
        $("#CruiseDetailMsg").html("Please Enter No.of Nights");
        return false;
    }
    if (nights <= 0) {
        $("#CruiseDetailMsg").html("Nights should be greater than zero");
        return false;
    }
    var details = $("#detail-for").val();
    if (details == "") {
        $("#CruiseDetailMsg").html("Please Enter Details for");
        return false;
    }
    var uploadfiles = $("#pd-image").get(0);
    var uploadedfiles = uploadfiles.files;
    if (uploadedfiles.length < 1 && flag != "U") {
        $("#CruiseDetailMsg").html("Select a file to upload ");
        return false;
    }
    for (var i = 0; i < uploadedfiles.length; i++) {
        var ext = uploadedfiles[i].name.split('.').pop().toLowerCase();
        if (jQuery.inArray(ext, fileExtension) == '-1') {
            $("#CruiseDetailMsg").html("Select a valid file");
            return false;
        }
    }

    var scont = $("#ddlSourceCountry option:selected").val()
    if (scont == "0") {
        $("#CruiseDetailMsg").html("Please select source country port");
        return false;
    }

    var dcont = $("#ddlDestinationCountry option:selected").val()
    if (dcont == "0") {
        $("#CruiseDetailMsg").html("Please select destination country port");
        return false;
    }

    var comp = $("#ddlCompany option:selected").val()
    if (comp == "0") {
        $("#CruiseDetailMsg").html("Please select company name");
        return false;
    }

    var tax = $("#tax").val();
    if (tax == "") {
        $("#CruiseDetailMsg").html("Please Enter Tax Per Person");
        return false;
    }
    if (tax <= 0) {
        $("#CruiseDetailMsg").html("Tax Per Person should be greater than zero");
        return false;
    }

    var adult = $("#GratAbFive").val();
    if (adult == "") {
        $("#CruiseDetailMsg").html("Please Enter Gratuity Adult(> 15 yrs)");
        return false;
    }
    if (adult <= 0) {
        $("#CruiseDetailMsg").html("Gratuity for Adult(> 15 yrs) should be greater than zero");
        return false;
    }

    var child = $("#GratChild").val();
    if (child == "") {
        $("#CruiseDetailMsg").html("Please Enter Gratuity Child(4-14 yrs)");
        return false;
    }
    if (child <= 0) {
        $("#CruiseDetailMsg").html("Gratuity for Child(4-14 yrs) should be greater than zero");
        return false;
    }

    var inclusion = $("#ContentPlaceHolder1_inclusion").val();
    if (inclusion == "") {
        $("#CruiseDetailMsg").html("Please enter inclusion for Cruise");
        return false;
    }

    var exclusion = $("#ContentPlaceHolder1_exclusion").val();
    if (exclusion == "") {
        $("#CruiseDetailMsg").html("Please enter exclusion for Cruise");
        return false;
    }
    return true;
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

function UploadCruiseImages() {
    var uploadfiles = $("#pd-image").get(0);
    var uploadedfiles = uploadfiles.files;

    if (uploadedfiles.length > 0) {
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
            url: "CruiseImageHandler.ashx?CruiseId=" + CruiseId,

            data: fromdata,
            dataType: "json",
            success: function (msg) {
                //if (msg != "") {
                //    if (msg == "1") {
                //$("#title-name").val('');
                $("#modaloverlay").hide()
                $(" .collapse").css("display", "none");
                //$("#SuccessStatus").text("Cruise Details inserted Successfully");
                //$("#modal-success").modal("show");
                GetCabinPricingData();
                //getTripMaster();


                //    }
                //    else if (msg == "0") {
                //        $("#FailureStatus").text("Error while inserting cruise details");
                //        $("#modal-danger").modal("show");
                //    }
                //}
                //else {

                //}
                //if (flag == "E") {
                //    $(" .collapse").css("display", "none");
                //    $("#UpdateTrip").modal("show");
                //}
            },
            Error: function (x, e) {
                $("#FailureStatus").text("Error while inserting cruise details");
                $("#modal-danger").modal("show");
            }
        });
    }
    else if (flag == "U") {
        GetCabinPricingData();
    }
}

function GetOnBoardActivites() {
    $.ajax({
        type: "POST",
        url: url + "/getOnBoardList",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                mapOnboardList(jsonobj);
            }
            else {
                OnboardList = null;
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });


    for (var i = 0; i < OnboardList.length; i++) {
        var checkbox = document.createElement('input');
        checkbox.type = "checkbox";
        checkbox.name = "Chk";
        checkbox.value = "" + OnboardList[i][0] + "";
        if (OnboardList[i][1] == 1) {
            checkbox.id = "Enter_" + OnboardList[i][0];
            checkbox.className = "Enter"
            var label = document.createElement('span')
            label.htmlFor = "id";
            label.appendChild(document.createTextNode('' + OnboardList[i][2] + ''));
            label.style.marginRight = "50px";
            document.getElementById('Entertainment').appendChild(checkbox);
            document.getElementById('Entertainment').appendChild(label);
        }
        if (OnboardList[i][1] == 2) {
            checkbox.id = "Kids_" + OnboardList[i][0];
            checkbox.className = "Kids"
            var label = document.createElement('span')
            label.htmlFor = "id";
            label.appendChild(document.createTextNode('' + OnboardList[i][2] + ''));
            label.style.marginRight = "50px";
            document.getElementById('Kids').appendChild(checkbox);
            document.getElementById('Kids').appendChild(label);
            //document.getElementById('Kids').appendChild('&nbsp;');
        }
        if (OnboardList[i][1] == 3) {
            checkbox.id = "Life_" + OnboardList[i][0];
            checkbox.className = "Life"
            var label = document.createElement('span')
            label.htmlFor = "id";
            label.appendChild(document.createTextNode('' + OnboardList[i][2] + ''));
            label.style.marginRight = "50px";
            document.getElementById('life').appendChild(checkbox);
            document.getElementById('life').appendChild(label);
        }
    }
}

function ValidateCabinInterior() {
    $("#CabIntMsg").html("");
    for (var i = 1; i < loopIntTill; i++) {
        if ($('#Int_startdt_' + (i)).val() != undefined) {
            if (CruiseId != undefined) {
                var start = $('#Int_startdt_' + (i)).datepicker('getDate');
                if (start == null) {
                    $("#CabIntMsg").html("Please select Start Date for Interior");
                    IsvalidInt = false;
                    return IsvalidInt;

                }
                var end = $('#Int_enddt_' + (i)).datepicker('getDate');
                if (end == null) {
                    $("#CabIntMsg").html("Please select End Date for Interior");
                    IsvalidInt = false;
                    return IsvalidInt;
                }
                if (start > end) {
                    $("#CabIntMsg").html("Start date should be smaller then End date");
                    IsvalidInt = false;

                    return IsvalidInt;
                }
            }
            var price = $('#Int_Price_' + (i)).val();
            if (price == "") {
                $("#CabIntMsg").html("Please enter Twin cabin price for Interior");
                IsvalidInt = false;
                return IsvalidInt;
                return false;
            }

            if (price <= 0) {
                $("#CabIntMsg").html("Price should be greater then zero");
                IsvalidInt = false;
                return IsvalidInt;
            }
        }
    }

    var uploadfiles = $("#Int-image").get(0);
    var uploadedfiles = uploadfiles.files;
    if (uploadedfiles.length < 1 && flag != "U") {
        $("#CabIntMsg").html("Select a file to upload for Interior");
        return false;
    }
    for (var i = 0; i < uploadedfiles.length; i++) {
        var ext = uploadedfiles[i].name.split('.').pop().toLowerCase();
        if (jQuery.inArray(ext, fileExtension) == '-1') {
            $("#CabIntMsg").html("Select a valid file");
            $("#Int-image").val("");
            return false;
        }
    }
    IsvalidInt = true;
    return IsvalidInt;
}

function removeRowInt(oButton) {
    $("#CabIntMsg").html("");
    var empTab = document.getElementById('tbl-Int');
    empTab.deleteRow(oButton.parentNode.parentNode.rowIndex);
    IntCounter = 1;
    for (var i = 1; i < loopIntTill; i++) {
        if ($('#Int_startdt_' + (i)).val() != undefined) {
            $("#Int_" + i).html(IntCounter);
            IntCounter++;
        }
    }
}

function ValidateCabinOcean() {
    $("#CabOcnMsg").html("");
    for (var i = 1; i < loopOcnTill; i++) {
        if ($('#Ocn_startdt_' + (i)).val() != undefined) {
            if (CruiseId != undefined) {
                var start = $('#Ocn_startdt_' + i).datepicker('getDate');
                if (start == null) {
                    $("#CabOcnMsg").html("Please select Start Date for Oceanview");
                    IsvalidOcn = false;
                    return IsvalidOcn;
                }
                var end = $('#Ocn_enddt_' + i).datepicker('getDate');
                if (end == null) {
                    $("#CabOcnMsg").html("Please select End Date for Oceanview");
                    IsvalidOcn = false;
                    return IsvalidOcn;
                }
                if (start > end) {
                    $("#CabOcnMsg").html("Start date should be smaller then End date");
                    IsvalidOcn = false;
                    return IsvalidOcn;
                }

            }
            var price = $('#Ocn_Price_' + i).val();
            if (price == "") {
                $("#CabOcnMsg").html("Please enter Twin cabin price for Oceanview");
                IsvalidOcn = false;
                return IsvalidOcn;
            }
            if (price <= 0) {
                $("#CabOcnMsg").html("Price should be greater then zero");
                IsvalidOcn = false;
                return IsvalidOcn;
            }
        }
    }

    var uploadfiles = $("#Ocn-image").get(0);
    var uploadedfiles = uploadfiles.files;
    if (uploadedfiles.length < 1 && flag != "U") {
        $("#CabOcnMsg").html("Select a file to upload for Oceanview");
        return false;
    }
    for (var i = 0; i < uploadedfiles.length; i++) {
        var ext = uploadedfiles[i].name.split('.').pop().toLowerCase();
        if (jQuery.inArray(ext, fileExtension) == '-1') {
            $("#CabOcnMsg").html("Select a valid file");
            $("#Ocn-image").val("");
            return false;
        }
    }
    IsvalidOcn = true;
    return IsvalidOcn;
}

function removeRowOcn(oButton) {
    $("#CabOcnMsg").html("");
    var empTab = document.getElementById('tbl-Ocean');
    empTab.deleteRow(oButton.parentNode.parentNode.rowIndex);
    OcnCounter = 1;
    for (var i = 1; i < loopIntTill; i++) {
        if ($('#Ocn_startdt_' + (i)).val() != undefined) {
            $("#Ocn_" + i).html(OcnCounter);
            OcnCounter++;
        }
    }
}

function ValidateCabinBal() {
    $("#CabBalMsg").html("");

    for (var i = 1; i < loopBalTill; i++) {
        if ($('#Bal_startdt_' + (i)).val() != undefined) {
            if (CruiseId != undefined) {
                var start = $('#Bal_startdt_' + (IntCounter - 1)).datepicker('getDate');
                if (start == null) {
                    $("#CabBalMsg").html("Please select Start Date for Balcony");
                    IsvalidBal = false;
                    return;
                }
                var end = $('#Bal_enddt_' + (IntCounter - 1)).datepicker('getDate');
                if (end == null) {
                    $("#CabBalMsg").html("Please select End Date for Balcony");
                    IsvalidBal = false;
                    return IsvalidBal;
                }
                if (start > end) {
                    $("#CabBalMsg").html("Start date should be smaller then End date");
                    IsvalidBal = false;
                    return IsvalidBal;
                }
            }
            var price = $('#Bal_Price_' + (IntCounter - 1)).val();
            if (price == "") {
                $("#CabBalMsg").html("Please enter Twin cabin price for Balcony");
                IsvalidBal = false;
                return IsvalidBal;
            }

            if (price <= 0) {
                $("#CabBalMsg").html("Price should be greater then zero");
                IsvalidBal = false;
                return IsvalidBal;
            }
        }
    }

    var uploadfiles = $("#Bal-image").get(0);
    var uploadedfiles = uploadfiles.files;
    if (uploadedfiles.length < 1 && flag != "U") {
        $("#CabBalMsg").html("Select a file to upload for Balcony");
        return false;
    }
    for (var i = 0; i < uploadedfiles.length; i++) {
        var ext = uploadedfiles[i].name.split('.').pop().toLowerCase();
        if (jQuery.inArray(ext, fileExtension) == '-1') {
            $("#CabBalMsg").html("Select a valid file");
            $("#Bal-image").val("");
            return false;
        }
    }
    IsvalidBal = true;
    return IsvalidBal;
}

function removeRowBal(oButton) {
    $("#CabBalMsg").html("");
    var empTab = document.getElementById('tbl-Bal');
    empTab.deleteRow(oButton.parentNode.parentNode.rowIndex);
    BalCounter = 1;
    for (var i = 1; i < loopBalTill; i++) {
        if ($('#Bal_startdt_' + (i)).val() != undefined) {
            $("#Bal_" + i).html(BalCounter);
            BalCounter++;
        }
    }
}

function ValidateCabinSuite() {
    $("#CabSuiMsg").html("");

    for (var i = 1; i < loopSuiTill; i++) {
        if ($('#Sui_startdt_' + (i)).val() != undefined) {
            if (CruiseId != undefined) {
                var start = $('#Sui_startdt_' + (IntCounter - 1)).datepicker('getDate');
                if (start == null) {
                    $("#CabSuiMsg").html("Please select Start Date for Suite");
                    IsvalidSui = false;
                    return IsvalidSui;
                }
                var end = $('#Sui_enddt_' + (IntCounter - 1)).datepicker('getDate');
                if (end == null) {
                    $("#CabSuiMsg").html("Please select End Date for Suite");
                    IsvalidSui = false;
                    return IsvalidSui;
                }
                if (start > end) {
                    $("#CabSuiMsg").html("Start date should be smaller then End date");
                    IsvalidSui = false;
                    return;
                }
            }
            var price = $('#Sui_Price_' + (IntCounter - 1)).val();
            if (price == "") {
                $("#CabSuiMsg").html("Please enter Twin cabin price for Suite");
                IsvalidSui = false;
                return IsvalidSui;
            }

            if (price <= 0) {
                $("#CabSuiMsg").html("Price should be greater then zero");
                IsvalidSui = false;
                return IsvalidSui;
            }
        }
    }

    var uploadfiles = $("#Sui-image").get(0);
    var uploadedfiles = uploadfiles.files;
    if (uploadedfiles.length < 1 && flag != "U") {
        $("#CabSuiMsg").html("Select a file to upload for Suite");
        return false;
    }
    for (var i = 0; i < uploadedfiles.length; i++) {
        var ext = uploadedfiles[i].name.split('.').pop().toLowerCase();
        if (jQuery.inArray(ext, fileExtension) == '-1') {
            $("#CabSuiMsg").html("Select a valid file");
            $("#Sui-image").val("");
            return false;
        }
    }
    IsvalidSui = true;
    return IsvalidSui;
}

function removeRowSui(oButton) {
    $("#CabSuiMsg").html("");
    var empTab = document.getElementById('tbl-Sui');
    empTab.deleteRow(oButton.parentNode.parentNode.rowIndex);
    SuiCounter = 1;
    for (var i = 1; i < loopSuiTill; i++) {
        if ($('#Sui_startdt_' + (i)).val() != undefined) {
            $("#Sui_" + i).html(SuiCounter);
            SuiCounter++;
        }
    }
}

function ValidateItenDetails() {
    $("#ItenMsg").html("");
    for (var i = 1; i < loopItenTill; i++) {
        if ($('#Iten_Detail_' + (i)).val() != undefined) {
            var det = $('#Iten_Detail_' + i).val();
            var arr = $('#Iten_Arrival_' + i).val();
            var dep = $('#Iten_Depart_' + i).val();
            if (det != undefined && arr != undefined && dep != undefined && det.trim() == "" && arr.trim() == "" && dep.trim() == "") {
                $("#ItenMsg").html("Please enter all or any one of the following details");
                IsvalidIten = false;
                return IsvalidIten;
            }
        }
    }

    IsvalidIten = true;
    return IsvalidIten;
}

function removeRowIten(oButton) {
    $("#ItenMsg").html("");
    var empTab = document.getElementById('tbl-Iten');
    empTab.deleteRow(oButton.parentNode.parentNode.rowIndex);
    ItenaryCount = 1;
    for (var i = 1; i < loopItenTill; i++) {
        if ($('#Iten_Detail_' + (i)).val() != undefined) {
            $("#Iten_" + i).html(ItenaryCount);
            ItenaryCount++;
        }
    }
}

function GetCabinPricingData() {
    var start = [];
    var end = [];
    var pri = [];
    var cabId = [];
    var cabPriId = [];
    var mainPrice = [];
    var IsInterior = $("#InteriorCheck").prop("checked");
    var IsOcean = $("#OceanCheck").prop("checked");
    var IsBalcony = $("#BalconyCheck").prop("checked");
    var IsSuite = $("#SuiteCheck").prop("checked");

    if (tempDateArray.length > 0) {
        $.each(tempDateArray, function (i) {
            cabId.push(tempDateArray[i]["cabinid"]);
            start.push(tempDateArray[i]["from"]);
            end.push(tempDateArray[i]["to"]);
            pri.push(tempDateArray[i]["Price"]);
            mainPrice.push(tempDateArray[i]["MainCost"])
            cabPriId.push(tempDateArray[i]["CabId"] );
        });
    }

    //if (loopIntTill>1 || flag == "U") {
    //    for (var i = 1; i < loopIntTill; i++) {
    //        if ($("#Int_startdt_" + i).val() != undefined) {
    //            cabId.push(Interior);
    //            start.push($("#Int_startdt_" + i).val());
    //            end.push($("#Int_enddt_" + i).val());
    //            pri.push($("#Int_Price_" + i).val());
    //            cabPriId.push($("#Int_Cabin_Price_" + i).html());
    //        }
    //    }
    //}

    //if (loopOcnTill > 1 || flag == "U") {
    //    for (var i = 1; i < loopOcnTill; i++) {
    //        if ($("#Ocn_startdt_" + i).val() != undefined) {
    //            cabId.push(Ocean);
    //            start.push($("#Ocn_startdt_" + i).val());
    //            end.push($("#Ocn_enddt_" + i).val());
    //            pri.push($("#Ocn_Price_" + i).val());
    //            cabPriId.push($("#Ocn_Cabin_Price_" + i).html());
    //        }
    //    }
    //}
    //if (loopBalTill>1 || flag == "U") {
    //    for (var i = 1; i < loopBalTill; i++) {
    //        if ($("#Bal_startdt_" + i).val() != undefined) {
    //            cabId.push(Balcony);
    //            start.push($("#Bal_startdt_" + i).val());
    //            end.push($("#Bal_enddt_" + i).val());
    //            pri.push($("#Bal_Price_" + i).val());
    //            cabPriId.push($("#Bal_Cabin_Price_" + i).html());
    //        }
    //    }
    //}

    //if (loopSuiTill >1|| flag == "U") {

    //    for (var i = 1; i < SuiCounter; i++) {
    //        if ($("#Sui_startdt_" + i).val() != undefined) {
    //            cabId.push(Suite);
    //            start.push($("#Sui_startdt_" + i).val());
    //            end.push($("#Sui_enddt_" + i).val());
    //            pri.push($("#Sui_Price_" + i).val());
    //            cabPriId.push($("#Sui_Cabin_Price_" + i).html());
    //        }
    //    }
    //}

    if (flag == "U") {
        $.ajax({
            type: "POST",
            url: url + "/UpdateCabinPricing",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({
                CruiseId: CruiseId, CabinType: cabId, Startdate: start, Enddate: end, price: pri, CabPriceId: cabPriId, MainPrice: mainPrice
            }),
            //data: { "CruiseId": CruiseId,"CabinType": cabId,"Startdate" : start, "Enddate" : end,"price":pri },
            dataType: "json",
            async: false,
            success: function (msg) {
                GetCabinDescription()
                UploadCabinImage();
            },
            Error: function (x, e) {
                alert(msg.d);
            }
        });
    }
    else {
        $.ajax({
            type: "POST",
            url: url + "/InsertCabinPricing",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({
                CruiseId: CruiseId, CabinType: cabId, Startdate: start, Enddate: end, price: pri,MainPrice:mainPrice
            }),
            //data: { "CruiseId": CruiseId,"CabinType": cabId,"Startdate" : start, "Enddate" : end,"price":pri },
            dataType: "json",
            async: false,
            success: function (msg) {

                GetCabinDescription()
                UploadCabinImage();
                //UploadCabinImage(Ocean);
                //UploadCabinImage(Balcony);
                //UploadCabinImage(Suite);
            },
            Error: function (x, e) {
                alert(msg.d);
            }
        });
    }

}

function UploadCabinImage() {

    var upInt = $("#Int-image").get(0);
    var upOcn = $("#Ocn-image").get(0);
    var upBal = $("#Bal-image").get(0);
    var upSui = $("#Sui-image").get(0);

    var uploadedIntfiles = upInt.files;
    var uploadedOcnfiles = upOcn.files;
    var uploadedBalfiles = upBal.files;
    var uploadedSuifiles = upSui.files;
    if (uploadedIntfiles.length > 0 || uploadedOcnfiles.length > 0 || uploadedBalfiles.length > 0 || uploadedSuifiles.length > 0) {
        $("#modaloverlay").show()
        $(" .collapse").css("display", "block");

        move();
        var cid = "0";
        var fromdata = new FormData();
        if (uploadedIntfiles.length > 0) {
            cid +=",1";
            for (var i = 0; i < uploadedIntfiles.length; i++) {
                fromdata.append(uploadedIntfiles[i].name, uploadedIntfiles[i]);
            }
           
        }

        if (uploadedOcnfiles.length > 0) {
           // var fromdata = new FormData();
            cid +=",2";
            for (var i = 0; i < uploadedOcnfiles.length; i++) {
                fromdata.append(uploadedOcnfiles[i].name, uploadedOcnfiles[i]);
            }

        }
        if (uploadedBalfiles.length > 0) {
            //var fromdata = new FormData();
            cid +=",3";
            for (var i = 0; i < uploadedBalfiles.length; i++) {
                fromdata.append(uploadedBalfiles[i].name, uploadedBalfiles[i]);
            }
            //$.ajax({
            //    type: "POST",
            //    contentType: false,
            //    processData: false,
            //    url: "CabinPricingHandler.ashx?CruiseId=" + CruiseId + "&CabinId=3",

            //    data: fromdata,
            //    dataType: "json",
            //    success: function (msg) {
            //        //if (msg != "") {
            //        //    if (msg == "1") {
            //        //        $("#title-name").val('');
                   
            //        //        $("#SuccessStatus").text("Cruise Details inserted Successfully");
            //        //        $("#modal-success").modal("show");
                
            //        //    }
            //        //    else if (msg == "0") {
            //        //        $("#FailureStatus").text("Error while inserting cruise details");
            //        //        $("#modal-danger").modal("show");
            //        //    }
            //        //}
            //        //else {

            //        //}
            //    },
            //    Error: function (x, e) {
            //        $("#FailureStatus").text("Error while inserting cruise details");
            //        $("#modal-danger").modal("show");
            //    }
            //});
        }
        if (uploadedSuifiles.length > 0) {
            cid+=",4";
            //var fromdata = new FormData();
            for (var i = 0; i < uploadedSuifiles.length; i++) {
                fromdata.append(uploadedSuifiles[i].name, uploadedSuifiles[i]);
            }
            //$.ajax({
            //    type: "POST",
            //    contentType: false,
            //    processData: false,
            //    url: "CabinPricingHandler.ashx?CruiseId=" + CruiseId + "&CabinId=4",

            //    data: fromdata,
            //    dataType: "json",
            //    success: function (msg) {
            //        //if (msg != "") {
            //        //    if (msg == "1") {
            //        //        $("#title-name").val('');
                   
            //        //        $("#SuccessStatus").text("Cruise Details inserted Successfully");
            //        //        $("#modal-success").modal("show");
                  
            //        //    }
            //        //    else if (msg == "0") {
            //        //        $("#FailureStatus").text("Error while inserting cruise details");
            //        //        $("#modal-danger").modal("show");
            //        //    }
            //        //}
            //        //else {

            //        //}
            //    },
            //    Error: function (x, e) {
            //        $("#FailureStatus").text("Error while inserting cruise details");
            //        $("#modal-danger").modal("show");
            //    }
            //});
        }
            //if (loopIntTill > 1) {
            //    fromdata.append(uploadedIntfiles[i].name, uploadedIntfiles[i]);
            //}
            //if (loopOcnTill > 1) {
            //    fromdata.append(uploadedOcnfiles[i].name, uploadedOcnfiles[i]);
            //}
            //if (loopBalTill > 1) {
            //    fromdata.append(uploadedBalfiles[i].name, uploadedBalfiles[i]);
            //}
            //if (loopSuiTill > 1) {
            //    fromdata.append(uploadedSuifiles[i].name, uploadedSuifiles[i]);
            //}
           
        // }
        //cid = JSON.stringify(cid);
        $.ajax({
            type: "POST",
            contentType: false,
            processData: false,
            url: "CabinPricingHandler.ashx?CruiseId=" + CruiseId + "&CabinId=" + cid,

            data: fromdata,
            dataType: "json",
            success: function (msg) {
                //if (msg != "") {
                //    if (msg == "1") {
                //        $("#title-name").val('');

                //        $("#SuccessStatus").text("Cruise Details inserted Successfully");
                //        $("#modal-success").modal("show");

                //    }
                //    else if (msg == "0") {
                //        $("#FailureStatus").text("Error while inserting cruise details");
                //        $("#modal-danger").modal("show");
                //    }
                //}
                //else {

                //}
            },
            Error: function (x, e) {
                $("#FailureStatus").text("Error while inserting cruise details");
                $("#modal-danger").modal("show");
            }
        });
        $("#modaloverlay").hide()
        $(" .collapse").css("display", "none");
        GetItenaryData();
        

       
    }
    else if (flag == "U") {
        GetItenaryData();
    }
}

function GetItenaryData() {
    var sr = 1;
    var days = [];
    var detail = [];
    var arrival = [];
    var depart = [];
    var itencruid = [];

    for (var i = 1; i < loopItenTill; i++) {
        if ($("#Iten_Detail_" + i).val() != undefined) {
            days.push(sr);
            detail.push($("#Iten_Detail_" + i).val());
            arrival.push($("#Iten_Arrival_" + i).val());
            depart.push($("#Iten_Depart_" + i).val());
            itencruid.push($("#Iten_Cur_" + i).html());
            sr++;
        }
    }

    if (flag == "U") {
        $.ajax({
            type: "POST",
            url: url + "/UpdateItenaryDetails",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({
                CruiseId: CruiseId, Days: days, Details: detail, Arrival: arrival, Depart: depart, ItenCurId: itencruid
            }),
            dataType: "json",
            async: false,
            success: function (msg) {
                GetOnBoardActivities();
            },
            Error: function (x, e) {
                alert(msg.d);
            }
        });
    }
    else {
        $.ajax({
            type: "POST",
            url: url + "/InsertItenaryDetails",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({
                CruiseId: CruiseId, Days: days, Details: detail, Arrival: arrival, Depart: depart
            }),
            dataType: "json",
            async: false,
            success: function (msg) {
                GetOnBoardActivities();
            },
            Error: function (x, e) {
                alert(msg.d);
            }
        });
    }
}

function GetOnBoardActivities() {
    var OnBoard = [];
    $.each($("input[name='Chk']:checked"), function () {
        OnBoard.push($(this).val());
    });

    $.ajax({
        type: "POST",
        url: url + "/InsertOnboardActivities",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({
            CruiseId: CruiseId, OnboardCatId: OnBoard, Flag: flag
        }),
        dataType: "json",
        async: false,
        success: function (msg) {
            
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function GetCabinDescription() {

    var cabinDesId = [];
    var cabinDesData = [];
    var data = $("#ContentPlaceHolder1_intdetail").val();
    if (data != "") {
        cabinDesId.push(Interior);
        cabinDesData.push(data);
    }
    var data1 = $("#ContentPlaceHolder1_oceanviewdetails").val();
    if (data1 != "") {
        cabinDesId.push(Ocean);
        cabinDesData.push(data1);
    }
    var data2 = $("#ContentPlaceHolder1_balconydetail").val();
    if (data2 != "") {
        cabinDesId.push(Balcony);
        cabinDesData.push(data2);
    }
    var data3 = $("#ContentPlaceHolder1_suitesdetail").val();
    if (data3 != "") {
        cabinDesId.push(Suite);
        cabinDesData.push(data3);
    }

    $.ajax({
        type: "POST",
        url: url + "/InsertCabinDescription",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({
            CruiseId: CruiseId, CabinId: cabinDesId, CabinDescription: cabinDesData
        }),
        dataType: "json",
        async: false,
        success: function (msg) {
            InsertShipInfo();
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function InsertShipInfo() {
    var ShipId = [];
    var ShipDetail = [];
    var data = $("#Gross-ton").val().trim();
    if (data != "") {
        ShipId.push(Grosston);
        ShipDetail.push(data);
    }
    data = $("#passengers").val().trim();
    if (data != "") {
        ShipId.push(NoOfPass);
        ShipDetail.push(data);
    }
    data = $("#Crew").val().trim();
    if (data != "") {
        ShipId.push(Crew);
        ShipDetail.push(data);
    }
    data = $("#stateRoom").val().trim();
    if (data != "") {
        ShipId.push(NoOfState);
        ShipDetail.push(data);
    }
    data = $("#length").val().trim();
    if (data != "") {
        ShipId.push(SLength);
        ShipDetail.push(data);
    }

    data = $("#decks").val().trim();
    if (data != "") {
        ShipId.push(Decks);
        ShipDetail.push(data);
    }
    data = $("#avgSpeed").val().trim();
    if (data != "") {
        ShipId.push(AvgSpeed);
        ShipDetail.push(data);
    }
    data = $("#width").val().trim();
    if (data != "") {
        ShipId.push(SWidth);
        ShipDetail.push(data);
    }

    $.ajax({
        type: "POST",
        url: url + "/InsertShipInfo",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({
            CruiseId: CruiseId, ShipId: ShipId, ShipDetail: ShipDetail, Flag: flag
        }),
        dataType: "json",
        async: false,
        success: function (msg) {
            $("#modaloverlay").hide()
            $(" .collapse").css("display", "none");
            if (flag == "U") {
                $("#SuccessStatus").text("Cruise Details updated Successfully");
            }
            else {
                $("#SuccessStatus").text("Cruise Details inserted Successfully");
            }
            $("#modal-success").modal("show");
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function getCruiseMaster() {
    $.ajax({
        type: "POST",
        url: url + "/GetCruiseMaster",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                mapCruiseMaster(jsonobj);
                BindCruiseMaster();

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

function mapCruiseMaster(jsonobj) {
    CruiseMasterList = $.map(jsonobj, function (el) {
        return {
            0: el.CruiseId,
            1: el.CruiseName,
            2: el.AliasForTrip,
            3: el.NoOfDays,
            4: el.NoOfNights
        }
    });
}

function BindCruiseMaster() {
    CruiseMasterTable = $("#tblCruiseMaster").dataTable({
        "data": CruiseMasterList,
        "bDestroy": true,
        "bPaginate": true,
        "paging": true,
        'autoWidth': false,
        //"aaSorting": [[1, "asc"]],


        "pageLength": 10,
        searching: true,
        "columnDefs": [
            { "targets": [0], "searchable": false, "visible": false, "sortable": true, "title": "Cruise id", "className": "col-xs-1" },
            { "targets": [1], "searchable": true, "visible": true, "sortable": false, "title": "Cruise Title", "className": "col-xs-1" },
            { "targets": [2], "searchable": true, "sortable": true, "title": "Alias Name", "className": "col-xs-1" },

            { "targets": [3], "searchable": true, "sortable": true, "title": "No. Day", "className": "col-xs-1" },
            { "targets": [4], "searchable": true, "sortable": true, "title": "No. Night", "className": "col-xs-1" },
            {
                "targets": [5], "searchable": true, "sortable": true, "title": "View Images", "className": "col-xs-1",
                "render": function (data, type, row) {
                    return "<div class='pull-left'><a id = 'view-" + row[0] + "' class='view' href=''>View Images</div>"
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
    bindTableEvents();
    if (CruiseId != undefined) {
        window.setTimeout(function () {
            fillData(CruiseId)
        }, 1000);

    }
}

function bindTableEvents() {
    $("#tblCruiseMaster").on("click", ".view", function (e) {
        e.preventDefault();
        debugger
        var rowid = $(this).attr("id");

        var cruise = rowid.split("-");

        CruiseId = cruise[1];
        GetCruiseImages(CruiseId);
        $("#Image").modal("show");
    });

    $("#tblCruiseMaster").on("click", '.set-alert2', function (e) {
        e.preventDefault();
        var rowid = $(this).attr("id");

        var trip = rowid.split("-");

        CruiseId = trip[1];
        var triparr = $.grep(CruiseMasterList, function (val, idx) {
            return CruiseMasterList[idx][0] == CruiseId
        });

        if (trip[0] == "edit") {
            // fillData(tripid);
            window.location.href = "/adminPages/CruiseMaster.aspx?CruiseId=" + CruiseId;
        }
        else {
            $("#CruiseName").text(triparr[0][1]);
            $("#deleteCruise").modal("show");
        }
    });

    $("#tableImages").on("click", ".clearImage", function (e) {
        e.preventDefault();
        var rowid = $(this).attr("id");

        var trip = rowid.split("-");

        imageid = trip[1];

        $("#deleteImage").modal("show");
    });
}

function fillData(CruiseId) {
    $.ajax({
        type: "POST",
        url: url + "/GetCruiseMasterDetail",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({
            CruiseId: CruiseId
        }),
        dataType: "json",

        success: function (msg) {
            var tbl = msg.d.split("~");

            var jObj = JSON.parse(tbl[0]);
            tab1 = $.map(jObj, function (e1) {
                return {
                    0: e1.CruiseName,
                    1: e1.NoOfDays,
                    2: e1.NoOfNights,
                    3: e1.AliasForTrip,
                    4: e1.PortSourceName,
                    5: e1.PortDestinationName,
                    6: e1.CompanyId,
                    7: e1.TaxPerPerson,
                    8: e1.GratuityForAdult,
                    9: e1.GratuityForChild
                }
            });
            $("#title-name").val(tab1[0][0]);
            $("#days").val(tab1[0][1]);
            $("#nights").val(tab1[0][2]);
            $("#detail-for").val(tab1[0][3]);
            $("#ddlSourceCountry").selectpicker('val', tab1[0][4]);
            $("#ddlDestinationCountry").selectpicker('val', tab1[0][5]);
            $("#ddlCompany").selectpicker('val', tab1[0][6]);
            $("#tax").val(tab1[0][7]);
            $("#GratAbFive").val(tab1[0][8]);
            $("#GratChild").val(tab1[0][9]);

            var jObj2 = JSON.parse(tbl[1]);
            tab2 = $.map(jObj2, function (e1) {
                return {
                    cabinid: e1.CruiseCabinId,
                    from: moment(e1.StartDate).format("DD-MMM-YYYY"),
                    to: moment(e1.EndDate).format("DD-MMM-YYYY"),
                    Price: e1.Price,
                    MainCost: e1.MainPrice,
                    CabId: e1.CurCabPriceId,
                    Id:e1.Id
                }
            });

            //console.log(tab2);
            tempDateArray = tab2;
           




            var uI = 1, uO = 1, uB = 1, uS = 1;
            // $("#AddRowInt").click();
            for (var i = 0; i < tab2.length; i++) {
                if (tab2[i][0] == 1) {
                    if (uI > 1) {
                        $("#AddRowInt").click();
                    }
                    var Id = loopIntTill - 1
                    $("#Int_startdt_" + Id).datepicker("setDate", (moment(tab2[i][1]).format("DD-MMM-YYYY")));
                    $("#Int_enddt_" + Id).datepicker("setDate", (moment(tab2[i][2]).format("DD-MMM-YYYY")));
                    //$("#Int_Price_" + Id).val(tab2[i][3]);
                    //  $("#Int_startdt_" + Id).val((moment(tab2[i][1]).format("DD-MMM-YYYY")));
                    // $("#Int_enddt_" + Id).val( (moment(tab2[i][2]).format("DD-MMM-YYYY")));
                    $("#Int_Price_" + Id).val(tab2[i][3]);
                    $("#Int_Cabin_Price_" + Id).html(tab2[i][4]);
                    $("#interiorDiv").addClass("hidden").removeClass("hidden");
                    $("#AddRowInt").addClass("hidden").removeClass("hidden");
                    uI++;
                }
                else if (tab2[i][0] == 2) {
                    if (uO > 1) {
                        $("#AddRowOcean").click();
                    }
                    var Id = loopOcnTill - 1
                    //var a = tab2[i][1].split("T");
                    $("#Ocn_startdt_" + Id).datepicker("setDate", (moment(tab2[i][1]).format("DD-MMM-YYYY")));
                    $("#Ocn_enddt_" + Id).datepicker("setDate", (moment(tab2[i][2]).format("DD-MMM-YYYY")));
                    $("#Ocn_Price_" + Id).val(tab2[i][3]);
                    $("#Ocn_Cabin_Price_" + Id).html(tab2[i][4]);
                    $("#OceanDiv").addClass("hidden").removeClass("hidden");
                    $("#AddRowOcean").addClass("hidden").removeClass("hidden");
                    uO++;
                }
                else if (tab2[i][0] == 3) {
                    if (uB > 1) {
                        $("#AddRowBal").click();
                    }
                    var Id = loopBalTill - 1
                    //console.log(Date.parse(tab2[i][1]));
                    $("#Bal_startdt_" + Id).datepicker("setDate", (moment(tab2[i][1]).format("DD-MMM-YYYY")));
                    $("#Bal_enddt_" + Id).datepicker("setDate", (moment(tab2[i][2]).format("DD-MMM-YYYY")));
                    $("#Bal_Price_" + Id).val(tab2[i][3]);
                    $("#Bal_Cabin_Price_" + Id).html(tab2[i][4]);
                    $("#BalconyDiv").addClass("hidden").removeClass("hidden");
                    $("#AddRowBal").addClass("hidden").removeClass("hidden");

                    uB++;
                }
                else if (tab2[i][0] == 4) {
                    if (uS > 1) {
                        $("#AddRowSui").click();
                    }
                    var Id = loopSuiTill - 1
                    //console.log(moment(tab2[i][1], "dd-M-yyyy"));
                    $("#Sui_startdt_" + Id).datepicker("setDate", (moment(tab2[i][1]).format("DD-MMM-YYYY")));
                    $("#Sui_enddt_" + Id).datepicker("setDate", (moment(tab2[i][2]).format("DD-MMM-YYYY")));
                    $("#Sui_Price_" + Id).val(tab2[i][3]);
                    $("#Sui_Cabin_Price_" + Id).html(tab2[i][4]);
                    $("#SuiteDiv").addClass("hidden").removeClass("hidden");
                    $("#AddRowSui").addClass("hidden").removeClass("hidden");
                    uS++;
                }
            }

            var jObj3 = JSON.parse(tbl[2]);
            tab3 = $.map(jObj3, function (e1) {
                return {
                    0: e1.Day,
                    1: e1.Detail,
                    2: e1.Arrival,
                    3: e1.Departature,
                    4: e1.ItineraryId
                }
            });

            for (var i = 0; i < tab3.length; i++) {
                if (i > 0) {
                    $("#AddRowIten").click();
                }
                var Id = loopItenTill - 1;
                $("#Iten_" + Id).val(tab3[i][0]);
                $("#Iten_Detail_" + Id).val(tab3[i][1]);
                $("#Iten_Arrival_" + Id).val(tab3[i][2]);
                $("#Iten_Depart_" + Id).val(tab3[i][3]);
                $("#Iten_Cur_" + Id).html(tab3[i][4]);
            }

            var jObj4 = JSON.parse(tbl[3]);
            tab4 = $.map(jObj4, function (e1) {
                return {
                    0: e1.OnboardCategoryId
                }
            });

            for (var i = 0; i < tab4.length; i++) {
                $(":checkbox[name='Chk'][value='" + tab4[i][0] + "']").attr('checked', true);
            }

            var jObj6 = JSON.parse(tbl[4]);
            tab6 = $.map(jObj6, function (e1) {
                return {
                    0: e1.ShipName,
                    1: e1.ShipId,
                    2: e1.Detail
                }
            });
            for (var i = 0; i < tab6.length; i++) {
                if (tab6[i][1] == 1) {
                    $("#Gross-ton").val(tab6[i][2])
                }
                if (tab6[i][1] == 2) {
                    $("#passengers").val(tab6[i][2])
                }
                if (tab6[i][1] == 3) {
                    $("#length").val(tab6[i][2])
                }
                if (tab6[i][1] == 4) {
                    $("#decks").val(tab6[i][2])
                }
                if (tab6[i][1] == 5) {
                    $("#avgSpeed").val(tab6[i][2])
                }
                if (tab6[i][1] == 6) {
                    $("#Crew").val(tab6[i][2])
                }
                if (tab6[i][1] == 7) {
                    $("#stateRoom").val(tab6[i][2])
                }
                if (tab6[i][1] == 8) {
                    $("#width").val(tab6[i][2])
                }
            }

            var jobj7 = JSON.parse(tbl[5]);
            tab7 = $.map(jobj7, function (e1) {
                return {
                   
                        0: e1.CruiseCabinId,
                        from: e1.StartDate,
                        ToDate: e1.EndDate,
                        Price: e1.MainPrice
                      
                    }
               
            });
            var countValue = 1;
           
            $.each(tab7, function (i) {
                //$.each(tab2, function (a) {
                //    //tempDateArray.push({ from: tab2[a]["cabinid"], })
                //    tempDateArray.push({ from: tab2[a]["from"], to: tab2[a]["Todt"], cabinid: tab2[a]["cabinid"], MainCost: tab7[i]["Price"], Price: tab2[a]["Price"], CabId: tab2[a]["Price"], Id: countValue });
                    
                //});

                //tab2 = $.grep(tab2, function (value) {
                //    return value.from === tab7[i]["from"] && value.Todt === tab7[i]["ToDate"] 
                //})
                //tempDateArray.push(tab2);
                TempTableArray.push({ from: moment(tab7[i]["from"]).format("DD-MMM-YYYY"), ToDate: moment(tab7[i]["ToDate"]).format("DD-MMM-YYYY"), Price: tab7[i]["Price"], id: countValue });
                countValue++;
            });
            dataCount = countValue;
            //tempDateArray = $.unique(tempDateArray);
            //result = [];
            //$.each(tempDateArray, function (i, e) {
            //    var matchingItems = $.grep(result, function (item) {
            //        return item.from === e.from && item.to === e.to && item.cabinid === e.cabinid && item.Price === e.Price  ;
            //    });
            //    if (matchingItems.length === 0) {
            //        result.push(e);
            //    }
            //});

            //tempDateArray = [];
            //tempDateArray = result;

            dataCount = 1;
            var DateTable = $("#tblDates tbody");
            DateTable.empty();
           // TempTableArray = tab7;
            $.each(tab7, function (i) {
                DateTable.append("<tr><td class='hidden'>" + dataCount + "</td>" + "<td>" + moment(tab7[i]["from"]).format("DD-MMM-YYYY") + "</td><td>" + moment(tab7[i]["ToDate"]).format("DD-MMM-YYYY") + "</td><td>" + tab7[i]["Price"] + "</td>" +
                "<td><span style='cursor:pointer' class='Editrow' id='editrow-" + dataCount + "'><i class='fa fa-pencil-square'></i></span></td> <td><span style='cursor:pointer' class='deleterow' id='delete-" + dataCount + "'><i class='fa fa-times-circle'></i></span></td></tr > ");
            dataCount++;
            });


        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });

    //triparr = $.grep(TripMasterList, function (val, idx) {
    //    return TripMasterList[idx][0] == tourid
    //});
    var locationstring = "";
    //var state = triparr[0][15];


    // $("#ddlcountry option:selected").val(triparr[0][14]);
    //$("#ddlstate").selectpicker('val', state);
    //$("#ddlcity").selectpicker('val', triparr[0][16]);
    //$("#tour-cost").val(triparr[0][3]);
    //$("#ddltour").selectpicker('val', triparr[0][2]);
    //$("#seat-no").val(triparr[0][11]);
    //inputFromDate = triparr[0][10];
    //$("#reservation").data('daterangepicker').setStartDate(moment(inputFromDate).format("MM/DD/YYYY"));

    //inputToDate = triparr[0][5];
    //$("#reservation").data('daterangepicker').setEndDate(moment(inputToDate).format("MM/DD/YYYY"));
    //// if (triparr[0][13] != "" && triparr[0][5] != null) { 
    //var values = triparr[0][13].split(",");
    //$('#ddlTheme').selectpicker('refresh');
    //$('#ddlTheme').selectpicker('val', values);

    ////i = 0, size = values.length;
    ////for (i; i < size; i++) {

    ////    $("#ddlTheme option[value='" + values[i] + "']").attr("selected", i);
    ////   // $("#ddlTheme").selectpicker("refresh");
    ////}

    ////}

    //$("#no-of-days").val(triparr[0][12]);
    ////   $("#ContentPlaceHolder1_inclusion").val(triparr[0][7]);
    ////   $("#ContentPlaceHolder1_Exclusion").val(triparr[0][6]);
    //var isactive = triparr[0][9];

    //if (isactive == "ACTIVE") {
    //    $('#activate').attr("checked", "checked")
    //}


}

function GetCruiseImages(CruiseId) {
    $.ajax({
        type: "POST",
        url: url + "/getCruiseImages",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ CruiseId: CruiseId }),
        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                mapCruiseImages(jsonobj);
            }
            else {
                CruiseImageList = null;
            }
            BindCruiseImages();
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function mapCruiseImages(obj) {
    CruiseImageList = $.map(obj, function (el) {
        return {
            0: el.CruiseId,
            1: el.CruiseImgId,
            2: el.ImagePath
        }
    });
}

function BindCruiseImages() {
    if (CruiseImageTable != null) {
        CruiseImageTable.fnDestroy();
        $("#tableImages").empty();
    }
    CruiseImageTable = $("#tableImages").dataTable({
        "data": CruiseImageList,
        "bDestroy": true,
        "bPaginate": true,
        "paging": true,
        'autoWidth': false,
        //"aaSorting": [[1, "asc"]],


        "pageLength": 10,
        searching: true,
        "columnDefs": [
            { "targets": [0], "searchable": false, "visible": false, "sortable": true, "title": "Cruise id", "className": "col-xs-1" },
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
    bindTableEvents();
}

//function bindImageEvents() {
//    $("#tableImages").on("click", ".clearImage", function (e) {
//        e.preventDefault();
//        var rowid = $(this).attr("id");

//        var trip = rowid.split("-");

//        imageid = trip[1];

//        $("#deleteImage").modal("show");
//    });
//}

function DeleteImage() {
    $.ajax({
        type: "POST",
        url: url + "/DeleteCruiseImages",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ ImageId: imageid }),
        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {
                    debugger
                    GetCruiseImages(CruiseId);
                }
            }
            else {
                CruiseImageList = null;
            }
            /// BindCruiseImages();
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}