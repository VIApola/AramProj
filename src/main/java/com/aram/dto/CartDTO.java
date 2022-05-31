package com.aram.dto;

public class CartDTO {
	private String user_id;
	private int item_no;
	private int quantity;
	
	public CartDTO() {}

	public CartDTO(String user_id, int item_no, int quantity) {
		super();
		this.user_id = user_id;
		this.item_no = item_no;
		this.quantity = quantity;
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

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	@Override
	public String toString() {
		return "CartDTO [user_id=" + user_id + ", item_id=" + item_no + ", quantity=" + quantity + "]";
	}

}
