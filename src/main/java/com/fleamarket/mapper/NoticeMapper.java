package com.fleamarket.mapper;

import java.util.List;

import com.fleamarket.domain.Criteria;
import com.fleamarket.domain.NoticeVO;

public interface NoticeMapper {
	
	public List<NoticeVO> readNoticeList(); // 리스트 보여주기
	public NoticeVO readNoticeContent(int no); // 리스트 상세 내용 보여주기
	public int insertNotice(NoticeVO notice); // 글등록
	public int updateNotice(NoticeVO notice); // 글 수정
	public int deleteNotice(int no); // 글 삭제
	public void count_hits(int no); // 조회수
	public List<NoticeVO> getListWithPaging(Criteria cri); // 페이징
	public int getTotal(Criteria cri);
}
