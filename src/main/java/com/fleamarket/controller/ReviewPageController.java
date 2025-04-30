package com.fleamarket.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import com.fleamarket.domain.Criteria;
import com.fleamarket.domain.ReviewVO;
import com.fleamarket.service.MarketService;
import com.fleamarket.service.ReviewService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ReviewPageController {
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private MarketService marketService;
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/review/get")
	public void goReviewPage(@RequestParam("reviewNo")long reviewNo, Model model, @ModelAttribute("cri")Criteria cri) {
		log.info("goReviewPage(@RequestParam(\"reviewNo\")long reviewNo, Model model, @ModelAttribute(\"cri\")Criteria cri)");
		reviewService.plusReviewViews(reviewNo);
		ReviewVO reviewVO= reviewService.getReview(reviewNo);
		model.addAttribute("review",reviewVO);
		model.addAttribute("market", marketService.getMarket(reviewVO.getMno()));
	}
	
	
}














