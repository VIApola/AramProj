package com.aram.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aram.dao.ImgFileDAO;
import com.aram.dao.ItemDAO;
import com.aram.dao.ItemSearchDAO;
import com.aram.dao.ReviewDAO;
import com.aram.dto.ItemDTO;
import com.aram.dto.ItemViewDTO;
import com.aram.dto.ItemimgDTO;
import com.google.gson.Gson;
import com.aram.dto.ReviewDTO;
import com.aram.utils.Pagination;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("*.item")
public class ItemController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}
	
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		System.out.println("요청 uri : " + uri);
		
		request.setCharacterEncoding("utf-8");
		
		if(uri.equals("/category.item")) { // 카테고리 페이지 로딩
			String category_id = request.getParameter("category_id");
			ItemDAO dao = new ItemDAO();
			try {

				ArrayList<ItemViewDTO> itemList = dao.selectAllItems();
				System.out.println(itemList);

				request.setAttribute("itemList", itemList);
				request.getRequestDispatcher("/shop/category/air.jsp").forward(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} else if(uri.equals("/detail.item")) { // 상품 상세페이지 로딩
			

			//int item_no = 105;
		int item_no = Integer.parseInt(request.getParameter("item_no"));



			System.out.println("상품번호 : " + item_no);
			ItemDAO dao = new ItemDAO();
			ImgFileDAO imgDao = new ImgFileDAO();
			ReviewDAO reviewDao = new ReviewDAO();
			
			try {
				ItemDTO itemDto = dao.selectItemByNo(item_no);
				System.out.println(itemDto);
				// 이미지 번호를 통해 이미지 경로값 가져오기
				int img_no = itemDto.getImg_no();
				ItemimgDTO imgDto = imgDao.select_img(img_no);

				ArrayList<ReviewDTO> reviewList = reviewDao.selectAllReviewByItem(item_no);
				System.out.println(reviewList);
				
				request.setAttribute("item", itemDto);
				request.setAttribute("itemImg", imgDto);
				request.setAttribute("reviewList", reviewList);
				
				request.getRequestDispatcher("/shop/detail.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(uri.equals("/toItemInput.item")) { // 상품 입력 페이지 이동 
			response.sendRedirect("/admin/itemInsertModify.jsp");
			
			
			
		} else if(uri.equals("/insert.item")) { // 상품등록 요청 (관리자)
			
			String filePath = request.getServletContext().getRealPath("/resources/images/items");
			System.out.println(filePath);
			
			File dir = new File(filePath);
			if(!dir.exists()) {
				dir.mkdirs();
			}
			int maxSize = 1024*1024*10;
			
			MultipartRequest multi = new MultipartRequest(request, filePath, maxSize, "utf-8", new DefaultFileRenamePolicy());
			
			String ori_name = multi.getOriginalFileName("imgFile");
			String sys_name = multi.getFilesystemName("imgFile");
			
			String item_name = multi.getParameter("itemName");
			int price = Integer.parseInt(multi.getParameter("itemPrice"));
			String item_comment = multi.getParameter("itemDetail");
			int item_stock = Integer.parseInt(multi.getParameter("itemStock"));
			String category_id = multi.getParameter("itemCategory");
			
			System.out.println(item_name + ":" + category_id + ":" + price + ":" + item_stock + ":" + item_comment);
			System.out.println(ori_name + ":" + sys_name + ":" + category_id);
			
			ItemDAO dao = new ItemDAO();
			ImgFileDAO imgDao = new ImgFileDAO();
			
			try {
				int item_no = dao.getItemNo();
				int img_no = imgDao.getImgFileNo();
				
				int rs = dao.insertItem(new ItemDTO(item_no, item_name, price, item_comment, null, item_stock, category_id, img_no));
				int rsFile = imgDao.insert_img(new ItemimgDTO(img_no, item_no, null, ori_name, sys_name));
				if(rs > 0 && rsFile > 0) {
					System.out.println("등록 완료");
					response.sendRedirect("/main");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} else if(uri.equals("/update.item")) { // 상품 정보 변경 (관리자)
			String item_name = request.getParameter("itemName");
			int price = Integer.parseInt(request.getParameter("itemPrice"));
			String item_comment = request.getParameter("itemDetail");
			int item_stock = Integer.parseInt(request.getParameter("itemStock"));
			String item_category = request.getParameter("itemCategory");
			
			ItemDAO dao = new ItemDAO();
			
			try {
				int rs = dao.updateItem(new ItemDTO(0, item_name, price, item_comment, null, item_stock, "P200", 0));
				if(rs > 0) {
					System.out.println("수정 완료");
					response.sendRedirect("/main");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(uri.equals("/delete.item")) { // 상품 삭제 (관리자)
			int item_no = Integer.parseInt(request.getParameter("item_no")); 
			
			ItemDAO dao = new ItemDAO();
			
			try {
				int rs = dao.deleteItem(item_no);
				if (rs > 0) {
					System.out.println("삭제완료");
					response.sendRedirect("/main");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(uri.equals("/")) {
			
		}

		/* 카테고리 파트 */
		if(uri.equals("/air.item")) { // 카테고리별 페이지 로드 (공기청정)
			
				ItemDAO dao = new ItemDAO();
			
	            try {
					ArrayList<ItemViewDTO> itemList = dao.selectAllItems();
					
					System.out.println("list 값 : " + itemList);
					
					request.setAttribute("itemList", itemList);
					
					int count = dao.countItems("p100"); // 카테고리별 물품 갯수
					request.setAttribute("count", count);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			
	            request.getRequestDispatcher("/shop/category/air.jsp").forward(request, response);
			
		}else if(uri.equals("/interior.item")) { //카테고리별 페이지 로드 (내부)
			
			 ItemDAO dao = new ItemDAO();
	            try {
	            	ArrayList<ItemViewDTO> itemList = dao.selectAllItems();
					
					System.out.println("list 값 : " + itemList);
					request.setAttribute("itemList", itemList);
					
					int count = dao.countItems("p200"); // 카테고리별 물품 갯수
					request.setAttribute("count", count);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			
			request.getRequestDispatcher("/shop/category/interior.jsp").forward(request, response);
		
		}else if(uri.equals("/outside.item")) { //카테고리별 페이지 로드 (외부)
			ItemDAO dao = new ItemDAO();
            try {
            	ArrayList<ItemViewDTO> itemList = dao.selectAllItems();
				
				System.out.println("list 값 : " + itemList);
				request.setAttribute("itemList", itemList);
				
				int count = dao.countItems("p300"); // 카테고리별 물품 갯수
				request.setAttribute("count", count);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		
            request.getRequestDispatcher("/shop/category/outside.jsp").forward(request, response);
		
		}
		
		
		
		//전체상품 낮은가격순
		if(uri.equals("/searchRowPrice.item")) {
			
			ItemSearchDAO dao = new ItemSearchDAO();
			
			try {
				ArrayList<ItemViewDTO> rowPriceList = dao.selectAllItemsByRowPrice();	
				System.out.println(rowPriceList);
				
				Gson gson = new Gson();
				String rs = gson.toJson(rowPriceList);
				System.out.println(rs);
				response.setCharacterEncoding("utf-8");
				response.getWriter().append(rs);
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		
		//전체상품 높은가격순으로
		}else if(uri.equals("/searchHighPrice.item")) {
			
			ItemSearchDAO dao = new ItemSearchDAO();
			
			try {
				ArrayList<ItemViewDTO> highPriceList = dao.selectHignPrice();
				System.out.println(highPriceList);
				
				Gson gson = new Gson();
				String rs = gson.toJson(highPriceList);
				System.out.println(rs);
				response.setCharacterEncoding("utf-8");
				response.getWriter().append(rs);
				
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			
		//전체상품 이름순으로
		}else if(uri.equals("/searchName.item")) {
			
			ItemSearchDAO dao = new ItemSearchDAO();
			
			try {
				ArrayList<ItemViewDTO> nameList = dao.selectItemName();
				System.out.println(nameList);
				
				Gson gson = new Gson();
				String rs = gson.toJson(nameList);
				System.out.println(rs);
				response.setCharacterEncoding("utf-8");
				response.getWriter().append(rs);
				
				
			}catch(Exception e) {
				e.printStackTrace();
			}	
		
		//가격범위만 입력했을때
		}else if(uri.equals("/searchItemPrice.item")) {
			int minPrice =Integer.parseInt(request.getParameter("minPrice"));
			int maxPrice =Integer.parseInt(request.getParameter("maxPrice"));
			System.out.println(minPrice+" : "+maxPrice);
			
			ItemSearchDAO dao = new ItemSearchDAO();
			try {
				
				ArrayList<ItemViewDTO> searchItemList = dao.searchByPrice(minPrice, maxPrice);
				System.out.println(searchItemList);
				int count =  dao.countSearchItems(minPrice, maxPrice);
				System.out.println(count);
				
				request.setAttribute("itemList", searchItemList);
				request.setAttribute("minPrice", minPrice);
				request.setAttribute("maxPrice", maxPrice);
				
				request.setAttribute("count", count);
				
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("/shop/searchItem/selectByPrice.jsp").forward(request, response);
		
		//키워드만 검색했을때
		}else if(uri.equals("/searchItem.item")) {
			String searchKeyword = request.getParameter("searchKeyword");
			System.out.println(searchKeyword);
			
			ItemSearchDAO dao = new ItemSearchDAO();
			try {
				
				ArrayList<ItemViewDTO> searchItemList = dao.searchByTitle(searchKeyword);
				System.out.println(searchItemList);
				int count =  dao.countSearchItems(searchKeyword);
				System.out.println(count);
				
				request.setAttribute("itemList", searchItemList);
				request.setAttribute("searchKeyword", searchKeyword);
				request.setAttribute("count", count);
				
				
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("/shop/searchItem/selectByName.jsp").forward(request, response);
			
		//가격, 키워드 검색할때
		}else if(uri.equals("/searchPriceItem.item")) {
			String searchKeyword = request.getParameter("searchKeyword");
			int minPrice =Integer.parseInt(request.getParameter("minPrice"));
			int maxPrice =Integer.parseInt(request.getParameter("maxPrice"));
			
			System.out.println(searchKeyword +" : "+minPrice+" : "+maxPrice);
			
			ItemSearchDAO dao = new ItemSearchDAO();
			try {
				ArrayList<ItemViewDTO> searchItemList = dao.searchByPriceName(searchKeyword,minPrice,maxPrice);
				System.out.println(searchItemList);
				int count =  dao.countSearchItems(searchKeyword);
				System.out.println(count);
				
				request.setAttribute("itemList", searchItemList);
				request.setAttribute("searchKeyword", searchKeyword);
				request.setAttribute("minPrice", minPrice);
				request.setAttribute("maxPrice", maxPrice);
				request.setAttribute("count", count);
				
				
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("/shop/searchItem/selectByNamePrice.jsp").forward(request, response);
		
		//메인에서 search눌렀을때
		}else if(uri.equals("/toSearchPage.item")) { //검색페이지 요청
			int curPage = Integer.parseInt(request.getParameter("curPage"));
			ItemDAO dao = new ItemDAO();
			Pagination pageNavi = new Pagination();
			
			try {
				int totalItemsCnt = dao.countAllItems();
				HashMap<String, Object> naviMap = pageNavi.getPageNavi(totalItemsCnt, curPage, 8);
				curPage = (Integer)naviMap.get("curPage");
				ArrayList<ItemViewDTO> itemList = dao.selectRecentPagingAll(curPage*8-7,curPage*8);
				
				request.setAttribute("itemList", itemList);
				request.setAttribute("itemCount", totalItemsCnt);
				request.setAttribute("naviMap", naviMap);
				
				System.out.println(itemList);
				System.out.println(totalItemsCnt);
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("/shop/searchitem.jsp").forward(request, response);	
		
		
		//키워드 검색 + 낮은 가격순
		}else if(uri.equals("/nameRowPrice.item")) {
			String searchKeyword = request.getParameter("searchKeyword");
			System.out.println(searchKeyword);
			ItemSearchDAO dao = new ItemSearchDAO();
			
			try {
				ArrayList<ItemViewDTO> rowPriceList = dao.searchByTitleRP(searchKeyword);	
				System.out.println(rowPriceList);
				
				Gson gson = new Gson();
				String rs = gson.toJson(rowPriceList);
				System.out.println(rs);
				response.setCharacterEncoding("utf-8");
				response.getWriter().append(rs);
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			//키워드 검색 + 높은 가격순	
		}else if(uri.equals("/nameHighPrice.item")) {
			String searchKeyword = request.getParameter("searchKeyword");
			System.out.println(searchKeyword);
			
			
			ItemSearchDAO dao = new ItemSearchDAO();
			
			try {
				ArrayList<ItemViewDTO> rowPriceList = dao.searchByTitleRP(searchKeyword);	
				System.out.println(rowPriceList);
				
				Gson gson = new Gson();
				String rs = gson.toJson(rowPriceList);
				System.out.println(rs);
				response.setCharacterEncoding("utf-8");
				response.getWriter().append(rs);
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			//키워드 + 이름순
		}else if(uri.equals("/nameSearchName.item")) {
			String searchKeyword = request.getParameter("searchKeyword");
			System.out.println(searchKeyword);
			
			ItemSearchDAO dao = new ItemSearchDAO();
			
			try {
				ArrayList<ItemViewDTO> rowPriceList = dao.searchByTitleName(searchKeyword);	
				System.out.println(rowPriceList);
				
				Gson gson = new Gson();
				String rs = gson.toJson(rowPriceList);
				System.out.println(rs);
				response.setCharacterEncoding("utf-8");
				response.getWriter().append(rs);
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			//가격범위 + 낮은가격
		}else if(uri.equals("/priceRowPrice.item")) {
			int minPrice =Integer.parseInt(request.getParameter("minPrice"));
			int maxPrice =Integer.parseInt(request.getParameter("maxPrice"));
			
			ItemSearchDAO dao = new ItemSearchDAO();
			
			try {
				ArrayList<ItemViewDTO> rowPriceList = dao.searchByPriceRP(minPrice,maxPrice);	
				System.out.println(rowPriceList);
				
				Gson gson = new Gson();
				String rs = gson.toJson(rowPriceList);
				System.out.println(rs);
				response.setCharacterEncoding("utf-8");
				response.getWriter().append(rs);
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			//가격범위 + 높은가격	
		}else if(uri.equals("/priceHighPrice.item")) {
			
			int minPrice =Integer.parseInt(request.getParameter("minPrice"));
			int maxPrice =Integer.parseInt(request.getParameter("maxPrice"));
			
			ItemSearchDAO dao = new ItemSearchDAO();
			
			try {
				ArrayList<ItemViewDTO> rowPriceList = dao.searchByPriceHP(minPrice,maxPrice);	
				System.out.println(rowPriceList);
				
				Gson gson = new Gson();
				String rs = gson.toJson(rowPriceList);
				System.out.println(rs);
				response.setCharacterEncoding("utf-8");
				response.getWriter().append(rs);
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			//가격범위 + 이름순	
		}else if(uri.equals("/priceName.item")) {
			int minPrice =Integer.parseInt(request.getParameter("minPrice"));
			int maxPrice =Integer.parseInt(request.getParameter("maxPrice"));
			
			ItemSearchDAO dao = new ItemSearchDAO();
													
			try {
				ArrayList<ItemViewDTO> rowPriceList = dao.searchByPriceTitle(minPrice,maxPrice);	
				System.out.println(rowPriceList);
				
				Gson gson = new Gson();
				String rs = gson.toJson(rowPriceList);
				System.out.println(rs);
				response.setCharacterEncoding("utf-8");
				response.getWriter().append(rs);
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		//가격 + 키워드 + 낮은가격	
		}else if(uri.equals("/namePriceRowPrice.item")) {
			System.out.println("요청 url : "+uri);
			
			
			String searchKeyword = request.getParameter("searchKeyword");
			int minPrice =Integer.parseInt(request.getParameter("minPrice"));
			int maxPrice =Integer.parseInt(request.getParameter("maxPrice"));
			
			ItemSearchDAO dao = new ItemSearchDAO();
			
			try {
				ArrayList<ItemViewDTO> rowPriceList = dao.searchByPriceNameRP(searchKeyword,minPrice,maxPrice);	
				System.out.println(rowPriceList);
				
				Gson gson = new Gson();
				String rs = gson.toJson(rowPriceList);
				System.out.println(rs);
				response.setCharacterEncoding("utf-8");
				response.getWriter().append(rs);
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		//가격 + 키워드 + 높은가격	
		}else if(uri.equals("/namePriceHighPrice.item")) {
			
			System.out.println("요청 url : "+uri);
			
			String searchKeyword = request.getParameter("searchKeyword");
			int minPrice =Integer.parseInt(request.getParameter("minPrice"));
			int maxPrice =Integer.parseInt(request.getParameter("maxPrice"));
			
			ItemSearchDAO dao = new ItemSearchDAO();
			
			try {
				ArrayList<ItemViewDTO> rowPriceList = dao.searchByPriceNameHP(searchKeyword,minPrice,maxPrice);	
				System.out.println(rowPriceList);
				
				Gson gson = new Gson();
				String rs = gson.toJson(rowPriceList);
				System.out.println(rs);
				response.setCharacterEncoding("utf-8");
				response.getWriter().append(rs);
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		//가격 + 키워드 + 이름순	
		}else if(uri.equals("/namePriceName.item")) {
			
			System.out.println("요청 url : "+uri);
			
			String searchKeyword = request.getParameter("searchKeyword");
			int minPrice =Integer.parseInt(request.getParameter("minPrice"));
			int maxPrice =Integer.parseInt(request.getParameter("maxPrice"));
			
			ItemSearchDAO dao = new ItemSearchDAO();
			
			try {
				ArrayList<ItemViewDTO> rowPriceList = dao.searchByPriceNameName(searchKeyword,minPrice,maxPrice);	
				System.out.println(rowPriceList);
				
				Gson gson = new Gson();
				String rs = gson.toJson(rowPriceList);
				System.out.println(rs);
				response.setCharacterEncoding("utf-8");
				response.getWriter().append(rs);
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		/*
		if(uri.equals("/dummy.item")) {
			ItemDAO dao = new ItemDAO();
			ImgFileDAO imgDao = new ImgFileDAO();
			
			for(int i=0; i<100; i++) {
				String item_name = "111";
				int price = 100;
				String item_comment = "111";
				int item_stock = 10;
				String category_id = "200";
				
				try {
					
					int item_no = dao.getItemNo();
					int img_no = imgDao.getImgFileNo();
					
					int rs = dao.insertItem(new ItemDTO(item_no, item_name, price, item_comment, null, item_stock, category_id, img_no));
					int rsFile = imgDao.insert_img(new ItemimgDTO(img_no, item_no, null, "111", "323"));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
		}
		*/
	 }

}
