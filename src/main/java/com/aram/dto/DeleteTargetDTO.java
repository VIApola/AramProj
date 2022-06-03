package com.aram.dto;

public class DeleteTargetDTO {
	
	private int item_no;

	@Override
	public String toString() {
		return "DeleteTargetDTO [item_no=" + item_no;
	}
	public DeleteTargetDTO() {}
	public DeleteTargetDTO(int item_no) {
		super();
		this.item_no = item_no;
	}

	public int getItem_no() {
		return item_no;
	}

	public void setItem_no(int item_no) {
		this.item_no = item_no;
	}
	
}
