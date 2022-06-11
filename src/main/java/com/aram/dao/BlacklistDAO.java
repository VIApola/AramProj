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

import com.aram.dto.BlacklistDTO;
import com.aram.dto.UserDTO;
import com.aram.utils.StringDateFormatter;

public class BlacklistDAO {
	
	private BasicDataSource bds;
	
	public BlacklistDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	/* BlacklistDAO (관리자 - 고객관리)
	 * 
	 * 블랙리스트 추가 insertBlacklist
	 * 블랙리스트 삭제 deleteFromBlacklist
	 * 최근가입순으로 고객조회 ManageUserList
	 * 전체 블랙리스트 조회 selectAllBlacklist
	 * 
	 * 블랙리스트 - 아이디로 검색 selectBlacklistById
	 * 블랙리스트 - 사유로 검색 selectBlacklistByDetail
	 * 
	 * 아이디로 유저검색 selectUserlistById
	 * 이름으로 유저검색 selectUserlistByUserName
	 * 이메일로 유저검색 selectUserlistByEmail
	 * */
	
	
	//블랙리스트에 추가
	public int insertBlacklist(String user_id, String black_detail) throws Exception{

		String sql = "insert into tbl_blacklist values(?,sysdate,?)";
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, user_id);
			pstmt.setString(2, black_detail);
			
