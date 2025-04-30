<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file="../includes/header.jsp"%>
<div class="comment-form">
	<h4 style="font-family:함초롬바탕 확장B;">공지사항 작성</h4>
	<c:choose>
	<c:when test="${notice ne null && notice ne ''}">
		<form class="form-contact comment_form" action="/notice/modify" id="commentForm" method="post">
		<input type="hidden" name="no" id="no" value="${notice.no}" />
	</c:when>
	<c:otherwise>
		<form class="form-contact comment_form" action="/notice/write" id="commentForm" method="post">
	</c:otherwise>
	</c:choose>
		<div class="row">
			<div class="col-sm-6">
				<div class="form-group">
					<input class="form-control" name="title" id="title" type="text" placeholder="Title" value="${notice.title}">
					<spring:hasBindErrors name="noticeVO">
						<c:if test="${errors.hasFieldErrors('title')}">                                     
               				<strong><c:out value="${errors.getFieldError('title').defaultMessage}"/></strong>
						</c:if>
					</spring:hasBindErrors> 
				</div>
			</div>
			<c:if test="${notice ne null && notice ne ''}">
				<ul class="blog-info-link mt-3 mb-4">
					<li><a href="#"><i class="far fa-user"></i> <c:out value="${notice.writer}"></c:out></a></li>
					<li><a href="#"><i class="far fa-comments"></i> <c:out value="${notice.updatedate}"></c:out> </a></li>
				</ul>
			</c:if>
			<div class="col-12">
				<div class="form-group">
					<textarea class="form-control w-100" name="content" id="content" cols="30" rows="9" placeholder="Write Content">${notice.content}</textarea>
					<spring:hasBindErrors name="noticeVO">
						<c:if test="${errors.hasFieldErrors('content')}">                                     
               				<strong><c:out value="${errors.getFieldError('content').defaultMessage}"/></strong>
						</c:if>
					</spring:hasBindErrors> 
				</div>
			</div>
		</div>
		<div class="form-group">
			<c:choose>
			<c:when test="${notice ne null && notice ne ''}">
				<sec:authorize access="hasAnyRole('ROLE_MASTER')">
					<button type="submit" class="button button-contactForm">글수정</button>
				</sec:authorize>
			</c:when>
			<c:otherwise>
				<sec:authorize access="hasAnyRole('ROLE_MASTER')">
					<button type="submit" class="button button-contactForm">글등록</button>
				</sec:authorize>
			</c:otherwise>
			</c:choose>
			<button type="reset" class="button button-contactForm">취소</button>
			<a href="/notice/notice" class="button button-contactForm">목록</a>
		</div>
		<input type="hidden" name="writer" value="<sec:authentication property='principal.username'/>" readonly="readonly">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	</form>
</div>
	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
	<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>

<%@ include file="../includes/footer.jsp"%>