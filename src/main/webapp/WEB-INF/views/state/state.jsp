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
						<h1 style="font-family:나눔스퀘어_ac; color:orange;">마켓 신청 현황페이지</h1>
						<p style="font-family:나눔스퀘어_ac; color:white;">마켓신청리스트 및 마켓신청현황</p>
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
							<th>마켓이름</th>
							<th>신청날짜</th>
							<th>등록날짜</th>
							<th>등록주최자명</th>
							<th>등록마켓대표번호</th>
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

<script>

$(document).ready(function(){
	

	var userId = "<c:out value='${userId}'/>"
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	//market 리스트 가져오는 함수(JSON목록을 호출)
	function getRegistMarketList(param, callback, error){
		var page = param.page || 1;
		$.getJSON("/manage/state/pages/" + page + "/" + userId +".json",
			function(data){
				if(callback){
					callback(data.marketCnt, data.list); //서버에서는 마켓 총 갯수와 해당 페이지의 마켓리스트를 가져옴
				}
			}).fail(function(xhr, status, err){
				alert(err);
			}
		);
	}
	
	var marketListArea = $(".marketListArea");
	showMarketList(1);
	
	function showMarketList(page){
		getRegistMarketList({page:page||1, userId:userId}, function(marketCnt, list){
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
				str += "<td><a href='/market/page?mno="+list[i].mno+"' data-oper='get'>"+list[i].mname+"</a></td>";
				str += "<td>"+date_to_str(new Date(list[i].mrequestDate))+"</td>";
				if(list[i].mregistDate != null){
					str += "<td>"+date_to_str(new Date(list[i].mregistDate))+"</td>";
				}else{
					str += "<td> -- </td>";
				}
				str += "<td>"+list[i].orgName+"</td>";
				str += "<td>"+list[i].mphone+"</td>";
				if(list[i].mpermit === '거부'){
					str += "<td>"+list[i].mpermit+" / <a class='genric-btn primary small' data-mno='"+list[i].mno+"' data-oper='showReason'>거부원인</a></td>";
				}else{
					str += "<td>"+list[i].mpermit+"</td>";	
				}
				str += "</tr>"
			}
			marketListArea.html(str);
			
			//페이징처리
			showPage(marketCnt,page,"marketTag");
			
		}); //end function
	}
	
	$(".marketListArea").on("click", "a", function(e){
		var oper=$(this).data("oper");
		if(oper != 'get'){ 
			e.preventDefault();
			var trName=$(this).closest("tr").attr("name");
			var mno = $(this).data("mno");
			$.ajax({
				type : "get",
				url : "/manage/state/"+mno,
				contentType : "application/json;charset=utf-8",
				success : function(result, status, xhr){
					
					var lastTrTag = $("tr[name="+trName+"]:last");
					var tempStr="";
					tempStr +="<tr class='rejectReasonTr'><td colspan='6'><textarea id='txtArea_"+trName+"' rows='4' cols='40'"
							+" style='width:100%; border:0;' disabled>"+result.reject+"</textarea><br/>"
							+"<button class='genric-btn primary small' onclick='cancelReject(\""+trName+"\");'"
							+"id='cancel_"+trName+"'>닫기</button></td></tr>";
					lastTrTag.after(tempStr);
					
				},
				error : function(xhr, status, err){
					if(err)
						console.log(err);
				}
			});
		}
		
	});
	
	var marketPageNum = 1;
	var marketPageTag = $("#marketPage");
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
	
	//마켓페이지 번호 클릭 이벤트 처리
	marketPageTag.on("click", "li a", function(e){
		e.preventDefault();
		marketPageNum = $(this).attr("href");
		console.log("targetPageNum: " + marketPageNum);
		showMarketList(marketPageNum);
	});
	
});

function cancelReject(trName){
	var str = "";
	var removeTag = $("button[id='cancel_"+trName+"']").closest("tr");
	removeTag.empty();
}
</script>

<%@ include file="../includes/footer.jsp" %>















