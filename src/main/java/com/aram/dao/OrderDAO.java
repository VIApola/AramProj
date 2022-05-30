package com.aram.dao;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import com.aram.dto.OrderDTO;

public class OrderDAO {
	private BasicDataSource bds;
	
	public OrderDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 생성
	public int insert(OrderDTO dto)throws Exception{
		
		String sql = "insert into ";
		
	}
	
	
	
	
	// 전체목록 
	
	// 개별목록
	
	// 수정
	
	// 삭제
	

}
