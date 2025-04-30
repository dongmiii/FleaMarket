package com.fleamarket.mapper;

import java.util.List;

import com.fleamarket.domain.ReviewAttachVO;

public interface ReviewAttachMapper {
	
	public void insert(ReviewAttachVO vo);
	
	public List<ReviewAttachVO> findByReviewNo(long reviewNo);
	
	public int delete(String uuid);
	
	public int deleteAll(long reviewNo);
	
	public List<ReviewAttachVO> getOldFiles();
}
