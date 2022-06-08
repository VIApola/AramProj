package com.aram.utils;

import java.util.Random;

public class RandomNumberGenerator {
	public static String randomNumGenerator() {
		Random rand = new Random();
		
		int createNum = 0; // 1자리 난수
		String randNum = ""; // 1자리 난수 -> 문자로 형변환
		String resultNum = ""; // 결과 난수
		int letter = 5; // 자릿수
		
		for (int i = 0; i < letter; i++) {
			createNum = rand.nextInt(9); // 0-9 까지의 수 중에서 난수 생성
			randNum = Integer.toString(createNum); // 생성된 난수를 문자로 변환
			resultNum += randNum; // 생성된 난수 문자열을 수만큼 붙임
		}
		System.out.println(resultNum);
		return resultNum;
	}
}
