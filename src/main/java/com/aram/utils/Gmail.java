package com.aram.utils;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator {
	
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("devbontae9@gmail.com", "dfcyurhbororqbdj");
		// dfcyurhbororqbdj
	}
	
}
