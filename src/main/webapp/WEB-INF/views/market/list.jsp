<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../includes/header.jsp"%>


<section class="breadcrumb breadcrumb_bg">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="breadcrumb_iner">
					<div class="breadcrumb_iner_item">
						<h1 style="font-family:나눔스퀘어_ac; color:orange;">FleaMarket 모아보기</h1>
						<p style="font-family:나눔스퀘어_ac; color:white;">더 다양한 플리마켓들을 살펴보세요</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="blog_part section_padding">
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-xl-5">
				<div class="section_tittle text-center">
					<h4>Market List</h4>
				</div>
			</div>
		</div>
		
		<!-- 검색 -->
		<form class="form-inline" id="searchForm" action="/market/list" method="get">
			<h3 style="font-family:나눔스퀘어_ac;"><label class="my-1 mr-2">검색 : </label></h3>
  			<div class="form-row align-items-center">
    			<div class="col-auto my-1">
      				<select name="type" class="custom-select mr-1 mr-sm-2" id="inlineFormCustomSelect">
        				<option value="" <c:out value="${pageMaker.cri.type==null ? 'selected' : ''}"/>>---</option>
        				<option value="N" <c:out value="${pageMaker.cri.type eq 'N' ? 'selected' : ''}"/>>마켓이름</option><!-- 마켓 명 -->
        				<option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : ''}"/>>마켓내용</option><!-- 마켓 내용-->
        				<option value="L" <c:out value="${pageMaker.cri.type eq 'L' ? 'selected' : ''}"/>>마켓위치</option><!-- 마켓 위치 -->
        				<option value="NC" <c:out value="${pageMaker.cri.type eq 'NC' ? 'selected' : ''}"/>>마켓이름 or 마켓내용</option>
						<option value="NL" <c:out value="${pageMaker.cri.type eq 'NL' ? 'selected' : ''}"/>>마켓이름 or 마켓위치</option>
						<option value="NCL" <c:out value="${pageMaker.cri.type eq 'NCL' ? 'selected' : ''}"/>>이름 or 내용 or 위치</option>
      				</select>
    			</div>
    			<div class="col-auto my-1">
     	 			<input type="text" class="form-control" name="keyword" value="<c:out value='${pageMaker.cri.keyword}'/>"/>
    			</div>
    			<div class="col-auto my-1">
      				<button type="submit" data-oper="searchBtn" class="genric-btn primary">Search</button>
    			</div>
    			
  			</div>
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}"/>
			<input type="hidden" name="amount" value="${pageMaker.cri.amount}"/>
		</form>
		<div class="form-row align-items-center">
				<div class="col-auto my-1">
    				<button data-oper="rankingBtn" class="genric-btn success-border radius">Market Ranking</button>
    			</div>
    			<div class="col-auto my-1">
    				<button data-oper="openingBtn" class="genric-btn info-border radius">진행 중</button>
    			</div>
    			<div class="col-auto my-1">
    				<button data-oper="openbeforeBtn" class="genric-btn info-border radius">오픈 전</button>
    			</div>
    	</div>
		<div class="row">
			<!-- 반복 시작 -->
			<c:forEach items="${marketInfo}" var="market" varStatus="status">
				<div class="col-sm-6 col-lg-4 col-xl-4">
            		<div class="single-home-blog">
            	    	<div class="card">
            	        	<img src="" class="card-img-top" id="marketMainImage_${status.index}" 
            	        		alt="marketImage" style="max-width: 100%; height: 300px;"/>
            	            <div class="card-body">
            	            	<span class="dot"><c:out value="${market.MLocation}"/></span>
            	                <a href="${market.mno}" class="move">
            	                	<h5 class="card-title" style="font-family:나눔스퀘어_ac;">${market.MName}</h5>
            	                </a>
            	                <a href=""></a>
            	                <ul>
            	                	<li>
            	                	<span class="ti-info">
            	                		<jsp:useBean id="now" class="java.util.Date" />
                        				<fmt:formatDate pattern="yyyyMMddhhmm" value="${now}" var="nowDate"/>
										<fmt:formatDate pattern="yyyyMMddhhmm" value="${market.MStartDate}" var="startDate"/>
										<fmt:formatDate pattern="yyyyMMddhhmm" value="${market.MLastDate}" var="closeDate"/>
										<c:if test="${startDate <= nowDate && closeDate >= nowDate}">
											진행 중	
										</c:if>
										<c:if test="${startDate > nowDate}">
											오픈 전	
										</c:if>
										<c:if test="${closeDate < nowDate}">
											마감	
										</c:if>
            	                	</span>
            	                	</li>
            	                	<li><span class="ti-star">${market.MLikes}</span></li>
            	            	</ul>
            	        	</div>
            	    	</div>
            		</div>
        		</div>
        	</c:forEach>
        	<!-- 반복 끝 -->
		</div>
	</div>
