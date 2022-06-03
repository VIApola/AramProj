package com.aram.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aram.dao.CartDAO;
import com.aram.dao.OrderDAO;
import com.aram.dto.Cart_ItemDTO;
import com.aram.dto.OrderDTO;
import com.aram.dto.OrderItemDTO;
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
		
		if (uri.equals("/toOrderPage.order")) {
			// 주문페이지로 이동
			
		} else if(uri.equals("/purchase.order")) {
			// 주문 페이지 출력
			UserDTO user = (UserDTO)request.getSession().getAttribute("loginSession");
			String user_id = user.getUser_id();
			String username = user.getUsername();
			String phone = user.getPhone();
			String email = user.getEmail();
			String addr = user.getAddr();
			
			UserDTO userDto = new UserDTO(user_id, null, username, null, phone, email,
					null, addr, null, null, null, null,
					null);
			
			// int quantity = Integer.parseInt(request.getParameter("quantity"));
			
			CartDAO cartDao = new CartDAO();
			
			try {
				ArrayList<Cart_ItemDTO> cartList = cartDao.selectByUserId(user_id);
				System.out.println(cartList);
				request.setAttribute("cartList", cartList);
				request.setAttribute("userInfo", userDto);
				request.getRequestDispatcher("/shop/purchase.jsp").forward(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if(uri.equals("/completeOrder.order")) {
			// 주문완료 요청
			UserDTO user = (UserDTO)request.getSession().getAttribute("loginSession");
			String user_id = user.getUser_id();
			
			String order_name = request.getParameter("name");
			String delivery_name = request.getParameter("deleivery_name");
			String delivery_addr = request.getParameter("delivery_addr");
			String order_msg = request.getParameter("order_msg");
			String delivery_msg = request.getParameter("delivery_msg");
			
			OrderDAO dao = new OrderDAO();
			CartDAO cartDao = new CartDAO();
			
			try {
				
				int order_no = dao.getOrderNo();
				
				ArrayList<Cart_ItemDTO> list = cartDao.selectByUserId(user_id);
				System.out.println(list);
				
				int totalPrice = 0;
				// 주문서 생성
				int	orderResult = dao.createOrder(new OrderDTO(order_no, user_id, order_name, null, null, delivery_name, delivery_addr, order_msg, delivery_msg));
				// 카드에 담긴 상품 주문대기로 이동
				
				int addOrder = 0;
				for (Cart_ItemDTO cart_ItemDTO : list) {
					int item_no = cart_ItemDTO.getItem_no();
					String item_name = cart_ItemDTO.getItem_name();
					int price = cart_ItemDTO.getPrice();
					int quantity = cart_ItemDTO.getQuantity();
					
					addOrder = dao.cartToOrder(new OrderItemDTO(order_no, item_no, item_name, price, quantity));
					// totalPrice += cart_ItemDTO.getPrice() * cart_ItemDTO.getQuantity();
				}
				// System.out.println("전체 금액 " + totalPrice);
				if(orderResult > 0 && addOrder > 0) {
					// 주문이 정상적으로 완료
					response.sendRedirect("/main");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
