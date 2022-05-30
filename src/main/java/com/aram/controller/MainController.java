package com.aram.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aram.dao.ItemDAO;
import com.aram.dto.ItemDTO;


@WebServlet("*.main")
public class MainController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		doAction(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}
	
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String uri = request.getRequestURI();
		System.out.println("uri" + uri);
		
		if(uri.equals("/searchProc.main")) {//sm크기에 나오는 네비게이션 검색창에서 검색어입력했을떄
			String searchKeyword = request.getParameter("searchKeyword");
			
			
			ItemDAO dao = new ItemDAO(); 
			
			try {
				ArrayList<ItemDTO> list = dao.searchByTitle(searchKeyword);
				request.setAttribute("searchList", list);
				
			}catch(Exception e) {
				e.printStackTrace();
			}	
			request.getRequestDispatcher("/shop/searchitem.jsp").forward(request, response);
		
		}else if(uri.equals("/toQnA.main")) {//네비게이션 QnA 페이지로
			response.sendRedirect("/board/qna.jsp");
		}else if(uri.equals("/toNotice.main")) {//네비게이션 Notice 페이지로
			response.sendRedirect("/board/notice.jsp");
			
		}else if(uri.equals("/toSearchPage.main")) {//검색페이지로
			response.sendRedirect("/shop/searchitem.jsp");
		}else if(uri.equals("/toMypage.main")) {//마이페이지로
			response.sendRedirect("/member/mypage.jsp");
		}else if(uri.equals("/toLogin.main")) {//로그인 페이지
			response.sendRedirect("/member/login.jsp");
		}else if(uri.equals("/toLogout.main")) {//로그아웃 기능 요청
			HttpSession session = request.getSession();
			session.getAttribute("loginSession");
			session.invalidate();
			response.sendRedirect("/main"); //로그아웃하면 main으로
		}else if(uri.equals("/toMycart.main")) {//장바구니페이지
			response.sendRedirect("/shop/mycart.jsp");
			
		}else if(uri.equals("/toJoin.main")){ //회원가입 페이지
			response.sendRedirect("/member/join.jsp");
		}
		
	}
}
