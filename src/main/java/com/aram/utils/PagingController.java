package com.aram.utils;

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


@WebServlet("/PagingController")
public class PagingController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
		
	}
	
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String uri = request.getRequestURI();
		System.out.println("요청 uri : " + uri);
		
		if(uri.equals("")) {
			
			ItemDAO dao = new ItemDAO();
			
			int curPage = Integer.parseInt(request.getParameter("curPage"));
			
			try {
				HashMap map = dao.getPageNavi(curPage);
				
				System.out.println("현재 페이지 : " + curPage);
				System.out.println("startNavi : "+ map.get("startNavi"));
				System.out.println("endNavi : " + map.get("endNavi"));
				System.out.println("needPrev 필요합니까? : "+ map.get("needPrev"));
				System.out.println("needNext 필요합니까? : "+ map.get("needNext"));
				
				
				//페이징     //데이터 몇개 보여줄건지 ex. 8개를 데이터를 보여쥼. curPage*보여줄데이터개수-(보여줄데이터개수-(보여줄데이터개수-1))
				ArrayList<ItemDTO> pageList = dao.selectPagingAll(curPage*8-7, curPage*8);
				
				request.setAttribute("pageList",pageList);
				request.setAttribute("naviMap", map);
						

				System.out.println(pageList);
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("").forward(request, response);	
		
			
		}
		
	}
	
}
