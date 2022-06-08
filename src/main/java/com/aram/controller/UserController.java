package com.aram.controller;

import java.io.IOException;

import java.util.ArrayList;
import java.io.PrintWriter;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.aram.dao.ReviewDAO;
import com.aram.dao.CartDAO;

import com.aram.dao.UserDAO;
import com.aram.dto.MypageReviewDTO;
import com.aram.dto.UserDTO;
import com.aram.utils.EncryptionUtils;
import com.google.gson.Gson;

@WebServlet("*.user")
public class UserController extends HttpServlet {
	
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
		
    
		if (uri.equals("/idCheck.user")) { // 아이디 중복체크 요청


			String id = request.getParameter("id");
			System.out.println("아이디 중복확인 : " + id);
			UserDAO dao = new UserDAO();
			
			try {
				int rs = dao.checkId(id);
				if(rs == 1) { // 사용할 수 있는 아이디라면
					System.out.println("아이디 사용가능");
					response.getWriter().append("ok");
				}else if(rs == 0) { // 중복된 아이디라면
					System.out.println("아이디 사용불가능");
					response.getWriter().append("nope");
				}	
			}catch(Exception e) {
				e.printStackTrace();
			}

		}else if(uri.equals("/join.user")){// 회원가입 페이지 요청
			response.sendRedirect("/member/join.jsp");
			
		}else if(uri.equals("/signup.user")) { // 회원가입 하기
			String name = request.getParameter("name");
			String id = request.getParameter("id");
			String nickname = request.getParameter("nickname");
			String password = request.getParameter("password");
			String phone = request.getParameter("phone");
			String email = request.getParameter("email");
			String postcode = request.getParameter("postcode");
			String roadAddr = request.getParameter("roadAddr");
			String detailAddr = request.getParameter("detailAddr");
			
			System.out.println(name + " : " + id + " : " + nickname + " : " + password
					+ " : " + phone + " : " + email + " : " + roadAddr + " : " + detailAddr);
			
			UserDAO dao = new UserDAO();
			try {
				password = EncryptionUtils.getSHA512(password);
				System.out.println("암호화된 데이터 : " + password);
				
				int rs = dao.signup(new UserDTO(id, password, name, nickname, phone, email, postcode, roadAddr, detailAddr, null, "n", null, "n"));
				if(rs > 0) {
					response.sendRedirect("/login.user"); 
					//response.sendRedirect("/member/emailSendAction.jsp");
					//이메일 인증때문에..잠시

				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}else if(uri.equals("/login.user")){ // 로그인창 요청
			response.sendRedirect("/member/login.jsp");
		}else if(uri.equals("/loginProc.user")) { // 로그인 요청
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			System.out.println(id + " : " + pw);
			
			UserDAO dao = new UserDAO();
			try {
				pw = EncryptionUtils.getSHA512(pw);
				System.out.println("암호화된 비번 : " + pw);
				UserDTO dto = dao.isLoginOk(id, pw);
				// 이메일 인증은 했는지 확인
//				String checked = dao.getUserEmailChecked(id);
//				System.out.println(checked);
				/*
				if(checked.equals("n")) {
					System.out.println("이메일 인증이 완료되지 않았습니다. 가입시 입력한 이메일을 확인해주세요.");
					response.setContentType("text/html;charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.println("<script>alert('이메일이 등록 되지 않았습니다. 인증 메일을 확인해야 로그인 할 수 있습니다.'); location.href='/main'</script>");
					out.flush();
				} else {
					// db에 유저 정보가 있을 때
					if(dto != null) {
						System.out.println("로그인 성공");
						request.setAttribute("rs", true);
						HttpSession session = request.getSession();
						session.setAttribute("loginSession", dto);
						
						// 관리자 인증 먼저 // 로그인 시 관리자인지 아닌지 체크하는 부분
						if(dto.getIsAdmin().equals("y")) {
							request.getRequestDispatcher("/toItemPage.admin").forward(request, response);
						}else {
							request.getRequestDispatcher("/member/login.jsp").forward(request, response);

						
					} else { // db에 유저 정보가 없을 때
						System.out.println("로그인 실패");
						request.setAttribute("rs", false);
				}
				*/
				if(dto != null) {
					System.out.println("로그인 성공");
					request.setAttribute("rs", true);
					HttpSession session = request.getSession();
					session.setAttribute("loginSession", dto);

					if(dto.getIsAdmin().equals("n")) { // 일반 회원일 경우

						request.getRequestDispatcher("/member/login.jsp").forward(request, response);
						//request.getRequestDispatcher("/member/emailSendAction.jsp").forward(request, response);
					} else { // 관리자일경우
						request.getRequestDispatcher("/toItemPage.admin").forward(request, response);
					}

				}else {
					System.out.println("로그인 실패");
					request.setAttribute("rs", false);
					request.getRequestDispatcher("/member/login.jsp").forward(request, response);
				}

				
				//request.getRequestDispatcher("/member/emailSendAction.jsp").forward(request, response);
        
			}catch(Exception e) {
				e.printStackTrace();
			}
		}else if(uri.equals("/kakaoLogin.user")) { // 카카오 로그인
			String kakaoid = request.getParameter("userid");
			System.out.println("카카오 아이디 : " + kakaoid);
			
			UserDAO dao = new UserDAO();
			try {
				UserDTO dto = dao.kakaoLogin(kakaoid);
				
				if(dto != null) {
					System.out.println("로그인 성공");
					
					response.getWriter().append("ok");
					HttpSession session = request.getSession();
					session.setAttribute("loginSession", dto);
					
				}else {
					System.out.println("로그인 실패");
					response.getWriter().append("fail");
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		}else if(uri.equals("/kakaoSignup.user")) {//카카오 회원가입
			String kakaoid = request.getParameter("userid");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			System.out.println("카카오 아이디 : " + kakaoid + " 카카오 이름 : " +name+ " 카카오 이메일 : " +email);
			request.setAttribute("kakaoid", kakaoid);
			request.setAttribute("kakaoname", name);
			request.getRequestDispatcher("/member/kakaojoin.jsp").forward(request, response);
			
		}else if(uri.equals("/kakaoSignupProc.user")) { // 카카오 회원가입 요청
			String name = request.getParameter("name");
			String id = request.getParameter("id");
			String nickname = request.getParameter("nickname");
			String phone = request.getParameter("phone");
			String email = request.getParameter("email");
			String postcode = request.getParameter("postcode");
			String roadAddr = request.getParameter("roadAddr");
			String detailAddr = request.getParameter("detailAddr");
			
			System.out.println(name + " : " + id + " : " + nickname + " : " + phone + " : " + email + " : " + roadAddr + " : " + detailAddr);
			
			UserDAO dao = new UserDAO();
			try {
				String pw_id = EncryptionUtils.getSHA512(id);
				System.out.println("암호회된 비번 : " + pw_id);
				int rs = dao.signup(new UserDTO(id, pw_id, name, nickname, phone, email, postcode, roadAddr, detailAddr, id, "n", null, "n"));
				if(rs > 0) {
					response.sendRedirect("/login.user");
				}
			}catch(Exception e) {
				e.printStackTrace();
			}

		}else if(uri.equals("/toFinduser.user")) { // 아이디/비밀번호 찾기 페이지로 이동 요청
			response.sendRedirect("/member/finduser.jsp");			
		}else if(uri.equals("/searchToForgotId.user")) { // 아이디 찾기 요청
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			
			System.out.println(name + " : " + email);
			UserDAO userDao = new UserDAO();
			try {
				String id = userDao.findId(name, email);
				
				if(id == null) { // 해당 정보의 아이디가 존재하지 않음
					System.out.println("해당 정보의 아이디가 존재하지 않음");
					request.setAttribute("rsFindId", "n");
				} else { // 아이디 찾기 성공
					System.out.println("아이디 찾기 성공 : " + id);
					request.setAttribute("rsFindId", id);
				}
				request.getRequestDispatcher("/member/finduser.jsp").forward(request, response);
				
			} catch(Exception e) {
				e.printStackTrace();
			}
		} else if (uri.equals("/searchToForgotPw.user")) { // 비밀번호찾기
			String id = request.getParameter("id");
			String email = request.getParameter("email");
			
			System.out.println(id + " : " + email);
			
			UserDAO userDao = new UserDAO();
			try {
				String rsId = userDao.toChangePw(id, email);
				System.out.println("rsId : " + rsId);
				
				if(rsId == null) {
					request.setAttribute("rsChangePw", "n");
				} else {
					request.setAttribute("rsChangePw", "y");
					request.setAttribute("rsChangePwIdValue", rsId);
				}
				request.getRequestDispatcher("/member/finduser.jsp").forward(request, response);
				
			} catch(Exception e) {
				e.printStackTrace();
			}
			
		} else if (uri.equals("/toChange_pw.user")) { // 분실시 비밀변호 변경 페이지 요청
			String rsId = request.getParameter("rsId");
			System.out.println("비밀번호 찾기에서 가져온 id : " + rsId);
			request.setAttribute("idFromFindPw", rsId);
			request.getRequestDispatcher("/member/change_pw.jsp").forward(request, response);
			

		} else if (uri.equals("/completeChangePw.user")) { // 분실시 비밀번호 변경
			String userId = request.getParameter("userId");
			String password = request.getParameter("password");
			System.out.println("아이디 : " + userId + "/ 변경된 비밀번호 : " + password);
			
			try {
				password = EncryptionUtils.getSHA512(password);
				System.out.println("암호화된 데이터 : " + password);
				UserDAO userDao = new UserDAO();
				int rs = userDao.changePw(userId, password);
				if(rs>0) { // 변경 성공
					request.setAttribute("rsChangePw", "y");
				} else { // 변경 실패
					request.setAttribute("rsChangePw", "n");
				}
				request.getRequestDispatcher("/member/change_pw.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(uri.equals("/toLogout.user")) { //로그아웃  요청
			HttpSession session = request.getSession();
			session.getAttribute("loginSession");
			session.invalidate();
			response.sendRedirect("/main"); //로그아웃하면 main으로

		}else if(uri.equals("/toMypage.user")){// 마이페이지 요청
			HttpSession session = request.getSession();
			session.getAttribute("loginSession");		
			
			String session_id = ((UserDTO)session.getAttribute("loginSession")).getUser_id();	
			System.out.println("현재 로그인세션 ID :" + session_id);	
			request.setAttribute("loginSession", session.getAttribute("loginSession"));
			
			request.getRequestDispatcher("/member/mypage.jsp").forward(request, response);
			
		}else if(uri.equals("/delete.user")) { // 회원탈퇴 요청
		
			String id = request.getParameter("id");

			System.out.println("회원탈퇴 아이디 : " + id);
		
			try {
				UserDAO dao = new UserDAO();
				int rs = dao.deleteUser(id);
			
				if(rs > 0) {
					response.getWriter().append("true");
				}else {
					response.getWriter().append("false");
				}
				
				
			}catch(Exception e) {
				e.printStackTrace();
			}

		}else if(uri.equals("/deleteKakao.user")) { // 카카오 회원탈퇴 요청
			HttpSession session = request.getSession();
			session.getAttribute("loginSession");
			String session_id = ((UserDTO)session.getAttribute("loginSession")).getUser_id();	
			String session_social = ((UserDTO)session.getAttribute("loginSession")).getSocial_login();
			
			System.out.println("id : " + session_id + " , kakao ID : " + session_social);
			
			UserDAO dao = new UserDAO();
			
			try {
				
			int rs = dao.deleteKakaoUser(session_id, session_social);
			if(rs>0) {
				response.getWriter().append("success");
			}else {
				response.getWriter().append("fail");
			}
				
				
			}catch(Exception e) {
				e.printStackTrace();
			}	
			
		}else if(uri.equals("/deleteProc.user")) { // 회원탈퇴 조건 검사
			HttpSession session = request.getSession();
			session.getAttribute("loginSession");
			String session_id = ((UserDTO)session.getAttribute("loginSession")).getUser_id();	
			String session_pw = ((UserDTO)session.getAttribute("loginSession")).getUser_pw();
			
			System.out.println("session ID : " + session_id + " session_pw : " + session_pw);
			
			String id = request.getParameter("id");
			String raw_pw = request.getParameter("pw");


			try {
				
			String pw = EncryptionUtils.getSHA512(raw_pw);
			
			UserDAO dao = new UserDAO();

			
			if(dao.checkId(id) != 0 || !session_id.equals(id)) { // input값과 데이터값이 일치하면 0,현재 로그인세션값과 입력한 정보가 일치하는지
						
					response.getWriter().append("fail_id");
					return;
			}

			if(dao.checkPw(id, pw) != 0 || !session_pw.equals(pw)) { //일치하면 0
					response.getWriter().append("fail_pw");
					return;
			}else {
					response.getWriter().append("pass");
			}
			

			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(uri.equals("/review.user")) { // 마이페이지-리뷰 페이지 요청	
			
			
			HttpSession session = request.getSession();
			session.getAttribute("loginSession");
			String session_id = ((UserDTO)session.getAttribute("loginSession")).getUser_id();	
			
			System.out.println("현재 로그인세션 ID : " + session_id);
			UserDAO dao = new UserDAO();
			try {
				ArrayList<MypageReviewDTO> list = dao.selectAllById(session_id);

				System.out.println("리스트 : " + list);
	
				Gson gson = new Gson();
				
				String rs = gson.toJson(list);
			
				response.getWriter().append(rs);
				
				//dao.insertReview(new ReviewDTO( 0, "긴 제목 초과 시 ", "긴제목6글자이상테스트1트 ㄱㄱㄱㄱㄱㄱ", "a", 5, "hwi9201", 105, 4 ));
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		
			
			
			
			
			
			
		}else if(uri.equals("/modify.user")) { // 회원정보 수정 요청
			
			HttpSession session = request.getSession();
			// 세션에서 아이디값 꺼내기
			String id = (String)session.getAttribute("user_id");
			String nickname = request.getParameter("nickname");
			String phone = request.getParameter("phone");
			String email = request.getParameter("email");
			String postcode = request.getParameter("postcode");
			String roadAddr = request.getParameter("roadAddr");
			String detailAddr = request.getParameter("detailAddr");
			
			System.out.println(id + " : " + nickname + " : " + phone + " : " + email
					+ " : " + postcode + " : " + roadAddr + " : " + detailAddr );
			
		}
	}
}
