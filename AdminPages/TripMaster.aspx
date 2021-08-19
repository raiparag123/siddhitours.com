<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPages/AdminMasterPage.master" AutoEventWireup="true" CodeFile="TripMaster.aspx.cs" Inherits="AdminPages_TripMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <script src="../JS/jquery-1.11.2.min.js"></script>
 
    <script src="../JS/jquery.dataTables.js"></script>
   
     <script src="../JS/dataTables.responsive.min.js"></script>
        <script src="../JS/dataTables.tableTools.min.js"></script>
       <script src="../JS/dataTables.bootstrap.js"></script>
    <link href="../Css/dataTables.bootstrap.css" rel="stylesheet" />
      <%--  <script src="../JS/dataTables.colVis.min.js"></script>--%>
        <script src="../JS/dataTables.buttons.min.js"></script>
  <%--    <script src="../AdminContent/JS/select2.full.min.js"></script>--%>
    <link href="../Css/bootstrap-select.min.css" rel="stylesheet" />
    <script src="../AdminContent/JS/bootstrap-select.min.js"></script>
    <script src="../JS/bootstrap.min.js"></script>
    <link href="../Css/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" />
 <link href="../Css/dataTables.bootstrap.css" rel="stylesheet" />
     <link href="../Css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../css/multi-form.css">
    
     <link rel="stylesheet" href="../css/AdminLTE.min.css">
        <script src="../AdminContent/JS/TripMaster.js"></script>
 

<%--    <script src="../js/bootstrap.min.js"></script>
<!-- Select2 -->

