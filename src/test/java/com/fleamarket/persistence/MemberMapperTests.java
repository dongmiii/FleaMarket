package com.fleamarket.persistence;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fleamarket.config.RootConfig;
import com.fleamarket.config.SecurityConfig;
import com.fleamarket.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes= {RootConfig.class, SecurityConfig.class})
@Log4j
public class MemberMapperTests {
	
	@Setter(onMethod_= {@Autowired})
	private PasswordEncoder pwEncoder;
	
	@Setter(onMethod_= {@Autowired})
	private DataSource ds;
	
	@Setter(onMethod_= {@Autowired})
	private MemberMapper mapper;
	
	
	//success
//	@Test
//	public void testinsert() {
//		for(int i=1; i<=5; i++) {
//			MemberVO member = new MemberVO();
//			if(i<=2) {
//				member.setUserid("user"+i); 
//				member.setUserpw(pwEncoder.encode("pw"+i));
//				member.setUserName("김승현"+i);
//				member.setGender('M');
//				member.setIdenNum("940206");
//				member.setPhoneNum("01011112222");
//				mapper.insert(member);
//			}else if(i<=4) {
//				member.setUserid("user"+i); 
//				member.setUserpw(pwEncoder.encode("pw"+i));
//				member.setUserName("김승현"+i);
//				member.setGender('M');
//				member.setIdenNum("940206");
//				member.setPhoneNum("01011112222");
//				mapper.insert(member);
//			}else {
//				member.setUserid("user"+i); 
//				member.setUserpw(pwEncoder.encode("pw"+i));
//				member.setUserName("김승현"+i);
//				member.setGender('M');
//				member.setIdenNum("940206");
//				member.setPhoneNum("01011112222");
//				mapper.insert(member);
//			}
//		}
//	}
	
	//success
//	@Test
//	public void testRead() {
//		log.info(mapper.read("user1"));
//	}
	
	//success
//	@Test
//	public void testUpdate() {
//		MemberVO member = new MemberVO();
//		member.setUserid("user3"); 
//		member.setUserpw(pwEncoder.encode("pw3"));
//		member.setUserName("김승현3");
//		member.setGender('M');
//		member.setIdenNum("960206");
//		member.setPhoneNum("01033334444");
//		int count = mapper.update(member);
//		log.info("updated Count: " + count);
//	}
	
	//success
//	@Test
//	public void testDelete() {
//		int count = mapper.delete("user5");
//		log.info("deleted Count: " + count);
//	}
	
	
	//success
//	@Test
//	public void testReadWithAuth() {
//		MemberVO member = mapper.readWithAuth("user4");
//		log.info(member);
//		member.getAuthList().forEach(vo->log.info(vo));
//	}
	
	//success
//	@Test
//	public void testGetCount() {
//		log.info(mapper.getCount("testuser02"));
//	}
}




















