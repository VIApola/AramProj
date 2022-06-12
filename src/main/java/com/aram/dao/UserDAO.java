package com.aram.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import com.aram.dto.MypageReviewDTO;
import com.aram.dto.UserDTO;
import com.aram.utils.StringDateFormatter;

public class UserDAO {
	
	/* UserDAO 순서
	 * - 회원가입 signUP
	 * - 중복검사 checkId
	 * - 로그인 확인 isLoginOk
	 * - 카카오 회원가입 kakaoJoin
	 * - 카카오 로그인 kakaoLogin
	 * - 아이디 비밀번호 찾기 findId toChangePassord, ChangePassword, 비밀번호 변경
	 * - 이메일 인증 관련 
	 * - 일반 화원탈퇴
	 * - 카카오 회원탈퇴
	 * */
	
	private BasicDataSource bds = null;
	
	public UserDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		} catch(Exception e) {
			e.printStackTrace();
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
	
	// 아이디 중복검사 
	public int checkId(String id) throws Exception {
		String sql = "select * from tbl_user where user_id = ?";
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, id);
			try(ResultSet rs = pstmt.executeQuery()){
			
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
	// 이메일 중복검사
	public int checkEmail(String email) throws Exception{
		String sql = "select * from tbl_user where email = ?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, email);
			try(ResultSet rs = pstmt.executeQuery()){
			
			int emailCheck = 0;
			if(rs.next() || email.equals("")) {// 이메일 중복
				emailCheck = 0;
			}else {
				emailCheck = 1;
			}
			return emailCheck;
			}
		}
		
	}
	// 비밀번호 일치 여부
	public int checkPw(String id, String pw)throws Exception{
		String sql = "select * from tbl_user where user_id =? and user_pw = ?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			try(ResultSet rs = pstmt.executeQuery()){
			
			if(rs.next()) {
				return 0;  // 비밀번호 존재
			}
			return 1;
		}
	}
	}
	// 로그인 - 아이디 비밀번호 검사, 유저정보를 담는 dto를 전송
	public UserDTO isLoginOk(String id, String pw) throws Exception {
		String sql = "select * from tbl_user where user_id=? and user_pw=?";
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			
			try(ResultSet rs = pstmt.executeQuery()){
			
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
				String join_date = StringDateFormatter.getStringDate(rs.getDate("join_date"));
				String isAdmin = rs.getString("isAdmin");
				
				return new UserDTO(user_id, user_pw, username, nickname, phone, email, post_no, addr, addr_detail, social_login, email_verify, join_date, isAdmin);
			}
			return null;
			}
			}
	}
	// 블랙리스트라면
	public int checkBlackList(String id) throws Exception{
		String sql = "select * from tbl_blacklist where user_id = ?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setString(1, id);
			try(ResultSet rs = pstmt.executeQuery()){
			
			if(rs.next()) {
				return 0; // 블랙리스트 존재
			}
			return 1;
			}
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
			try(ResultSet rs = pstmt.executeQuery()){
			
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
				String join_date = StringDateFormatter.getStringDate(rs.getDate("join_date"));
				String isAdmin = rs.getString("isAdmin");
				
				return new UserDTO(user_id, user_pw, username, nickname, phone, email, post_no, addr, addr_detail, social_login, email_verify, join_date, isAdmin);
			}
			return null;
		}
	}
	}
	// 아이디찾기
	public String findId(String name, String email) throws Exception {
		String sql = "select user_id from tbl_user where username = ? and email= ?";
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			
			try(ResultSet rs = pstmt.executeQuery()){
			
			if(rs.next()) {
				String id = rs.getString(1);
				return id;
			} else {
				return null;
			}
			
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
			
			try(ResultSet rs = pstmt.executeQuery()){
			
			if(rs.next()) {
				String rsId = rs.getString(1);
				return rsId;
			} else {
				return null;
			}
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
				
			try(ResultSet rs = pstmt.executeQuery()){
			if(rs.next()) {
				return rs.getString(1);
			}
			return null; // 데이터 베이스 오류
			}
			}
	}
	
	// 이메일 인증 확인
	public String getUserEmailChecked(String id) throws Exception {
		String sql = "select idHashChecked from email_verfied where user_id=?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
				
			pstmt.setString(1, id);
				
			try(ResultSet rs = pstmt.executeQuery()){
			if(rs.next()) {
				return rs.getString(1);
			}
		return "";
		}
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
		try(Connection con = bds.getConnection();
			PreparedStatement pst = con.prepareStatement(sql)){
			
			pst.setString(1, id);
			pst.setString(2, hashedEmail);
			
			return pst.executeUpdate();
		}
	}
	
	//회원탈퇴
	public int deleteUser(String id) throws Exception{
		String sql = "delete from tbl_user where user_id = ?";
		try(Connection con =bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			pstmt.setString(1, id);
			
			return pstmt.executeUpdate();
		}
	}
	
	//카카오 회원탈퇴
	public int deleteKakaoUser(String id, String social_login)throws Exception{
		String sql = "delete from tbl_user where user_id = ? and social_login = ?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			
			pstmt.setString(1, id);
			pstmt.setString(2, social_login);
			return pstmt.executeUpdate();
		
		}
	}
	
	// 회원아이디로 마이페이지-리뷰에서 필요한 모든 정보 출력
	public ArrayList<MypageReviewDTO> selectAllById(String user_id)throws Exception{
		String sql="select * from tbl_review a, tbl_item_img b, tbl_items c where a.item_no = b.item_no and b.item_no = c.item_no and user_id=? order by write_date desc";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			pstmt.setString(1, user_id);
			try(ResultSet rs = pstmt.executeQuery()){
			ArrayList<MypageReviewDTO> list = new ArrayList<>();
			while(rs.next()) {
				
				int review_no = rs.getInt("review_no");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String written_date = StringDateFormatter.getStringDate(rs.getDate("write_date"));
				int score = rs.getInt("score");
				
				int item_no = rs.getInt("item_no");
				int img_no = rs.getInt("img_no");
				String sys_date = rs.getString("sys_name");
				String item_name = rs.getString("item_name");
			
			list.add(new MypageReviewDTO(review_no, title, content, written_date, score, user_id, item_no, img_no, sys_date, item_name));	
			}
			return list;
		}
	}
}
	/*
	// 관리자 확인
	public boolean getIsAdmin(String id) throws Exception {
		String sql = "select isadmin from tbl_user where user_id = ?";
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setString(1, id);
			
			try(ResultSet rs = pstmt.executeQuery()){
			
			if (rs.equals("y")) {
				return true;
			} else {
				return false;
			}
			
		}
	}
	}
	*/
	
		// 관리자인지 아닌지
//		public boolean isAdmin(String id, String pw) throws Exception{
//			String sql = "select "
//		}

}


