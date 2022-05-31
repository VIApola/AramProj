package com.aram.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import com.aram.dto.ItemimgDTO;

public class ImgFileDAO {
	private BasicDataSource bds;
	
	public ImgFileDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//파일 목록 전체 불러오기
	public ArrayList<ItemimgDTO> selectAll_img() throws Exception {
		String sql ="select * from tbl_item_img";
			try(Connection con = bds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)
						){
				ResultSet rs = pstmt.executeQuery();
				
				ArrayList<ItemimgDTO> list = new ArrayList<>();
				while(rs.next()) {
					int img_no = rs.getInt("img_no");
					int item_no = rs.getInt("item_no");
					String img_type = rs.getString("img_type");
					String ori_name = rs.getString("ori_name");
					String sys_name = rs.getString("sys_name");
					
					list.add(new ItemimgDTO(img_no, item_no, img_type, ori_name,sys_name));
				}
				return list;
			}
	}	
	
	//파일 개별 목록 불러오기
	public ItemimgDTO select_img(int img_no) throws Exception{
		String sql = "select * from tbl_item_img where img_no =?";
				try(Connection con = bds.getConnection();
					PreparedStatement pstmt = con.prepareStatement(sql)	
						){
					pstmt.setInt(1, img_no);
					
					ResultSet rs = pstmt.executeQuery();
				if(rs.next()) {
					int item_no = rs.getInt("item_no");
					String img_type = rs.getString("img_type");
					String ori_name = rs.getString("ori_name");
					String sys_name = rs.getString("sys_name");
					
					return new ItemimgDTO(img_no,item_no,img_type,ori_name,sys_name);			
				}
				return null;
			}
	}

	//파일 추가
	public int insert_img(ItemimgDTO dto) throws Exception{
		String sql = "insert into tbl_item_img values(seq_img_no.nextval, ?,?,?,?)";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			pstmt.setInt(1, dto.getItem_no());
			pstmt.setString(2, dto.getImg_type());
			pstmt.setString(3, dto.getOri_name());
			pstmt.setString(4, dto.getSys_name());
			
			int rs = pstmt.executeUpdate();
			return rs;
		}
	}
	
	//파일 수정
	public int modify_img(ItemimgDTO dto) throws Exception{
		String sql = "update tbl_item_img set img_title=?,img_type=?,ori_name=?,sys_name=? where img_no =?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			pstmt.setInt(1, dto.getItem_no());
			pstmt.setString(2, dto.getImg_type());
			pstmt.setString(3, dto.getOri_name());
			pstmt.setString(4, dto.getSys_name());
			pstmt.setInt(5, dto.getImg_no());
			
			int rs = pstmt.executeUpdate();
			return rs;
		}
		
	}
			
	//파일 삭제
	public int delete_img(int img_no)throws Exception{
		String sql = "delete from tbl_item_img where img_no =?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			pstmt.setInt(1, img_no);
			int rs = pstmt.executeUpdate();
			return rs;
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
			
}
