package com.fleamarket.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MarketAttachVO {
	
	private String uuid;
	private String uploadPath;
	private String imageName;
	private String sort; //판매될 아이템인지 마켓의 이미지인지를 구분하기 위한 필드
	private Long mno;
	
}
