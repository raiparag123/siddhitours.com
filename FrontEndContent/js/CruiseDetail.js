var CruiseList = [];
var CruiseDlr = [];
var CabinList = [];
var cabinDlr = [];
var ItenaryList = [];
var OnBoard = [];
var shipdetail = [];
var Url = "CruiseDetail.aspx";
var currencyflag = "1";
$(document).ready(function () {
    var CruiseId = GetParameterValues("CruiseId");
    var date = GetParameterValues("Date");
    currencyflag = $("#currValue").val();
    if (currencyflag == 1) {
        $("input[name='currency'][value=INR]").attr('checked', 'checked');
    }
    else {
        $("input[name='currency'][value=DOLLAR]").attr('checked', 'checked');
    }
    getTourDetail(CruiseId, date);

    $("input[name='currency").change(function (e) {
        //$('#form').bootstrapValidator('validate');
        var value = $("input[name='currency']:checked").val();
        var sendValue = ""
        if (value == 'INR') {
            sendValue = 1;
            currencyflag = 1;
            BindTour();
        }
        else {
            sendValue = 0;
            currencyflag = 0;
            bindTourDlr();
        }
        $.ajax({
            type: "POST",
            url: "Default.aspx/SetSession",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ Value: sendValue }),
            dataType: "json",
            success: function (msg) {
                if (msg.d != "") {


                }
            },
            Error: function (x, e) {
                alert(msg.d);
            }
        });
        // BindRent();
    });

});


function GetParameterValues(param) {
    var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for (var i = 0; i < url.length; i++) {
        var urlparam = url[i].split('=');
        if (urlparam[0] == param) {
            return urlparam[1];
        }
    }
}

