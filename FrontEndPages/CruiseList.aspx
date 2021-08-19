<%@ Page Title="" Language="C#" MasterPageFile="~/FrontEndPages/MasterPage.master" AutoEventWireup="true" CodeFile="CruiseList.aspx.cs" Inherits="FrontEndPages_CruiseList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
         <script src="../FrontEndContent/js/jquery.js"></script>
    <script src="../FrontEndContent/js/CruiseList.js"></script>
       <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>
    	<script src="../FrontEndContent/js/bootstrap.min.js"></script>
    <script src="../FrontEndContent/js/owl.carousel.min.js"></script>
    <script src="../JS/moment.min.js"></script>
    <link rel="stylesheet" href="../FrontEndContent/css/slick.css">
	<link rel="stylesheet" href="../FrontEndContent/css/slick-theme.css">
    <link href="../FrontEndContent/css/main.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <section id="cruise-page" class="cruise-page">
         
		<div class="container cruise-clients">
			<div class="row main-title">
				<div class="col-xs-10 col-xs-offset-1">
                <div class="owl-carousel owl-theme" id="Company">
						
				</div>
				</div>
            </div>
		</div>
		<div class="container cruise-header">
			<div class="row main-title">
                <div class="col-lg-12 text-center">
                    <h2>Top Cruise Deals</h2>
					<h4></h4>
				</div>
            </div>
		</div>
		<div class="container b2b-desc-cont  b2b-desc">
            <div class="row">
				<div class="col-sm-4">
					<ul class="breadcrumb">
					  <li><a href="../Default.aspx">Home</a></li>
					
					  <li class="active">Cruise</li>
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
						  <div class="col-sm-9">
							<select class="form-control" id="ddlcountry">
							  <option value="0" selected>Location</option>
							 
							</select>
						  </div>
						</div>
					</form>
				</div>
            </div>
			<div class="row">
				<div class="col-sm-12 cruise-sort">
					<h4>Sort By: </h4>
					<h4><a href="#" id="popular">Popular</a></h4>
					<h4>Price: <a href="#" id="high">High</a> <a href="#" id="low">Low</a></h4>
					<%--<h4>Duration: <a href="#">High</a> <a href="#">Low</a></h4>--%>
				</div>
			</div>
		</div>
		
        <div class="container cruise-body">
			<div class="sub-title" id="cruiseList">
				<%--<div class="col-sm-4">
					<div class="panel panel-default">
						<div class="panel-body">
							<img src="img/d4.jpg" class="img-responsive">
							<span class="label label-danger">Location, Location</span>
						</div>
						<div class="panel-heading">
							<div class="row">
								<div class="col-sm-9 title-1">
									<h5><span class="days-cruise">7 days</span> on Title Here...</h5>
								</div>
								<div class="col-sm-3 title-1">
									<img src="img/bgrenergy.jpg" class="img-responsive client-name-box">
								</div>
								
							</div>	
							<hr>
							<div class="row">
								<div class="col-sm-6 title-price">
									<h5>₹ 2500 (per person)</h5>
								</div>
								<div class="col-sm-6 detail-button text-center">
									<a href="" class="btn btn-danger btn-sm" >View Details</a>
								</div>
							</div>
						</div>
					</div>
				</div>--%>
				<%--<div class="col-sm-4">
					<div class="panel panel-default">
						<div class="panel-body">
							<img src="img/d4.jpg" class="img-responsive">
							<span class="label label-danger">Location, Location</span>
						</div>
						<div class="panel-heading">
							<div class="row">
								<div class="col-sm-9 title-1">
									<h5><span class="days-cruise">7 days</span> on Title Here...</h5>
								</div>
								<div class="col-sm-3 title-1">
									<img src="img/bgrenergy.jpg" class="img-responsive client-name-box">
								</div>
								
							</div>	
							<hr>
							<div class="row">
								<div class="col-sm-6 title-price">
									<h5>₹ 2500 (per person)</h5>
								</div>
								<div class="col-sm-6 detail-button text-center">
									<a href="" class="btn btn-danger btn-sm" >View Details</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-4">
					<div class="panel panel-default">
						<div class="panel-body">
							<img src="img/d4.jpg" class="img-responsive">
							<span class="label label-danger">Location, Location</span>
						</div>
						<div class="panel-heading">
							<div class="row">
								<div class="col-sm-9 title-1">
									<h5><span class="days-cruise">7 days</span> on Title Here...</h5>
								</div>
								<div class="col-sm-3 title-1">
									<img src="img/bgrenergy.jpg" class="img-responsive client-name-box">
								</div>
								
							</div>	
							<hr>
							<div class="row">
								<div class="col-sm-6 title-price">
									<h5>₹ 2500 (per person)</h5>
								</div>
								<div class="col-sm-6 detail-button text-center">
									<a href="" class="btn btn-danger btn-sm" >View Details</a>
								</div>
							</div>
						</div>
					</div>
				</div>--%>
			</div>
        </div>
    </section>
    <script src="../FrontEndContent/js/slick.min.js"></script>
    <script>
       
            $('.carousel').carousel({
                interval: 4000 //changes the speed
    })
	var owl = $('.owl-carousel');

	owl.owlCarousel({
                center: true,
    loop:true,
    margin:10,
	autoplay:true,
	autoplayTimeout:1000,
	autoplayHoverPause:true,
	dots: false,
    responsive:{
                0:{
                items:2,
            nav:true
        },
        600:{
                items:3,
            nav:false
        },
        1000:{
                items:6,
            nav:false
        }
    }
	});
    </script>
</asp:Content>