package com.fleamarket.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fleamarket.domain.AuthVO;
import com.fleamarket.domain.Criteria;
import com.fleamarket.domain.CriteriaUserId;
import com.fleamarket.domain.MarketAttachVO;
import com.fleamarket.domain.MarketPageDTO;
import com.fleamarket.domain.MarketVO;
import com.fleamarket.domain.SearchCriteria;
import com.fleamarket.mapper.AuthMapper;
import com.fleamarket.mapper.MarketAttachMapper;
import com.fleamarket.mapper.MarketMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MarketServiceImpl implements MarketService {
	
	@Autowired
	private MarketMapper marketMapper;
	
	@Autowired
	private MarketAttachMapper marketAttachMapper;
	
	@Autowired
	private AuthMapper authMapper;
	
	@Transactional
	@Override
	public void insertMarket(MarketVO marketVO) {
		log.info("insertMarket(MarketVO marketVO)");
		marketMapper.insertSelectKey(marketVO);
		marketVO.getMarketAttachList().forEach((vo)->{
			log.info("inserted marketAttach: " + vo.getImageName());
			vo.setMno(marketVO.getMno());
			marketAttachMapper.insert(vo);
		});
		AuthVO auth = new AuthVO();
		auth.setUserid(marketVO.getUserId());
		auth.setAuth("ROLE_ORGANIZER");
		authMapper.insert(auth);
	}

	@Override
	public MarketVO getMarket(long mno) {
		log.info("getMarket(long mno)");
		return marketMapper.read(mno);
	}

	@Transactional
	@Override
	public boolean updateMarket(MarketVO marketVO) {
		log.info("updateMarket(MarketVO marketVO)");
		int deletedCount = marketAttachMapper.deleteAll(marketVO.getMno()); //일단 모두 지워버리고 다시 저장
		log.info("deletedCount: " + deletedCount);
		boolean modifyResult = marketMapper.update(marketVO) == 1;
		if(modifyResult && marketVO.getMarketAttachList() != null && marketVO.getMarketAttachList().size() > 0) {
			marketVO.getMarketAttachList().forEach(attachVO->{
				attachVO.setMno(marketVO.getMno());
				marketAttachMapper.insert(attachVO);
			});
		}
		return modifyResult;
	}
	
	
	@Transactional
	@Override
	public boolean deleteMarket(long mno) {
		log.info("deleteMarket(long mno)");
		marketAttachMapper.deleteAll(mno);
		return marketMapper.delete(mno) == 1;
	}
	
	//메인페이지에서 보여줄 서비스 메서드
	@Transactional
	@Override
	public List<MarketVO> getMarketList(){
		log.info("getMarketList()");
		List<MarketVO> marketList = marketMapper.getList(); //getList()가 아닌 다른거 
		marketList.forEach((vo)->{
			vo.setMarketAttachList(getAttachList(vo.getMno()));
		});
		return marketList;
	}
	
	@Override
	public MarketPageDTO getMarketListWithCriPaging(Criteria cri){
		MarketPageDTO dto = new MarketPageDTO(
					marketMapper.getMarketCountWithoutParameter(),
					marketMapper.getListWithCriPaging(cri)
				); 
		return dto;
	}
	
	//마켓 모아보기에서 보여줄 서비스 메서드
	@Transactional
	@Override
	public List<MarketVO> getMarketListWithPaging(SearchCriteria cri){ //SearchCriteria로 수정해야함
		log.info("getMarketListWithPaging(SearchCriteria cri)");
		List<MarketVO> marketList = marketMapper.getListWithPaging(cri); 
		marketList.forEach((vo)->{
			vo.setMarketAttachList(getAttachList(vo.getMno()));
		});
		return marketList;
	}
	
	@Transactional
	@Override
	public List<MarketVO> getMarketListWithRanking(SearchCriteria cri){ //SearchCriteria로 수정해야함
		log.info("getMarketListWithRanking(SearchCriteria cri)");
		List<MarketVO> marketList = marketMapper.getListWithRanking(cri);
		marketList.forEach((vo)->{
			vo.setMarketAttachList(getAttachList(vo.getMno()));
		});
		return marketList;
	}
	
	
	@Override
	public List<MarketAttachVO> getAttachList(long mno){
		log.info("getAttachList(long mno)");
		return marketAttachMapper.findByMno(mno);
	}
	
	@Override
	public int getMarketTotalCount(SearchCriteria cri) {
		log.info("getMarketTotalCount()");
		return marketMapper.getMarketCount(cri);
	}

	@Transactional
	@Override
	public boolean updatePermit(MarketVO marketVO) {
		if(marketVO.getReject() != null) { 
			if(marketMapper.updateMarketRejectReason(marketVO) != 1) {
				return false;
			}
		}
		if(marketMapper.updatePermit(marketVO) != 1) 
			return false;
		return true;
	}

	@Override
	public boolean updateRegistDate(MarketVO marketVO) {
		if(marketMapper.updateRegistDate(marketVO) == 1) 
			return true;
		return false;
	}
	
	@Override
	public MarketPageDTO getRegistMarketList(CriteriaUserId cri) {
		MarketPageDTO dto = new MarketPageDTO(
				marketMapper.getMarketCountWithUserId(cri.getUserId()), 
				marketMapper.getListWithUserid(cri)
			); 
		return dto;
	}
}


















