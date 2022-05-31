package com.aram.dto;

public class NoticeDTO {
	private int notice_no;
	private String user_id;
	private String title;
	private String author;
	private String write_date;
	private String content;
	private int board_views;

	public NoticeDTO() {}

	public NoticeDTO(int notice_no, String user_id, String title, String author, String write_date, String content,
			int board_views) {
		super();
		this.notice_no = notice_no;
		this.user_id = user_id;
		this.title = title;
		this.author = author;
		this.write_date = write_date;
		this.content = content;
		this.board_views = board_views;
	}

	public int getNotice_no() {
		return notice_no;
	}

	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getWrite_date() {
		return write_date;
	}

	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getBoard_views() {
		return board_views;
	}

	public void setBoard_views(int board_views) {
		this.board_views = board_views;
	}

	@Override
	public String toString() {
		return "NoticeDTO [notice_no=" + notice_no + ", user_id=" + user_id + ", title=" + title + ", author=" + author
				+ ", write_date=" + write_date + ", content=" + content + ", board_views=" + board_views + "]";
	}
	
}
