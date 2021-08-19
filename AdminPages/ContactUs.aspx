<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPages/AdminMasterPage.master" AutoEventWireup="true" CodeFile="ContactUs.aspx.cs" Inherits="AdminPages_ContactUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script src="../JS/jquery-1.11.2.min.js"></script>
    <script src="../JS/bootstrap.min.js"></script>
   
    <link href="../Css/bootstrap.min.css" rel="stylesheet" />
<%--  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>
 
       <script src="../AdminContent/JS/select2.full.min.js"></script>
    <link href="../Css/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" />
    <script src="../AdminContent/JS/ContactUs.js"></script>
      <link rel="stylesheet" href="../css/AdminLTE.min.css">
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
							<div class="col-sm-12">
								<div class="form-group">
									<label class="control-label">Address</label>
									<textarea class="address-txt" id="address" runat="server" placeholder="Address" style="width: 100%; height: 100px; font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
								</div>
							</div>
						</div>
						<div class="row">	
							<div class="col-sm-6">
								<div class="form-group">
									<label for="ph1-name">Phone No. 1</label>
									<input class="form-control"  id="ph1" onkeyup="return isNumber();" maxlength="12" placeholder="Enter Phone No. 1">
								</div>
								<div class="form-group">
								  <div class="checkbox">
									<label>
									  <input type="checkbox" id="whatsapp1">
									  Mark as WhatsApp
									</label>
								  </div>
								</div>  
							</div>
							<div class="col-sm-6">
								<div class="form-group">
									<label for="ph2-name">Phone No. 2</label>
									<input  class="form-control" id="ph2" onkeyup="return isNumber();" maxlength="12" placeholder="Enter Phone No. 2">
								</div>
								<div class="form-group">
								  <div class="checkbox">
									<label>
									  <input type="checkbox" id="whatsapp2">
									  Mark as WhatsApp
									</label>
								  </div>
								</div>
							</div>
						</div>
						<hr>
						<div class="row">
							<div class="col-sm-3">
								<div class="form-group">
									<label for="email-id">Email</label>
									<input type="email" class="form-control" id="email-id" placeholder="Enter Email">
								</div>
							</div>
							<div class="col-sm-3">
								<div class="form-group">
									<label for="google-link">Google Map Link</label>
									<input type="text" class="form-control" id="google-link" placeholder="Enter Google Map Link">
								</div>
							</div>
							<div class="col-sm-3">
								<div class="form-group">
									<label for="facebook">Facebook Link</label>
									<input type="text" class="form-control" id="facebook" placeholder="Enter Facebook Link">
								</div>
							</div>
							<div class="col-sm-3">
								<div class="form-group">
									<label for="insta">Instagram Link</label>
									<input type="text" class="form-control" id="insta" placeholder="Enter Instagram Link">
								</div>
							</div>
						</div>
					</div>
					<div class="col-sm-12">
                            <label style="color: orangered" name="CntMessage" id="CntMessage"></label>
                                <br />
						<button type="submit" id="btnSave" class="btn btn-primary">Save Changes</button>
					</div>
				</form>
			</div>	
			<hr>
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
    $('.address-txt').wysihtml5()
  })
</script>
</asp:Content>

