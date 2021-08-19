<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPages/AdminMasterPage.master" AutoEventWireup="true" CodeFile="TourPackage.aspx.cs" Inherits="AdminPages_TourPackage" %>

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
    <script src="../AdminContent/JS/TourPackage.js"></script>

    <script src="../JS/bootstrap.min.js"></script>
    <link href="../Css/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" />
    <link href="../Css/dataTables.bootstrap.css" rel="stylesheet" />
    <link href="../Css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../css/multi-form.css">
    <link rel="stylesheet" href="../css/select2.min.css">
    <link rel="stylesheet" href="../css/AdminLTE.min.css">

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
    <style>
        
	.loading-text{
                color: #000;
    font-weight: 700;
    letter-spacing: .5px;
    margin: 7px 5px 0;
        }
            .processing-bar-holder {
    position: fixed;
    top: 0;
    width: 300px;
    text-align: center;
    padding: 0;
    z-index: 2501;
    bottom: 0;
    height: 10px;
    margin: auto;
    left: 0;
    right: 0;
    height: 50px;
    background-color: rgba(255,255,255,0.9);
}
        .processing-bar {
    display: block;
    margin: 0 auto;
    border-bottom-left-radius: 5px;
    border-bottom-right-radius: 5px;
    padding: 0 10px;
    background-color: #00b0ef;
    text-align: center;
    color: #fff;
    font-size: 12px;
    position: relative;
}
        .bg-holder{
                  position: relative;
    background-color: #32404e;
    height: 9px;
    margin-top: 6px;
        }

        #myProgress {
            width: 100%;
            background-color: transparent;
        }

        #myBar {
           
            width: 1%;            
    height: 9px;
    background-color: #5195c5;   
    border-radius: 0;    
    position: relative;
        }
        .modaloverlay{
    background:transparent url(../images/overlay.png) repeat top left;
    position:fixed;
    top:0px;
    bottom:0px;
    left:0px;
    right:0px;
    z-index:1000;
    width:100%;
    height:100%;
    display:block;
    background-color:rgb(0,0,0);
    opacity:0.75;
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content">
        <div class="modaloverlay" id="modaloverlay"></div>
         <div id="processing-bar-holder" class="clearfix processing-bar-holder collapse">
            <div class="processing-bar" id="myProgress">
                <p class="loading-text">Uploading Files</p>
                <div class="bg-holder" style="display: none">
                    <div id="myBar"></div>
                </div>                
            </div>
        </div>
        <!--<div class="container">-->
        <div class="box box-primary">
            <div class="box-body">
                <div class="row">
                    <div class="col-sm-12">
                        <form role="form">
                            <asp:HiddenField ID="hdnfile1" runat="server" />
                           <%-- <asp:HiddenField ID="hdnfile2" runat="server" />
                            <asp:HiddenField ID="hdnfile3" runat="server" />
                            <asp:HiddenField ID="hdnfile4" runat="server" />--%>
                            <asp:HiddenField ID="pack1" runat="server" />
                           <%-- <asp:HiddenField ID="pack2" runat="server" />
                            <asp:HiddenField ID="pack3" runat="server" />
                                <asp:HiddenField ID="pack4" runat="server" />--%>

                            <asp:HiddenField ID="hdnpackid1" runat="server" />
                            <%--<asp:HiddenField ID="hdnpackid2" runat="server" />
                            <asp:HiddenField ID="hdnpackid3" runat="server" />
                             <asp:HiddenField ID="hdnpackid4" runat="server" />--%>

                            <div class="row" id="row1">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="trip-cost1">Cost Under</label>
                                        <asp:TextBox  runat="server" onkeypress="return isNumber();" maxlength="6" class="form-control" ID="tripcost1" placeholder="Enter Cost Under "></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label for="pd-image">Upload Image</label>
                                        <asp:FileUpload type="file" runat="server" ID="file1" />

                                        <p class="help-block">Only .png & .jpg is Supported</p>
                                    </div>
                                </div>

                            </div>
                            <hr>
                           <%-- <div class="row" id="row2">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="trip-cost2">Cost Under (Section 2)</label>
                                        <asp:TextBox type="number" runat="server"  onkeyup="return isNumber();" maxlength="6" class="form-control" ID="tripcost2" placeholder="Enter Cost Under "></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="pd-image">Upload Image</label>
                                        <asp:FileUpload runat="server" type="file" ID="file2" />

                                        <p class="help-block">Only .png & .jpg is Supported</p>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="row" id="row3">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="trip-cost3">Cost Under (Section 3)</label>
                                        <asp:TextBox runat="server" type="number"  onkeyup="return isNumber();" maxlength="6" class="form-control" ID="tripcost3" placeholder="Enter Cost Under "></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="pd-image">Upload Image</label>
                                        <asp:FileUpload type="file" ID="file3" runat="server" />

                                        <p class="help-block">Only .png & .jpg is Supported</p>
                                    </div>
                                </div>
                            </div>
                             <div class="row" id="row4">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="trip-cost3">Cost Under (Section 4)</label>
                                        <asp:TextBox runat="server" type="number"  onkeyup="return isNumber();" maxlength="6" class="form-control" ID="tripcost4" placeholder="Enter Cost Under "></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="pd-image">Upload Image</label>
                                        <asp:FileUpload type="file" ID="file4" runat="server" />

                                        <p class="help-block">Only .png & .jpg is Supported</p>
                                    </div>
                                </div>
                            </div>--%>
                            <div class="col-sm-12">
                                 <label style="color: orangered" name="TourMessage" id="TourMessage"></label>
                                <br />
                                <input type="submit"  ID="btnSubmit" class="btn btn-primary"   value="Save Changes"></input>
                                <input type="submit"  ID="btnUpdate" class="btn btn-primary"   value="Update Changes"></input>
                                 <input type="submit"  ID="btnCancel" class="btn btn-primary"   value="Cancel"></input>
                         

                            </div>
                        </form>
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-sm-12">
                        <table id="tourPackage" class="table table-bordered table-striped">
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
                        Are You Sure you want to delete   <span id="PackageName"></span>

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

