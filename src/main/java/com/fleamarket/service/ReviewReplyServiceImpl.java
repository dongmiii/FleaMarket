package com.fleamarket.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fleamarket.domain.Criteria;
import com.fleamarket.domain.ReviewReplyPageDTO;
import com.fleamarket.domain.ReviewReplyVO;
import com.fleamarket.mapper.ReviewReplyMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReviewReplyServiceImpl implements ReviewReplyService {
	
	@Autowired
	private ReviewReplyMapper reviewReplyMapper;
	
	
	@Override
	public int regist(ReviewReplyVO reviewReplyVO) {
		log.info("insertMReply(ReviewReplyVO reviewReplyVO)");
		
		return reviewReplyMapper.insert(reviewReplyVO);
	}

	@Override
	public ReviewReplyVO get(long replyNo) {
		log.info("getMReply(long replyNo)");
		return reviewReplyMapper.read(replyNo);
	}

	@Override
	public int modify(ReviewReplyVO reviewReplyVO) {
		log.info("updateMReply(MarketReplyVO marketReplyVO)");
		return reviewReplyMapper.update(reviewReplyVO);
	}

	@Override
	public int remove(long replyNo) {
		log.info("removeMReply(long replyNo)");
		return reviewReplyMapper.delete(replyNo);
	}

	@Override
	public List<ReviewReplyVO> getList(Criteria cri, long reviewNo) {
		return reviewReplyMapper.getListWithPaging(cri, reviewNo);
	}
	
	@Override
	public ReviewReplyPageDTO getListWithPaging(Criteria cri, long reviewNo) {
		return new ReviewReplyPageDTO(
				reviewReplyMapper.getCountByReviewNo(reviewNo),
				reviewReplyMapper.getListWithPaging(cri, reviewNo)
				);
	}
}
























