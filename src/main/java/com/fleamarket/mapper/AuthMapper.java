package com.fleamarket.mapper;

import com.fleamarket.domain.AuthVO;

public interface AuthMapper {
	
	public void insert(AuthVO auth);
	
	public int delete(String userId);
	
	public int update(AuthVO auth);
	
	public AuthVO read(String userid);
	
}
