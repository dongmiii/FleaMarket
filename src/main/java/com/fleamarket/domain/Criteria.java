package com.fleamarket.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Criteria {
	
	private int pageNum; //페이지번호
	private int amount; //각 페이지에 보여줄 정보갯수
	
	
	public Criteria() {
		this(1,12);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
}
