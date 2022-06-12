package com.aram.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import com.aram.dto.NoticeDTO;
import com.aram.utils.StringDateFormatter;

public class NoticeDAO {
	
	private BasicDataSource bds = null;
	
	public NoticeDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/* NoticeDAO (공지사항 게시판)
	 * 
	 * 게시글 작성 write
	 * 게시글 삭제 delete
	 * 게시글 수정 modify
	 * 상세검색 - 글쓴이로 검색 searchByAuthor
	 * 상세검색 - 제목으로 탐색 searhByTitle
	 * 게시글 전체 조회 selectAll
	 * 번호로 게시글 조회 selectBySeq
	 * 게시글 조회수 증가체크 updateView_count
	 * 
	 * */
	
	// Notice 게시글 작성
	public int write(NoticeDTO dto) throws Exception{
		String sql = "INSERT INTO tbl_notice VALUES(seq_notice.nextval, ?, ?, ?, sysdate, ?, default)";

		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){

			pstmt.setString(1, dto.getUser_id());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getAuthor());
			pstmt.setString(4, dto.getContent());
			
			int rs = pstmt.executeUpdate();
			return rs;
		}
	}
	
	// 게시글 삭제
	public int delete(int notice_no) throws Exception{
		String sql = "DELETE FROM tbl_notice WHERE notice_no = ?";
		
		try (Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setInt(1, notice_no);
			
			int rs = pstmt.executeUpdate();
			return rs;
			
		}
				
	}
	
	// 게시글 수정
	public int modify(NoticeDTO dto) throws Exception{
		String sql = "UPDATE tbl_notice SET title =?, content = ? WHERE notice_no = ?";
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getNotice_no());
			
			int rs = pstmt.executeUpdate();
			return rs;
		}
	}
	
	
	// 글쓴이와 타이틀로 상세검색
	// 글쓴이로 검색
	public ArrayList<NoticeDTO> searchByAuthor(String searchAuthor) throws Exception {
		String sql = "SELECT * FROM tbl_notice WHERE author = ? order by 1 desc";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, searchAuthor);
			
			try(ResultSet rs = pstmt.executeQuery()){
			ArrayList<NoticeDTO> list = new ArrayList<>();
			while(rs.next()) {
				int notice_no = rs.getInt("notice_no");
				String user_id = rs.getString("user_id");
				String title = rs.getString("title");
				String author = rs.getString("author");
				String write_date = StringDateFormatter.getStringDate(rs.getDate("write_date"));
				String content = rs.getString("content");
				int board_views = rs.getInt("board_views");
				list.add(new NoticeDTO(notice_no, user_id, title, author, write_date, content, board_views));
				
				System.out.println(list);
			}
			return list;
		}
	}
	}
	// 제목으로 검색
	public ArrayList<NoticeDTO> searchByTitle(String searchTitle) throws Exception{
		String sql = "SELECT * FROM tbl_notice WHERE title = ? order by 1 desc";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, searchTitle);
			
			try(ResultSet rs = pstmt.executeQuery()){
			ArrayList<NoticeDTO> list = new ArrayList<>();
			while(rs.next()) {
				int notice_no = rs.getInt("notice_no");
				String user_id = rs.getString("user_id");
				String title = rs.getString("title");
				String author = rs.getString("author");
				String write_date = StringDateFormatter.getStringDate(rs.getDate("write_date"));
				String content = rs.getString("content");
				int board_views = rs.getInt("board_views");
				list.add(new NoticeDTO(notice_no, user_id, title, author, write_date, content, board_views));
				
				System.out.println(list);
			}
			return list;
		}
	}
	
	}
	// 게시글 전체 조회
	public ArrayList<NoticeDTO> selectAll(int start, int end) throws Exception { 
		String sql =  "SELECT * from (select tbl_notice.*, row_number() over(order by notice_no desc) as num from tbl_notice)"
				+ " where num between ? and ?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			try(ResultSet rs = pstmt.executeQuery()){
			
			ArrayList<NoticeDTO> list = new ArrayList<>();
			while(rs.next()) {
				int notice_no = rs.getInt("notice_no");
				String user_id = rs.getString("user_id");
				String title = rs.getString("title");
				String author = rs.getString("author");
				String write_date = StringDateFormatter.getStringDate(rs.getDate("write_date"));
				String content = rs.getString("content");
				int board_views = rs.getInt("board_views");
				
				list.add(new NoticeDTO(notice_no, user_id, title, author, write_date, content, board_views));
				
			}
			System.out.println(list);
			return list;
		}
	}
	}
	
	//게시글 부분 조회
	public NoticeDTO selectBySeq(int notice_no) throws Exception {
		String sql = "SELECT * FROM tbl_notice WHERE notice_no = ?";

		try(Connection con = bds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){

			pstmt.setInt(1, notice_no);
			try(ResultSet rs = pstmt.executeQuery()){

				if(rs.next()) {
					String user_id = rs.getString("user_id");
					String title = rs.getString("title");
					String author = rs.getString("author");
					String write_date = StringDateFormatter.getStringDate(rs.getDate("write_date"));
					String content = rs.getString("content");
					int board_views = rs.getInt("board_views");
					NoticeDTO dto = new NoticeDTO(notice_no, user_id, title, author, write_date, content, board_views);
					return dto;
				}
				return null;
			}
		}
	}
	
	public int totalNoticeCnt() throws Exception {
		String sql = "select count(*) from tbl_notice";
		try(Connection con = bds.getConnection();
			PreparedStatement pst = con.prepareStatement(sql) ){
			
			ResultSet rs = pst.executeQuery();
			
			rs.next();
			return rs.getInt(1);
			
		}
	}
	
	//조회수 check
	public void updateView_count(int notice_no) throws Exception{
		String sql = "UPDATE tbl_notice SET board_views = board_views+1 WHERE notice_no = ?";

		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){

			pstmt.setInt(1, notice_no);
			pstmt.executeUpdate();
		}
	}
	
	
}
