<%@ Page Title="" Language="C#" MasterPageFile="~/FrontEndPages/MasterPage.master" AutoEventWireup="true" CodeFile="BusinessTourDetail.aspx.cs" Inherits="FrontEndPages_BusinessTourDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
         <script src="../FrontEndContent/js/jquery.js"></script>
     <script src="../FrontEndContent/js/businessDetail.js"></script>
     <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>
    <script src="../FrontEndContent/js/bootstrap.min.js"></script>
      <script src="../FrontEndContent/js/owl.carousel.min.js"></script>
    <link href="../FrontEndContent/css/main.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <section id="b2b-desc" class="b2b-desc">
        <div class="container b2b-desc-cont">
            <div class="row">
				<div class="col-sm-4">
					<ul class="breadcrumb">
					  <li><a href="../default.aspx">Home</a></li>
					  <li><a href="BusinessTour.aspx">BusinessTour</a></li>
					  <li class="active">Tour Description</li>
					</ul>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-6 col-md-9 text-center">
					<h3 class="b2b-title" id="title"></h3>
                    </div>
				<div class="col-xs-6 col-md-3 text-right">
					<h3 class="b2b-cost rupee-font" id="cost"></h3>
				</div>
				<%--<div class="col-sm-2">
					<button class="btn btn-success btn-lg" data-toggle="modal" data-target="#myModal1">Contact Us</button>
				</div>--%>
			</div>
        </div>
		
	<div class="container b2b-gallery">
		<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
		  <!-- Indicators -->
		  <ol class="carousel-indicators" id="indicators">
			<%--<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
			<li data-target="#carousel-example-generic" data-slide-to="1"></li>
			<li data-target="#carousel-example-generic" data-slide-to="2"></li>--%>
		  </ol>

		  <!-- Wrapper for slides -->
		  <div class="carousel-inner" id="businessImages">
			<%--<div class="item active">
			  <img src="" alt="...">
			  <div class="carousel-caption">
				<h2>Heading</h2>
			  </div>
			</div>
			<div class="item">
			  <img src="" alt="...">
			  <div class="carousel-caption">
				<h2>Heading</h2>
			  </div>
			</div>
			<div class="item">
			  <img src="" alt="...">
			  <div class="carousel-caption">
				<h2>Heading</h2>
			  </div>
			</div>--%>
		  </div>

		  <!-- Controls -->
		  <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
			<span class="glyphicon glyphicon-chevron-left"></span>
		  </a>
		  <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
			<span class="glyphicon glyphicon-chevron-right"></span>
		  </a>
		</div>
	</div>
	<div class="container b2b-desc-data">
		<div class="row">
			<div class="col-sm-8 text- inclu-exclu">
			<div class="panel panel-default">
			<div class="panel-body">
				<h3 class="b2b-inc-exc">Inclusion / Exclusion</h3>
				<p class="b2b-main-data" id="Detail">
				
				</p>
			</div>
			</div>
			</div>
			<div class="col-sm-4">
				<h3 class="b2b-inc-exc">Explore Similar B2B</h3>
				<div class="owl-carousel owl-theme" id="otherTour">
					<div class="item">
						<div class="panel panel-default">
							<div class="panel-body">
								<img src="img/d6.jpg" class="img-responsive">
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
					<div class="item">
						<div class="panel panel-default">
							<div class="panel-body">
								<img src="img/d6.jpg" class="img-responsive">
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
					<div class="item">
						<div class="panel panel-default">
							<div class="panel-body">
								<img src="img/d6.jpg" class="img-responsive">
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
					<div class="item">
						<div class="panel panel-default">
							<div class="panel-body">
								<img src="img/d6.jpg" class="img-responsive">
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
				</div>
			</div>
		</div>
	</div>
    </section>
    <script>
       
            $('.carousel').carousel({
                interval: 4000 //changes the speed
    })
	var owl = $('.owl-carousel');

	owl.owlCarousel({
    center: true,
    loop:true,
    margin:10,
    responsive:{
                0:{
                items: 1
        }
    }
	});
	$('.next').click(function() {
                owl.trigger('next.owl.carousel');
            })
	$('.prev').click(function() {
                owl.trigger('prev.owl.carousel');
	})
	
    </script>
</asp:Content>

