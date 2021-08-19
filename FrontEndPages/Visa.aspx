<%@ Page Title="" Language="C#" MasterPageFile="~/FrontEndPages/MasterPage.master" AutoEventWireup="true" CodeFile="Visa.aspx.cs" Inherits="FrontEndPages_Visa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    	<script src="../FrontEndContent/js/bootstrap.min.js"></script>
    <script src="../FrontEndContent/js/visa.js"></script>
      <script src="js/jquery.js"></script>

       <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- Trending Page -->
    <section id="visa-page" class="visa-page">
         <%--<div class="container b2b-desc-cont  b2b-desc">
            <div class="row">
				<div class="col-sm-4">
					<ul class="breadcrumb">
					  <li><a href="../Default.aspx">Home</a></li>
					
					  <li class="active">Visa</li>
					</ul>
				</div>
			</div>
               </div>--%>
        <div class="container">
			<div class="row main-title">
                <div class="col-lg-12 text-center">
                    <h2>Visa</h2>
					<h4>Each country typically has a multitude of categories of visas with various names. Don't worry we are here to help.</h4>
				</div>
            </div>
		</div>
		<div class="container">
			
            <div class=" b2b-desc-cont  b2b-desc">
            <div class="row">
				<div class="col-sm-4">
					<ul class="breadcrumb">
					  <li><a href="../Default.aspx">Home</a></li>
					
					  <li class="active">Visa</li>
					</ul>
				</div>
			</div>
               </div>
		</div>
		<div class="container">
			<div class="row filter-section">
                <div class="col-lg-12">
                    <form class="form-horizontal">
						<div class="form-group">
                              <div class="col-sm-6 col-md-4 text-center">
						  <label for="select" class="control-label"><i class="fa fa-filter"></i> Filter</label>
                                  </div>
						  <div class="col-sm-6 col-md-4">
							<select class="form-control" id="selectCountry">
							  <%--<option selected>Select Country</option>
							  <option>India</option>
							  <option>USA</option>
							  <option>China</option>
							  <option>Japan</option>
							  <option>Europe</option>--%>
							</select>
						  </div>
						</div>
					</form>
				</div>
            </div>
            <div class="row">
				<div class="col-sm-12 b2b-sort" hidden>
					<h4>Sort By: </h4>
					<h4><a href="#" id="popular">Popular</a></h4>
					<h4>Price: <a href="#" id="high">High</a> <a href="#" id="low">Low</a></h4>
					
				</div>
			</div>
		</div>
        <div class="container">
			<div class="sub-title" id="VisaData">
				<%--<div class="col-sm-3">
					<div class="panel panel-default">
						<div class="panel-body">
							<img src="../img/d1.jpg" class="img-responsive">
						</div>
						<div class="panel-heading text-center">
							<div class="row">
								<div class="col-sm-6 title-1">
									<h4>Europe</h4>
								</div>
								<div class="col-sm-6 title-price">
									<h4>₹ 12,000</h4>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-6 detail-button">
									<button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#myModal">View Details</button>
								</div>
								<div class="col-sm-6 contact-button">
									<button class="btn btn-success btn-sm" data-toggle="modal" data-target="#myModal1">Contact Us</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-3">
					<div class="panel panel-default">
						<div class="panel-body">
							<img src="../img/d2.jpg" class="img-responsive">
						</div>
						<div class="panel-heading text-center">
							<div class="row">
								<div class="col-sm-6 title-1">
									<h4>Europe</h4>
								</div>
								<div class="col-sm-6 title-price">
									<h4>₹ 12,000</h4>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-6 detail-button">
									<button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#myModal">View Details</button>
								</div>
								<div class="col-sm-6 contact-button">
									<button class="btn btn-success btn-sm" data-toggle="modal" data-target="#myModal1">Contact Us</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-3">
					<div class="panel panel-default">
						<div class="panel-body">
							<img src="../img/d3.jpg" class="img-responsive">
						</div>
						<div class="panel-heading text-center">
							<div class="row">
								<div class="col-sm-6 title-1">
									<h4>Europe</h4>
								</div>
								<div class="col-sm-6 title-price">
									<h4>₹ 12,000</h4>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-6 detail-button">
									<button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#myModal">View Details</button>
								</div>
								<div class="col-sm-6 contact-button">
									<button class="btn btn-success btn-sm" data-toggle="modal" data-target="#myModal1">Contact Us</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-3">
					<div class="panel panel-default">
						<div class="panel-body">
							<img src="../img/d4.jpg" class="img-responsive">
						</div>
						<div class="panel-heading text-center">
							<div class="row">
								<div class="col-sm-6 title-1">
									<h4>Europe</h4>
								</div>
								<div class="col-sm-6 title-price">
									<h4>₹ 12,000</h4>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-6 detail-button">
									<button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#myModal">View Details</button>
								</div>
								<div class="col-sm-6 contact-button">
									<button class="btn btn-success btn-sm" data-toggle="modal" data-target="#myModal1">Contact Us</button>
								</div>
							</div>
						</div>
					</div>
				</div>--%>
			</div>
			<%--<div class="row sub-title">
				<div class="col-sm-3">
					<div class="panel panel-default">
						<div class="panel-body">
							<img src="../img/d5.jpg" class="img-responsive">
						</div>
						<div class="panel-heading text-center">
							<div class="row">
								<div class="col-sm-6 title-1">
									<h4>Europe</h4>
								</div>
								<div class="col-sm-6 title-price">
									<h4>₹ 12,000</h4>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-6 detail-button">
									<button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#myModal">View Details</button>
								</div>
								<div class="col-sm-6 contact-button">
									<button class="btn btn-success btn-sm" data-toggle="modal" data-target="#myModal1">Contact Us</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-3">
					<div class="panel panel-default">
						<div class="panel-body">
							<img src="../img/d6.jpg" class="img-responsive">
						</div>
						<div class="panel-heading text-center">
							<div class="row">
								<div class="col-sm-6 title-1">
									<h4>Europe</h4>
								</div>
								<div class="col-sm-6 title-price">
									<h4>₹ 12,000</h4>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-6 detail-button">
									<button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#myModal">View Details</button>
								</div>
								<div class="col-sm-6 contact-button">
									<button class="btn btn-success btn-sm" data-toggle="modal" data-target="#myModal1">Contact Us</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-3">
					<div class="panel panel-default">
						<div class="panel-body">
							<img src="../img/d7.jpg" class="img-responsive">
						</div>
						<div class="panel-heading text-center">
							<div class="row">
								<div class="col-sm-6 title-1">
									<h4>Europe</h4>
								</div>
								<div class="col-sm-6 title-price">
									<h4>₹ 12,000</h4>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-6 detail-button">
									<button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#myModal">View Details</button>
								</div>
								<div class="col-sm-6 contact-button">
									<button class="btn btn-success btn-sm" data-toggle="modal" data-target="#myModal1">Contact Us</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-3">
					<div class="panel panel-default">
						<div class="panel-body">
							<img src="../img/d8.jpg" class="img-responsive">
						</div>
						<div class="panel-heading text-center">
							<div class="row">
								<div class="col-sm-6 title-1">
									<h4>Europe</h4>
								</div>
								<div class="col-sm-6 title-price">
									<h4>₹ 12,000</h4>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-6 detail-button">
									<button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#myModal">View Details</button>
								</div>
								<div class="col-sm-6 contact-button">
									<button class="btn btn-success btn-sm" data-toggle="modal" data-target="#myModal1">Contact Us</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>--%>
        </div>
    </section>
    	<div class="modal fade" id="desc"  role="dialog" >

             <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="visaname"></h4>
                </div>
                <div class="modal-body">
			<h5>Documents Required:</h5>
                    <div id="docreq"></div>
			<%--<ul>
			<li>Passport</li>
			<li>Bank Details</li>
			<li>3 Lacs Minimum Retention in Bank</li>
			</ul>--%>
		  </div>
                <div class="modal-footer">
                    <%--<button type="button" id="btnConfirmCountry" class="btn btn-info" data-dismiss="modal">Confirm</button>--%>

                    <button type="button" class="btn btn-success" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>

	</div>
    	<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<%--<h4 class="modal-title" id="myModalLabel"></h4>--%>
		  </div>
		  <div class="modal-body">
			<form class="form-horizontal" id="form">
                <div id="div-email">
			  <fieldset>
				<div class="form-group">
				  <label for="select" class="col-lg-2 control-label">Selects</label>
				  <div class="col-lg-10">
					<select class="form-control" id="selectVisa" required>
					  <%--<option>Europe Visa</option>
					  <option>Indian Visa</option>
					  <option>US Visa</option>
					  <option>Bangkok Visa</option>--%>
					</select>
				  </div>
				</div>
				<div class="form-group">
				  <label for="inputEmail" class="col-lg-2 control-label">Email</label>
				  <div class="col-lg-10">
					<input type="email" class="form-control" id="inputEmail"  name="cpemail"  placeholder="Email:" required="true">
				  </div>
				</div>
				<div class="form-group">
				  <label for="phoneno" class="col-lg-2 control-label">Number</label>
				  <div class="col-lg-10">
					<input type="text" maxlength="10" class="form-control" id="phoneno" onkeypress="return isNumber(event)"  placeholder="Phone No.">
				  </div>
				</div>
				<div class="form-group">
				  <div class="col-lg-10 col-lg-offset-2">
					<button type="reset" class="btn btn-success" data-dismiss="modal">Cancel</button>
					<button type="submit" id="btnSubmit" class="btn btn-danger">Submit</button>
				  </div>
				</div>
			  </fieldset>
                    </div>
                <div id="success">
                    Thank you for contacting Us.<br />
                    One of our member will soon get in touch with you.<br />
                    <button type="reset" class="btn btn-success" data-dismiss="modal">Close</button>
                </div>
			</form>  
		  </div>
		</div>
	  </div>
	</div>

</asp:Content>

