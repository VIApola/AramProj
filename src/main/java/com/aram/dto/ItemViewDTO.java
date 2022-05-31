package com.aram.dto;

public class ItemViewDTO {
	private int item_no;
	private String item_name;
	private int price;
	private String item_comment;
	private String item_regdate;
	private int item_stock;
	private String category_id;
	
	private ItemimgDTO itemImgDTO;
	
	public ItemViewDTO() {}

	public ItemViewDTO(int item_no, String item_name, int price, String item_comment, String item_regdate,
			int item_stock, String category_id, ItemimgDTO itemImgDTO) {
		super();
		this.item_no = item_no;
		this.item_name = item_name;
		this.price = price;
		this.item_comment = item_comment;
		this.item_regdate = item_regdate;
		this.item_stock = item_stock;
		this.category_id = category_id;
		this.itemImgDTO = itemImgDTO;
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

	public String getItem_comment() {
		return item_comment;
	}

	public void setItem_comment(String item_comment) {
		this.item_comment = item_comment;
	}

	public String getItem_regdate() {
		return item_regdate;
	}

	public void setItem_regdate(String item_regdate) {
		this.item_regdate = item_regdate;
	}

	public int getItem_stock() {
		return item_stock;
	}

	public void setItem_stock(int item_stock) {
		this.item_stock = item_stock;
	}

	public String getCategory_id() {
		return category_id;
	}

	public void setCategory_id(String category_id) {
		this.category_id = category_id;
	}

	public ItemimgDTO getItemImgDTO() {
		return itemImgDTO;
	}

	public void setItemImgDTO(ItemimgDTO itemImgDTO) {
		this.itemImgDTO = itemImgDTO;
	}

	@Override
	public String toString() {
		return "ItemViewDTO [item_no=" + item_no + ", item_name=" + item_name + ", price=" + price + ", item_comment="
				+ item_comment + ", item_regdate=" + item_regdate + ", item_stock=" + item_stock + ", category_id="
				+ category_id + ", itemImgDTO=" + itemImgDTO + "]";
	}

}
