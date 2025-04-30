package com.fleamarket.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fleamarket.domain.Criteria;
import com.fleamarket.domain.PageDTO;
import com.fleamarket.domain.ReviewAttachVO;
import com.fleamarket.domain.ReviewVO;
import com.fleamarket.service.MarketService;
import com.fleamarket.service.ReviewService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ReviewListController {
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private MarketService marketService;
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/review/list")
	public void showReivewList(Criteria cri, Model model) {
		log.info("showReivewList(Model model)");
		int totalCount = reviewService.getTotalCount();
		List<ReviewVO> reviewList = reviewService.getList(cri);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("pageMaker", new PageDTO(cri,totalCount));
	}

	
	@GetMapping(value="/review/getAttachList", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<ReviewAttachVO>> getAttachList(Long reviewNo){
		log.info("getAttachList " + reviewNo);
		return new ResponseEntity<>(reviewService.getAttachList(reviewNo), HttpStatus.OK);
	}

}




















