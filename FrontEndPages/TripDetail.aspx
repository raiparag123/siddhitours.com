<%@ Page Title="" Language="C#" MasterPageFile="~/FrontEndPages/MasterPage.master" AutoEventWireup="true" CodeFile="TripDetail.aspx.cs" Inherits="FrontEndPages_TripDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
       <script src="../FrontEndContent/js/jquery.js"></script>
     <script src="../FrontEndContent/js/TripDetail.js"></script>
    <script src="../FrontEndContent/js/bootstrap.min.js"></script>
      <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>

    <script src="../js/moment.min.js"></script>
      <script src="../FrontEndContent/js/owl.carousel.min.js"></script>
    <link href="../FrontEndContent/css/main.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <section id="b2b-desc" class="b2b-desc">
        <div class="container b2b-desc-cont">
			<div class="row">
				<div class="col-sm-4">
					<ul class="breadcrumb">
					  <li><a href="../Default.aspx">Home</a></li>
					  <li><a href="Trip.aspx">Tours</a></li>
					  <li class="active">Tour Description</li>
					</ul>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-4">
					<h4 class="b2b-title" id="Title"></h4>
				</div>
				<div class="col-xs-12 col-sm-4">
					<h4 class="b2b-cost rupee-font" id="Cost"></h4>
				</div>
				<div class="col-xs-12 col-sm-4">
					<h5 class="location-details" id="Location"></h5>
				</div>
			</div>
        </div>
		
	<div class="container tour-desc-gallery ">
		<div class="row">
			<div class="col-sm-8">
				<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
				  <!-- Indicators -->
				  <ol class="carousel-indicators" id="indicators">
					<%--<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
					<li data-target="#carousel-example-generic" data-slide-to="1"></li>
					<li data-target="#carousel-example-generic" data-slide-to="2"></li>--%>
				  </ol>
				  <!-- Wrapper for slides -->
				  <div class="carousel-inner" id="tripImages">
					<%--<div class="item active">
					  <img src="http://placehold.it/800x400" alt="...">
					  
					</div>
					<div class="item">
					  <img src="http://placehold.it/800x400" alt="...">
					  <div class="carousel-caption">
						<h2>Heading</h2>
					  </div>
					</div>
					<div class="item">
					  <img src="http://placehold.it/800x400" alt="...">
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
			<div class="col-sm-4">
				<div class="tour-table">
					<table class="table table-curved table-hover tour-basic-details">
					  <tbody>
						<tr>
						  <td><span id="day"></span> Days - <span id="night"></span> Nights</td>
						</tr>
						<tr>
						  <td>Theme :<span id="theme"></span></td>
						</tr>
						<tr id="seatTd">
						  <td>Seats Available : <span id="seat"></span></td>
						</tr>
						<tr>
						  <td id="groupDate">FIT Date:<span id="date"></span></td>
						</tr>
						<tr>
						  <td>Tour Type:<span id="type"></span></td>
						</tr>
					  </tbody>	
					</table>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<h3 class="b2b-inc-exc">Overview</h3>
				<p class="b2b-main-data" id="overview">
								</p>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12">
				<h3 class="b2b-inc-exc">Inclusion</h3>
				<p class="b2b-main-data" id="Inclusion">
				
				</p>
			</div>
		</div>	
        	<div class="row">
			<div class="col-sm-12">
				<h3 class="b2b-inc-exc">Exclusion </h3>
				<p class="b2b-main-data" id="Exclusion">
				
				</p>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12">
				<h3 class="b2b-inc-exc" id="itenary">Itinerary</h3>
				<ul class="timeline" id="ItenaryList">
				<%--<li>
					<a href="#">Day 1 - Getting Ready for Dolphin Meet</a>
					<div class="itenary-box">
						<img src="img/d1.jpg" class="itenary-image">
						<p></p>
					</div>
				</li>
				<li>
					<a href="#">Day 2 - The Khalifa</a>
					<div class="itenary-box">
						<img src="img/d2.jpg" class="itenary-image">
						<p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat
					</div>
				</li>
				<li>
					<a href="#">Day 3</a>
					<div class="itenary-box">
						<img src="img/d3.jpg" class="itenary-image">
						<p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat
					</div>
				</li>--%>
			</ul>
			</div>
		</div>			
		<div class="row">	
			<div class="col-sm-12 similar-tour-desc">
				<h3 class="b2b-inc-exc">Similar Tour Suggestion</h3>
				<div class="owl-carousel owl-theme" id="OtherTour">
					<%--<div class="item">
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
					</div>--%>
				
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
       600:{
            items: 4
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

