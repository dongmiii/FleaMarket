<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../includes/header.jsp"%>

<sec:authentication property="principal" var="pinfo"/>

<!--::breadcrumb part start::-->
<section class="breadcrumb breadcrumb_bg">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="breadcrumb_iner">
					<div class="breadcrumb_iner_item">
						<h1 style="font-family:나눔스퀘어_ac; color:orange;">FleaMarket 후기 Page</h1>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- 업로드한 이미지 나열 -->

<section class="social_connect_part">
	<div class="container-fluid">
		<div class="row justify-content-center">
			<div class="col-xl-5">
				<div class="section_tittle text-center">
            		<h4>REVIEW POST</h4>
            		<h2 style="font-family:나눔스퀘어_ac;">${review.title}</h2>
            	</div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12">
		 		<div class="row justify-content-center">
		 			<div class="col-xl-9">
		 			<hr/>
		 				<div class="section_tittle text-center">
            				<h4>REVIEW IMAGES</h4>
            			</div>
            			<div class="bigPictureWrapper">
							<div class="bigPicture">
								
							</div>
						</div>
		 				<div class="social_connect">
		 					<!-- 업로드한 이미지 자리 -->
		 				</div>
		 			</div>
		 		</div>
			</div>
		</div>
	</div>
</section>
<section class="blog_area single-post-area section_padding">
	<div class="container">
		<div class="row">         <!--       -->
			<div class="col-lg-12 mb-5 mb-lg-0 posts-list">
				<div class="single-post">
				<hr/>
					<div class="blog_details">
						<h2 style="font-family:나눔스퀘어_ac;">
							${review.writer}님께서 평가한 ${market.MName}의 점수는 ${review.MLikes}점 입니다.
						</h2>
						<ul class="blog-info-link mt-3 mb-4">
							<li><i class="far fa-user"></i> 작성자: ${review.writer}</li>
                    		<li><i class="far fa-comments"></i> 등록 날짜: <fmt:formatDate pattern="yy/MM/dd" value="${review.regDate}"/></li>
                      	</ul>
                      	<div class="quote-wrapper">
                        	<div class="quotes" style="white-space:pre-line;">
                           		${review.content}
                         	</div>
                        </div>
                        <div class="d-sm-flex justify-content-between text-center">
							<p class="like-info"><span class="align-middle"><i class="far fa-heart"></i></span> 
								조회수: ${review.views}</p>
						</div>
					</div>
				</div>
				<div class="navigation-top">
					<div class="navigation-area">
						<div class="row">
						<form id="actionForm" action="/review/list" method="GET">
							<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>"/>
							<input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>"/>
						<!--<input type="hidden" name="type" value="<c:out value='${pageMaker.cri.type}'/>"/>
							<input type="hidden" name="keyword" value="<c:out value='${pageMaker.cri.keyword}'/>"/>  -->
						</form>
							<div class="col-lg-3 col-md-6 col-12 nav-left flex-row d-flex justify-content-start align-items-center">
								<div class="thumb">
                                	<a href="/review/list">
                                 		<img class="img-fluid move" src="/resources/img/list.png" alt="" style='max-width: 100%; height: auto;'/>
                                 	</a>
                              	</div>
                              	<div class="arrow">
                                	<a href="/review/list">
                                 		<span class="lnr text-white ti-arrow-left move"></span>
                                 	</a>
                              	</div>
                              	<div class="detials">
                              		<!-- 페이징처리 해야함 -->
                                	<a href="/review/list" class="move">
                                    <h4 style="font-family:나눔스퀘어_ac;">목록으로</h4>
                                	</a>
                              	</div>
							</div>
							<sec:authorize access="isAuthenticated()">
								<c:if test="${review.writer eq pinfo.username}">
									<div class="col-lg-4 col-md-6 col-12 nav-left flex-row d-flex justify-content-start align-items-center">
										<div class="thumb">
                                			<a href="/review/modify?reviewNo=${review.reviewNo}">
                                 				<img class="img-fluid" src="/resources/img/modifyicon.png" alt="" style='max-width: 100%; height: auto;'/>
                                 			</a>
                              			</div>
                              			<div class="arrow">
                                			<a href="/review/modify?reviewNo=${review.reviewNo}">
                                 				<span class="lnr text-white  ti-pencil"/></span>
                                 			</a>
                              			</div>
                              			<div class="detials">
                                			<a href="/review/modify?reviewNo=${review.reviewNo}">
                                    			<h4 style="font-family:나눔스퀘어_ac;">후기 수정</h4>
                                 			</a>
                              			</div>
									</div>
								</c:if>
                        	</sec:authorize>
						</div>
					</div>
				</div>
				<div class="comments-area">
					<!-- 댓글 구간 -->
				</div>
				<!-- 댓글 페이징 구간 -->
				<div class="blog_left_sidebar">
					<nav class="blog-pagination justify-content-center d-flex">
            			<ul class="pagination">
                		    <!-- 숫자 페이지 공간 -->    		
            			</ul>
        			</nav>
				</div>
				<!-- 댓글 페이징 마무리 -->
				
				<!-- 댓글 입력 폼 -->
				<div class="comment-form">
                	<h4>Leave a Reply</h4>
                    <div class="form-contact comment_form" id="commentForm">
                    	<div class="row">
                        	<div class="col-12">
                            	<div class="form-group">
                                	<textarea class="form-control w-100" name="reply" id="comment" 
                                 				cols="30" rows="4" placeholder="Write Comment" required></textarea>
                              	</div>
                           	</div>
                           	<div class="col-sm-6">
                            	<div class="form-group">
                                	<input class="form-control" name="userid" id="userid" type="text" placeholder="Writer"
                                 					readonly="readonly" value="${pinfo.username}"/>
                              	</div>
                           	</div>
                        </div>
                        <div class="form-group">
                        	<button type="submit" id="replyBtn" class="button button-contactForm">댓글 등록</button>
                        </div>
                    </div>
            	</div>
			</div>
		</div>
	</div>
