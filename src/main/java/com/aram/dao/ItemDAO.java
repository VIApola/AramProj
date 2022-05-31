package com.aram.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import com.aram.dto.ItemDTO;
import com.aram.dto.ItemViewDTO;
import com.aram.dto.ItemimgDTO;

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
			pst.setInt(1, dto.getItem_no());
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
	public ArrayList<ItemViewDTO> selectAllItems() throws Exception {
		String sql = "select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no";
		try(PreparedStatement pst = bds.getConnection().prepareStatement(sql)){
			ResultSet rs = pst.executeQuery();
			
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
						item_regdate, item_stock, category_id, new ItemimgDTO(img_no, item_no, img_type, ori_name, sys_name)));
			}
			System.out.println(" 보내기 전 list (ItemDTO) : " + itemList);
			
			return itemList;
			
		}
	}
	
	// 제품번호별 세부 상품 조회
	public ItemDTO selectItemByNo(int item_no) throws Exception {
		String sql = "select * from tbl_items where item_no = ?";
		try(PreparedStatement pst = bds.getConnection().prepareStatement(sql)){
			pst.setInt(1, item_no);
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
				
				return new ItemDTO(item_no, item_name, price, item_comment, null, item_stock, category_id, img_no);
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
	public int deleteItem(int item_no) throws Exception {
		String sql = "delete from tbl_items where item_id = ?";
		try(PreparedStatement pst = bds.getConnection().prepareStatement(sql)){
			pst.setInt(1, item_no);	
			
			return pst.executeUpdate();
		}
	}
	
	// 카테고리별 상품 갯수
	public int countItems(String category_id) throws Exception {
		String sql = "select count(*) from tbl_items where category_id=?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setString(1, category_id);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			return rs.getInt(1);

		}
	}
	
	// 아이템 번호 미리 가져오는 함수
	public int getItemNo() throws Exception {
		String sql = "select seq_item_no.nextval from dual";
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
