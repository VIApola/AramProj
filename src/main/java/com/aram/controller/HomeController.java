package com.aram.controller;

import java.io.IOException;

import java.util.ArrayList;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.aram.dao.ItemDAO;
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
		request.setCharacterEncoding("utf-8");
		
		ItemDAO ItemDAO = new ItemDAO();
		
		try {
			ArrayList<ItemDTO> list = ItemDAO.selectByStock();
			request.setAttribute("itemList", list);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("/main.jsp").forward(request, response);
	}

}
