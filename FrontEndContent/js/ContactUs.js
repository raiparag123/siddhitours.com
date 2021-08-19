var url = "ContactUs.aspx";

$(document).ready(function () {

    $(".integer").keypress(function (e) {
        //if the letter is not digit then display error and don't type anything
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            return false;
        }
    });

    $.ajax({
        type: "POST",
        url: url + "/GetContactUs",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        //data: JSON.stringify({
        //    CruiseId: CruiseId, Title: title, days: days, nights: nights, AlisaName: aliasName, Source: source, Destination: destination, Inclusion: CrDetaulInclusion, Exclusion: CrDetailExclusion
        //}),
        success: function (msg) {
            if (msg.d != null) {
                var jsonobj = JSON.parse(msg.d);
                var data = $.map(jsonobj, function (e1) {
                    return {
                        0: e1.Address_Data,
                        1: e1.Email,
                        2: e1.GoogleMapLink,
                        3: e1.FB,
                        4: e1.Instagram,
                        5: e1.MOBILE1,
                        6: e1.MOBILE2,
                        7: e1.IsWhatsapp1,
                        8: e1.IsWhatsapp2
                    }
                });
                console.log(data[0][7]);

                $("#Address").html(data[0][0]);
                
                if (data[0][7] == true)
                {
                    $("#whats1").removeAttr("class","fa-phone");
                    $("#whats1").attr("class","fa fa-whatsapp");
                }
                $("#Mob1").html(data[0][5]);
                if (data[0][8] == true) {
                    $("#whats2").removeAttr("class", "fa-phone");
                    $("#whats2").attr("class", "fa fa-whatsapp");
                }
                $("#Mob2").html(data[0][6]);

                $("#Email").html(data[0][1]);
                $("#facebook").attr("href", data[0][3]);
                $("#insta").attr("href", data[0][4]);
            }
        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });

    $("#sendMail").click(function (e) {
        e.preventDefault();

        var name = $("#name").val();
        if (name.trim() == "")
        {
            $("#lblMessage").html("Please enter your name");
            return false;
        }
        var mob = $("#contactno").val();
        if (mob.trim() == "")
        {
            $("#lblMessage").html("Please enter mobile number");
            return false;
        }
        var emailid = $("#EmailId").val();
        if (emailid.trim() == "") {
            $("#lblMessage").html("Please enter email id");
            return false;
        }
        var expr = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
        var valid = expr.test(emailid);//.toString();
        //console.log(valid);
        if (valid == false) {
            $("#lblMessage").html("Please enter valid e-mail address");
            return false;
            //alert('Invalid');
        }
        
        //{
        //    $("#lblMessage").html('Please enter valid e-mail address');
        //    return false;
        //}​
        var detail = $("#desc").val();
        if (detail.trim() == "") {
            $("#lblMessage").html("Please type some message");
            return false;
        }

        $.ajax({
            type: "POST",
            url: url + "/GetUserDetails",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: JSON.stringify({
                Name: name, Mobile: mob, Email: emailid, Message: detail
            }),
            success: function (msg) {
                if (msg.d != null) {
                    $("#name").val("");
                    $("#contactno").val("");
                    $("#EmailId").val("");
                    $("#desc").val("");
                    alert("Thank you for your details. We will contact us soon");
                }
            },
            Error: function (x, e) {
                alert(msg.d);
            }
        });

    });
});