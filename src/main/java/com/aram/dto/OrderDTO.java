package com.aram.dto;

public class OrderDTO {
	private String order_no;
	private String user_id;
	private String order_name;
	private String order_email;
	private String order_phone;
	private String order_date;
	private int order_amount;
	private String order_state;
	private String delivery_name;
	private String delivery_phone;
	private String delivery_addr;
	private String order_msg;
	private String delivery_msg;
	
	public OrderDTO() {}

	public OrderDTO(String order_no, String user_id, String order_name, String order_email, String order_phone,
			String order_date, int order_amount, String order_state, String delivery_name, String delivery_phone,
			String delivery_addr, String order_msg, String delivery_msg) {
		super();
		this.order_no = order_no;
		this.user_id = user_id;
		this.order_name = order_name;
		this.order_email = order_email;
		this.order_phone = order_phone;
		this.order_date = order_date;
		this.order_amount = order_amount;
		this.order_state = order_state;
		this.delivery_name = delivery_name;
		this.delivery_phone = delivery_phone;
		this.delivery_addr = delivery_addr;
		this.order_msg = order_msg;
		this.delivery_msg = delivery_msg;
	}

	public String getOrder_no() {
		return order_no;
	}

	public void setOrder_no(String order_no) {
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

	public String getOrder_email() {
		return order_email;
	}

	public void setOrder_email(String order_email) {
		this.order_email = order_email;
	}

	public String getOrder_phone() {
		return order_phone;
	}

	public void setOrder_phone(String order_phone) {
		this.order_phone = order_phone;
	}

	public String getOrder_date() {
		return order_date;
	}

	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}

	public int getOrder_amount() {
		return order_amount;
	}

	public void setOrder_amount(int order_amount) {
		this.order_amount = order_amount;
	}

	public String getOrder_state() {
		return order_state;
	}

	public void setOrder_state(String order_state) {
		this.order_state = order_state;
	}

	public String getDelivery_name() {
		return delivery_name;
	}

	public void setDelivery_name(String delivery_name) {
		this.delivery_name = delivery_name;
	}

	public String getDelivery_phone() {
		return delivery_phone;
	}

	public void setDelivery_phone(String delivery_phone) {
		this.delivery_phone = delivery_phone;
	}

	public String getDelivery_addr() {
		return delivery_addr;
	}

	public void setDelivery_addr(String delivery_addr) {
		this.delivery_addr = delivery_addr;
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
				+ ", order_email=" + order_email + ", order_phone=" + order_phone + ", order_date=" + order_date
				+ ", order_amount=" + order_amount + ", order_state=" + order_state + ", delivery_name=" + delivery_name
				+ ", delivery_phone=" + delivery_phone + ", delivery_addr=" + delivery_addr + ", order_msg=" + order_msg
				+ ", delivery_msg=" + delivery_msg + "]";
	}
	
}
