package com.app.event;

import java.sql.Connection;


public interface AppEvent {
		
	public int getCount();
	
	public String createInformation(String dtId,Connection con) throws Exception;
	
	

}
