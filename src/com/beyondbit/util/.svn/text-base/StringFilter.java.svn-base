package com.beyondbit.util;

public class StringFilter {

	
	public static String filterSqlString(String keyword){
		if(keyword == null) return "";
		//keyword = keyword.replace('\\',' ');
		//keyword = keyword.replace('&',' ');
		keyword = keyword.replace('\'',' ');
		//keyword = keyword.replace('%',' ');
//		keyword = keyword.replace('#',' ');
//		keyword = keyword.replace('*',' ');
//		keyword = keyword.replace('?',' ');
		return keyword;
	}
	
	public static void main(String args[]){
		System.out.println("%".replaceAll("\\%","\\\\%"));
	}
	
}
