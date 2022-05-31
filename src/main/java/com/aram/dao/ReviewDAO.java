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

import com.aram.dto.ReviewDTO;

public class ReviewDAO {
private BasicDataSource bds;
	
	public ReviewDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 리뷰 등록
	public int insertReview(ReviewDTO dto)throws Exception{
		String sql = "insert into tbl_review values(seq_review_no.nextval,?,?,sysdate,?,?,?,?)";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getScore());
			pstmt.setString(4, dto.getUser_id());
			pstmt.setInt(5, dto.getItem_id());
			pstmt.setInt(6, dto.getImg_no());
			
			int rs = pstmt.executeUpdate();
			return rs;
			
		}
	}
	
	// 전체 리뷰 조회
	public ArrayList<ReviewDTO> selectAllReview() throws Exception{
		String sql = "select * from tbl_review";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);	
				){
			ResultSet rs = pstmt.executeQuery();
			
			ArrayList<ReviewDTO> list = new ArrayList<>();
			while(rs.next()) {
				int review_no = rs.getInt(1);
				String title = rs.getString(2);
				String content = rs.getString(3);
				String write_date = rs.getString(4);
				int score = rs.getInt(5);
				String user_id = rs.getString(6);
				int item_id = rs.getInt(7);
				int img_no = rs.getInt(8);
				
				list.add(new ReviewDTO(review_no, title, content, write_date, score, user_id, item_id, img_no));
			}
			return list;
		}
	}
	
	// 상품별 리뷰조회
		public ArrayList<ReviewDTO> selectAllReviewByItem(int item_no) throws Exception {
			String sql = "select * from tbl_review where item_no=?";
			try(Connection con = bds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
				pstmt.setInt(1, item_no);
				
				ResultSet rs = pstmt.executeQuery();
				
				ArrayList<ReviewDTO> list = new ArrayList<>();
				while(rs.next()) {
					int review_no = rs.getInt(1);
					String title = rs.getString(2);
					String content = rs.getString(3);
					String write_date = rs.getString(4);
					int score = rs.getInt(5);
					String user_id = rs.getString(6);
					int item_id = rs.getInt(7);
					int img_no = rs.getInt(8);
					
					list.add(new ReviewDTO(review_no, title, content, write_date, score, user_id, item_id, img_no));
				}
				return list;
			}
		}
	
		
	
	//개별 리뷰 조회
	public ReviewDTO selectReviewByNo(int review_no)throws Exception{
		String sql = "select * from tbl_review where review_no = ?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			pstmt.setInt(1, review_no);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String title = rs.getString("title");
				String content = rs.getString("content");
				String write_date = getStringDate(rs.getDate("write_date"));
				int score = rs.getInt("score");
				String user_id = rs.getString("user_id");
				int item_id = rs.getInt("item_id");
				int img_no = rs.getInt("img_no");
				
				return new ReviewDTO(review_no, title, content, write_date, score, user_id, item_id, img_no);
			}
			return null;
		}
	}
	
	// 리뷰 수정
	public int modifyReview(ReviewDTO dto)throws Exception{
		String sql = "update tbl_review set title=?,content=?,score=?, item_id=?, img_no=? where review_no=?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getScore());
			pstmt.setInt(4, dto.getItem_id());
			pstmt.setInt(5, dto.getImg_no());
			pstmt.setInt(6, dto.getReview_no());
			
			int rs = pstmt.executeUpdate();
			return rs;
		}
	}
	
	// 리뷰 삭제
	public int deleteReview(int review_no)throws Exception{
		String sql = "delete from tbl_review where review_no=?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			pstmt.setInt(1, review_no);
			
			return pstmt.executeUpdate();
		}
	}

	// Date형을 String형으로
	public String getStringDate(Date date) {
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	return sdf.format(date);
	}
	
}
