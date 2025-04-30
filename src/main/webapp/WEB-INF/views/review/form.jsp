<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ include file="../includes/header.jsp"%>

<!-- 다녀온 후기 입력 폼 -->
<div class="whole-wrap">
	<div class="container box_1170">
		<div class="section-top-border">
			<div class="row">
				<div class="col-lg-12 col-md-8">
					<h3 class="mb-30" style="font-family:나눔스퀘어_ac;">FleaMarket 후기등록</h3>
					<form role="form" action="/review/regist" method="post">
					<!-- 제목, 내용, 이미지 업로드 -->
					<div class="form-group">
						<div class="mt-10">
							<input type="text" name="title" placeholder="제목"
								onfocus="this.placeholder = ''"
								onblur="this.placeholder = '제목'" 
								required
								class="single-input form-control w-100"/>
							<spring:hasBindErrors name="reviewVO">
								<c:if test="${errors.hasFieldErrors('title')}">                                     
               						<strong><c:out value="${errors.getFieldError('title').defaultMessage}"/></strong>
								</c:if>
							</spring:hasBindErrors> 							
						</div>
					</div>
					<div class="form-group">
						<label>마켓 선택</label>
						<div class="form-select" id="default-select">
						<select name="mno">
							<option value="X">---</option>
							<c:forEach items="${marketList}" var="market">
								<option value="<c:out value='${market.mno}'/>"><c:out value="${market.MName}"/></option>
							</c:forEach>
						</select>	
						</div>
						<spring:hasBindErrors name="reviewVO">
							<c:if test="${errors.hasFieldErrors('mno')}">                                     
               					<strong><c:out value="${errors.getFieldError('mno').defaultMessage}"/></strong>
							</c:if>
						</spring:hasBindErrors> 
					</div>
					<div class="form-group">
						<label>평점</label>
						<div class="form-select" id="default-select">
							<select name="mLikes">
								<option value="X">---</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
							</select>	
						</div>
						<spring:hasBindErrors name="reviewVO">
							<c:if test="${errors.hasFieldErrors('mLikes')}">                                     
               					<strong><c:out value="${errors.getFieldError('mLikes').defaultMessage}"/></strong>
							</c:if>
						</spring:hasBindErrors> 
					</div>
					<div class="form-group">
						<div class="mt-10">
							<textarea name="content" placeholder="내용" rows="10"
								onfocus="this.placeholder = ''"
								onblur="this.placeholder = '내용'" 
								required
								class="single-input form-control w-100"></textarea>
						</div>
						<spring:hasBindErrors name="reviewVO">
							<c:if test="${errors.hasFieldErrors('content')}">                                     
               					<strong><c:out value="${errors.getFieldError('content').defaultMessage}"/></strong>
							</c:if>
						</spring:hasBindErrors> 
					</div>
					<div class="mt-10">
						<input type="text" name="writer" class="form-control" 
							value="<sec:authentication property='principal.username'/>" readonly="readonly">
					</div>
					<div class="section-top-border">
						<div class="button-group-area">
							<button type="submit" class="genric-btn primary-border" id="registBtn">후기 등록</button>
							<input type="reset" class="genric-btn primary-border" value="다시 작성">
							<!-- <button type="submit" class="genric-btn primary-border" id="backToList">목  록</button>  -->
						</div>
					</div>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					</form>
					<div class="panel panel-default">
					<h3 class="text-heading" style="font-family:나눔스퀘어_ac;">이미지 첨부</h3>
						<div class="panel-body">
							<div class="form-group uploadDiv">
								<input type="file" class="genric-btn primary-border" name="uploadFile" multiple />
							</div>
							<div class="uploadResult">
								<ul>
								<!-- 업로드된 파일들이 보여질 공간 -->
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>



<%@ include file="../includes/footer.jsp"%>

<script>
	$(document).ready(function(){
		
		var formObj = $("form[role='form']");
		var regex = new RegExp("(.*?)\.(jpg|gif|png|bmp)$");
		var maxSize = 5242880; //5MB
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		var cloneUploadDiv = $(".uploadDiv").clone();
		var uploadCount = 0;
		
		
		$("input[type='file']").change(function(e){
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']"); 
			var files = inputFile[0].files;
			for(var i=0; i<files.length; i++){
				console.log(files[i].name);
				if(!checkExtensionAndSize(files[i].name,files[i].size)){
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			formData.append("sort", "relatedReview");
			console.log(files);
			$.ajax({
				url: "/uploadAjaxAction",
				processData: false,
				contentType: false,
				data: formData,
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
				},
				type: "POST",
				dataType:"json",
				success: function(result){
					showUploadResult(result);
				}
			});
		});
		
		function showUploadResult(uploadResultArr){
			
			if(!uploadResultArr || uploadResultArr.length == 0){
				return;
			}
			
			var uploadUL = $(".uploadResult ul");
			var str="";
			
			$(uploadResultArr).each(function(i,obj){
				if(obj.image){ //이미지라면 섬네일 이미지를 보여주고 
					var thumbnailFile = encodeURIComponent(obj.uploadPath + "/s_" +  obj.uuid + "_" + obj.fileName);
					str += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid 
							+ "' data-filename='" + obj.fileName + "' data-type='" + obj.image +"'><div>";
					str += "<u>" + obj.fileName + "</u>";
					str += "<button type='button' class='genric-btn danger circle arrow small' data-file=\'" 
							+ thumbnailFile + "\' data-type='image'>";
					str += "X</button><br>";
					str += "<img src='/display?fileName=" + thumbnailFile + "'/>";
					str += "</div></li>";
				}
			});
			uploadUL.append(str);
		}
	
		
		$("button[type='submit']").on("click", function(e){
			e.preventDefault();
			var str="";
			$(".uploadResult ul li").each(function(i, obj){
				uploadCount += 1;
				var jObj = $(obj);
				str += "<input type='hidden' name='attachList["+i+"].imageName' value='" + jObj.data("filename") + "'/>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='" + jObj.data("uuid") + "'/>";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='" + jObj.data("path") + "'/>";
				//여기에 <input type='hidden' name='attachList["+i+"].reviewNo value='"+jObj.data("reviewno")+"'/>"; 가 필요없음
			});
			if(uploadCount === 0){ //이미지 업로드를 안했다면
				console.log("이미지 업로드 안함");
			}
			formObj.append(str).submit();
		});
		
		//업로드된 파일의 x버튼 클릭시 삭제처리하는 이벤트
		$(".uploadResult").on("click", "button", function(e){
			console.log("delete file");
			
			var targetFile = $(this).data("file");
			var type = $(this).data("type");
			var targetLi = $(this).closest("li");
			
			$.ajax({
				url: "/deleteFile",
				data: {fileName:targetFile, type:type},
				type: "POST",
				dataType: "text",
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
				},
				success: function(result){
					alert(result);
					targetLi.remove(); //li태그가 없어지면 input[type='file']이 change된 것이므로 다시 showUploadResult()함수를 실행시킴
				}
			});
		});
		
		function checkExtensionAndSize(fileName, fileSize){
			if(fileName > maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			if(!regex.test(fileName)){
				console.log(regex.test(fileName));
				alert("이미지 파일만 업로드 가능합니다.");
				return false;
			}
			return true;
		}
		
	});
</script>














