package com.fleamarket.domain;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {
	
	private String userid;
	private String userpw;
	
	private String confirmPw;
	
	private String userName;
//	private char gender;
	private Character gender;
	private String idenNum;
	private String phoneNum;
	private char enabled;
	
	private Date regDate;
	private Date updateDate;
	private List<AuthVO> authList;
	
}
