<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Siddhi Tours</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
	<link href="../FrontEndContent/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
<link href="../FrontEndContent/css/owl.carousel.min.css" rel="stylesheet" />
	<link href="../FrontEndContent/css/owl.theme.default.min.css" rel="stylesheet" />

    <link href="../FrontEndContent/css/bootstrap.min.css" rel="stylesheet" />
   	<link href="../FrontEndContent/css/main.css" rel="stylesheet" />

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
     
    <link rel="Stylesheet" href="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.10/themes/redmond/jquery-ui.css" /> 
</head>

<body>

    <!-- Navigation -->
    <nav class="navbar navbar-default navbar-fixed-top" id="nav" role="navigation" data-spy="affix" data-offset-top="400">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="default.aspx"><img src="../img/logo.png" class="main-logo"></a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
					<li><a href="default.aspx">Home</a></li>
					<li class="dropdown" id="category" runat="server">
					 <%-- <a href="../frontendpages/trip.aspx" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Tours <span class="caret"></span></a>
					  <ul class="dropdown-menu" >
						
					  </ul>--%>
					</li>
					<li class="dropdown">
					  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Services <span class="caret"></span></a>
					  <ul class="dropdown-menu">
						<li><a href="../frontendpages/BusinessTour.aspx">Business Tours</a></li>
						<li><a href="../frontendpages/visa.aspx">Visa</a></li>
						<li><a href="../frontendpages/rent.aspx">Rent-a-car</a></li>
                         
					  </ul>
					</li>
                     <li><a href="../frontendpages/CruiseList.aspx">Cruise</a></li>
					<li><a href="../frontendpages/AboutUs.aspx">About Us</a></li>
					<li><a href="../frontendpages/ContactUs.aspx">Contact Us</a></li>




				</ul>
                <form class="navbar-form navbar-left hidden-xs hidden-lg hidden-sm">
        <div class="form-group">
        <input type="search"  class="form-control search-Loc" placeholder="Search Tour" id="search" />
        </div>
        <button type="submit" value="Search" id="btnsearch" class="btn btn-default btn-sm"><i class="fa fa-search"></i></button>
      </form>

				<ul class="nav navbar-nav navbar-right hidden-xs hidden-lg hidden-sm">
                  <%--   <li><input type="radio" name="currency" value="INR"> INR<br></li>
  <li><input type="radio" name="currency" value="DOLLAR"> DOLLAR<br></li>
					<li><a href="#"><i class="fa fa-facebook"></i></a></li>
					<li><a href="#"><i class="fa fa-instagram"></i></a></li>--%>

                    <li>
						<div class="switch" >
						  <input type="radio" class="switch-input" name="currency" value="INR" id="week" checked>
						  <label for="week" class="switch-label switch-label-off"><i class="fa fa-inr"></i></label>
						  <input type="radio" class="switch-input" name="currency" value="DOLLAR" id="month">
						  <label for="month" class="switch-label switch-label-on"><i class="fa fa-dollar"></i></label>
						  <span class="switch-selection"></span>
						</div>
					</li>

				</ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

    <!-- Change11 -->
	<div id="slider" style="right:-342px;">
		<div id="sidebar" onclick="open_panel();">
			<img src="img/contact.png"/>
		</div>
		<div id="header">
					<form runat="server">
              <asp:HiddenField ID="currValue" runat="server" />
			  <input type="text" name="cpname" id="name" placeholder="Name:" required>
			  <input type="email" name="cpemail" id="email" placeholder="Email:" required>
			  <input type="tel" name="cpphone" id="phone" onkeypress="return isNumber(event)" maxlength="10" placeholder="Phone:" required>
			  <textarea name="cpmessage" id="message" placeholder="Message:" required></textarea>
			  <input type="submit" id="submit" value="Send message">
			</form>
		</div>
	</div>
	<!-- Change11 Ends -->


    <a href="javascript:" id="return-to-top"><i class="fa fa-chevron-up"></i></a>
    <!-- Full Page Image Background Carousel Header -->
    <header id="myCarousel" class="carousel slide">
        <!-- Indicators -->
       

        <!-- Wrapper for Slides -->
        <div class="carousel-inner" id="banner" runat="server">

       
           <%-- <div class="item active">
                <div class="fill" style="background-image:url('img/1.jpg');"></div>
                <div class="carousel-caption">
                    <h1>Siddhi Tours</h1>
					<h4>Discover our World Class Travel Experience</h4>
					<a href="#" class="btn btn-default btn-lg">Go Explore</a>
                </div>
            </div>
            <div class="item">
                <div class="fill" style="background-image:url('img/2.jpg');"></div>
                <div class="carousel-caption">
                    <h1>Popular Tours</h1>
					<h4>Explore our popular tours at 30% discount..</h4>
					<a href="#" class="btn btn-default btn-lg">Go Explore</a>
                </div>
            </div>--%>
            <%--<div class="row carousel-searchbar">
				<div class="col-sm-12 text-center">
					<form class="form-inline main-search-form">
					  <div class="form-group">
						<input type="text" class="form-control" id="search" placeholder="Search" class="search-text">
					  </div>
					  <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i></button>
					</form>
				</div>
			</div>
        </div>--%>

        <!-- Controls -->
            	<a href="#" class="scroll-down" address="true"></a>
        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
            <span class="icon-prev"></span>
        </a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next">
            <span class="icon-next"></span>
        </a>