			return pstmt.executeUpdate();
		}
		
	}
	
	//블랙리스트에서 삭제
	public int deleteFromBlacklist(String user_id) throws Exception{
		String sql = "delete from tbl_blacklist where user_id = ?";
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, user_id);
			
			return pstmt.executeUpdate();	
		}
	}
	
	// 고객관리에서 뿌려줄 user 정보 최근가입순 ( 조건 : admin이 아닌 회원, tbl_blacklist에 user_id가 null인 회원)  
	public ArrayList<UserDTO> ManageUserList() throws Exception { 
		
		String sql = "select * from tbl_user a left join tbl_blacklist b on a.user_id = b.user_id"
				   + " where b.user_id is null and isadmin = 'n' order by join_date desc";
				
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			ArrayList<UserDTO> list = new ArrayList<>();
			try(ResultSet rs = pstmt.executeQuery()){
			
			while(rs.next()) {	
				String user_id = rs.getString("user_id");
				String username = rs.getString("username");
				String email = rs.getString("email");
				String join_date = StringDateFormatter.getStringDate(rs.getDate("join_date"));	
				list.add (new UserDTO(user_id, null, username, null, null, email, null, null, null, null, null, join_date, null));
			}
			return list;
		}
	}
}
	
	// 블랙리스트 전체 조회
	public ArrayList<BlacklistDTO> selectAllBlacklist() throws Exception{
		String sql = "select * from tbl_blacklist";
		
		try(Connection con =bds.getConnection();
			PreparedStatement pstmt  = con.prepareStatement(sql)){
			
			try(ResultSet rs = pstmt.executeQuery()){
			
			ArrayList<BlacklistDTO> list = new ArrayList<>();
			while(rs.next()) {
				
				String user_id = rs.getString("user_id");
				String black_date = StringDateFormatter.getStringDate(rs.getDate("black_date"));
				String black_detail = rs.getString("black_detail");
				
				list.add(new BlacklistDTO(user_id,black_date,black_detail));
			}
			return list;
		}
	}
	}
	
	
	
	// 검색하는 DAO들
	// 블랙리스트에서 아이디로 검색하기
	public ArrayList<BlacklistDTO> selectBlacklistById(String id) throws Exception{
		String sql = "select * from tbl_blacklist where user_id like '%'||?||'%'";
		
		    try(Connection con =bds.getConnection();
		    	PreparedStatement pstmt  = con.prepareStatement(sql)){
			
				pstmt.setString(1, id);
			
				try(ResultSet rs = pstmt.executeQuery()){
				
				ArrayList<BlacklistDTO> list = new ArrayList<>();
				while(rs.next()) {
					
					String user_id = rs.getString("user_id");
					String black_date = StringDateFormatter.getStringDate(rs.getDate("black_date"));
					String black_detail = rs.getString("black_detail");
					
					list.add(new BlacklistDTO(user_id,black_date,black_detail));
				}
				return list;
			}
	}
	}
	
	// 블랙리스트에서 사유로 검색하기
	public ArrayList<BlacklistDTO> selectBlacklistByDetail(String detail) throws Exception{
		String sql = "select * from tbl_blacklist where black_detail like '%'||?||'%'";
		
			try(Connection con =bds.getConnection();
				PreparedStatement pstmt  = con.prepareStatement(sql)){
			
				pstmt.setString(1, detail);
			
				try(ResultSet rs = pstmt.executeQuery()){
				
				ArrayList<BlacklistDTO> list = new ArrayList<>();
				while(rs.next()) {
					
					String user_id = rs.getString("user_id");
					String black_date = StringDateFormatter.getStringDate(rs.getDate("black_date"));
					String black_detail = rs.getString("black_detail");
					
					list.add(new BlacklistDTO(user_id,black_date,black_detail));
				}
				return list;
			}
	}
	}
	
	// 블랙리스트에서 등록일 검색하기
	public ArrayList<BlacklistDTO> selectBlacklistByDate(String date) throws Exception{
		String sql = "select * from tbl_blacklist where black_date like '%'||?||'%'";
		
			try(Connection con =bds.getConnection();
				PreparedStatement pstmt  = con.prepareStatement(sql)){
				
				pstmt.setString(1, date);
			
				try(ResultSet rs = pstmt.executeQuery()){
				
				ArrayList<BlacklistDTO> list = new ArrayList<>();
				while(rs.next()) {
					
					String user_id = rs.getString("user_id");
					String black_date = StringDateFormatter.getStringDate(rs.getDate("black_date"));
					String black_detail = rs.getString("black_detail");
					
					list.add(new BlacklistDTO(user_id,black_date,black_detail));
				}
				return list;
			}
	}
	}
	
	// tbl_user에서 아이디로 검색하기
	public ArrayList<UserDTO> selectUserlistById(String id) throws Exception{
		String sql = "select * from tbl_user a left join tbl_blacklist b on a.user_id = b.user_id where b.user_id is null and isadmin = 'n' and a.user_id like '%'||?||'%'";
		
		ArrayList<UserDTO> list = new ArrayList<>();
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, id);
			
			try(ResultSet rs = pstmt.executeQuery()){
			
			while(rs.next()) {
				String user_id = rs.getString("user_id");
				String username = rs.getString("username");
				String email = rs.getString("email");
				String join_date = StringDateFormatter.getStringDate(rs.getDate("join_date"));	
				list.add (new UserDTO(user_id, null, username, null, null, email, null, null, null, null, null, join_date, null));
			}
			return list;
			
		}
		
	}
		
	}
	// tbl_user에서 이름으로 검색하기
	public ArrayList<UserDTO> selectUserlistByUserName(String name) throws Exception{
		String sql = "select * from tbl_user a left join tbl_blacklist b on a.user_id = b.user_id where b.user_id is null and isadmin = 'n' and username like '%'||?||'%'";
		
		ArrayList<UserDTO> list = new ArrayList<>();
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, name);
			
			try(ResultSet rs = pstmt.executeQuery()){
			
			while(rs.next()) {
				String user_id = rs.getString("user_id");
				String username = rs.getString("username");
				String email = rs.getString("email");
				String join_date = StringDateFormatter.getStringDate(rs.getDate("join_date"));	
				list.add (new UserDTO(user_id, null, username, null, null, email, null, null, null, null, null, join_date, null));
			}
			return list;
		}
		
	}
	}
	

	//tbl_user에서 이메일로 검색하기
	public ArrayList<UserDTO> selectUserlistByEmail(String userEmail) throws Exception{
		String sql = "select * from tbl_user a left join tbl_blacklist b on a.user_id = b.user_id where b.user_id is null and isadmin = 'n' and email like '%'||?||'%'";
		
		ArrayList<UserDTO> list = new ArrayList<>();
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, userEmail);
			
			try(ResultSet rs = pstmt.executeQuery()){
			
			while(rs.next()) {
				String user_id = rs.getString("user_id");
				String username = rs.getString("username");
				String email = rs.getString("email");
				String join_date = StringDateFormatter.getStringDate(rs.getDate("join_date"));	
				list.add (new UserDTO(user_id, null, username, null, null, email, null, null, null, null, null, join_date, null));
			}
			return list;
		}

		}	
		
	}

	}
	
}
