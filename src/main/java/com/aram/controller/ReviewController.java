package com.aram.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aram.dao.ImgFileDAO;
import com.aram.dao.ReviewDAO;
import com.aram.dto.ReviewDTO;
import com.aram.dto.UserDTO;
import com.google.gson.Gson;

@WebServlet("*.re")
public class ReviewController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}
	
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		
		if(uri.equals("/write.re")) { // 리뷰 등록 요청
			
			// Session에서 user_id 정보 가져오기
			HttpSession session = request.getSession();
			String user_id = ((UserDTO)session.getAttribute("loginSession")).getUser_id();
			String nickname = ((UserDTO)session.getAttribute("loginSession")).getNickname();
			System.out.println("현재 로그인세션 ID : " + user_id);

			String title = request.getParameter("title");
			int score = Integer.parseInt(request.getParameter("score"));
			String content = request.getParameter("content");
			int item_no = Integer.parseInt(request.getParameter("item_no"));
			
			System.out.println(title);
			System.out.println(score);
			System.out.println(content);
			System.out.println(item_no);
			
			ReviewDAO dao = new ReviewDAO();
			ImgFileDAO imgDao = new ImgFileDAO();
			
			try {
				int img_no = imgDao.getImgFileNo();
				int rs = dao.insertReview(new ReviewDTO(0, nickname, title, content, null, score, user_id, item_no, img_no));
				if (rs > 0) {
					
					ArrayList<ReviewDTO> reviewList = dao.selectAllReviewByItem(item_no);
					
					Gson gson = new Gson();
					String reviewData = gson.toJson(reviewList);
					System.out.println(reviewData);
					response.setCharacterEncoding("utf-8");
					response.getWriter().append(reviewData);
					
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			
		} else if(uri.equals("/modify.re")) { // 리뷰 수정 요청
			String title = request.getParameter("title");
			int score = Integer.parseInt(request.getParameter("score"));
			String content = request.getParameter("content");
			int item_no = Integer.parseInt(request.getParameter("item_no"));
			
			System.out.println(title);
			System.out.println(score);
			System.out.println(content);
			
			ReviewDAO dao = new ReviewDAO();
			
			try {
				int rs = dao.modifyReview(new ReviewDTO(0, null, title, content, null, score, null, 0, 0));
				if (rs > 0) {
					
					ArrayList<ReviewDTO> reviewList = dao.selectAllReviewByItem(item_no);
					
					Gson gson = new Gson();
					String reviewData = gson.toJson(reviewList);
					System.out.println(reviewData);
					response.setCharacterEncoding("utf-8");
					response.getWriter().append(reviewData);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} else if(uri.equals("/delete.re")) { // 리뷰 삭제 요청
			System.out.println("리뷰 등록 실행");
			int review_no = Integer.parseInt(request.getParameter("review_no"));
			int item_no = Integer.parseInt(request.getParameter("item_no"));
			ReviewDAO dao = new ReviewDAO();
			
			try {
				int rs = dao.deleteReview(review_no);
				if (rs > 0) {
					
					ArrayList<ReviewDTO> reviewList = dao.selectAllReviewByItem(item_no);
					
					Gson gson = new Gson();
					String reviewData = gson.toJson(reviewList);
					System.out.println(reviewData);
					response.setCharacterEncoding("utf-8");
					response.getWriter().append(reviewData);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
