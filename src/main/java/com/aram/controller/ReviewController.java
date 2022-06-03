package com.aram.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aram.dao.ImgFileDAO;
import com.aram.dao.ReviewDAO;
import com.aram.dto.ReviewDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

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
			System.out.println("리뷰 등록 실행");
			
			String title = request.getParameter("title");
			int score = Integer.parseInt(request.getParameter("score"));
			String content = request.getParameter("content");
			int item_no = Integer.parseInt(request.getParameter("item_no"));
			
			// Session에서 user_id 정보 가져오기
			String user_id = "user1";
			
			System.out.println(title);
			System.out.println(score);
			System.out.println(content);
			System.out.println(item_no);
			
			ReviewDAO dao = new ReviewDAO();
			ImgFileDAO imgDao = new ImgFileDAO();
			
			/*
			String filePath = request.getServletContext().getRealPath("/resources/images/items");
			System.out.println(filePath);
			
			File dir = new File(filePath);
			if(!dir.exists()) {
				dir.mkdirs();
			}
			int maxSize = 1024*1024*10;
			
			MultipartRequest multi = new MultipartRequest(request, filePath, maxSize, "utf-8", new DefaultFileRenamePolicy());
			*/
			try {
				int img_no = imgDao.getImgFileNo();
				int rs = dao.insertReview(new ReviewDTO(0, title, content, null, score, user_id, item_no, img_no));
				if (rs >0) {
					response.sendRedirect("/main");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			
		} else if(uri.equals("/delete.re")) { // 리뷰 삭제 요청
			System.out.println("리뷰 등록 실행");
			int review_no = Integer.parseInt(request.getParameter("review_no"));
			
			ReviewDAO dao = new ReviewDAO();
			
			try {
				int rs = dao.deleteReview(review_no);
				if (rs > 0) {
					response.sendRedirect("/main");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
