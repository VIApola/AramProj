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
	
	//메인에서 뿌려줄 재고 적은 순으로 1~8위
	public ArrayList<ItemDTO> selectByStock ()throws Exception {
		String sql ="select * from (select * from tbl_items order by item_stock) where rownum <=8";
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			ResultSet rs = pstmt.executeQuery();
			
			ArrayList<ItemDTO> list = new ArrayList<>();
			while(rs.next()) {
				int item_id = rs.getInt("item_id");
				String item_name = rs.getString("item_name");
				int price = rs.getInt("price");
				String item_comment = rs.getString("item_comment");
				String item_regdate = getStringDate(rs.getDate("item_regdate"));
				int item_stock = rs.getInt("item_stock");
				String category_id = rs.getString("category_id");
				int img_no = rs.getInt("img_no");
				list.add(new ItemDTO (item_id,item_name,price,item_comment,item_regdate,item_stock,category_id, img_no));
				
			}
			return list;
			
		}
	}
		//date형 String형으로
		public String getStringDate(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		return sdf.format(date);
	}
		
	//제품이름 검색 요청
	public ArrayList<ItemDTO> searchByTitle(String searchKeyword) throws Exception{
		String sql="select * from tbl_items where item_name like '%'||?||'%' order by 1 desc";
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setString(1, searchKeyword);
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<ItemDTO> list = new ArrayList<>();
			
			while(rs.next()) {
				int item_id = rs.getInt("item_id");
				String item_name = rs.getString("item_name");
				int price = rs.getInt("price");
				String item_comment = rs.getString("item_comment");
				String item_regdate = getStringDate(rs.getDate("item_regdate"));
				int item_stock = rs.getInt("item_stock");
				String category_id = rs.getString("category_id");
				int img_no = rs.getInt("img_no");
				list.add(new ItemDTO (item_id,item_name,price,item_comment,item_regdate,item_stock,category_id, img_no));	
			}
			return list;
		}
	}
	
	//가격대 범위안의 아이템 조회하기
	//public ArrayList<ItemDTO> searchByPrice (int minPrice, int maxPrice)
	
	
	

}
