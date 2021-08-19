<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Siddhi Tours Login</title>
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.7 -->
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/login.css">
   <script src="../JS/jquery-1.11.2.min.js"></script>
    <script src="JS/bootstrap.min.js"></script>
   <%-- <script src="JS/validate.js"></script>--%>
    <script src="AdminContent/JS/Login.js" type="text/javascript"></script>
     <script src="http://www.geoplugin.net/javascript.gp" type="text/javascript"></script>
<script src="http://www.google.com/jsapi" type="text/javascript"></script>
    <style>
        
    <style>
        
	.loading-text{
                color: #000;
    font-weight: 700;
    letter-spacing: .5px;
    margin: 7px 5px 0;
        }
            .processing-bar-holder {
    position: fixed;
    top: 0;
    width: 300px;
    text-align: center;
    padding: 0;
    z-index: 2501;
    bottom: 0;
    height: 10px;
    margin: auto;
    left: 0;
    right: 0;
    height: 50px;
   
}
        .processing-bar {
    display: block;
    margin: 0 auto;
    border-bottom-left-radius: 5px;
    border-bottom-right-radius: 5px;
    padding: 0 10px;
    background-color: #00b0ef;
    text-align: center;
    color: #fff;
    font-size: 12px;
    position: relative;
}
        .bg-holder{
                  position: relative;
    background-color: #32404e;
    height: 9px;
    margin-top: 6px;
        }

        #myProgress {
            width: 100%;
            background-color: transparent;
        }

        #myBar {
           
            width: 1%;            
    height: 9px;
    background-color: #5195c5;   
    border-radius: 0;    
    position: relative;
        }
        .modaloverlay{
    background:transparent url(../images/overlay.png) repeat top left;
    position:fixed;
    top:0px;
    bottom:0px;
    left:0px;
    right:0px;
    z-index:1000;
    width:100%;
    height:100%;
    display:block;
    background-color:rgb(0,0,0);
    opacity:0.75;
}

    </style>
    
  </head>
  
<body>
    <div class="modaloverlay" id="modaloverlay"></div>
         <div id="processing-bar-holder" class="clearfix processing-bar-holder collapse">
             <img src="img/giphy.gif" style="width: 50%;" />
            <%--<div class="processing-bar" id="myProgress">
                <p class="loading-text">Uploading Files</p>
                <div class="bg-holder" style="display: none">
                    <div id="myBar"></div>
                </div>                
            </div>--%>
        </div>
	<div class="wrapper">
		<form action="" method="post" runat="server" name="Login_Form" class="form-horizontal form-signin" id="myForm" > 
            <asp:HiddenField ID="user" runat="server" />
            <asp:HiddenField ID="pass" runat="server"/>
            <asp:HiddenField ID="hdnflag" runat="server" />
            
		    <h3 class="form-signin-heading"><img src="img/logo.png" class="logo-size"></h3>
			  <hr class="colorgraph"><br>
       
        <input type="text" id="txtUserName" class="form-control" MaxLength="100" type="text" name="Username" required="" placeholder="Username"  autofocus=""  />
        
        
        <input id="txtPassword"  type="password" class="form-control" name="pass" placeholder="Password" MaxLength="150" required="" autofocus=""  />
            <br />
            <input type="checkbox" ID ="rememberme" name="check"   value ="remember Password" />Remember me<br />
        <br />
        <input type="submit" ID="btnSubmit"  class="btn btn-lg btn-primary btn-block" value="Login" />
     
        <div class="col-sm-12 text-center forgot-pass">
				<a href="#" id="reset_pwd">Forgot Password?</a>
			  </div>
    </form>
    </div>
   <div class="modal  fade" id="modal1">
          <div class="modal-dialog" style="width:30%">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Status</h4>
              </div>
              <div class="modal-body">
              <h5><span id="invalid_cred"></span></h5>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-outline pull-right" data-dismiss="modal">Close</button>
               
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
       </div>
   
    
    
</body>
