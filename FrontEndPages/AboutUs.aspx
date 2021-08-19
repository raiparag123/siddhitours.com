<%@ Page Title="" Language="C#" MasterPageFile="~/FrontEndPages/MasterPage.master" AutoEventWireup="true" CodeFile="AboutUs.aspx.cs" Inherits="FrontEndPages_AboutUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script src="../FrontEndContent/js/bootstrap.min.js"></script>
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>
    <script src="../FrontEndContent/js/AboutUs.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <section id="about-us-page" class="about-us-page">
		<div class="container">
			<div class="row main-title">
                <div class="col-lg-12 text-center">
                    <h2>About Us</h2>
				</div>
            </div>
		</div>
		<div class="container about-us">
			<div class="row">
                <div class="col-sm-4" id="AboutImg">
                    <img src="" runat="server" id="abtImage" class="img-rounded about-us-img">
				</div>
				<div class="col-sm-8">
                    <p class="about-us-main" id="dataDisplay" runat="server">					
					</p>
				</div>
            </div>
		</div>      
    </section>
</asp:Content>