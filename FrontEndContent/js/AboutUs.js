var url = "AboutUs.aspx";

$(document).ready(function () {
    
    //$.ajax({
    //    type: "POST",
    //    url: url + "/GetAboutUs",
    //    contentType: "application/json; charset=utf-8",
    //    dataType: "json",
    //    success: function (msg) {
    //        if (msg.d != null) {
    //            var jsonobj = JSON.parse(msg.d);
    //            var data = $.map(jsonobj, function (e1) {
    //                return {
    //                    0: e1.ABOUTCONTENT,
    //                    1: e1.IMAGEPATH
    //                }
    //            });
    //            var str = '<img src="' + data[0][1] + '" class="img-rounded about-us-img">';
    //            $("#AboutImg").html(str);
    //            $("#dataDisplay").html(data[0][0]);
    //        }
    //    },
    //    Error: function (x, e) {
    //        alert(msg.d);
    //    }
    //});
});