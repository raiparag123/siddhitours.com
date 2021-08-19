<%@ Page Title="" Language="C#" MasterPageFile="~/FrontEndPages/MasterPage.master" AutoEventWireup="true" CodeFile="CruiseDetail.aspx.cs" Inherits="FrontEndPages_CruiseDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <link href="../FrontEndContent/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
	<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="../FrontEndContent/css/owl.carousel.min.css">
	<link rel="stylesheet" href="../FrontEndContent/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="../FrontEndContent/css/slick.css">
	<link rel="stylesheet" href="../FrontEndContent/css/slick-theme.css">
	<link href="../FrontEndContent/css/main.css" rel="stylesheet">
    <script src="../FrontEndContent/js/CruiseDetail.js"></script>
      <script src="../JS/moment.min.js"></script>
    <%--<script src="../JS/jquery-1.11.2.min.js"></script>--%>
    <script src="../FrontEndContent/js/jquery.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>
	<script src="../FrontEndContent/js/owl.carousel.min.js"></script>
    <script src="../FrontEndContent/js/slick.min.js"></script>
	<!-- Bootstrap Core JavaScript -->
     
    <script src="../FrontEndContent/js/bootstrap.min.js"></script>
	<script src="../FrontEndContent/js/responsive-tabs.js"></script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <section id="cruise-desc" class="cruise-desc">
            <div class="container b2b-desc-cont  b2b-desc">
            <div class="row">
				<div class="col-sm-4">
					<ul class="breadcrumb">
					  <li><a href="../Default.aspx">Home</a></li>
					<li><a href="CruiseList.aspx">Cruise List</a></li>
					  <li class="active">Cruise Description</li>
					</ul>
				</div>
			</div>
               </div>
        <div class="container cruise-top-detail">
			<div class="row">
				<div class="col-sm-5">
					<div class="cruise-gallery">
						<div class="slider slider-for" id="main">
						<%--	<div><img src="img/d1.jpg" class="img-responsive gallery-img-main"></div>--%>
							<%--<div><img src="img/d2.jpg" class="img-responsive gallery-img-main"></div>
							<div><img src="img/d3.jpg" class="img-responsive gallery-img-main"></div>
							<div><img src="img/d4.jpg" class="img-responsive gallery-img-main"></div>
							<div><img src="img/d5.jpg" class="img-responsive gallery-img-main"></div>--%>
						</div>
						<div class="slider slider-nav" id="navImage">
						<%--	<div><img src="img/d1.jpg" class="img-responsive gallery-img-nav"></div>--%>
							<%--<div><img src="img/d2.jpg" class="img-responsive gallery-img-nav"></div>
							<div><img src="img/d3.jpg" class="img-responsive gallery-img-nav"></div>
							<div><img src="img/d4.jpg" class="img-responsive gallery-img-nav"></div>
							<div><img src="img/d5.jpg" class="img-responsive gallery-img-nav"></div>--%>
						</div>
					</div>
				</div>
				<div class="col-sm-7">
                    <div class="panel panel-default">
					<div class="panel-body">
					 <h4 class="main-title-cruise" id="title"></h4>
                        <h5 class="main-title-cruise" >Price : <b><span id="mainprice"></span></b></h5>
					<div class="row">
						<div class="col-sm-6">
							<h5>Duration:<span id="day"></span> Nights/<span id="night"></span> Days</h5>
						</div>
						<div class="col-sm-6">
							<h5>From : <span id="from"></span> - To: <span id="to"></span></h5>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-6">
							<h5>Embarkation Port: <span id="source"></span></h5>
						</div>
						<div class="col-sm-6">
							<h5>Disembarkartion Post:  <span id="Destination"></span></h5>
						</div>
					</div>
					<div class="row inc-exc-cruise">
						<div class="col-sm-6">
							<p class="cruise-inc" id="inc"></p>
						</div>
						<div class="col-sm-6">
							<p class="cruise-exc" id="exc"></p>
						</div>
					</div>
				</div>
                        </div>
                    </div>
			</div>
        </div>
	<div class="container cruise-desc-data">
		<div class="row">
			<div class="col-sm-12">
                <div class="panel panel-default main-nav-tabs">
					<div class="panel-body">
				<ul class="nav nav-tabs responsive">
				  <li class="active"><a href="#tab1" data-toggle="tab" aria-expanded="false">Cabin Pricing</a></li>
				  <li class=""><a href="#tab2" data-toggle="tab" aria-expanded="false">itinerary Details</a></li>
				  <li class=""><a href="#tab3" data-toggle="tab" aria-expanded="false">On Board Activities</a></li>
				  <li class="dropdown">
					<a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
					  Cabin <span class="caret"></span>
					</a>
					<ul class="dropdown-menu" id="ddlcabin">
					  <%--<li class=""><a href="#tab4" data-toggle="tab" aria-expanded="false">Interior</a></li>
					  <li class=""><a href="#tab5" data-toggle="tab" aria-expanded="false">Oceanview</a></li>
					  <li class=""><a href="#tab6" data-toggle="tab" aria-expanded="false">Balcony</a></li>
					  <li class=""><a href="#tab7" data-toggle="tab" aria-expanded="false">Suites</a></li>--%>
					</ul>
				  </li>
				  <li class=""><a href="#tab8" data-toggle="tab" aria-expanded="false">Ship General Info</a></li>
				</ul>
                        </div>
                    </div>
				<div id="myTabContent" class="tab-content responsive">
				  <div class="tab-pane fade active in" id="tab1">
                      <div class="panel panel-default">
					<div class="panel-body">
					<table class="table table-hover" id="cabinTable">
					  <thead>
						<tr>
						  <th>Cabin Type</th>
						  <th>Cabin Image</th>
						  <th>Gratitude</th>
						  <th>Tax</th>
						  <th>Price</th>
                            <th>Total</th>
						</tr>
					  </thead>
					  <tbody>
						<%--<tr>
						  <td>Column content</td>
						  <td><img src="img/d3.jpg" class="img-responsive"></td>
						  <td>Column content</td>
						  <td>Column content</td>
						  <td>Column content</td>
						</tr>
						<tr>
						  <td>Column content</td>
						  <td><img src="img/d3.jpg" class="img-responsive"></td>
						  <td>Column content</td>
						  <td>Column content</td>
						  <td>Column content</td>
						</tr>
						<tr>
						  <td>Column content</td>
						  <td><img src="img/d3.jpg" class="img-responsive"></td>
						  <td>Column content</td>
						  <td>Column content</td>
						  <td>Column content</td>
						</tr>
						<tr>
						  <td>Column content</td>
						  <td><img src="img/d3.jpg" class="img-responsive"></td>
						  <td>Column content</td>
						  <td>Column content</td>
						  <td>Column content</td>
						</tr>--%>
					  </tbody>
					</table> 
                        </div>
                          </div>
				  </div>
				  <div class="tab-pane fade" id="tab2">
                      <div class="panel panel-default">
					<div class="panel-body">
					<ul class="timeline" id="ItenaryList">
						<%--<li>
							<a href="#">Day 1 - Getting Ready for Dolphin Meet</a>
							<div class="itenary-box">
								<img src="img/d1.jpg" class="itenary-image">
								<p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat
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
				  </div>
				  <div class="tab-pane fade" id="tab3">
                     
					<div class="row">
						<div class="col-sm-12" id="enterDiv" style="display:none">
                             <div class="panel panel-default">
                                 <div class="panel-heading"><h2 class="panel-title">Entertainment</h2></div>
					<div class="panel-body">
							<%--<h2 id="onBoard-Title">Entertainment</h2>--%>
							<div id="Entertainment">
								<%--<div class="col-sm-4">
									<img src="img/trial-icon.png" class="img-responsive">
									<h4>Activity Name here</h4>
								</div>
								<div class="col-sm-4">
									<img src="img/trial-icon.png" class="img-responsive">
									<h4>Activity Name here</h4>
								</div>
								<div class="col-sm-4">
									<img src="img/trial-icon.png" class="img-responsive">
									<h4>Activity Name here</h4>
								</div>--%>
							</div>
                        </div>
                                 </div>
						</div>
						<div class="col-sm-12" id="kid" style="display:none">
							<div class="panel panel-default">
						<div class="panel-heading"><h2 class="panel-title">Kid's Entertainment</h2></div>
						<div class="panel-body">
							<div  id="kidDiv">
								<%--<div class="col-sm-4">
									<img src="img/trial-icon.png" class="img-responsive">
									<h4>Activity Name here</h4>
								</div>
								<div class="col-sm-4">
									<img src="img/trial-icon.png" class="img-responsive">
									<h4>Activity Name here</h4>
								</div>
								<div class="col-sm-4">
									<img src="img/trial-icon.png" class="img-responsive">
									<h4>Activity Name here</h4>
								</div>--%>
							</div>
                            </div>
                                </div>
						</div>
						<div class="col-sm-12" id="life" style="display:none">
							<div class="panel panel-default">
						<div class="panel-heading"><h2 class="panel-title">Lifestyle</h2></div>
						<div class="panel-body">
							<div class="row" id="lifeDiv">
								<%--<div class="col-sm-4">
									<img src="img/trial-icon.png" class="img-responsive">
									<h4>Activity Name here</h4>
								</div>
								<div class="col-sm-4">
									<img src="img/trial-icon.png" class="img-responsive">
									<h4>Activity Name here</h4>
								</div>--%>
							</div>
                            </div>
                                </div>
						</div>
					</div>
				  </div>
				  <div class="tab-pane fade" id="tab4">

					<%--<div class="row" >
						<div class="col-sm-4">
							<img src="img/d8.jpg" class="img-responsive">
						</div>
						<div class="col-sm-8">
							<h3>Title here!</h3>
							<h4>Pricing Here!!</h4>
							<p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?</p>
						</div>
					</div>--%>
				  </div>
				  <div class="tab-pane fade" id="tab5">
					<%--<div class="row">
						<div class="col-sm-4">
							<img src="img/d3.jpg" class="img-responsive">
						</div>
						<div class="col-sm-8">
							<h3>Title here!</h3>
							<h4>Pricing Here!!</h4>
							<p></p>
						</div>
					</div>--%>
				  </div>
				  <div class="tab-pane fade" id="tab6">
					<%--<div class="row">
						<div class="col-sm-4">
							<img src="img/d7.jpg" class="img-responsive">
						</div>
						<div class="col-sm-8">
							<h3>Title here!</h3>
							<h4>Pricing Here!!</h4>
							<p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?</p>
						</div>
					</div>--%>
				  </div>
				  <div class="tab-pane fade" id="tab7">
					<%--<div class="row">
						<div class="col-sm-4">
							<img src="img/d9.jpg" class="img-responsive">
						</div>
						<div class="col-sm-8">
							<h3>Title here!</h3>
							<h4>Pricing Here!!</h4>
							<p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?</p>
						</div>
					</div>--%>
				  </div>
				  <div class="tab-pane fade" id="tab8">
                      <div class="panel panel-default">
					<div class="panel-body">
					<div  id="ship">
						
					</div>
                        </div>
                          </div>
                      
                      </div>
				  </div>
				</div>
			</div>
		</div>
	<%--</div>--%>

     </section>
      <script>
    $('.carousel').carousel({
        interval: 4000 //changes the speed
    })
	 //$('.slider-for').slick({
	 //  slidesToShow: 1,
	 //  slidesToScroll: 1,
	 //  arrows: false,
	 //  fade: true,
	 //  asNavFor: '.slider-nav'
	 //});
	 //$('.slider-nav').slick({
	 //  slidesToShow: 3,
	 //  slidesToScroll: 1,
	 //  asNavFor: '.slider-for',
	 //  dots: false,
	 //  focusOnSelect: true
	 //});
	
	(function($) {
      fakewaffle.responsiveTabs(['xs', 'sm']);
	})(jQuery);
	
</script>
</asp:Content>

