package com.aram.utils;

import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

public class Pagination {

	private BasicDataSource bds;

	public Pagination() {
		try {
			Context iCtx = new InitialContext();
			Context envCtx = (Context) iCtx.lookup("java:comp/env");
			bds = (BasicDataSource) envCtx.lookup("jdbc/bds");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 페이징 - getPageNavi 메서드
	public HashMap<String, Object> getPageNavi(int totalCnt, int curPage, int recordPerPage) throws Exception {

		// totalCnt : 전체 게시글 갯수
		int recordCntPerPage = recordPerPage; // 한페이지에 띠울 게시글수
		int naviCntPerPage = 5; // 페이지 네비바의 개수
		int pageTotalCnt = 0; // 총 몇페이지가 나올지

		// 총 페이지 개수를 구하는 연산
		if (totalCnt % recordCntPerPage > 0) {
			pageTotalCnt = totalCnt / recordCntPerPage + 1;
		} else {
			pageTotalCnt = totalCnt / recordCntPerPage;
		}
		
		// 현재 페이지의 범위 제한하기
		if (curPage < 1) {
			curPage = 1;
		} else if (curPage > pageTotalCnt) {
			curPage = pageTotalCnt;
		}
		
		// navi의 시작점과 끝 지점을 잡기
		int startNavi = ((curPage - 1) / naviCntPerPage) * naviCntPerPage + 1;
		int endNavi = startNavi + naviCntPerPage - 1;

		System.out.println(pageTotalCnt);
		System.out.println(endNavi);
		// 네비바의 이전페이지 다음페이지 버튼 생성 여부
		boolean needPrev = true;
		boolean needNext = true;

		if (startNavi == 1) {
			needPrev = false;
		}
		
		// endNavi가 전체 페이지를 넘지 않게
		if (pageTotalCnt < endNavi) {
			endNavi = pageTotalCnt;
		}
		
		if (endNavi == pageTotalCnt) {
			needNext = false;
		}
		
		// HashMap을 이용해 구현한 값을 전달해서 반환
		HashMap<String, Object> map = new HashMap<>();

		map.put("curPage", curPage);
		map.put("startNavi", startNavi);
		map.put("endNavi", endNavi);
		map.put("needPrev", needPrev);
		map.put("needNext", needNext);

		return map;

	}
}
