package com.fleamarket.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fleamarket.domain.Criteria;
import com.fleamarket.domain.MarketPageDTO;
import com.fleamarket.domain.MarketVO;
import com.fleamarket.domain.MemberPageDTO;
import com.fleamarket.service.MarketService;
import com.fleamarket.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ManageController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MarketService marketService;
	
	@PreAuthorize("hasAnyRole('ROLE_MASTER')")
	@GetMapping("/manage/mknmb")
	public void goManageList() {
		
	}
	
	
	//마켓신청에서 허락 버튼 클릭 시
	@PreAuthorize("hasAnyRole('ROLE_MASTER')")
	@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH}, value="/manage/market/agree/{mno}",
		produces= {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> processMarketAgree(@PathVariable("mno")long mno){
		log.info("마켓 신청의 허락을 진행함");
		MarketVO marketVO = marketService.getMarket(mno);
		marketVO.setMPermit("허락");
		if(marketService.updatePermit(marketVO)){
			if(marketService.updateRegistDate(marketVO)){
				return new ResponseEntity<>("update success", HttpStatus.OK);
			}
		}
		return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//마켓 거부 처리
	@PreAuthorize("hasAnyRole('ROLE_MASTER')")
	@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH}, value="/manage/market/disagree/{mno}", 
					consumes= "application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> processMarketDisAgree(@PathVariable("mno")long mno, @RequestBody String rejectReason){
		log.info("마켓 신청의 거부 진행함");
		MarketVO marketVO = marketService.getMarket(mno);
		marketVO.setMPermit("거부");
		marketVO.setReject(rejectReason);
		if(marketService.updatePermit(marketVO)){
			if(marketService.updateRegistDate(marketVO)){
				return new ResponseEntity<>("update success", HttpStatus.OK);
			}
		}
		return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PreAuthorize("hasAnyRole('ROLE_MASTER')")
	@GetMapping(value="/manage/market/pages/{page}", produces= {MediaType.APPLICATION_JSON_UTF8_VALUE,MediaType.APPLICATION_XML_VALUE})
	@ResponseBody
	public ResponseEntity<MarketPageDTO> getMarketList(@PathVariable("page")int page){
		log.info("getMarketList()... ");
		Criteria cri = new Criteria(page, 10); //몇페이지, 페이지당 갯수
		log.info(cri);
		return new ResponseEntity<>(marketService.getMarketListWithCriPaging(cri), HttpStatus.OK);
	}
	
	@PreAuthorize("hasAnyRole('ROLE_MASTER')")
	@GetMapping(value="/manage/member/pages/{page}", produces= {MediaType.APPLICATION_JSON_UTF8_VALUE,MediaType.APPLICATION_XML_VALUE})
	@ResponseBody
	public ResponseEntity<MemberPageDTO> getMemberList(@PathVariable("page")int page){
		log.info("getMemberList()... ");
		Criteria cri = new Criteria(page, 10); //몇페이지, 페이지당 갯수
		log.info(cri);
		return new ResponseEntity<>(memberService.getMemberList(cri), HttpStatus.OK);
	}
	
	@PreAuthorize("hasAnyRole('ROLE_MASTER')")
	@DeleteMapping(value="/manage/market/remove/{mno}", produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("mno")Long mno){
		
		log.info("remove: " + mno);
		if(marketService.deleteMarket(mno)) {
			return new ResponseEntity<>("remove success", HttpStatus.OK);
		}
		return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}





