<script src="../AdminContent/JS/select2.full.min.js"></script>
<!-- AdminLTE App -->
<script src="../js/adminlte.min.js"></script>--%>
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <section class="content">
      <asp:HiddenField ID="hdnTripId" runat="server" />
	<!--<div class="container">-->
         <div class="modaloverlay" id="modaloverlay"></div>
         <div id="processing-bar-holder" class="clearfix processing-bar-holder collapse">
            <div class="processing-bar" id="myProgress">
                <p class="loading-text">Uploading Files</p>
                <div class="bg-holder" style="display: none">
                    <div id="myBar"></div>
                </div>                
            </div>
        </div>
	<div class="box box-primary">
		<div class="box-body">
			<div class="container">
				<div class="stepwizard">
					<div class="stepwizard-row setup-panel">
						<div class="stepwizard-step col-xs-3"> 
							<a href="#step-1" id="1" type="button" class="btn btn-success btn-circle">1</a>
							<p><small>Tour Details</small></p>
						</div>
						<div class="stepwizard-step col-xs-3"> 
							<a href="#step-2" id="2" type="button" class="btn btn-default btn-circle" disabled="disabled">2</a>
							<p><small>Overview & Theme</small></p>
						</div>
						<div class="stepwizard-step col-xs-3"> 
							<a href="#step-3" id="3" type="button" class="btn btn-default btn-circle" disabled="disabled">3</a>
							<p><small>Itenary Details</small></p>
						</div>
						<div class="stepwizard-step col-xs-3"> 
							<a href="#step-4" id="4" type="button" class="btn btn-default btn-circle" disabled="disabled">4</a>
							<p><small>Image Upload and Finish</small></p>
						</div>
					</div>
				</div>
				
				<form role="form">
					<div class="panel panel-primary setup-content" id="step-1">
						<div class="panel-heading">
							 <h3 class="panel-title">Tour Details</h3>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label for="title-name">Tour Title</label>
								<input type="text" class="form-control" id="title-name" placeholder="Enter title">
							</div>
							<div class="row">
								<div class="col-sm-4">
									<div class="form-group">
									  <label>Select Country</label>
									  <select  class="form-control dropdown-list selectpicker" data-live-search="true"
                        data-width="100%" data-size="6" id ="ddlcountry" style="width: 100%;">
									<%--	<option>India</option>
										<option>China</option>--%>
									  </select>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="form-group">
									  <label>Select State</label>
									  <select  class="form-control dropdown-list selectpicker" data-live-search="true"
                        data-width="100%" data-size="6"  id="ddlstate" style="width: 100%;">
										<%--<option>Maharashtra</option>
										<option>Gujarat</option>--%>
									  </select>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="form-group">
									  <label>Select Places</label>
									  <select  class="form-control dropdown-list selectpicker" data-live-search="true"
                        data-width="100%" data-size="6" id="ddlcity" style="width: 100%;">
									<%--	<option>Coorg</option>
										<option>Agra</option>--%>
									  </select>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-4">
									<div class="form-group">
										<label for="tour-cost">Tour Cost</label>
										<input type="text" class="form-control" id="tour-cost" onkeyup="return isNumber();" maxlength="6" placeholder="Enter Tour Cost">
									</div>
								</div>
								<div class="col-sm-4">
									<div class="form-group">
									  <label>Select Tour Type</label>
									  <select class="form-control dropdown-list selectpicker" data-live-search="true"
                        data-width="100%" data-size="6" id="ddltour" style="width: 100%;">
										<%--<option>FIT</option>
										<option>Group Tour</option>
										<option>College IV</option>--%>
									  </select>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="form-group">
										<label for="seat-no">No. of Seat</label>
										<input type="text" class="form-control" id="seat-no" onkeyup="return isNumber();" maxlength="3" placeholder="Enter No. of Seat">
									</div>
								</div>
							</div>
							<div class="form-group">
							<label>Select Date range for FIT</label>
							<div class="input-group">
							  <div class="input-group-addon">
								<i class="fa fa-calendar"></i>
							  </div>
							  <input type="text" class="form-control pull-right" id="reservation">
							</div>
							<!-- /.input group -->
						  </div>
                              <label style="color: orangered" name="TrenMessage" id="tab1"></label>
                            <br />
							<button class="btn btn-primary nextBtn pull-right" type="button" id="btnTab1">Next</button>
						</div>
					</div>
					
					<div class="panel panel-primary setup-content" id="step-2">
						<div class="panel-heading">
							 <h3 class="panel-title">Overview & Theme</h3>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label>Theme</label>
								<select class="form-control dropdown-list selectpicker" data-live-search="true"
                        data-width="100%" data-size="6" multiple="multiple" data-placeholder="Select Theme" id="ddlTheme" style="width: 100%;">
									<%--<option>Beach</option>
									<option>Adventure</option>
									<option>Family</option>
									<option>Peaceful</option>--%>
								</select>
							</div>
							<div class="form-group">
								<label class="control-label">Overview About the Tour</label>
								<textarea class="overview-text" runat="server" placeholder="Overview of the tour..." id="txtOverview" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
							</div>
                             <label style="color: orangered" name="TrenMessage" id="tab2"></label>
                            <br />
							<button class="btn btn-primary nextBtn pull-right" id="btntab2" type="button">Next</button>
						</div>
					</div>
					
					<div class="panel panel-primary setup-content" id="step-3">
						<div class="panel-heading">
							 <h3 class="panel-title">Itenary Details</h3>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label for="no-of-days">No. of Days</label>
								<input type="number" class="form-control" id="no-of-days" onkeyup="return isNumber();" maxlength="2" placeholder="Enter No. of Days">
							</div>
							<div class="form-group">
								<div id="boxlimit">
                                <%--<button type="button" class="btn btn-success" data-toggle="modal" data-target="#modal-default">
									Day 1
								</button>--%>

                                    </div>
								<div class="modal fade" id="modal-default">
								  <div class="modal-dialog">
									<div class="modal-content">
									  <div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
										  <span aria-hidden="true">&times;</span></button>
										<h4 class="modal-title">Day <span id="day"></span></h4>
									  </div>
									  <div class="modal-body">
										<div class="form-group">
											<label class="control-label">Details</label>
											<textarea class="day-text" placeholder="Write your details here..." style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
										</div>
										<div class="form-group">
										  <label for="day-image">Upload Image</label>
										  <input type="file" id="day-image">
										  <p class="help-block">Only .png & .jpg is Supported</p>
										</div>
									  </div>
									  <div class="modal-footer">
										<button type="button" class="btn btn-primary">Save changes</button>
									  </div>
									</div>
									<!-- /.modal-content -->
								  </div>
								  <!-- /.modal-dialog -->
								</div>
								<!-- /.modal -->
							</div>
							<div class="form-group">
								<label class="control-label">Inclusion</label>
								<textarea class="inc-text" runat="server" id="inclusion" placeholder="Inclusion " style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
							</div>
                            <div class="form-group">
								<label class="control-label"> Exclusion</label>
								<textarea class="inc-text" runat="server" id="Exclusion" placeholder="Exclusion" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
							</div>
                             <label style="color: orangered" name="TrenMessage" id="tab3"></label>
                            <br />
							<button class="btn btn-primary nextBtn pull-right" type="button" id="btnTab3">Next</button>
						</div>
					</div>
					
					<div class="panel panel-primary setup-content" id="step-4">
						<div class="panel-heading">
							 <h3 class="panel-title">Image Upload and Finish</h3>
						</div>
						<div class="panel-body">
							<div class="row">
								<div class="col-sm-3 col-sm-offset-3">
									<div class="form-group">
									  <label for="tp-image">Upload Image</label>
									  <input type="file" id="tp-image" multiple>
									  <p class="help-block">Only .png & .jpg is Supported</p>
									</div>
								</div>
								<%--<div class="col-sm-3">
									<div class="form-group">
									<label for="tp-image">Activate the Tour ?</label>
									<br>
										<label class="switch1">
										  <input type="checkbox" name="checkactive" id="activate">

										  <span class="slider1 round1"></span>
										</label>
									</div>
								</div>--%>
							</div>
                             <label style="color: orangered" name="TrenMessage" id="tab4"></label>
                            <br />
							<button class="btn btn-success pull-right" type="submit" id="btnfinish">Finish!</button>
                            	<button class="btn btn-success pull-right" type="submit" id="btnUpdate">Update!</button>
						</div>
					</div>

                    <hr>
			<div class="row">
				<div class="col-sm-12">
					<table id="tblTripMaster" class="table table-bordered table-striped">
							
					</table>
				</div>
			</div>
				</form>
			</div>
		</div>	
	</div>	
       
         </section>

      <div class="modal fade" id="deleteTrip" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close">
										  <span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">Delete Trip</h4>
        </div>
        <div class="modal-body">
       Are You Sure you want to delete   <span id="tripname"></span>
            
        </div>
        <div class="modal-footer">
             <button type="button" id="btnConfirm" class="btn btn-info" data-dismiss="modal">Confirm</button>
           
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
    </div>

    <div class="modal fade" id="UpdateTrip" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close">
										  <span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">Update Tour</h4>
        </div>
        <div class="modal-body">
      Do you want to update itenary detail?
            
        </div>
        <div class="modal-footer">
             <button type="button" id="btnTour" class="btn btn-info" data-dismiss="modal">Yes</button>
           
          <button type="button" class="btn btn-default" id="btnCancel" data-dismiss="modal">No</button>
        </div>
      </div>
      
    </div>
    </div>

      <div class="modal fade" id="Image" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close">
										  <span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">Tour Images</h4>
        </div>
        <div class="modal-body">
   <table id="tableImages" class="table table-bordered table-striped" ></table>
            
        </div>
        <div class="modal-footer">
           
           
          <button type="button" class="btn btn-default"  data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
    </div>

      <div class="modal fade" id="deleteImage" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close">
										  <span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">Tour Images</h4>
        </div>
        <div class="modal-body">
   Are you sure you want to delete the image?
            
        </div>
        <div class="modal-footer">
           
            <button type="button" class="btn btn-default" id="confirmImage"  data-dismiss="modal">Confirm</button>
          <button type="button" class="btn btn-default"  data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
    </div>



    <script>
  $(function () {
    //Initialize Select2 Elements
    //$('.select2').select2()
	//Date Range Picker
        //$('#').daterangepicker()
        
	//HTML EDITOR
	$('.overview-text').wysihtml5()
	$('.inc-text').wysihtml5()
	$('.day-text').wysihtml5()
	})
	
	$(document).ready(function () {

   
});
</script>
</asp:Content>

