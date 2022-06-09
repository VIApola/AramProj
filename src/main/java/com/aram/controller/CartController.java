package com.aram.controller;

import java.io.IOException;
import java.util.ArrayList;

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
			
			// 로그인만 회원만 가능하므로 세션값 필요
			HttpSession session = request.getSession();
			String loginSession = ((UserDTO)session.getAttribute("loginSession")).getUser_id();
			System.out.println("현재 로그인세션 ID : " + loginSession);
			
			CartDAO dao = new CartDAO();
			
			try {
				ArrayList<Cart_ItemDTO> list = dao.selectByUserId(loginSession);
				
				int listSize =  list.size();
				System.out.println("list : " + list.toString());
				
				request.setAttribute("list", list);
				request.setAttribute("listSize", listSize);
				// 장바구니 데이터 (user_id ) 로 총 가격 (total) 구하기
				int total = dao.total(loginSession);
				System.out.println("총 금액 : " + total);
				request.setAttribute("total", total);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("/shop/mycart.jsp").forward(request, response);
		}
		
		if(uri.equals("/cartProc.cart")) { // 장바구니 담기 누를 때
			
			HttpSession session = request.getSession();
			String user_id = ((UserDTO)session.getAttribute("loginSession")).getUser_id();
			System.out.println("현재 로그인세션 ID : " + user_id);
			
			// 상품정보와 수량 가져오기
			int item_no = Integer.parseInt(request.getParameter("item_no"));
			System.out.println("item_no = " + item_no);
			String item_name = request.getParameter("item_name");
			System.out.println("item_name = " + item_name);
			int price = Integer.parseInt(request.getParameter("price"));
			int quantity = Integer.parseInt(request.getParameter("qty"));
			System.out.println("수량 : " + quantity);
			
			ArrayList<ItemDTO> list = new ArrayList<>(); // 장바구니에 담긴 아이템들 리스트
			
			ItemDAO dao = new ItemDAO();
			CartDAO cartDao = new CartDAO();
			try {
				// 일단 장바구니를 비움
				cartDao.emptyCart(user_id);
				
				ItemDTO item = dao.selectItemByNo(item_no);
				System.out.println("선택된 아이템 정보 : " + item);
				list.add(item);
				
				System.out.println("장바구니에 있는지 유무(없으면 true) : " + cartDao.existItem(item_no));
				
				if(cartDao.existItem(item_no)) { // 현재 장바구니에 없는 아이템 
					// 장바구니 테이블에 데이터 추가
					cartDao.addCart(new CartDTO(user_id, item_no, quantity));
				} else {  // 장바구니에 이미 존재하는 아이템
					cartDao.updateQuantity(quantity, user_id, item_no); //기존 quantity +추가된 quantity
				}
				response.sendRedirect("/mycart.cart");
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		if (uri.equals("/delete.cart")) { // 장바구니 아이템 삭제
			
			HttpSession session = request.getSession();
			String user_id = ((UserDTO)session.getAttribute("loginSession")).getUser_id();	
			System.out.println("현재 로그인세션 ID : " + user_id);
			
			String[] checkVals = request.getParameterValues("checkVals");
			CartDAO dao = new CartDAO();
			
		
			for(int i = 0 ; i <  dao.length(checkVals); i++) {
				  System.out.println("checkVals : " + checkVals[i]);
				  try {
					  dao.deleteItem(user_id, Integer.parseInt(checkVals[i]));
				  } catch(Exception e) {
					  e.printStackTrace();
				  }
			}
			
			try {
				ArrayList<Cart_ItemDTO> list = dao.selectByUserId(user_id);
				Gson gson = new Gson();
				String result = gson.toJson(list);
			
				response.getWriter().append(result);
		
		
				
			} catch (Exception e) {
				e.printStackTrace();
			}
				 
		}
		
		if(uri.equals("/changeQty.cart")) { // 장바구니 수량 변경
			
			// 주문 페이지 출력
			HttpSession session = request.getSession();
			UserDTO user = (UserDTO)session.getAttribute("loginSession");
			String user_id = user.getUser_id();
			
			// item_no 배열 / 수량 배열 불러오기
			String[] item_no_arr = request.getParameterValues("item_no");
			String[] quantity_arr = request.getParameterValues("quantity");
			 
			CartDAO dao = new CartDAO();
			
			int rs = 0;
			try {
				// 장바구니에서 변경된 수량을 우선 적용하고 주문으로 넘어가기
				for(int i = 0; i < item_no_arr.length; i++) {
					int item_no = Integer.parseInt(item_no_arr[i]);
					int quantity = Integer.parseInt(quantity_arr[i]);
					rs = dao.updateQuantity(quantity, user_id, item_no);
					System.out.println(rs);
				}
				
				String text = "success";
				Gson gson = new Gson();
				String result = gson.toJson(text);
				
				response.setCharacterEncoding("utf-8");
				response.getWriter().append(result);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
