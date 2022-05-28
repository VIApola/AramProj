package com.aram.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import com.aram.dto.ItemDTO;

public class ItemDAO {
	private BasicDataSource bds;
	
	public ItemDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 제품 등록
	public int insertItem(ItemDTO dto) throws Exception {
		String sql = "insert into tbl_items values (?, ?, ?, ?, sysdate, ?, ?, ?)";
		try(PreparedStatement pst = bds.getConnection().prepareStatement(sql)){
			pst.setInt(1, dto.getItem_id());
			pst.setString(2, dto.getItem_name());
			pst.setInt(3, dto.getPrice());
			pst.setString(4, dto.getItem_comment());
			pst.setInt(5, dto.getItem_stock());
			pst.setString(6, dto.getCategory_id());
			pst.setInt(7, dto.getImg_no());			
			
			return pst.executeUpdate();
		}
	}
	
	// 전체 상품 조회
	public ArrayList<ItemDTO> selectAllItems() throws Exception {
		String sql = "select * from tbl_items";
		try(PreparedStatement pst = bds.getConnection().prepareStatement(sql)){
			ResultSet rs = pst.executeQuery();
			
			ArrayList<ItemDTO> list = new ArrayList<>();
			while(rs.next()) {
				int item_id = rs.getInt("item_id");
				String item_name = rs.getString("item_name");
				int price = rs.getInt("price");
				String item_comment = rs.getString("item_comment");
				//String item_regdate = (String)rs.getDate("item_regdate");
				int item_stock = rs.getInt("item_stock");
				String category_id = rs.getString("category_id");
				int img_no = rs.getInt("img_no");
				
				list.add(new ItemDTO(item_id, item_name, price, item_comment, null, item_stock, category_id, img_no));
			}
			return list;
			
		}
	}
	
	// 제품번호별 세부 상품 조회
	public ItemDTO selectItemByNo(int item_id) throws Exception {
		String sql = "select * from tbl_items where item_id = ?";
		try(PreparedStatement pst = bds.getConnection().prepareStatement(sql)){
			pst.setInt(1, item_id);
			ResultSet rs = pst.executeQuery();
			
			if(rs.next()) {
				// String item_id = rs.getString("item_id");
				String item_name = rs.getString("item_name");
				int price = rs.getInt("price");
				String item_comment = rs.getString("item_comment");
				//String item_regdate = (String)rs.getDate("item_regdate");
				int item_stock = rs.getInt("item_stock");
				String category_id = rs.getString("category_id");
				int img_no = rs.getInt("img_no");
				
				return new ItemDTO(item_id, item_name, price, item_comment, null, item_stock, category_id, img_no);
			}
			return null;
		}
	}
	
	// 제품 정보 수정
	public int updateItem(ItemDTO dto) throws Exception {
		String sql = "update tbl_items set item_name=?, price=?, item_comment=?, item_stock=?, category_id=?, img_no=?";
		try(PreparedStatement pst = bds.getConnection().prepareStatement(sql)){
			pst.setString(1, dto.getItem_name());
			pst.setInt(2, dto.getPrice());
			pst.setString(3, dto.getItem_comment());
			pst.setInt(4, dto.getItem_stock());
			pst.setString(5, dto.getCategory_id());
			pst.setInt(6, dto.getImg_no());
			
			return pst.executeUpdate();
		}
	}

	// 등록된 제품 삭제
	public int deleteItem(int item_id) throws Exception {
		String sql = "delete from tbl_items where item_id = ?";
		try(PreparedStatement pst = bds.getConnection().prepareStatement(sql)){
			pst.setInt(1, item_id);	
			
			return pst.executeUpdate();
		}
	}
	
}