function getTourDetail(CruiseId, date) {


    $.ajax({
        type: "POST",
        url: Url + "/getCruiseDetail",
        contentType: "application/json; charset=utf-8",

        dataType: "json",

        data: JSON.stringify({ cruiseId: CruiseId, Date: date }),
        success: function (msg) {
            if (msg.d != "~~~~") {
                var Obj = msg.d.split("~");
                var cabin = "";
                var itenary = "";
                var onboard = "";
                var ship = "";
                if (Obj[0].length > 0) {
                    var cruise = JSON.parse(Obj[0]);
                    mapCruise(cruise);
                    if (Obj[1].length > 0) {
                        cabin = JSON.parse(Obj[1]);
                        mapCabin(cabin);
                    }
                    if (Obj[2].length > 0) {
                        itenary = JSON.parse(Obj[2]);
                        mapItenary(itenary);
                    }
                    if (Obj[3].length > 0) {
                        onboard = JSON.parse(Obj[3]);
                        maponboard(onboard);
                    }
                    if (Obj[4].length > 0) {
                        ship = JSON.parse(Obj[4]);
                        mapShip(ship);
                    }
                    if (currencyflag == 1) {
                        BindTour();
                    }
                    else {
                        bindTourDlr();
                    }
                    bindslickSlider();
                }




            }
            else {
                $("#cruise-desc").empty();
                $("#cruise-desc").append("<h1 align='center'>No Data Found</h1>");
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });


}

function mapCruise(obj) {
    CruiseList = $.map(obj, function (el) {
        return {
            0: el.CRUISEID,
            1: el.CRUISENAME,
            2: el.PORTSOURCENAME,
            3: el.PORTDESTINATIONNAME,
            4: el.TITLE,
            5: el.DAYS,
            6: el.NIGHTS,
            7: el.INCLUSIONS,
            8: el.EXCLUSIONS,
            9: el.IMAGEPATH,
            10: el.ADULT,
            11: el.CHILD,
            12: el.TAX
        }
    });

    CruiseDlr = $.map(obj, function (el) {
        return {
            0: el.CRUISEID,
            1: el.CRUISENAME,
            2: el.PORTSOURCENAME,
            3: el.PORTDESTINATIONNAME,
            4: el.TITLE,
            5: el.DAYS,
            6: el.NIGHTS,
            7: el.INCLUSIONS,
            8: el.EXCLUSIONS,
            9: el.IMAGEPATH,
            10: el.ADULT,
            11: el.CHILD,
            12: el.TAX
        }
    });
}

function mapCabin(obj) {
    CabinList = $.map(obj, function (el) {
        return {
            0: el.CABINID,
            1: el.CRUISEID,
            2: el.CABINNAME,
            3: el.CURISEIMGID,
            4: el.DESCRIPTION,
            5: el.IMAGEPATH,
            6: el.PRICE,
            7: el.STARTDATE,
            8: el.ENDDATE,
            9: el.MAINPRICE
        }
    });

    cabinDlr = $.map(obj, function (el) {
        return {
            0: el.CABINID,
            1: el.CRUISEID,
            2: el.CABINNAME,
            3: el.CURISEIMGID,
            4: el.DESCRIPTION,
            5: el.IMAGEPATH,
            6: el.PRICE,
            7: el.STARTDATE,
            8: el.ENDDATE,
            9: el.MAINPRICE

        }
    });
}

function mapItenary(obj) {
    ItenaryList = $.map(obj, function (el) {
        return {
            0: el.ITINERARYID,
            1: el.CRUISEID,
            2: el.DAY,
            3: el.DETAIL,
            4: el.ARRIVAL,
            5: el.DEPARTATURE
        }
    });
}

function maponboard(obj) {
    OnBoard = $.map(obj, function (el) {
        return {
            0: el.CONBOARDID,
            1: el.CONBOARDNAME,
            2: el.ONBOARDCATEGORYID,
            3: el.CATEGORYNAME,
            4: el.ICON
        }
    });
}

function mapShip(obj) {
    shipdetail = $.map(obj, function (el) {
        return {
            0: el.SHIPNAME,
            1: el.FAICONNAME,
            2: el.DETAIL
        }
    });
}

function BindTour() {

    if (CruiseList.length > 0) {
        strappend = "";
        strSub = "";


        $("#cabinTable").find("tbody").empty();
        if (CabinList.length > 0) {
            $("#mainprice").text("₹"+ CabinList[0][9]);
            $("#from").text(moment(CabinList[0][7]).format("DD-MMM-YYYY"));
            $("#to").text(moment(CabinList[0][8]).format("DD-MMM-YYYY"));
            $("#cabinTable").find("tbody").empty();

            strCabin = "";
            strCabinList = "";
            strCabinInfo = "";
            var cnt = 4;

            $.each(CabinList, function (i) {
                var total = parseInt(CabinList[i][6]) + parseInt(CruiseList[0][12]);
                strCabin += '<tr><td>' + CabinList[i][2] + '</td>' +
                    '<td> <img src="' + CabinList[i][5] + '" class="img-responsive"></td>' +
                    '<td>Adult:₹' + CruiseList[0][10] + '</br>' +
                    'Teenager:₹' + CruiseList[0][11] + ' </br> ' +
                    'Child:₹0 </br> ' +
                    '</td>' +
                    '<td>₹' + CruiseList[0][12] + '</td>' +
                    '<td>₹' + CabinList[i][6] + '</td>' +
                    '<td>₹' + total + '</td></tr > ';
                $("#ddlcabin").empty();
                $("#tab" + +cnt).empty();
                strCabinList += '<li class=""><a href="#tab' + cnt + '" data-toggle="tab" aria-expanded="false">' + CabinList[i][2] + '</a></li>';
                $("#tab" + +cnt).append('<div class="panel panel-default">' +
                    '<div class="panel-body" ><div class="row">' +
                    '<div class="col-sm-4">' +
                    '<img src=' + CabinList[i][5] + ' class="img-responsive">' +
                    '</div>' +
                    '<div class="col-sm-8">' +
                    '<h3>' + CabinList[i][2] + '</h3>' +
                    '<h4 class="rupee-font">₹' + CabinList[i][6] + '</h4>' +
                    '<p>' + CabinList[i][4] + '</p>' +
                    '</div>' +
                    '</div>');
                cnt++
            });
            $("#cabinTable").find("tbody").append(strCabin);
            $("#ddlcabin").append(strCabinList);


        }

        if (ItenaryList.length > 0) {
            $("#ItenaryList").find("li").empty();
            strItenary = "";
            $.each(ItenaryList, function (i) {
                strItenary += '<li><a href= "#" >' + ItenaryList[i][2] + '-' + ItenaryList[i][3] + '</a ></li>';
            });
            $("#ItenaryList").append(strItenary);

        }

    }
}


function sliderInit() {
    $(".slider-for").not('.slick-initialized').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: false,
        fade: true,
        asNavFor: '.slider-nav'
    });
    $('.slider-nav').not('.slick-initialized').slick({
        slidesToShow: 3,
        slidesToScroll: 1,
        asNavFor: '.slider-for',
        dots: false,
        focusOnSelect: true
    });


};


