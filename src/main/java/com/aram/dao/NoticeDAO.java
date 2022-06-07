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
	public ArrayList<NoticeDTO> searchByAuthor(String searchAuthor) throws Exception{
		String sql = "SELECT * FROM tbl_notice WHERE author = ? order by 1 desc";
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
		String sql = "SELECT * FROM tbl_notice WHERE title = ? order by 1 desc";
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
	
	
	// 게시글 전체 조회
	public ArrayList<NoticeDTO> selectAll(int start, int end) throws Exception{ 
		String sql =  "SELECT * from (select tbl_notice.*, row_number() over(order by notice_no desc) as num from tbl_notice)"
				+ " where num between ? and ?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
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

	
	//게시글 부분 조회
	public NoticeDTO selectBySeq(int notice_no) throws Exception{
		String sql = "SELECT * FROM tbl_notice WHERE notice_no = ?";

		try(Connection con = bds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){

			pstmt.setInt(1, notice_no);
			ResultSet rs = pstmt.executeQuery();

			if(rs.next()) {
				String user_id = rs.getString("user_id");
				String title = rs.getString("title");
				String author = rs.getString("author");
				String write_date = getStringDate(rs.getDate("write_date"));
				String content = rs.getString("content");
				int board_views = rs.getInt("board_views");
				NoticeDTO dto = new NoticeDTO(notice_no, user_id, title, author, write_date, content, board_views);
				return dto;
			}
			return null;
		}
	}
	
	// 날짜 String으로 변환
	public String getStringDate(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
		return sdf.format(date);
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
	
	//페이징 
	public HashMap<String, Object> getPageNavi(int curPage) throws Exception{
		   String sql = "select count(*) as totalCnt from tbl_notice";
		 	   
		   try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
			   
			   ResultSet rs = pstmt.executeQuery();
			   rs.next();
			   
			    int totalCnt = rs.getInt("totalCnt");
			   
				int recordCntPerPage = 10; 
				
				int naviCntPerPage = 5; 
				
				int pageTotalCnt = 0; 
				
				
				//10개씩 한페이지 -> pageTotalCnt
				
				
				if(totalCnt % recordCntPerPage > 0) {
					pageTotalCnt = totalCnt/recordCntPerPage + 1;
				}else {
					pageTotalCnt = totalCnt/recordCntPerPage;
				}
				
				if(curPage < 1) {
					curPage = 1;
				}else if(curPage>pageTotalCnt) {
					curPage = pageTotalCnt;
				}
				
				int startNavi = ((curPage-1)/naviCntPerPage) * naviCntPerPage + 1;
				int endNavi = startNavi + naviCntPerPage - 1;
				
				
				if(pageTotalCnt < endNavi) {
					endNavi = pageTotalCnt; 
				}
				
				boolean needPrev =  true; 
				boolean needNext = true; 
				
				if(startNavi == 1) {
					needPrev = false;
				}
				if(endNavi == pageTotalCnt) {
					needNext = false;
				}
				
				HashMap<String, Object> map = new HashMap<>();
				
				map.put("startNavi", startNavi);
				map.put("endNavi", endNavi);
				map.put("needPrev", needPrev);
				map.put("needNext", needNext);
				
				return map;
				
				
		  }
		   
	   }
	
	
}
