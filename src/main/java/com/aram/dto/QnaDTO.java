package com.aram.dto;

public class QnaDTO {
	private int qna_no;
	private String user_id;
	private String title;
	private String content;
	private String write_date;
	private boolean answer_yn;
	private String answer;
	private String answer_date;
	
	public QnaDTO() {}

	public QnaDTO(int qna_no, String user_id, String title, String content, String write_date, boolean answer_yn,
			String answer, String answer_date) {
		super();
		this.qna_no = qna_no;
		this.user_id = user_id;
		this.title = title;
		this.content = content;
		this.write_date = write_date;
		this.answer_yn = answer_yn;
		this.answer = answer;
		this.answer_date = answer_date;
	}

	public int getQna_no() {
		return qna_no;
	}

	public void setQna_no(int qna_no) {
		this.qna_no = qna_no;
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

	public boolean isAnswer_yn() {
		return answer_yn;
	}

	public void setAnswer_yn(boolean answer_yn) {
		this.answer_yn = answer_yn;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getAnswer_date() {
		return answer_date;
	}

	public void setAnswer_date(String answer_date) {
		this.answer_date = answer_date;
	}

	@Override
	public String toString() {
		return "QnaDTO [qna_no=" + qna_no + ", user_id=" + user_id + ", title=" + title + ", content=" + content
				+ ", write_date=" + write_date + ", answer_yn=" + answer_yn + ", answer=" + answer + ", answer_date="
				+ answer_date + "]";
	}
	
}
