<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPages/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Trending.aspx.cs" Inherits="AdminPages_Trending" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
       <script src="../JS/jquery-1.11.2.min.js"></script>
 
    <script src="../JS/jquery.dataTables.js"></script>
  
     <script src="../JS/dataTables.responsive.min.js"></script>
        <script src="../JS/dataTables.tableTools.min.js"></script>
       <script src="../JS/dataTables.bootstrap.js"></script>
    <link href="../Css/dataTables.bootstrap.css" rel="stylesheet" />
      <%--  <script src="../JS/dataTables.colVis.min.js"></script>--%>
        <script src="../JS/dataTables.buttons.min.js"></script>
     <link href="../Css/bootstrap-select.min.css" rel="stylesheet" />
    <script src="../AdminContent/JS/bootstrap-select.min.js"></script>
    <script src="../AdminContent/JS/trending.js"></script>

    <script src="../JS/bootstrap.min.js"></script>
    <link href="../Css/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" />
 <link href="../Css/dataTables.bootstrap.css" rel="stylesheet" />
     <link href="../Css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../css/multi-form.css">
      
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <section class="content">
      
	<!--<div class="container">-->
	<div class="box box-primary">
		<div class="box-body">
			<div class="row">
				<form role="form">
					<div class="col-sm-12">
						<div class="row">
							<div class="col-sm-3">
								<div class="form-group">
									  <label>TrendingSequence</label>
									  <select class="form-control" id="ddltrend">
                                          <option value="0">Select Sequence</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
									  </select>
								</div>
							</div>
						</div>	
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<label for="grp-name">Group Name</label>
									<input type="text" class="form-control" id="txtgrp" placeholder="Enter Group Name">
								</div>
							</div>
							<div class="col-sm-12">
								<div class="form-group">
									<label>Tour Packages</label>
									<select class="form-control selectpicker" id="ddlpackage" data-live-search="true" data-width="100%" data-size="6" multiple="multiple"
                                        data-placeholder="Select Packages" style="width: 100%;">
									
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="col-sm-12">
                         <label style="color: orangered" name="TrenMessage" id="TrenMessage"></label>
                            <br />
						<button type="submit" id="btnSubmit" class="btn btn-primary">Save</button>
                        	<button type="submit" id="btnUpdate" class="btn btn-primary">Update</button>
					</div>
				</form>
			</div>	
			<hr>
			<div class="row">
				<div class="col-sm-12">
					<table id="tbltrend" class="table table-bordered table-striped">
							
					</table>
				</div>
			</div>
		</div>	
	</div>	
	<!--</div>-->
	
    </section>
    <div class="modal fade" id="deleteModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Delete Tour Package Under</h4>
        </div>
        <div class="modal-body">
       Are You Sure you want to delete   <span id="trend"></span>
            
        </div>
        <div class="modal-footer">
             <button type="button" id="btnconfirm" class="btn btn-info" data-dismiss="modal">Confirm</button>
           
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
    </div>

    <div class="modal fade" id="updateModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Update Trend</h4>
        </div>
        <div class="modal-body">
      Sequence already assigned to other group.Do you still want to update?   
            
        </div>
        <div class="modal-footer">
             <button type="button" id="btnupdateConfirm" class="btn btn-info" data-dismiss="modal">Confirm</button>
           
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
    </div>
</asp:Content>

