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
	
	//제품이름 검색 요청
		public ArrayList<ItemViewDTO> searchByTitle(String searchKeyword) throws Exception{
			String sql="select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no where item_name like '%'||?||'%' order by 1 desc";
			
				try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
				
				pstmt.setString(1, searchKeyword);
				
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
		
		//제품이름별 카운트
		public int countSearchItems(String searchKeyword) throws Exception {
			String sql = "select count(*) from tbl_items where item_name like '%'||?||'%'";
			try(Connection con = bds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
				pstmt.setString(1, searchKeyword);
				ResultSet rs = pstmt.executeQuery();
				rs.next();
				return rs.getInt(1);

			}
		}
		
		//키워드 검색 + 높은 가격정렬
		public ArrayList<ItemViewDTO> searchByTitleHP(String searchKeyword) throws Exception{
			String sql="select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no where item_name like '%'||?||'%' order by price desc";
			
				try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
				
				pstmt.setString(1, searchKeyword);
				
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
		
		
		
		//키워드 검색 + 낮은 가격정렬
		public ArrayList<ItemViewDTO> searchByTitleRP(String searchKeyword) throws Exception{
			String sql="select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no where item_name like '%'||?||'%' order by price";
			
				try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
				
				pstmt.setString(1, searchKeyword);
				
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
		
		
		
		//키워드 검색 + 이름정렬
		public ArrayList<ItemViewDTO> searchByTitleName(String searchKeyword) throws Exception{
			String sql="select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no where item_name like '%'||?||'%' order by item_name";
			
				try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
				
				pstmt.setString(1, searchKeyword);
				
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
		
		
		
		
		//가격대 범위안의 아이템 조회하기
		public ArrayList<ItemViewDTO> searchByPrice (int minPrice, int maxPrice) throws Exception{
			String sql = "select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no where price between ? and ?";
			
			try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
				
				
				pstmt.setInt(1,minPrice);
				pstmt.setInt(2,maxPrice);
				
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
		//가격대 범위안의 아이템 카운트
		public int countSearchItems(int minPrice, int maxPrice) throws Exception {
			String sql = "select count(*) from tbl_items where price between ? and ?";
			try(Connection con = bds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
				
				pstmt.setInt(1,minPrice);
				pstmt.setInt(2,maxPrice);
				
				ResultSet rs = pstmt.executeQuery();
				rs.next();
				
				return rs.getInt(1);
			}
		
		}
		
		//가격대 범위 입력 + 높은 가격 정렬
		public ArrayList<ItemViewDTO> searchByPriceHP (int minPrice, int maxPrice) throws Exception{
			String sql = "select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no where price between ? and ? order by price desc";
			
			try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
				
				
				pstmt.setInt(1,minPrice);
				pstmt.setInt(2,maxPrice);
				
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
		
		
		//가격대 범위 입력 + 낮은 가격 정렬
		public ArrayList<ItemViewDTO> searchByPriceRP (int minPrice, int maxPrice) throws Exception{
			String sql = "select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no where price between ? and ? order by price";
			
			try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
				
				
				pstmt.setInt(1,minPrice);
				pstmt.setInt(2,maxPrice);
				
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
		
		//가격대 범위 입력 + 이름순 정렬 
		public ArrayList<ItemViewDTO> searchByPriceName (int minPrice, int maxPrice) throws Exception{
			String sql = "select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no where price between ? and ? order by item_name";
			
			try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
				
				
				pstmt.setInt(1,minPrice);
				pstmt.setInt(2,maxPrice);
				
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
		
		
		//가격 + 키워드 검색 조회
		public ArrayList<ItemViewDTO> searchByPriceName (String searchKeyword, int minPrice, int maxPrice) throws Exception{
			String sql = "select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no"
					+ "where  item_name like '%'||?||'%' and  price between ? and ? order by 1 desc";
			
			try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
				
				pstmt.setString(1, searchKeyword);
				pstmt.setInt(2,minPrice);
				pstmt.setInt(3,maxPrice);
				
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
		
		//가격+키워드 카운트
		public int countSearchItems(String searchKeyword, int minPrice, int maxPrice) throws Exception {
			String sql = "select count(*) from tbl_items where  item_name like '%'||?||'%' and  price between ? and ?";
			try(Connection con = bds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
				
				pstmt.setString(1, searchKeyword);
				pstmt.setInt(2,minPrice);
				pstmt.setInt(3,maxPrice);
				
				
				ResultSet rs = pstmt.executeQuery();
				rs.next();
				
				return rs.getInt(1);
			}
		
		}
		
		//가격 + 키워드 + 높은가격순
		public ArrayList<ItemViewDTO> searchByPriceNameHP (String searchKeyword, int minPrice, int maxPrice) throws Exception{
			String sql = "select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no"
					+ "where  item_name like '%'||?||'%' and  price between ? and ? order by price desc";
			
			try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
				
				pstmt.setString(1, searchKeyword);
				pstmt.setInt(2,minPrice);
				pstmt.setInt(3,maxPrice);
				
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
		
		
		
		//가격 + 키워드 + 낮은 가격정렬 
		public ArrayList<ItemViewDTO> searchByPriceNameRP (String searchKeyword, int minPrice, int maxPrice) throws Exception{
			String sql = "select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no"
					+ "where  item_name like '%'||?||'%' and  price between ? and ? order by price";
			
			try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
				
				pstmt.setString(1, searchKeyword);
				pstmt.setInt(2,minPrice);
				pstmt.setInt(3,maxPrice);
				
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
		
		
		//가격 + 키워드 + 이름 정렬 
		public ArrayList<ItemViewDTO> searchByPriceNameName (String searchKeyword, int minPrice, int maxPrice) throws Exception{
			String sql = "select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no"
					+ "where  item_name like '%'||?||'%' and  price between ? and ? order by item_name";
			
			try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
				
				pstmt.setString(1, searchKeyword);
				pstmt.setInt(2,minPrice);
				pstmt.setInt(3,maxPrice);
				
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
		

			//낮은 가격순 전체 조회
			   public ArrayList<ItemViewDTO> selectAllItemsByRowPrice() throws Exception {
					String sql = "select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no order by price";
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
									item_regdate, item_stock, category_id, new ItemimgDTO(img_no,item_no,img_type, ori_name, sys_name)));
						}
						System.out.println(" 보내기 전 list (ItemDTO) : " + itemList);
						
						return itemList;
						
					}
				}
			   
			   
			   
			   //높은가격순으로 전체 출력
			   public ArrayList<ItemViewDTO> selectHignPrice() throws Exception{
					  
				   String sql = "select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no order by price desc";
				  
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
			   
			  //이름순으로 전체 출력
			   public ArrayList<ItemViewDTO> selectItemName() throws Exception{
					  
				   String sql = "select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no order by item_name";
				   
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
	
	
			   
			   
			   
			   
			   
			   
			   
			   
			   
			   
			   
			   
			// Date형을 String형으로
				public String getStringDate(Date date) {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
					return sdf.format(date);
				}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
