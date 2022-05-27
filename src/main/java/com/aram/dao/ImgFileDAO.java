package com.aram.dao;

import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import com.aram.dto.ItemimgDTO;

public class ImgFileDAO {
	private BasicDataSource bds;
	
	public ImgFileDAO() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context)iCtx.lookup("java:comp/env");
			bds = (BasicDataSource)envCtx.lookup("jdbc/bds");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<ItemimgDTO> selectAll() throws Exception{
		String sql ="select * from tbl_item_img";
	}
	

}
