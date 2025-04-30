package com.fleamarket.domain;

import lombok.Data;

@Data
public class CriteriaUserId extends Criteria {
	
	private String userId;
	
	public CriteriaUserId() {
		super();
	}
	
	public CriteriaUserId(int pageNum, int amount) {
		super(pageNum, amount);
	}
	
}
