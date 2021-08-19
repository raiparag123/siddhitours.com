var url = "Trending.aspx";
var trending = [];
var DollarArray = [];
var currencyFlag = "1";
$(document).ready(function (e) {
    $("#nav").removeClass(".affix-top");
    $("#nav").removeAttr("data-spy");
    currencyFlag = $("#currValue").val();
    if (currencyFlag == 1) {
        $("input[name='currency'][value=INR]").attr('checked', 'checked');
       // BindTrending();
    }
    else {
        $("input[name='currency'][value=DOLLAR]").attr('checked', 'checked');
        //BindTrending();
    }
    getTrending();

    $("input[name='currency']").change(function () {
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
        BindTrending();
    });
});

function getTrending() {
    $.ajax({
        type: "POST",
        url: url + "/getTrending",
        contentType: "application/json; charset=utf-8",

        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
                mapTrending(jsonObj);
                BindTrending();
                $("#Trend-deal").show();
                $("#no-trending").hide();

            }
            else {
                $("#Trend-deal").hide();
                $("#no-trending").show();
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}


function mapTrending(jsonObj) {
    trending = $.map(jsonObj, function (el) {
        return {
            0: el.SEQUENCEID,
            1: el.GROUPNAME,
            2: el.TRIPID,
            3: el.TRIPTITLE,
            4: el.TRIPDAYS,
            5: el.TRIPCOST,
            6:el.IMAGEPATH

        }
    });

    DollarArray = $.map(jsonObj, function (el) {
        return {
            0: el.SEQUENCEID,
            1: el.GROUPNAME,
            2: el.TRIPID,
            3: el.TRIPTITLE,
            4: el.TRIPDAYS,
            5: el.TRIPCOST,
            6: el.IMAGEPATH

        }
    });
}

function BindTrending() {
    if (currencyFlag == 1) {

        var sequence1 = jQuery.grep(trending, function (n, idx) {
            return trending[idx][0] == 1;
        });

        var sequence2 = jQuery.grep(trending, function (n, idx) {
            return trending[idx][0] == 2;
        });

        var sequence3 = jQuery.grep(trending, function (n, idx) {
            return trending[idx][0] == 3;
        });

        var sequence4 = jQuery.grep(trending, function (n, idx) {
            return trending[idx][0] == 4;
        });



        if (sequence1.length > 0) {
            var firstdiv = "";
            $("#trending1-title").html(sequence1[0][1]);
            //$("#owl-demo").owlCarousel({
            $.each(sequence1, function (i) {
                var night = sequence1[i][4] - 1
                firstdiv += '<div class="item">' +
                    '<div class="panel panel-default" >' +
                    '<a href="tripDetail.aspx?Tripid=' + sequence1[i][2] + '">' +
                    '<div class="panel-body">' +
                    '<img src=' + sequence1[i][6] + ' class="img-responsive">' +
                    '<span class="label label-danger">' + night + ' Nights /' + sequence1[i][4] + ' Days</span>' +
                    '</div>' +
                    '<div class="panel-heading text-center">' +
                    '<div class="row">' +
                    '<div class="col-sm-6 title-1">' +
                    '<h4 class="word-wrap"  >' + sequence1[i][3] + '</h4 >' +
                    '</div>' +
                    '<div class="col-sm-6 title-price">' +
                    '<h4>₹' + sequence1[i][5] + '</h4>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</a>' +
                    '</div>' +
                    '</div >';
            });
            //});
            //$("#trending1").html(firstdiv);
            var carousel = $("#trending1");
            carousel.trigger('destroy.owl.carousel');
            carousel.find('.owl-stage-outer').children().unwrap();
            carousel.removeClass("owl-center owl-loaded owl-text-select-on");

            carousel.html(firstdiv);

            //reinitialize the carousel (call here your method in which you've set specific carousel properties)
            carousel.owlCarousel({
                //center: true,
                //loop: true,
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
            //$('#trending1').owlCarousel().trigger('add.owl.carousel',
            //   [jQuery(firstdiv)]).trigger('refresh.owl.carousel');
        }
        else {
            $("#trend1-div").hide();
        }

        if (sequence2.length > 0) {
            var seconddiv = "";
            $("#trending2-title").html(sequence2[0][1]);
            $.each(sequence2, function (i) {
                var night = sequence2[i][4] - 1
                seconddiv += '<div class="item">' +
                    '<div class="panel panel-default" >' +
                    '<a href="tripDetail.aspx?Tripid=' + sequence2[i][2] + '">' +
                    '<div class="panel-body">' +
                    '<img src=' + sequence2[i][6] + ' class="img-responsive">' +
                    '<span class="label label-danger">' + night + ' Nights /' + sequence2[i][4] + ' Days</span>' +
                    '</div>' +
                    '<div class="panel-heading text-center">' +
                    '<div class="row">' +
                    '<div class="col-sm-6 title-1">' +
                    '<h4 class="word-wrap ">' + sequence2[i][3] + '</h4 >' +
                    '</div>' +
                    '<div class="col-sm-6 title-price">' +
                    '<h4>₹' + sequence2[i][5] + '</h4>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</a>' +
                    '</div>' +
                    '</div >';
            });

            var carousel = $("#trending2");
            carousel.trigger('destroy.owl.carousel');
            carousel.find('.owl-stage-outer').children().unwrap();
            carousel.removeClass("owl-center owl-loaded owl-text-select-on");

            carousel.html(seconddiv);

            //reinitialize the carousel (call here your method in which you've set specific carousel properties)
            carousel.owlCarousel({
                //center: true,
                //loop: true,
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
        }
        else {
            $("#trend2-div").hide();
        }

        if (sequence3.length > 0) {
            var thirddiv = "";
            $("#trending3-title").html(sequence3[0][1]);
            $.each(sequence3, function (i) {
                var night = sequence3[i][4] - 1
                thirddiv += '<div class="item">' +
                    '<div class="panel panel-default" >' +
                    '<a href="tripDetail.aspx?Tripid=' + sequence3[i][2] + '">' +
                    '<div class="panel-body">' +
                    '<img src=' + sequence3[i][6] + ' class="img-responsive">' +
                    '<span class="label label-danger">' + night + ' Nights /' + sequence3[i][4] + ' Days</span>' +
                    '</div>' +
                    '<div class="panel-heading text-center">' +
                    '<div class="row">' +
                    '<div class="col-sm-6 title-1">' +
                    '<h4 class="word-wrap ">' + sequence3[i][3] + '</h4 >' +
                    '</div>' +
                    '<div class="col-sm-6 title-price">' +
                    '<h4>₹' + sequence3[i][5] + '</h4>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</a>' +
                    '</div>' +
                    '</div >';
            });
            var carousel = $("#trending3");
            carousel.trigger('destroy.owl.carousel');
            carousel.find('.owl-stage-outer').children().unwrap();
            carousel.removeClass("owl-center owl-loaded owl-text-select-on");

            carousel.html(thirddiv);

            //reinitialize the carousel (call here your method in which you've set specific carousel properties)
            carousel.owlCarousel({
                //center: true,
                //loop: true,
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
        }
        else {
            $("#trend3-div").hide();
        }

        if (sequence4.length > 0) {
            var fourthdiv = "";
            $("#trending4-title").html(sequence4[0][1]);
            $.each(sequence4, function (i) {
                var night = sequence4[i][4] - 1
                fourthdiv += '<div class="item">' +
                    '<div class="panel panel-default" >' +
                    '<a href="tripDetail.aspx?Tripid=' + sequence4[i][2] + '">' +
                    '<div class="panel-body">' +
                    '<img src=' + sequence4[i][6] + ' class="img-responsive">' +
                    '<span class="label label-danger">' + night + ' Nights /' + sequence4[i][4] + ' Days</span>' +
                    '</div>' +
                    '<div class="panel-heading text-center">' +
                    '<div class="row">' +
                    '<div class="col-sm-6 title-1">' +
                    '<h4 class="word-wrap ">' + sequence4[i][3] + '</h4 >' +
                    '</div>' +
                    '<div class="col-sm-6 title-price">' +
                    '<h4>₹ ' + sequence4[i][5] + '</h4>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</a>' +
                    '</div>' +
                    '</div >';
            });
            var carousel = $("#trending4");
            carousel.trigger('destroy.owl.carousel');
            carousel.find('.owl-stage-outer').children().unwrap();
            carousel.removeClass("owl-center owl-loaded owl-text-select-on");

            carousel.html(fourthdiv);

            //reinitialize the carousel (call here your method in which you've set specific carousel properties)
            carousel.owlCarousel({
                //center: true,
                //loop: true,
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
        }
        else {
            $("#trend4-div").hide();
        }
    }
    else {
        var sequence1;
        var sequence2;
        var sequence3;
        var sequence4;
        $.each(DollarArray, function (i) {


            var gp_from = "INR";
            var gp_to = "USD";
            var gp_amount = trending[i][5];
            $.getJSON("http://www.geoplugin.net/currency_converter.gp?jsoncallback=?", { from: gp_from, to: gp_to, amount: gp_amount },
                function (output) {
                    DollarArray[i][5] = output.to.amount;
                    if (i == DollarArray.length - 1) {
                        var sequence1 = jQuery.grep(DollarArray, function (n, idx) {
                            return DollarArray[idx][0] == 1;
                        });

                        var sequence2 = jQuery.grep(DollarArray, function (n, idx) {
                            return DollarArray[idx][0] == 2;
                        });

                        var sequence3 = jQuery.grep(DollarArray, function (n, idx) {
                            return DollarArray[idx][0] == 3;
                        });

                        var sequence4 = jQuery.grep(DollarArray, function (n, idx) {
                            return DollarArray[idx][0] == 4;
                        });


                        if (sequence1.length > 0) {
                            var firstdiv = "";
                            $("#trending1-title").html(sequence1[0][1]);
                            //$("#owl-demo").owlCarousel({
                            $.each(sequence1, function (i) {
                                var night = sequence1[i][4] - 1
                                firstdiv += '<div class="item">' +
                                    '<div class="panel panel-default" >' +
                                    '<a href="tripDetail.aspx?Tripid=' + sequence1[i][2] + '">' +
                                    '<div class="panel-body">' +
                                    '<img src=' + sequence1[i][6] + ' class="img-responsive">' +
                                    '<span class="label label-danger">' + night + ' Nights /' + sequence1[i][4] + ' Days</span>' +
                                    '</div>' +
                                    '<div class="panel-heading text-center">' +
                                    '<div class="row">' +
                                    '<div class="col-sm-6 title-1">' +
                                    '<h4 class="word-wrap ">' + sequence1[i][3] + '</h4 >' +
                                    '</div>' +
                                    '<div class="col-sm-6 title-price">' +
                                    '<h4>$' + sequence1[i][5] + '</h4>' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>' +
                                    '</a>' +
                                    '</div>' +
                                    '</div >';
                            });
                            //});
                            //$("#trending1").html(firstdiv);
                            var carousel = $("#trending1");
                            carousel.trigger('destroy.owl.carousel');
                            carousel.find('.owl-stage-outer').children().unwrap();
                            carousel.removeClass("owl-center owl-loaded owl-text-select-on");

                            carousel.html(firstdiv);

                            //reinitialize the carousel (call here your method in which you've set specific carousel properties)
                            carousel.owlCarousel({
                               
                                loop: false,
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
                            //$('#trending1').owlCarousel().trigger('add.owl.carousel',
                            //   [jQuery(firstdiv)]).trigger('refresh.owl.carousel');
                        }
                        else {
                            $("#trend1-div").hide();
                        }

                        if (sequence2.length > 0) {
                            var seconddiv = "";
                            $("#trending2-title").html(sequence2[0][1]);
                            $.each(sequence2, function (i) {
                                var night = sequence2[i][4] - 1
                                seconddiv += '<div class="item">' +
                                    '<div class="panel panel-default" >' +
                                    '<a href="tripDetail.aspx?Tripid=' + sequence2[i][2] + '">' +
                                    '<div class="panel-body">' +
                                    '<img src=' + sequence2[i][6] + ' class="img-responsive">' +
                                    '<span class="label label-danger">' + night + ' Nights /' + sequence2[i][4] + ' Days</span>' +
                                    '</div>' +
                                    '<div class="panel-heading text-center">' +
                                    '<div class="row">' +
                                    '<div class="col-sm-6 title-1">' +
                                    '<h4 class="word-wrap ">' + sequence2[i][3] + '</h4 >' +
                                    '</div>' +
                                    '<div class="col-sm-6 title-price">' +
                                    '<h4>$' + sequence2[i][5] + '</h4>' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>' +
                                    '</a>' +
                                    '</div>' +
                                    '</div >';
                            });

                            var carousel = $("#trending2");
                            carousel.trigger('destroy.owl.carousel');
                            carousel.find('.owl-stage-outer').children().unwrap();
                            carousel.removeClass("owl-center owl-loaded owl-text-select-on");

                            carousel.html(seconddiv);

                            //reinitialize the carousel (call here your method in which you've set specific carousel properties)
                            carousel.owlCarousel({
                                
                                loop: false,
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
                        }
                        else {
                            $("#trend2-div").hide();
                        }

                        if (sequence3.length > 0) {
                            var thirddiv = "";
                            $("#trending3-title").html(sequence3[0][1]);
                            $.each(sequence3, function (i) {
                                var night = sequence3[i][4] - 1
                                thirddiv += '<div class="item">' +
                                    '<div class="panel panel-default" >' +
                                    '<a href="tripDetail.aspx?Tripid=' + sequence3[i][2] + '">' +
                                    '<div class="panel-body">' +
                                    '<img src=' + sequence3[i][6] + ' class="img-responsive">' +
                                    '<span class="label label-danger">' + night + ' Nights /' + sequence3[i][4] + ' Days</span>' +
                                    '</div>' +
                                    '<div class="panel-heading text-center">' +
                                    '<div class="row">' +
                                    '<div class="col-sm-6 title-1">' +
                                    '<h4 class="word-wrap ">' + sequence3[i][3] + '</h4 >' +
                                    '</div>' +
                                    '<div class="col-sm-6 title-price">' +
                                    '<h4>$' + sequence3[i][5] + '</h4>' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>' +
                                    '</a>' +
                                    '</div>' +
                                    '</div >';
                            });
                            var carousel = $("#trending3");
                            carousel.trigger('destroy.owl.carousel');
                            carousel.find('.owl-stage-outer').children().unwrap();
                            carousel.removeClass("owl-center owl-loaded owl-text-select-on");

                            carousel.html(thirddiv);

                            //reinitialize the carousel (call here your method in which you've set specific carousel properties)
                            carousel.owlCarousel({
                               
                                loop: false,
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
                        }
                        else {
                            $("#trend3-div").hide();
                        }

                        if (sequence4.length > 0) {
                            var fourthdiv = "";
                            $("#trending4-title").html(sequence4[0][1]);
                            $.each(sequence4, function (i) {
                                var night = sequence4[i][4] - 1
                                fourthdiv += '<div class="item">' +
                                    '<div class="panel panel-default" >' +
                                    '<a href="tripDetail.aspx?Tripid=' + sequence4[i][2] + '">' +
                                    '<div class="panel-body">' +
                                    '<img src=' + sequence4[i][6] + ' class="img-responsive">' +
                                    '<span class="label label-danger">' + night + ' Nights /' + sequence4[i][4] + ' Days</span>' +
                                    '</div>' +
                                    '<div class="panel-heading text-center">' +
                                    '<div class="row">' +
                                    '<div class="col-sm-6 title-1">' +
                                    '<h4 class="word-wrap ">' + sequence4[i][3] + '</h4 >' +
                                    '</div>' +
                                    '<div class="col-sm-6 title-price">' +
                                    '<h4>$ ' + sequence4[i][5] + '</h4>' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>' +
                                    '</a>' +
                                    '</div>' +
                                    '</div >';
                            });
                            var carousel = $("#trending4");
                            carousel.trigger('destroy.owl.carousel');
                            carousel.find('.owl-stage-outer').children().unwrap();
                            carousel.removeClass("owl-center owl-loaded owl-text-select-on");

                            carousel.html(fourthdiv);

                            //reinitialize the carousel (call here your method in which you've set specific carousel properties)
                            carousel.owlCarousel({
                                center: true,
                                loop: false,
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
                        }
                        else {
                            $("#trend4-div").hide();
                        }

                    }
                });

            
            
        });

            




        }
}