</div>
    </header>
   
	<%--<div class="container">
		<div class="row">
			<div class="nb-form text-center">
			<p class="title"><i class="fa fa-comment"></i> Send us your query</p>
			<p class="message">Did not find what you are looking for ? Let us help you make your trip.</p>
			<form runat="server">
              <asp:HiddenField ID="currValue" runat="server" />
			  <input type="text" name="cpname" placeholder="Name:" required>
			  <input type="email" name="cpemail" placeholder="Email:" required>
			  <input type="tel" name="cpphone" placeholder="Phone:" required>
			  <textarea name="cpmessage" placeholder="Message:" required></textarea>
			  <input type="submit" value="Send message">
			</form>
			</div>
		</div>
	</div>--%>


	<!-- Tour Packages Under -->
    <section id="tp-under" class="tp-under">
        <div class="container">
            <div class="row main-title">
                <div class="col-lg-12 text-center">
                    <h2>Best Tour Packages Under...</h2>
					<h4>Explore our tour packages @ affordable prices</h4>
				</div>
            </div>
			<div class="row sub-title" id="PackageRow">
				
			</div>
        </div>
    </section>
    <!-- Other Services -->
    <section id="other-services" class="other-services">
        <div class="container">
            <div class="row main-title">
                <div class="col-lg-12 text-center">
                    <h2>Other Services</h2>
					<h4>We offer you a complete package with our other services if needed</h4>
				</div>
            </div>
			<div class="row sub-title">
				<div class="col-sm-3 text-center" >
					<div class="panel panel-default">
					  <a href="FrontEndPages/Rent.aspx">
					  <div class="panel-body">
						<%--<img src="../img/d1.jpg" id="rent" class="img-responsive">--%>
                          <img src="" id="rent" class="img-responsive">
					  </div>
					  <div class="panel-footer"><h3>Rent A Car</h3></div>
					  </a>
					</div>
				</div>
				<div class="col-sm-3 text-center">
					<div class="panel panel-default">
					  <a href="FrontEndPages/BusinessTour.aspx">
					  <div class="panel-body">
						<%--<img src="../img/d2.jpg" id="B2b" class="img-responsive">--%>
                          <img src="" id="B2b" class="img-responsive">
					  </div>
					  <div class="panel-footer"><h3>B2B Trips</h3></div>
					  </a>
					</div>
				</div>
				<div class="col-sm-3 text-center">
					<div class="panel panel-default">
					  <a href="FrontEndPages/Visa.aspx">
					  <div class="panel-body">
						<%--<img src="../img/d3.jpg" id="Visa" class="img-responsive">--%>
                          <img src="" id="Visa" class="img-responsive">
					  </div>
					  <div class="panel-footer"><h3>VISA</h3></div>
					  </a>
					</div>
				</div>
                <div class="col-sm-3 text-center">
					<div class="panel panel-default">
					  <a href="FrontEndPages/CruiseList.aspx">
					  <div class="panel-body">
						<%--<img src="../img/d3.jpg" id="Visa" class="img-responsive">--%>
                          <img src="" id="cruise" class="img-responsive">
					  </div>
					  <div class="panel-footer"><h3>Cruise</h3></div>
					  </a>
					</div>
				</div>
			</div>
        </div>
    </section>
	<!-- Popular Destination -->
     <section id="popular-destination" class="popular-destination">
        <div class="container">
            <div class="row main-title">
                <div class="col-lg-12 text-center">
                    <h2>Popular Destination</h2>
					<h4>Explore our in demand destinations from around the globe</h4>
				</div>
            </div>
			<div class="row sub-title">
				<!--<div class="col-sm-12 text-center">
						<div class="customNavigation">
							<span class="pager-left"><a class="btn btn-link prev"><span class="glyphicon glyphicon-chevron-left"></span></a></span>
							<span class="pager-right"><a class="btn btn-link next"><span class="glyphicon glyphicon-chevron-right"></span></a></span>
						</div>
				</div>-->
				<div class="col-sm-12">
					<div class="owl-carousel owl-theme" id="destination">
                    
						<%--<div class="item">
							<div class="panel panel-default">
							  <div class="panel-body text-center">
								<a href="#">
									<div class="overlay">
										<h3 class="overlay-title">Dashing Dubai</h3>
									</div>
								</a>
								<img src="../img/d10.jpg" class="img-responsive">
							  </div>
							</div>
						</div>
						<div class="item">
							<div class="panel panel-default">
							  <div class="panel-body">
								<a href="#">
									<div class="overlay">
										<h3 class="overlay-title">Paris Love</h3>
									</div>
								</a>
								<img src="../img/d12.jpg" class="img-responsive">
							  </div>
							</div>
						</div>
						<div class="item">
							<div class="panel panel-default">
							  <div class="panel-body">
								<a href="#">
									<div class="overlay">
										<h3 class="overlay-title">Fascinating London</h3>
									</div>
								</a>
								<img src="../img/d11.jpg" class="img-responsive">
							  </div>
							</div>
						</div>
						<div class="item">
							<div class="panel panel-default">
							  <div class="panel-body">
								<a href="#">
									<div class="overlay">
										<h3 class="overlay-title">Excellent Europe</h3>
									</div>
								</a>
								<img src="../img/d1.jpg" class="img-responsive">
							  </div>
							</div>
						</div>
						<div class="item">
							<div class="panel panel-default">
							  <div class="panel-body">
								<a href="#">
									<div class="overlay">
										<h3 class="overlay-title">The Moutain Top</h3>
									</div>
								</a>
								<img src="../img/d5.jpg" class="img-responsive">
							  </div>
							</div>
						</div>
						<div class="item">
							<div class="panel panel-default">
							  <div class="panel-body">
								<a href="#">
									<div class="overlay">
										<h3 class="overlay-title">Adventure Trip</h3>
									</div>
								</a>
								<img src="../img/d6.jpg" class="img-responsive">
							  </div>
							</div>
						</div>
						<div class="item">
							<div class="panel panel-default">
							  <div class="panel-body">
								<a href="#">
									<div class="overlay">
										<h3 class="overlay-title">Cruise Control</h3>
									</div>
								</a>
								<img src="../img/d7.jpg" class="img-responsive">
							  </div>
							</div>
						</div>
						<div class="item">
							<div class="panel panel-default">
							  <div class="panel-body">
								<a href="#">
									<div class="overlay">
										<h3 class="overlay-title">Beautiful Bangkok</h3>
									</div>
								</a>
								<img src="../img/d8.jpg" class="img-responsive">
							  </div>
							</div>
						</div>
						<div class="item">
							<div class="panel panel-default">
							  <div class="panel-body">
								<a href="#">
									<div class="overlay">
										<h3 class="overlay-title">City of Love</h3>
									</div>
								</a>
								<img src="../img/d9.jpg" class="img-responsive">
							  </div>
							</div>
						</div>--%>
					</div>
				</div>
			</div>
        </div>
    </section>

    <section id="search-footer" class="search-footer hidden-lg">
		<div class="container">
			<div class="row">
				<div class="col-xs-6 col-sm-8">
					<input type="search" class="form-control ui-autocomplete-input search-Loc" placeholder="Search Tour" id="search"  role="textbox" aria-autocomplete="list" aria-haspopup="true">
				</div>
				<div class="col-xs-6 col-sm-4">
					<li>
						<div class="switch">
						  <input type="radio" class="switch-input" name="currency" value="INR" id="week" checked="checked">
						  <label for="week" class="switch-label switch-label-off"><i class="fa fa-inr"></i></label>
						  <input type="radio" class="switch-input" name="currency" value="DOLLAR" id="month">
						  <label for="month" class="switch-label switch-label-on"><i class="fa fa-dollar"></i></label>
						  <span class="switch-selection"></span>
						</div>
					</li>
				</div>
			</div>
		</div>
	</section>

    <!-- Footer -->
    <footer>
		<div class="container">
			<div class="row">
				<div class="col-sm-4 text-center">
					<h3>Sitemap</h3>
						<h4><a href="../Frontendpages/aboutus.aspx">About Us</a></h4>
					<h4><a href="../Frontendpages/Trip.aspx">Tours</a></h4>
					
					<h4><a href="../Frontendpages/ContactUs.aspx">Contact Us</a></h4>
					<h4><a href="../Frontendpages/Trip.aspx">Popular Destination</a></h4>
				</div>
				<div class="col-sm-4 text-center">
					<h3>Other Links</h3>
					<%--<h4><a href="../Frontendpages/Trip.aspx?CategoryId=1">Group Tour</a></h4>--%>
					<h4><a href="../Frontendpages/visa.aspx">Visa</a></h4>
					<h4><a href="../Frontendpages/BusinessTour.aspx">B2B Trips</a></h4>
					<h4><a href="../Frontendpages/rent.aspx">Rent A Car</a></h4>
					<h4><a href="../Frontendpages/CruiseList.aspx">Cruise</a></h4>
				</div>
				<div class="col-sm-4 text-center">
					<h3>Stay Connected</h3>
					<h4><i class="fa fa-envelope"></i> <span id="FooteremailId"></span></h4>
					<h4><i id="Footerwhats1" class="fa fa-phone"></i> <span id="Footermob1"></span></h4>
					<h4><i id="Footerwhats2" class="fa fa-phone"></i> <span id="Footermob2"></span></h4>
					<br>
					<ul class="social">
                        <li> <a id="fb" href="#" target="_blank"> <i class="fa fa-facebook">  </i> </a> </li>
                        <%--<li> <a href="#"> <i class="fa fa-twitter">  </i> </a> </li>
                        <li> <a href="#"> <i class="fa fa-google-plus">  </i> </a> </li>--%>
                        <li> <a id="insta" href="#" target="_blank"> <i class="fa fa-instagram">  </i> </a> </li>
                    </ul>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-12 text-center">
					<h4>Copyright &copy 2018 Siddhi Tours, All Rights Reserved | Designed & Developed by <a href="http://fourlance.in/" target="_blank" style="color:#03a9f4">Fourlance</a></h4>
				</div>
			</div>
		</div>
    </footer>
    <!-- jQuery -->
    <script src="../frontendcontent/js/jquery.js"></script>
	<script src="../frontendcontent/js/owl.carousel.min.js"></script>
    <!-- Bootstrap Core JavaScript -->
    
    
    <%--  <script src="../frontendcontent/js/masterPage.js"></script>--%>
    <script src="../frontendcontent/js/default.js"></script>
  
    <script src="../frontendcontent/js/bootstrap.min.js"></script>
   <%-- <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js"></script>  --%>  
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>
    <!-- Script to Activate the Carousel -->
    <script>
    $('.carousel').carousel({
        interval: 4000,
        
       pause: 'false'//changes the speed,

    })
	var owl = $('.owl-carousel');
	
	owl.owlCarousel({
        center: true,

    loop:true,
    margin:10,
    responsive:{
        600:{
            items:4
        }
    }
	});
	$('.next').click(function() {
    owl.trigger('next.owl.carousel');
	})
	$('.prev').click(function() {
    owl.trigger('prev.owl.carousel');
	})


        /*
------------------------------------------------------------
Function to activate form button to close the slider.
------------------------------------------------------------
*/
function close_panel() {
slideIn();
a = document.getElementById("sidebar1");
a.setAttribute("id", "sidebar");
a.setAttribute("onclick", "open_panel()");
}
/*
	/*
------------------------------------------------------------
Function to activate form button to open the slider.
------------------------------------------------------------
*/
function open_panel() {
slideIt();
var a = document.getElementById("sidebar");
a.setAttribute("id", "sidebar1");
a.setAttribute("onclick", "close_panel()");
}
/*
------------------------------------------------------------
Function to slide the sidebar form (open form)
------------------------------------------------------------
*/

        $(function () {
            $('.scroll-down').click(function () {
                $('html, body').animate({ scrollTop: $('#tp-under').offset().top }, 'slow');
                return false;
            });
        });




