<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ResetPassword.aspx.cs" Inherits="ResetPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Siddhi Tours Reset Password</title>
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.7 -->
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/login.css">
  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
</head>
<body>
    <div class = "container">
	<div class="wrapper">
		<form action="" method="post" name="Login_Form" class="form-signin">       
			  <hr class="colorgraph"><br>
        <div id="displayPassword" runat="server">
           <input type="password" id="newpassword" placeholder="New Password" class="form-control" required />
           <input type="password" id="confpassword" placeholder="Confirm Password" class="form-control"  required/>
            <input type="submit" id="btnSubmit" class="btn btn-lg btn-primary btn-block" />
        </div>
        <div id="expiry" runat="server"><h2>The Link is expired</h2></div>
    </form>
        </div>
        </div>
      <script src="AdminContent/JS/jquery-1.8.3.js"></script>
    <script src="AdminContent/JS/ResetPassword.js"></script>
</body>
</html>
