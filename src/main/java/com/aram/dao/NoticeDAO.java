package com.aram.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import com.aram.dto.NoticeDTO;

public class NoticeDAO {
	private BasicDataSource bds;
	
	public NoticeDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	// 세션을 통한 검색
	// 글쓴이로 검색
	public ArrayList<NoticeDTO> searchByAuthor(String searchAuthor) throws Exception{
		String sql = "select * from tbl_notice where author = ? order by 1 desc";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, searchAuthor);
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<NoticeDTO> list = new ArrayList<>();
			while(rs.next()) {
				int notice_no = rs.getInt("notice_no");
				String user_id = rs.getString("user_id");
				String title = rs.getString("title");
				String author = rs.getString("author");
				String write_date = getStringDate(rs.getDate("write_date"));
				String content = rs.getString("content");
				int board_views = rs.getInt("board_views");
				list.add(new NoticeDTO(notice_no, user_id, title, author, write_date, content, board_views));
				
				System.out.println(list);
			}
			return list;
		}
	}
	
	// 제목으로 검색
	public ArrayList<NoticeDTO> searchByTitle(String searchTitle) throws Exception{
		String sql = "select * from tbl_notice where title = ? order by 1 desc";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, searchTitle);
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<NoticeDTO> list = new ArrayList<>();
			while(rs.next()) {
				int notice_no = rs.getInt("notice_no");
				String user_id = rs.getString("user_id");
				String title = rs.getString("title");
				String author = rs.getString("author");
				String write_date = getStringDate(rs.getDate("write_date"));
				String content = rs.getString("content");
				int board_views = rs.getInt("board_views");
				list.add(new NoticeDTO(notice_no, user_id, title, author, write_date, content, board_views));
				
				System.out.println(list);
			}
			return list;
		}
	}
	
	// 내용으로 검색
		public ArrayList<NoticeDTO> searchByContent(String searchContent) throws Exception{
			String sql = "select * from tbl_notice where content = ? order by 1 desc";
			try(Connection con = bds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
				
				pstmt.setString(1, searchContent);
				
				ResultSet rs = pstmt.executeQuery();
				ArrayList<NoticeDTO> list = new ArrayList<>();
				while(rs.next()) {
					int notice_no = rs.getInt("notice_no");
					String user_id = rs.getString("user_id");
					String title = rs.getString("title");
					String author = rs.getString("author");
					String write_date = getStringDate(rs.getDate("write_date"));
					String content = rs.getString("content");
					int board_views = rs.getInt("board_views");
					list.add(new NoticeDTO(notice_no, user_id, title, author, write_date, content, board_views));
					
					System.out.println(list);
				}
				return list;
			}
		}

	
	// 게시글 조회
	public ArrayList<NoticeDTO> selectAll() throws Exception{ 
		String sql = "SELECT * FROM tbl_notice";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<NoticeDTO> list = new ArrayList<>();
			while(rs.next()) {
				int notice_no = rs.getInt("notice_no");
				String user_id = rs.getString("user_id");
				String title = rs.getString("title");
				String author = rs.getString("author");
				String write_date = getStringDate(rs.getDate("write_date"));
				String content = rs.getString("content");
				int board_views = rs.getInt("board_views");
				
				list.add(new NoticeDTO(notice_no, user_id, title, author, write_date, content, board_views));
				System.out.println(list);
			}
			return list;
		}
	}
	// 날짜 String으로 변환
	public String getStringDate(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
		return sdf.format(date);
	}
	
	//조회수 check
	public void updateView_count(int notice_no) throws Exception{
		String sql = "update tbl_notice set view_count = view_count+1 where notice_no = ?";

		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){

			pstmt.setInt(1, notice_no);
			pstmt.executeUpdate();
		}
	}
	
	
	
}
