<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@	taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="includes/header.jsp" %>

    <!-- banner part start-->
    
    <section class="banner_part">
        <div class="container">
            <div class="row align-content-center">
                <div class="col-lg-7 col-xl-5">
                    <div class="banner_text">
                        <h1><span>FleaMarket</span><br> 
                    	With DOONGJI</h1>
                        <p style="font-family:나눔스퀘어_ac; color:black;" >여러 장소에서 열리는 플리마켓의 정보들을 한 곳에서 찾아볼 수 있는 공간</p>
                        <a href="/intro/intro" class="btn_1">사이트 소개 <span class="ti-angle-right"></span> </a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <c:forEach items="${marketInfo}" var="market" varStatus="status">
    	<section class="about_part">
        <div class="container-fluid">
            <div class="row align-items-center">
            	<c:choose>
            	<c:when test="${status.index%2==0}">
                <div class="col-md-6 offset-xl-1 col-xl-4">
                    <div class="about_img">
                        <img src="" id="marketMainImage_${status.index}" alt="" style="max-width: 100%; height: 300px;" /> 
                    </div>
                </div>
                <div class="col-md-6 col-xl-4">
                    <div class="about_text">
                        <h4>Market Information</h4>
                        <h2 style="font-family:나눔스퀘어_ac;">Welcome to<br>
                        <c:out value="${market.MName}"/></h2>
                        <p>Location: <c:out value="${market.MLocation}"/></p>
                        <p>Date: <fmt:formatDate pattern="yyyy/MM/dd" value="${market.MStartDate}"/>
                        	 ~ <fmt:formatDate pattern="yyyy/MM/dd" value="${market.MLastDate}"/></p>
                        <a href="<c:out value='${market.mno}'/>" class="btn_2 move">알아보기</a>
                    </div>
                </div>
                </c:when>
                 
                 <c:when test="${status.index%2==1}">
                 <div class="col-md-6 col-xl-4">
                    <div class="about_text">
                        <h4>Market Information</h4>
                        <h2 style="font-family:나눔스퀘어_ac;">Welcome to<br>
                        <c:out value="${market.MName}"/></h2>
                        <p>Location: <c:out value="${market.MLocation}"/></p>
                        <p>Date: <fmt:formatDate pattern="yyyy/MM/dd" value="${market.MStartDate}"/>
                        	 ~ <fmt:formatDate pattern="yyyy/MM/dd" value="${market.MLastDate}"/></p>
                        <a href="<c:out value='${market.mno}'/>" class="btn_2 move">알아보기</a>
                    </div>
                </div>
                <div class="col-md-6 offset-xl-1 col-xl-4">
                    <div class="about_img">
                        <img src="" id="marketMainImage_${status.index}" alt="" style="max-width: 100%; height: 300px;" /> 
                    </div>
                </div>
                </c:when>
                </c:choose>
            </div>
        </div>
    	</section>
    </c:forEach>
	
	<form id="actionForm" action="/index" method="GET">
		<!-- 
		페이징 처리를 위해서
		<input type="hidden" name="pageNum" value="<c:out value='${pageMaker.cri.pageNum}'/>"/>
		<input type="hidden" name="amount" value="<c:out value='${pageMaker.cri.amount}'/>"/>
		<input type="hidden" name="type" value="<c:out value='${pageMaker.cri.type}'/>"/>
		<input type="hidden" name="keyword" value="<c:out value='${pageMaker.cri.keyword}'/>"/>
		 -->
	</form>
    
    <!-- Modal 추가 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">알림</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">처리가 완료되었습니다.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

<%@include file="includes/footer.jsp"%>


<script type="text/javascript">
	$(document).ready(function(){
		
		var result = '<c:out value="${result}"/>';
		var actionForm = $("#actionForm");
		
		checkModal(result); //먼저 모달을 띄우는데(result가 존재한다면)
		
		history.replaceState({},null,null); //뒤로가기를 하면 다시 모달을 띄워질 수가 있기 때문에 
		
		function checkModal(result) {
			
			if(result === '' || history.state){
				return;
			}
			
			if(result){
				$(".modal-body").html(result);
			}
			$("#myModal").modal("show"); //화면에 모달창이 보임
		}
		
		$(".move").on("click", function(e){
			
			e.preventDefault();
			actionForm.append("<input type='hidden' name='mno' value='" + $(this).attr("href") + "'>");
			actionForm.attr("action", "/market/page");
			actionForm.submit();
		});
		
		
		<c:forEach items="${marketInfo}" var="marketTemp" varStatus="status">
		//console.log("${reviewInfo.reviewNo}");
		
		$.getJSON("/market/getAttachList",{mno:"${marketTemp.mno}"}, function(arr){
			console.log(arr);
			if(Object.keys(arr).length === 0){ //이미지가 없다면
				//console.log("noimage.gif 보여줌");
				$("#marketMainImage_${status.index}").attr("src","/resources/img/noimage.gif");
			}else{ //이미지가 존재한다면
				var str="";
				$(arr).each(function(i, attach){
					console.log(attach.sort);
					if(attach.sort === "market"){ //마켓대표이미지중 하나를 위해서
						if(i == 0){ //여러번 호출 안되게 하기 위해
							str = encodeURIComponent(attach.uploadPath + "/marketMain_" + 
									attach.uuid + "_" + attach.imageName);
							console.log(str);
							return false; //jquery .each문에서의 break
						}	
					}
				});
				$("#marketMainImage_${status.index}").attr("src","/display?fileName="+str);
			}
		});
		</c:forEach>
		
		
	});
</script>




