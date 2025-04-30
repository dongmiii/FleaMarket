package com.fleamarket.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewReplyVO {

	private long replyNo; //댓글 시퀀스 번호
	private long reviewNo; //댓글이 달린 후기 번호
	private String reply;
	private String replyer;
	private Date replyDate;
	private Date updateDate;
	
}
