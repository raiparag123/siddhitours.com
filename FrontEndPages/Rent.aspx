<%@ Page Title="" Language="C#" MasterPageFile="~/FrontEndPages/MasterPage.master" AutoEventWireup="true" CodeFile="Rent.aspx.cs" Inherits="FrontEndPages_Rent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <section id="car-page" class="car-page">
          <div class="container">
			<div class="row main-title">
                <div class="col-lg-12 text-center">
                    <h2>Rent - A - Car</h2>
					<h4>Hire a car at affordable prices.</h4>
				</div>
            </div>
		</div>
		<div class="container">
            <div class="row">
				<div class="col-sm-4">
					<ul class="breadcrumb">
					  <li><a href="../Default.aspx">Home</a></li>
					
					  <li class="active">Rent</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="container">
			<div class="row filter-section">
                <div class="col-lg-12">
                    <form class="form-horizontal">
						<div class="form-group text-left">
                            <div class="col-sm-4 text-center">
						  <label for="select" class="control-label"><i class="fa fa-filter"></i> Filter</label>
                                </div>
						  <div class="col-sm-4">
							<select class="form-control" id="selectCountry">
							  <%--<option selected>Select Location</option>
							  <option>India</option>
							  <option>USA</option>
							  <option>China</option>
							  <option>Japan</option>
							  <option>Europe</option>--%>
							</select>
						  </div>
						  <div class="col-sm-4 pull-right">
							<select class="form-control" id="selectVehicle">
							 <%-- <option selected>Select Vehicle Type</option>
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
				<div class="col-sm-12 b2b-sort">
					<h4>Sort By: </h4>
					<h4><a href="#" id="popular">Popular</a></h4>
					<h4>Price: <a href="#" id="high">High</a> <a href="#" id="low">Low</a></h4>
					
				</div>
			</div>
		</div>
        <div class="container">
			<div class="row sub-title" id="Rent">
				<%--<div class="col-sm-4">
					<div class="panel panel-default">
						<div class="panel-body">
							<img src="img/c1.png" class="img-responsive">
							<span class="label label-danger">₹ 150/hour</span>
						</div>
						<div class="panel-heading text-center">
							<div class="row">
								<div class="col-sm-6 title-1">
									<h4>Toyota Indigo</h4>
								</div>
								<div class="col-sm-6 title-price">
									<h4>₹ 2500 / 100kms</h4>
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
				<div class="col-sm-4">
					<div class="panel panel-default">
						<div class="panel-body">
							<img src="img/c2.jpg" class="img-responsive">
							<span class="label label-danger">₹ 150/hour</span>
						</div>
						<div class="panel-heading text-center">
							<div class="row">
								<div class="col-sm-6 title-1">
									<h4>Toyota Indigo</h4>
								</div>
								<div class="col-sm-6 title-price">
									<h4>₹ 2500 / 100kms</h4>
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
				<div class="col-sm-4">
					<div class="panel panel-default">
						<div class="panel-body">
							<img src="img/c3.jpg" class="img-responsive">
							<span class="label label-danger">₹ 150/hour</span>
						</div>
						<div class="panel-heading text-center">
							<div class="row">
								<div class="col-sm-6 title-1">
									<h4>Toyota Indigo</h4>
								</div>
								<div class="col-sm-6 title-price">
									<h4>₹ 2500 / 100kms</h4>
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
			<div class="row sub-title">
				<%--<div class="col-sm-4">
					<div class="panel panel-default">
						<div class="panel-body">
							<img src="img/c1.png" class="img-responsive">
							<span class="label label-danger">₹ 150/hour</span>
						</div>
						<div class="panel-heading text-center">
							<div class="row">
								<div class="col-sm-6 title-1">
									<h4>Toyota Indigo</h4>
								</div>
								<div class="col-sm-6 title-price">
									<h4>₹ 2500 / 100kms</h4>
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
				<div class="col-sm-4">
					<div class="panel panel-default">
						<div class="panel-body">
							<img src="img/c2.jpg" class="img-responsive">
							<span class="label label-danger">₹ 150/hour</span>
						</div>
						<div class="panel-heading text-center">
							<div class="row">
								<div class="col-sm-6 title-1">
									<h4>Toyota Indigo</h4>
								</div>
								<div class="col-sm-6 title-price">
									<h4>₹ 2500 / 100kms</h4>
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
				<div class="col-sm-4">
					<div class="panel panel-default">
						<div class="panel-body">
							<img src="img/c3.jpg" class="img-responsive">
							<span class="label label-danger">₹ 150/hour</span>
						</div>
						<div class="panel-heading text-center">
							<div class="row">
								<div class="col-sm-6 title-1">
									<h4>Toyota Indigo</h4>
								</div>
								<div class="col-sm-6 title-price">
									<h4>₹ 2500 / 100kms</h4>
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
        </div>
    </section>
	<!-- MODAL here-->
	<div class="modal fade" id="desc" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title" id="myModalLabel"></h4>
		  </div>
		  <div class="modal-body">
			<h5> Description:</h5>
			<div id="description"></div>
              <h5> Terms and Condition:</h5>
              <div id="Term"></div>

		  </div>
		</div>
	  </div>
	</div>
	<!--CONTACT MODAL-->
	<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title" id="myModalLabel">Europe Visa</h4>
		  </div>
		  <div class="modal-body">
			<form class="form-horizontal">
                <div id="div-email">
			  <fieldset>
				<div class="form-group">
				  <label for="select" class="col-lg-2 control-label">Selects</label>
				  <div class="col-lg-10">
					<select class="form-control" id="vehicle">
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
					<input type="text" class="form-control" id="inputEmail" placeholder="Email">
				  </div>
				</div>
				<div class="form-group">
				  <label for="phoneno" class="col-lg-2 control-label">Mobile No</label>
				  <div class="col-lg-10">
					<input type="text" class="form-control" id="phoneno" maxlength="10" onkeypress="return isNumber(event)" placeholder="Phone No.">
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
    	<script src="../FrontEndContent/js/bootstrap.min.js"></script>
      <script src="../FrontEndContent/js/Rent.js"></script>
      <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>

</asp:Content>

