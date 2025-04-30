package com.fleamarket.service;

import java.util.List;

import com.fleamarket.domain.Criteria;
import com.fleamarket.domain.CriteriaUserId;
import com.fleamarket.domain.MarketAttachVO;
import com.fleamarket.domain.MarketPageDTO;
import com.fleamarket.domain.MarketVO;
import com.fleamarket.domain.SearchCriteria;

public interface MarketService {
	
	public void insertMarket(MarketVO marketVO);
	
	public MarketVO getMarket(long mno);
	
	public boolean updateMarket(MarketVO marketVO);
	
	public boolean deleteMarket(long mno); 
	
	public List<MarketVO> getMarketList();
	
	public List<MarketAttachVO> getAttachList(long mno);
	
	public int getMarketTotalCount(SearchCriteria cri);
	
	public List<MarketVO> getMarketListWithPaging(SearchCriteria cri); 
	
	public MarketPageDTO getMarketListWithCriPaging(Criteria cri);
	
	public List<MarketVO> getMarketListWithRanking(SearchCriteria cri); //마켓의 점수순으로 select해줌
	
	public boolean updatePermit(MarketVO marketVO);
	
	public boolean updateRegistDate(MarketVO marketVO);
	
	public MarketPageDTO getRegistMarketList(CriteriaUserId cri);
	
}
