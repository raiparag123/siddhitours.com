var BusinessList = [];
var Country = [];
var State = [];
var City = [];
var url = "BusinessTour.aspx";
var filter = []
var flag = 0;
var country = "";

$(document).ready(function (e) {
    $("#nav").removeClass(".affix-top");
    $("#nav").removeAttr("data-spy");
    getTourList();
    $("#ddlcountry").change(function (e) {
        flag = 1;
        var value = $("#ddlcountry option:selected").val();
        filter = jQuery.grep(BusinessList, function (n, idx) {
            return BusinessList[idx][4] == value;
        });
        bindFilterTour(filter);
        country = value;
        BindStateDropDown();
    });

    $("#ddlState").change(function (e) {
        flag = 1;
        var value = $("#ddlState option:selected").val();
         filter = jQuery.grep(BusinessList, function (n, idx) {
            return BusinessList[idx][5] == value;
        });
        bindFilterTour(filter);
    });

    //$("#ddlCity").change(function (e) {
    //    flag = 1;
    //    var value = $("#ddlCity option:selected").val();
    //     filter = jQuery.grep(BusinessList, function (n, idx) {
    //        return BusinessList[idx][6] == value;
    //    });
    //    bindFilterTour(filter);
    //});

    $("#popular").click(function (e) {
        e.preventDefault();
        if (flag == 1) {
            filter.sort(function (a, b) {
                var a1 = a[0], b1 = b[0];

                if (a1 == b1) return 0;
                return a1 < b1 ? 1 : -1;
            });
            bindFilterTour(filter);
        }
        else {
            BusinessList.sort(function (a, b) {
                var a1 = a[0], b1 = b[0];
                if (a1 == b1) return 0;
                return a1 < b1 ? 1 : -1;
            });
            bindFilterTour(BusinessList);
        }
    });

    $("#high").click(function (e) {
        e.preventDefault();
        if (flag == 1) {
            filter.sort(function (a, b) {

                var a1 = a[2], b1 = b[2];
                if (a1 == b1) return 0;
                return a1 < b1 ? 1 : -1;
            });
            bindFilterTour(filter);
        }
        else {
            BusinessList.sort(function (a, b) {
                var a1 = a[2], b1 = b[2];
                if (a1 == b1) return 0;
                return a1 < b1 ? 1 : -1;
            });
            bindFilterTour(BusinessList);
        }

    });

    $("#low").click(function (e) {
        e.preventDefault();
        if (flag == 1) {
            filter.sort(function (a, b) {
                var a1 = a[2], b1 = b[2];
                if (a1 == b1) return 0;
                return a1 > b1 ? 1 : -1;
            });
            bindFilterTour(filter);
        }
        else {
            BusinessList.sort(function (a, b) {
                var a1 = a[2], b1 = b[2];
                if (a1 == b1) return 0;
                return a1 > b1 ? 1 : -1;
            });
            bindFilterTour(BusinessList);
        }
        
    });

});

