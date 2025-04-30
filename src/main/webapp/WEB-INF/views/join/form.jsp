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
					<h3 class="mb-30">FleaMarket 회원 가입</h3>
					<form action="/join/joinMember" method="post">
						<div class="mt-10">
							<input type="text" name="userid" placeholder="ID"
								onfocus="this.placeholder = ''"
								onblur="this.placeholder = 'ID'" 
								required
								class="single-input">
								<button class="genric-btn primary-border" id="confirmCheck">중복 확인</button>
						</div>
						<div class="mt-10">
							<input type="password" name="userpw" placeholder="비밀번호"
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
							<input type="password" name="confirmPw" placeholder="2차 비밀번호"
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
							<input type="text" name="userName" placeholder="이름"
								onfocus="this.placeholder = ''"
								onblur="this.placeholder = '이름'" 
								required
								class="single-input"/>
							<spring:hasBindErrors name="memberVO">
								<c:if test="${errors.hasFieldErrors('userName')}">                                     
               						<strong><c:out value="${errors.getFieldError('userName').defaultMessage}"/></strong>
								</c:if>
							</spring:hasBindErrors>
						</div>
						<div class="input-group-icon mt-3">
							<div class="icon"><i class="fa fa-globe" aria-hidden="true"></i></div>
							<div class="form-select" id="default-select">
								<select name="gender">
									<option value="X">성별</option>
									<option value="남">남</option>
									<option value="여">여</option>
								</select>
							</div>
						</div>
						<div class="mt-10">
							<spring:hasBindErrors name="memberVO">
								<c:if test="${errors.hasFieldErrors('gender')}">                                     
               						<strong><c:out value="${errors.getFieldError('gender').defaultMessage}"/></strong>
								</c:if>
							</spring:hasBindErrors>
						</div>
						<div class="mt-10">
							<input type="text" name="idenNum" placeholder="주민번호 앞 6자리"
								onfocus="this.placeholder = ''"
								onblur="this.placeholder = '주민번호 앞 6자리'"
								required
								class="single-input"/>
							<spring:hasBindErrors name="memberVO">
								<c:if test="${errors.hasFieldErrors('idenNum')}">                                     
               						<strong><c:out value="${errors.getFieldError('idenNum').defaultMessage}"/></strong>
								</c:if>
							</spring:hasBindErrors>
						</div>
						<div class="mt-10">
							<input type="text" name="phoneNum" placeholder="연락처(핸드폰번호)"
								onfocus="this.placeholder = ''"
								onblur="this.placeholder = '연락처(핸드폰번호 \'-\'없이)'"
								class="single-input"/>
							<spring:hasBindErrors name="memberVO">
								<c:if test="${errors.hasFieldErrors('phoneNum')}">                                     
               						<strong><c:out value="${errors.getFieldError('phoneNum').defaultMessage}"/></strong>
								</c:if>
							</spring:hasBindErrors>
						</div>
						<div class="section-top-border">
							<div class="button-group-area">
								<button class="genric-btn primary-border" id="registBtn">회원가입</button>
								<input type="reset" class="genric-btn primary-border" value="다시 작성">
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
		
		console.log("${code}");
		
		var formObj = $("form");
		var idDuplicateCheck = false;
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		//중복 확인 버튼 클릭 시 ajax처리
		$("#confirmCheck").on("click", function(e){
			var inputId = $("input[name='userid']").val();
			console.log(inputId);
			console.log("inputId: " + inputId);
			$.ajax({
				type : 'post',
				url : '/join/idDuplicateCheck',
				data : inputId,
				dataType : 'json',
				contentType : 'application/json; charset=utf-8',
				beforeSend : function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : function(data){
					if(data.count === 1){
						alert("id가 존재합니다 다른 id로 설정하세요");
						$("input[name='userid']").focus();
						idDuplicateCheck = false;
					}else{
						alert("사용 가능합니다");
						$("input[name='userpw']").focus();
						idDuplicateCheck = true;
					}
				},
				error : function(xhr, status, error){
					alert(error);
					console.log("error: " + error);
					console.log("status: " + status);
				}
			});
		});
		
		
		//회원가입 버튼 눌렀을 시 먼저 회원중복확인이 돼있어야 가능하게 처리
		$("#registBtn").on("click", function(e){
			
			e.preventDefault();
			
			if(!idDuplicateCheck){
				alert("id 중복확인을 해주세요");
				return;
			}
			formObj.submit();
		});
		
		
		
	}); //end ready()
</script>

<%@ include file="../includes/footer.jsp"%>





















