/*
 * Copyright (c)Beyondbit Internet Software Co., Ltd. 
 * 
 * This software is the confidential and proprietary information of 
 * Beyondbit Internet Software  Co., Ltd. ("Confidential Information").
 * You shall not disclose such Confidential Information and shall use it 
 * only in accordance with the terms of the license agreement you 
 * entered into with Beyondbit Internet Software Co., Ltd.
 */
package com.service.web;

import com.util.CTools;

/**
 * @author chenjq
 * Date 2006-7-21 <br>
 * Description: <br>
 * 
 */
public class TreeTools {
    
    public static String dealLinkhref(String link,String param) {
        return link=link.indexOf("?")!=-1?link + "&" + param:link + "?" + param;
    }
    
    public static String replaceTag(String value,String [] tagArr,String [] valArr){
        String repValue = value;
        
        for(int i=0;i<tagArr.length;i++){
            repValue = CTools.replace(repValue,tagArr[i],valArr[i]);
        }       
        return repValue;    
    }
    
    public static String repFont(String name,String dir) {
        String dirs = Messages.getString("reddir");                      
        if(dir!=null && !dir.trim().equals("") && dirs.indexOf( "," + dir + ",")!=-1) {
            return "<font color='#FF0000'>" + name + "</font>";
        } else {
            return name;
        }
    }

}