</section>
<section class="blog_area">
<div class="container">
	<div class="row">
		<div class="col-lg-12 mb-5 mb-lg-0">
        	<div class="blog_left_sidebar">
				<!-- pagination -->
				<nav class="blog-pagination justify-content-center d-flex">
        	    	<ul class="pagination">
        	        	<c:if test="${pageMaker.prev}">
        	        		<li class="page-item">
        	        			<a href="${pageMaker.startPage-1}" class="page-link" aria-label="Previous">
        	        				<i class="ti-angle-left"></i>
        	        			</a>
        	        		</li>
        	        	</c:if> 
        	            <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
        	            	<li class='page-item ${pageMaker.cri.pageNum == num ? "active" : ""}'>
        	                      <a href="${num}" class="page-link">${num}</a>
        	                 </li>
        	            </c:forEach>     
        	            <c:if test="${pageMaker.next}">
        	            	<li class="page-item">
        	        			<a href="${pageMaker.endPage+1}" class="page-link" aria-label="Next">
        	        				<i class="ti-angle-right"></i>
        	        			</a>
        	        		</li>
        	            </c:if>
        	    	</ul>
        		</nav>
        		<!-- end pagination -->
        		
        		<form id="actionForm" action="/market/list" method="get">
        			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}"/>
        			<input type="hidden" name="amount" value="${pageMaker.cri.amount}"/>
        			<!-- 11/1 작성함 -->
        			<input type="hidden" name="type" value="<c:out value='${pageMaker.cri.type}'/>"/>
					<input type="hidden" name="keyword" value="<c:out value='${pageMaker.cri.keyword}'/>"/>
        		</form>
        		
        	</div>
        </div>
	</div>
</div>
</section>

<script type="text/javascript">

	$(document).ready(function(){
		<c:forEach items="${marketInfo}" var="marketTemp" varStatus="status">
			var mno = '<c:out value="${market.mno}"/>';
			$.getJSON("/market/getAttachList", {mno:"${marketTemp.mno}"}, function(arr) {
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
		
		var actionForm = $("#actionForm");
		var searchForm = $("#searchForm");
		
		$("#searchForm button").on("click", function(e){
			
			if(!searchForm.find("option:selected").val()){
				alert("검색종류를 선택하세요!");
				return false;
			}
			
			if(!searchForm.find("input[name='keyword']").val()){
				alert("키워드를 입력하세요!");
				return false;
			}
			
			searchForm.find("input[name='pageNum']").val("1"); //1페이지로 
			e.preventDefault();
			searchForm.submit();
		});
		
		$(".page-item a").on("click", function(e){
			e.preventDefault();
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		
		//각 글의 제목클릭시 마켓상세페이지로 이동하기 위한 클릭이벤트처리
		$(".move").on("click", function(e){
			e.preventDefault();
			actionForm.append("<input type='hidden' name='mno' value='" + $(this).attr("href") + "'>");
			actionForm.attr("action", "/market/page");
			actionForm.submit();
		});
		
		//랭킹,오픈전,오픈중,search버튼 클릭 시
		$(".col-auto").on("click", "button", function(e){
			e.preventDefault();
			var str="";
			var operBtn = $(this).data("oper");
			if(operBtn === 'searchBtn'){
				searchForm.submit();
			}else if(operBtn === 'rankingBtn'){//마켓의 점수로 
				actionForm.empty();
				str += "<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'/>";
				str += "<input type='hidden' name='amount' value='${pageMaker.cri.amount}'/>";
				str += "<input type='hidden' name='type' value='R'/>";
				actionForm.append(str); 
				actionForm.attr("action", "/market/rankingList");
				actionForm.submit();
			}else if(operBtn === 'openingBtn'){//오픈중인 마켓버튼
				actionForm.empty();
				str += "<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'/>";
				str += "<input type='hidden' name='amount' value='${pageMaker.cri.amount}'/>";
				str += "<input type='hidden' name='type' value='O'/>";
				actionForm.append(str);
				actionForm.submit();
			}else if(operBtn === 'openbeforeBtn'){//오픈전인 마켓 버튼
				actionForm.empty();
				str += "<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'/>";
				str += "<input type='hidden' name='amount' value='${pageMaker.cri.amount}'/>";
				str += "<input type='hidden' name='type' value='B'/>";
				actionForm.append(str);
				actionForm.submit();
			}
			
		});
		
	});
</script>

<%@ include file="../includes/footer.jsp"%>













