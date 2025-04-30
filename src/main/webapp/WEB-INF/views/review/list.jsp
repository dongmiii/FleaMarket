<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../includes/header.jsp"%>
<!-- 후기 리스트 -->
<!--::breadcrumb part start::-->
<section class="breadcrumb breadcrumb_bg">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="breadcrumb_iner">
					<div class="breadcrumb_iner_item">
						<h1 style="font-family:나눔스퀘어_ac; color:orange;">FleaMarket Reviews</h1>
						<p style="font-family:나눔스퀘어_ac; color:white;">다녀온 후기와 함께 플리마켓에 관한 평점도 등록하세요</p>
						<a href="/review/form" class="btn_1">후기 작성 <span class="ti-angle-right"></span> </a>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<section class="team_member section_padding padding_less_40">
	<div class="container">
		<div class="row">
			<c:forEach items="${reviewList}" var="review" varStatus="status">
				<div class="col-sm-6 col-lg-3">
					<div class="single_team_member single-home-blog">
						<div class="card">
							<img src="" class="card-img-top" id="listImage_${status.index}" alt="" style="max-width: 100%; height: 200px;" />
							<div class="card-body">
								<div class="tean_content">
									<div class="blog_item_date">
										<h3><c:out value="${review.MLikes}"/></h3>
									</div> 
									<a href="<c:out value='${review.reviewNo}'/>" class="move">
										<h6 class="card-title" style="font-family:나눔스퀘어_ac;"><c:out value="${review.title}"/></h6>
									</a>
									<p><c:out value="${review.writer}"/></p>
								</div>
								<div class="tean_right_content">
									<p>조회수: <c:out value="${review.views}"/></p>
									<p>등록: <fmt:formatDate pattern="yy/MM/dd" value="${review.regDate}"/></p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
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
        	<form id="actionForm" action="/review/list" method="get">
        		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}"/>
        		<input type="hidden" name="amount" value="${pageMaker.cri.amount}"/>
        	</form>
        </div>
        </div>
		</div>
		</div>
	</div>
</section>

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

<script type="text/javascript">
	
	$(document).ready(function(){
		
		var reviewList = "<c:out value='${reviewList}'/>";
		var result = '<c:out value="${result}"/>'; //후기 등록완료 후 처리필요(writer 문자열 전달받음)
		var actionForm = $("#actionForm");
		
		checkModal(result); //먼저 모달을 띄우는데(result가 존재한다면)
		
		history.replaceState({},null,null); 
		
		function checkModal(result) {
			
			if(result === '' || history.state){
				return;
			}
			
			if(result == '후기등록'){
				$(".modal-body").html("후기가  등록되었습니다.");
			}else if(result == '후기수정'){
				$(".modal-body").html("후기가  수정되었습니다.");
			}else if(result == '후기삭제'){
				$(".modal-body").html("후기가  삭제되었습니다.");
			}
			$("#myModal").modal("show"); //화면에 모달창
		} 
		
		<c:forEach items="${reviewList}" var="reviewInfo" varStatus="status">
			//console.log("${reviewInfo.reviewNo}");
			
			$.getJSON("/review/getAttachList",{reviewNo:"${reviewInfo.reviewNo}"}, function(arr){
				//console.log(arr);
				if(Object.keys(arr).length === 0){ //이미지가 없다면
					//console.log("noimage.gif 보여줌");
					$("#listImage_${status.index}").attr("src","/resources/img/noimage.gif");
				}else{ //이미지가 존재한다면
					var str="";
					$(arr).each(function(i, attach){
						if(i == 0){ //여러번 호출 안되게하기 위해
							str = encodeURIComponent(attach.uploadPath + "/reviewMain_" + 
									attach.uuid + "_" + attach.imageName);
							return false;
						}
					});
					$("#listImage_${status.index}").attr("src","/display?fileName="+str);
				}
			});
		</c:forEach>
		
		$(".page-item a").on("click", function(e){
			e.preventDefault();
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		
		//각 게시글의 제목클릭시 게시글조회페이지로 이동하기 위한 클릭이벤트처리
		$(".move").on("click", function(e){
			e.preventDefault();
			actionForm.append("<input type='hidden' name='reviewNo' value='" + $(this).attr("href") + "'>");
			actionForm.attr("action", "/review/get");
			actionForm.submit();
		});
	
	});
	
	
</script>


<%@ include file="../includes/footer.jsp"%>




































