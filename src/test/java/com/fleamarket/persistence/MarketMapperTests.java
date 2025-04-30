package com.fleamarket.persistence;

import java.security.Security;
import java.util.Calendar;
import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fleamarket.common.FinalString;
import com.fleamarket.config.RootConfig;
import com.fleamarket.domain.MarketVO;
import com.fleamarket.mapper.MarketMapper;

import lombok.extern.log4j.Log4j;

//test할 때 RootConfig.class의 @ComponentScan(basePackages= {"com.fleamarket.service"}) 는 주석하고 테스트해야함
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes= {RootConfig.class, Security.class})
@Log4j
public class MarketMapperTests {
	
	@Autowired
	private MarketMapper marketMapper;
	
	
	//#{mName}, #{mInfo}, #{mStartDate}, #{mLastDate}, #{mLocation}
//	public MarketMapperTests() {
//		
//	}
	
	//success
//	@Test
//	public void testInsert() {
//		
//		MarketVO marketVO = new MarketVO();
//		marketVO.setMName("플리마켓 222");
//		marketVO.setMInfo("설명1010.");
//		marketVO.setMEmail("kshyun@naver.com");
//		marketVO.setMCategory("cloths, bag & shoes");
//		marketVO.setMExp("유");
//		marketVO.setMPhone("01014223538");
//		marketVO.setMStartDate(new Date()); //오늘 날짜
//		marketVO.setMLocation("경기도 안양시 만안구 안양천서로311");
//		
//		Calendar cal = Calendar.getInstance();
//		cal.set(Calendar.YEAR , cal.getTime().getYear());
//	    cal.set(Calendar.MONTH , cal.getTime().getMonth());
//	    cal.set(Calendar.DAY_OF_WEEK , cal.getTime().getDay()+3);
//		
//	    marketVO.setMLastDate(cal.getTime());
//	    marketVO.setMLikes(0L);
//	    marketVO.setOrgName("김승현");
//		
//		marketMapper.insertSelectKey(marketVO);
//	}
	
	//success
//	@Test
//	public void testRead() {
//		log.info(marketMapper.read(7L));
//	}
	
	
	//success
//	@Test
//	public void testUpdate() {
//		
//		MarketVO marketVO = new MarketVO();
//		marketVO.setMno(7L);
//		marketVO.setMName("수정플리마캣");
//		marketVO.setMInfo("설명입니다2.");
//		marketVO.setMStartDate(new Date()); //오늘 날짜
//		marketVO.setMLocation("경기도 안양시 만안구 안양천서로311");
//		marketVO.setMEmail("kshyun12@naver.com");
//		marketVO.setMPhone("01011112222");
//		marketVO.setMCategory("cloths, bag & shoes");
//		marketVO.setMExp("유");
//		marketVO.setOrgName("김승여");
//		Calendar cal = Calendar.getInstance();
//		cal.set(Calendar.YEAR , cal.getTime().getYear());
//	    cal.set(Calendar.MONTH , cal.getTime().getMonth());
//	    cal.set(Calendar.DAY_OF_WEEK , cal.getTime().getDay()+3);
//		marketVO.setMLastDate(cal.getTime());
//		int count = marketMapper.update(marketVO); 
//		
//		if(count==1) {
//			log.info("updated Count: " + count);
//		}
//	}
	
	//success
//	@Test
//	public void testDelete() {
//		int count = marketMapper.delete(7L);
//		log.info("deleted Count: " + count);
//	}
	
	//success
//	@Test
//	public void testUpdateMarketLikes() {
//		MarketVO marketVO = new MarketVO();
//		marketVO.setMno(8L);
//		marketVO.setMLikes(3L);
//		
//		marketMapper.updateMarketLikes(marketVO);
//	}
	
	//success
//	@Test
//	public void testGetList() {
//		marketMapper.getList().forEach(vo->log.info(vo));
//	}
	
	//success
//	@Test
//	public void testUpdatePermit() {
//		MarketVO marketVO = new MarketVO();
//		marketVO.setMno(35L);
//		marketVO.setMPermit(FinalString.PERMIT_AGREE);
//		marketMapper.updatePermit(marketVO);
//	}
}




























