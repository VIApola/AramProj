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
	
	
	// 페이징
//	public HashMap<String, Object> getPageNavi(int curPage) throws Exception {
//		String sql = "SELECT count(*) as totalCnt FROM tbl_notice";
//		try(Connection con = bds.getConnection();
//			PreparedStatement pstmt = con.prepareStatement(sql)){
//			
//			ResultSet rs = pstmt.executeQuery();
//			rs.next();
//			// DB에서 전체 게시글 개수 조회
//			int totalCnt = rs.getInt("totalCnt"); 
//			int recordCntPerPage = 10; // 한페이지에 몇개의 데이터를 띄워줄지
//			int naviCntPerPage = 5; // 페이지 네비바의 개수
//			int pageTotalCnt = 0; // 총 몇 페이지가 나올지
//			
//			
//			// 총 페이지 개수를 구하는 연산
//			if(totalCnt % recordCntPerPage > 0) { // 나머지가 있을때 + 1
//				pageTotalCnt = totalCnt / recordCntPerPage + 1;
//			} else {
//				pageTotalCnt = totalCnt / recordCntPerPage;
//			}
//			
//			if(curPage < 1 ) { 
//				curPage = 1; 
//				
//			}else if(curPage > pageTotalCnt) { 
//				curPage = pageTotalCnt; 
//			}
//			
//			int startNavi = ((curPage -1) / naviCntPerPage) * naviCntPerPage + 1;
//
//			int endNavi = startNavi + naviCntPerPage - 1;
//			
//			if(pageTotalCnt < endNavi) {
//				endNavi = pageTotalCnt; 
//				
//			}
//
//			
//			boolean needPrev = true; 
//			boolean needNext = true; 
//			
//			if(startNavi == 1) {
//				needPrev = false;
//			}
//			if(endNavi == pageTotalCnt) {
//				needNext = false;
//			}
//			
//	
//
//			HashMap<String, Object> map = new HashMap<>();
//
//			map.put("startNavi", startNavi);
//			map.put("endNavi", endNavi);
//	
//			map.put("needPrev", needPrev);
//			map.put("needNext", needNext);
//			
//			return map;
//		}
//	}
	
}