function slideIt() {
var slidingDiv = document.getElementById("slider");
var stopPosition = 0;
if (parseInt(slidingDiv.style.right) < stopPosition) {
slidingDiv.style.right = parseInt(slidingDiv.style.right) + 2 + "px";
setTimeout(slideIt, 1);
}
}
/*
------------------------------------------------------------
Function to activate form button to close the slider.
------------------------------------------------------------
*/
function close_panel() {
slideIn();
a = document.getElementById("sidebar1");
a.setAttribute("id", "sidebar");
a.setAttribute("onclick", "open_panel()");
}
/*
------------------------------------------------------------
Function to slide the sidebar form (slide in form)
------------------------------------------------------------
*/

        // ===== Scroll to Top ==== 
        $(window).scroll(function () {
            if ($(this).scrollTop() >= 100) {        // If page is scrolled more than 50px
                $('#return-to-top').fadeIn(200);    // Fade in the arrow
            } else {
                $('#return-to-top').fadeOut(200);   // Else fade out the arrow
            }
        });
        $('#return-to-top').click(function () {      // When arrow is clicked
            $('body,html').animate({
                scrollTop: 0                       // Scroll to top of body
            }, 500);
        });

/*
------------------------------------------------------------
Function to slide the sidebar form (slide in form)
------------------------------------------------------------
*/
function slideIn() {
    var slidingDiv = document.getElementById("slider");
    var w = window.innerWidth;
   
    if(w <= 768){
		 var stopPosition = -260;
	}
	else{
		 var stopPosition = -342;
	}
if (parseInt(slidingDiv.style.right) > stopPosition) {
slidingDiv.style.right = parseInt(slidingDiv.style.right) - 2 + "px";
setTimeout(slideIn, 1);
}
}

//change11
           //change11
$(document).ready(function(){ 
    var w = window.innerWidth;
	if(w <= 768){
		$('#slider').css('right' , '-260px');
	}
	else{
		$('#slider').css('right' , '-342px');
	}
	});
    
    </script>

</body>
</html>
