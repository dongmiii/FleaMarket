<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ include file="../includes/header.jsp"%>

<!-- 다녀온 후기 입력 폼 -->
<sec:authentication property="principal" var="pinfo"/>
<div class="whole-wrap">
	<div class="container box_1170">
		<div class="section-top-border">
			<div class="row">
				<div class="col-lg-12 col-md-8">
				<h3 class="mb-30" style="font-family:나눔스퀘어_ac;">FleaMarket 후기수정</h3>
					<form role="form" action="/review/modify" method="post">
						<input type="hidden" name="reviewNo" value="<c:out value='${review.reviewNo}'/>"/>
						<div class="form-group">
							<div class="mt-10">
								<input type="text" name="title" placeholder="제목"
									onfocus="this.placeholder = ''"
									onblur="this.placeholder = '제목'" 
									required
									class="single-input form-control w-100"
									value="${review.title}"/>
								<!--<spring:hasBindErrors name="reviewVO">
									<c:if test="${errors.hasFieldErrors('title')}">                                     
               							<strong><c:out value="${errors.getFieldError('title').defaultMessage}"/></strong>
									</c:if>
								</spring:hasBindErrors> 
								-->
							</div>
						</div>
						<div class="form-group">
							<label>마켓 선택</label>
							<div class="form-select" id="default-select">
							<select name="mno">
								<option value="X">---</option>
								<c:forEach items="${marketList}" var="market">
									<option value="<c:out value='${market.mno}'/>"
										<c:if test="${review.mno eq market.mno}">selected</c:if>><c:out value="${market.MName}"/>
									</option>
								</c:forEach>
							</select>	
							</div>
							<!--<spring:hasBindErrors name="reviewVO">
									<c:if test="${errors.hasFieldErrors('title')}">                                     
               							<strong><c:out value="${errors.getFieldError('title').defaultMessage}"/></strong>
									</c:if>
								</spring:hasBindErrors> 
								-->
						</div>
						<div class="form-group">
							<label>평점</label>
							<div class="form-select" id="default-select">
								<select name="mLikes" disabled="disabled">
									<option value="X">---</option>
									<option value="1" <c:if test="${1 eq review.MLikes+0}">selected</c:if>>1</option>
									<option value="2" <c:if test="${2 eq review.MLikes+0}">selected</c:if>>2</option>
									<option value="3" <c:if test="${3 eq review.MLikes+0}">selected</c:if>>3</option>
									<option value="4" <c:if test="${4 eq review.MLikes+0}">selected</c:if>>4</option>
									<option value="5" <c:if test="${5 eq review.MLikes+0}">selected</c:if>>5</option>
								</select>	
							</div>
							<!--<spring:hasBindErrors name="reviewVO">
									<c:if test="${errors.hasFieldErrors('title')}">                                     
               							<strong><c:out value="${errors.getFieldError('title').defaultMessage}"/></strong>
									</c:if>
								</spring:hasBindErrors> 
								-->
						</div>
						<div class="form-group">
							<div class="mt-10">
								<textarea name="content" placeholder="내용" rows="10"
									onfocus="this.placeholder = ''"
									onblur="this.placeholder = '내용'" 
									required
									class="single-input form-control w-100">${review.content}</textarea>
							</div>
							<!--<spring:hasBindErrors name="reviewVO">
									<c:if test="${errors.hasFieldErrors('title')}">                                     
               							<strong><c:out value="${errors.getFieldError('title').defaultMessage}"/></strong>
									</c:if>
								</spring:hasBindErrors> 
								-->
						</div>
						<div class="mt-10">
							<input type="text" name="writer" class="form-control" 
								value="<sec:authentication property='principal.username'/>" readonly="readonly">
						</div>
						<div class="section-top-border">
							<div class="button-group-area">
								<sec:authorize access="isAuthenticated()">
									<c:if test="${review.writer eq pinfo.username}">
										<button type="submit" class="genric-btn primary-border" data-oper="modify">후기 수정</button>
										<button type="submit" class="genric-btn primary-border" data-oper="remove">후기 삭제</button>
									</c:if>
								</sec:authorize>
								<button type="submit" class="genric-btn primary-border" data-oper="backToPage">취  소</button>
							</div>
						</div>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					</form>
					<div class="panel panel-default">
					<h3 class="text-heading" style="font-family:나눔스퀘어_ac;">첨부된 이미지</h3>
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

