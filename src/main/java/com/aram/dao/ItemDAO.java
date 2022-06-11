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
			
			try(ResultSet rs = pstmt.executeQuery()){
						
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
	}
	
	//제품이름 검색 요청
	public ArrayList<ItemViewDTO> searchByTitle(String searchKeyword) throws Exception{
		String sql="select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no where item_name like '%'||?||'%' order by 1 desc";
		
			try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
			
			pstmt.setString(1, searchKeyword);
			
			try(ResultSet rs = pstmt.executeQuery()){
				
	
			
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
	}
	
	// 제품 이름별 카운트
	public int countSearchItems(String searchKeyword) throws Exception {
		String sql = "select count(*) from tbl_items where item_name like '%'||?||'%'";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setString(1, searchKeyword);
			try(ResultSet rs = pstmt.executeQuery()){
				
			
			rs.next();
			return rs.getInt(1);

			}
		}
	}
	
	
	//가격대 범위안의 아이템 조회하기
	public ArrayList<ItemViewDTO> searchByPrice (int minPrice, int maxPrice) throws Exception{
		String sql = "select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no where price between ? and ?";
		
		try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
			
			pstmt.setInt(1,minPrice);
			pstmt.setInt(2,maxPrice);
		
			try(ResultSet rs = pstmt.executeQuery()){
				

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
	}
	//가격대 범위안의 아이템 카운트
	public int countSearchItems(int minPrice, int maxPrice) throws Exception {
		String sql = "select count(*) from tbl_items where price between ? and ?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setInt(1,minPrice);
			pstmt.setInt(2,maxPrice);
			
			try(ResultSet rs = pstmt.executeQuery()){
				
			rs.next();
			return rs.getInt(1);

			
			}
		}
	}
	
	
	
	// 전체 상품 조회
	public ArrayList<ItemViewDTO> selectAllItems() {
		System.out.println("selectAll");
		String sql = "select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no";
		try(Connection con = bds.getConnection();
			PreparedStatement pst = con.prepareStatement(sql)){
			try(ResultSet rs = pst.executeQuery()){
			
				System.out.println("selectAll connection created ");
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
			System.out.println("selectAllItems 실행완료");
			return itemList;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 제품번호별 세부 상품 조회
	public ItemDTO selectItemByNo(int item_no) throws Exception {
		String sql = "select * from tbl_items where item_no = ?";
		try(PreparedStatement pst = bds.getConnection().prepareStatement(sql)){
			pst.setInt(1, item_no);
			try(ResultSet rs = pst.executeQuery()){
				
			
		
			
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
	}
	
	// 카테고리별 전체 상품 조회
	public ArrayList<ItemViewDTO> selectItemsByCategory(String category_id) throws Exception {
		String sql = "select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no where category_id = ?";
		try(PreparedStatement pst = bds.getConnection().prepareStatement(sql)){
			pst.setString(1, category_id);	
			
			try(ResultSet rs = pst.executeQuery()){
				
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
	}

	// 카테고리별 상품 갯수
	public int countItems(String category_id) throws Exception {
		String sql = "select count(*) from tbl_items where category_id=?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setString(1, category_id);
			try(ResultSet rs = pstmt.executeQuery()){
			rs.next();
			return rs.getInt(1);
			}
		}
	}
	
	// 아이템 번호 미리 가져오는 함수
	public int getItemNo() throws Exception {
		String sql = "select seq_item_no.nextval from dual";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			try(ResultSet rs = pstmt.executeQuery()){
			rs.next();
			
			return rs.getInt(1);
			}
		}
	}
	//전체상품 (tbl_items만)
	public ArrayList<ItemDTO> selectAllTblItems () throws Exception{
		String sql = "select * from tbl_items";
		
		try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
			
			try(ResultSet rs = pstmt.executeQuery()){
			
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
		
	}
	
	// 등록되어있는 전체상품 카운트
	public int countAllItems() throws Exception{
		String sql = "select count(*) from tbl_items";
		
		try(PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)){
			try(ResultSet rs = pstmt.executeQuery()){
			rs.next();
			System.out.println("countAll 실행완료");
			return rs.getInt(1);
		}
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
			
			try(ResultSet rs = pstmt.executeQuery()){
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
   }
   // 최신순으로 전체 아이템 조회 + 이미지 포함
   public ArrayList<ItemDTO> selectPagingAll(int start, int end) throws Exception{
		String sql = "select * from (select tbl_items.*, row_number() over(order by item_id desc) as num from tbl_items) where num between ? and ?";
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			try(ResultSet rs = pstmt.executeQuery()){
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
   }
	
	// Date형을 String형으로
	public String getStringDate(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		return sdf.format(date);
	}
	
	// -------------------------- 관리자페이지
	
	public ArrayList<ItemViewDTO> mngItemList() throws Exception { // 관리자 페이지 : 상품관리목록 전체조회 (날짜 역순)
		
		String sql = "select * from tbl_items a join tbl_item_img b on a.img_no = b.img_no order by item_regdate desc";
		
		try (PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)) {
			
			try(ResultSet rs = pstmt.executeQuery()){
			ArrayList<ItemViewDTO> list = new ArrayList<>();
			
			while(rs.next()) {
				int item_no = rs.getInt("item_no");
				String item_name = rs.getString("item_name");
				int price = rs.getInt("price");
				String item_comment = rs.getString("item_comment");
				String item_regdate = getStringDate(rs.getDate("item_regdate"));
				int item_stock = rs.getInt("item_stock");
				
				String category_id = "분류없음";
				if(rs.getString("category_id").equals("p100")) {
					category_id = "공기정화식물";
				} else if(rs.getString("category_id").equals("p200")){
					category_id = "실내식물";
				} else if(rs.getString("category_id").equals("p300")) {
					category_id = "실외식물";
				}
				
				int img_no = rs.getInt("img_no");
				String img_type = rs.getString("img_type");
				String ori_name = rs.getString("ori_name");
				String sys_name = rs.getString("sys_name");
				
				list.add(new ItemViewDTO(item_no, item_name, price, item_comment,
						item_regdate, item_stock, category_id, new ItemimgDTO(img_no,item_no,img_type, ori_name, sys_name)));

			}
			return list;
			}
		}
		
	}
	
	
	public ArrayList<ItemViewDTO> searchByNameMng(String input) throws Exception { // 관리자 페이지 : 상품검색-상품명, 이름순
		
		String sql = "select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no where item_name like '%'||?||'%' order by 2";
		
		try (PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)) {
			
			pstmt.setString(1, input);
			
			try(ResultSet rs = pstmt.executeQuery()){
			ArrayList<ItemViewDTO> list = new ArrayList<>();
			
			while(rs.next()) {
				int item_no = rs.getInt("item_no");
				String item_name = rs.getString("item_name");
				int price = rs.getInt("price");
				String item_comment = rs.getString("item_comment");
				String item_regdate = getStringDate(rs.getDate("item_regdate"));
				int item_stock = rs.getInt("item_stock");
				
				String category_id = "분류없음";
				if(rs.getString("category_id").equals("p100")) {
					category_id = "공기정화식물";
				} else if(rs.getString("category_id").equals("p200")){
					category_id = "실내식물";
				} else if(rs.getString("category_id").equals("p300")) {
					category_id = "실외식물";
				}
				
				int img_no = rs.getInt("img_no");
				String img_type = rs.getString("img_type");
				String ori_name = rs.getString("ori_name");
				String sys_name = rs.getString("sys_name");
				
				list.add(new ItemViewDTO(item_no, item_name, price, item_comment,
						item_regdate, item_stock, category_id, new ItemimgDTO(img_no,item_no,img_type, ori_name, sys_name)));

			}
			return list;
			}
		}
		
	}
	
	
	
	
	public ArrayList<ItemViewDTO> searchByNoMng(String input) throws Exception { // 관리자 페이지 : 상품검색-상품번호, 번호순
		
		String sql = "select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no where item_no like '%'||?||'%' order by 1";
		
		try (PreparedStatement pstmt = bds.getConnection().prepareStatement(sql)) {
			
			pstmt.setString(1, input);
			
			try(ResultSet rs = pstmt.executeQuery()){
			ArrayList<ItemViewDTO> list = new ArrayList<>();
			
			while(rs.next()) {
				int item_no = rs.getInt("item_no");
				String item_name = rs.getString("item_name");
				int price = rs.getInt("price");
				String item_comment = rs.getString("item_comment");
				String item_regdate = getStringDate(rs.getDate("item_regdate"));
				int item_stock = rs.getInt("item_stock");
				
				String category_id = "분류없음";
				if(rs.getString("category_id").equals("p100")) {
					category_id = "공기정화식물";
				} else if(rs.getString("category_id").equals("p200")){
					category_id = "실내식물";
				} else if(rs.getString("category_id").equals("p300")) {
					category_id = "실외식물";
				}
				
				int img_no = rs.getInt("img_no");
				String img_type = rs.getString("img_type");
				String ori_name = rs.getString("ori_name");
				String sys_name = rs.getString("sys_name");
				
				list.add(new ItemViewDTO(item_no, item_name, price, item_comment,
						item_regdate, item_stock, category_id, new ItemimgDTO(img_no,item_no,img_type, ori_name, sys_name)));

			}
			return list;
			}
		}
		
	}
	
	

	
	public ItemViewDTO selectByItemNo(int num) throws Exception { // 관리자 페이지 : 상품번호로 데이터 조회 (상품수정페이지)
		
		String sql = "select * from tbl_items a join tbl_item_img b on a.item_no = b.item_no where a.item_no = ?";
		
		try(Connection con = bds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)){
			
			pstmt.setInt(1, num);
			try(ResultSet rs = pstmt.executeQuery()){
			
			if(rs.next()) {
				
				int item_no = rs.getInt("item_no");
				String item_name = rs.getString("item_name");
				int price = rs.getInt("price");
				String item_comment = rs.getString("item_comment");
				String item_regdate = rs.getString("item_regdate");
				int item_stock = rs.getInt("item_stock");
				String category_id = rs.getString("category_id");
				int img_no = rs.getInt("img_no");
				String img_type = rs.getString("img_type");
				String ori_name = rs.getString("ori_name");
				String sys_name = rs.getString("sys_name");
				
				ItemViewDTO dto = new ItemViewDTO(item_no, item_name, price, item_comment,
						item_regdate, item_stock, category_id, new ItemimgDTO(img_no,item_no,img_type, ori_name, sys_name));
				
				return dto;
			}
			return null;
			}
		}
	}
	
	
	
	
	// 제품 등록 (관리자)
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
	
	// 제품 정보 수정 (관리자)
	public int updateItem(ItemDTO dto) throws Exception {
		String sql = "update tbl_items set item_name=?, price=?, item_comment=?, item_stock=?, category_id=?, img_no=? where item_no = ?";
		try(PreparedStatement pst = bds.getConnection().prepareStatement(sql)){
			pst.setString(1, dto.getItem_name());
			pst.setInt(2, dto.getPrice());
			pst.setString(3, dto.getItem_comment());
			pst.setInt(4, dto.getItem_stock());
			pst.setString(5, dto.getCategory_id());
			
			pst.setInt(6, dto.getImg_no());
			pst.setInt(7, dto.getItem_no());
			
			return pst.executeUpdate();
		}
	}

	// 등록된 제품 삭제 (관리자)
	public int deleteItem(int item_no) throws Exception {
		String sql = "delete from tbl_items where item_no = ?";
		try(PreparedStatement pst = bds.getConnection().prepareStatement(sql)){
			pst.setInt(1, item_no);	
			
			return pst.executeUpdate();
		}
	}

}
