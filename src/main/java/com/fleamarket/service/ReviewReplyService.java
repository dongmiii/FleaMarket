package com.fleamarket.service;

import java.util.List;

import com.fleamarket.domain.Criteria;
import com.fleamarket.domain.ReviewReplyPageDTO;
import com.fleamarket.domain.ReviewReplyVO;

public interface ReviewReplyService {
	
	public int regist(ReviewReplyVO marketReplyVO);
	
	public ReviewReplyVO get(long replyNo);
	
	public int modify(ReviewReplyVO marketReplyVO);
	
	public int remove(long replyNo);
	
	public List<ReviewReplyVO> getList(Criteria cri, long reviewNo);
	
	public ReviewReplyPageDTO getListWithPaging(Criteria cri, long reviewNo);
}	
