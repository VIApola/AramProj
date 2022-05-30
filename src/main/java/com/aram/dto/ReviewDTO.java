package com.aram.dto;

public class ReviewDTO {
	private int review_no;
	private String title;
	private String content;
	private String write_date;
	private int score;
	private String user_id;
	private int item_id;
	private int img_no;
	
	public ReviewDTO() {}

	public ReviewDTO(int review_no, String title, String content, String write_date, int score, String user_id,
			int item_id, int img_no) {
		super();
		this.review_no = review_no;
		this.title = title;
		this.content = content;
		this.write_date = write_date;
		this.score = score;
		this.user_id = user_id;
		this.item_id = item_id;
		this.img_no = img_no;
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

	public int getItem_id() {
		return item_id;
	}

	public void setItem_id(int item_id) {
		this.item_id = item_id;
	}

	public int getImg_no() {
		return img_no;
	}

	public void setImg_no(int img_no) {
		this.img_no = img_no;
	}

	@Override
	public String toString() {
		return "ReviewDTO [review_no=" + review_no + ", title=" + title + ", content=" + content + ", write_date="
				+ write_date + ", score=" + score + ", user_id=" + user_id + ", item_id=" + item_id + ", img_no="
				+ img_no + "]";
	}
	

}
