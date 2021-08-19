<%@ Page Title="" Language="C#" MasterPageFile="~/FrontEndPages/MasterPage.master" AutoEventWireup="true" CodeFile="BusinessTour.aspx.cs" Inherits="FrontEndPages_BusinessTour" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    	
     
    <script src="../FrontEndContent/js/jquery.js"></script>
     <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>
    <script src="../FrontEndContent/js/bootstrap.min.js"></script>
   <script src="../FrontEndContent/js/owl.carousel.min.js"></script>
     
     <script src="../FrontEndContent/js/businessTour.js"></script>
    <link href="../FrontEndContent/css/main.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <section id="b2b-page" class="b2b-page">
           <div class="container b2b-header">
			<div class="row main-title">
                <div class="col-lg-12 text-center">
                    <h2>B2B Trips</h2>
					<h4>Plan your business trips with us at an affordable packages</h4>
				</div>
            </div>
               </div>
            <div id="Businesstour" class="container">
                
                      <div class="container b2b-desc-cont">
            <div class="row">
				<div class="col-sm-4">
					<ul class="breadcrumb">
					  <li><a href="../Default.aspx">Home</a></li>
					
					  <li class="active">Business Tour</li>
					</ul>
				</div>
			</div>
                </div>
		
		<div class="container">
			<div class="row filter-section">
                <div class="col-lg-12">
                    <form class="form-horizontal">
						<div class="form-group">
						  <div class="col-sm-3 text-center">
							<label for="select" class="control-label"><i class="fa fa-filter"></i> Filter</label>
						  </div>
						  <div class="col-sm-3">
							<select class="form-control" id="ddlcountry">
							  <option value=0 selected>Country</option>
							
							</select>
						  </div>
						  <div class="col-sm-3">
							<select class="form-control" id="ddlState">
                                <option value=0 selected>City</option>
							
							</select>
						  </div>
						  <%--<div class="col-sm-3">
							<select class="form-control" id="ddlCity">
                                <option value=0 selected>Place</option>
							<%--  <option selected>Place</option>
							  <option>India</option>
							  <option>USA</option>
							  <option>China</option>
							  <option>Japan</option>
							  <option>Europe</option>
							</select>
						  </div>--%>
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
        <div class="container b2b-body">
			<div class="sub-title" id="b2bData">
				<%--<div class="col-sm-4">
					<div class="panel panel-default">
						<div class="panel-body">
							<img src="img/d4.jpg" class="img-responsive">
							<!--<span class="label label-danger">₹ 150/hour</span>-->
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
								<div class="col-sm-12 detail-button">
									<a href="" class="btn btn-danger btn-sm" >View Details</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			
				
			
				
			</div>--%> 

			
        </div>
                </div>
<div id="no-tour" style="display:none">
    <h1 align="center">No Business Tour Found.</h1>
</div>
    </section>

</asp:Content>

