package com.fleamarket.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fleamarket.domain.CriteriaUserId;
import com.fleamarket.domain.MarketPageDTO;
import com.fleamarket.domain.MarketVO;
import com.fleamarket.service.MarketService;
import com.fleamarket.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class StateController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MarketService marketService;
	
	@PreAuthorize("hasAnyRole('ROLE_ORGANIZER') AND isAuthenticated()")
	@GetMapping("/state/state")
	public void goStateList(Model model, Principal principal) {
		model.addAttribute("userId", principal.getName());
	}
	
	
	//주최자가 신청한 마켓에 대한 리스트를 부를때 
	@PreAuthorize("hasAnyRole('ROLE_ORGANIZER') AND isAuthenticated()")
	@GetMapping(value="/manage/state/pages/{page}/{userId}", produces= {MediaType.APPLICATION_JSON_UTF8_VALUE,MediaType.APPLICATION_XML_VALUE})
	@ResponseBody
	public ResponseEntity<MarketPageDTO> getMarketList(@PathVariable("page")int page,@PathVariable("userId")String userId){
		log.info("마켓 신청 현황 리스트 호출");
		CriteriaUserId cri = new CriteriaUserId(page, 10); //몇페이지, 페이지당 갯수
		cri.setUserId(userId);
		return new ResponseEntity<>(marketService.getRegistMarketList(cri), HttpStatus.OK);
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ORGANIZER') AND isAuthenticated()")
	@GetMapping(value="/manage/state/{mno}", produces= {MediaType.APPLICATION_JSON_UTF8_VALUE,MediaType.APPLICATION_XML_VALUE})
	@ResponseBody
	public ResponseEntity<MarketVO> getRejectReason(@PathVariable("mno")long mno){
		MarketVO marketVO = marketService.getMarket(mno);
		if(marketVO != null) {
			return new ResponseEntity<>(marketVO, HttpStatus.OK);
		}
		return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
























