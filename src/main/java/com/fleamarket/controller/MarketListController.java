package com.fleamarket.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fleamarket.domain.MarketVO;
import com.fleamarket.domain.PageDTO;
import com.fleamarket.domain.SearchCriteria;
import com.fleamarket.service.MarketService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MarketListController {
	
	@Autowired
	private MarketService marketService;
	
	@GetMapping("/market/list")
	public void goMarketList(SearchCriteria cri, Model model) {
		List<MarketVO> marketList=null;
		int totalCount = marketService.getMarketTotalCount(cri);
		log.info("totalCount: " + totalCount);
		cri.setAmount(9); 
		log.info("type: " + cri.getType());
		log.info("keyword: " + cri.getKeyword());
		log.info("page: " + cri.getPageNum());
		log.info("amount: " + cri.getAmount());
		
		marketList = marketService.getMarketListWithPaging(cri); //등록순으로 출력
		
		model.addAttribute("marketInfo", marketList);
		model.addAttribute("pageMaker", new PageDTO(cri,totalCount));
	}
	
	
	@GetMapping("/market/rankingList")
	public String goMarketRankingList(SearchCriteria cri, Model model) {
		List<MarketVO> marketList=null;
		int totalCount = marketService.getMarketTotalCount(cri);
		cri.setAmount(9); 
		marketList = marketService.getMarketListWithRanking(cri); //랭킹순으로 출력
		model.addAttribute("marketInfo", marketList);
		model.addAttribute("pageMaker", new PageDTO(cri,totalCount));
		return "market/list";
	}
}





















