/**
 * ReviewReply process module 
 */

console.log("reply module.......");

var reviewReplyService = (function(){
	
	//댓글 추가 함수(객체,콜백)
	//외부에서는 replyService.add(객체,콜백)를 전달하는 형태로 호출할 수 있는데, Ajax호출은 감춰져있기 때문에(=add함수안에 있기 때문에) 코드를 봄 더 깔끔하게 작설 할 수 있다.
	function add(reply, callback){
		console.log("reviewReply......");
		
		//success
		$.ajax({
			type : 'post',
			url : '/review/replies/new',
			data : JSON.stringify(reply), //The JSON.stringify() method converts a JavaScript object or value to a JSON string
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				alert(er);
			}
		});
	}
	
	//댓글 리스트 가져오는 함수(JSON목록을 호출) success
	function getList(param, callback, error){
		
		var reviewNo = param.reviewNo;
		var page = param.page || 1;
		
		$.getJSON("/review/replies/pages/" + reviewNo + "/" + page + ".json",
				function(data){
					if(callback){
						callback(data.reivewReplyCnt, data.list);
					}
				}).fail(function(xhr, status, err){
					alert(err);
				}
			);
	}
	
	//댓글 삭제
	function remove(replyNo, replyer, callback, error){
		$.ajax({
			type : 'delete',
			url : "/review/replies/" + replyNo,
			data : JSON.stringify({replyNo:replyNo, replyer:replyer}),
			contentType : "application/json; charset=utf-8",
			success : function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error : function(xhr, status, err){
				if(error){
					error(err);
				}
			}
		});
	}
	
	//댓글 수정
	function update(reply, callback, error){
		$.ajax({
			type : "put",
			url : "/review/replies/" + reply.replyNo,
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify(reply),
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, err){
				if(error){
					error(er);
				}
			}
		});
	}
	
	//댓글 조회
	function get(replyNo, callback, error){
		$.get("/review/replies/" + replyNo + ".json", function(result){
				if(callback){
					callback(result);
				}
			}).fail(function(xhr, status, err){
				if(error){
					error();
				}
			});
	}
	
	//댓글의 날짜가 오늘이면 시/분/초로 그전이면 년/월/일로 출력
	function displayTime(timeValue){
		
		var today = new Date();
		
		var gap = today - timeValue;
		
		var str="";
		var dateObj = new Date(timeValue);
		
		if(gap < 1000 * 60 * 60 * 24){ //오늘이라면
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [(hh > 9 ? '' : '0')+hh, ':', (mi > 9 ? '' : '0')+mi, ':', (ss > 9 ? '' : '0')+ss].join(''); 
		}else{
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth()+1; //getMonth() method is zero-based
			var dd = dateObj.getDate();
			
			return [yy, '/', (mm > 9 ? '' : '0')+mm, '/', (dd > 9 ? '' : '0')+dd].join('');
		}
		
	};
	
	return {
		add:add,
		getList:getList,
		remove:remove,
		update:update,
		get:get,
		displayTime:displayTime
	};
	
})();










