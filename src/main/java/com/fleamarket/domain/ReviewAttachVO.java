package com.fleamarket.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewAttachVO {
	
	private String uuid; //pk
	private String uploadPath; //이미지 경로
	private String imageName; //
	private long reviewNo; //fk
}



