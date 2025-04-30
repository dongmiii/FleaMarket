<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ include file="../includes/header.jsp"%>
<!-- 
	1.주최자 이메일(orgMail)
	2.마켓 이름(marketName)
	3.대표자 성명(orgName)
	4.대표자연락처(orgPhone)
	5.플리마켓 행사 경험 유/무(marketExp)
	6.카테고리(물품 분류)(category)
	7.마켓 소개(marketInfo)
	8.브랜드 대표이미지(3장으로 제한)(attachList)
	9.마켓에 판매될 아이템 이미지(8장으로 제한)(itemAttachList)
	
 -->
<div class="whole-wrap">
	<div class="container box_1170">
		<div class="section-top-border">
			<div class="row">
				<div class="col-lg-12 col-md-8">
					<h3 class="mb-30" style="font-family:나눔스퀘어_ac;">FleaMarket 신청</h3>
					<form role="form" action="/market/regist" method="post">
						<div class="col-lg-12">
						<div class="mt-10">
							<div class="form-group">
							<input type="text" name="mName" placeholder="마켓 이름"
								onfocus="this.placeholder = ''"
								onblur="this.placeholder = '마켓 이름'" 
								required
								class="single-input form-control"/>
							<spring:hasBindErrors name="marketVO">
								<c:if test="${errors.hasFieldErrors('mName')}">                                     
               						<strong><c:out value="${errors.getFieldError('mName').defaultMessage}"/></strong>
								</c:if>
							</spring:hasBindErrors> 
							 </div>	
						</div>
						</div>
						<div class="col-lg-12">
						<div class="mt-10">
							<div class="form-group">
							<input type="text" name="orgName" placeholder="주최자명"
								onfocus="this.placeholder = ''"
								onblur="this.placeholder = '주최자명'" 
								required
								class="single-input form-control"/>
							<spring:hasBindErrors name="marketVO">
								<c:if test="${errors.hasFieldErrors('orgName')}">                                     
               						<strong><c:out value="${errors.getFieldError('orgName').defaultMessage}"/></strong>
								</c:if>
							</spring:hasBindErrors>
							 </div>
						</div>
						</div>
						<div class="col-lg-12">
						<div class="mt-10">
							<div class="form-group">
							<input type="text" name="mEmail" placeholder="주최자 이메일"
								onfocus="this.placeholder = ''"
								onblur="this.placeholder = '주최자 이메일'" 
								required
								class="single-input form-control"/>
							<spring:hasBindErrors name="marketVO">
								<c:if test="${errors.hasFieldErrors('mEmail')}">                                     
               						<strong><c:out value="${errors.getFieldError('mEmail').defaultMessage}"/></strong>
								</c:if>
							</spring:hasBindErrors>
							 </div>
						</div>
						</div>
						<div class="col-lg-12">
						<div class="mt-10">
							<div class="form-group">
							<input type="text" name="mPhone" placeholder="주최자 연락처"
								onfocus="this.placeholder = ''"
								onblur="this.placeholder = '주최자 연락처'" 
								required
								class="single-input form-control"/>
							<spring:hasBindErrors name="marketVO">
								<c:if test="${errors.hasFieldErrors('mPhone')}">                                     
               						<strong><c:out value="${errors.getFieldError('mPhone').defaultMessage}"/></strong>
								</c:if>
							</spring:hasBindErrors>
							 </div>
						</div>
						</div>
						<div class="col-lg-12">
						<div class="mt-10 col-sm-6">
						<div class="form-group">
							<input type="text" name="mStartDate" placeholder="마켓 시작 날짜(년도/월/일)"
								onfocus="this.placeholder = ''"
								onblur="this.placeholder = '마켓 시작 날짜(년도/월/일)'" 
								required
								class="single-input form-control"/>
							<spring:hasBindErrors name="marketVO">
								<c:if test="${errors.hasFieldErrors('mStartDate')}">                                     
               						<strong><c:out value="${errors.getFieldError('mStartDate').defaultMessage}"/></strong>
								</c:if>
							</spring:hasBindErrors>
						</div>
						</div>
						<div class="mt-10 col-sm-6">
						<div class="form-group">
							<input type="text" name="mLastDate" placeholder="마켓 종료 날짜(년도/월/일)"
								onfocus="this.placeholder = ''"
								onblur="this.placeholder = '마켓 종료 날짜(년도/월/일)'" 
								required
								class="single-input form-control"/>
							<spring:hasBindErrors name="marketVO">
								<c:if test="${errors.hasFieldErrors('mLastDate')}">                                     
               						<strong><c:out value="${errors.getFieldError('mLastDate').defaultMessage}"/></strong>
								</c:if>
							</spring:hasBindErrors>
						</div>
						</div>
						</div>
						<div class="col-lg-12">
						<div class="input-group-icon mt-3">
							<label>플리마켓 행사 경험</label>
							<div class="form-select" id="default-select">
								<select name="mExp">
									<option value="X">---</option>
									<option value="유">유</option>
									<option value="무">무</option>
								</select>
							</div>
						</div>
						<div class="mt-10">
							<spring:hasBindErrors name="marketVO">
								<c:if test="${errors.hasFieldErrors('mExp')}">                                     
               						<strong><c:out value="${errors.getFieldError('mExp').defaultMessage}"/></strong>
								</c:if>
							</spring:hasBindErrors>
						</div>
						 </div>
						<div class="col-lg-5 single-element-widget mt-30">
							<h3 class="mb-30" style="font-family:나눔스퀘어_ac;">Category</h3>
							<div class="switch-wrap d-flex justify-content-between">
								<p>CLOTHS</p>
								<div class="primary-checkbox">
									<input type="checkbox" id="category1" name='categoryList' value='cloth'>
									<label for="category1"></label>
								</div>
							</div>
							<div class="switch-wrap d-flex justify-content-between">
								<p>BAG & SHOES</p>
								<div class="primary-checkbox">
									<input type="checkbox" id="category2" name='categoryList' value='bag&shoes'>
									<label for="category2"></label>
								</div>
							</div>
							<div class="switch-wrap d-flex justify-content-between">
								<p>ACC</p>
								<div class="primary-checkbox">
									<input type="checkbox" id="category3" name='categoryList' value='acc'>
									<label for="category3"></label>
								</div>
							</div>
							<div class="switch-wrap d-flex justify-content-between">
								<p>LIFE STYLE</p>
								<div class="primary-checkbox">
									<input type="checkbox" id="category4" name='categoryList' value='life style'>
									<label for="category4"></label>
								</div>
							</div>
							<div class="switch-wrap d-flex justify-content-between">
								<p>BEAUTY</p>
								<div class="primary-checkbox">
									<input type="checkbox" id="category5" name='categoryList' value='beauty'>
									<label for="category5"></label>
								</div>
							</div>
							<div class="switch-wrap d-flex justify-content-between">
								<p>FOOD & BEVERAGE</p>
								<div class="primary-checkbox">
									<input type="checkbox" id="category6" name='categoryList' value='food & beverage'>
									<label for="category6"></label>
								</div>
							</div>
							<div class="switch-wrap d-flex justify-content-between">
								<p>ART</p>
								<div class="primary-checkbox">
									<input type="checkbox" id="category7" name='categoryList' value='art'>
									<label for="category7"></label>
								</div>
							</div>
							<div class="switch-wrap d-flex justify-content-between">
								<p>기타</p>
								<div class="primary-checkbox">
									<input type="checkbox" id="category8" name='categoryList' value='기타'>
									<label for="category8"></label>
								</div>
							</div>
						</div>
						<spring:hasBindErrors name="marketVO">
							<c:if test="${errors.hasFieldErrors('mCategory')}">                                     
               					<strong><c:out value="${errors.getFieldError('mCategory').defaultMessage}"/></strong>
							</c:if>
						</spring:hasBindErrors>
						<div class="col-lg-12">
							<div class="mt-10">
								<div class="form-group">
									<label>도로명주소</label>
									<input type="text" id="sample4_postcode" placeholder="우편주소" 
												class="single-input form-control" readonly="readonly" value="">
									<label>도로명주소</label>
									<input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="mLocation"
												class="single-input form-control" readonly="readonly" value="">
								</div>
								<input type="button" id="addressBtn" class="genric-btn primary-border" value="주소 찾기">
							</div>
							<spring:hasBindErrors name="marketVO">
								<c:if test="${errors.hasFieldErrors('mLocation')}">                                     
               						<strong><c:out value="${errors.getFieldError('mLocation').defaultMessage}"/></strong>
								</c:if>
							</spring:hasBindErrors>
						</div>
						
						<div class="col-lg-12">
						<div class="mt-10">
							<textarea name="mInfo" 
							placeholder="마켓의 소개 및 홍보" 
							rows="10" 
							onfocus="this.placeholder = ''" 
							onblur="this.placeholder = '마켓의 소개 및 홍보'"  
							required 
							class="single-input form-control w-100"></textarea>
						</div>
						<spring:hasBindErrors name="marketVO">
								<c:if test="${errors.hasFieldErrors('mInfo')}">                                     
               						<strong><c:out value="${errors.getFieldError('mInfo').defaultMessage}"/></strong>
								</c:if>
							</spring:hasBindErrors> 
						</div>
						<div class="section-top-border">
							<div class="button-group-area">
								<button type="submit" class="genric-btn primary-border" data-oper="regist" id="registBtn">마켓신청</button>
								<input type="reset" class="genric-btn primary-border" value="다시 작성">
								<button type="submit" class="genric-btn primary-border" data-oper="back" id="backToMain">신청취소</button>
							</div>
						</div>
						<input type="hidden" name="userId" value="${userId}"/>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					</form>
					<div class="panel panel-default">
					<h3 class="text-heading">마켓 이미지첨부3장</h3>
						<div class="panel-body">
							<div class="form-group uploadMarketDiv">
								<input type="file" class="genric-btn primary-border" name="uploadMarketImage" multiple />
							</div>
							<div class="uploadMarketResult">
								<ul>
								<!-- 업로드될 마켓 이미지들이 보여질 공간 -->
								</ul>
							</div>
						</div> 
					</div>
					<div class="panel panel-default">
					<h3 class="text-heading">마켓에 판매될 물품 이미지 첨부</h3>
						<div class="panel-body">
							<div class="form-group uploadItemDiv">
								<input type="file" class="genric-btn primary-border" name="uploadItemImage" multiple />
							</div>
							<div class="uploadItemResult">
								<ul>
								<!-- 업로드될 마켓아이템들이 보여질 공간 -->
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
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$(document).ready(function(){
		
		var formObj = $("form[role='form']");
		var regex = new RegExp("(.*?)\.(jpg|gif|png|bmp)$");
		var maxSize = 5242880; //5MB
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		
		$("input[name='uploadMarketImage']").change(function(e){
			callAjaxImageUpload("input[name='uploadMarketImage']", "relatedMarket", "market");
		});
		
		$("input[name='uploadItemImage']").change(function(e){
			callAjaxImageUpload("input[name='uploadItemImage']", "relatedItem", "item");
		});
		
		function callAjaxImageUpload(inputTag, relatedStr, flag){
			var formData = new FormData();
			var inputFile = $(inputTag); 
			var files = inputFile[0].files;
			for(var i=0; i<files.length; i++){
				console.log(files[i].name);
				if(!checkExtensionAndSize(files[i].name,files[i].size)){
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			formData.append("sort", relatedStr); 
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
					showUploadResult(result, flag); 
				}
			});
		}
		
		function showUploadResult(uploadResultArr, divStr){
			
			var uploadUL = "";
			var str="";
			
			if(!uploadResultArr || uploadResultArr.length == 0){
				return;
			}
			
			if(divStr === "market"){
				uploadUL = $(".uploadMarketResult ul");	
			}else if(divStr === "item"){
				uploadUL = $(".uploadItemResult ul");
			}
			
			//obj는 AttachFileDTO가 전달옴(fileName, uploadPath, uuid, image(사진이냐아니냐))
			$(uploadResultArr).each(function(i,obj){
				if(obj.image){ //이미지라면 섬네일 이미지를 보여주고 
					var thumbnailFile = encodeURIComponent(obj.uploadPath + "/s_" +  obj.uuid + "_" + obj.fileName);
					str += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid 
							+ "' data-filename='" + obj.fileName + "' data-type='" + obj.image +"' data-sort='"+divStr+"'><div>";
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
		
		//submit작업
		$("button[type='submit']").on("click", function(e){
			e.preventDefault();
			if($(this).data("oper") === 'back'){
				self.location="/";
				return;
			}
			var str="";
			var uploadMarketImageCount = 0;
			var uploadItemImageCount = 0;
			var categoryListStr = "";
			
			//mCategory 전처리
			$('input:checkbox[name="categoryList"]:checked').each(function(index) {
				if(index === 0){
					categoryListStr += $(this).val();
				}else{
					categoryListStr+=", " + $(this).val();	
				}
 			});
			
			//i값 조정필요
			var liIndex = 0;
			$(".uploadMarketResult ul li").each(function(i, obj) {
				uploadMarketImageCount += 1;
				var jObj = $(obj);
				str += "<input type='hidden' name='marketAttachList["+i+"].imageName' value='" + jObj.data("filename") + "'/>";
				str += "<input type='hidden' name='marketAttachList["+i+"].uuid' value='" + jObj.data("uuid") + "'/>";
				str += "<input type='hidden' name='marketAttachList["+i+"].uploadPath' value='" + jObj.data("path") + "'/>";
				str += "<input type='hidden' name='marketAttachList["+i+"].sort' value='" + jObj.data("sort") + "'/>";
				liIndex=i;
				//여기에 <input type='hidden' name='attachList["+i+"].reviewNo value='"+jObj.data("reviewno")+"'/>"; 가 필요없음
			});
			if(uploadMarketImageCount != 3){ //이미지 업로드를 안했다면
				alert("마켓 관련 이미지를 3장 첨부해주세요");
				$(".uploadMarketResult ul li").each(function(i,obj){
					$(this).remove();
				});
				return;
			}
			
			var preLiIndex = ++liIndex;
			$(".uploadItemResult ul li").each(function(i, obj) {
				uploadItemImageCount += 1;
				var jObj = $(obj);
				str += "<input type='hidden' name='marketAttachList["+(liIndex+i)+"].imageName' value='" + jObj.data("filename") + "'/>";
				str += "<input type='hidden' name='marketAttachList["+(liIndex+i)+"].uuid' value='" + jObj.data("uuid") + "'/>";
				str += "<input type='hidden' name='marketAttachList["+(liIndex+i)+"].uploadPath' value='" + jObj.data("path") + "'/>";
				str += "<input type='hidden' name='marketAttachList["+(liIndex+i)+"].sort' value='" + jObj.data("sort") + "'/>";
				//여기에 <input type='hidden' name='attachList["+i+"].reviewNo value='"+jObj.data("reviewno")+"'/>"; 가 필요없음
			});
			if(uploadItemImageCount === 0){ //이미지 업로드를 안했다면
				alert("마켓에 판매될 물건 이미지를 첨부해주세요");
				liIndex = preLiIndex;
				return;
			}
			formObj.append(str);
			formObj.append("<input type='hidden' name='mCategory' value='"+categoryListStr+"'/>").submit();
		});
		
		
		//업로드된 파일의 x버튼 클릭시 삭제처리하는 이벤트
		$(".uploadMarketResult").on("click", "button", function(e){
			pushRemoveBtn($(this),"market");
		});
		
		//업로드된 파일의 x버튼 클릭시 삭제처리하는 이벤트
		$(".uploadItemResult").on("click", "button", function(e){
			pushRemoveBtn($(this),"item");
		});
		
		function pushRemoveBtn(thisStr,sortStr){
			console.log("delete file");
			
			var targetFile = thisStr.data("file");
			var type = thisStr.data("type");
			var targetLi = thisStr.closest("li");
			var sort = sortStr;
				
			$.ajax({
				url: "/deleteMarketFile",
				data: {fileName:targetFile, type:type, sort:sort},
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
		}
		
		
		$("#addressBtn").on("click", function(e){
			sample4_execDaumPostcode();
		});
		
		function sample4_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 참고 항목 변수

	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample4_postcode').value = data.zonecode;
	                document.getElementById("sample4_roadAddress").value = roadAddr;
	                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
	                
	                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
	                if(roadAddr !== ''){
	                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
	                } else {
	                    document.getElementById("sample4_extraAddress").value = '';
	                }

	                var guideTextBox = document.getElementById("guide");
	                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	                if(data.autoRoadAddress) {
	                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	                    guideTextBox.style.display = 'block';

	                } else if(data.autoJibunAddress) {
	                    var expJibunAddr = data.autoJibunAddress;
	                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	                    guideTextBox.style.display = 'block';
	                } else {
	                    guideTextBox.innerHTML = '';
	                    guideTextBox.style.display = 'none';
	                }
	            }
	            
	        }).open({
	        	autoClose:true,
	        	popupName:'postPopup',
	        	});
	        
	    }
	});
</script>


















