package com.aram.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aram.dao.ItemDAO;
import com.aram.dto.ItemViewDTO;
import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


@WebServlet("*.admin")
public class AdminController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();
		System.out.println("요청 uri" + uri);
		
		
	
		
		
		
		if(uri.equals("/itemUpload.admin")) { // 상품등록
			System.out.println("파일 업로드 요청");

		String realPath = request.getServletContext().getRealPath("");	
		
		String filePath = request.getServletContext().getRealPath("files");
			System.out.println(realPath + " : " +filePath);
		
		File dir = new File(filePath);	
		if(!dir.exists()) {
			dir.mkdirs();	
		}
		
		int maxSize = 1024*1024*10;
		
		
		try {
			
			MultipartRequest multi = new MultipartRequest(request,filePath,maxSize,"utf-8",new DefaultFileRenamePolicy());
			
			String ori_name = multi.getOriginalFileName("img_title");
			String sys_name	= multi.getFilesystemName("img_title");
			
			System.out.println("업로드할 파일명"+ori_name+" : "+sys_name);
			String item_name = multi.getParameter("item_name");
			String category_name = multi.getParameter("category_name");
			int price = Integer.parseInt(multi.getParameter("price"));
			int item_stock = Integer.parseInt(multi.getParameter("item_stock"));
			String item_comment = multi.getParameter("item_comment");
			
			System.out.println("파일등록 : "+item_name+" : "+category_name+" : "+price+" : "+item_stock+" : "+item_comment);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		
		
		} else if (uri.equals("/toItemPage.admin")) { // 관리자 페이지(상품관리) 이동 요청

			ItemDAO itemDao = new ItemDAO();
			
			try {
				ArrayList<ItemViewDTO> mngItemList = itemDao.mngItemList();
				System.out.println(mngItemList);
				
				int count = itemDao.countAllItems();
				
				request.setAttribute("count", count);
				request.setAttribute("mngItemList", mngItemList);
				request.getRequestDispatcher("/admin/itemManagePage.jsp").forward(request, response);
				
			} catch(Exception e) {
				e.printStackTrace();
			}

		} else if (uri.equals("/toUserManage.admin")) { //관리자 페이지(고객관리) 이동 요청
	         response.sendRedirect("/admin/blacklist.jsp");
	         
		} else if (uri.equals("/toNoticeManage.admin")) { // 관리자 페이지 (공지사항 관리) 이동 요청
			response.sendRedirect("/board/notice.jsp");
			
		} else if (uri.equals("/toModifyItem.admin")) { // 개별상품 수정버튼 눌렀을 때
			int item_no = Integer.parseInt(request.getParameter("item_no"));
			System.out.println(item_no);
			
			ItemDAO itemdao = new ItemDAO();
			try {
				ItemViewDTO dto = itemdao.selectByItemNo(item_no);
				request.setAttribute("dto", dto);
				System.out.println(dto);
				
				// RealPath로 쓰면 맨 앞에 슬래시가 2개가 더 생겨서 취소
//				String filePath = request.getServletContext().getRealPath("/resources/images/items");
//				System.out.println(filePath);
//				request.setAttribute("filePath", filePath);
				
				
				
			} catch(Exception e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("/admin/itemModify.jsp").forward(request, response);
			
		}
//		else if () {
//			
//		}
		
		
		
		
		
		
		
	}
}
