package com.fleamarket.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fleamarket.domain.MarketVO;
import com.fleamarket.service.MarketService;
import com.fleamarket.util.MarketVoValidator;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MarketRegistController {
	
	@Autowired
	private MarketService marketService;
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/market/registForm")
	public void goMarketRegistForm(Model model, Principal principal) {
		model.addAttribute("userId", principal.getName());
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/market/regist")
	public String marketRegist(MarketVO marketVO, Errors errors, RedirectAttributes rttr, Model model, Principal principal) {
		
		new MarketVoValidator().validate(marketVO, errors);
		if(errors.hasErrors()) {
			System.out.println(errors.getAllErrors());
			model.addAttribute("userId", principal.getName());
			return "market/registForm"; 
		}
		
		log.info("registMarket");
		log.info("==================================================================");
		log.info("regist: " + marketVO);
		if(marketVO.getMarketAttachList() != null) {
			marketVO.getMarketAttachList().forEach(vo->log.info(vo));
		}
		log.info("==================================================================");
		marketService.insertMarket(marketVO);
		rttr.addFlashAttribute("result", "마켓신청완료(운영자의 허락 시 메인페이지에 등업됩니다.)");
		return "redirect:/";
	}
	
}




















