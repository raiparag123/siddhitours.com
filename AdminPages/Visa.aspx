<%@ Page Title="" Language="C#" EnableEventValidation="false" MasterPageFile="~/AdminPages/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Visa.aspx.cs" Inherits="AdminPages_Visa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../JS/jquery-1.11.2.min.js"></script>

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
    <script src="../AdminContent/JS/Visa.js"></script>
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
    <!-- Content Header (Page header) -->
  <div class="modaloverlay" id="modaloverlay"></div>
         <div id="processing-bar-holder" class="clearfix processing-bar-holder collapse">
            <div class="processing-bar" id="myProgress">
                <p class="loading-text">Uploading Files</p>
                <div class="bg-holder" style="display: none">
                    <div id="myBar"></div>
                </div>                
            </div>
        </div>
   
    <!-- Main content -->
    <section class="content">
        <!--<div class="container">-->
        <div class="box box-primary">
            <div class="box-body">
                <div class="row">
                    <form role="form">
                        <div class="col-sm-3">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label>Select Country</label>
                                        <select id="ddlCountry" class="form-control select2" style="width: 100%;">
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="cost">Cost</label>
                                        <input type="number" id="cost"  onkeyup="return isNumber();" maxlength="6" class="form-control" placeholder="Enter Cost">
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="pd-image">Upload Images</label>
                                        <%--<input type="file" id="pd-image">--%>
                                        <input type="file" id="UploadDoc">
                                        <p class="help-block">Only .png, .jpeg & .jpg is Supported</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-9">
                            <div class="form-group">
                                <label class="control-label">Documents Required</label>
                                <textarea runat="server" id="DocReq" name="DocReq" class="textarea b2b-inc" placeholder="Inclusion / Exclusion" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <label style="color: orangered" name="homeMessage" id="visamessage"></label>
                            <br />
                            <button type="submit" id="btnVisa" class="btn btn-primary">Add Visa Details</button>
                            <button type="submit" id="btnEditVisa" class="btn btn-primary">Edit Visa Details</button>
                            <button type="submit" id="btnCancelVisa" class="btn btn-primary">Cancel</button>
                        </div>
                    </form>
                </div>
                <hr>
                <div class="row">
                    <div class="col-sm-12">
                        <table id="tblVisa" class="table table-bordered table-striped">
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!--</div>-->
    </section>
    <!-- /.content -->
    <div class="modal fade" id="deleteVisa" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Delete Visa</h4>
                </div>
                <div class="modal-body">
                    Are You Sure you want to delete this Visa
                </div>
                <div class="modal-footer">
                    <button type="button" id="btnConfirmVisa" class="btn btn-info" data-dismiss="modal">Confirm</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            $('.textarea').wysihtml5()
        })
</script>
</asp:Content>