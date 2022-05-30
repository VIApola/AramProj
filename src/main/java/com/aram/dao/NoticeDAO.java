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
	
	public ArrayList<NoticeDTO> selectAll() throws Exception{
		String sql = "SELECT * FROM TBL_BOARD";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<NoticeDTO> list = new ArrayList<>();
			while(rs.next()) {
				int notice_no = rs.getInt("notice_no");
				String user_id = rs.getString("user_id");
				String title = rs.getString("title");
				String authore = rs.getString("authore");
				String write_date = getStringDate(rs.getDate("write_date"));
				String content = rs.getString("content");
				int board_views = rs.getInt("board_views");
				
				list.add(new NoticeDTO(notice_no, user_id, title, authore, write_date, content, board_views));
						
			}
			return list;
		}
	}

	private String getStringDate(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
		return sdf.format(date);
	}
	
}
