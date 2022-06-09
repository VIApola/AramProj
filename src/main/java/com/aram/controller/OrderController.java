package com.aram.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.valves.rewrite.InternalRewriteMap.Escape;

import com.aram.dao.CartDAO;
import com.aram.dao.ItemDAO;
import com.aram.dao.OrderDAO;
import com.aram.dto.CartDTO;
import com.aram.dto.Cart_ItemDTO;
import com.aram.dto.ItemDTO;
import com.aram.dto.OrderDTO;
import com.aram.dto.OrderItemDTO;
import com.aram.dto.UserDTO;
import com.google.gson.Gson;

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
			// 구매하기 버튼 누르면 주문으로 이동
			
			HttpSession session = request.getSession();
			UserDTO user = (UserDTO)session.getAttribute("loginSession");
			String user_id = user.getUser_id();
			
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
				// 기존에 장바구니에 있는 항목 비우기
				cartDao.emptyCart(user_id);
				
				// 장바구니에 담기
				
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
				
				response.sendRedirect("/purchase.order");
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			 
		} else if(uri.equals("/purchase.order")) {
			// 주문 페이지 출력
			HttpSession session = request.getSession();
			UserDTO user = (UserDTO)session.getAttribute("loginSession");
			String user_id = user.getUser_id();
			 
			CartDAO dao = new CartDAO();
			
			try {
				// 구매리스트
				ArrayList<Cart_ItemDTO> cartList = dao.selectByUserId(user_id);
				int totalPrice = dao.totalPrice(user_id);
				request.setAttribute("cartList", cartList);
				request.setAttribute("totalPrice", totalPrice);
				request.getRequestDispatcher("/shop/purchase.jsp").forward(request, response);

			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} else if(uri.equals("/complete.order")) {
			// 주문완료 요청
			HttpSession session = request.getSession();
			UserDTO user = (UserDTO)session.getAttribute("loginSession");
			
			String user_id = user.getUser_id();
			String order_no = request.getParameter("order_no");
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
				
				ArrayList<Cart_ItemDTO> cartList = cartDao.selectByUserId(user_id);
				// System.out.println(list);
				
				// 총 합계 출력
				int order_amount = cartDao.totalPrice(user_id);
				
				if (order_amount < 50000) {
					order_amount += 3000;
				}
				
				// 주문서 생성
				int	orderResult = dao.createOrder(new OrderDTO(order_no, user_id, order_name, order_email, order_phone,
																null, order_amount, null, delivery_name, delivery_phone, 
																delivery_addr, order_msg, delivery_msg));
				// 카트에 담긴 상품 주문대기로 이동
				int addOrder = 0;
				for (Cart_ItemDTO item : cartList) {
					int item_no = item.getItem_no();
					String item_name = item.getItem_name();
					int price = item.getPrice();
					int quantity = item.getQuantity();
					
					OrderItemDTO orderItem =  new OrderItemDTO(order_no, item_no, item_name, price, quantity);
					addOrder = dao.cartToOrder(orderItem);
				}

				if(orderResult > 0 && addOrder > 0) {
					// 주문이 정상적으로 완료
					System.out.println("주문 담기 완료");
					
					// 회원의 장바구니를 비우기
					cartDao.emptyCart(user_id);
					
					String text = "success";
					Gson gson = new Gson();
					String result = gson.toJson(text);
					
					response.setCharacterEncoding("utf-8");
					response.getWriter().append(result);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(uri.equals("/success.order")) {
      
      String order_no = request.getParameter("order_no");
			
			OrderDAO dao = new OrderDAO();
			try {
				OrderDTO orderDto =  dao.selectOrder(order_no);
				ArrayList<OrderItemDTO> itemList =  dao.selectOrderedItems(order_no);
				System.out.println(orderDto);
				System.out.println(itemList);
				
				request.setAttribute("order", orderDto);
				request.setAttribute("itemList", itemList);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("/shop/successOrder.jsp").forward(request, response);
			
		} else if(uri.equals("/orderValidation.order")) {
			
			String user_id = request.getParameter("user_id");
			int totalFromUser = Integer.parseInt(request.getParameter("totalPrice"));
			
			System.out.println(totalFromUser);
			
			CartDAO dao = new CartDAO();
			
			try {
				// DB에 저장된 실제 총 금액을 가져옴
				int totalFromDatabase = dao.totalPrice(user_id);
				System.out.println(totalFromDatabase + "db값");
				
				// DB에 저장된 금액이랑 유저가 보낸 금액을 비교
				if(totalFromUser == totalFromDatabase) {
					System.out.println("금액이 동일합니다.");
					// 5만원 이하면 배송비를 더해서 반환
					if(totalFromUser < 50000) {
						totalFromUser += 3000;
					} 
				} else {
					System.out.println("금액에 문제가 있습니다!");
					totalFromUser = -1;
				}
				System.out.println(totalFromUser);
				Gson gson = new Gson();
				String rs = gson.toJson(totalFromUser);
				response.setCharacterEncoding("utf-8");
				response.getWriter().append(rs);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(uri.equals("/selectUserOrder.order")) {// 유저아이디에 따른 구매목록
			HttpSession session = request.getSession();
            session.getAttribute("loginSession");
            String session_id = request.getParameter("user_id");
			System.out.println("세션 아이디값 : " + session_id);
			
			OrderDAO dao = new OrderDAO();
			try {
				if(session_id != null) {
					ArrayList<OrderDTO> list = dao.selectUserOrder(session_id);
					Gson gson = new Gson();
					String rs = gson.toJson(list);
					response.setCharacterEncoding("utf-8");
					response.getWriter().append(rs);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		}
	}

}
