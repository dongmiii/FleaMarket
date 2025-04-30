<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>DOONGI SITE</title>
    <link rel="icon" href="/resources/img/siteicon.png">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="/resources/fleaMarket/css/bootstrap.min.css">
    <!-- animate CSS -->
    <link rel="stylesheet" href="/resources/fleaMarket/css/animate.css">
    <!-- owl carousel CSS -->
    <link rel="stylesheet" href="/resources/fleaMarket/css/owl.carousel.min.css">
    <!-- themify CSS -->
    <link rel="stylesheet" href="/resources/fleaMarket/css/themify-icons.css">
    <!-- flaticon CSS -->
    <link rel="stylesheet" href="/resources/fleaMarket/css/flaticon.css">
    <!-- font awesome CSS -->
    <link rel="stylesheet" href="/resources/fleaMarket/css/magnific-popup.css">
    <link rel="stylesheet" href="/resources/fleaMarket/css/nice-select.css">
    <!-- swiper CSS -->
    <link rel="stylesheet" href="/resources/fleaMarket/css/swiper.min.css">
    <!-- style CSS -->
    <link rel="stylesheet" href="/resources/fleaMarket/css/style.css">
    <style>
    	img#MOVE_TOP_BTN {
    		position: fixed;
    		right: 2%;
    		bottom: 50px;
    		display: none;
    		z-index: 999;
		}
    </style>
</head>

<body>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <!--::header part start::-->
    
    <!-- 위로가기 버튼 -->
    <img src="/resources/img/top.png" id="MOVE_TOP_BTN"></img>
    
    <header class="header_area">
        <div class="sub_header">
            <div class="container">
                <div class="row align-items-center">
                	<div class="col-md-4 col-xl-6">
                    	<div id="logo">
                        	<a href="/"><img src="/resources/img/mainLogo.png" alt="" title="" /></a>
                    	</div>
                	</div>
                  <div class="col-md-8 col-xl-6">
                      <div class="sub_header_social_icon float-right">
                      	<sec:authorize access="isAnonymous()">
                      		<a href="/join/form" class="register_icon"><i class="ti-arrow-right"></i>회원가입</a>
                      		<a href="/login/form" class="register_icon"><i class="ti-arrow-right"></i>로그인</a>
                      	</sec:authorize>
                      	<sec:authorize access="isAuthenticated()">
                      		<a href="/member/mypage" class="register_icon"><i class="ti-arrow-right"></i>MY PAGE</a>
                      		<a href="/logout/form" class="register_icon"><i class="ti-arrow-right"></i>로그아웃</a>
                      	</sec:authorize>
                      </div>
                  </div>
            	</div>
            </div>
        </div>
        <div class="main_menu">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <nav class="navbar navbar-expand-lg navbar-light">
                            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                                <span class="navbar-toggler-icon"></span>
                            </button>

                            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                                <ul class="navbar-nav mr-auto">
                                    <li class="nav-item active">
                                        <a href="/" class="nav-link active">Home</a>
                                    </li>
                                    <li class="nav-item active">
                                        <a href="/intro/intro" class="nav-link active">Doongji</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/notice/notice" class="nav-link">공지사항</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/review/list" class="nav-link">후기</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/market/list" class="nav-link">마켓 모아보기</a>
                                    </li>
                                    <sec:authorize access="hasAnyRole('ROLE_USER')">
                                    	<li class="nav-item">
                                    	    <a href="/market/registForm" class="nav-link">마켓 신청</a>
                                    	</li>
                                    </sec:authorize>
                                    <sec:authorize access="hasAnyRole('ROLE_ORGANIZER')">
                                    	<li class="nav-item">
                                    	    <a href="/state/state" class="nav-link">신청마켓 현황</a>
                                    	</li>
                                    </sec:authorize>
                                     <sec:authorize access="hasAnyRole('ROLE_MASTER')">
                                    	<li class="nav-item">
                                    	    <a href="/manage/mknmb" class="nav-link">관리</a>
                                    	</li>
                                    </sec:authorize>
                                </ul>
                            </div>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- Header part end-->
    
    
    <script>
    $(function() {
	    $(window).scroll(function() {
	        if ($(this).scrollTop() > 350) {
	            $('#MOVE_TOP_BTN').fadeIn();
	        } else {
	            $('#MOVE_TOP_BTN').fadeOut();
	        }
	    });
	    
	    $("#MOVE_TOP_BTN").click(function() {
	        $('html, body').animate({
	            scrollTop : 0
	        }, 400);
	        return false;
	    });
	});
    </script>
    