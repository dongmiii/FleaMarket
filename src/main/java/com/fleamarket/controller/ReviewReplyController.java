package com.fleamarket.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.fleamarket.domain.Criteria;
import com.fleamarket.domain.ReviewReplyPageDTO;
import com.fleamarket.domain.ReviewReplyVO;
import com.fleamarket.service.ReviewReplyService;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/review/replies")
@Log4j
public class ReviewReplyController {
	
	@Autowired
	private ReviewReplyService reviewReplyService;
	
	//댓글 추가
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value="/new", consumes="application/json", produces= "text/plain;charset=UTF-8")
	public ResponseEntity<String> create(@RequestBody ReviewReplyVO vo){
		log.info("ReviewReplyVO: " + vo);
		int insertCount = reviewReplyService.regist(vo);
		log.info("Reply INSERT COUNT: " + insertCount);
		
		return insertCount == 1 ? new ResponseEntity<String>("댓글 등록 완료", HttpStatus.OK) 
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글 리스트가져오기
	@GetMapping(value="/pages/{reviewno}/{page}", produces= {MediaType.APPLICATION_JSON_UTF8_VALUE,MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<ReviewReplyPageDTO> getList(@PathVariable("reviewno")Long reviewNo, @PathVariable("page")int page){
		log.info("getList()... ");
		Criteria cri = new Criteria(page, 10); //몇페이지, 페이지당 갯수
		log.info(cri);
		return new ResponseEntity<>(reviewReplyService.getListWithPaging(cri, reviewNo), HttpStatus.OK);
	}
	
	//댓글 조회
	@GetMapping(value="/{replyno}", produces= {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<ReviewReplyVO> get(@PathVariable("replyno")Long replyNo){
		log.info("get: " + replyNo);
		return new ResponseEntity<>(reviewReplyService.get(replyNo), HttpStatus.OK);
	}
	
	//댓글 삭제
	@PreAuthorize("principal.username == #vo.replyer")
	@DeleteMapping(value="/{replyno}", produces= "text/plain;charset=UTF-8")
	public ResponseEntity<String> remove(@RequestBody ReviewReplyVO vo, @PathVariable("replyno")Long replyNo){
		
		log.info("remove: " + replyNo);
		log.info("replyer: " + vo.getReplyer());
		
		return reviewReplyService.remove(replyNo) == 1 ? new ResponseEntity<>("댓글 삭제 완료", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글 수정
	//@PreAuthorize("principal.username == #vo.replyer")
	@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH}, value="/{replyno}", consumes="application/json"
			, produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReviewReplyVO vo, @PathVariable("replyno")Long replyNo){
		vo.setReplyNo(replyNo);
		log.info("rno: " + replyNo);
		log.info("modify: " + vo);
		return reviewReplyService.modify(vo) == 1 ? new ResponseEntity<>("댓글 수정 완료", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}





















