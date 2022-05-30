package com.aram.dto;

public class ItemimgDTO {
	private int img_no;
	private String img_title;
	private String img_type;
	private String ori_name;
	private String sys_name;
	
	public ItemimgDTO() {}

	public ItemimgDTO(int img_no, String img_title, String img_type, String ori_name, String sys_name) {
		super();
		this.img_no = img_no;
		this.img_title = img_title;
		this.img_type = img_type;
		this.ori_name = ori_name;
		this.sys_name = sys_name;
	}

	public int getImg_no() {
		return img_no;
	}

	public void setImg_no(int img_no) {
		this.img_no = img_no;
	}

	public String getImg_title() {
		return img_title;
	}

	public void setImg_title(String img_title) {
		this.img_title = img_title;
	}

	public String getImg_type() {
		return img_type;
	}

	public void setImg_type(String img_type) {
		this.img_type = img_type;
	}

	public String getOri_name() {
		return ori_name;
	}

	public void setOri_name(String ori_name) {
		this.ori_name = ori_name;
	}

	public String getSys_name() {
		return sys_name;
	}

	public void setSys_name(String sys_name) {
		this.sys_name = sys_name;
	}

	@Override
	public String toString() {
		return "ItemimgDTO [img_no=" + img_no + ", img_title=" + img_title + ", img_type=" + img_type + ", ori_name="
				+ ori_name + ", sys_name=" + sys_name + "]";
	}
	
}
