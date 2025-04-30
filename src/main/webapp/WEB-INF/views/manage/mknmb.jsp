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
						<h1 style="font-family:나눔스퀘어_ac; color:orange;">관리페이지</h1>
						<p style="font-family:나눔스퀘어_ac; color:white;">마켓관리<span>/</span>회원관리</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<div class="whole-wrap">
	<div class="container box_1170">
		<div class="section-top-border">
			<h3 class="mb-30" style="font-family:나눔스퀘어_ac;">마켓신청관리</h3>
			<div class="progress-table-wrap">
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>No.</th>
							<th>마켓이름</th>
							<th>신청날짜</th>
							<th>마켓주최자명</th>
							<th>마켓대표번호</th>
							<th>신청현황</th>
						</tr>
					</thead>
					<tbody class="marketListArea">
						
					</tbody>
				</table>
			</div>
			<nav class="blog-pagination justify-content-center d-flex">
				<ul class="pagination" id="marketPage">
					<!-- 페이징 처리할 곳 -->
				</ul>
			</nav>
		</div>	
	</div>
</div>


<div class="whole-wrap">
	<div class="container box_1170">
		<div class="section-top-border">
			<h3 class="mb-30" style="font-family:나눔스퀘어_ac;">회원관리</h3>
			<div class="progress-table-wrap">
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>회원ID</th>
							<th>회원명</th>
							<th>성별</th>
							<th>주민번호</th>
							<th>연락처</th>
							<th>가입날짜</th>
							<th>수정날짜</th>
							<th>탈퇴</th>
						</tr>
					</thead>
					<tbody class="marketMemberListArea">
						
					</tbody>
				</table>
			</div>
			<nav class="blog-pagination justify-content-center d-flex">
				<ul class="pagination" id="memberPage">
					<!-- 페이징 처리할 곳 -->
				</ul>
			</nav>
		</div>	
	</div>
</div>


