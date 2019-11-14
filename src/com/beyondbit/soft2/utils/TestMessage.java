/*
 * Created on 2004-10-25
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.beyondbit.soft2.utils;

import com.component.database.CDataCn;

/**
 * @author along
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class TestMessage {

	/**
	 * 
	 */
	public TestMessage() {
		super();
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		CMessage message = new CMessage();
		message.setMs_receivername("");
		
		/**
		 * ...
		 */
		
		CDataCn dCn = new CDataCn();
		CMessageProxy proxy = new CMessageProxy(dCn);
		proxy.addMessage(message);
		
	}
}
