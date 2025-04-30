package com.fleamarket.mapper;

import java.util.List;

import com.fleamarket.domain.Criteria;
import com.fleamarket.domain.CriteriaUserId;
import com.fleamarket.domain.MarketVO;
import com.fleamarket.domain.SearchCriteria;

public interface MarketMapper {
	
	public void insertSelectKey(MarketVO marketVO);
	
	public MarketVO read(long mno);
	
	public int update(MarketVO marketVO);
	
	public int delete(long mno);
	
	public List<MarketVO> getList();
	
	public int updateMarketLikes(MarketVO marketVO);
	
	public int updatePermit(MarketVO marketVO);
	
	public int updateRegistDate(MarketVO marketVO);
	
	public int getMarketCount(SearchCriteria cri);
	
	public int getMarketCountWithoutParameter();
	
	public int getMarketCountWithUserId(String userId);
	
	public List<MarketVO> getListWithPaging(SearchCriteria cri); //SearchCriteria로 수정해야함
	
	public List<MarketVO> getListWithCriPaging(Criteria cri);
	
	public List<MarketVO> getListWithRanking(SearchCriteria cri);
	
	public List<MarketVO> getListWithUserid(CriteriaUserId cri);
	
	public int updateMarketRejectReason(MarketVO marketVO);
}


























