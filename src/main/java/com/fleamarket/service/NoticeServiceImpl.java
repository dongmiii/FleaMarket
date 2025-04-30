package com.fleamarket.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fleamarket.domain.Criteria;
import com.fleamarket.domain.NoticeVO;
import com.fleamarket.mapper.NoticeMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private NoticeMapper noticeMapper; // mapper 와 impl 자동 매핑

	@Override
	public List<NoticeVO> readNoticeList() {
		// 데이터접근 지시
		log.debug("readNoticeList()");
		List<NoticeVO> notice = noticeMapper.readNoticeList();
		return notice;
	}
	
	@Override
	public NoticeVO readNoticeContent(int no) {
		// 데이터접근 지시
		log.debug("readNoticeContent()");
		NoticeVO notice = noticeMapper.readNoticeContent(no);
		return notice;
	}
	
	@Override
	public boolean updateNotice(NoticeVO notice) {
		log.info("updateNotice()");
		if(noticeMapper.updateNotice(notice) ==1) {
			return true;
		}
		return false;
	}
	
	@Override
	public boolean deleteNotice(int no) {
		log.info("deleteNotice()");
		if(noticeMapper.deleteNotice(no) ==1) {
			return true;
		}
		return false;
	}
	
	@Override
	public boolean insertNotice(NoticeVO notice) {
		log.info("insertNotice()");
		if(noticeMapper.insertNotice(notice) ==1) {
			return true;
		}
		return false;
	}
	
	@Override
	public void countNotice(int no) {
		log.info("countNotice()");
		noticeMapper.count_hits(no);
		
	}
	
	@Override
	public List<NoticeVO> getList(Criteria cri) {
		log.info("get List with criteria : " + cri);
		return noticeMapper.getListWithPaging(cri);
	}
	
	@Override
	public int getTotal(Criteria cri) {
		return noticeMapper.getTotal(cri);
	}
}
