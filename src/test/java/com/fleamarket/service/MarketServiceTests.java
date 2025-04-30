package com.fleamarket.service;

import java.util.Calendar;
import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fleamarket.config.RootConfig;
import com.fleamarket.config.SecurityConfig;
import com.fleamarket.domain.ReviewReplyVO;
import com.fleamarket.domain.MarketVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes= {RootConfig.class, SecurityConfig.class})
@Log4j
public class MarketServiceTests {

	@Autowired
	private MarketService marketService;
	
	private MarketVO marketVO;
	
	public MarketServiceTests() {
		this.marketVO = new MarketVO();
		marketVO.setMName("플리마켓입니다8");
		marketVO.setMEmail("kshyun@naver.com");
		marketVO.setMInfo("설명입니다8.");
		marketVO.setMCategory("cloths, bag & shoes");
		marketVO.setMExp("무");
		marketVO.setMPhone("01011547894");
		marketVO.setOrgName("김승현");
		marketVO.setMLikes(0L);
		marketVO.setMStartDate(new Date()); //오늘 날짜
		marketVO.setMLocation("경기도 안양시 만안구 안양천서로008");
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR , cal.getTime().getYear());
	    cal.set(Calendar.MONTH , cal.getTime().getMonth());
	    cal.set(Calendar.DAY_OF_WEEK , cal.getTime().getDay()+3);
		
		marketVO.setMLastDate(cal.getTime());
	}
	
	//success
//	@Test
//	public void testInsertMarket() {
//		marketService.insertMarket(marketVO);
//	}
	
	//success
//	@Test
//	public void testGetMarket() {
//		log.info(marketService.getMarket(8L));
//	}
	
	//success
//	@Test
//	public void testUpdateMarket() {
//		
//		marketVO.setMno(8L);
//		marketVO.setMName("플리마켓수정함");
//		marketVO.setMInfo("설명입니다(수정)");
//		marketVO.setMStartDate(new Date()); //오늘 날짜
//		marketVO.setMLocation("경기도 안양시 만안구 안양천서로314");
//		
//		Calendar cal = Calendar.getInstance();
//		cal.set(Calendar.YEAR , cal.getWeekYear());
//	    cal.set(Calendar.MONTH , cal.getTime().getMonth()+2);
//	    cal.set(Calendar.DAY_OF_WEEK , cal.getTime().getDay()+5);
//		
//		marketVO.setMLastDate(cal.getTime());
//		log.info(marketVO);
//		if(marketService.updateMarket(marketVO))
//			log.info("success");
//		
//	}
	
	//success
//	@Test
//	public void testDeleteMarket() {
//		if(marketService.deleteMarket(8L))
//			log.info("success");
//		else
//			log.info("fail");
//	}
	
	//success
//	@Test
//	public void testGetMarketList() {
//		marketService.getMarketList().forEach(vo->log.info(vo));
//	}
	
	
}





















