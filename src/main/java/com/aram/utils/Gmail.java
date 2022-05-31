package com.aram.utils;

import java.net.Authenticator;
import java.net.PasswordAuthentication;

public class Gmail extends Authenticator {
	
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("aramproj@gmail.com", "!aram06123");
	}
	
}
