package com.aram.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aram.dao.NoticeDAO;
import com.aram.dao.QnaDAO;
import com.aram.dto.NoticeDTO;
import com.aram.dto.QnaDTO;
import com.aram.dto.UserDTO;
import com.google.gson.Gson;

@WebServlet("*.bo")
public class BoardController extends HttpServlet {
	
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
		
		UserDTO userdto = new UserDTO();
		HttpSession session = request.getSession();
		
		session.setAttribute("loginSession", userdto);
		session.getAttribute("loginSession");
		System.out.println(userdto);
	
		
		// Notice 
		if(uri.equals("/notice.bo")) { //Notice_ 게시판 메인
			int curPage = 1;
			System.out.println("curPage");
			
			session.getAttribute("loginSession");
			System.out.println(userdto);
			
			NoticeDAO dao = new NoticeDAO();
			
			
			try {
				
				// HashMap map = dao.getPageNavi(curPage);
				
				ArrayList<NoticeDTO> list = dao.selectAll(curPage*10-9, curPage*10);
				System.out.println(list);
				request.setAttribute("list", list);
				// request.setAttribute("naviMap", map);
				request.getSession();
			}catch(Exception e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("/board/notice.jsp").forward(request, response);
			
		
		// Notice_게시글 검색
		}else if(uri.equals("/noticeSearchProc.bo")) { // Notice_글쓴이 검색 요청

			
			String searchAuthor = request.getParameter("searchauthor");
			String searchTitle = request.getParameter("searchtitle");
			String searchContent = request.getParameter("searchcontent");
			System.out.println("searchAuthor : " + searchAuthor);
			System.out.println("searchTitle : " + searchTitle);
			System.out.println("searchContent : " + searchContent);
				
			NoticeDAO dao = new NoticeDAO();
			try {
				
				if(searchAuthor != null) { // 글쓴이 조회
					ArrayList<NoticeDTO> list = dao.searchByAuthor(searchAuthor);
					Gson gson = new Gson();
					String rs = gson.toJson(list);
					System.out.println(rs);
					response.setCharacterEncoding("utf-8");
					response.getWriter().append(rs);
					
				
				}else if(searchTitle != null){ // 제목 조회
					ArrayList<NoticeDTO> list = dao.searchByTitle(searchTitle);
					Gson gson = new Gson();
					String rs = gson.toJson(list);
					System.out.println(rs);
					response.setCharacterEncoding("utf-8");
					response.getWriter().append(rs);
					
					
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		
		// Notice 게시글 작성
		}else if(uri.equals("/writeNotice.bo")) { //Notice_게시글작성 페이지 요청
			
			response.sendRedirect("/board/writeNotice.jsp");
			
		}else if(uri.equals("/writeNoticeProc.bo")) { //Notice_게시글 작성
			
//			UserDTO userdto = (UserDTO)request.getSession().getAttribute("loginSession");
//			System.out.println(userdto);
			NoticeDTO noticedto = new NoticeDTO();
			
			String user_id = userdto.getUser_id();
			String author = userdto.getNickname();
			
			int notice_no = noticedto.getNotice_no();
			String write_date = noticedto.getWrite_date();
			
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			System.out.println(notice_no + " : " + user_id + " : " + title + " : " + author + " : " + write_date + " : " + content);
			
			NoticeDAO dao = new NoticeDAO();
			
			try {
				int rs = dao.write(new NoticeDTO(notice_no, user_id, title, author, write_date , content, 0));
				if(rs > 0) {
					
					response.sendRedirect("/notice.bo");
					
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			
			/*
			 * else if(uri.equals("/writeProc.bo")) { // 글쓰기 요청
			MemberDTO dto = (MemberDTO)request.getSession().getAttribute("loginSession");
			String writer_nickname = dto.getNickname();
			String writer_id = dto.getId();
			String title = request.getParameter("title");
			String content = request.getParameter("content");

			System.out.println(writer_nickname + " : " + writer_id + " : " + title + " : " + content);

			BoardDAO dao = new BoardDAO();
			try {
				int rs = dao.write(new BoardDTO(0,title,content,writer_nickname,writer_id,0,null));
				if(rs > 0) {
					response.sendRedirect("/board.bo");
				}
			}catch(Exception e) {
				e.printStackTrace();
			}	
			 * 
			 * 
			 * 
			 * 
			 * String writer_nickname = dto.getNickname();
			String writer_id = dto.getId();
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			System.out.println(writer_nickname + " : " + writer_id + " : " + title + " : " + content);
		
			BoardDAO dao = new BoardDAO();
			try {
				int rs = dao.write(new BoardDTO(0,title,content,writer_nickname,writer_id,0,null));
				if(rs > 0) {
					response.sendRedirect("/board.bo");
				}
			}catch(Exception e) {
				e.printStackTrace();
			}			
			 * */
		
		// Notice 게시글 상세보기
		}else if(uri.equals("/detailViewNotice.bo")) { // Notice_detailview 게시글 상세보기
			
			int notice_no = Integer.parseInt(request.getParameter("notice_no"));
			System.out.println("seq_board : " + notice_no);
			NoticeDAO dao = new NoticeDAO();
			
			try {
				NoticeDTO dto = dao.selectBySeq(notice_no);
				request.setAttribute("dto", dto);
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			// 조회수
//			int notice_no = Integer.parseInt(request.getParameter("notice_no"));
//			System.out.println("notice_no : " + notice_no);
//			NoticeDAO noticeDAO = new NoticeDAO();
//			try{
//				noticeDAO.updateView_count(notice_no);
//			}catch(Exception e) {
//				e.printStackTrace();
//			}
			
			
			request.getRequestDispatcher("/board/detailViewNotice.jsp").forward(request, response);
			
			
		}else if(uri.equals("/modifyNotice.bo")) { // Notice게시글 수정요청
			int notice_no = Integer.parseInt(request.getParameter("notice_no"));
			System.out.println(notice_no);
			
			NoticeDAO dao = new NoticeDAO();
			
			try {
				NoticeDTO dto = dao.selectBySeq(notice_no);
				request.setAttribute("dto", dto);
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			request.getRequestDispatcher("/board/modifyNotice.jsp").forward(request, response);
			
		}else if(uri.equals("/modifyNoticeProc.bo")) { // Notice게시글 수정
			
			int notice_no =Integer.parseInt(request.getParameter("notice_no"));
			String title = request.getParameter("title");
			String content = request.getParameter("content");
//			System.out.println(notice_no);
			
			NoticeDTO dto = new NoticeDTO();
		
			String user_id = dto.getUser_id();
			String author = dto.getAuthor();
			String write_date = dto.getWrite_date();
			
			
			NoticeDAO dao = new NoticeDAO();
			
			try {
				int rs = dao.modify(new NoticeDTO(notice_no, user_id, title, author, write_date, content, 0));
				if(rs > 0) {
					response.sendRedirect("/detailViewNotice.bo?notice_no=" + notice_no);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			
		}else if(uri.equals("/deleteNotice.bo")) { // Notice게시글 삭제
			int notice_no = Integer.parseInt(request.getParameter("notice_no"));
			System.out.println(notice_no);
			
			NoticeDAO dao = new NoticeDAO();
			try{
				int rs = dao.delete(notice_no);
				if(rs > 0) {
//					System.out.println("삭제 완료");
					response.sendRedirect("/notice.bo");
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			
			
		// QnA 게시판	
		}else if(uri.equals("/qna.bo")) { // qna 게시판 메인
			
			QnaDAO dao = new QnaDAO();
			
			try {
				
				
				ArrayList<QnaDTO> list = dao.qnaSelectAll();
				System.out.println(list);
				request.setAttribute("qnalist", list);

			}catch(Exception e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("/board/qna.jsp").forward(request, response);
			

		}else if(uri.equals("/qnaSearchProc.bo")) { // Qna_글쓴이 검색 요청

			
			String searchAuthor = request.getParameter("searchauthor");
			String searchTitle = request.getParameter("searchtitle");

			System.out.println("searchAuthor : " + searchAuthor);
			System.out.println("searchTitle : " + searchTitle);

				
			QnaDAO dao = new QnaDAO();
			try {
				
				if(searchAuthor != null) { // 글쓴이 조회
					ArrayList<QnaDTO> list = dao.searchByUserId(searchAuthor);
					Gson gson = new Gson();
					String rs = gson.toJson(list);
					System.out.println(rs);
					response.setCharacterEncoding("utf-8");
					response.getWriter().append(rs);
					
				
				}else if(searchTitle != null){ // 제목 조회
					ArrayList<QnaDTO> list = dao.searchByTitle(searchTitle);
					Gson gson = new Gson();
					String rs = gson.toJson(list);
					System.out.println(rs);
					response.setCharacterEncoding("utf-8");
					response.getWriter().append(rs);
					
					
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			
		}

	}
}
