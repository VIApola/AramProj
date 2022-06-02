package com.aram.dao;

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

	//메인에서 뿌려줄 재고 적은 순으로 1~8위
	public ArrayList<ItemViewDTO> selectByStock() throws Exception {
		String sql ="select * from (select * from tbl_items order by item_stock) where rownum <=8";
		
		try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
			
			ResultSet rs = pstmt.executeQuery();
			
			ImgFileDAO dao = new ImgFileDAO();
			
			ArrayList<ItemViewDTO> list = new ArrayList<>();
			while(rs.next()) {
				int item_no = rs.getInt("item_no");
				String item_name = rs.getString("item_name");
				int price = rs.getInt("price");
				String item_comment = rs.getString("item_comment");
				String item_regdate = getStringDate(rs.getDate("item_regdate"));
				int item_stock = rs.getInt("item_stock");
				String category_id = rs.getString("category_id");
				int img_no = rs.getInt("img_no");
				ItemimgDTO itemImgDto = dao.select_img(img_no);
				
				list.add(new ItemViewDTO(item_no, item_name, price, item_comment, item_regdate, item_stock, category_id, itemImgDto));
				
			}
			return list;
			
		}
	}
		
		
	//제품이름 검색 요청
	public ArrayList<ItemDTO> searchByTitle(String searchKeyword) throws Exception{
		String sql="select * from tbl_items where item_name like '%'||?||'%' order by 1 desc";
		
		try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
			
			pstmt.setString(1, searchKeyword);
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<ItemDTO> list = new ArrayList<>();
			
			while(rs.next()) {
				int item_no = rs.getInt("item_no");
				String item_name = rs.getString("item_name");
				int price = rs.getInt("price");
				String item_comment = rs.getString("item_comment");
				String item_regdate = getStringDate(rs.getDate("item_regdate"));
				int item_stock = rs.getInt("item_stock");
				String category_id = rs.getString("category_id");
				int img_no = rs.getInt("img_no");
				list.add(new ItemDTO (item_no,item_name,price,item_comment,item_regdate,item_stock,category_id, img_no));	
			}
			return list;
		}
	}
	
	//가격대 범위안의 아이템 조회하기
	public ArrayList<ItemDTO> searchByPrice (int minPrice, int maxPrice) throws Exception{
		String sql = "select * from  tbl_items where price between ? and ?";
		
		try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
			
			pstmt.setInt(1, minPrice);
			pstmt.setInt(2, maxPrice);
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<ItemDTO> list = new ArrayList<>();
			
			while(rs.next()) {
				int item_no = rs.getInt("item_no");
				String item_name = rs.getString("item_name");
				int price = rs.getInt("price");
				String item_comment = rs.getString("item_comment");
				String item_regdate = getStringDate(rs.getDate("item_regdate"));
				int item_stock = rs.getInt("item_stock");
				String category_id = rs.getString("category_id");
				int img_no = rs.getInt("img_no");
				list.add(new ItemDTO (item_no,item_name,price,item_comment,item_regdate,item_stock,category_id, img_no));	
			}
			return list;
			
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
				// String item_no = rs.getString("item_no");
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
		String sql = "delete from tbl_items where item_no = ?";
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
	//전체상품 (tbl_items만)
	public ArrayList<ItemDTO> selectAllTblItems () throws Exception{
		String sql = "select * from tbl_items";
		
		try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
			
			ResultSet rs = pstmt.executeQuery();
			
			ArrayList<ItemDTO> list = new ArrayList<>();
			while(rs.next()) {
				int item_no = rs.getInt("item_no");
				String item_name = rs.getString("item_name");
				int price = rs.getInt("price");
				String item_comment = rs.getString("item_comment");
				String item_regdate = getStringDate(rs.getDate("item_regdate"));
				int item_stock = rs.getInt("item_stock");
				String category_id = rs.getString("category_id");
				int img_no = rs.getInt("img_no");
				list.add(new ItemDTO (item_no,item_name,price,item_comment,item_regdate,item_stock,category_id, img_no));
				
			}
			return list;
			
		}
		
		
	}
	
	// 등록되어있는 전체상품 카운트
	public int countAllItems() throws Exception{
		String sql = "select count(*) from tbl_items";
		
		try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			return rs.getInt(1);
		}
	}
	
  
   
   // 최신순으로 전체 아이템 조회 + 이미지 포함
   public ArrayList<ItemViewDTO> selectRecentPagingAll(int start, int end) throws Exception{
		String sql = "SELECT * FROM\n"
				+ "(SELECT item.ITEM_NO, ITEM_NAME, PRICE, SYS_NAME, row_number() over(order by item.item_no desc) AS num\n"
				+ "FROM tbl_items item join tbl_item_img img on item.img_no=img.img_no) WHERE num BETWEEN ? AND ?";
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			ResultSet rs = pstmt.executeQuery();
			ArrayList<ItemViewDTO> list = new ArrayList<>();
			
			while(rs.next()) {
				int item_id = rs.getInt("item_no");
				String item_name = rs.getString("item_name");
				int price = rs.getInt("price");
				String sys_name = rs.getString("sys_name");
				
				list.add(new ItemViewDTO(item_id, item_name, price, null, null , 0, null, new ItemimgDTO(0,0,null,null, sys_name)));
			}
			return list;
		}	
	}
   
   // 최신순으로 전체 아이템 조회 + 이미지 포함
   public ArrayList<ItemDTO> selectPagingAll(int start, int end) throws Exception{
		String sql = "select * from (select tbl_items.*, row_number() over(order by item_id desc) as num from tbl_items) where num between ? and ?";
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
	
   //낮은 가격순으로 전체 조회
   public ArrayList<ItemDTO> selectRowPrice() throws Exception{
	  
	   String sql = "select * from tbl_items order by price desc";
	   
	   try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
		   
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
   
   //높은가격순으로 전체 출력
   public ArrayList<ItemDTO> selectHignPrice() throws Exception{
		  
	   String sql = "select * from tbl_items order by price";
	   
	   try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
		   
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
   
  //이름순으로 전체 출력
   public ArrayList<ItemDTO> selectItemName() throws Exception{
		  
	   String sql = "select * from tbl_items order by item_name";
	   
	   try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
		   
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
   
   
	// Date형을 String형으로
	public String getStringDate(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		return sdf.format(date);
	}
	
	/**
	//date형 String형으로
			public String getStringDate(Date date) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			return sdf.format(date);
		}
	**/
	
}
