package com.fleamarket.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fleamarket.domain.MarketAttachVO;
import com.fleamarket.service.MarketService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class HomeController {
	
	@Autowired
	private MarketService marketService;
	
	@GetMapping(value = "/")
	public String home(Model model) {
		log.info("Welcome home!");
		model.addAttribute("marketInfo", marketService.getMarketList());
		return "index";
	}
	
//	@GetMapping(value="/market/getAttachList", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
//	@ResponseBody
//	public ResponseEntity<List<MarketAttachVO>> getAttachList(Long mno){
//		log.info("getAttachList " + mno);
//		return new ResponseEntity<>(marketService.getAttachList(mno), HttpStatus.OK);
//	}
	
}


























