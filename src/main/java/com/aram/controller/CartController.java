package com.aram.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aram.dao.CartDAO;
import com.aram.dao.ItemDAO;
import com.aram.dto.CartDTO;
import com.aram.dto.Cart_ItemDTO;
import com.aram.dto.ItemDTO;
import com.aram.dto.UserDTO;
import com.google.gson.Gson;


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
			
			HttpSession session = request.getSession();
			String loginSession = ((UserDTO)session.getAttribute("loginSession")).getUser_id();	
			System.out.println("현재 로그인세션 ID : " + loginSession);
			
			
				request.setAttribute("loginSession", loginSession);
			
			CartDAO dao = new CartDAO();
			
			try {
				ArrayList<Cart_ItemDTO> list = dao.selectByUserId(loginSession);
				
				request.setAttribute("list", list);
				
				// 장바구니 데이터 (user_id ) 로 총 가격 (total) 구하기
				int total = dao.total(loginSession);
				System.out.println("총 금액 : " + total);
				request.setAttribute("total", total);
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("/shop/mycart.jsp").forward(request, response);
			
		}
		if(uri.equals("/cartProc.cart")) {
			
			HttpSession session = request.getSession();
			String loginSession = ((UserDTO)session.getAttribute("loginSession")).getUser_id();	
			System.out.println("현재 로그인세션 ID : " + loginSession);
			
			
			int item_no = Integer.parseInt(request.getParameter("item_no"));  
			System.out.println("item_no = " + item_no);
			
			int quantity = Integer.parseInt(request.getParameter("result"));
			System.out.println("수량 : " + quantity);
			
			ArrayList<ItemDTO> list = new ArrayList<>(); // 장바구니에 담긴 아이템들 리스트
			
			ItemDAO dao = new ItemDAO(); 
			try {
				
				ItemDTO item = dao.selectItemByNo(item_no);
				System.out.println("선택된 아이템 정보 : " + item);
				list.add(item);
				CartDAO cartDao = new CartDAO();
				
				System.out.println("장바구니에 있는지 유무(없으면 true) : " + cartDao.existItem(item_no));
				
				if(cartDao.existItem(item_no)) { // 현재 장바구니에 없는 아이템 
					
					// 장바구니 테이블에 데이터 추가
					cartDao.addCart(new CartDTO(loginSession, item_no, quantity));
				
					
				}else {  // 장바구니에 이미 존재하는 아이템
				
					cartDao.updateQuantity(quantity, loginSession, item_no); //기존 quantity +추가된 quantity
					
				}
				
				response.sendRedirect("/mycart.cart");
				
			} catch (Exception e) {
				
				e.printStackTrace();
			}
			
		}
		if(uri.equals("/deleteCart.cart")) { //장바구니 아이템 삭제
			
			HttpSession session = request.getSession();
			String loginSession = ((UserDTO)session.getAttribute("loginSession")).getUser_id();	
			System.out.println("현재 로그인세션 ID : " + loginSession);
			
			
			String[] checkVals = request.getParameterValues("checkVals");
			CartDAO dao = new CartDAO();
			
			
			for(int i = 0 ; i <  dao.length(checkVals); i++) {
				  System.out.println("checkVals : " + checkVals[i]);
				  try {
					  dao.deleteItem(loginSession, Integer.parseInt(checkVals[i]));
				  }catch(Exception e) {
					  e.printStackTrace();
				  }
			}
				 
			
			  try {
		
		
				ArrayList<Cart_ItemDTO> list = dao.selectAll();
				Gson gson = new Gson();
				String result = gson.toJson(list);
			
				
				
				
				response.getWriter().append(result);
		
				
			
				
			} catch (Exception e) {
				e.printStackTrace();
			}
				 
	
			
			
		}
		
		
		
		
		
	
	
	
	}

	
}
