package com.fleamarket.service;

import java.util.List;

import com.fleamarket.domain.Criteria;
import com.fleamarket.domain.MemberPageDTO;
import com.fleamarket.domain.MemberVO;

public interface MemberService {
	
	//일반사용자 등록 서비스 메서드
	public void joinMember(MemberVO member);
	
	public MemberVO getMember(String userid);
	
	public boolean updateMember(MemberVO member);
	
	public boolean removeMember(String userid);
	
	public int checkDuplicateId(String userid);
	
	public List<MemberVO> getMemberListWithPaging(Criteria cri);
	
	public MemberPageDTO getMemberList(Criteria cri);
	
	public int getTotalMemberCount();
}
