package com.aram.utils;

import java.sql.Date;
import java.text.SimpleDateFormat;

public class StringDateFormatter {
	public static String getStringDate(Date date) { // oracle의 date 타입을 받아야함
		// oracle date타입의 데이터를 java의 String을 변환 -> SimpleDateFormat
		// 생성자의 인자값을 String으로 변환할때 어떤 형식으로 변환할 것인기 format
		// format의 대소문자 구분하기
		// oracle 월(mm/MM) 분(mi)
		// java 월(MM) 분(mm)
		// 1900년 02월 02일 00시 00분 00초
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		return sdf.format(date);
	}
}
