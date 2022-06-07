package com.aram.dto;

public class MypageReviewDTO {

	private int review_no;
	private String title;
	private String content;
	private String write_date;
	private int score;
	private String user_id;
	private int item_no;
	private int img_no;
	private String sys_name;
	private String item_name;
	
	
	
	public MypageReviewDTO() {}
	public MypageReviewDTO(int review_no, String title, String content, String write_date, int score, String user_id,
			int item_no, int img_no, String sys_name, String item_name) {
		super();
		this.review_no = review_no;
		this.title = title;
		this.content = content;
		this.write_date = write_date;
		this.score = score;
		this.user_id = user_id;
		this.item_no = item_no;
		this.img_no = img_no;
		this.sys_name = sys_name;
		this.item_name = item_name;
	}
	public int getReview_no() {
		return review_no;
	}
	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getItem_no() {
		return item_no;
	}
	public void setItem_no(int item_no) {
		this.item_no = item_no;
	}
	public int getImg_no() {
		return img_no;
	}
	public void setImg_no(int img_no) {
		this.img_no = img_no;
	}
	public String getSys_name() {
		return sys_name;
	}
	public void setSys_name(String sys_name) {
		this.sys_name = sys_name;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	
	@Override
	public String toString() {
		return "MypageReviewDTO [review_no=" + review_no + ", title=" + title + ", content=" + content + ", write_date="
				+ write_date + ", score=" + score + ", user_id=" + user_id + ", item_no=" + item_no + ", img_no="
				+ img_no + ", sys_name=" + sys_name + ", item_name=" + item_name + "]";
	}
	
	
}
