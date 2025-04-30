package com.fleamarket.persistence;

import javax.sql.DataSource;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fleamarket.config.RootConfig;
import com.fleamarket.config.SecurityConfig;
import com.fleamarket.mapper.AuthMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes= {RootConfig.class, SecurityConfig.class})
@Log4j
public class AuthMapperTests {	
	
	@Setter(onMethod_= {@Autowired})
	private PasswordEncoder pwEncoder;
	
	@Setter(onMethod_= {@Autowired})
	private DataSource ds;
	
	@Autowired
	private AuthMapper mapper;
	
	//success
//	@Test
//	public void testInsert() {
//		mapper.insert(new AuthVO("user1", "ROLE_USER"));
//	}
	
	//success
//	@Test
//	public void testUpdate() {
//		int count = mapper.update(new AuthVO("user3", "ROLE_MANAGER"));
//		log.info("updated Count: " + count);
//	}
	
	//success
//	@Test
//	public void testDelete() {
//		int count = mapper.delete("user1");
//		log.info("updated Count: " + count);
//	}
	
	//success
//	@Test
//	public void testRead() {
//		log.info(mapper.read("user1"));
//	}
	
	
}



















