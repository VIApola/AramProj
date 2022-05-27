package com.aram.dto;

public class UserDTO {
	private String user_id;
	private String user_pw;
	private String username;
	private String nickname;
	private String phone;
	private String email;
	private String post_no;
	private String addr;
	private String addr_detail;
	private String social_login;
	private boolean email_verify;
	private String join_date;
	private boolean isAdmin;
	
	public UserDTO() {}

	public UserDTO(String user_id, String user_pw, String username, String nickname, String phone, String email,
			String post_no, String addr, String addr_detail, String social_login, boolean email_verify,
			String join_date, boolean isAdmin) {
		super();
		this.user_id = user_id;
		this.user_pw = user_pw;
		this.username = username;
		this.nickname = nickname;
		this.phone = phone;
		this.email = email;
		this.post_no = post_no;
		this.addr = addr;
		this.addr_detail = addr_detail;
		this.social_login = social_login;
		this.email_verify = email_verify;
		this.join_date = join_date;
		this.isAdmin = isAdmin;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_pw() {
		return user_pw;
	}

	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPost_no() {
		return post_no;
	}

	public void setPost_no(String post_no) {
		this.post_no = post_no;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getAddr_detail() {
		return addr_detail;
	}

	public void setAddr_detail(String addr_detail) {
		this.addr_detail = addr_detail;
	}

	public String getSocial_login() {
		return social_login;
	}

	public void setSocial_login(String social_login) {
		this.social_login = social_login;
	}

	public boolean isEmail_verify() {
		return email_verify;
	}

	public void setEmail_verify(boolean email_verify) {
		this.email_verify = email_verify;
	}

	public String getJoin_date() {
		return join_date;
	}

	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}

	public boolean isAdmin() {
		return isAdmin;
	}

	public void setAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

	@Override
	public String toString() {
		return "UserDTO [user_id=" + user_id + ", user_pw=" + user_pw + ", username=" + username + ", nickname="
				+ nickname + ", phone=" + phone + ", email=" + email + ", post_no=" + post_no + ", addr=" + addr
				+ ", addr_detail=" + addr_detail + ", social_login=" + social_login + ", email_verify=" + email_verify
				+ ", join_date=" + join_date + ", isAdmin=" + isAdmin + "]";
	}
	
	

}
