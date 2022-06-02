package com.aram.controller;

import java.io.IOException;
import java.util.ArrayList;

import java.util.ArrayList;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aram.dao.ItemDAO;
import com.aram.dto.ItemViewDTO;
import com.aram.dto.ItemDTO;
import com.aram.dao.ImgFileDAO;


@WebServlet("/main")
public class HomeController extends HttpServlet {

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
		
		ItemDAO itemDao = new ItemDAO();
		
		try {
			ArrayList<ItemViewDTO> list = itemDao.selectByStock();
			request.setAttribute("itemList", list);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("/main.jsp").forward(request, response);
	
	
		
		
		
		
		
	
	
	
	}

}
