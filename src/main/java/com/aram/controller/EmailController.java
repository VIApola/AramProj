package com.aram.controller;

import java.io.IOException;
import java.util.Properties;

import javax.mail.Transport;
import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aram.dao.UserDAO;
import com.aram.utils.Gmail;
import com.aram.utils.SHA256;

@WebServlet("*.email")
public class EmailController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}
	
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		System.out.println(uri);
		
		if(uri.equals("/send.email")) {
			String user_id = "fallows7";
					// request.getParameter("id");
			
			UserDAO dao = new UserDAO();
			String host = "http://localhost:8022/";
			String from = "devbontae9@gmail.com";
			String to= "";
			
			try {
				to = dao.getUserEmail("fallows7");
			} catch (Exception e) {
				e.printStackTrace();
			}
			String hashedEmail = new SHA256().getSHA256(to);
			
			String subject = "인증을 위한 이메일 입니다.";
			String content = "다음링크에 접속하여 이메일 인증을 완료하세요" + 
			 "<a href='" + host + "check.email?code=" + hashedEmail + "'>이메일인증하기</a>";
			
			Properties p = new Properties();
			p.put("mail.smtp.user", from);
			p.put("mail.smtp.host", "smtp.gmail.com");
			p.put("mail.smtp.port", "587");
			p.put("mail.smtp.starttls.enable", "true");
			p.put("mail.smtp.auth", "true");
			p.put("mail.smtp.debug", "true");
			p.put("mail.smtp.ssl.protocols", "TLSv1.2");
			p.put("mail.smtp.socketFactory.port", "465");
			p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			p.put("mail.smtp.socketFactory.fallback", "false");
			
			
			try {
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
				
				dao.setHashedEmail(user_id, hashedEmail);
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			
			System.out.println("전송완료");
			
			response.sendRedirect("/main");
			
			
		} else if(uri.equals("/check.email")){
			String code = request.getParameter("code");
			System.out.println(code);
			
			UserDAO dao = new UserDAO();
			try {
				int rs = dao.setUserEmailChecked(code);
				if(rs >0) {
					System.out.println("인증완료!");
					response.sendRedirect("/main");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		
		
	}

}
