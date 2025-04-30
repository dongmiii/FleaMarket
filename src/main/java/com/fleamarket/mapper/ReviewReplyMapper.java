package com.fleamarket.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.fleamarket.domain.Criteria;
import com.fleamarket.domain.ReviewReplyVO;


public interface ReviewReplyMapper {
	
	public int insert(ReviewReplyVO reviewReplyVO);
	
	public ReviewReplyVO read(long replyNo);
	
	public int update(ReviewReplyVO reviewReplyVO);
	
	public int delete(long replyNo);
	
	public List<ReviewReplyVO> getListWithPaging(@Param("cri")Criteria cri, @Param("reviewNo")long reviewNo);	
	
	public int getCountByReviewNo(long reviewNo);
	
	public int deleteAll(long reviewNo);
}
