<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPages/AdminMasterPage.master" AutoEventWireup="true" CodeFile="RentCar.aspx.cs" Inherits="AdminPages_RentCar" %>

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
   
    <script src="../AdminContent/JS/Rent.js"></script>
    <script src="../JS/bootstrap.min.js"></script>
    <link href="../Css/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" />
 <link href="../Css/dataTables.bootstrap.css" rel="stylesheet" />
     <link href="../Css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../css/multi-form.css">
     <link rel="stylesheet" href="../css/AdminLTE.min.css">
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
					<div class="row">
						<div class="col-sm-4">
							<div class="form-group">
								<label>Vehicle Location</label>
								<select class="form-control selectpicker" id="ddlcity" data-live-search="true" style="width: 100%;">
									
								</select>
							</div>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<label>Vehicle Type</label>
								<select class="form-control selectpicker" id="ddlvehicle" data-live-search="true" style="width: 100%;">
									
								</select>
							</div>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
							  <label for="pd-image">Upload Images</label>
							  <input type="file" id="pd-image">
							  <p class="help-block">Only .png & .jpg is Supported</p>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6">
							<div class="form-group">
								<label for="vehicle-name">Vehicle Name</label>
								<input type="text" class="form-control" id="vehicle-name" placeholder="Enter vehicle name">
							</div>
						</div>
						<div class="col-sm-6">
							<div class="form-group">
								<label for="cost">Cost</label>
								<input type="number" class="form-control" onkeyup="return isNumber();" maxlength="6" id="cost" placeholder="Enter Cost">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6">
							<div class="form-group">
								<label class="control-label">Description</label>
								<textarea class="desc-txt" id="Description" placeholder="Description" runat="server" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
							</div>
						</div>	
						<div class="col-sm-6">
							<div class="form-group">
								<label class="control-label">Terms & Condition</label>
								<textarea class="terms-txt" id="terms" placeholder="Terms & Condition" runat="server" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
							</div>
						</div>
					</div>
					<div class="col-sm-12">
                         <label style="color: orangered" name="RentMessage" id="RentMessage"></label>
                                <br />
						<button type="submit" id="btnSubmit" class="btn btn-primary">Add  Details</button>
                        	<button type="submit" id="btnUpdate" class="btn btn-primary">Update  Details</button>
                        <button type="submit" id="btnCancel" class="btn btn-primary">Cancel</button>
					</div>
				</form>
				</div>
			</div>	
			<hr>
			<div class="row">
				<div class="col-sm-12">
					<table id="RentTbl" class="table table-bordered table-striped">
							
					</table>
				</div>
			</div>
		</div>	
	</div>	
	<!--</div>-->
	
    </section>
    
      <div class="modal fade" id="deleteRent" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close">
										  <span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">Delete Detail</h4>
        </div>
        <div class="modal-body">
       Are You Sure you want to delete  ?
        </div>
        <div class="modal-footer">
             <button type="button" id="btnConfirm" class="btn btn-info" data-dismiss="modal">Confirm</button>
           
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
    </div>
    <script>
 
    //Initialize Select2 Elements
   
	$(function () {
    $('.desc-txt').wysihtml5()
	$('.terms-txt').wysihtml5()
  })
</script>
</asp:Content>

