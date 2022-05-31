<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.aram.dto.UserDTO"%>
<%@ page import="com.aram.dao.UserDAO"%>
<%@ page import="com.aram.utils.SHA256"%>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
	String user_id = null;
	String user_pw = null;
	String email = null;
	if(request.getParameter("user_id") != null){
		user_id = request.getParameter("user_id");
	}
	if(request.getParameter("user_pw") != null) {
		user_pw = request.getParameter("user_pw");
	}
	if(request.getParameter("email") != null) {
		email = request.getParameter("email");
	}
	if(user_id == null || user_pw == null || email == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('회원가입을 해주세요.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	// 회원가입 안했을경우..?
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='/join.user';");
		script.println("</script>");
	
	
%>
