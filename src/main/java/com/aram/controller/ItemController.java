package com.aram.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aram.dao.ItemDAO;
import com.aram.dto.ItemDTO;
import com.google.gson.internal.bind.DateTypeAdapter;

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
			
			ItemDAO dao = new ItemDAO();
			try {
				ArrayList<Object> itemList = dao.selectAllItems().get("list");
				request.setAttribute("itemList", itemList);
				request.getRequestDispatcher("/shop/detial.jsp");
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} else if(uri.equals("/detail.item")) { // 상품 상세페이지 로딩
			int item_no = Integer.parseInt(request.getParameter("item_no"));
			System.out.println("상품번호 : " + item_no);
			ItemDAO dao = new ItemDAO();
			
			try {
				ItemDTO itemDto = dao.selectItemByNo(item_no);
				dao.selectItemByNo(item_no);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(uri.equals("")) {
			
		}
		
		
		
		
		
		
		if(uri.equals("/air.item")) { //카테고리별 페이지 로드 (공기청정)
			
				ItemDAO dao = new ItemDAO();
			
	            try {
					ArrayList<Object> list = dao.selectAllItems().get("list");
					System.out.println("list 값 : " + list);
					request.setAttribute("list", list);
					
					int count = dao.countItems("P100"); // 카테고리별 물품 갯수
					request.setAttribute("count", count);
				} catch (Exception e) {
					e.printStackTrace();
				}
			
			request.getRequestDispatcher("/shop/category/air.jsp").forward(request, response);
			
		}else if(uri.equals("/interior.item")) {//카테고리별 페이지 로드 (내부)
			
			 ItemDAO dao = new ItemDAO();
	            try {
					ArrayList<Object> list = dao.selectAllItems().get("list");
					request.setAttribute("list", list);
					int count = dao.countItems("P200"); // 카테고리별 물품 갯수
					request.setAttribute("count", count);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			
			request.getRequestDispatcher("/shop/category/interior.jsp").forward(request, response);
		
		}else if(uri.equals("/outside.item")) { //카테고리별 페이지 로드 (외부)
			ItemDAO dao = new ItemDAO();
            try {
				ArrayList<Object> list = dao.selectAllItems().get("list");
				request.setAttribute("list", list);
				int count = dao.countItems("P300"); // 카테고리별 물품 갯수
				request.setAttribute("count", count);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		
            request.getRequestDispatcher("/shop/category/outside.jsp").forward(request, response);
		}
		
		
		
		
		
	}

}
