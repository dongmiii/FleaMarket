package com.fleamarket.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NoticeVO { // 폼에서 입력한 값들 저장해주는 클래스
	
	private long  no;
	private String title;
	private String content;
	private Date updatedate;
	private String writer;
	private long hits;
	

}
