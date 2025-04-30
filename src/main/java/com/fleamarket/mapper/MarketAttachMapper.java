package com.fleamarket.mapper;

import java.util.List;

import com.fleamarket.domain.MarketAttachVO;

public interface MarketAttachMapper {
	
	public void insert(MarketAttachVO vo);
	
	public List<MarketAttachVO> findByMno(long mno);
	
	public int delete(String uuid);
	
	public int deleteAll(long mno);
	
	public List<MarketAttachVO> getOldFiles();
}
