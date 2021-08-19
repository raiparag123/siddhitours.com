var TripDetail = [];
var ItenaryDetail = [];
var OtherDeal = [];
var url = "TripDetail.aspx";
currencyFlag = "1";
var categoryId = "";
var Tourarray = [];
$(document).ready(function (e) {
    $("#nav").removeClass(".affix-top");
    $("#nav").removeAttr("data-spy");
    var id = GetParameterValues("Tripid");
    GetTripDetail(id);

     currencyFlag = $("#currValue").val();
    if (currencyFlag == 1) {
        $("input[name='currency'][value=INR]").attr('checked', 'checked');
    }
    else {
        $("input[name='currency'][value=DOLLAR]").attr('checked', 'checked');
    }
    $("input[name='currency']:checked").val();


    $("input[name='currency").change(function (e) {
        //$('#form').bootstrapValidator('validate');
        var value = $("input[name='currency']:checked").val();
        var sendValue = ""
        if (value == 'INR') {
            sendValue = 1;
            currencyFlag = 1;
        }
        else {
            sendValue = 0;
            currencyFlag = 0;
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
         BindTour();
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

function GetTripDetail(tripid) {
    $.ajax({
        type: "POST",
        url: url + "/getTripDetail",
        contentType: "application/json; charset=utf-8",

        dataType: "json",

        data: JSON.stringify({ TripID: tripid }),
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = msg.d.split("~");
                var Trip = JSON.parse(jsonObj[0]);
                mapTourDetail(Trip);


                
                if (jsonObj[1] != "") {
                    var Itenary = JSON.parse(jsonObj[1]);
                    mapItenaryDetail(Itenary);
                }
                else {
                    $("#itenary").hide();
                }
                if (jsonObj[2] != "") {
                    var othertour = JSON.parse(jsonObj[2]);
                    mapOtherItenary(othertour);
                }
                BindTour();
               
                
                


            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function mapTourDetail(Trip) {
    TripDetail = $.map(Trip, function (el) {
        return {
            0: el.TRIPID,
            1: el.TRIPTITLE,
            2: el.TRIPTHEME,
            3: el.TRIPDAYS,
            4: el.COUNTRY,
            5: el.STATE,
            6: el.CITY,
            7: el.TRIPLOCATION,
            8: el.TRIPCOST,
            9: el.IMAGEPATH,
            10: el.TRIPINCLUSION,
            11: el.TRIPOVERVIEW,
            12: el.SEAT,
            13: el.TRIPDATE,
            14: el.TODATE,
            15: el.TRIPCATEGORY,
            16: el.TYPENAME,
            17: el.TRIPEXCLUSION





        }
    });
}

function mapItenaryDetail(Itenary) {
    ItenaryDetail = $.map(Itenary, function (el) {
        return {
            0: el.DAY,
            1: el.DAYDETAIL,
            2: el.IMAGEPATH
          
        }
    });
}

function mapOtherItenary(othertour) {
    OtherDeal = $.map(othertour, function (el) {
        return {
            0: el.TRIPID,
            1: el.TRIPTITLE, 
            2: el.TRIPCOST,
            3: el.IMAGEPATH
          

        }
    });
}

function BindTour() {
    if (TripDetail[0][15] == "1") {
        $("#groupDate").show();
    }
    else {
        $("#groupDate").hide();
    }

    if (TripDetail[0][15] == "2") {
        $("#seatTd").hide();
    }
    else {
        $("#seatTd").show();
    }


    if (currencyFlag == 1) {
        $("#Cost").text("₹" + TripDetail[0][8]);
    }
    else {
        amt = TripDetail[0][8];
        $.getJSON("http://www.geoplugin.net/currency_converter.gp?jsoncallback=?", { from: "INR", to: "USD", amount: amt },
            function (output) {
                $("#Cost").text("$" + output.to.amount);
            });
    }

    $("#Title").text(TripDetail[0][1]);
  
    var country = "";
    var state = "";
    var city = "";
    var string = "";
    if (TripDetail[0][4] != "0") {
        string += TripDetail[0][4] ;
    }
    if (TripDetail[0][5] != "0") {
        string += ">"+TripDetail[0][5]  ;
    }
    if (TripDetail[0][6] != "0") {
        string +=">"+  TripDetail[0][6] ;
    }
    
    $("#Location").text(string);
    $("#overview").html(TripDetail[0][11]);
    $("#Inclusion").html(TripDetail[0][10]);
    //TRIPEXCLUSION
    $("#Exclusion").html(TripDetail[0][17]);
    var day = parseInt(TripDetail[0][3])-1
    $("#day").text(day);
    $("#night").text(TripDetail[0][3]);
    $("#theme").text(TripDetail[0][2]);
    $("#seat").text(TripDetail[0][12]);
    $("#date").text(moment(TripDetail[0][13]).format("DD-MMM-YYYY"));
    $("#type").text(TripDetail[0][16]);
    strData = "";
    strTotalSlide = "";
    $(".carousel-indicators").empty();
    $("#tripImages").empty();
    $.each(TripDetail, function (i) {
        strData += '<div class="item">' +
            '<img src=' + TripDetail[i][9] + ' alt= "..." >' +

            '</div >';

        strTotalSlide += '<li data-target="#carousel-example-generic" data-slide-to="' + i +'" ></li> ';

    });
    $("#indicators").append(strTotalSlide);
    $("#tripImages").append(strData);
    $('.item').first().addClass('active');
    $('.carousel-indicators > li').first().addClass('active');
   // $("#myCarousel").carousel();
    $('#carousel-example-generic').carousel();
    strData = "";
    $("#ItenaryList").empty();
    $.each(ItenaryDetail, function (i) {
        strData += '<li>' +
            '<a href= "#" > Day' + ItenaryDetail[i][0] + '</a >' +
            '<div class="itenary-box">' +
            '<div class="row">' +
            '<div class="col-sm-4">'+
            '<img src=' + ItenaryDetail[i][2] + ' class="itenary-image">' +
            '</div>' +
            '<div class="col-sm-8">'+
            '<p>' + ItenaryDetail[i][1] + '</p>' +
            '</div>'+
            '</div>' +
            '</li>';
    });

    $("#ItenaryList").append(strData);

    strOther = "";
    $.each(OtherDeal, function (i) {
        strOther += '<div class="item">' +
            '<div class="panel panel-default" >' +
            '<div class="panel-body">' +
            '<img src=' + OtherDeal[i][3] + ' class="img-responsive">' +
            '</div>' +
            '<div class="panel-heading text-center">' +
            '<div class="row">' +
            '<div class="col-xs-12 title-1">' +
            '<h4>' + OtherDeal[i][1] + '</h4>' +
            '</div>' +

            '</div>' +
            '<div class="row">' +
            '<div class="col-sm-12 detail-button">' +
            '<a href=tripDetail.aspx?Tripid=' + OtherDeal[i][0] + '  class="btn btn-danger btn-sm" >View Details</a>' +
            '</div>' +
            '</div>' +
            '</div>' +
            '</div>' +
            '</div >'
    });

    var carousel = $("#OtherTour");
    carousel.trigger('destroy.owl.carousel');
    carousel.find('.owl-stage-outer').children().unwrap();
    carousel.removeClass("owl-center owl-loaded owl-text-select-on");

    carousel.html(strOther);

    //reinitialize the carousel (call here your method in which you've set specific carousel properties)
    carousel.owlCarousel({
        center: true,
        loop: true,
        margin: 10,
        responsive: {
            0: {
                items: 1
            },
            400: {
                items: 2
            },
            600: {
                items: 3
            },
            992: {
                items: 4
            }
        }
    });

    $('.next').click(function () {
        carousel.trigger('next.owl.carousel');
    })
    $('.prev').click(function () {
        carousel.trigger('prev.owl.carousel');
    })

}