</section>
<script type="text/javascript" src="/resources/fleaMarket/js/reviewReply.js"></script>

<script>
	
$(".social_connect").on("click", "div", function(e){
	var obj = $(this);
	//div가 모두 위임받는 듯한 에러 발생(예외처리)
	if(obj.data("path") === undefined || obj.data("uuid") === undefined || obj.data("imagename") === undefined){
		return;
	}
	var path = encodeURIComponent(obj.data("path") + "/reviewDetail_" + obj.data("uuid") + "_" + obj.data("imagename"));
	console.log("callpath before replacing in get.jsp: " + path);
	showImage(path.replace(new RegExp(/\\/g), "/"));
});

$(".bigPictureWrapper").on("click",function(e){
	$(".bigPicture").animate({width:'0%', height:'0%'},1000);
	setTimeout(function(){
		$(".bigPictureWrapper").hide();
	},1000);
})

//원본이미지 보여주기
function showImage(fileCallPath){
	//alert(fileCallPath);
	
	$(".bigPictureWrapper").css("display", "flex").show();
	$(".bigPicture").html("<img src='/display?fileName=" + fileCallPath + "'/>").animate({width:'100%', height:'100%'},1000);
}
	
	//이미지 업로드 관련 로딩
	$(document).ready(function(){
		(function(){			
			var reviewNo = "<c:out value='${review.reviewNo}'/>";
			
			$.getJSON("/review/getAttachList", {reviewNo:reviewNo}, function(arr){
				//console.log(arr);
				var str="";
				
				$(arr).each(function(i, attach){
					str += "<div class='single-social_connect' data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+
					"' data-imagename='"+attach.imageName+"'>";
					str += "<div class='social_connect_img'>";
					var fileCallPath = encodeURIComponent(attach.uploadPath + "/reviewDetail_" + attach.uuid + "_" 
							+ attach.imageName);
					str += "<img src='/display?fileName="+fileCallPath+"' style='max-width: 100%; height: 200px;'/>";
					str += "<div class='social_connect_overlay'>";
					str += "<div><span class='ti-instagram'></span></div>";
					str += "</div></div></div>";
				});
				$(".social_connect").html(str);
			});	
		})();	
	});
	
	//리플 관련 코드
	$(document).ready(function(){
		
		
		var reviewValue = '<c:out value="${review.reviewNo}"/>';
		var actionForm = $("#actionForm");
		var commentArea = $(".comments-area");
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		var replyCount = 0;
		var loginUser;
		<sec:authorize access="isAuthenticated()">
			loginUser = '<sec:authentication property="principal.username"/>';
			console.log("login user: " + loginUser);
		</sec:authorize>
		
		$(document).ajaxSend(function(e, xhr, options){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});
		
		//목록버튼 클릭 시
		$(".move").on("click", function(e){
			e.preventDefault();
			actionForm.submit();
		});
		
		
		/*댓글 리스트 작업*/
		showList(1);
		
		function showList(page){
			reviewReplyService.getList({reviewNo:reviewValue,page:page||1}, function(replyCnt, list){
				replyCount = 0;
				console.log("replyCnt: " + replyCnt);
				console.log("list: " + list);
				console.log(list);
				
				if(page == -1){
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum); //마지막 페이지로 이동
					return;
				}
				
				var str="";
				if(list == null || list.length==0){
					commentArea.html("");
					return;
				}
				
				for(var i=0, len=list.length||0; i<len; i++){
					replyCount++;
					str += "<div class='comment-list'>";
					str += "<div class='single-comment justify-content-between d-flex'>";
					str += "<div class='user justify-content-between d-flex'>";
					str += "<div class='thumb'>"; 
					str += "<img src='/resources/img/usericon.jpg' alt='' style='max-width: 100%; height: auto;'>";
					str += "</div>";
					str += "<div class='desc'>";
					str += "<p class='comment'>";
					str += list[i].reply;
					str += "</p>";
					str += "<div class='d-flex justify-content-between'>";
					str += "<div class='d-flex align-items-center'>";
					str += "<p class='date'>";
					str += "작성자:" + list[i].replyer + "</p>";
					str += "<p class='date'>등록일:" + reviewReplyService.displayTime(list[i].replyDate) + "</p>";
					str += "</div>";
					<sec:authorize access='isAuthenticated()'>
						if(loginUser == list[i].replyer){
							str += "<div class='reply-btn'>";
							str += "<a href='' class='btn-reply text-uppercase' data-replyno='"+list[i].replyNo+"'>X</a></div>";	
						}
					</sec:authorize>
					str += "</div></div></div></div></div>";
				}
				commentArea.html(str);
				
				showReplyPage(replyCnt); //댓글 페이징 호출
				
			}); //end function
		}
		
		/* 댓글 페이지처리 */
		var replyPageNum = 1;
		var replyPageTag = $(".pagination");
		
		function showReplyPage(replyCnt){ //replyCnt는 댓글의 총 갯수
			var endNum = Math.ceil(replyPageNum / 10.0) * 10;
			var startNum = endNum - 9;
			
			var prev = startNum != 1;
			var next = false;
			
			if(endNum * 10 >= replyCnt){
				endNum = Math.ceil(replyCnt/10.0);
			}
			
			if(endNum * 10 < replyCnt){
				next = true;
			}
			
			var str = "";
			
			if(prev){
				str += "<li class='page-item'><a class='page-link' href='" + (startNum-1) + "' aria-label='Previous'>";
				str += "<i class='ti-angle-left'></i>";
				str += "</a></li>";
			}
			
			for(var i=startNum; i<=endNum; i++){
				var active = replyPageNum == i ? 'active' : '';
				str += "<li class='page-item " + active + "'><a class='page-link' href='" + i + "'>" + i + "</a></li>";
			}
			
			if(next){
				str += "<li class='page-item'><a class='page-link' href='" + (endNum+1) + "' aria-label='Next'>";
				str += "<i class='ti-angle-right'></i></a></li>";
			}
			replyPageTag.html(str);
		}
		
		//댓글페이지 클릭 시
		replyPageTag.on("click", "li a", function(e){
			
			e.preventDefault();
			
			replyPageNum = $(this).attr("href");
							
			console.log("targetPageNum: " + replyPageNum);
			showList(replyPageNum);
		});
		
		//댓글 등록 버튼 클릭 시
		$("#replyBtn").on("click", function(e){
			var commentForm = $(".comment_form");
			var comment = commentForm.find("textarea[name='reply']");
			var replyer = commentForm.find("input[name='userid']");
			console.log("댓글 내용:" + comment.val());
			console.log("댓글 작성자:" + replyer.val());
			e.preventDefault();
			//var content = $(".comment").val();
			var reply={
				reply:comment.val(),
				replyer:replyer.val(),
				reviewNo:reviewValue
			};
			reviewReplyService.add(reply, function(result){
				//alert(result);
				commentForm.find("textarea[name='reply']").val("");
				showList(-1); //댓글 조회 갱신
			});
		});
		
		//댓글 삭제 처리
		$(document).on("click", ".btn-reply", function(e){
			e.preventDefault();
			var rno = $(this).data("replyno");
			reviewReplyService.remove(rno, loginUser, function(result){
				alert(result);
				showList(1); //댓글 페이징 처리시 pageNum으로
			});
		});
		
		//댓글 수정 처리
		//아직 안함
		
		
		
	});
	
</script>



<%@ include file="../includes/footer.jsp"%>





















