<%@ Page Title="Company Master" Language="C#" MasterPageFile="~/AdminPages/AdminMasterPage.master" AutoEventWireup="true" CodeFile="CompanyMaster.aspx.cs" Inherits="AdminPages_CompanyMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../JS/jquery-1.11.2.min.js"></script>
    <script src="../JS/bootstrap.min.js"></script>
    <script src="../JS/jquery.dataTables.js"></script>
    <script src="../JS/dataTables.bootstrap.min.js"></script>
    <script src="../JS/dataTables.responsive.min.js"></script>
    <script src="../JS/dataTables.tableTools.min.js"></script>

    <script src="../JS/dataTables.colVis.min.js"></script>
    <script src="../JS/dataTables.buttons.min.js"></script>

    <link href="../Css/bootstrap.min.css" rel="stylesheet" />
    <%--  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>
    <script src="../JS/bootstrap.min.js"></script>
    <link href="../Css/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" />
    <link href="../Css/dataTables.bootstrap.css" rel="stylesheet" />
    <%--    <link href="../Css/dataTables.tableTools.css" rel="stylesheet" />
    <link href="../Css/dataTables.colVis.css" rel="stylesheet" />--%>
    <script src="../AdminContent/JS/Company.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<section class="content-header">
      <h1>
        Trip Type Master
        
      </h1>
    </section>--%>

    <section class="content">
        <div class="box box-primary">
            <div class="box-body">
                <div class="row">

                    <div class="col-sm-12 form-group">
                        <div class="col-sm-6">
                            <label for="trip-category">Company Name</label>
                            <input type="text" class="form-control" id="txtCompanyName" />
                        </div>
                        <div class="col-sm-6">
                            <label for="pd-image">Upload Images</label>
                            <input type="file" id="pd-image">
                            <p class="help-block">Only .png & .jpg is Supported.</p>
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <label style="color: orangered" name="CompanyMessage" id="CompanyMessage"></label>
                        <br />
                        <input type="submit" id="btnsubmit" value="Submit" class="btn btn-info" />
                        <input type="submit" id="btnEdit" class="btn btn-info" value="Update" />
                        <input type="submit" id="btnCancel" class="btn btn-info" value="Cancel" />
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-sm-12">
                        <table id="tblCompany" class="table table-bordered table-hover"></table>
                    </div>
                </div>



                <div class="modal fade" id="deleteModal" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Modal Header</h4>
                            </div>
                            <div class="modal-body">
                                Are You Sure you want to delete   <span id="CompanyName" style="font-weight: bold"></span>?

                            </div>
                            <div class="modal-footer">
                                <button type="button" id="btnConfirm" class="btn btn-info" data-dismiss="modal">Confirm</button>
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
