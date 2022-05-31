package com.aram.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aram.dao.CartDAO;
import com.aram.dto.Cart_ItemDTO;


@WebServlet("*.cart")
public class CartController extends HttpServlet {

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
		response.setCharacterEncoding("utf-8");
		
		
		if(uri.equals("/mycart.cart")) { // 장바구니 페이지 요청 시
			
			CartDAO dao = new CartDAO();
			try {
				ArrayList<Cart_ItemDTO> list = dao.selectAll();
				request.setAttribute("list", list);
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("/shop/mycart.jsp").forward(request, response);
			
		}
		if(uri.equals("/cartProc.cart")) {
			int item_no = Integer.parseInt(request.getParameter("item_no"));  
			System.out.println(item_no);
		}
		
		
		
		
	
	
	
	}

	
}
