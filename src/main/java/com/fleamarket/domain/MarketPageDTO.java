package com.fleamarket.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

//관리 페이지에서 사용하기위한 객체
@Data
@AllArgsConstructor
@Getter
public class MarketPageDTO {
	
	private int marketCnt; 
	private List<MarketVO> list; 
	
}
