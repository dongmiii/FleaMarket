package com.fleamarket.mapper;

import java.util.List;

import com.fleamarket.domain.Criteria;
import com.fleamarket.domain.MemberVO;

//테스트코드 마무리완료
public interface MemberMapper {

	public MemberVO readWithAuth(String userid);
	
	public void insert(MemberVO member);
	
	public int delete(String userId);
	
	public int update(MemberVO member);
	
	public MemberVO read(String userid);
	
	public int getCount(String userid);
	
	public int getTotalCount();
	
	public List<MemberVO> getMemberListWithPaging(Criteria cri);
}
