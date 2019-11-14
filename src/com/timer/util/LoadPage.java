package com.timer.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class LoadPage {
	
	public StringBuffer load(String s_url) throws Exception{
		java.io.InputStream urlStream;
		String currentLineCode = "";
		StringBuffer strDestinationHtmlCode = new StringBuffer();
		URL url = new URL(s_url);
		HttpURLConnection connection = (HttpURLConnection)url.openConnection();
		connection.connect();
		urlStream = connection.getInputStream();
		BufferedReader reader = new BufferedReader(
				new InputStreamReader(urlStream));
		while ((currentLineCode = reader.readLine()) != null) {
			strDestinationHtmlCode.append(currentLineCode);
			strDestinationHtmlCode.append("\n");
		}
		connection.disconnect();
		reader.close();
		return strDestinationHtmlCode;
	}
	
	public static void main(String[] args){
		LoadPage pageloader = new LoadPage();
		try{
			System.out.println(pageloader.load("http://www.chinaren.com"));
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
}
