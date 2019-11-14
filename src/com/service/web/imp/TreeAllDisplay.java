/*
 * Copyright (c)Beyondbit Internet Software Co., Ltd. 
 * 
 * This software is the confidential and proprietary information of 
 * Beyondbit Internet Software  Co., Ltd. ("Confidential Information").
 * You shall not disclose such Confidential Information and shall use it 
 * only in accordance with the terms of the license agreement you 
 * entered into with Beyondbit Internet Software Co., Ltd.
 */
package com.service.web.imp;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.component.database.CDataCn;
import com.service.web.TreeWeb;
import com.service.web.Messages;
import com.service.web.Contain;
import com.service.web.TreeTools;
import com.util.CTools;

/**
 * @author chenjq
 * Date 2006-7-21 <br>
 * Description: <br>
 * 
 */
public class TreeAllDisplay extends TreeWeb {
    
    public TreeAllDisplay(String sjDir,CDataCn dCn,String baseUrl) {
        this.sjDir = sjDir;
        this.baseUrl = baseUrl;
        con = dCn.getConnection();  
    }
       
        
    public String createTree() {
        return createFirstLeftBar();
    }
    
    private String createFirstLeftBar(){
        String returnValue = "";
        
        String value = Messages.getString(Contain.ROOTHTML);        
        String [] tagArr = Messages.getString(Contain.ROOTLABLE).split(","); 
        String [] repArr = new String [tagArr.length];
        
        try {
            stmt  = con.createStatement();             
            rs = stmt.executeQuery(CTools.replace(Messages.getString(Contain.ROOTSQL),"$SQL_DIR",getSjDir()));
            while(rs.next()){
                String url = rs.getString("sj_url");
                String dir = rs.getString("sj_dir");
                dir=dir==null?"":dir;
                url=url==null?"":url;               
                repArr[0] = TreeTools.repFont(rs.getString("sj_name"),dir);
                //if(repArr[0].length()>6) repArr[0] = repArr[0].substring(0,5) + "..";
                repArr[2] = "fir-" + dir +"-";
                repArr[3] = createSecondLeftBar(dir,"-" + dir+"-");
                //repArr[4] = url.indexOf("http://")!=-1?"target='_blank'":"";
                repArr[4] = url.indexOf("http://")!=-1?"target='_blank' title='" + rs.getString("sj_name") + "'":"title='" + rs.getString("sj_name") + "'";
                if(repArr[3].equals("")&&!url.equals("")) repArr[1] = TreeTools.dealLinkhref(url,"sj_dir=" + rs.getString("sj_dir") + "&pardir=" + this.parDir); 
                else if(!repArr[3].equals("")) repArr[1] = "javascript:expandGrid('" + repArr[2] + "')";
                else repArr[1] = "#";
        
                returnValue += TreeTools.replaceTag(value,tagArr,repArr);
            }           
            return returnValue;
        } catch (SQLException e) {          
            e.printStackTrace();
            return "";
        }
    }
    
    
    public String createSecondLeftBar(String sjId,String objId){
        
        String returnValue = "";
        String value = Messages.getString(Contain.PARENTHTML);
        String [] tagArr = Messages.getString(Contain.PARENTLABLE).split(",");
        String [] repArr = new String [tagArr.length];
        try {
            Statement stmt1  = con.createStatement();           
            ResultSet rs1 = stmt1.executeQuery(CTools.replace(Messages.getString(Contain.PARENTSQL),Contain.SQLTARGET,sjId));
            
            int ii = 0;
            while(rs1.next()){
                ii++;
                String url = rs1.getString("sj_url");
                String dir = rs1.getString("sj_dir");
                dir=dir==null?"":dir;
                url=url==null?"":url;
                repArr[0] = rs1.getString("sj_name");
                if(repArr[0].length()>6) repArr[0] = repArr[0].substring(0,6) + "..";
                	repArr[0] = TreeTools.repFont(repArr[0],dir);
                repArr[2] = "sec" + objId + dir + "-";
                repArr[3] = createThirdLeftBar(dir,objId + dir + "-");
                repArr[4] = url.indexOf("http://")!=-1?"target='_blank'":"45345";
                if(repArr[3].equals("")&&!url.equals("")) repArr[1] = TreeTools.dealLinkhref(url,"sj_dir=" + rs1.getString("sj_dir") + "&pardir=" + this.parDir); 
                else if(!repArr[3].equals("")) repArr[1] = "javascript:expandSecGrid('" + repArr[2] + "')";
                else repArr[1] = "#";
                
                //for hh
                repArr[5] = "title='" + rs1.getString("sj_name") + "'";
                //repArr[4] = "sec" + objId + dir + "-";
                
                returnValue += TreeTools.replaceTag(value,tagArr,repArr);             
            }
            if(ii!=0)
                return returnValue;
            else
                return "";
            
            
        } catch (SQLException e) {          
            e.printStackTrace();
            return "";
        }
        
    }
    
   private String createThirdLeftBar(String sjId,String objId){      
        String sunValue = "";
        String value = Messages.getString(Contain.SONHTML);
        String [] tagArr = Messages.getString(Contain.SONLABLE).split(",");
        String [] repArr = new String [tagArr.length];
        try {
            Statement stmt2  = con.createStatement();
            
            
            ResultSet rs2 = stmt2.executeQuery(CTools.replace(Messages.getString(Contain.SONSQL),Contain.SQLTARGET,sjId));
            //System.out.println(CTools.replace(Messages.getString(Contain.SONSQL),Contain.SQLTARGET,sjId));
            int jj=0;
            while(rs2.next()){
                repArr[0] = rs2.getString("sj_name");
                if(repArr[0].length()>6) repArr[0] = repArr[0].substring(0,6) + "..";
                String url = rs2.getString("sj_url");
                String dir = rs2.getString("sj_dir");
                dir=dir==null?"":dir;
                url=url==null?"":url;
                repArr[0] = TreeTools.repFont(repArr[0],dir);
                repArr[1] = url.equals("")?"#":TreeTools.dealLinkhref(url,"sj_dir=" + rs2.getString("sj_dir") + "&pardir=" + this.parDir);
                repArr[2] = "thd" + objId + dir + "-";
                //repArr[3] = url.indexOf("http://")!=-1?"target='_blank'":"45345";
                repArr[3] = url.indexOf("http://")!=-1?"target='_blank' title='" + rs2.getString("sj_name") + "'":"title='" + rs2.getString("sj_name") + "'";
                sunValue += TreeTools.replaceTag(value,tagArr,repArr);
                jj++;
            }
            if(jj!=0)
                return sunValue;
            else
                return "";
            
        } catch (SQLException e) {          
            e.printStackTrace();
            return "";
            
        }
        // 
    }
    
    public static void main(String [] args) {
      CDataCn dCn = new CDataCn();
      TreeWeb barObj = new TreeAllDisplay("govOpen",dCn,"index.jsp");
      System.out.print("ss " +  barObj.createTree() + "ss");
      dCn.closeCn();
      
      //String [] arr = new String [] {"1","2"};
    }
    
    

}
