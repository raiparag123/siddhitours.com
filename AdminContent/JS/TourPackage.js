var Packagelist = [];
var PackageTable = null;
var packageid = "";
var length = 0;
var fileExtension = ["jpg", "jpeg", "png"];


$(document).ready(function () {
    url = window.location.href;
    $("#modaloverlay").hide();
    $("#btnUpdate").hide();
    $("#btnSubmit").show();
    $("#btnCancel").hide();

    $("#title").text("Tour Package Master");
    getTourPackage();

    $("#btnconfirm").click(function (e) {
        $("#TourMessage").html("");
        e.preventDefault();
        Deletepackage();
    });

    $("#btnSubmit").click(function (e) {
        e.preventDefault();
        var length = 0;
        if (Packagelist == null) {
            length = 0;
        }
        else {
            length = Packagelist.length;
        }
        if (length > 4) {

            $("#TourMessage").html("Only four package can be uploaded");
            return false;
            
        }
        else {
            var amount = $("input[id$='tripcost1']").val();
            if (length > 0) {
                var packarr = $.grep(Packagelist, function (val, idx) {
                    return Packagelist[idx][1] == amount.trim();
                });
                if (packarr.length > 0) {
                    $("#TourMessage").html("Package already exist");
                    return false;
                }
                else {
                    InsertTourPackage("0", "A");
                }
            }
            else {
                InsertTourPackage("0", "A");
            }
        }
        


    });
    $("#btnUpdate").click(function (e) {
        e.preventDefault();
        var amount = $("input[id$='tripcost1']").val();
        var packarr = $.grep(Packagelist, function (val, idx) {
            return Packagelist[idx][1] == amount.trim() && Packagelist[idx][0] != packageid;
        });
        if (packarr.length > 0) {
            $("#TourMessage").html("Package already exist");
        }
        else {
            InsertTourPackage(packageid, "E");
        }

    });

    $("#btnCancel").click(function (e) {
        e.preventDefault();
        window.location.href = "TourPackage.aspx";
    });


  
   
    
    
});

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}


function InsertTourPackage(packid,flag) {
  
    var amount = $("input[id$='tripcost1']").val();
    var uploadfiles = $("#ContentPlaceHolder1_file1").get(0);
    var uploadedfiles = uploadfiles.files;

    if (amount.trim() == "") {
        $("#TourMessage").html("Please enter the amount for the package ");
        return false;
    }
    if (flag == "A") {
        if (uploadedfiles.length < 1) {
            $("#TourMessage").html("Select a file to upload ");
            return false;
        }
    }

    if ($("input[type='file']").val() != "") {
        var ext = $("input[type='file']").val().split('.').pop().toLowerCase();
        if (jQuery.inArray(ext, fileExtension) == '-1') {
            $("#TourMessage").html("Select a valid file");
            return false;

        }
    }


 
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
        url: "TourPackageUnder.ashx?Amount=" + amount + "&packid=" + packid + "&flag=" + flag,

        data: fromdata,
        dataType: "json",
        success: function (msg) {
            if (msg != "") {
                if (msg == 1) {
                    $("#TourMessage").html("");
                    $("#myBar").css("width", "100%")
                    $(".collapse").css("display", "none");
                    $("#ContentPlaceHolder1_tripcost1").val('');
                    $("#SuccessStatus").text("Tour Package inserted Successfully");
                    if (flag == "E") {
                        $("#btnUpdate").hide();
                        $("#btnSubmit").show();
                        $("#btnCancel").hide();

                    }
                    $("#modal-success").modal("show");
                    hideMainProcessing();

                    getTourPackage();
                    window.location.href="TourPackage.aspx";
                    
                }
            }
            else {
                $("#myBar").css("width", "100%")
                $(".collapse").css("display", "none");
                $("#FailureStatus").text("Error while inserting business tour");
                $("#modal-danger").modal("show");
            }
            hideMainProcessing();
        },
        Error: function (x, e) {
            $("#FailureStatus").text("Error while inserting business tour");
            $("#modal-danger").modal("show");
            hideMainProcessing();
        }
    });

    

}

function getTourPackage() {
    $.ajax({
        type: "POST",
        url: url + "/GetTourPackage",
        contentType: "application/json; charset=utf-8",

        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                var jsonObj = JSON.parse(msg.d);
                mapTourPackage(jsonObj);
               
                length = Packagelist.length;
                if (length > 0) {
                   
                }
                else {
                   
                }
                
               
            }
            else {
                Packagelist = null;
               
            }
            bindTourPackage();

        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function mapTourPackage(jsonObj) {
    Packagelist=$.map(jsonObj, function (el) {
        return {
            0: el.PACKAGEID,
            1: el.PACKAGEVALUE,
            2:el.IMAGEPATH
        }
    })
}


function bindTourPackage() {
    if (PackageTable != null) {
      
        $("#tourPackage").empty();
        PackageTable.fnDestroy();

    }
    PackageTable = $("#tourPackage").dataTable({
        "data": Packagelist,
        "bDestroy": true,
        "bPaginate": true,

        'autoWidth': false,
        //"aaSorting": [[1, "asc"]],
        searching: true,

        "columnDefs": [
            { "targets": [0], "searchable": false, "visible": false, "sortable": true, "title": "Package id", "className": "col-xs-1" },
            { "targets": [1], "searchable": true, "sortable": true, "title": "Package Name", "className": "col-xs-1" },
            {
                "targets": [2], "searchable": true, "sortable": true, "title": "Image", "className": "col-xs-1",
                render: function (data, type, row) {
                    return "<img src=" + row[2] + " width=75% />"
                }
            },
            {
                "targets": [3], "searchable": true, "title": "Edit/Delete", "className": "col-xs-1",
                "render": function (data, type, row) {
                    return "<div class='pull-left'><a id='edit-" + row[0] + "' class='set-alert2' href=''><i class='fa fa-pencil-square' aria-hidden='true'></i></a></div> <div class='pull-right' style='padding-right:10px;font-size:18px;'><a id='clear-" + row[0] + "' href='' class='set-alert2'><i class='fa fa-times-circle' aria-hidden='true'></i></a></div>";
                }
            }
        ]
    });
    bindTableEvents(PackageTable);
}

function bindTableEvents(PackageTable) {
    $(PackageTable).on("click",".set-alert2", function (e) {
        e.preventDefault();
        var rowid = $(this).attr("id");

        var tour = rowid.split("-");

        packageid = tour[1];
        var triparr = $.grep(Packagelist, function (val, idx) {
            return Packagelist[idx][0] == packageid
        });

        if (tour[0] == "edit") {

            $("#btnUpdate").show();
            $("#btnSubmit").hide();
            $("#btnCancel").show();

                $("input[id$='tripcost1']").val(triparr[0][1]);
           
        }
        else {
            $("#PackageName").html(triparr[0][1]);
            $("#deleteModal").modal("show");
        }
    });
}


function Deletepackage() {
    $.ajax({
        type: "POST",
        url: url + "/DeletePackage",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ PackageId: packageid }),
        dataType: "json",
        success: function (msg) {
            if (msg.d != "") {
                if (msg.d == "1") {

                    $("#SuccessStatus").text("Package Deleted Successfully");
                    $("#modal-success").modal("show");
                    getTourPackage();
                }
            }
            else {
                $("#FailureStatus").text("Error while deleting package");
                $("#modal-danger").modal("show");
            }

        },
        Error: function (x, e) {
            alert(msg.d);
        }
    });
}

function showMainProcessing() {

    $('#modaloverlay').show();

}
function hideMainProcessing() {
    $('#modaloverlay').hide();

}

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


