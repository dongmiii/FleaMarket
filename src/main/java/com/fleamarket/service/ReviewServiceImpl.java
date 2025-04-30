package com.fleamarket.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fleamarket.domain.Criteria;
import com.fleamarket.domain.MarketVO;
import com.fleamarket.domain.ReviewAttachVO;
import com.fleamarket.domain.ReviewVO;
import com.fleamarket.mapper.MarketMapper;
import com.fleamarket.mapper.ReviewAttachMapper;
import com.fleamarket.mapper.ReviewMapper;
import com.fleamarket.mapper.ReviewReplyMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	private ReviewMapper reviewMapper;
	
	@Autowired
	private ReviewAttachMapper reviewAttachMapper;
	
	@Autowired
	private MarketMapper marketMapper;
	
	@Autowired
	private ReviewReplyMapper reviewReplyMapper;
	
	@Transactional
	@Override
	public void insertReview(ReviewVO reviewVO) {
		log.info("insertReview(ReviewVO reviewVO)");
		reviewMapper.insertSelectKey(reviewVO);
		MarketVO marketVO = marketMapper.read(reviewVO.getMno());
		long likeScore = marketVO.getMLikes()+reviewVO.getMLikes();
		marketVO.setMLikes(likeScore);
		marketMapper.updateMarketLikes(marketVO);
		//이미지를 등록하지 않았다면
		if(reviewVO.getAttachList() == null || reviewVO.getAttachList().size() == 0) {
			return;
		}
		
		reviewVO.getAttachList().forEach((vo)->{
//			log.info("inserted reviewAttach: " + vo.getImageName());
			vo.setReviewNo(reviewVO.getReviewNo());
			reviewAttachMapper.insert(vo);
		});
	}

	@Override
	public ReviewVO getReview(long reviewNo) {
		log.info("getReview(long reviewNO)");
		return reviewMapper.read(reviewNo);
	}

	//문제 되는곳
	@Transactional(timeout=10)//테스트해봐야 하는 부분(해결 안됌)
	@Override
	public boolean updateReview(ReviewVO reviewVO) {
		log.info("updateReview(ReviewVO reviewVO)");
		int deletedCount = reviewAttachMapper.deleteAll(reviewVO.getReviewNo());
		log.info("deletedCount: " + deletedCount);
		boolean modifyResult = reviewMapper.update(reviewVO) == 1;
		if(modifyResult && reviewVO.getAttachList() != null && reviewVO.getAttachList().size() > 0) { 
			reviewVO.getAttachList().forEach(attachVO->{
				attachVO.setReviewNo(reviewVO.getReviewNo());
				reviewAttachMapper.insert(attachVO);
			});
		}
		return modifyResult;
	}

	@Transactional
	@Override
	public boolean removeReview(long reviewNo) {
		log.info("removeReview(long reviewNo)");
		ReviewVO reviewVO = reviewMapper.read(reviewNo);
		MarketVO marketVO = marketMapper.read(reviewVO.getMno());
		marketVO.setMLikes(marketVO.getMLikes()-reviewVO.getMLikes());
		marketMapper.updateMarketLikes(marketVO);
		reviewReplyMapper.deleteAll(reviewNo);
		reviewAttachMapper.deleteAll(reviewNo);
		boolean result = reviewMapper.delete(reviewNo) == 1;
		return result;
	}

	@Transactional
	@Override
	public List<ReviewVO> getList(Criteria cri) {
		log.info("getList()");
		List<ReviewVO> reviewList = reviewMapper.getList(cri);
		reviewList.forEach((vo)->{
			vo.setAttachList(reviewAttachMapper.findByReviewNo(vo.getReviewNo()));
		});
		return reviewList;
	}

	@Override
	public int getTotalCount() {
		log.info("getTotalCount()");
		return reviewMapper.getTotalCount();
	}
	
	@Override
	public List<ReviewAttachVO> getAttachList(long reviewNo){
		log.info("getAttachList()");
		return reviewAttachMapper.findByReviewNo(reviewNo);
	}
	
	@Override
	public int plusReviewViews(long reviewNo) {
		log.info("plusReviewViews(long reviewNo)");
		return reviewMapper.updateViews(reviewNo); 
	}
	
}


























