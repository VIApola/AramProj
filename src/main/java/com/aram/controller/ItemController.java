package com.aram.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

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
		
		if(uri.equals("/category.item")) { // 카테고리 버튼 누를 때
			String category_id = request.getParameter("category_id");
			int page = Integer.parseInt(request.getParameter("page"));
			
			System.out.println(category_id);
			ItemDAO dao = new ItemDAO();
			
			
			try {
				ArrayList<ItemViewDTO> itemList = dao.selectItemsByCategory(category_id);
				HashMap<String, Object> pageMap =  Pagination.getPageNavi(itemList.size(), page, 8);
				pageMap.put("category_id", category_id);
				
				System.out.println("list 값 : " + itemList);
				request.setAttribute("itemList", itemList);
				
				int count = itemList.size();
				request.setAttribute("count", count);
				
				request.setAttribute("pageMap", pageMap);
				
				request.getRequestDispatcher("/shop/category.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		else if(uri.equals("/detail.item")) { // 상품 상세페이지 로딩
			

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
				
				// 상품에 달린 리뷰 가져오기
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
				int rsFile = imgDao.insert_img(new ItemimgDTO(img_no, item_no, "type", ori_name, sys_name));
				if(rs > 0 && rsFile > 0) {
					System.out.println("등록 완료");
					response.sendRedirect("/toItemPage.admin");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} else if(uri.equals("/update.item")) { // 상품 정보 수정 (관리자)
			
			String filePath = request.getServletContext().getRealPath("/resources/images/items");
			System.out.println(filePath);
			
			
			int maxSize = 1024*1024*10;
			
			MultipartRequest multi = new MultipartRequest(request, filePath, maxSize, "utf-8", new DefaultFileRenamePolicy());
			
			String ori_name = multi.getOriginalFileName("imgFile");
			String sys_name = multi.getFilesystemName("imgFile");

			String item_name = multi.getParameter("itemName");
			int price = Integer.parseInt(multi.getParameter("itemPrice"));
			String item_comment = multi.getParameter("itemDetail");
			int item_stock = Integer.parseInt(multi.getParameter("itemStock"));
			String category_id = multi.getParameter("itemCategory");
			int item_no = Integer.parseInt(multi.getParameter("item_no"));
			int img_no = Integer.parseInt(multi.getParameter("defaultImg"));
			
			System.out.println(item_no + " : " + item_name + ":" + category_id + ":" + price + ":" + item_stock + ":" + item_comment);
			System.out.println(ori_name + ":" + sys_name + ":" + category_id);
			System.out.println("이미지 넘버 : " + img_no);
			
			ItemDAO dao = new ItemDAO();
			ImgFileDAO imgDao = new ImgFileDAO();
			
			// 기존 이미지파일 경로값 가져오기
			String dftFile = null;
			try {
				String dftFileName = imgDao.select_img(img_no).getSys_name(); // 서버에 저장된 기존파일의 이름
				dftFile = filePath + "\\" + dftFileName; // 기존파일경로
				System.out.println("기존파일경로 : " + dftFile);
			} catch(Exception e) {
				e.printStackTrace();
			}
			
			// 이미지를 새로 첨부하지 않았을경우
			if(ori_name == null) {
				System.out.println("이미지가 null값입니다");

				try {
					int rs = dao.updateItem(new ItemDTO(item_no, item_name, price, item_comment, null, item_stock, category_id, img_no));
					if(rs>0) {
						System.out.println("수정 완료");
						response.sendRedirect("/toItemPage.admin");
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
				
			} else { // 이미지를 새로 첨부했을 경우
				try {
					
					int rs = dao.updateItem(new ItemDTO(item_no, item_name, price, item_comment, null, item_stock, category_id, img_no));
					int rsFile = imgDao.modify_img(new ItemimgDTO(img_no, item_no, "type", ori_name, sys_name));
					if(rs > 0 && rsFile > 0) {
						System.out.println("수정 완료");
						
						// 기존이미지 실제파일 삭제
						File file = new File(dftFile);
						if(file.exists()) {
							file.delete();
							System.out.println("실제 기존파일 삭제 완료");
						} else {
							System.out.println("기존파일이 존재하지 않습니다.");
						}
						
						response.sendRedirect("/toItemPage.admin");
					}
					
				}catch(Exception e) {
					e.printStackTrace();
				}
				
				
			}
				

			
		}else if(uri.equals("/delete.item")) { // 상품 삭제 (관리자)
			
			String filePath = request.getServletContext().getRealPath("/resources/images/items");
			System.out.println(filePath);

			int item_no = Integer.parseInt(request.getParameter("item_no")); 
			int img_no = Integer.parseInt(request.getParameter("img_no"));
			
			ItemDAO dao = new ItemDAO();
			ImgFileDAO imgDao = new ImgFileDAO();
			
			// 기존 이미지파일 경로값 가져오기
			String dftFile = null;
			try {
				String dftFileName = imgDao.select_img(img_no).getSys_name(); // 서버에 저장된 기존파일의 이름
				dftFile = filePath + "\\" + dftFileName; // 기존파일경로
				System.out.println("기존파일경로 : " + dftFile);
			} catch(Exception e) {
				e.printStackTrace();
			}

			try {
				int rsCount = dao.countAllItems();
				int rs = dao.deleteItem(item_no);
				int rsFile = imgDao.delete_img(img_no);
				if (rs > 0 && rsFile>0) { // 삭제 성공, 상품목록 응답
					System.out.println("데이터 삭제완료");
					
					// 기존이미지 실제파일 삭제
					File file = new File(dftFile);
					if(file.exists()) {
						file.delete();
						System.out.println("실제 기존파일 삭제 완료");
					} else {
						System.out.println("기존파일이 존재하지 않습니다.");
					}

					ArrayList<ItemViewDTO> list = dao.mngItemList();
					Gson gson = new Gson();
					String result = gson.toJson(list);
					
					response.setCharacterEncoding("utf-8");
					response.getWriter().append(result);
					
				} else { // 삭제 실패
					response.getWriter().append("fail");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			
			
		} else if(uri.equals("/deleteSelected.item")) { // (관리자) 선택된 상품 전체 삭제
			String[] checkArr = request.getParameterValues("checkArr"); // 배열로 받아주기
			
			ItemDAO dao = new ItemDAO();
			ImgFileDAO imgDao = new ImgFileDAO();
			
			for(int i = 0; i<checkArr.length; i++) {
				System.out.println(checkArr[i]); // 배열 출력
				
				try {
					int count = dao.countAllItems();
					int rs = dao.deleteItem(Integer.parseInt(checkArr[i]));
					int rsFile = imgDao.delete_imgByTitle(Integer.parseInt(checkArr[i]));
					if (rs > 0 && rsFile>0) { // 삭제 성공, 상품목록 응답
						System.out.println("삭제완료");
						// response.sendRedirect("/toItemPage.admin");
					} else { // 삭제 실패
						response.getWriter().append("fail");
						return;
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			try {
				ArrayList<ItemViewDTO> list = dao.mngItemList();
				
				Gson gson = new Gson();
				String result = gson.toJson(list);
				
				response.setCharacterEncoding("utf-8");
				response.getWriter().append(result);

			} catch(Exception e) {
				e.printStackTrace();
			}
				
		}
		
		if(uri.equals("/toSearchPage.item")) { // 검색페이지 진입할 때
			System.out.println("검색페이지");
			
			ItemDAO dao = new ItemDAO();
            try {
            	ArrayList<ItemViewDTO> itemList = dao.selectAllItems();
            	int itemCount = dao.countAllItems();
            	
				System.out.println("list 값 : " + itemList);
				System.out.println(itemCount);
				request.setAttribute("itemList", itemList);
				request.setAttribute("itemCount", itemCount);
				
				request.getRequestDispatcher("/shop/searchitem.jsp").forward(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if (uri.equals("/searchit.item")) { // 검색버튼 누를 때
			// null 값 체크
			String orderBy = "";
			String keyword = "";
			int minPrice = 0;
			int maxPrice = 0;
			
			System.out.println(request.getParameter("orderBy"));
			System.out.println(request.getParameter("keyword"));
			System.out.println(request.getParameter("minPrice"));
			System.out.println(request.getParameter("maxPrice"));
			
			if(request.getParameter("orderBy") != null) {
				orderBy = request.getParameter("orderBy");
			}
			if(request.getParameter("keyword") != "") {
				keyword = request.getParameter("keyword");
			}
			if (request.getParameter("minPrice") != "") {
				minPrice = Integer.parseInt(request.getParameter("minPrice"));
			}
			if (request.getParameter("maxPrice") != "") {
				maxPrice = Integer.parseInt(request.getParameter("maxPrice"));
			}
			
			ItemSearchDAO dao = new ItemSearchDAO();
			
			try {
				ArrayList<ItemViewDTO> searchList = dao.searchItems(orderBy, keyword, minPrice, maxPrice);
				int itemCount = dao.countSearchItems(uri, keyword, minPrice, maxPrice);
				System.out.println(searchList);
				
				HashMap<String, Object> searchMap = new HashMap<String, Object>();
				
				searchMap.put("orderBy", orderBy);
				searchMap.put("keyword", keyword);
				searchMap.put("minPrice", minPrice);
				searchMap.put("maxPrice", maxPrice);
				
				request.setAttribute("itemList", searchList);
				request.setAttribute("itemCount", itemCount);
				request.setAttribute("searchMap", searchMap);
				request.getRequestDispatcher("/shop/searchitem.jsp").forward(request, response);
			
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		if (uri.equals("/searchOrderBy.item")) { // 검색페이지 정렬조건 누를때
			String orderBy = request.getParameter("orderBy");
			String keyword = request.getParameter("keyword");
			int minPrice = Integer.parseInt(request.getParameter("minPrice"));
			int maxPrice = Integer.parseInt(request.getParameter("maxPrice"));
			
			System.out.println(request.getParameter("orderBy"));
			System.out.println(request.getParameter("keyword"));
			System.out.println(request.getParameter("minPrice"));
			System.out.println(request.getParameter("maxPrice"));
			
			ItemSearchDAO dao = new ItemSearchDAO();
			
			try {
				ArrayList<ItemViewDTO> searchList = dao.searchItems(orderBy, keyword, minPrice, maxPrice);
				System.out.println(searchList);
				
				Gson gson = new Gson();
				String rs = gson.toJson(searchList);
				System.out.println(rs);
				response.setCharacterEncoding("utf-8");
				response.getWriter().append(rs);
			
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if (uri.equals("/categoryOrderBy.item")) { // 카테고리 정렬조건 누를때
			String orderBy = request.getParameter("orderBy");
			String category_id = request.getParameter("category_id");
			System.out.println(orderBy);
			System.out.println(category_id);
			
			ItemSearchDAO dao = new ItemSearchDAO();
			
			try {
				ArrayList<ItemViewDTO> searchList = dao.searchItems(orderBy, category_id);
				System.out.println(searchList);
				
				Gson gson = new Gson();
				String rs = gson.toJson(searchList);
				System.out.println(rs);
				response.setCharacterEncoding("utf-8");
				response.getWriter().append(rs);
			
			} catch (Exception e) {
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
