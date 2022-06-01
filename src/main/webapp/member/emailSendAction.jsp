<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.Address" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Authenticator" %>
<%@ page import="java.util.Properties" %>
<%@ page import="com.aram.dao.UserDAO"%>
<%@ page import="com.aram.utils.SHA256"%>
<%@ page import="com.aram.utils.Gmail" %>
<%@ page import="java.io.PrintWriter" %>
<%
	UserDAO userDAO = new UserDAO();
	String user_id = null;
	if(session.getAttribute("loginSession.user_id") != null){
		user_id = (String) session.getAttribute("loginSession.user_id"); 
	}
	if(user_id == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href='/login.user'");
		script.println("</script>");
		script.close();
		return;
	}
	boolean emailChecked = userDAO.getUserEmailChecked(user_id);
	if(emailChecked == true){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 인증된 회원입니다.');");
		script.println("location.href='/main'");
		script.println("</script>");
		script.close();
		return;
	}
	
	String host = "http://localhost:8080/main";
	String from = "armaproj@gmail.com";
	String to = userDAO.getUserEmail(user_id);
	String subject = "Aram 사이트 가입을 위한 이메일 인증입니다.";
	String content = "다음 링크에 접속하여 이메일 인증을 진행하세요."+
		"<a href='" + host + "emailCheckAction.jsp?code="+ new SHA256().getSHA256(to)
		+ "'>이메일 인증하기</a>";
		
		Properties p = new Properties();
		p.put("mail.smtp.user",  from);
		p.put("mail.smpt.host", "smtp.googlemail.com");
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttles.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");
	
		try{
			Authenticator auth = new Gmail();
			Session ses = Session.getInstance(p, auth);
			ses.setDebug(true);
			MimeMessage msg = new MimeMessage(ses);
			msg.setSubject(subject);
			Address fromAddr = new InternetAddress(from);
			msg.setFrom(fromAddr);
			Address toAddr = new InternetAddress(to);
			msg.addRecipient(Message.RecipientType.TO, toAddr);
			msg.setContent(content, "text/html;charset=UTF-8");
			Transport.send(msg);
			
		}catch(Exception e){
			e.printStackTrace();
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('오류가 발생했습니다.');");
			script.println("history.back()");
			script.println("</script>");
			script.close();
			return;
		}
%>
