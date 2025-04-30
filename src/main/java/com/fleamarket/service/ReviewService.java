package com.fleamarket.service;

import java.util.List;

import com.fleamarket.domain.Criteria;
import com.fleamarket.domain.ReviewAttachVO;
import com.fleamarket.domain.ReviewVO;

public interface ReviewService {
	

	public void insertReview(ReviewVO reviewVO);
	
	public ReviewVO getReview(long reviewNo);
	
	public boolean updateReview(ReviewVO reviewVO);
	
	public boolean removeReview(long reviewNo);
	
	public List<ReviewVO> getList(Criteria cri);
	
//	public int getTotal(Criteria cri);
	
	public int getTotalCount();
	
	public List<ReviewAttachVO> getAttachList(long reviewNo);
	
	public int plusReviewViews(long reviewNo);
}
