package com.aram.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aram.dao.NoticeDAO;
import com.aram.dto.NoticeDTO;
import com.google.gson.Gson;

@WebServlet("*.bo")
public class BoardController extends HttpServlet {
	
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
		
		if(uri.equals("/notice.bo")) { // 게시글 뿌려주기
			NoticeDAO dao = new NoticeDAO();
			
			try {
				ArrayList<NoticeDTO> list = dao.selectAll();
				System.out.println(list);
				request.setAttribute("list", list);
			}catch(Exception e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("/board/notice.jsp").forward(request, response);
			

		}else if(uri.equals("/write.bo")) { // 게시굴 작성
			response.sendRedirect("/board/write.jsp");
		}else if(uri.equals("/searchProc.bo")) { // 글쓴이 검색 요청

			
			String searchAuthor = request.getParameter("searchauthor");
			String searchTitle = request.getParameter("searchtitle");
			String searchContent = request.getParameter("searchcontent");
			System.out.println("searchAuthor : " + searchAuthor);
			System.out.println("searchTitle : " + searchTitle);
			System.out.println("searchContent : " + searchContent);
				
			NoticeDAO dao = new NoticeDAO();
			try {
				
				if(!searchAuthor.equals(null)) {
					ArrayList<NoticeDTO> list = dao.searchByAuthor(searchAuthor);
					Gson gson = new Gson();
					String rs = gson.toJson(list);
					System.out.println(rs);
					response.setCharacterEncoding("utf-8");
					response.getWriter().append(rs);
					
				
				}else if(!searchTitle.equals(null)){
					ArrayList<NoticeDTO> list = dao.searchByTitle(searchTitle);
					Gson gson = new Gson();
					String rs = gson.toJson(list);
					System.out.println(rs);
					response.setCharacterEncoding("utf-8");
					response.getWriter().append(rs);
					
					
				}else if(!searchContent.equals(null)) {
					ArrayList<NoticeDTO> list = dao.searchByContent(searchContent);
					Gson gson = new Gson();
					String rs = gson.toJson(list);
					System.out.println(rs);
					response.setCharacterEncoding("utf-8");
					response.getWriter().append(rs);
					
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		}
	}
}
