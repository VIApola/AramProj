package com.aram.utils;

public class RunTest {
	public static void main(String[] args) {
		String keyword = "";
		int minPrice = 2300;
		int maxPrice = 50000;
		String orderBy = "price_asc";
		
		String sql = SearchQuery.findQuery(orderBy, keyword, minPrice, maxPrice);
		System.out.println(sql);
	}

}
