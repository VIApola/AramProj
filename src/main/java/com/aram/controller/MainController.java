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
		
		if(uri.equals("/toQnA.main")) {//네비게이션 QnA 페이지로
			response.sendRedirect("/board/qna.jsp");
		}else if(uri.equals("/toNotice.main")) {//네비게이션 Notice 페이지로
			response.sendRedirect("/board/notice.jsp");
			
		}else if(uri.equals("/toMypage.main")) {//마이페이지로
			response.sendRedirect("/member/mypage.jsp");
		
		}else if(uri.equals("/toMycart.main")) {//장바구니페이지
			response.sendRedirect("/shop/mycart.jsp");
			
		}else if(uri.equals("/error.main")){ // 에러 발생시 에러페이지로
			response.sendRedirect("/error.jsp");
		}
		
	}
}
