package com.fleamarket.persistence;

import java.security.Security;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fleamarket.config.RootConfig;
import com.fleamarket.domain.Criteria;
import com.fleamarket.domain.ReviewVO;
import com.fleamarket.mapper.ReviewMapper;

import lombok.extern.log4j.Log4j;

//test할 때 RootConfig.class의 @ComponentScan(basePackages= {"com.fleamarket.service"}) 는 주석하고 테스트해야함
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes= {RootConfig.class, Security.class})
@Log4j
public class ReviewMapperTests {
	
	@Autowired
	private ReviewMapper mapper;
	
	private ReviewVO reviewVO;
	
	public ReviewMapperTests() {
		this.reviewVO = new ReviewVO();
		reviewVO.setTitle("제목3입니다.");
		reviewVO.setContent("내용3입니다");
		reviewVO.setWriter("tester3");
		reviewVO.setMLikes(5L);
		reviewVO.setMno(12L);
	}
	
	//success
//	@Test
//	public void testInsertSelecKey() {
//		mapper.insertSelectKey(reviewVO);
//	}
	
	//success
//	@Test
//	public void testRead() {
//		log.info(mapper.read(1L));
//	}
	
	//success
//	@Test
//	public void testUpdate() {
//		reviewVO.setReviewNo(1L);
//		reviewVO.setContent("테스트 수정된 내용");
//		mapper.update(reviewVO);
//	}
	
	//success
//	@Test
//	public void testGetList() {
//		mapper.getList().forEach(vo->log.info(vo));
//	}
	
	//success
//	@Test
//	public void testDelete() {
//		mapper.delete(1L);
//	}
	
	//success
//	@Test
//	public void testPaging() {
//		Criteria cri = new Criteria();
//		cri.setAmount(10);
//		cri.setPageNum(2);
//		List<ReviewVO> list = mapper.getList(cri);
//		list.forEach(vo->log.info(vo));
//	}
	
}































