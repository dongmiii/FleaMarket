package com.fleamarket.service;

import java.util.HashMap;
import java.util.List;

import com.fleamarket.domain.Criteria;
import com.fleamarket.domain.NoticeVO;

public interface NoticeService { // 기능 이름 정의?
	// 공지사항 등록 수정 삭제 조회
	List<NoticeVO> readNoticeList();
	NoticeVO readNoticeContent(int no);
	boolean updateNotice(NoticeVO notice);
	boolean deleteNotice(int no);
	boolean insertNotice(NoticeVO notice);
	void countNotice(int no);
	public List<NoticeVO> getList(Criteria cri);
	public int getTotal(Criteria cri);
}
