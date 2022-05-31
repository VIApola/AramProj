package com.aram.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import com.aram.dto.CartDTO;
import com.aram.dto.ItemDTO;

public class CartDAO {
	private BasicDataSource bds;
	
	public CartDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 장바구니에 제품 담기
	public int addCart(CartDTO dto) throws Exception {
		String sql = "insert into tbl_cart values (?, ?, ?)";
		try(PreparedStatement pst = bds.getConnection().prepareStatement(sql)){
			pst.setString(1, dto.getUser_id());
			pst.setString(2, dto.getItem_id());
			pst.setInt(3, dto.getQuantity());
			
			return pst.executeUpdate();
		}
	}
	
	// 유저별 장바구니에 담긴 상품 조회
	/*
	public ArrayList<CartDTO> selectAllItems(String user_id) throws Exception {
		String sql = "select * from tbl_cart where user_id=?";
		try(PreparedStatement pst = bds.getConnection().prepareStatement(sql)){
			pst.setString(1, user_id);
			
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
	*/
	
	// 장바구니 수량 수정
	public int updateQuantity(CartDTO dto) throws Exception {
		String sql = "update tbl_cart set quantity=? where user_id=? and item_id=?";
		try(PreparedStatement pst = bds.getConnection().prepareStatement(sql)){
			pst.setInt(1, dto.getQuantity());
			pst.setString(2, dto.getUser_id());
			pst.setString(3, dto.getItem_id());
			
			return pst.executeUpdate();
		}
	}

	// 장바구니 상품 삭제
	public int deleteItem(CartDTO dto) throws Exception {
		String sql = "delete from tbl_cart where user_id=? and item_id = ?";
		try(PreparedStatement pst = bds.getConnection().prepareStatement(sql)){
			pst.setString(1, dto.getUser_id());
			pst.setString(2, dto.getItem_id());
			
			return pst.executeUpdate();
		}
	}

}
