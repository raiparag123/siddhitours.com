var HomeBanner = [];
var url = "default.aspx";
var TourPackage = [];
var PopularDestination = [];
var Tourarray = [];
var currencyFlag = "1";
$(document).ready(function () {
   // getHomeBanner();
    
    getServices();
    getDestination();
    GetFooter();
    currencyFlag = $("#currValue").val();
    if (currencyFlag == 0) {
        $("input[name='currency'][value=DOLLAR]").attr('checked', 'checked');
        $("input[name='currencyTOP'][value=DOLLAR]").attr('checked', 'checked');
    }
    else {
       
        $("input[name='currency'][value=INR]").attr('checked', 'checked');
        $("input[name='currencyTOP'][value=DOLLAR]").attr('checked', 'checked');
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
            url: "/frontendpages/Default.aspx/SetSession",
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
        BindTourPackage();
    });

    $(".search-Loc").autocomplete({
        source: function (request, response) {
            var param = { prefixText: $('#search').val() };
            $.ajax({
                url: "Default.aspx/GetSearchTrip",
                data: JSON.stringify(param),
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataFilter: function (data) { return data; },
                success: function (data) {
                    console.log(JSON.stringify(data));
                    response($.map(data.d, function (item) {
                        return {
                            value: item
                        }
                    }))
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                   // var err = eval("(" + XMLHttpRequest.responseText + ")");
                    alert(err.Message)
                    // console.log("Ajax Error!");    
                }
            });
        },
        minLength: 2//This is the Char length of inputTextBox    
    });


    $("#btnsearch").click(function (e) {
        e.preventDefault();
        var searchValue = $("#search").val();
        window.location.href = "/FrontendPages/Trip.aspx?Search=" + searchValue;
    });

    $("#submit").click(function (e) {
        //$('#form').bootstrapValidator('validate');

        e.preventDefault();
        SendMail();
    });
    getTourPackage();

});


