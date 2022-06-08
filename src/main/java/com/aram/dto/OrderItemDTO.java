package com.aram.dto;

public class OrderItemDTO {
	private String order_no;
	private int item_no;
	private String item_name;
	private int price;
	private int quantity;

	public OrderItemDTO() {}

	public OrderItemDTO(String order_no, int item_no, String item_name, int price, int quantity) {
		super();
		this.order_no = order_no;
		this.item_no = item_no;
		this.item_name = item_name;
		this.price = price;
		this.quantity = quantity;
	}

	public String getOrder_no() {
		return order_no;
	}

	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}

	public int getItem_no() {
		return item_no;
	}

	public void setItem_no(int item_no) {
		this.item_no = item_no;
	}

	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	@Override
	public String toString() {
		return "OrderItem [order_no=" + order_no + ", item_no=" + item_no + ", item_name=" + item_name + ", price="
				+ price + ", quantity=" + quantity + "]";
	}
	
}
