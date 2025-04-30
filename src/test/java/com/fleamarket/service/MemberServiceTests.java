package com.fleamarket.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fleamarket.config.RootConfig;
import com.fleamarket.config.SecurityConfig;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes= {RootConfig.class, SecurityConfig.class})
@Log4j
public class MemberServiceTests {
	
	@Autowired
	private MemberService service;
	
	@Test
	public void testGetMember() {
		log.info(service.getMember("testuser01"));
	}
	
}
