<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.aram.dto.UserDTO"%>
<%@ page import="com.aram.dao.UserDAO"%>
<%@ page import="com.aram.utils.SHA256"%>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	String userPassword = null;
	String userEmail = null;
	if(request.getParameter("userID") != null){
		userID = request.getParameter("userId");
	}
	if(request.getParameter("userPassword") != null) {
		userPassword = request.getParameter("userPassword");
	}
	if(request.getParameter("userEmail") != null) {
		userEmail = request.getParameter("userEmail");
	}
	if(userID == null || userPassword == null || userEmail == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('회원가입을 해주세요.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	// 회원가입 안했을경우..?
	//UserDAO userDAO = new UserDAO();
	//int result = userDAO.
%>
