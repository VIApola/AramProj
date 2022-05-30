package com.aram.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import com.aram.dto.UserDTO;

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
	
	// 카카오 회원가입
	public int kakaoJoin(UserDTO dto) throws Exception{
		String sql = "insert into tbl_user values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,sysdate, ?)";
		try(Connection con = bds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
				
				pstmt.setString(1, dto.getUser_id());
				pstmt.setString(2, dto.getUser_pw());
				pstmt.setString(3, dto.getUsername());
				pstmt.setString(4, dto.getNickname());
				pstmt.setString(5, dto.getPhone());
				pstmt.setString(6, dto.getEmail());
				pstmt.setString(7, dto.getPost_no());
				pstmt.setString(8, dto.getAddr());
				pstmt.setString(9, dto.getAddr_detail());
				pstmt.setString(10, dto.getSocial_login());
				pstmt.setString(11, dto.getEmail_verify());
				pstmt.setString(12, dto.getIsAdmin());
				
				int rs = pstmt.executeUpdate();
				return rs;
				
			}
	}
	// 카카오 로그인
	public UserDTO kakaoLogin(String id) throws Exception{
		String sql = "select * from tbl_user where user_id=?";
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, id);	
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) { //로그인 성공이라면
				String user_id = rs.getString("user_id");
				String user_pw = rs.getString("user_pw");
				String username = rs.getString("username");
				String nickname = rs.getString("nickname");
				String phone = rs.getString("phone");
				String email = rs.getString("email");
				String post_no = rs.getString("post_no");
				String addr = rs.getString("addr");
				String addr_detail = rs.getString("addr_detail");
				String social_login = rs.getString("social_login");
				String email_verify = rs.getString("email_verify");
				String join_date = getStringDate(rs.getDate("join_date"));
				String isAdmin = rs.getString("isAdmin");
				
				return new UserDTO(user_id, user_pw, username, nickname, phone, email, post_no, addr, addr_detail, social_login, email_verify, join_date, isAdmin);
			}
			return null;
		}
	}
	// 관리자인지 아닌지
//	public boolean isAdmin(String id, String pw) throws Exception{
//		String sql = "select "
//	}
	// 로그인 아이디 비밀번호 검사
	public UserDTO isLoginOk(String id, String pw) throws Exception{
		String sql = "select * from tbl_user where user_id=? and user_pw=?";
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) { //로그인 성공이라면
				String user_id = rs.getString("user_id");
				String user_pw = rs.getString("user_pw");
				String username = rs.getString("username");
				String nickname = rs.getString("nickname");
				String phone = rs.getString("phone");
				String email = rs.getString("email");
				String post_no = rs.getString("post_no");
				String addr = rs.getString("addr");
				String addr_detail = rs.getString("addr_detail");
				String social_login = rs.getString("social_login");
				String email_verify = rs.getString("email_verify");
				String join_date = getStringDate(rs.getDate("join_date"));
				String isAdmin = rs.getString("isAdmin");
				
				return new UserDTO(user_id, user_pw, username, nickname, phone, email, post_no, addr, addr_detail, social_login, email_verify, join_date, isAdmin);
			}
			return null;
		}
	}
	// 회원가입
	public int signup(UserDTO dto) throws Exception{
		String sql = "insert into tbl_user values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,sysdate, ?)";
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, dto.getUser_id());
			pstmt.setString(2, dto.getUser_pw());
			pstmt.setString(3, dto.getUsername());
			pstmt.setString(4, dto.getNickname());
			pstmt.setString(5, dto.getPhone());
			pstmt.setString(6, dto.getEmail());
			pstmt.setString(7, dto.getPost_no());
			pstmt.setString(8, dto.getAddr());
			pstmt.setString(9, dto.getAddr_detail());
			pstmt.setString(10, dto.getSocial_login());
			pstmt.setString(11, dto.getEmail_verify());
			pstmt.setString(12, dto.getIsAdmin());
			
			int rs = pstmt.executeUpdate();
			return rs;
			
		}
	}
	
	//아이디 중복검사 
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
	// date 형 -> String 으로 변환
		public String getStringDate(Date date) { // oracle의 date 타입을 받아야함
			// oracle date타입의 데이터를 java의 String을 변환 -> SimpleDateFormat
			// 생성자의 인자값을 String으로 변환할때 어떤 형식으로 변환할 것인기 format
			// format의 대소문자 구분하기
			// oracle 월(mm/MM) 분(mi)
			// java 월(MM) 분(mm)
			// 1900년 02월 02일 00시 00분 00초
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분 ss초");
			return sdf.format(date);
		}
}


