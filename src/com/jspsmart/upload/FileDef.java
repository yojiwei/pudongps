package com.jspsmart.upload;
import java.util.*;
import com.beyondbit.web.publishinfo.Messages;
//È¥µô¿Õ¸ñ
public class FileDef {
	private String fileExt;
	public boolean judgeFileExt(Object o){
		SmartUpload f = (SmartUpload) o;
		int count = f.getFiles().getCount();
		List a = Arrays.asList(Messages.getString("allowFileExt").split(","));
		if(a!=null){
			for(int i=0; i<count; i++){
				fileExt = f.getFiles().getFile(i).getFileExt();
				System.out.println("--------------------------------------------"+fileExt);
				Iterator it = a.iterator();
				while(it.hasNext()){
					if(fileExt.toLowerCase().equals(it.next())){
						return true;
					}
				}
			}
		}
		return false;
	}
}
