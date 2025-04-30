package com.fleamarket.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MarketVO {
	
	private long mno; //시퀸스
	private String mName; //마켓 이름
	private String orgName; //주최자 명
	private String mEmail; //주최자 이메일
	private String mPhone; //마켓의 대표 번호
	private String mExp; //마켓 경험 유무 (유/무)
	private String mCategory; //선택 카테고리들(a,b,c,....)
	private String mInfo; //마켓의 소개
	private Date mStartDate; //마켓 시작 날짜
	private Date mLastDate; //마켓 마지막 날짜
	private String mLocation; //마켓 위치
	private long mLikes; //평점
	private String mPermit; //마켓 허락 유무
	private Date mRequestDate; //마켓 신청날짜
	private Date mRegistDate;  //등록 날짜(null들어갈 수 있음)
	
	private String userId; //등록했을 때 아이디
	private String reject; //거절된 이유
	
	private List<MarketAttachVO> marketAttachList; //마켓 등록 시 업로드할 마켓이미지와 아이템들
}
