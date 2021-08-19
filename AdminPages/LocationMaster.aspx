<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPages/AdminMasterPage.master" AutoEventWireup="true" CodeFile="LocationMaster.aspx.cs" Inherits="AdminPages_LocationMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../JS/jquery-1.11.2.min.js"></script>
    <script src="../JS/bootstrap.min.js"></script>
    <script src="../JS/jquery.dataTables.js"></script>
    <script src="../JS/dataTables.bootstrap.js"></script>
    <link href="../Css/dataTables.bootstrap.css" rel="stylesheet" />
   <%-- <link rel="stylesheet" href="../css/AdminLTE.min.css">--%>
    <link rel="stylesheet" href="../css/multi-form.css">
    <%--  <script src="../JS/dataTables.colVis.min.js"></script>
        <script src="../JS/dataTables.buttons.min.js"></script>--%>

    <link href="../Css/bootstrap.min.css" rel="stylesheet" />
    <%--  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>

    <link href="../Css/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" />
    <link href="../Css/dataTables.bootstrap.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content">

        <!--<div class="container">-->
        <div class="row">
            <div class="col-sm-12">
                <!-- Custom Tabs -->
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab_1" data-toggle="tab">All</a></li>
                        <li><a href="#tab_2" data-toggle="tab">Country</a></li>
                        <li><a href="#tab_3" data-toggle="tab">City</a></li>
                        <li><a href="#tab_4" data-toggle="tab">Places</a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab_1">
                            <div class="box-body">
                                <table id="tblAllDestination" class="table table-bordered table-striped">
                                </table>
                            </div>
                        </div>
                        <!-- /.tab-pane -->
                        <div class="tab-pane" id="tab_2">

                            <div class="box-body">
                                <div class="form-group">
                                    <label for="country-name">Country</label>
                                    <input type="text" class="form-control" id="country-name" placeholder="Enter Country Name" required>
                                </div>
                                <label style="color: orangered" name="countryMessage" id="countryMessage"></label>
                                <br />
                                <input type="submit" id="btnCountry" class="btn btn-primary" value="Add Country" />
                                <input type="submit" id="btnCountryEdit" class="btn btn-primary" value="Edit Country" />
                                <input type="submit" id="btnCountryCancel" class="btn btn-primary" value="Cancel" />
                            </div>
                            <!-- /.box-body -->

                            <hr>
                            <div class="box-body">
                                <table id="tblCountry" class="table table-bordered table-striped">
                                </table>
                            </div>
                        </div>
                        <!-- /.tab-pane -->
                        <div class="tab-pane" id="tab_3">
                            <%--<form role="form">--%>
                            <div class="box-body">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label>Select Country</label>
                                            <select class="form-control select2" id="ddlCountry" style="width: 100%;">
                                                <%--<option>India</option>
										<option>China</option>--%>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="state-name">City</label>
                                            <input type="text" class="form-control" id="state-name" placeholder="Enter City Name" required>
                                        </div>
                                    </div>
                                </div>
                                <label style="color: orangered" name="stateMessage" id="stateMessage"></label>
                                <br />
                                <button type="submit" class="btn btn-primary" id="btnState">Add City</button>
                                <input type="submit" id="btnStateEdit" class="btn btn-primary" value="Edit State" />
                                <input type="submit" id="btnStateCancel" class="btn btn-primary" value="Cancel" />



                                <!-- /.box-body -->

                                <%--</form>--%>
                                <hr>
                                <div class="box-body">
                                    <table id="tblState" class="table table-bordered table-striped">
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- /.tab-pane -->
                        <div class="tab-pane" id="tab_4">

                            <div class="box-body">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label>Select Country</label>
                                            <select class="form-control select2" id="ddlcountry2" style="width: 100%;">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label>Select City</label>
                                            <select class="form-control select2" id="ddlstate" style="width: 100%;">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-group">
                                            <label for="place-name">Places</label>
                                            <input type="text" class="form-control" id="place-name" placeholder="Enter Places Name">
                                        </div>
                                    </div>
                                </div>
                                <label style="color: orangered" name="placeMessage" id="placeMessage"></label>
                                <br />
                                <button type="submit" class="btn btn-primary" id="btnCity">Add Places</button>
                                <input type="submit" id="btnCityEdit" class="btn btn-primary" value="Edit City" />
                                <input type="submit" id="btnCityCancel" class="btn btn-primary" value="Cancel" />

                            </div>
                            <!-- /.box-body -->

                            <hr>
                            <div class="box-body">
                                <table id="tblcity" class="table table-bordered table-striped">
                                </table>
                            </div>
                        </div>
                        <!-- /.tab-pane -->
                    </div>
                    <!-- /.tab-content -->
                </div>
                <!-- nav-tabs-custom -->
            </div>
        </div>
        <!--</div>-->

    </section>
    <div class="modal fade" id="deleteCountry" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Delete Country</h4>
                </div>
                <div class="modal-body">
                    Are You Sure you want to delete   <span id="CountryName"></span>

                </div>
                <div class="modal-footer">
                    <button type="button" id="btnConfirmCountry" class="btn btn-info" data-dismiss="modal">Confirm</button>

                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>

    <div class="modal fade" id="deleteState" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Delete State</h4>
                </div>
                <div class="modal-body">
                    Are You Sure you want to delete   <span id="StateName"></span>

                </div>
                <div class="modal-footer">

                    <button type="button" id="btnConfirmState" class="btn btn-info" data-dismiss="modal">Confirm</button>

                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>

    <div class="modal fade" id="deletecity" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Delete City</h4>
                </div>
                <div class="modal-body">
                    Are You Sure you want to delete   <span id="CityName"></span>

                </div>
                <div class="modal-footer">

                    <button type="button" id="btnConfirmCity" class="btn btn-info" data-dismiss="modal">Confirm</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>

    <script src="../AdminContent/JS/LocationMaster.js"></script>
</asp:Content>

