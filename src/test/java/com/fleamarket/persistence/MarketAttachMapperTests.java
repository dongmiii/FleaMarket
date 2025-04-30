package com.fleamarket.persistence;

import java.security.Security;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fleamarket.config.RootConfig;
import com.fleamarket.domain.MarketAttachVO;
import com.fleamarket.mapper.MarketAttachMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes= {RootConfig.class, Security.class})
@Log4j
public class MarketAttachMapperTests {

	@Autowired
	private MarketAttachMapper mapper;
	
	private MarketAttachVO vo;
	public MarketAttachMapperTests() {
		this.vo = new MarketAttachVO();
		vo.setUuid("tempUuid3");
		vo.setUploadPath("tempPath11");
		vo.setImageName("tempImageName11");
		vo.setSort("market1"); //or item
		vo.setMno(8L);
	}
	
	//success
//	@Test
//	public void testInsert() {
//		mapper.insert(vo);
//	}
	
	//success
//	@Test
//	public void testFindByMno() {
//		mapper.findByMno(8L).forEach(vo->log.info(vo));
//	}
	
	//success
//	@Test
//	public void testDelete() {
//		mapper.delete("tempUuid");
//	}
	
	//success
//	@Test
//	public void testDeleteAll() {
//		mapper.deleteAll(8L);
//	}
	
	
	
}
























