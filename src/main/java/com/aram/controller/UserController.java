package com.aram.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aram.dao.UserDAO;
import com.google.gson.Gson;


@WebServlet("*.user")
public class UserController extends HttpServlet {
	
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
		if(uri.equals("/idCheck.user")) { // 아이디 중복체크 요청
			String id = request.getParameter("id");
			System.out.println("아이디 중복확인 : " + id);
			UserDAO dao = new UserDAO();
			
			try {
				int rs = dao.checkId(id);
				if(rs == 1) { // 사용할 수 있는 아이디라면
					System.out.println("아이디 사용가능");
					
				}else if(rs == 0) { // 중복된 아이디라면
					System.out.println("아이디 사용불가능");
				}
				Gson gson = new Gson();
				String result = gson.toJson(rs);
				response.getWriter().append(result+ "");
				request.setAttribute("id", id);
				
				request.getRequestDispatcher("/member/join.jsp").forward(request, response);
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			
		}
	}

}
