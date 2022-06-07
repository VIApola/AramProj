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

// 세션 가져오기 : 공지사항 같은 경우 후에 관리자세션으로 연결할 것!
//HttpSession session = request.getSession();
//session.getAttribute("loginSession");


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
		// 세션 가져오기 : 공지사항(notice) 같은 경우 관리자세션으로 연결할 것!
//		HttpSession session = request.getSession();
//		session.getAttribute("loginSession");
//		System.out.println(userdto);
	
		
		//  =========================== Notice =========================== 
		
		// Notice_ 게시판 메인
		if(uri.equals("/notice.bo")) { 
			int curPage = 1;
			System.out.println("curPage");
			
			// 후에 관리자 세션으로 가져오기
			HttpSession session = request.getSession();
			session.getAttribute("loginSession");
			
			
			NoticeDAO dao = new NoticeDAO();
			
			
			try {
				
//				 HashMap map = dao.getPageNavi(curPage);
				
				ArrayList<NoticeDTO> list = dao.selectAll(curPage*10-9, curPage*10);
				System.out.println(list);
				request.setAttribute("list", list);

				request.getSession();

			}catch(Exception e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("/board/notice.jsp").forward(request, response);
			
		
		// Notice_게시판 게시글 검색
		}else if(uri.equals("/noticeSearchProc.bo")) {

			
			String searchAuthor = request.getParameter("searchauthor");
			String searchTitle = request.getParameter("searchtitle");
			String searchContent = request.getParameter("searchcontent");
			System.out.println("searchAuthor : " + searchAuthor);
			System.out.println("searchTitle : " + searchTitle);
			System.out.println("searchContent : " + searchContent);
				
			NoticeDAO dao = new NoticeDAO();
			try {
				
				if(searchAuthor != null) { // 글쓴이(Id) 조회
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
		
		// Notice_게시판 글작성
		}else if(uri.equals("/writeNotice.bo")) { // Notice_게시글 작성 페이지 요청
			
			response.sendRedirect("/board/writeNotice.jsp");
			
		}else if(uri.equals("/writeNoticeProc.bo")) { // Notice_게시글 작성 proc
			
			// 후에 관리자 세션으로 가져오기
			HttpSession session = request.getSession();
			session.getAttribute("loginSession");
			
			
			NoticeDTO noticedto = new NoticeDTO();
			
			String user_id = ((UserDTO)session.getAttribute("loginSession")).getUser_id();
			String author = ((UserDTO)session.getAttribute("loginSession")).getNickname();
			
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
			
			
		
		// Notice_게시판 게시글 상세보기
		}else if(uri.equals("/detailViewNotice.bo")) { // Notice_detailview
			int notice_no = Integer.parseInt(request.getParameter("notice_no"));
			System.out.println("notice_np : " + notice_no);
			NoticeDAO dao = new NoticeDAO();
			
			try {
				//조회수 +1
				dao.updateView_count(notice_no);
				//상세보기 페이지 게시
				NoticeDTO dto = dao.selectBySeq(notice_no);
				request.setAttribute("dto", dto);
			}catch(Exception e) {
				e.printStackTrace();
			}
									
			request.getRequestDispatcher("/board/detailViewNotice.jsp").forward(request, response);
			
		
		// Notice_게시판 게시글 수정
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
			
		
		// Notice_게시판 게시글 삭제	
		}else if(uri.equals("/deleteNotice.bo")) {
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
			
			
			
			
		// =========================== QnA 게시판 ===========================
		// Qna_게시판 메인	
		}else if(uri.equals("/qna.bo")) {
			
			QnaDAO dao = new QnaDAO();
			
			try {
				
				ArrayList<QnaDTO> list = dao.qnaSelectAll();
				System.out.println(list);
				request.setAttribute("qnalist", list);

			}catch(Exception e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("/board/qna.jsp").forward(request, response);
		
			
		// Qna_게시판 검색
		}else if(uri.equals("/qnaSearchProc.bo")) { 

			HttpSession session = request.getSession();
            session.getAttribute("loginSession");
			String searchId = request.getParameter("searchid");
			String searchTitle = request.getParameter("searchtitle");

//			System.out.println("searchAuthor : " + searchId);
//			System.out.println("searchTitle : " + searchTitle);
			// 세션 아이디값
			String session_id = request.getParameter("user_id");
			System.out.println("세션 아이디값 : " + session_id);	

			QnaDAO dao = new QnaDAO();
			
			try {
				
				if(searchId != null) { // 글쓴이(Id) 조회
					ArrayList<QnaDTO> list = dao.searchByUserId(searchId);
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
				else if(session_id != null) {// 세션아이디로 자기자신이 쓴 글 조회
					
					ArrayList<QnaDTO> list = dao.searchByUserId(session_id);
					Gson gson = new Gson();
					String rs = gson.toJson(list);
					System.out.println(rs);
					response.setCharacterEncoding("utf-8");
					response.getWriter().append(rs);
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		// Qna_게시판 게시글 작성
		}else if(uri.equals("/writeQna.bo")) { // qna 게시글 작성 페이지 이동
			
			response.sendRedirect("/board/writeQna.jsp");
			
		}else if(uri.equals("/writeQnaProc.bo")) { // qna 게시글 작성 Proc
			
			HttpSession session = request.getSession();
			
			QnaDTO dto = new QnaDTO();
			
			//세션서 아이디값 가져오기
			String user_id = ((UserDTO)session.getAttribute("loginSession")).getUser_id();
			
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String write_date = request.getParameter("write_date");
			Boolean answer_yn = Boolean.parseBoolean(request.getParameter("answer_yn"));
			
			System.out.println(user_id + " : " +  title + " : " + content + " : " + write_date + " : " + answer_yn);
			
			QnaDAO dao = new QnaDAO();
			try{
				int rs = dao.write(new QnaDTO(0, user_id, title, content, write_date, answer_yn, "", ""));
				if(rs > 0) {
					response.sendRedirect("/qna.bo");
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		
		// Qna_게시판 detailview 조회		
		}else if(uri.equals("/detailViewQna.bo")) { // Qna 게시판 상세글 조회
			int qna_no = Integer.parseInt(request.getParameter("qna_no"));
			System.out.println("qna_no : " + qna_no);
			
			QnaDAO dao = new QnaDAO();
			
			try {
				QnaDTO dto = dao.selectByNo(qna_no);
				request.setAttribute("dto", dto);
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			request.getRequestDispatcher("/board/detailViewQna.jsp").forward(request, response);
		
			
		// Qna_게시판 수정
		}else if(uri.equals("/modifyQna.bo")) { // Qna 게시글 수정페이지 요청
			int qna_no = Integer.parseInt(request.getParameter("qna_no"));
			System.out.println("qna_no : " + qna_no);
			
			QnaDAO dao = new QnaDAO();
			try {
				QnaDTO dto = dao.selectByNo(qna_no);
				request.setAttribute("dto", dto);
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			request.getRequestDispatcher("/board/modifyQna.jsp").forward(request, response);
			
		}else if(uri.equals("/modifyQnaProc.bo")) { // Qna 게시글 수정
			int qna_no = Integer.parseInt(request.getParameter("qna_no"));
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			QnaDTO dto = new QnaDTO();
			
			String user_id = dto.getUser_id();
			String write_date = dto.getWrite_date();
			Boolean answer_yn = dto.isAnswer_yn();
			String answer= dto.getAnswer();
			String answer_date = dto.getAnswer_date();
			
			QnaDAO dao = new  QnaDAO();
			
			try {
				int rs = dao.modify(new QnaDTO(qna_no, user_id, title, content, write_date, answer_yn, answer, answer_date));
				if(rs > 0) {
					response.sendRedirect("/detailViewQna.bo?qna_no=" + qna_no);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			
	
		// Qna_게시판 게시글 삭제
		}else if(uri.equals("/deleteQna.bo")) {
			int qna_no = Integer.parseInt(request.getParameter("qna_no"));
			System.out.println("qna_no : " + qna_no);
			
			QnaDAO dao = new QnaDAO();
			try {
				int rs = dao.delete(qna_no);
				if(rs > 0) {
					System.out.println("삭제!");
					response.sendRedirect("/qna.bo");
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		}

	}
}
