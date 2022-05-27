package com.aram.dto;

public class CartDTO {
	private String user_id;
	private String item_id;
	private int quantity;
	
	public CartDTO() {}

	public CartDTO(String user_id, String item_id, int quantity) {
		super();
		this.user_id = user_id;
		this.item_id = item_id;
		this.quantity = quantity;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getItem_id() {
		return item_id;
	}

	public void setItem_id(String item_id) {
		this.item_id = item_id;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	@Override
	public String toString() {
		return "CartDTO [user_id=" + user_id + ", item_id=" + item_id + ", quantity=" + quantity + "]";
	}

}
