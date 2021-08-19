<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPages/AdminMasterPage.master" AutoEventWireup="true" CodeFile="HomeBanner.aspx.cs" Inherits="AdminPages_HomeBanner" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../JS/jquery-1.11.2.min.js"></script>

    <script src="../JS/jquery.dataTables.js"></script>
    <script src="../ckeditor/ckeditor.js" type="text/javascript"></script>
    <script src="../JS/dataTables.responsive.min.js"></script>
    <script src="../JS/dataTables.tableTools.min.js"></script>
    <script src="../JS/dataTables.bootstrap.js"></script>
    <link href="../Css/dataTables.bootstrap.css" rel="stylesheet" />
    <%--  <script src="../JS/dataTables.colVis.min.js"></script>--%>
    <script src="../JS/dataTables.buttons.min.js"></script>
    <script src="../AdminContent/JS/select2.full.min.js"></script>


    <script src="../JS/bootstrap.min.js"></script>
    <link href="../Css/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" />
    <link href="../Css/dataTables.bootstrap.css" rel="stylesheet" />
    <link href="../Css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../css/multi-form.css">
    <link rel="stylesheet" href="../css/select2.min.css">
    <link rel="stylesheet" href="../css/AdminLTE.min.css">
    <script src="../AdminContent/JS/HomeBanner.js"></script>
    <script>
        var destination = '#<%=hdnDestination.ClientID%>'; 
       
    </script>
    <script>
        function showsuccess(label) {
            $("#SuccessStatus").text(label);
            $("#modal-success").modal("show");
        }
    </script>
    <script>
        function showerror(label) {
            $("#FailureStatus").text(label);
            $("#modal-danger").modal("show");
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content">

        <!--<div class="container">-->
        <div class="box box-primary">
            <div class="box-body">
                <div class="row">
                    <form role="form">
                        <asp:HiddenField ID="hdnDestination" runat="server" />
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label for="pd-image">Upload Image</label>
                                <asp:FileUpload type="file" ID="file1" runat="server" />

                                <p class="help-block">Only .png & .jpg is Supported</p>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label>Destination Link</label>
                                <select class="form-control select2" id="ddlDestination" style="width: 100%;">
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-1 text-center">
                            <h1>OR</h1>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label>Tour Packages Link</label>
                                <select class="form-control select2" id="ddlTourPackage" style="width: 100%;">
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <label style="color: orangered" name="homeMessage" id="homeMessage"></label>
                            <br />
                            <asp:Button type="submit" ID="btnSubmit" runat="server" class="btn btn-primary" OnClientClick="return validateData()" Text="Add Home Slider Image" OnClick="btnSubmit_Click"></asp:Button>
                        </div>
                    </form>
                </div>
                <hr>
                <div class="row">
                    <div class="col-sm-12">
                        <table id="tblHomeBanner" class="table table-bordered table-striped">
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!--</div>-->
        <div class="modal fade" id="deleteModal" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Delete Tour Package Under</h4>
                    </div>
                    <div class="modal-body">
                        Are You Sure you want to delete   <span id="BannerName"></span>

                    </div>
                    <div class="modal-footer">
                        <button type="button" id="btnconfirm" class="btn btn-info" data-dismiss="modal">Confirm</button>

                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>

            </div>
        </div>
    </section>
</asp:Content>