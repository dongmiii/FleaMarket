package com.fleamarket.mapper;

import java.util.List;

import com.fleamarket.domain.Criteria;
import com.fleamarket.domain.ReviewVO;

public interface ReviewMapper {
	
	public void insertSelectKey(ReviewVO reviewVO);
	
	public ReviewVO read(long reviewNo);
	
	public int update(ReviewVO reviewVO);
	
	public int delete(long reviewNo);
	
	public List<ReviewVO> getList(Criteria cri);
	 
//	public long getTotalCount(Criteria cri);
	
	public int getTotalCount();
	
	public int updateViews(long reviewNo);
	
}
