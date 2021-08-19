<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPages/AdminMasterPage.master" AutoEventWireup="true" CodeFile="ItenaryMaster.aspx.cs" Inherits="AdminPages_ItenaryMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script src="../JS/jquery-1.11.2.min.js"></script>
 
    <script src="../JS/jquery.dataTables.js"></script>
   
     <script src="../JS/dataTables.responsive.min.js"></script>
        <script src="../JS/dataTables.tableTools.min.js"></script>
       <script src="../JS/dataTables.bootstrap.js"></script>
   
      <%--  <script src="../JS/dataTables.colVis.min.js"></script>--%>
     <%--   <script src="../JS/dataTables.buttons.min.js"></script>--%>
  <%--    <script src="../AdminContent/JS/select2.full.min.js"></script>--%>
   
    <script src="../AdminContent/JS/bootstrap-select.min.js"></script>
    <script src="../JS/bootstrap.min.js"></script>
    <link href="../Css/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" />
 
     <link href="../Css/bootstrap.min.css" rel="stylesheet" />
     <link href="../Css/dataTables.bootstrap.css" rel="stylesheet" />
    <%--<link rel="stylesheet" href="../css/multi-form.css">--%>
    <script src="../AdminContent/JS/ItenaryMaster.js"></script>
   <%--  <link rel="stylesheet" href="../css/AdminLTE.min.css">--%>
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
								<div class="col-sm-4">
                 <div class="form-group" id="daydiv">
                    <label class="control-label">Select Day</label>
                   <select class="form-control" id="ddlDay">

                   </select>
                </div>
</div>
                    </div>
                <div class="form-group">
                    <label class="control-label">Details</label>
                    <textarea class="day-text" id="detail" placeholder="Write your details here..." style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
                </div>
                <div class="form-group">
                    <label for="day-image">Upload Image</label>
                    <input type="file" id="day-image">
                    <p class="help-block">Only .png & .jpg is Supported</p>
                </div>
              <label style="color: orangered" name="tripMessage" id="tripMessage"></label>
                        <br />
                <button class="btn btn-primary nextBtn pull-left" id="btnSubmit" type="button">Submit</button>
                 <button class="btn btn-primary nextBtn pull-left" id="btnUpdate" type="button">Update</button>
               
            </div>
        <hr>
			<div class="row">
				<div class="col-sm-12">
					<table id="tblTripMaster" class="table table-bordered table-hover">
							
					</table>
				</div>
			</div>
        <div class="modal fade" id="deleteTrip" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal" aria-label="Close">
										  <span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">Delete Itenary</h4>
        </div>
        <div class="modal-body">
       Are You Sure you want to delete record for day  <span id="tripname"></span>
            
        </div>
        <div class="modal-footer">
             <button type="button" id="btnConfirm" class="btn btn-info" data-dismiss="modal">Confirm</button>
           
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
    </div>
       </div>

            </section>

     
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
        </script>
</asp:Content>

