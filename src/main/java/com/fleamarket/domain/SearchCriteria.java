package com.fleamarket.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class SearchCriteria extends Criteria {

	private String type; //타입
	private String keyword; //검색할 키워드
	
	//private String oper; //search, rank, opening, closed
	
	public SearchCriteria() {
		super();
	}
	
	public SearchCriteria(int pageNum, int amount) {
		super(pageNum, amount);
	}
	
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
	
	
}
