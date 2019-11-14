package com.util;

public class DwrTest {
	public String test = "";
	
	/**
	 * sayHello
	 */
	public String sayHello(String name){
		return "Hi,"+name;
	}
	
	public static void main(String args[]){
		DwrTest tt = new DwrTest();
		System.out.println(tt.sayHello("xiaowei"));
	}

}
