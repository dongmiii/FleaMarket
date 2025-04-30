package com.fleamarket.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fleamarket.domain.AuthVO;
import com.fleamarket.domain.Criteria;
import com.fleamarket.domain.MemberPageDTO;
import com.fleamarket.domain.MemberVO;
import com.fleamarket.mapper.AuthMapper;
import com.fleamarket.mapper.MemberMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private AuthMapper authMapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	public void setMemberMapper(MemberMapper memberMapper) {
		this.memberMapper = memberMapper;
	}
	
	//수정해야함(일단 가입하면 user, 마켓신청하고 허락이되면 organizer, master는 db에서 직업 다뤄줘야함)
	@Transactional
	@Override
	public void joinMember(MemberVO member) {
		log.info("joinMember()");
		member.setUserpw(passwordEncoder.encode(member.getUserpw()));
		memberMapper.insert(member);
		
		AuthVO authVo = new AuthVO();
		authVo.setUserid(member.getUserid());
		authVo.setAuth("ROLE_USER");
		authMapper.insert(authVo);
	}

	@Override
	public MemberVO getMember(String userid) {
		log.info("getMember()");
		MemberVO member = memberMapper.read(userid);
		return member;
	}

	
	@Override
	public boolean updateMember(MemberVO member) {
		log.info("updateMember()");
		member.setUserpw(passwordEncoder.encode(member.getUserpw()));
		if(memberMapper.update(member) == 1) {
			return true;
		}
		return false;
	}
	
	@Transactional
	@Override
	public boolean removeMember(String userid) {
		log.info("removeMember()");
		
		if(authMapper.delete(userid) == 0) { //권한이 여러개 있을 수 있음
			return false;
		}
		if(memberMapper.delete(userid) != 1) {
			return false;
		}
		return true;
	}
	
	@Override
	public int checkDuplicateId(String userid) {
		log.info("checkDuplicateId()");
		return memberMapper.getCount(userid);
	}
	
	@Override
	public List<MemberVO> getMemberListWithPaging(Criteria cri){
		log.info("getMemberListWithPaging(Criteria cri)");
		List<MemberVO> memberList = memberMapper.getMemberListWithPaging(cri);
		return memberList;
	}
	
	@Override
	public int getTotalMemberCount() {
		log.info("getTotalMemberCount()");
		int totalCount = memberMapper.getTotalCount();
		return totalCount;
	}

	@Transactional
	@Override
	public MemberPageDTO getMemberList(Criteria cri) {
		MemberPageDTO dto = new MemberPageDTO(
				getTotalMemberCount(),
				getMemberListWithPaging(cri)
				);
		return dto;
	}
	
}



























