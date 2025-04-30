<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<title>FleaMarket Logout</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="/resources/Login_v6/images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/Login_v6/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/Login_v6/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/Login_v6/fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/Login_v6/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="/resources/Login_v6/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/Login_v6/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/Login_v6/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="/resources/Login_v6/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/resources/Login_v6/css/util.css">
	<link rel="stylesheet" type="text/css" href="/resources/Login_v6/css/main.css">
<!--===============================================================================================-->
</head>
<body>
	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-85 p-b-20">
				<form class="login100-form validate-form" action="/customLogout" method="post"> 
					<span class="login100-form-avatar">
						<img src="/resources/img/loginLogo.png" alt="AVATAR">
					</span>
					<span class="login100-form-title p-b-70">
						<img src="/resources/img/logoutLogo.png" alt="AVATAR">
					</span>
					<div class="container-login100-form-btn m-t-85">
						<button class="login100-form-btn">
							로 그 아 웃
						</button>
					</div>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				</form>
				<div class="container-login100-form-btn m-t-35">
					<button class="login100-form-btn" id="homeBtn">
						H O M E
					</button>
				</div>
			</div>
		</div>
	</div>

	<div id="dropDownSelect1"></div>
	
	<script>
		$(document).ready(function(){
			$("#homeBtn").on("click", function(e){
				self.location = "/";
			});
		});
	</script>	
		
<!--===============================================================================================-->
	<script src="/resources/Login_v6/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="/resources/Login_v6/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="/resources/Login_v6/vendor/bootstrap/js/popper.js"></script>
	<script src="/resources/Login_v6/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="/resources/Login_v6/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="/resources/Login_v6/vendor/daterangepicker/moment.min.js"></script>
	<script src="/resources/Login_v6/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="/resources/Login_v6/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="/resources/Login_v6/js/main.js"></script>

</body>
</html>