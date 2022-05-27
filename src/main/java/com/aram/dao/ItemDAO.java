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

	
	public ArrayList<ItemDTO> selectAll() throws Exception{
		String sql ="select * from tbl_items";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)	
					){
			
			ResultSet rs = pstmt.executeQuery();
			
			ArrayList<ItemDTO> list = new ArrayList<>();
			
			while(rs.next()) {
				int item_id = rs.getInt("item_id");
				String item_name = rs.getString("item_name");
				int price = rs.getInt("price");
				String item_comment = rs.getString("item_comment");
				String item_regdate = rs.getString("item_regdate");
				int item_stock = rs.getInt("item_stock");
				String category_id = rs.getString("category_id");
				int img_no = rs.getInt("img_no");
				
				list.add(new ItemDTO(item_id, item_name, price, item_comment, item_regdate, item_stock,category_id,img_no));
			}
			return list;
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
