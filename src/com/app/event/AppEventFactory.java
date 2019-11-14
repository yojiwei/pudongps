package com.app.event;

public class AppEventFactory {
	
	
	
	public static AppEvent getInstance(String className){
		AppEvent eventObj = null;
		try {
			eventObj = (AppEvent)Class.forName(className).newInstance();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return eventObj;
	}

}
