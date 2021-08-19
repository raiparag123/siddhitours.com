<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPages/AdminMasterPage.master" AutoEventWireup="true" CodeFile="AboutUs.aspx.cs" Inherits="AdminPages_AboutUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../JS/jquery-1.11.2.min.js"></script>
    <script src="../JS/bootstrap.min.js"></script>
    <script src="../JS/jquery.dataTables.js"></script>
    <script src="../JS/dataTables.bootstrap.min.js"></script>
    <script src="../JS/dataTables.responsive.min.js"></script>
    <script src="../JS/dataTables.tableTools.min.js"></script>

    <script src="../JS/dataTables.colVis.min.js"></script>
    <script src="../JS/dataTables.buttons.min.js"></script>
    <script src="../AdminContent/JS/select2.full.min.js"></script>
    <link href="../Css/bootstrap.min.css" rel="stylesheet" />
    <%--  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>
    <script src="../JS/bootstrap.min.js"></script>
    <link href="../Css/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" />
    <link href="../Css/dataTables.bootstrap.css" rel="stylesheet" />
    <script src="../AdminContent/JS/AboutUs.js"></script>
    <link rel="stylesheet" href="../css/AdminLTE.min.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content">
       
        <!--<div class="container">-->
        <div class="box box-primary">
            <div class="box-body">
                 <div class="modaloverlay" id="modaloverlay"></div>
         <div id="processing-bar-holder" class="clearfix processing-bar-holder collapse">
            <div class="processing-bar" id="myProgress">
                <p class="loading-text">Uploading Files</p>
                <div class="bg-holder" style="display: none">
                    <div id="myBar"></div>
                </div>                
            </div>
        </div>
                <div class="row">
                    <form role="form">
                        <div class="col-sm-12">
                            <form>
                                <textarea class="textarea" runat="server" id="aboutus" placeholder="Place some text here" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>

                                <div class="form-group">
                                    <label for="pd-image">Upload Images</label>
                                    <input type="file" id="about-image">
                                    <p class="help-block">Only .png & .jpg is Supported.</p>
                                </div>
                            </form>
                        </div>
                        <div class="col-sm-12">
                            <label style="color: orangered" name="BTBMessage" id="lblmessage"></label>
                            <br />
                            <button type="submit" id="btnSubmit" class="btn btn-primary">Update</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!--</div>-->

    </section>
    <script>
        $(function () {
            //Initialize Select2 Elements
            $('.select2').select2()
        })

        $(function () {
            $('.textarea').wysihtml5()
        })
</script>
</asp:Content>