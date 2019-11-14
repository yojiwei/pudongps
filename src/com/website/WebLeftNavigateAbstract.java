package com.website;

import com.util.CTools;

public abstract class WebLeftNavigateAbstract {
	
	protected String dealLinkhref(String link,String param) {
		return link=link.indexOf("?")!=-1?link + "&" + param:link + "?" + param;
	}
	
	protected String replaceTag(String value,String [] tagArr,String [] valArr){
		String repValue = value;
		
		for(int i=0;i<tagArr.length;i++){
			repValue = CTools.replace(repValue,tagArr[i],valArr[i]);
		}		
		return repValue; 	
	}
	
	protected String repFont(String name,String dir) {
		String dirs = Messages.getString("reddir");                      
		if(dir!=null && !dir.trim().equals("") && dirs.indexOf( "," + dir + ",")!=-1) {
			return "<font color='#FF0000'>" + name + "</font>";
		} else {
			return name;
		}
	}
}
