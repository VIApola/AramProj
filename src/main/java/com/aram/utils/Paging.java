package com.aram.utils;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import com.aram.dto.ItemDTO;

public class Paging {
private BasicDataSource bds;
	
	public Paging() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//페이징 - getPageNavi 메서드
	   public HashMap<String, Object> getPageNavi(int curPage) throws Exception{
		   String sql = "select count(*) as totalCnt from tbl_items";
		 	   
		   try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
			   
			   ResultSet rs = pstmt.executeQuery();
			   rs.next();
			   
			    int totalCnt = rs.getInt("totalCnt");
			   
				int recordCntPerPage = 8; 
				
				int naviCntPerPage = 5; 
				
				int pageTotalCnt = 0; 
				
				
				//총34개 5페이지 -> pageTotalCnt
				
				
				if(totalCnt % recordCntPerPage > 0) {
					pageTotalCnt = totalCnt/recordCntPerPage + 1;
				}else {
					pageTotalCnt = totalCnt/recordCntPerPage;
				}
				
				if(curPage < 1) {
					curPage = 1;
				}else if(curPage>pageTotalCnt) {
					curPage = pageTotalCnt;
				}
				
				int startNavi = ((curPage-1)/naviCntPerPage) * naviCntPerPage + 1;
				int endNavi = startNavi + naviCntPerPage - 1;
				
				
				if(pageTotalCnt < endNavi) {
					endNavi = pageTotalCnt; 
				}
				
				boolean needPrev =  true; 
				boolean needNext = true; 
				
				if(startNavi == 1) {
					needPrev = false;
				}
				if(endNavi == pageTotalCnt) {
					needNext = false;
				}
				
				HashMap<String, Object> map = new HashMap<>();
				
				map.put("startNavi", startNavi);
				map.put("endNavi", endNavi);
				map.put("needPrev", needPrev);
				map.put("needNext", needNext);
				
				return map;
				
				
		  }
		   
	   }
	   
	   
	   //전체 상품 보여주기 (tbl_items)
	   public ArrayList<ItemDTO> selectPagingAll(int start, int end) throws Exception{
			String sql = "select *from (select tbl_items.*, row_number() over(order by item_id desc)as num from tbl_items) where num between ? and ?";
			
			try(Connection con = bds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
				
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				
				
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
	
	 // date형 String형으로
	 public String getStringDate(Date date) {
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	 	return sdf.format(date);
	 }
	
	
	
}
