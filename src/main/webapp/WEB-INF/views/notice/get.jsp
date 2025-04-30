<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../includes/header.jsp"%>
      <!--::breadcrumb part start::-->
      <section class="breadcrumb breadcrumb_bg">
         <div class="container">
            <div class="row">
               <div class="col-lg-12">
                  <div class="breadcrumb_iner">
                     <div class="breadcrumb_iner_item">
                        <h1 style="font-family:나눔스퀘어_ac; color:orange;">NOTICE</h1>
                        <p style="font-family:나눔스퀘어_ac; color:white;">공지사항</p>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </section>
      <!--::breadcrumb part start::-->
      <!--================Blog Area =================-->
      <section class="blog_area single-post-area section_padding">
         <div class="container">
            <div class="row">
               <div class="col-lg-8 posts-list">
                  <div class="single-post">
                     <div class="blog_details">
                        <h2 style="font-family:나눔스퀘어_ac;"><c:out value="${notice.title}"></c:out>
                        </h2>
                        <ul class="blog-info-link mt-3 mb-4">
                           <li><a href="#"><i class="far fa-user"></i> 
                           <c:out value="${notice.writer}"></c:out></a></li>
                           <li><a href="#"><i class="far fa-comments"></i>
                           <c:out value="${notice.updatedate}"></c:out> </a></li>
                        </ul>
                        <p class="excert">
                        	<c:out value="${notice.content}"></c:out>
                        </p>
                     </div>
                  </div>
              </div>
          </div>
          	 <div class="button-group-area mt-40">
          	 	<sec:authorize access="hasAnyRole('ROLE_MASTER')">
	   				<a href="/notice/form?no=${notice.no}" class="genric-btn warning radius" data-oper='modify'>수정</a>
	   				<a href="/notice/delete?no=${notice.no}" class="genric-btn danger radius" data-oper='delete'>삭제</a>
   				</sec:authorize>
   				<a href="/notice/notice" class="genric-btn danger radius move" data-oper='list'>목록</a>
			</div>
       </div>
      </section>   
      
      <form id='operForm' action="/notice/form" method="get">
      	<input type='hidden' id='bno' name='bno' value='<c:out value="${notice.no}"/>'>
      	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
      	<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
      </form>

	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form");
			$('.move').on("click", function(e){
				e.preventDefault();
				var operation = $(this).data("oper");
				console.log(operation);
				if(operation === 'delete'){
					formObj.attr("action" , "/notice/delete");
				}else if(operation === 'list'){
					formObj.attr("action" , "/notice/notice").attr("method" , "get");
					var pageNumTag = $("input[name='pageNum']").clone();
					var amountTag = $("input[name='amount']").clone();
					
					formObj.empty();
					formObj.append(pageNumTag);
					formObj.append(amountTag);
				}else if(operation === 'modify'){
					formObj.attr("action" , "/notice/modify");
				}
				formObj.submit();
			});
		});
	</script>
<%@ include file="../includes/footer.jsp"%>