<script type="text/javascript">
	
	$(document).ready(function(){
		(function(){
			//첨부파일목록 보여주는 작업
			var reviewNo = "<c:out value='${review.reviewNo}'/>";
			
			//getAttachList호출 시 ReviewAttachVO리스트가 옴
			$.getJSON("/review/getAttachList", {reviewNo:reviewNo}, function(arr){
				//console.log(arr);
				var str="";
				
				$(arr).each(function(i, obj){ 
					var thumbnailFile = encodeURIComponent(obj.uploadPath + "/s_" +  obj.uuid + "_" + obj.imageName);
					str += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid 
							+ "' data-filename='" + obj.imageName + "' data-type='true' data-reviewno='"+obj.reviewNo+"'><div>"; //data-type='true'를 작성해야함
					str += "<u>" + obj.imageName + "</u>";
					str += "<button type='button' class='genric-btn danger circle arrow small' data-file=\'" 
							+ thumbnailFile + "\' data-type='image'>";
					str += "X</button><br>";
					str += "<img src='/display?fileName=" + thumbnailFile + "'/>";
					str += "</div></li>";
				});
				$(".uploadResult ul").html(str);
			});
		})(); //즉시 실행함수 끝
		
		var reviewNo = "<c:out value='${review.reviewNo}'/>";
		var formObj = $("form[role='form']");
		var regex = new RegExp("(.*?)\.(jpg|gif|png|bmp)$");
		var maxSize = 5242880; //5MB
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		var cloneUploadDiv = $(".uploadDiv").clone();
		
		//이미지 파일 change
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
			// /uploadAjaxAction 호출 시 AttachFileDTO 리스트가 옴
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
		
		//x버튼 클릭시 화면에서 사라지는 작업
		$(".uploadResult").on("click", "button", function(e){
			if(confirm("지우시겠습니까?")){
				var targetLi = $(this).closest("li");
				targetLi.remove();
			}
		});
		
		
		//각 버튼 클릭 시 처리
		$("button").on("click", function(e){
			
			e.preventDefault(); //submit작동을 일단 못하게 막음
			
			var operation = $(this).data("oper");
			var no = "<c:out value='${review.reviewNo}'/>";
			console.log(operation);
			
			//remove버튼을 눌렀을 때 폼의 action을 변경
			if(operation === "remove"){
				var str = "";
				$(".uploadResult ul li").each(function(i, obj){
					var jobj = $(obj);
					console.dir(jobj);
					
					str += "<input type='hidden' name='attachList["+i+"].imageName' value='"+jobj.data("filename")+"'/>";
					str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'/>";
					str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'/>";
					str += "<input type='hidden' name='attachList["+i+"].reviewNo' value='"+jobj.data("reviewno")+"'/>";
				});
				formObj.append(str).attr("action", "/review/remove").submit();
			}else if(operation === "backToPage"){ //리스트가 아닌 후기 상세페이지로 이동
				formObj.attr("action", "/review/get?reviewNo="+reviewNo).attr("method", "GET");
		//		var pageNumTag = $("input[name='pageNum']").clone();
		//		var amountTag = $("input[name='amount']").clone();
		//		var typeTag = $("input[name='type']").clone();
		//		var keywordTag = $("input[name='keyword']").clone();
				
		//		formObj.empty(); //리스트로의 이동은 아무런 파라미터가 없기 때문에 <form>태그의 모든 내용은 삭제한 상태로 submit()을 진행한다.
				
				//목록페이지의 번호와 갯수를 추가함(위에서 empty()시켰기 때문에)
		//		formObj.append(pageNumTag); 
		//		formObj.append(amountTag);
		//		formObj.append(typeTag);
		//		formObj.append(keywordTag);
			}else if(operation === "modify"){
				console.log("modify clicked");
				var str = "";
				
				//수정할려는 업로드 데이터들 붙히기
				$(".uploadResult ul li").each(function(i, obj){
					var jobj = $(obj);
					console.dir(jobj);
					
					str += "<input type='hidden' name='attachList["+i+"].imageName' value='"+jobj.data("filename")+"'/>";
					str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'/>";
					str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'/>";
					str += "<input type='hidden' name='attachList["+i+"].reviewNo' value='"+jobj.data("reviewno")+"'/>";
				});
				formObj.append(str).submit();
			}
			formObj.submit();
		});



		//이미지 선택 후 보이는곳 렌더링
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
							+ "' data-filename='" + obj.fileName + "' data-type='" + obj.image 
							+"' data-reviewno='<c:out value='${review.reviewNo}'/>'><div>";
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

<%@ include file="../includes/footer.jsp"%>
























