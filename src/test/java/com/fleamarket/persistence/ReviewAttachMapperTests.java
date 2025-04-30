package com.fleamarket.persistence;

import java.security.Security;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fleamarket.config.RootConfig;
import com.fleamarket.domain.ReviewAttachVO;
import com.fleamarket.mapper.ReviewAttachMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes= {RootConfig.class, Security.class})
public class ReviewAttachMapperTests {
	
	@Autowired
	private ReviewAttachMapper mapper;
	
	private ReviewAttachVO vo;
	public ReviewAttachMapperTests() {
		this.vo = new ReviewAttachVO();
		vo.setImageName("test");
		vo.setReviewNo(7L);
		vo.setUploadPath("2019\\10\\02");
		vo.setUuid("tempUUID3");
	}
	
	//success
//	@Test
//	public void testInsert() {
//		mapper.insert(vo);
//	}
	
	//success
//	@Test
//	public void testFindByReviewNo() {
//		log.info(mapper.findByReviewNo(7L));
//	}
	
	//success
//	@Test
//	public void testDelete() {
//		int count = mapper.delete("tempUUID");
//		log.info("deleted count: " + count);
//	}
	
	//success
//	@Test
//	public void testDeleteAll() {
//		int count = mapper.deleteAll(7L);
//		log.info("deleted count: " + count);
//	}
	
	//success
//	@Test
//	public void testGetOldFiles() {
//		mapper.getOldFiles().forEach(vo->log.info(vo));
//	}
	
}



























