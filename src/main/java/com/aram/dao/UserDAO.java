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
	
	/* UserDAO 순서
	 * - 회원가입 signUP
	 * - 중복검사 checkId
	 * - 로그인 확인 isLoginOk
	 * - 카카오 회원가입 kakaoJoin
	 * - 카카오 로그인 kakaoLogin
	 * - 아이디 비밀번호 찾기 findId toChangePassord, ChangePassword, 비밀번호 변경
	 * - 이메일 인증 관련
	 * */
	
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
	
	// 아이디 중복검사 
	public int checkId(String id) throws Exception {
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
	
	
	// 로그인 - 아이디 비밀번호 검사, 유저정보를 담는 dto를 전송
	public UserDTO isLoginOk(String id, String pw) throws Exception {
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

	// 카카오 회원가입
	public int kakaoJoin(UserDTO dto) throws Exception {
		String sql = "insert into tbl_user values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,sysdate, ?)";
		try(Connection con = bds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
				
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
	
	// 아이디찾기
	public String findId(String name, String email) throws Exception {
		String sql = "select user_id from tbl_user where username = ? and email= ?";
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String id = rs.getString(1);
				return id;
			} else {
				return null;
			}
			
		}
	}
	
	// 비밀번호찾기
	public String toChangePw(String id, String email) throws Exception {
		String sql = "select user_id from tbl_user where user_id = ? and email = ?";
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, id);
			pstmt.setString(2, email);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String rsId = rs.getString(1);
				return rsId;
			} else {
				return null;
			}
		}
	}
	
	// 비밀번호찾기 -> 비밀번호변경
	public int changePw(String id, String pw) throws Exception {
		String sql = "update tbl_user set user_pw = ? where user_id = ?";
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, pw);
			pstmt.setString(2, id);
			
			int rs = pstmt.executeUpdate();
			return rs;
			
		}
	}
	// 회원정보 수정
	public int modifyUser(UserDTO dto) throws Exception{
		String sql = "update tbl_user set nickname=?, phone=?, email=?, "
				+ "post_no=?, addr=?, addr_detail=? where user_id=?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, dto.getNickname());
			pstmt.setString(2, dto.getPhone());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getPost_no());
			pstmt.setString(5, dto.getAddr());
			pstmt.setString(6, dto.getAddr_detail());
			pstmt.setString(7, dto.getUser_id());
			
			int rs = pstmt.executeUpdate();
			return rs;
		}
	}

	// 특정 회원의 이메일값 반환
	public String getUserEmail(String id) throws Exception{
		String sql = "select email from tbl_user where user_id=?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
				
			pstmt.setString(1, id);
				
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			return null; // 데이터 베이스 오류
				
			}
	}
	
	// 이메일 인증 확인
	public String getUserEmailChecked(String id) throws Exception {
		String sql = "select idHashChecked from email_verfied where user_id=?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
				
			pstmt.setString(1, id);
				
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			return null;
			}
	}
	
	// 이메일 인증 완료 상태로 변경
	public int setUserEmailChecked(String code) throws Exception {
		String sql = "update email_verfied set idHashChecked='y' where idHash=?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
				
				pstmt.setString(1, code);				
				return pstmt.executeUpdate();
			}
	}
	
	
	
	public int setHashedEmail(String id, String hashedEmail) throws Exception {
		String sql = "insert into email_verfied values(?,?,'n')";
		try(PreparedStatement pst = bds.getConnection().prepareStatement(sql)){
			
			pst.setString(1, id);
			pst.setString(2, hashedEmail);
			
			return pst.executeUpdate();
		}
	}
		
		// 관리자인지 아닌지
//		public boolean isAdmin(String id, String pw) throws Exception{
//			String sql = "select "
//		}


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