function getTourList() {
    $.ajax({
        type: "POST",
        url: url + "/getTourList",
        contentType: "application/json; charset=utf-8",

        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
                mapTourList(jsonObj);
                BindTour();
                $("#Businesstour").show();
                $("#no-tour").hide();


            }
            else {
                $("#Businesstour").hide();
                $("#no-tour").show();
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function mapTourList(obj) {
    BusinessList = $.map(obj, function (el) {
        return {
            0: el.BUSINESSID,
            1: el.TITLE,
            2: el.COST,
            3: el.IMAGEPATH,
            4: el.COUNTRY,
            5: el.STATE,
            6: el.CITY


        }
    });

    $.each(BusinessList, function (i) {
        Country.push(BusinessList[i][4]);
        //State.push(BusinessList[i][5]);
        //City.push(BusinessList[i][6]);
    })
    Country = jQuery.unique(Country);
    //State = jQuery.unique(State);
    //City = jQuery.unique(City);
    BindDropdown();
}

function BindDropdown() {
    if (Country.length > 0) {
        strCountry = "";
        //strCountry="<option value=0>Select</option>"
        $.each(Country, function (i) {
            strCountry += "<option value=" + Country[i] + ">" + Country[i]+"</option>"
        });
        $("#ddlcountry").append(strCountry);
    }

    //if (State.length > 0) {
    //    strState = "";
    //    //strCountry="<option value=0>Select</option>"
    //    $.each(State, function (i) {
    //        strState += "<option value=" + State[i] + ">" + State[i] + "</option>"
    //    });
    //    $("#ddlState").append(strState);
    //}
    getStateList();

    //if (City.length > 0) {
    //    strCity = "";
    //    //strCountry="<option value=0>Select</option>"
    //    $.each(City, function (i) {
    //        strCity += "<option value=" + City[i] + ">" + City[i] + "</option>"
    //    });
    //    $("#ddlCity").append(strCity);
    //}

}


function BindTour() {
  
    var strData = "";
    $("#b2bData").empty();
    $("#b2bData").addClass('row');
    if (BusinessList.length > 0) {
        var imgno = 0;
        $.each(BusinessList, function (i) {
            strData += '<div class="col-sm-4">' +
                '<div class="panel panel-default" >' +
                '<div class="panel-body">' +
                '<img src=' + BusinessList[i][3] + ' class="img-responsive">' +

                '</div>' +
                ' <div class="panel-heading text-center">' +
                '<div class="row">' +
                '<div class="col-sm-6 title-1">' +
                '<h4>' + BusinessList[i][1] + '</h4>' +
                '</div>' +
                ' <div class="col-sm-6 title-price">' +

                '</div>' +
                '</div>' +
                ' <div class="row">' +
                '<div class="col-sm-12 detail-button">' +
                '<a href="BusinessTourDetail.aspx?BusinessId='+ BusinessList[i][0] +'" class="btn btn-danger btn-sm" >View Details</a>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div >';
            if (i != 0) {
                if (i == 2) {
                    $("#b2bData").append("</div><div class='row sub-title'>");
                    imgno = i + 3;
                }
                if (i == imgno) {
                    $("#b2bData").append("</div><div class='row sub-title'>");
                    imgno = i + 3;
                }
            }
        });
        $("#b2bData").append(strData);
        $("#b2bData").append("</div>");
    }

}


function bindFilterTour(filterarr){
    var strData = "";
    $("#b2bData").empty();
    $("#b2bData").addClass('row');
    if (filterarr.length > 0) {
        var imgno = 0;
        $.each(filterarr, function (i) {
            strData += '<div class="col-sm-4">' +
                '<div class="panel panel-default" >' +
                '<div class="panel-body">' +
                '<img src=' + filterarr[i][3] + ' class="img-responsive">' +

                '</div>' +
                ' <div class="panel-heading text-center">' +
                '<div class="row">' +
                '<div class="col-sm-6 title-1">' +
                '<h4>' + filterarr[i][1] + '</h4>' +
                '</div>' +
                ' <div class="col-sm-6 title-price">' +

                '</div>' +
                '</div>' +
                ' <div class="row">' +
                '<div class="col-sm-12 detail-button">' +
                '<a href="BusinessTourDetail.aspx?BusinessId=' + filterarr[i][0] + '" class="btn btn-danger btn-sm" >View Details</a>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div >';
            if (i != 0) {
                if (i == 2) {
                    $("#b2bData").append("</div><div class='row sub-title'>");
                    imgno = i + 3;
                }
                if (i == imgno) {
                    $("#b2bData").append("</div><div class='row sub-title'>");
                    imgno = i + 3;
                }
            }
        });
        $("#b2bData").append(strData);
        $("#b2bData").append("</div>");
    }
    else {
        $("#b2bData").append("<h1>No Data Found</h1>");
        $("#b2bData").append("</div>");
    }
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

                //BindStateDropDown();
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function mapStateList(jsonobj) {
    State = $.map(jsonobj, function (el) {
        return {
            0: el.STATEID,
            1: el.STATENAME,
            2: el.COUNTRYNAME
        }
    });
}

function BindStateDropDown() {
    var appendvalue = "";
    $("#ddlState").empty();
    for (var i = 0; i <= State.length - 1; i++) {
        if (country == State[i][2]) {
            appendvalue += "<option value=" + State[i][1].replace(" ", "_") + ">" + State[i][1] + "</option>";
        }
    }
    $("#ddlState").append("<option value=0>Select</option>");
    $("#ddlState").append(appendvalue);
    $("#ddlState").selectpicker('refresh');
}