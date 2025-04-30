<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ include file="../includes/header.jsp"%>

<div class="whole-wrap">
	<div class="container box_1170">
		<div class="section-top-border">
			<div class="row">
				<div class="col-lg-12 col-md-8">
					<h3 class="mb-30" style="font-family:나눔스퀘어_ac;">FleaMarket MyPage</h3>
					<form action="/member/modify" method="post">
						<div class="mt-10">
							<input type="text" name="userid" 
								class="single-input"
								value="${member.userid}"
								readonly="readonly">
						</div>
						<div class="mt-10">
							<input type="password" name="userpw" placeholder="변경할 비밀번호"
								onfocus="this.placeholder = ''"
								onblur="this.placeholder = '비밀번호'" 
								required
								class="single-input"/>
							<spring:hasBindErrors name="memberVO">
								<c:if test="${errors.hasFieldErrors('userpw')}">                                     
               						<strong><c:out value="${errors.getFieldError('userpw').defaultMessage}"/></strong>
								</c:if>
							</spring:hasBindErrors>
						</div>
						<div class="mt-10">
							<input type="password" name="confirmPw" placeholder="변경된 2차 비밀번호"
								onfocus="this.placeholder = ''"
								onblur="this.placeholder = '2차 비밀번호'" 
								required
								class="single-input"/>
							<spring:hasBindErrors name="memberVO">
								<c:if test="${errors.hasFieldErrors('confirmPw')}">                                     
               						<strong><c:out value="${errors.getFieldError('confirmPw').defaultMessage}"/></strong>
								</c:if>
							</spring:hasBindErrors>
						</div>
						<div class="mt-10">
							<input type="text" name="userName" 
								class="single-input"
								value="${member.userName}"/>
						</div>
						<div class="mt-10">
							<input type="text" name="gender" 
								class="single-input" 
								value="${member.gender}"
								readonly="readonly"/>
						</div>
						<div class="mt-10">
							<input type="text" name="idenNum" 
								class="single-input"
								readonly="readonly"
								value="${member.idenNum}"/>
						</div>
						<div class="mt-10">
							<input type="text" name="phoneNum" placeholder="연락처(핸드폰번호)"
								onfocus="this.placeholder = ''"
								onblur="this.placeholder = '연락처(핸드폰번호 \'-\'없이)'"
								class="single-input"
								value ="${member.phoneNum}"/>
							<spring:hasBindErrors name="memberVO">
								<c:if test="${errors.hasFieldErrors('phoneNum')}">                                     
               						<strong><c:out value="${errors.getFieldError('phoneNum').defaultMessage}"/></strong>
								</c:if>
							</spring:hasBindErrors>
						</div>
						<div class="section-top-border">
							<div class="button-group-area">
								<button type="submit" class="genric-btn primary-border" data-oper="home" id="homeBtn">HOME</button>
								<button type="submit" class="genric-btn primary-border" data-oper="modify" id="modifyBtn">정보수정</button>
								
								<button type="submit" class="genric-btn primary-border" data-oper="withdrawal" id="withdrawalBtn">회원탈퇴</button>
							</div>
						</div>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		var formObj = $("form");
		
		$("button").on("click", function(e){
			e.preventDefault();
			var operation = $(this).data("oper");
			console.log(operation);
			
			if(operation === "home"){
				formObj.attr("action", "/").attr("method", "GET");
				formObj.empty();
			}else if(operation === "withdrawal"){
				formObj.attr("action", "/member/withdrawal").attr("method", "POST");
			}
			formObj.submit();
		});
	});
	
</script>


<%@ include file="../includes/footer.jsp"%>


































