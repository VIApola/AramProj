package com.aram.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import com.aram.dto.CartDTO;
import com.aram.dto.Cart_ItemDTO;
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

	//카트에 담긴 값 main으로 뿌려주기위해 전체 조회
	//메인에서 if로 user_id와 로그인세션의 user_id가 같다면
	//quantity의 값을 가져와 뿌려줘야함

	
	// 장바구니에 item 전체 데이터 출력
		public ArrayList<Cart_ItemDTO> selectAll()throws Exception{
			String sql = "select * from tbl_cart join tbl_items on tbl_cart.item_no = tbl_items.item_no";
			try(Connection con = bds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)	
					){
				ResultSet rs = pstmt.executeQuery();
				
				ArrayList<Cart_ItemDTO> list = new ArrayList<>();
				while(rs.next()) {
					String user_id = rs.getString("user_id");
					int item_no = rs.getInt("item_no");
					int quantity = rs.getInt("quantity");
					String item_name = rs.getString("item_name");
					int price = rs.getInt("price");
					String item_comment = rs.getString("item_comment");
					String item_regdate = rs.getString("item_regdate");
					int item_stock = rs.getInt("item_stock");
					String category_id = rs.getString("category_id");
					int img_no = rs.getInt("img_no");
					
					list.add(new Cart_ItemDTO(user_id,item_no,quantity,item_name,price,item_comment,item_regdate,item_stock,category_id,img_no));
				}
				return list;
			}
		}
		
		
	// 장바구니에 제품 담기
	public int addCart(CartDTO dto) throws Exception {
		String sql = "insert into tbl_cart values (?, ?, ?)";
		try(PreparedStatement pst = bds.getConnection().prepareStatement(sql)){
			pst.setString(1, dto.getUser_id());
			pst.setInt(2, dto.getItem_no());
			pst.setInt(3, dto.getQuantity());
			
			return pst.executeUpdate();
		}
	}
	
	// 장바구니 상품 삭제
	public int deleteItem(String user_id, int item_no) throws Exception {
		String sql = "delete from tbl_cart where user_id=? and item_no = ?";
		try(PreparedStatement pst = bds.getConnection().prepareStatement(sql)){
			pst.setString(1, user_id);
			pst.setInt(2, item_no);
			
			return pst.executeUpdate();
		}
	}
	
	
	//해당 물품이 장바구니에 있는 물품인지 확인 - 없을 시 true, 있으면 false
	public boolean existItem(int item_no)throws Exception{
		String sql = "select count(*) as count from tbl_cart where item_no = ?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			pstmt.setInt(1, item_no);
			
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			
			if(rs.getInt("count") == 0) { // 현재 장바구니에 없는 아이템 
				return true;
			}else { // 장바구니에 이미 존재하는 아이템
				return false;
			}
			
		}
	}
	

	
	
	// 장바구니 수량 추가
	public int updateQuantity(int quantity, String user_id, int item_no) throws Exception {
		String sql = "update tbl_cart set quantity= quantity+? where user_id=? and item_no=?";
		try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
				
			pstmt.setInt(1, quantity);
			pstmt.setString(2, user_id);
			pstmt.setInt(3, item_no);
			
			
			return pstmt.executeUpdate();
		}
	}
	
	
	public int length(String[] checkVals) {
		if(checkVals == null) {
			return 0;
		}
		return checkVals.length;
	}
	
	
	public int total(String user_id) throws Exception{
		String sql = "select price, quantity from tbl_cart left join tbl_items on tbl_cart.item_no = tbl_items.item_no where user_id = ? ";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			pstmt.setString(1, user_id);
			
			ResultSet rs = pstmt.executeQuery();
			
			int total = 0;
			while(rs.next()) {
				int price = rs.getInt("price");
				int quantity = rs.getInt("quantity");
				
				total = total + (price * quantity);
			}
				return total;
		}
	}




	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
