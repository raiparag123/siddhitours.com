<%@ Page Title="" Language="C#" MasterPageFile="~/FrontEndPages/MasterPage.master" AutoEventWireup="true" CodeFile="Trip.aspx.cs" Inherits="FrontEndPages_Trip" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
         <script src="../FrontEndContent/js/jquery.js"></script>
    <script src="../FrontEndContent/js/bootstrap.min.js"></script>
     <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>
     <script src="../FrontEndContent/js/triplist.js"></script>
    <link href="../FrontEndContent/css/main.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <section id="tour-list-page" class="tour-list-page">
         
		<div class="container">
			<div class="row main-title">
                <div class="col-lg-12 text-center">
                    <h2>Tour Packages</h2>
					<h4>A fully packed tour packages to suit all your needs</h4>
				</div>
            </div>
		</div>	
            <div class="container">
				<div class="row">
				<div class="col-sm-4">
					<ul class="breadcrumb">
					  <li><a href="../Default.aspx">Home</a></li>
					
					  <li class="active">Tours</li>
					</ul>
				</div>
				</div>
            </div>
		</div>
          <div id="tripfound">
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
							  <option value="0" selected>Country</option>
							 <%-- <option>India</option>
							  <option>USA</option>
							  <option>China</option>
							  <option>Japan</option>
							  <option>Europe</option>--%>
							</select>
						  </div>
						  <div class="col-sm-3">
							<select class="form-control" id="ddlCity">
							  <option value="0" selected>City</option>
							 <%-- <option>India</option>
							  <option>USA</option>
							  <option>China</option>
							  <option>Japan</option>
							  <option>Europe</option>--%>
							</select>
						  </div>
						  <%--<div class="col-sm-3">
							<select class="form-control" id="select">
							  <option selected>Place</option>
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
				<div class="col-sm-12 tour-packages-sort">
					<h4>Sort By: </h4>
					<h4><a href="#" id="popular">Popular</a></h4>
					<h4>Price: <a href="#" id="high">High</a> <a href="#" id="low">Low</a></h4>
					
				</div>
			</div>
		</div>
		
        <div class="container tour-main-list">
			<div id="tripList">
				<%--<div class="col-sm-12 tour-packages">
					<div class="panel panel-default">
					  <div class="panel-body">
						<div class="row">
							<div class="col-sm-3 mid-sec">
								<img src="img/d1.jpg" class="img-responsive">
							</div>
							<div class="col-sm-6 mid-sec">
								<h4></h4>
								<span class="duration-info"></span>
								<h4>
									<a href="#" class="btn btn-primary btn-xs"></a>
									<a href="#" class="btn btn-primary btn-xs"></a>
									<a href="#" class="btn btn-primary btn-xs"></a>
								</h4>
								<h4><a href="#" class="btn btn-defaut btn-sm">India <i class="fa fa-arrow-right"></i> Maharashtra <i class="fa fa-arrow-right"></i> Mumbai</a></h4>
							</div>
							<div class="col-sm-3 text-center last-sec">
								
								<h4 class="tour-main-price">₹ 25000</h4>
								<a href="#" class="btn btn-danger"> View Details</a>
							</div>
						</div>
					  </div>
					</div>
				</div>--%>
				</div>
          
        </div>
              </div>
            <div id="no-trip">
				<h1 align="center">No Trip Found</h1>
			</div>
    </section>
</asp:Content>