function SendMail() {

    var name = $("#name").val();
    var email = $("#email").val();
    var phone = $("#phone").val();
    var message = $("#message").val();


    $.ajax({
        type: "POST",
        url: "Default.aspx/SendMail",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ Name: name, Email: email, Phone: phone, Message: message }),
        dataType: "json",
        success: function (msg) {
            console.log(msg.d);
            if (msg.d != "") {
                $("#name").val('');
                $("#email").val('');
                $("#phone").val('');
                $("#message").val('');

            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function getHomeBanner() {
    $.ajax({
        type: "POST",
        url: url + "/getHomeBanner",
        contentType: "application/json; charset=utf-8",

        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
                mapHomeBanner(jsonObj);
                BindBanner();


            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function mapHomeBanner(jsonObj) {
    HomeBanner = $.map(jsonObj, function (el) {
        return {
            0: el.IMAGEPATH,
            1: el.QUERYSTRING
            
        }
    })
}

function BindBanner() {
    var strBanner = "";
    if (HomeBanner.length > 0) {

        $.each(HomeBanner, function (i) {
            // if (i == 0) {
            //     $(".carousel-inner").append( "<div class='item active'>");
            //  }
            //  else {
            //$(".carousel-inner").append("<div class='item'>");
            // }

            //$(".carousel-inner").append("<div class='fill' style= 'background-image:url("+HomeBanner[i][0]+");' ></div >"+
            ////strBanner += "<div class='fill' style= 'background-image:url('abc.jpg');' ></div >" +
            //       "<div class='carousel-caption'>"+
            //            "<h1>Siddhi Tours</h1>"+
            //           "<h4></h4>"+
            //            ""+
            //            '</div>'+
            //        '</div >');
            if (i == 0) {
                $(".carousel-inner").append('<div class="item active">' +
                    '<div class="fill" style="background-image:url(' + HomeBanner[i][0] + ');"></div>' +
                    '<div class="carousel-caption">' +
                    '<h1>Siddhi Tours</h1>' +
                  //  '<h4>' + i + '</h4>' +
                    ' <a href="' + HomeBanner[i][1] + '" class="btn btn-default btn-lg">Go Explore</a>' +
                    ' </div>' +
                    '</div>');
            }
            else {
                $(".carousel-inner").append('<div class="item">' +
                    '<div class="fill" style="background-image:url(' + HomeBanner[i][0] + ');"></div>' +
                    '<div class="carousel-caption">' +
                    '<h1>Siddhi Tours</h1>' +
                    //'<h4>' + i + '</h4>' +
                    ' <a href="' + HomeBanner[i][1]+'" class="btn btn-default btn-lg">Go Explore</a>' +
                    ' </div>' +
                    '</div>');
            }


        });
      //  $(".carousel-inner").append(strBanner);
      //  $('.carousel').carousel();
        //$("#indicators").append(strTotalSlide);
       // $("#tripImages").append(strData);
      //  $('.item').first().addClass('active');
        //$('.carousel-indicators > li').first().addClass('active');
        // $("#myCarousel").carousel();
        //$('#myCarousel').carousel();
      // $('.carousel').carousel({
      // interval: 4000,

      // pause: 'false'//changes the speed,

   // })
    }
    
}

function getTourPackage() {
    $.ajax({
        type: "POST",
        url: url + "/getTourPackage",
        contentType: "application/json; charset=utf-8",

        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
                mapTourPackage(jsonObj);
                //BindTourPackage();


            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function mapTourPackage(jsonObj) {
    TourPackage = $.map(jsonObj, function (el) {
        return {
            0: el.IMAGEPATH,
            1: el.PACKAGEVALUE,
            2: el.PACKAGEID
        }
    });
    Tourarray = $.map(jsonObj, function (el) {
        return {
            0: el.IMAGEPATH,
            1: el.PACKAGEVALUE,
            2: el.PACKAGEID
        }
    })
    

    $.each(Tourarray, function (i) {
        var gp_from = "INR";
        var gp_to = "USD";
        var gp_amount = TourPackage[i][1];
        $.getJSON("http://www.geoplugin.net/currency_converter.gp?jsoncallback=?", { from: gp_from, to: gp_to, amount: gp_amount },
            function (output) {
                Tourarray[i][1] = output.to.amount;
                //var package = "Package=" + Tourarray[i][1];
                //$("#PackageRow").append("<div class='col-sm-3'>" +
                //    "<a class='under-img' href='../Frontendpages/trip.aspx?" + package + "''>" +
                //    "<div class='img__overlay '> $ " + Tourarray[i][1] + "</div>" +
                //    "<img src=" + Tourarray[i][0] + ">" +
                //    "</a>" +
                //    "</div>");

            });
    });

    setTimeout(BindTourPackage,750);
    
}

function BindTourPackage() {
  //  var Tourarray = [];
   // Tourarray = TourPackage.slice(0);
   // var orignilTour = TourPackage;
    var strPackage = "";
    if (currencyFlag == "1") {
        if (TourPackage.length > 0) {
            $("#PackageRow").empty();
            for (var i = 0; i < TourPackage.length; i++) {
                var package = "Package=" + TourPackage[i][1];
                strPackage += "<div class='col-sm-3'>" +
                    "<a class='under-img' href='../Frontendpages/trip.aspx?" + package + "''>" +
                    "<div class='img__overlay'><h4 class='rupee-font'> ₹ " + TourPackage[i][1] + "</h4></div>" +
                    "<img src=" + TourPackage[i][0] + ">" +
                    "</a>" +
                    "</div>";
            }
            $("#PackageRow").append(strPackage);
        }
    }
    else {
       
        $("#PackageRow").empty();
        strPackage = "";
        //$.each(Tourarray, function (i) {
        for (var i = 0; i < Tourarray.length; i++) {

            //var gp_from = "INR";
            //var gp_to = "USD";
            //var gp_amount = TourPackage[i][1];
            //$.getJSON("http://www.geoplugin.net/currency_converter.gp?jsoncallback=?", { from: gp_from, to: gp_to, amount: gp_amount },
            //    function (output) {
            //        Tourarray[i][1] = output.to.amount;
                    var package = "Package=" + Tourarray[i][1];
                    $("#PackageRow").append( "<div class='col-sm-3'>" +
                        "<a class='under-img' href='../Frontendpages/trip.aspx?" + package + "''>" +
                        "<div class='img__overlay '> <h4 class='rupee-font'>$ " + Tourarray[i][1] + "</h4></div>" +
                        "<img src=" + Tourarray[i][0] + ">" +
                        "</a>" +
                        "</div>");

            //    });
            //console.log(strPackage);

           

            //Tourarray[i][1]= getrate("INR", "USD", TourPackage[i][1]);
        }//);

        
                
      //  $("#PackageRow").append(strPackage);
        
    }
    
   

}

function getServices() {
    $.ajax({
        type: "POST",
        url: url + "/getServices",
        contentType: "application/json; charset=utf-8",

        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = msg.d.split("~");
                var obj = jsonObj
                console.log(obj);
                if (obj[0] != null) {
                    var obj1 = JSON.parse(obj[0]);
                    if (obj1.length > 0) {
                        $("#rent").attr("src", obj1[0]["IMAGEPATH"]);
                    }
                    else {
                        $("#rent").attr("src", "../img/d1.jpg");
                    }
                }
                else {
                    $("#rent").attr("src", "../img/d1.jpg");
                }
                if (obj[1] != null) {
                    var obj2 = JSON.parse(obj[1]);
                    if (obj2.length > 0) {
                        $("#B2b").attr("src", obj2[0]["IMAGEPATH"]);
                    }
                    else {
                        $("#B2b").attr("src", "../img/d2.jpg");
                    }
                }
                else {
                    $("#B2b").attr("src", "../img/d2.jpg");
                }
                if (obj[2] != null) {
                    var obj3 = JSON.parse(obj[2]);
                    if (obj3.length>0) {
                        $("#Visa").attr("src", obj3[0]["IMAGEPATH"]);
                    }
                    else {
                        $("#Visa").attr("src", "../img/d3.jpg");
                    }
                }
                else {
                    $("#visa").attr("src", "../img/d3.jpg");
                }

                if (obj[3] != null) {
                    var obj4 = JSON.parse(obj[3]);
                    if (obj4.length > 0) {
                        $("#cruise").attr("src", obj4[0]["IMAGEPATH"]);
                    }
                    else {
                        $("#cruise").attr("src", "../img/d3.jpg");
                    }
                }
                else {
                    $("#cruise").attr("src", "../img/d3.jpg");
                }

            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function getDestination() {
    $.ajax({
        type: "POST",
        url: url + "/getDestination",
        contentType: "application/json; charset=utf-8",

        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
                mapDestination(jsonObj);
                bindDestination();

            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function mapDestination(jsonObj) {
    PopularDestination = $.map(jsonObj, function (el) {
        return {
            0: el.IMAGEID,
            1: el.LOCATION,
            2: el.TITLE,
            3: el.IMAGEPATH,
            4: el.PPID


        }
    })
}

function bindDestination() {
    var strDestination = "";
    //var owl = $("#destination");

    
    if (PopularDestination.length > 0) {
        for (var i = 0; i < PopularDestination.length; i++) {
          
            strDestination += "<div class='item'>" +
             "<div class='panel panel-default'>" +
                "<div class='panel-body text-center'>" +
                "<a href='../FrontendPages/Trip.aspx?Title=" + PopularDestination[i][2].replace(" ","$")+"'>" +
                    "<div class='overlay'>" +
                    "<h3 class='overlay-title '>" + PopularDestination[i][2] + "</h3>"+
            "</div>" +
                "</a>" +
                "<img src="+PopularDestination[i][3]+" class='img-responsive'>" +
                "</div>"+
                "</div>" +
               
                "</div>";

            //'<div class="owl-item">'+
            //strDestination += '<div class="item">' +
            //    '<div class="panel panel-default">' +
            //    '<div class="panel-body text-center">' +
            //    '<a href="#">' +
            //    '<div class="overlay">' +
            //    ' <h3 class="overlay-title">Dashing Dubai</h3>' +
            //    '</div>' +
            //    '</a>' +
            //    '<img src="../img/d10.jpg" class="img-responsive">' +
            //    '</div>' +
            //    //'</div>'
            //    '</div>';
             
        }

        var carousel = $("#destination");
        carousel.trigger('destroy.owl.carousel');
        carousel.find('.owl-stage-outer').children().unwrap();
        carousel.removeClass("owl-center owl-loaded owl-text-select-on");

        carousel.html(strDestination);

        //reinitialize the carousel (call here your method in which you've set specific carousel properties)
        carousel.owlCarousel({
            center: true,
            loop: true,
            autoPlay: 3000,
            margin: 10,
            dots: true,
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
}

function GetFooter() {
    $.ajax({
        type: "POST",
        url: "Default.aspx/GetContactUs",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        //async: false,
        success: function (msg) {
            if (msg.d != "") {
                var jsonobj = JSON.parse(msg.d);
                mapContactUs(jsonobj);
                BindContactUs();
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function mapContactUs(jsonobj) {
    contactUs = $.map(jsonobj, function (el) {
        return {
            0: el.Email,
            1: el.FB,
            2: el.Instagram,
            3: el.Phone1,
            4: el.Phone2,
            5: el.IsWhatsapp1,
            6: el.IsWhatsapp2
        }
    });
}
function BindContactUs() {
    //console.log(contactUs);
    $("#FooteremailId").html(contactUs[0][0]);
    if (contactUs[0][5] == true) {
        $("#Footerwhats1").removeAttr("class", "fa-phone");
        $("#Footerwhats1").attr("class", "fa fa-whatsapp");
    }
    $("#Footermob1").html(contactUs[0][3]);
    if (contactUs[0][6] == true) {
        $("#Footerwhats2").removeAttr("class", "fa-phone");
        $("#Footerwhats2").attr("class", "fa fa-whatsapp");
    }
    $("#Footermob2").html(contactUs[0][4]);
    $("#fb").attr("href", contactUs[0][1]);
    $("#insta").attr("href", contactUs[0][2]);
}