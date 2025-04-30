package com.fleamarket.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fleamarket.domain.MarketVO;
import com.fleamarket.domain.ReviewVO;
import com.fleamarket.service.MarketService;
import com.fleamarket.service.ReviewService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ReviewRegistController {
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private MarketService marketService;
	
	@GetMapping("/review/form")
	@PreAuthorize("isAuthenticated()")
	public void goForm(Model model) {
		log.info("goForm(Model model)");
		List<MarketVO> marketList = marketService.getMarketList();
		model.addAttribute("marketList", marketList);
	}
	
	@PostMapping("/review/regist")
	@PreAuthorize("isAuthenticated()")
	public String registReview(ReviewVO reviewVO, RedirectAttributes rttr) {
		log.info("registReview");
		log.info("==================================================================");
		log.info("registe: " + reviewVO);
		if(reviewVO.getAttachList() != null) {
			reviewVO.getAttachList().forEach(vo->log.info(vo));
		}
		log.info("==================================================================");
		reviewService.insertReview(reviewVO);
		rttr.addFlashAttribute("result", "후기등록");
		return "redirect:/review/list";
	}
	
}

















