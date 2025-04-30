package com.fleamarket.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fleamarket.config.RootConfig;
import com.fleamarket.config.SecurityConfig;
import com.fleamarket.domain.ReviewReplyVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes= {RootConfig.class, SecurityConfig.class})
@Log4j
public class ReviewReplyServiceTests {
	
	@Autowired
	private ReviewReplyService service;
	
	private ReviewReplyVO reviewReplyVO;
	
	public ReviewReplyServiceTests() {
		this.reviewReplyVO = new ReviewReplyVO();
		reviewReplyVO.setReply("댓글내용");
		reviewReplyVO.setReplyer("testuser01");
	}
	
	//success
//	@Test
//	public void testInsertMReply() {
//		service.insertMReply(marketReplyVO);
//	}

	//success
//	@Test
//	public void testGetMReply() {
//		log.info(service.getMReply(3L));
//	}
	
	//success
//	@Test
//	public void testUpdateMReply() {
//		marketReplyVO.setReplyNo(4L);
//		marketReplyVO.setReply("댓글 수정됌1212");
//		if(service.updateMReply(marketReplyVO)) {
//			log.info("update success");
//		}else {
//			log.info("update failed");
//		}
//	}
	
	//success
//	@Test
//	public void testRemoveMReply() {
//		if(service.removeMReply(4L))
//			log.info("remove seuccess");
//		else
//			log.info("remove failed");
//	}
	
}





















