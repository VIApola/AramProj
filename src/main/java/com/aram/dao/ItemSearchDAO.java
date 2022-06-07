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

import com.aram.dto.ItemViewDTO;
import com.aram.dto.ItemimgDTO;
import com.aram.utils.SearchQuery;

public class ItemSearchDAO {
private BasicDataSource bds;
	
	public ItemSearchDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 검색 조건에 맞는 쿼리문을 가져와서 DB에서 검색 정보를 가져옴
	public ArrayList<ItemViewDTO> searchItems(String sortBy, String keyword, int minPrice, int maxPrice) throws Exception {
		String sql = SearchQuery.findQuery(sortBy, keyword, minPrice, maxPrice);
		System.out.println(sql);
		try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
			ResultSet rs = pstmt.executeQuery();
			
			ArrayList<ItemViewDTO> itemList = new ArrayList<>();
	
			while(rs.next()) {
				
				int item_no = rs.getInt("item_no");
				String item_name = rs.getString("item_name");
				int price = rs.getInt("price");
				String item_comment = rs.getString("item_comment");
				String item_regdate = getStringDate(rs.getDate("item_regdate"));
				int item_stock = rs.getInt("item_stock");
				String category_id = rs.getString("category_id");
				
				int img_no = rs.getInt("img_no");
				String img_type = rs.getString("img_type");
				String ori_name = rs.getString("ori_name");
				String sys_name = rs.getString("sys_name");
		
				itemList.add(new ItemViewDTO(item_no, item_name, price, item_comment,
				item_regdate, item_stock, category_id, new ItemimgDTO(img_no,item_no,img_type, ori_name, sys_name)));
			}
			System.out.println(" 보내기 전 list (ItemDTO) : " + itemList);
				return itemList;
			}
	}
	
	// 카테고리 페이지에서 정렬 조건만 사용
	public ArrayList<ItemViewDTO> searchItems(String sortBy, String category_id) throws Exception {
		String sql = SearchQuery.findQuery(sortBy, category_id);
		System.out.println(sql);
		try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
			ResultSet rs = pstmt.executeQuery();
			
			ArrayList<ItemViewDTO> itemList = new ArrayList<>();
	
			while(rs.next()) {
				
				int item_no = rs.getInt("item_no");
				String item_name = rs.getString("item_name");
				int price = rs.getInt("price");
				String item_comment = rs.getString("item_comment");
				String item_regdate = getStringDate(rs.getDate("item_regdate"));
				int item_stock = rs.getInt("item_stock");
				
				int img_no = rs.getInt("img_no");
				String img_type = rs.getString("img_type");
				String ori_name = rs.getString("ori_name");
				String sys_name = rs.getString("sys_name");
		
				itemList.add(new ItemViewDTO(item_no, item_name, price, item_comment,
				item_regdate, item_stock, category_id, new ItemimgDTO(img_no,item_no,img_type, ori_name, sys_name)));
			}
			System.out.println(" 보내기 전 list (ItemDTO) : " + itemList);
				return itemList;
			}
	}
	
	// 가격대 범위안의 아이템 카운트
	public int countSearchItems(String sortBy, String keyword, int minPrice, int maxPrice) throws Exception {
		String sql = SearchQuery.findResultCount(sortBy, keyword, minPrice, maxPrice);
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			
			return rs.getInt(1);
		}
	}
	
   // Date형을 String형으로
	public String getStringDate(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		return sdf.format(date);
	}
}
