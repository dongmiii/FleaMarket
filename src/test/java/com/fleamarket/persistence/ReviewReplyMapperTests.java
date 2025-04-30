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
import com.fleamarket.domain.ReviewReplyVO;
import com.fleamarket.mapper.ReviewReplyMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes= {RootConfig.class, Security.class})
@Log4j
public class ReviewReplyMapperTests {
	
	@Autowired
	private ReviewReplyMapper reviewMapper;
	
	//success
//	@Test
//	public void testMapperExists() {
//		log.info(mapper);
//	}
	
	//success
//	@Test
//	public void testInsertReply() {
//		IntStream.rangeClosed(1,5).forEach(i->{
//			ReviewReplyVO reply = new ReviewReplyVO();
//			
//			reply.setReviewNo(35L);
//			reply.setReply("댓글 테스트" + i);
//			reply.setReplyer("replyer" + i);
//			
//			reviewMapper.insertSelectKey(reply);
//		});
//	}
	
	//success
//	@Test
//	public void testReadingReply() {
//		log.info(reviewMapper.read(4L));
//	}
	
	//success
//	@Test
//	public void testUpdatingReply() {
//		Long targetReplyNo = 5L;
//		ReviewReplyVO vo = reviewMapper.read(targetReplyNo);
//		vo.setReply("Updated Reply");
//		int count = reviewMapper.update(vo);
//		log.info("Update Count: " + count);
//	}
	
	//success
//	@Test
//	public void testDeletingReply() {
//		log.info(reviewMapper.delete(4L));
//	}

	
	//댓글 페이징 구현 아직 안함(테스트 안함)
	//success
//	@Test
//	public void testList() {
//	Criteria cri = new Criteria();
//	List<ReviewReplyVO> replies = reviewMapper.getListWithPaging(cri, 35);
//	replies.forEach(vo->log.info(vo));
//	}
	
	
	
}












