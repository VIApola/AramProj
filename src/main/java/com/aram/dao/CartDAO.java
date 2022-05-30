package com.aram.dao;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

public class CartDAO {
	private BasicDataSource bds;
	
	public CartDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//카트에 담긴 값 main으로 뿌려주기위해 전체 조회
	//메인에서 if로 user_id와 로그인세션의 user_id가 같다면
	//quantity의 값을 가져와 뿌려줘야함
}
