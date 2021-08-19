<%@ Page Title="" Language="C#" MasterPageFile="~/FrontEndPages/MasterPage.master" AutoEventWireup="true" CodeFile="Trending.aspx.cs" Inherits="FrontEndPages_Trending" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- Trending Page -->
    <section id="trending-page" class="trending-page">
		<div class="container">
			<div class="row main-title">
                <div class="col-lg-12 text-center">
                    <h2>Trending Tours</h2>
					<h4>Browse through the current travelling trends. We made it easy for you by categorizing the best.</h4>
				</div>
            </div>
		</div>
		<div class="container b2b-desc-cont  b2b-desc">
            <div class="row">
				<div class="col-xs-12 text-center">
					<ul class="breadcrumb">
					  <li><a href="../Default.aspx">Home</a></li>
					
					  <li class="active">Trending</li>
					</ul>
				</div>
			</div>
        </div>
        <div class="container">
            <div id="Trend-deal">
			<div class="row" id="trend1-div">
				<!--<div class="col-sm-12 text-center">
						<div class="customNavigation">
							<span class="pager-left"><a class="btn btn-link prev"><span class="glyphicon glyphicon-chevron-left"></span></a></span>
							<span class="pager-right"><a class="btn btn-link next"><span class="glyphicon glyphicon-chevron-right"></span></a></span>
						</div>
				</div>-->
				<div class="col-sm-12">
					<h3 class="trend-title" id="trending1-title"><h3>
				</div>
				<div class="col-sm-12">
					<div class="owl-carousel owl-theme" id="trending1">
						<%--<div class="item">
							<div class="panel panel-default">
								<a href="#">
									<div class="panel-body">
										<img src="../../img/d1.jpg" class="img-responsive">
										<span class="label label-danger">4 Nights / 5 Days</span>
									</div>
									<div class="panel-heading text-center">
										<div class="row">
											<div class="col-sm-6 title-1">
												<h4>Incredible India</h4>
											</div>
											<div class="col-sm-6 title-price">
												<h4>₹ 14,000</h4>
											</div>
										</div>
									</div>
								</a>
							</div>
						</div>
						<div class="item">
							<div class="panel panel-default">
								<a href="#">
									<div class="panel-body">
										<img src="../../img/d2.jpg" class="img-responsive">
										<span class="label label-danger">4 Nights / 5 Days</span>
									</div>
									<div class="panel-heading text-center">
										<div class="row">
											<div class="col-sm-6 title-1">
												<h4>Incredible India</h4>
											</div>
											<div class="col-sm-6 title-price">
												<h4>₹ 14,000</h4>
											</div>
										</div>
									</div>
								</a>
							</div>
						</div>
						<div class="item">
							<div class="panel panel-default">
								<a href="#">
									<div class="panel-body">
										<img src="../../img/d3.jpg" class="img-responsive">
										<span class="label label-danger">4 Nights / 5 Days</span>
									</div>
									<div class="panel-heading text-center">
										<div class="row">
											<div class="col-sm-6 title-1">
												<h4>Incredible India</h4>
											</div>
											<div class="col-sm-6 title-price">
												<h4>₹ 14,000</h4>
											</div>
										</div>
									</div>
								</a>
							</div>
						</div>
						<div class="item">
							<div class="panel panel-default">
								<a href="#">
									<div class="panel-body">
										<img src="../../img/d4.jpg" class="img-responsive">
										<span class="label label-danger">4 Nights / 5 Days</span>
									</div>
									<div class="panel-heading text-center">
										<div class="row">
											<div class="col-sm-6 title-1">
												<h4>Incredible India</h4>
											</div>
											<div class="col-sm-6 title-price">
												<h4>₹ 14,000</h4>
											</div>
										</div>
									</div>
								</a>
							</div>
						</div>
						<div class="item">
							<div class="panel panel-default">
								<a href="#">
									<div class="panel-body">
										<img src="../../img/d5.jpg" class="img-responsive">
										<span class="label label-danger">4 Nights / 5 Days</span>
									</div>
									<div class="panel-heading text-center">
										<div class="row">
											<div class="col-sm-6 title-1">
												<h4>Incredible India</h4>
											</div>
											<div class="col-sm-6 title-price">
												<h4>₹ 14,000</h4>
											</div>
										</div>
									</div>
								</a>
							</div>
						</div>
						<div class="item">
							<div class="panel panel-default">
								<a href="#">
									<div class="panel-body">
										<img src="../../img/d6.jpg" class="img-responsive">
										<span class="label label-danger">4 Nights / 5 Days</span>
									</div>
									<div class="panel-heading text-center">
										<div class="row">
											<div class="col-sm-6 title-1">
												<h4>Incredible India</h4>
											</div>
											<div class="col-sm-6 title-price">
												<h4>₹ 14,000</h4>
											</div>
										</div>
									</div>
								</a>
							</div>
						</div>--%>
					</div>
				</div>
			</div>
			<div class="row" id="trend2-div">
				
				<div class="col-sm-12">
					<h3 class="trend-title" id="trending2-title"><h3>
				</div>
				<div class="col-sm-12">
					<div class="owl-carousel owl-theme" id="trending2">
						
					</div>
				</div>
			</div>


            <div class="row" id="trend3-div">
				<!--<div class="col-sm-12 text-center">
						<div class="customNavigation">
							<span class="pager-left"><a class="btn btn-link prev"><span class="glyphicon glyphicon-chevron-left"></span></a></span>
							<span class="pager-right"><a class="btn btn-link next"><span class="glyphicon glyphicon-chevron-right"></span></a></span>
						</div>
				</div>-->
				<div class="col-sm-12">
					<h3 class="trend-title" id="trending3-title"><h3>
				</div>
				<div class="col-sm-12">
					<div class="owl-carousel owl-theme" id="trending3">
						
					</div>
				</div>
			</div>


            <div class="row" id="trend4-div">
				<!--<div class="col-sm-12 text-center">
						<div class="customNavigation">
							<span class="pager-left"><a class="btn btn-link prev"><span class="glyphicon glyphicon-chevron-left"></span></a></span>
							<span class="pager-right"><a class="btn btn-link next"><span class="glyphicon glyphicon-chevron-right"></span></a></span>
						</div>
				</div>-->
				<div class="col-sm-12">
					<h3 class="trend-title" id="trending4-title"><h3>
				</div>
				<div class="col-sm-12">
					<div class="owl-carousel owl-theme" id="trending4">
						<%--<div class="item">
							<div class="panel panel-default">
								<a href="#">
									<div class="panel-body">
										<img src="../../img/d1.jpg" class="img-responsive">
										<span class="label label-danger">4 Nights / 5 Days</span>
									</div>
									<div class="panel-heading text-center">
										<div class="row">
											<div class="col-sm-6 title-1">
												<h4>Incredible India</h4>
											</div>
											<div class="col-sm-6 title-price">
												<h4>₹ 14,000</h4>
											</div>
										</div>
									</div>
								</a>
							</div>
						</div>
						<div class="item">
							<div class="panel panel-default">
								<a href="#">
									<div class="panel-body">
										<img src="../img/d2.jpg" class="img-responsive">
										<span class="label label-danger">4 Nights / 5 Days</span>
									</div>
									<div class="panel-heading text-center">
										<div class="row">
											<div class="col-sm-6 title-1">
												<h4>Incredible India</h4>
											</div>
											<div class="col-sm-6 title-price">
												<h4>₹ 14,000</h4>
											</div>
										</div>
									</div>
								</a>
							</div>
						</div>
						<div class="item">
							<div class="panel panel-default">
								<a href="#">
									<div class="panel-body">
										<img src="../img/d3.jpg" class="img-responsive">
										<span class="label label-danger">4 Nights / 5 Days</span>
									</div>
									<div class="panel-heading text-center">
										<div class="row">
											<div class="col-sm-6 title-1">
												<h4>Incredible India</h4>
											</div>
											<div class="col-sm-6 title-price">
												<h4>₹ 14,000</h4>
											</div>
										</div>
									</div>
								</a>
							</div>
						</div>
						<div class="item">
							<div class="panel panel-default">
								<a href="#">
									<div class="panel-body">
										<img src="../img/d4.jpg" class="img-responsive">
										<span class="label label-danger">4 Nights / 5 Days</span>
									</div>
									<div class="panel-heading text-center">
										<div class="row">
											<div class="col-sm-6 title-1">
												<h4>Incredible India</h4>
											</div>
											<div class="col-sm-6 title-price">
												<h4>₹ 14,000</h4>
											</div>
										</div>
									</div>
								</a>
							</div>
						</div>
						<div class="item">
							<div class="panel panel-default">
								<a href="#">
									<div class="panel-body">
										<img src="../img/d5.jpg" class="img-responsive">
										<span class="label label-danger">4 Nights / 5 Days</span>
									</div>
									<div class="panel-heading text-center">
										<div class="row">
											<div class="col-sm-6 title-1">
												<h4>Incredible India</h4>
											</div>
											<div class="col-sm-6 title-price">
												<h4>₹ 14,000</h4>
											</div>
										</div>
									</div>
								</a>
							</div>
						</div>
						<div class="item">
							<div class="panel panel-default">
								<a href="#">
									<div class="panel-body">
										<img src="../../img/d6.jpg" class="img-responsive">
										<span class="label label-danger">4 Nights / 5 Days</span>
									</div>
									<div class="panel-heading text-center">
										<div class="row">
											<div class="col-sm-6 title-1">
												<h4>Incredible India</h4>
											</div>
											<div class="col-sm-6 title-price">
												<h4>₹ 14,000</h4>
											</div>
										</div>
									</div>
								</a>
							</div>
						</div>--%>
					</div>
				</div>
			</div>
            </div>
        <div id="no-trending" style="display:none">
           <h1 align="center">No Trip Found</h1>
            </div>
        </div>
        
    </section>
    <script src="../FrontEndContent/js/jquery.js"></script>
    <script src="../FrontEndContent/js/owl.carousel.min.js"></script>
	<script src="../FrontEndContent/js/bootstrap.min.js"></script>
        <script src="../FrontEndContent/js/Trending.js"></script>
      <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>

     <script>
        $('.carousel').carousel({
            interval: 4000 //changes the speed
        })
        var owl = $('.owl-carousel');

        owl.owlCarousel({
            center: true,
            loop: false,
            margin: 10,
            responsive: {
                600: {
                    items: 5
                }
            }
        });
        $('.next').click(function () {
            owl.trigger('next.owl.carousel');
        })
        $('.prev').click(function () {
            owl.trigger('prev.owl.carousel');
        })

    
        
    </script>
</asp:Content>

