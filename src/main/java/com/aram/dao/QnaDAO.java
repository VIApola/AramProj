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

import com.aram.dto.NoticeDTO;
import com.aram.dto.QnaDTO;

public class QnaDAO {
	private BasicDataSource bds;
	
	public QnaDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<QnaDTO> qnaSelectAll() throws Exception{ 
		String sql =  "select * from tbl_qna order by 1 desc";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			ResultSet rs = pstmt.executeQuery();
			
			ArrayList<QnaDTO> list = new ArrayList<>();
			while(rs.next()) {
				int notice_no = rs.getInt("qna_no");
				String user_id = rs.getString("user_id");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String write_date = getStringDate(rs.getDate("write_date"));
				boolean answer_yn = rs.getBoolean("answer_yn");
				String answer = rs.getString("answer");
				String answer_date = getStringDate(rs.getDate("answer_date"));
				

				
				list.add(new QnaDTO(notice_no, user_id, title, content, write_date, answer_yn, answer, answer_date));
				
			}
			return list;
		}
	}
	
	public String getStringDate(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
		return sdf.format(date);
	}
	
	// 세션을 통한 검색
		// 글쓴이로 검색
		public ArrayList<QnaDTO> searchByUserId(String searchByUserId) throws Exception{
			String sql = "select * from tbl_qna where user_id = ? order by 1 desc";
			try(Connection con = bds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
				
				pstmt.setString(1, searchByUserId);
				
				ResultSet rs = pstmt.executeQuery();
				ArrayList<QnaDTO> list = new ArrayList<>();
				while(rs.next()) {
					int qna_no = rs.getInt("qna_no");
					String user_id = rs.getString("user_id");
					String title = rs.getString("title");
					String content = rs.getString("content");
					String write_date = getStringDate(rs.getDate("write_date"));
					boolean answer_yn = rs.getBoolean("answer_yn");
					String answer = rs.getString("answer");
					String answer_date = getStringDate(rs.getDate("answer_date"));

					
					
					list.add(new QnaDTO(qna_no, user_id, title, content, write_date, answer_yn, answer, answer_date));
					
					System.out.println(list);
				}
				return list;
			}
		}
		
		// 제목으로 검색
		public ArrayList<QnaDTO> searchByTitle(String searchTitle) throws Exception{
			String sql = "select * from tbl_qna where title = ? order by 1 desc";
			try(Connection con = bds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
				
				pstmt.setString(1, searchTitle);
				
				ResultSet rs = pstmt.executeQuery();
				ArrayList<QnaDTO> list = new ArrayList<>();
				while(rs.next()) {
					int qna_no = rs.getInt("qna_no");
					String user_id = rs.getString("user_id");
					String title = rs.getString("title");
					String content = rs.getString("content");
					String write_date = getStringDate(rs.getDate("write_date"));
					boolean answer_yn = rs.getBoolean("answer_yn");
					String answer = rs.getString("answer");
					String answer_date = getStringDate(rs.getDate("answer_date"));

					
					
					list.add(new QnaDTO(qna_no, user_id, title, content, write_date, answer_yn, answer, answer_date));
					
					System.out.println(list);
				}
				return list;
			}
		}
	

}
