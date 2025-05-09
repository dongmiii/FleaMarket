package com.fleamarket.persistence;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fleamarket.config.RootConfig;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Log4j
public class DataSourceTests {

	@Setter(onMethod_= {@Autowired})
	private DataSource dataSource;
	
	@Setter(onMethod_= {@Autowired})
	private SqlSessionFactory sqlSessionFactory;
	
//	@Test
//	public void testConnection() {
//		try(Connection con = dataSource.getConnection()){
//			assertNotNull(con);
//			log.info(con);
//		}catch(SQLException ex) {
//			fail(ex.getMessage());
//		}
//	}
	
//	@Test
//	public void testMyBatis() {
//		try(SqlSession session = sqlSessionFactory.openSession(); Connection conn = session.getConnection()){
//			log.info(session);
//			log.info(conn);
//		}catch(SQLException ex) {
//			fail(ex.getMessage());
//		}
//	}
	
}

















