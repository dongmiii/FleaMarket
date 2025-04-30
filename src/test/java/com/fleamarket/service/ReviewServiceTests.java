package com.fleamarket.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fleamarket.config.RootConfig;
import com.fleamarket.config.SecurityConfig;
import com.fleamarket.domain.Criteria;
import com.fleamarket.domain.ReviewVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes= {RootConfig.class, SecurityConfig.class})
@Log4j
public class ReviewServiceTests {

	@Autowired
	private ReviewService service;
	
	private ReviewVO reviewVO;
	
	public ReviewServiceTests() {
		this.reviewVO = new ReviewVO();
		reviewVO.setTitle("테스트 제목2");
		reviewVO.setContent("테스트 내용2입니다");
		reviewVO.setWriter("testuser02");
	}
	
	//success
//	@Test
//	public void testInsertReview() {
//		service.insertReview(reviewVO);
//	}
	
	//success
//	@Test
//	public void testGetReview() {
//		log.info(service.getReview(3L));
//	}
	
	//success
//	@Test
//	public void testUpdateReview() {
//		reviewVO.setReviewNo(24L);
//		reviewVO.setTitle("hello world");
//		service.updateReview(reviewVO);
//	}
	
	//success
//	@Test
//	public void testGetList() {
//		service.getList().forEach(vo->log.info(vo));
//	}
	
	//success
//	@Test
//	public void testGetTotalCount() {
//		log.info(service.getTotalCount());
//	}
	
	//success
//	@Test
//	public void testRemoveReview() {
//		if(service.removeReview(3L)) {
//			log.info("remove success");
//		}else {
//			log.info("remove failed");
//		}
//		
//	}
	
//	@Test
//	public void testGetList() {
//		service.getList(new Criteria(1,10)).forEach(vo->log.info(vo));
//	}
	
}

















