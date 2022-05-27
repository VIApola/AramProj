package com.aram.dto;

public class OrderDTO {
	private int order_no;
	private String user_id;
	private String order_name;
	private String order_date;
	private int quantity;
	private String order_amount; 
	private String delivery_addr;
	private String delivery_name;
	private String order_msg;
	private String delivery_msg;
	
	public OrderDTO() {}

	public OrderDTO(int order_no, String user_id, String order_name, String order_date, int quantity,
			String order_amount, String delivery_addr, String delivery_name, String order_msg, String delivery_msg) {
		super();
		this.order_no = order_no;
		this.user_id = user_id;
		this.order_name = order_name;
		this.order_date = order_date;
		this.quantity = quantity;
		this.order_amount = order_amount;
		this.delivery_addr = delivery_addr;
		this.delivery_name = delivery_name;
		this.order_msg = order_msg;
		this.delivery_msg = delivery_msg;
	}

	public int getOrder_no() {
		return order_no;
	}

	public void setOrder_no(int order_no) {
		this.order_no = order_no;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getOrder_name() {
		return order_name;
	}

	public void setOrder_name(String order_name) {
		this.order_name = order_name;
	}

	public String getOrder_date() {
		return order_date;
	}

	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getOrder_amount() {
		return order_amount;
	}

	public void setOrder_amount(String order_amount) {
		this.order_amount = order_amount;
	}

	public String getDelivery_addr() {
		return delivery_addr;
	}

	public void setDelivery_addr(String delivery_addr) {
		this.delivery_addr = delivery_addr;
	}

	public String getDelivery_name() {
		return delivery_name;
	}

	public void setDelivery_name(String delivery_name) {
		this.delivery_name = delivery_name;
	}

	public String getOrder_msg() {
		return order_msg;
	}

	public void setOrder_msg(String order_msg) {
		this.order_msg = order_msg;
	}

	public String getDelivery_msg() {
		return delivery_msg;
	}

	public void setDelivery_msg(String delivery_msg) {
		this.delivery_msg = delivery_msg;
	}

	@Override
	public String toString() {
		return "OrderDTO [order_no=" + order_no + ", user_id=" + user_id + ", order_name=" + order_name
				+ ", order_date=" + order_date + ", quantity=" + quantity + ", order_amount=" + order_amount
				+ ", delivery_addr=" + delivery_addr + ", delivery_name=" + delivery_name + ", order_msg=" + order_msg
				+ ", delivery_msg=" + delivery_msg + "]";
	}
	
}
