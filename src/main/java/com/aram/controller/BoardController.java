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
			System.out.println("얍!");
			NoticeDAO dao = new NoticeDAO();
			
			try {
				ArrayList<NoticeDTO> list = dao.selectAll();
				request.setAttribute("list", list);
			}catch(Exception e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("/board/notice.jsp").forward(request, response);
		}else if(uri.equals("/write.bo")) { // 게시굴 작성
			response.sendRedirect("/board/write.jsp");
		}
	}
}
