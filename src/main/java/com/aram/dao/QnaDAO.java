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

import com.aram.dto.QnaDTO;
import com.aram.utils.StringDateFormatter;

public class QnaDAO {
	
	private BasicDataSource bds = null;
	
	public QnaDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	/* QnaDAO (QnA 게시판)
	 * 
	 * qna 게시판 작성 write
	 * qna 삭제 deleteByQnA_no
	 * qna 게시글 수정 modify
	 * qna 게시글 전체 조회 qnaSelectAll
	 * qna 게시글 상세내용 조회 selectByNo
	 * 
	 * 게시판 검색 - 글쓴이(id) 기준 searchByUserId
	 * 게시판 검색 - 제목으로 검색(title) searchByTitle
	 * 
	 * 관리자페이지 Qna 내용으로 검색 - searchByContent
	 * 게시글에 관리자 댓글 입력 - insertReply
	 * rpmodifyReply
	 * 
	 * */
	
	// qna 게시글 작성
	public int write(QnaDTO dto)throws Exception {
		String sql = "INSERT into tbl_qna values(seq_qna.nextval, ?, ?, ?, sysdate, default, default, sysdate)";
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, dto.getUser_id());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			
			int rs = pstmt.executeUpdate();
			
			return rs;
		}
	}
	
	//QnA 삭제 
	public int deleteByQnA_no(int qna_no) throws Exception{
		String sql = "delete from tbl_qna where qna_no = ?";
						
		 try(Connection con = bds.getConnection();
			 PreparedStatement pstmt =  con.prepareStatement(sql)){
			    	
			    pstmt.setInt(1, qna_no);
			    	
			    return pstmt.executeUpdate();
		 }
	}
	
	
	
	// qna 게시글 삭제
	public int delete(int qna_no)throws Exception {
		String sql = "DELETE FROM tbl_qna WHERE qna_no = ?";
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setInt(1, qna_no);
			
			int rs = pstmt.executeUpdate();
			return rs;
		}
	}
	
	
	// qna 게시글 수정
	public int modify(QnaDTO dto)throws Exception{
		String sql = "UPDATE tbl_qna SET title = ?, content = ? WHERE qna_no = ?";
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getQna_no());
			
			int rs = pstmt.executeUpdate();
			return rs;
		}
	}
	
	
	// qna 게시글 조회 _ 전체
	public ArrayList<QnaDTO> qnaSelectAll() throws Exception{ 
		String sql =  "select * from tbl_qna order by 1 desc";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			try(ResultSet rs = pstmt.executeQuery()){
			
			ArrayList<QnaDTO> list = new ArrayList<>();
			while(rs.next()) {
				int notice_no = rs.getInt("qna_no");
				String user_id = rs.getString("user_id");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String write_date = StringDateFormatter.getStringDate(rs.getDate("write_date"));
				boolean answer_yn = rs.getBoolean("answer_yn");
				String answer = rs.getString("answer");
				String answer_date = StringDateFormatter.getStringDate(rs.getDate("answer_date"));
				
				list.add(new QnaDTO(notice_no, user_id, title, content, write_date, answer_yn, answer, answer_date));
				
			}
			return list;
		}
	}
	}
	
	//qna 게시글 조회 _ 부분 (detailview)
	public QnaDTO selectByNo(int qna_no) throws Exception{
		String sql = "SELECT * FROM tbl_qna Where qna_no = ?";
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setInt(1, qna_no);
			
			try(ResultSet rs = pstmt.executeQuery()){
			
			if(rs.next()) {
				String user_id = rs.getString("user_id");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String write_date = StringDateFormatter.getStringDate(rs.getDate("write_date"));
				Boolean answer_yn = rs.getBoolean("answer_yn");
				String answer = rs.getString("answer");
				String answer_date = StringDateFormatter.getStringDate(rs.getDate("answer_date"));
				QnaDTO dto = new QnaDTO(qna_no, user_id, title, content, write_date, answer_yn, answer, answer_date);
				return dto;
			}
			return null;
		}
	}

	}

	// Qna 게시판 게시글 검색
	// id(글쓴이)로 검색
	public ArrayList<QnaDTO> searchByUserId(String searchByUserId) throws Exception {
		String sql = "select * from tbl_qna where user_id = ? order by 1 desc";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, searchByUserId);
			
			try(ResultSet rs = pstmt.executeQuery()){
				
				ArrayList<QnaDTO> list = new ArrayList<>();
				while(rs.next()) {
					int qna_no = rs.getInt("qna_no");
					String user_id = rs.getString("user_id");
					String title = rs.getString("title");
					String content = rs.getString("content");
					String write_date = StringDateFormatter.getStringDate(rs.getDate("write_date"));
					boolean answer_yn = rs.getBoolean("answer_yn");
					String answer = rs.getString("answer");
					String answer_date = StringDateFormatter.getStringDate(rs.getDate("answer_date"));

					list.add(new QnaDTO(qna_no, user_id, title, content, write_date, answer_yn, answer, answer_date));
				
					System.out.println(list);
				}
				return list;
			}
		}
	}
		
	// 제목으로 검색
	public ArrayList<QnaDTO> searchByTitle(String searchTitle) throws Exception {
		String sql = "select * from tbl_qna where title like '%'||?||'%' order by 1 desc";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, searchTitle);
			
			try(ResultSet rs = pstmt.executeQuery()){
			ArrayList<QnaDTO> list = new ArrayList<>();
			
				while(rs.next()) {
					int qna_no = rs.getInt("qna_no");
					String user_id = rs.getString("user_id");
					String title = rs.getString("title");
					String content = rs.getString("content");
					String write_date = StringDateFormatter.getStringDate(rs.getDate("write_date"));
					boolean answer_yn = rs.getBoolean("answer_yn");
					String answer = rs.getString("answer");
					String answer_date = StringDateFormatter.getStringDate(rs.getDate("answer_date"));
					
					list.add(new QnaDTO(qna_no, user_id, title, content, write_date, answer_yn, answer, answer_date));
				}
				
				System.out.println(list);
				return list;
			}
		}

	}

		//관리자페이지 - Q&A관리 내용으로 검색
		public ArrayList<QnaDTO> searchByContent(String contents) throws Exception{
			String sql = "select * from tbl_qna where content like '%'||?||'%' order by 1 desc";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, contents);
				

				try(ResultSet rs = pstmt.executeQuery()){
				ArrayList<QnaDTO> list = new ArrayList<>();
				while(rs.next()) {
					int qna_no = rs.getInt("qna_no");
					String user_id = rs.getString("user_id");
					String title = rs.getString("title");
					String content = rs.getString("content");
					String write_date = StringDateFormatter.getStringDate(rs.getDate("write_date"));
					boolean answer_yn = rs.getBoolean("answer_yn");
					String answer = rs.getString("answer");
					String answer_date = StringDateFormatter.getStringDate(rs.getDate("answer_date"));
				
					list.add(new QnaDTO(qna_no, user_id, title, content, write_date, answer_yn, answer, answer_date));
					
					System.out.println(list);
				}
				return list;
			}
			
			}	
			}

		
		//게시글에 관리자 댓글입력
		public int insertReply(int qna_no, String answer) throws Exception{
			String sql = "update tbl_qna set answer_yn ='y',answer=?,answer_date = sysdate where qna_no = ?";
			
			try(Connection con = bds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
				
				pstmt.setString(1, answer);
				pstmt.setInt(2, qna_no);
				
				return pstmt.executeUpdate();
				
				
			}
		}
		
		//게시글 관리자 댓글 수정
		public int modifyReply(int qna_no, String answer) throws Exception{
			String sql = "update tbl_qna set answer=? where qna_no = ?";
			
			try(Connection con = bds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
				
				pstmt.setString(1, answer);
				pstmt.setInt(2, qna_no);
				
				return pstmt.executeUpdate();
				
				
			}
		}
		
		//게시글 관리자 댓글 삭제
		public int deleteReply(int qna_no) throws Exception{
			String sql = "update tbl_qna set answer_yn ='n',answer=null where qna_no = ?";
			
			try(Connection con = bds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
				
				pstmt.setInt(1, qna_no);
				
				return pstmt.executeUpdate();
				
				
			}
		}
		
}
