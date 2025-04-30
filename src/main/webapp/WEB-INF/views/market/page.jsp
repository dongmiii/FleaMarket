<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<%@ include file="../includes/header.jsp"%>
<!--::breadcrumb part start::-->
<section class="breadcrumb breadcrumb_bg">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="breadcrumb_iner">
					<div class="breadcrumb_iner_item">
						<h1 style="font-family:나눔스퀘어_ac; color:orange;">Market Detail Page</h1>
						<p style="color:white;">
							플리마켓에 관한 상세정보페이지입니다<br>
							지도와 길찾기를 통해 마켓의 위치를 확인해 보세요<br>
							마켓에서 판매중인 물품들을 확인해보세요
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>


<section class="blog_area single-post-area section_padding">
	<div class="container">
		<div class="row">
			<div class="col-lg-7 posts-list">
				<div class="single-post">
					<!-- 메인 이미지 -->
					<div class="feature-img">
						<img class="img-fluid" id="mainImage_0" src="" alt="" style="max-width: 100%; height: 300px;" />	
					</div>
					<div class="blog_details">
						<h2 style="font-family:나눔스퀘어_ac;"><c:out value="${market.MName}"/></h2>
                        <ul class="blog-info-link mt-3 mb-4">
                           <li><i class="far fa-user"></i>주최자: <c:out value="${market.orgName}"/></li>
                           <li><i class="far fa-comments"></i>마켓기간: <fmt:formatDate pattern="yy/MM/dd" value="${market.MStartDate}"/> ~ <fmt:formatDate pattern="yy/MM/dd" value="${market.MLastDate}"/></li>
                        </ul>
                     	마켓 주소: <c:out value="${market.MLocation}"/>
                        <br>마켓 주최자번호: <c:out value="${market.MPhone}"/>
                        <br>마켓 카테고리: <c:out value="${market.MCategory}"/> 
                        <br>현재 평점: <c:out value="${market.MLikes}"/> 
                        <br>진행여부: 
                        <jsp:useBean id="now" class="java.util.Date" />
                        <fmt:formatDate pattern="yyyyMMddhhmm" value="${now}" var="nowDate"/>
						<fmt:formatDate pattern="yyyyMMddhhmm" value="${market.MStartDate}" var="startDate"/>
						<fmt:formatDate pattern="yyyyMMddhhmm" value="${market.MLastDate}" var="closeDate"/>
						<c:if test="${startDate < nowDate && closeDate > nowDate}">
							진행중	
						</c:if>
						<c:if test="${startDate > nowDate}">
							오픈 전	
						</c:if>
						<c:if test="${closeDate < nowDate}">
							마감	
						</c:if>
                        <div class="quote-wrapper">
                        	<div class="quotes" style="white-space:pre-line;"><c:out value="${market.MInfo}"/></div>
                        </div>
					</div>
				</div>
			</div>
			<div class="col-lg-5">
				<div class="blog_right_sidebar">
					<div class="feature-img">
						<img class="img-fluid" id="mainImage_1" src="" alt="" style="max-width: 100%; height: 300px;" />	
					</div>
					<div class="feature-img">
						<img class="img-fluid" id="mainImage_2" src="" alt="" style="max-width: 100%; height: 300px;" />	
					</div>
					<aside class="single_sidebar_widget post_category_widget">
                        <h4 class="widget_title">Market Category</h4>
                        <ul class="list cat-list">
                        	<c:set var="category" value="${fn:split(market.MCategory,',')}"/>
                        	<c:forEach items="${category}" var="cate">
                        		<li>
                        	      <div class="d-flex">
                        	         <p><c:out value="${cate}"/></p>
                        	      </div>
                        	   </li>
                        	</c:forEach>
                        </ul>
                     </aside>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="gallery_part">
	 <div class="container-fluid">
	 	<div class="row justify-content-center">
	 		<div class="col-lg-10">
	 			<hr>
	 		</div>
 	 		<div class="col-xl-5"> 
             	<div class="section_tittle text-center">
                	<h4>FleaMarket Location</h4>
				</div>
				<!-- <a href="https://map.kakao.com/link/to/카카오판교오피스,37.402056,127.108212"></a> -->
				<div class="section_tittle text-center">
					<div class="genric-btn primary" id="openLoad">길찾기</div>
				</div>
			</div>
	 	</div>
	 </div>
</section>

<!-- 지도 시작 -->
<!-- <section class="contact-section section_padding"> --> 
<div class="container">
	<div class="row justify-content-center">
		<div class="col-lg-12">
			<div class="d-none d-sm-block mb-5 pb-4">
				<div id="map" style="height: 480px;"></div>
			</div>
		</div>
	</div>
</div>
<!-- </section> -->
<!-- 지도 끝 -->

<!-- 아이템 이미지 시작 -->
<section class="gallery_part">
	<div class="container-fluid">
		<div class="row justify-content-center">
			<div class="col-lg-10">
	 			<hr>
	 		</div>
			<div class="col-xl-5">
            	<div class="section_tittle text-center">
                	<h4>Sell Items</h4>
            	</div>
			</div>
		</div>
	</div>
</section>
<div class="whole-wrap">
	<div class="container box_1170">
		<div class="row gallery-item">
			<!-- 아이템 이미지 나열 -->
		</div>
	</div>
</div>
<!-- 아이템 이미지 끝 -->

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0e781e6ca430c3b19be8493a8ce0e7a3&libraries=services"></script>
<script>
	$(document).ready(function() {
		(function() {
			var mno = '<c:out value="${market.mno}"/>';
			$.getJSON("/market/getAttachList", {mno:mno}, function(arr) {
				//console.log(arr);
				var str="";
				var itemImageStr="";
				//main이미지 설정및 서브이미지 설정, 아이템 이미지 설정
				$(arr).each(function(i, attach){
					if(attach.sort === 'market'){
						str = encodeURIComponent(attach.uploadPath + "/marketDetail_" + 
								attach.uuid + "_" + attach.imageName);
						$("#mainImage_"+i).attr("src","/display?fileName="+str);
					}else if(attach.sort === 'item'){
						var imageOriginUri = encodeURIComponent(attach.uploadPath + "/" + 
								attach.uuid + "_" + attach.imageName);
						var imageUri = encodeURIComponent(attach.uploadPath + "/itemDetail_" + 
								attach.uuid + "_" + attach.imageName);	
						itemImageStr += '<div class="col-md-4">';
						itemImageStr += '<a href="/display?fileName='+imageOriginUri+'" class="img-pop-up">';
						itemImageStr += '<div class="single-gallery-image" style="background: url(/display?fileName='+imageUri+')"></div>';
						itemImageStr += '</a></div>';
					}
				});
				$(".gallery-item").append(itemImageStr);
			});
		})();
		
		var mAddress = "<c:out value='${market.MLocation}'/>";
		var mName = "<c:out value='${market.MName}'/>";
		var location_x;
		var location_y;
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 

		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(mAddress, function(result, status) { 
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x); //좌표값 전달받음
		        location_x = result[0].x;
		        location_y = result[0].y;
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+mName+'</div>' //마켓이름 넣을곳
		        });
		        infowindow.open(map, marker);
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		});
		
		$("#openLoad").on("click", function(e){
			window.open("https://map.kakao.com/link/to/"+mAddress+","+location_y+","+location_x,
					"길찾기", "width=1400,height=700");
			
		});
	});
	
	
</script>

<%@ include file="../includes/footer.jsp"%>

