function bindTourDlr() {

    if (CruiseDlr.length > 0) {


        var gp_from = "INR";
        var gp_to = "USD";
        var gp_amount = CruiseList[0][10];
        $.getJSON("http://www.geoplugin.net/currency_converter.gp?jsoncallback=?", { from: gp_from, to: gp_to, amount: gp_amount },
            function (output) {
                CruiseDlr[0][10] = output.to.amount;
            });
        var gp_from = "INR";
        var gp_to = "USD";
        var gp_amount = CruiseList[0][11];
        $.getJSON("http://www.geoplugin.net/currency_converter.gp?jsoncallback=?", { from: gp_from, to: gp_to, amount: gp_amount },
            function (output) {
                CruiseDlr[0][11] = (output.to.amount);
            });

        var gp_from = "INR";
        var gp_to = "USD";
        var gp_amount = CruiseList[0][12];
        $.getJSON("http://www.geoplugin.net/currency_converter.gp?jsoncallback=?", { from: gp_from, to: gp_to, amount: gp_amount },
            function (output) {
                CruiseDlr[0][12] = (output.to.amount);
            });

        strappend = "";
        strSub = "";

        //$(".slider-for").slick({});
        //$(".slider-nav").append(strappend);
        //sliderInit();




        $("#cabinTable").find("tbody").empty();
        if (cabinDlr.length > 0) {
            
            $("#from").text(moment(cabinDlr[0][7]).format("DD-MMM-YYYY"));
            $("#to").text(moment(cabinDlr[0][8]).format("DD-MMM-YYYY"));
            

            strCabin = "";
            strCabinList = "";
            strCabinInfo = "";
            var cnt = 4;

            var gp_from = "INR";
            var gp_to = "USD";
            var gp_amount = cabinDlr[0][9];
            $.getJSON("http://www.geoplugin.net/currency_converter.gp?jsoncallback=?", { from: gp_from, to: gp_to, amount: gp_amount },
                function (output) {
                    //CruiseDlr[0][9] = (output.to.amount);
                    $("#mainprice").text("$" + output.to.amount);
                });


            $.each(cabinDlr, function (i) {

                var gp_from = "INR";
                var gp_to = "USD";
                var gp_amount = CabinList[i][6];
                $.getJSON("http://www.geoplugin.net/currency_converter.gp?jsoncallback=?", { from: gp_from, to: gp_to, amount: gp_amount },
                    function (output) {
                        cabinDlr[i][6] = (output.to.amount);


                        var total = Math.round(parseFloat(cabinDlr[i][6]) + parseFloat(CruiseDlr[0][12]));
                        strCabin += '<tr><td>' + CabinList[i][2] + '</td>' +
                            '<td> <img src="' + CabinList[i][5] + '" class="img-responsive"></td>' +
                            '<td>Adult:$' + CruiseDlr[0][10] + '</br>' +
                            'Teenager:$' + CruiseDlr[0][11] + ' </br> ' +
                            'Child:$0 </br> ' +
                            '</td>' +
                            '<td>$' + CruiseDlr[0][12] + '</td>' +
                            '<td>$' + cabinDlr[i][6] + '</td>' +
                        '<td>$' + total + '</td></tr > ';
                        $("#cabinTable").find("tbody").append(strCabin);
                        $("#ddlcabin").empty();
                        $("#tab" + +cnt).empty();
                        strCabinList += '<li class=""><a href="#tab' + cnt + '" data-toggle="tab" aria-expanded="false">' + cabinDlr[i][2] + '</a></li>';
                        $("#tab" + +cnt).append('<div class="panel panel-default">' +
                            '<div class="panel-body" ><div class="row">' +
                            '<div class="col-sm-4">' +
                            '<img src=' + cabinDlr[i][5] + ' class="img-responsive">' +
                            '</div>' +
                            '<div class="col-sm-8">' +
                            '<h3>' + cabinDlr[i][2] + '</h3>' +
                            '<h4 class="rupee-font">$' + cabinDlr[i][6] + '</h4>' +
                            '<p>' + cabinDlr[i][4] + '</p>' +
                            '</div>' +
                            '</div>');
                        $("#ddlcabin").append(strCabinList);
                        $("#cabinTable").find("tbody").empty();
                        $("#cabinTable").find("tbody").append(strCabin);
                        cnt++
                    });
            });
        }

        if (ItenaryList.length > 0) {
            $("#ItenaryList").find("li").empty();
            strItenary = "";
            $.each(ItenaryList, function (i) {
                strItenary += '<li><a href= "#" >' + ItenaryList[i][2] + '-' + ItenaryList[i][3] + '</a ></li>';
            });
            $("#ItenaryList").append(strItenary);
        }
    }
}
function bindslickSlider() {
    if (CruiseList.length > 0) {
        strappend = "";
        strSub = "";

        $("#title").text(CruiseList[0][4]);
        $("#day").text(CruiseList[0][5]);
        $("#night").text(CruiseList[0][6]);
        $("#source").text(CruiseList[0][2]);
        $("#Destination").text(CruiseList[0][2]);
        $("#inc").html(CruiseList[0][7]);
        $("#exc").html(CruiseList[0][8]);
        $(".slider-for").empty();
        $(".slider-nav").empty();
        $.each(CruiseList, function (i) {

            $(".slider-for").append("<div><img src='" + CruiseList[i][9] + "' class='img-responsive gallery-img-main'></div>");
            $(".slider-nav").append("<div><img src='" + CruiseList[i][9] + "' class='img-responsive gallery-img-nav'></div>");
        });

        $(".slider-for").not('.slick-initialized').slick({
            slidesToShow: 1,
            slidesToScroll: 1,
            arrows: false,
            fade: true,
            asNavFor: '.slider-nav'
        });
        $(".slider-nav").not('.slick-initialized').slick({
            slidesToShow: 3,
            slidesToScroll: 1,
            asNavFor: '.slider-for',
            dots: false,
            focusOnSelect: true

        });
        var Entertainment = jQuery.grep(OnBoard, function (n, idx) {
            return OnBoard[idx][0] == 1;
        });


        var Kids = jQuery.grep(OnBoard, function (n, idx) {
            return OnBoard[idx][0] == 2;
        });

        var lifestyle = jQuery.grep(OnBoard, function (n, idx) {
            return OnBoard[idx][0] == 3;
        });


        if (Entertainment.length > 0) {
            $("#enterDiv").show();
            var imgno = 0;
            var strenter = "";
            $("#Entertainment").addClass('row');
            $.each(Entertainment, function (i) {

                strenter += '<div class="col-sm-4" >' +
                    '<img src=' + Entertainment[i][4] + ' class="img-responsive">' +
                    '<h4>' + Entertainment[i][3] + '</h4>' +
                    '</div>';
                if (i != 0) {
                    if (i == 2) {
                        strenter += "</div><div class='row'>";
                        imgno = i + 3;
                    }
                    if (i == imgno) {
                        strenter += "</div><div class='row'>";
                        imgno = i + 3;
                    }
                }
            });

            $("#Entertainment").append(strenter);
            $("#Entertainment").append("</div>");
        }
        else {
            $("#enterDiv").hide();
        }


        if (Kids.length > 0) {
            $("#kid").show();
            var imgno = 0;
            var kid = "";
            $("#kid").addClass('row');
            $.each(Kids, function (i) {

                kid += '<div class="col-sm-4" >' +
                    '<img src=' + Kids[i][4] + ' class="img-responsive">' +
                    '<h4>' + Kids[i][3] + '</h4>' +
                    '</div>';
                if (i != 0) {
                    if (i == 2) {
                        kid += "</div><div class='row'>";
                        imgno = i + 3;
                    }
                    if (i == imgno) {
                        strenter += "</div><div class='row'>";
                        imgno = i + 3;
                    }
                }
            });

            $("#kidDiv").append(kid);
            $("#kidDiv").append("</div>");
        }
        else {
            $("#kid").hide();
        }

        if (lifestyle.length > 0) {
            $("#life").show();
            var imgno = 0;
            var life = "";
            $("#lifeDiv").addClass('row');
            $.each(lifestyle, function (i) {

                life += '<div class="col-sm-4" >' +
                    '<img src=' + lifestyle[i][4] + ' class="img-responsive">' +
                    '<h4>' + lifestyle[i][3] + '</h4>' +
                    '</div>';
                if (i != 0) {
                    if (i == 2) {
                        life += "</div><div class='row'>";
                        imgno = i + 3;
                    }
                    if (i == imgno) {
                        strenter += "</div><div class='row'>";
                        imgno = i + 3;
                    }
                }
            });

            $("#lifeDiv").append(life);
            $("#lifeDiv").append("</div>");
        }
        else {
            $("#life").hide();
        }


        if (shipdetail.length > 0) {
            $("#ship").show();
            var imgno = 0;
            var strenter = "";
            $("#ship").addClass('row');
            $.each(shipdetail, function (i) {

                strenter += '<div class="col-sm-4" >' +
                    '<img src="icon/avg_speed.png" class="img-responsive">' +
                    '<h4 style="text-align:center">' + shipdetail[i][0] + ' : ' + shipdetail[i][2] + '</h4>' +
                    '</div>';
                if (i != 0) {
                    if (i == 2) {
                        strenter += "</div><div class='row'>";
                        imgno = i + 3;
                    }
                    if (i == imgno) {
                        strenter += "</div><div class='row'>";
                        imgno = i + 3;
                    }
                }
            });

            $("#ship").append(strenter);
            $("#ship").append("</div>");
        }
    }
    else {
        $("#cruise-desc").empty();
        $("#cruise-desc").append("<h1 align='center'>No Data Found</h1>");
    }
}