<script type="text/javascript">
	
	$(document).ready(function(){
		
		//market 리스트 가져오는 함수(JSON목록을 호출)
		function getMarketList(param, callback, error){
			var page = param.page || 1;
			$.getJSON("/manage/market/pages/" + page + ".json",
				function(data){
					if(callback){
						callback(data.marketCnt, data.list); //서버에서는 마켓 총 갯수와 해당 페이지의 마켓리스트를 가져옴
					}
				}).fail(function(xhr, status, err){
					alert(err);
				}
			);
		}
		
		//member 리스트 가져오는 함수
		function getMemberList(param, callback, error){
			var page = param.page || 1;
			$.getJSON("/manage/member/pages/"+page+".json",
				function(data){
					if(callback){
						callback(data.memberCnt,data.list);
					}
				}).fail(function(xhr, status, err){
					alert(err);
				}
			);
		}
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		$(document).ajaxSend(function(e, xhr, options){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});
		
		function updateMarketRegist(mno,callback,error){
			$.ajax({
				type : "put",
				url : "/manage/market/agree/"+mno,
				contentType : "application/json;charset=utf-8",
				success : function(result, status, xhr){
					if(callback){
						callback(result);
					}
				},
				error : function(xhr, status, err){
					if(error){
						error(err);
					}
				}
			});
		}
		
		//--------------------------------------------------------------------
		/*마켓 리스트 작업*/
		var marketListArea = $(".marketListArea");
		showMarketList(1);
		
		function showMarketList(page){
			getMarketList({page:page||1}, function(marketCnt, list){
				if(page == -1){
					pageNum = Math.ceil(marketCnt/10.0);
					showMarketList(pageNum); //마지막 페이지로 이동
					return;
				}
				
				var str="";
				if(list == null || list.length==0){
					marketListArea.html("");
					return;
				}
				
				for(var i=0, len=list.length||0; i<len; i++){
					str += "<tr name='trTag_"+i+"'>";
					str += "<td>"+list[i].mno+"</td>";
					str += "<td><a href='/market/page?mno="+list[i].mno+"' data-oper='get'>"+list[i].mname+"</a></td>";
					str += "<td>"+date_to_str(new Date(list[i].mrequestDate))+"</td>";
					str += "<td>"+list[i].orgName+"</td>";
					str += "<td>"+list[i].mphone+"</td>";
					if(list[i].mpermit === '확인중'){  
						str += "<td><a href='"+list[i].mno+"' data-oper='agree' class='genric-btn primary small'>허락</a>&nbsp;"+
						"<a href='"+list[i].mno+"' data-oper='disagree' class='genric-btn primary small'>거절</a>&nbsp;"+
						"<a href='"+list[i].mno+"' data-oper='remove' class='genric-btn danger small'>삭제</a></td>";
					}else{
						str += "<td><b>"+list[i].mpermit+"</b></td>";
					}
					str += "</tr>";
				}
				marketListArea.html(str);
				
				//페이징처리
				showPage(marketCnt,page,"marketTag");
				
			}); //end function
		}
		
		//--------------------------------------------------------------------
		/*멤버 리스트 작업*/
		var memberListArea = $(".marketMemberListArea");
		showMemberList(1);
		
		function showMemberList(page){
			getMemberList({page:page||1}, function(memberCnt, list){
				console.log("memberCnt: " + memberCnt);
				console.log("list: " + list);
				console.log(list);
				if(page == -1){
					pageNum = Math.ceil(memberCnt/10.0);
					showMemberList(pageNum); //마지막 페이지로 이동
					return;
				}
				
				var str="";
				if(list == null || list.length==0){
					memberListArea.html("");
					return;
				}
				
				for(var i=0, len=list.length||0; i<len; i++){
					str += "<tr>";
					str += "<td><a href='/member/page?userid="+list[i].userid+"' data-oper='get'>"+list[i].userid+"</a></td>";
					str += "<td>"+list[i].userName+"</td>";
					str += "<td>"+list[i].gender+"</td>";
					str += "<td>"+list[i].idenNum+"</td>";
					str += "<td>"+list[i].phoneNum+"</td>";
					str += "<td>"+date_to_str(new Date(list[i].regDate))+"</td>";
					str += "<td>"+date_to_str(new Date(list[i].updateDate))+"</td>";
					str += "<td><a href='"+list[i].userid+"' class='genric-btn danger small' data-oper='withdrawal'>회원탈퇴</a></td>";
					str += "</tr>";
				}
				memberListArea.html(str);
			
				//페이징처리
				showPage(memberCnt,page,"memberTag");
				
			}); //end function
		}
		
		function date_to_str(format)
		{
		    var year = format.getFullYear();
		    var month = format.getMonth() + 1;
		    if(month<10) month = '0' + month;
		    var date = format.getDate();
		    if(date<10) date = '0' + date;
		    var hour = format.getHours();
		    if(hour<10) hour = '0' + hour;
		    var min = format.getMinutes();
		    if(min<10) min = '0' + min;
		    var sec = format.getSeconds();
		    if(sec<10) sec = '0' + sec;
		    return year + "/" + month + "/" + date + " " + hour + ":" + min + ":" + sec;
		}

		
		/* marketList 페이징처리 */
		var marketPageNum = 1;
		var memberPageNum = 1;
		var marketPageTag = $("#marketPage");
		var memberPageTag = $("#memberPage");
		
		function showPage(cnt, pageNum, tag){ 
			var endNum = Math.ceil(pageNum / 10.0) * 10;
			var startNum = endNum - 9;
			
			var prev = startNum != 1;
			var next = false;
			
			if(endNum * 10 >= cnt){
				endNum = Math.ceil(cnt/10.0);
			}
			
			if(endNum * 10 < cnt){
				next = true;
			}
			
			var str = "";
			
			if(prev){
				str += "<li class='page-item'>";
				str += "<a href='" + (startNum-1) + "' class='page-link' aria-label='Previous'>";
				str += "<i class='ti-angle-left'></i>";
				str += "</a></li>";
			}
			
			for(var i=startNum; i<=endNum; i++) {
				var active = pageNum == i ? 'active' : '';
				str += "<li class='page-item " + active + "'><a class='page-link' href='" + i + "'>" + i + "</a></li>";
			}
			
			if(next){
				str += "<li class='page-item'><a class='page-link' href='" + (endNum+1) + "' aria-label='Next'>";
				str += "<i class='ti-angle-right'></i></a></li>";
			}
			if(tag==='marketTag'){
				marketPageTag.html(str);	
			}else if(tag==='memberTag'){
				memberPageTag.html(str);
			}
			
		}
		
		//마켓페이지 번호 클릭 이벤트 처리
		marketPageTag.on("click", "li a", function(e){
			e.preventDefault();
			marketPageNum = $(this).attr("href");
			console.log("targetPageNum: " + marketPageNum);
			showMarketList(marketPageNum);
		});
		
		//회원페이지 번호 클릭 이벤트 처리
		memberPageTag.on("click", "li a", function(e){
			e.preventDefault();
			memberPageNum = $(this).attr("href");
			console.log("targetPageNum: " + memberPageNum);
			showMemberList(memberPageNum);
		});
		
		$(".marketListArea").on("click", "a", function(e){
			var oper=$(this).data("oper");
			var trName=$(this).closest("tr").attr("name");
			if(oper !='get'){ //마켓 정보를 보는것이 아니라면
				e.preventDefault();
				var mno = $(this).attr("href");
				if(oper==='agree'){
					$.ajax({
						type : "put",
						url : "/manage/market/agree/"+mno,
						contentType : "application/json;charset=utf-8",
						success : function(result, status, xhr){
							if(result === 'update success'){
								showMarketList(marketPageNum);
							}else{
								alert("내부 에러 발생"); 
							}
						},
						error : function(xhr, status, err){
							if(err){
								console.log(err);
							}
						}
					});
				}else if(oper==='remove'){
					$.ajax({
						type : "delete",
						url : "/manage/market/remove/"+mno,
						contentType : "application/json;charset=utf-8",
						success : function(result, status, xhr){
							if(result === 'remove success'){
								showMarketList(marketPageNum); 
							}else{
								alert("내부 에러 발생"); 
							}
						},
						error : function(xhr, status, err){
							if(err){
								console.log(err);
							}
						}
					});
				}else if(oper==='disagree'){ //거절 클릭한다면 거절한 이유를 작성하고 거절버튼클릭하도록
					
					var marketNo = $("tr[name="+trName+"] td").first().text();
					var lastTrTag = $("tr[name="+trName+"]:last");
					var tempStr="";
					tempStr +="<tr class='rejectTr'><td colspan='6'><textarea name='rejectReason' id='txtArea_"+trName+"' rows='4' cols='40' style='width:100%; border:0;'>이유 작성</textarea><br/>"
							+"<button class='genric-btn primary small' data-trname='"+trName+"' data-mno='"+marketNo+"'>처리</button>&nbsp;"
							+"<button class='genric-btn primary small' onclick='cancelReject(\""+trName+"\");'"
							+"id='cancel_"+trName+"'>입력취소</button></td></tr>";
					lastTrTag.after(tempStr); 
				}
			}
		});
		
		$(".marketMemberListArea").on("click", "a", function(e){
			var oper=$(this).data("oper");
			if(oper != 'get'){ //회원 탈퇴 처리
				e.preventDefault();	
				var userid = $(this).attr("href");
				$.ajax({
					type : "delete",
					url : "/manage/member/remove/"+userid,
					contentType : "application/json;charset=utf-8",
					success : function(result, status, xhr){
						if(result === 'remove success'){
							showMemberList(memberPageNum);
						}else{
							alert("내부 에러 발생"); 
						}
					},
					error : function(xhr, status, err){
						if(err)
							console.log(err);
					}
				});
			}
		});
		
		//거절 처리 버튼 클릭 시 수행
		$(".marketListArea").on("click", "tr button", function(e){
			var trName = $(this).data('trname');
			var marketNo = $(this).data('mno');
			var rejectText = $("textarea[id='txtArea_"+trName+"']").val();
			$.ajax({
				type : "put",
				url : "/manage/market/disagree/"+marketNo,
				data : rejectText,
				contentType : "application/json;charset=utf-8",
				success : function(result, status, xhr){
					if(result === 'update success'){
						showMarketList(marketPageNum); 
					}else{
						alert("내부 에러 발생"); 
					}
				},
				error : function(xhr, status, err){
					if(err){
						console.log(err);
					}
				}
			});
		});
	});
	
	function cancelReject(trName){
		var str = "";
		var removeTag = $("button[id='cancel_"+trName+"']").closest("tr");
		removeTag.empty();
	}
	
	
	

</script>


<%@ include file="../includes/footer.jsp"%>

















