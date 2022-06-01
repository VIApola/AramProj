package com.aram.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import com.aram.dto.OrderDTO;

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
	
	// 생성
	public int insert(OrderDTO dto)throws Exception{
		
		String sql = "insert into tbl_order values (?,?,?,sysdate,?,?,?,?,?,?)";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			pstmt.setInt(1, dto.getOrder_no());
			pstmt.setString(2, dto.getUser_id());
			pstmt.setString(3, dto.getOrder_name());
			pstmt.setInt(4, dto.getQuantity());
			pstmt.setString(5, dto.getOrder_amount());
			pstmt.setString(6, dto.getDelivery_addr());
			pstmt.setString(7, dto.getDelivery_name());
			pstmt.setString(8, dto.getOrder_msg());
			pstmt.setString(9, dto.getDelivery_msg());
			
			int rs = pstmt.executeUpdate();
			return rs;
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
				 int quantity = rs.getInt(5);
				 String order_amount = rs.getString(6);
				 String delivery_addr = rs.getString(7);
				 String delivery_name = rs.getString(8);
				 String order_msg = rs.getString(9);
				 String delivery_msg = rs.getString(10);
				
				 list.add(new OrderDTO(order_no, user_id, order_name, order_date, quantity, order_amount, delivery_addr, delivery_name, order_msg, delivery_msg));
				 
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
				pstmt.setInt(1, dto.getQuantity());
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
	
	
	// 삭제
	public int deleteOrder(int order_no)throws Exception{
		String sql = "delete from tbl_order where order_no = ?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
				){
			pstmt.setInt(1, order_no);
			return pstmt.executeUpdate();
		}
	}


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
