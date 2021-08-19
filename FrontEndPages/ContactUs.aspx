<%@ Page Title="" Language="C#" MasterPageFile="~/FrontEndPages/MasterPage.master" AutoEventWireup="true" CodeFile="ContactUs.aspx.cs" Inherits="FrontEndPages_ContactUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>
    <script src="../FrontEndContent/js/bootstrap.min.js"></script>
    <script src="../FrontEndContent/js/ContactUs.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section id="about-us-page" class="about-us-page">
        <div class="container">
            <div class="row main-title">
                <div class="col-lg-12 text-center">
                    <h2>Contact Us</h2>
                </div>
            </div>
        </div>
        <div class="container about-us">

            <div class="row">
                <div class="col-sm-8 contact-form-row">
                    <div class="panel panel-default">
					<div class="panel-body">
                    <form role="form">
                        <div class="form-group ">
                            <label for="name">Your Name</label>
                            <input type="text" class="form-control" id="name" placeholder="Full Name">
                        </div>
                        <div class="form-group ">
                            <label for="contactno">Mobile No.</label>
                            <input type="text" class="form-control integer" maxlength="15" id="contactno" placeholder="Mobile No.">
                        </div>
                        <div class="form-group ">
                            <label for="exampleInputEmail1">Email ID</label>
                            <input type="text" class="form-control" id="EmailId" placeholder="Email ID">
                        </div>
                        <div class="form-group ">
                            <label for="message">Message</label>
                            <textarea class="desc-txt" placeholder="Type your message" name="desc" id="desc" style="width: 100%; height: 200px; font-size: 14px; line-height: 18px; padding: 10px;"></textarea>
                        </div>
                        <label style="color: orangered" name="Message" id="lblMessage"></label>
                            <br />
                        <button class="btn btn-danger" id="sendMail" type="submit">Send Message</button>
                    </form>
                        </div>
                        </div>
                </div>
                <div class="col-sm-4 contact-details-row">
                    <div class="panel panel-default">
						<div class="panel-body">
                    <h4>
                        <div class="col-sm-2"><i class="fa fa-map-marker"></i></div>
                        <div class="col-sm-10" id="Address">
                        </div>
                        </h4>				
                        <h4>
                            <div class="col-sm-2"><i id="whats1" class="fa fa-phone"></i></div>
                            <div class="col-sm-10" id="Mob1"></div>
                        </h4>
                        <h4>
                            <div class="col-sm-2"><i id="whats2" class="fa fa-phone"></i></div>
                            <div class="col-sm-10" id="Mob2"></div>
                        </h4>
                        <h4>
                            <div class="col-sm-2"><i class="fa fa-envelope"></i></div>
                            <div class="col-sm-10" id="Email"></div>
                        </h4>
                        <div class="social-media">
                            <a href="#" id="facebook"><i class="fa fa-facebook"></i></a>
                            <a href="#"><i class="fa fa-twitter"></i></a>
                            <a href="#"><i class="fa fa-google-plus"></i></a>
                            <a href="#" id="insta"><i class="fa fa-instagram"></i></a>
                        </div>
                </div>
                        </div>
				</div>
            </div>
		</div>
		<div class="container-fluid">
            <div class="row map-row">
                <div class="col-sm-12 text-center map-details">
                    <div class="mapouter">
                        <div class="gmap_canvas">
                            <iframe width="100%" height="350" id="gmap_canvas" src="https://maps.google.com/maps?q=M.I.D.C%20Bhosari&t=&z=15&ie=UTF8&iwloc=&output=embed" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe>
                        </div>
                        <style>
                            .mapouter {
                                text-align: right;
                                height: 350px;
                                width: 100%;
                            }

                            .gmap_canvas {
                                overflow: hidden;
                                background: none !important;
                                height: 350px;
                                width: 100%;
                            }
                        </style>
                    </div>
                </div>
            </div>
        </div>


    </section>
</asp:Content>