package com.fleamarket.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewVO {

	private long reviewNo; //시퀀스
	private String title; //제목
	private String content; //내용
	private String writer; //작성자
	private Date regDate; //등록 날짜
	private Date updateDate; //수정날짜
	private long views; //조회수
	private long mLikes; //후기에 남긴 평점
	private long mno; //어떤 마켓인지 알기 위한 칼럼(fk)
	
	private List<ReviewAttachVO> attachList; //후기게시판에 붙는 이미지들
}
