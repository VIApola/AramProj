package com.aram.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

public class UserDAO {
	private BasicDataSource bds;
	
	public UserDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 아이디 중복검사 
	public int checkId(String id) throws Exception{
		String sql = "select * from tbl_user where user_id = ?";
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			
			int idCheck = 0;
			if(rs.next()|| id.equals("")) { //아이디 중복
				idCheck = 0;
			}else { // 아이디 생성가능
				idCheck = 1; 
			}
			return idCheck;
			
		}
	}
}
