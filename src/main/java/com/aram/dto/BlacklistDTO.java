package com.aram.dto;

public class BlacklistDTO {
	private String user_id;
	private String black_date;
	private String black_detail;
	
	public BlacklistDTO() {}

	public BlacklistDTO(String user_id, String black_date, String black_detail) {
		super();
		this.user_id = user_id;
		this.black_date = black_date;
		this.black_detail = black_detail;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getBlack_date() {
		return black_date;
	}

	public void setBlack_date(String black_date) {
		this.black_date = black_date;
	}

	public String getBlack_detail() {
		return black_detail;
	}

	public void setBlack_detail(String black_detail) {
		this.black_detail = black_detail;
	}

	@Override
	public String toString() {
		return "BlacklistDTO [user_id=" + user_id + ", black_date=" + black_date + ", black_detail=" + black_detail
				+ "]";
	}

}
