package com.aram.utils;

public class SearchQuery {
	
	// 카테고리 페이지에서 쓰는 함수
	public static String findQuery(String sortBy, String category_id) {
		// sortBy - 정렬 기준 (이름순, 낮은가격(asc), 높은가격(desc))
		String sql = "select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no where category_id='" + category_id + "'";
		
		// 정렬 기준에 따라 조건 추가
		if (sortBy.equals("name")) { // 이름순
			sql += " order by item_name";
		}
		if (sortBy.equals("price_asc")) { // 낮은 가격순(asc)
			sql += " order by price";
		}
		if (sortBy.equals("price_desc")) { // 높은 가격순(desc)
			sql += " order by price desc";
		}
		
		return sql;
	}
	
	// 검색 페이지에서 쓰는 함수
	public static String findQuery(String sortBy, String keyword, int minPrice, int maxPrice) {
		// sortBy - 정렬 기준 (이름순, 낮은가격(asc), 높은가격(desc))
		// keyword - 키워드 검색이 존재할 때
		// minPrice,maxPrice - 최소가격, 최대가격
		
		String sql = "select * from tbl_items a join tbl_item_img b on a.img_no=b.img_no";
		
		// 제품 키워드 입력 유무에 따라 조건 추가
		if (!keyword.equals("")) {
			sql += " where item_name like '%'||'" + keyword + "'||'%'";
			// 가격 조건도 있으면 같이 추가
			if (minPrice != 0 && maxPrice != 0) {
				sql += "and price between " + minPrice + " and " + maxPrice;
			}
		}
		
		// 최소가격, 최대가격에 따라 조건추가
		// 최소가격만 적었을때
		// 최대가격만 적었을때
		
		// 최소가격, 최대가격 둘다 적었을 때 + 키워드
		if (minPrice != 0 && maxPrice != 0 && keyword.equals("")) {
			sql += " where price between " + minPrice + " and " + maxPrice;
		}
		
		// 정렬 기준에 따라 조건 추가
		if (sortBy.equals("name")) { // 이름순
			sql += " order by item_name";
		}
		if (sortBy.equals("price_asc")) { // 낮은 가격순(asc)
			sql += " order by price";
		}
		if (sortBy.equals("price_desc")) { // 높은 가격순(desc)
			sql += " order by price desc";
		}
		
		return sql;
		
	}
	
	public static String findResultCount(String sortBy, String keyword, int minPrice, int maxPrice) {
		
		String sql = "select count(*) from tbl_items";
		
		// 제품 키워드 입력 유무에 따라 조건 추가
		if (!keyword.equals("")) {
			sql += " where item_name like '%'||'" + keyword + "'||'%'";
			// 가격 조건도 있으면 같이 추가
			if (minPrice != 0 && maxPrice != 0) {
				sql += " and price between " + minPrice + " and " + maxPrice;
			}
		}
		
		// 가격대 입력에 따라 조건 추가
		// 최소가격, 최대가격 둘다 적었을 때 + 키워드
		if (minPrice != 0 && maxPrice != 0 && keyword.equals("")) {
			sql += " where price between " + minPrice + " and " + maxPrice;
		}
		
		// 정렬 기준에 따라 조건 추가
		if (sortBy.equals("name")) { // 이름순
			sql += " order by item_name";
		}
		if (sortBy.equals("price_asc")) { // 낮은 가격순(asc)
			sql += " order by price";
		}
		if (sortBy.equals("price_desc")) { // 높은 가격순(desc)
			sql += " order by price desc";
		}
		
		return sql;
	}
	
}
