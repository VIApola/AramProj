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
import com.aram.dao.OrderDAO;
import com.aram.dto.Cart_ItemDTO;
import com.aram.dto.OrderDTO;
import com.aram.dto.UserDTO;

@WebServlet("*.order")
public class OrderController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}
	
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		System.out.println(uri);
		
		request.setCharacterEncoding("utf-8");
		
		if (uri.equals("/toOrderPage.order")) {
			// 주문페이지로 이동
			
		} else if(uri.equals("/purchase.order")) {
			// 주문 페이지 출력
			HttpSession session = request.getSession();
			UserDTO user = (UserDTO)session.getAttribute("loginSession");
			String user_id = user.getUser_id();
			
			CartDAO dao = new CartDAO();
			
			try {
				ArrayList<Cart_ItemDTO> cartList = dao.selectByUserId(user_id);
				
				request.setAttribute("cartList", cartList);
				
				request.getRequestDispatcher("/shop/purchase.jsp").forward(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if(uri.equals("/complete.order")) {
			// 주문완료 요청
			HttpSession session = request.getSession();
			UserDTO user = (UserDTO)session.getAttribute("loginSession");
			
			String user_id = user.getUser_id();
			String order_name = request.getParameter("order_name");
			String order_email = request.getParameter("order_email");
			String order_phone = request.getParameter("order_phone");
			String delivery_name = request.getParameter("delivery_name");
			String delivery_phone = request.getParameter("delivery_phone");
			String delivery_addr = request.getParameter("delivery_addr");
			String order_msg = request.getParameter("order_msg");
			String delivery_msg = request.getParameter("delivery_msg");
			
			System.out.println(order_name);
			System.out.println(order_email);
			System.out.println(order_phone);
			System.out.println(delivery_name);
			System.out.println(delivery_phone);
			System.out.println(delivery_addr);
			System.out.println(order_msg);
			System.out.println(delivery_msg);
			
			
			OrderDAO dao = new OrderDAO();
			CartDAO cartDao = new CartDAO();
			
			try {
				
				int order_no = dao.getOrderNo();
				
				// ArrayList<Cart_ItemDTO> list = cartDao.selectByUserId(user_id);
				// System.out.println(list);
				
				// 총 합계 출력
				int order_amount = 0;
				// 주문서 생성
				int	orderResult = dao.createOrder(new OrderDTO(order_no, user_id, order_name, order_email, order_phone,
																null, order_amount, null, delivery_name, delivery_phone, 
																delivery_addr, order_msg, delivery_msg));
				// 카트에 담긴 상품 주문대기로 이동
				int addOrder = 0;

				if(orderResult > 0 && addOrder > 0) {
					// 주문이 정상적으로 완료
					System.out.println("주문 담기 완료");
					response.sendRedirect("/shop/successOrder.jsp");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
