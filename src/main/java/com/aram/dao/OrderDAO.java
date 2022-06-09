package com.aram.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import com.aram.dto.OrderDTO;
import com.aram.dto.OrderItemDTO;

public class OrderDAO {
	private BasicDataSource bds;
	
	public OrderDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 주문서 생성
	public int createOrder(OrderDTO dto)throws Exception {
		String sql = "insert into tbl_order values (?,?,?,?,?,sysdate,?,'주문대기중',?,?,?,?,?)";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			pstmt.setString(1, dto.getOrder_no());
			pstmt.setString(2, dto.getUser_id());
			pstmt.setString(3, dto.getOrder_name());
			pstmt.setString(4, dto.getOrder_email());
			pstmt.setString(5, dto.getOrder_phone());
			pstmt.setInt(6, dto.getOrder_amount());
			pstmt.setString(7, dto.getDelivery_name());
			pstmt.setString(8, dto.getDelivery_phone());
			pstmt.setString(9, dto.getDelivery_addr());
			pstmt.setString(10, dto.getOrder_msg());
			pstmt.setString(11, dto.getDelivery_msg());
			
			return pstmt.executeUpdate();
		}
	}
	
	// 장바구니에 담긴 상품 -> 주문대기 테이블로
	public int cartToOrder(OrderItemDTO dto) throws Exception {
		String sql = "insert into tbl_order_item values (?,?,?,?,?)";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setString(1, dto.getOrder_no());
			pstmt.setInt(2, dto.getItem_no());
			pstmt.setString(3, dto.getItem_name());
			pstmt.setInt(4, dto.getPrice());
			pstmt.setInt(5, dto.getQuantity());

			return pstmt.executeUpdate();
		}
	}
	
	// 주문대기 테이블에서 주문번호 기준으로 상품리스트 가져오기
	public ArrayList<OrderItemDTO> selectOrderedItems(String order_no) throws Exception {
		String sql = "select * from tbl_order_item where order_no=?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setString(1, order_no);
			
			ResultSet rs = pstmt.executeQuery();
			
			ArrayList<OrderItemDTO> orderList = new ArrayList<OrderItemDTO>();
			
			while (rs.next()) {
				int item_no = rs.getInt("item_no");
				String item_name = rs.getString("item_name");
				int price = rs.getInt("price");
				int quantity = rs.getInt("quantity");
				
				orderList.add(new OrderItemDTO(order_no, item_no, item_name, price, quantity));
			}
			return orderList;
		}
	}
	
	
	// 전체목록 
	public ArrayList<OrderDTO> selectAllOrder() throws Exception {
		String sql = "select * from tbl_order";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			ResultSet rs= pstmt.executeQuery();
			
			ArrayList<OrderDTO> list = new ArrayList<>();
			while(rs.next()) {
				 String order_no = rs.getString(1);
				 String user_id	= rs.getString(2);
				 String order_name = rs.getString(3);
				 String order_email = rs.getString(4);
				 String order_phone = rs.getString(5);
				 String order_date = rs.getString(6);
				 int order_amount = rs.getInt(7);
				 String order_state = rs.getString(8);
				 String delivery_name = rs.getString(9);
				 String delivery_phone = rs.getString(10);
				 String delivery_addr = rs.getString(11);
				 String order_msg = rs.getString(12);
				 String delivery_msg = rs.getString(13);
				
				 list.add(new OrderDTO(order_no, user_id, order_name, order_email, order_phone,
						 				order_date, order_amount, order_state, delivery_name, 
						 				delivery_phone ,delivery_addr, order_msg, delivery_msg));
				 
			}
			return list;
		}
	}
	
	
	// 개별목록
	public OrderDTO selectOrder(String order_no) throws Exception{
		String sql = "select * from tbl_order where order_no = ?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			pstmt.setString(1, order_no);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				 String user_id	= rs.getString(2);
				 String order_name = rs.getString(3);
				 String order_email = rs.getString(4);
				 String order_phone = rs.getString(5);
				 String order_date = rs.getString(6);
				 int order_amount = rs.getInt(7);
				 String order_state = rs.getString(8);
				 String delivery_name = rs.getString(9);
				 String delivery_phone = rs.getString(10);
				 String delivery_addr = rs.getString(11);
				 String order_msg = rs.getString(12);
				 String delivery_msg = rs.getString(13);
				 
				 return new OrderDTO(order_no, user_id, order_name, order_email, order_phone,
			 				order_date, order_amount, order_state, delivery_name, 
			 				delivery_phone ,delivery_addr, order_msg, delivery_msg);
			}
			return null;
		}
	}
	
	// 수정
//	public int modifyOrder(OrderDTO dto)throws Exception {
//		String sql = "update tbl_order set quanity=?, order_amount=?, delivery_addr=?, delivery_name=?, order_msg=?, delivery_msg=? where order_no=?";
//			try(Connection con = bds.getConnection();
//				PreparedStatement pstmt = con.prepareStatement(sql)	
//					){
//				pstmt.setInt(1, dto.getorder);
//				pstmt.setString(2, dto.getOrder_amount());
//				pstmt.setString(3, dto.getDelivery_addr());
//				pstmt.setString(4, dto.getDelivery_name());
//				pstmt.setString(5, dto.getOrder_msg());
//				pstmt.setString(6, dto.getDelivery_msg());
//				pstmt.setInt(7, dto.getOrder_no());
//				
//				int rs = pstmt.executeUpdate();
//				return rs;	
//			}
//	}
	
	// 주문서 삭제 (관리자)
	public int deleteOrder(String order_no)throws Exception{
		String sql = "delete from tbl_order where order_no = ?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			pstmt.setString(1, order_no);
			return pstmt.executeUpdate();
		}
	}

	// 주문서 번호 미리 가져오기
	public int getOrderNo() throws Exception {
		String sql = "select seq_order_no.nextval from dual";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			ResultSet rs = pstmt.executeQuery();
			rs.next();

			return rs.getInt(1);
		}
	}
	
}
