package com.aram.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.jasper.compiler.Node.CustomTag;
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
		String sql = "insert into tbl_order values (?,?,?,sysdate,'주문대기중',?,?,?,?,?)";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			pstmt.setInt(1, dto.getOrder_no());
			pstmt.setString(2, dto.getUser_id());
			pstmt.setString(3, dto.getOrder_name());
			pstmt.setString(4, dto.getDelivery_name());
			pstmt.setString(5, dto.getDelivery_addr());
			pstmt.setString(6, dto.getOrder_msg());
			pstmt.setString(7, dto.getDelivery_msg());
			
			return pstmt.executeUpdate();
		}
	}
	
	// 장바구니에 담긴 상품 -> 주문대기 테이블로
	public int cartToOrder(OrderItemDTO dto) throws Exception {
		String sql = "insert into tbl_order_item values (?,?,?,?,?)";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setInt(1, dto.getOrder_no());
			pstmt.setInt(2, dto.getItem_no());
			pstmt.setString(3, dto.getItem_name());
			pstmt.setInt(4, dto.getPrice());
			pstmt.setInt(5, dto.getQuantity());

			return pstmt.executeUpdate();
		}
	}
	
	// 전체목록 
	public ArrayList<OrderDTO> selectAllOrder() throws Exception{
		String sql = "select * from tbl_order";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			ResultSet rs= pstmt.executeQuery();
			
			ArrayList<OrderDTO> list = new ArrayList<>();
			while(rs.next()) {
				 int order_no = rs.getInt(1);
				 String user_id	= rs.getString(2);
				 String order_name = rs.getString(3);
				 String order_date = rs.getString(4);
				 String order_state = rs.getString(5);
				 String delivery_name = rs.getString(6);
				 String delivery_addr = rs.getString(7);
				 String order_msg = rs.getString(8);
				 String delivery_msg = rs.getString(9);
				
				 list.add(new OrderDTO(order_no, user_id, order_name, order_date, order_state, delivery_name, delivery_addr, order_msg, delivery_msg));
				 
			}
			return list;
		}
	}
	
	
	
	// 개별목록
	public OrderDTO selectOrder(int order_no) throws Exception{
		String sql = "select * from tbl_order where order_no = ?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			pstmt.setInt(1, order_no);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				 String user_id	= rs.getString(2);
				 String order_name = rs.getString(3);
				 String order_date = rs.getString(4);
				 int quantity = rs.getInt(5);
				 String order_amount = rs.getString(6);
				 String delivery_addr = rs.getString(7);
				 String delivery_name = rs.getString(8);
				 String order_msg = rs.getString(9);
				 String delivery_msg = rs.getString(10);
				 return new OrderDTO(order_no, user_id, order_name, order_date, quantity, order_amount, delivery_addr, delivery_name, order_msg, delivery_msg);
			}
			return null;
		}
	}
	
	// 수정
	public int modifyOrder(OrderDTO dto)throws Exception{
		String sql = "update tbl_order set quanity=?,order_amount=?,delivery_addr=?,delivery_name=?,order_msg=?,delivery_msg=? where order_no=?";
			try(Connection con = bds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)	
					){
				pstmt.setString(2, dto.getOrder_amount());
				pstmt.setString(3, dto.getDelivery_addr());
				pstmt.setString(4, dto.getDelivery_name());
				pstmt.setString(5, dto.getOrder_msg());
				pstmt.setString(6, dto.getDelivery_msg());
				pstmt.setInt(7, dto.getOrder_no());
				
				int rs = pstmt.executeUpdate();
				return rs;	
			}
	}
	
	// 주문서 삭제 (관리자)
	public int deleteOrder(int order_no)throws Exception{
		String sql = "delete from tbl_order where order_no = ?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			pstmt.setInt(1, order_no);
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
