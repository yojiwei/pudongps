package com.website;

/**
 * <p>Title: oa</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: popteach</p>
 * @author not attributable
 * @version 1.0
 */
import com.component.database.*;
import java.sql.*;
import com.util.*;

public class NavigateBarGov  extends CDataControl {
    String _URL="";
 String _sql="";
 String _ti_id="";
 String _ti_name="";
 String _ti_upperid="";
 String _ti_code="";
 String _ti_url="";

   public String getURL(int ti_id)
   {
     return getURL(ti_id,true);
   }

   public String getURL(int ti_id,boolean isLast)
   {
     getSubject(ti_id,isLast);
     return _URL;
   }

   private String getSubject(int ti_id,boolean isLast)
   {

     ResultSet rs = null;
     Statement stmt = null;

     if (ti_id>=0){
       try{
         stmt = cn.createStatement();
         _sql="select ti_id,ti_upperid,ti_name,ti_code,ti_url from tb_title where ti_id=" + ti_id;
         rs = stmt.executeQuery(_sql);
         if (rs.next()){
           _ti_id=rs.getString("ti_id");
           _ti_name =rs.getString("ti_name");
           _ti_upperid  =rs.getString("ti_upperid");
           _ti_code  =rs.getString("ti_code");
           _ti_url  =CTools.dealNull(rs.getString("ti_url"));
           rs.close();
           stmt.close();
         }else{
           rs.close();
           stmt.close();
         }
       }
       catch(Exception e){
         System.out.println("Error! While getting subject list! --by honeyday.");
       }
       if (_ti_id.equals("0"))
       {
           /*
         if (!isLast)
           _URL="<A href=/website/govopen/GovOpenColumn.jsp>政府信息公开</A>"+_URL;
         else
           _URL="政府信息公开"+_URL;
           */
          _URL = _URL.substring(2);
         return _ti_id;
       }
       else
       {
         String _sURL="";

           if (!isLast)
           {
             if (!_ti_url.equals(""))
             {
               _sURL+="<a href=";
               _sURL+=_ti_url;
               if(_ti_url.indexOf("?") > 0)
               {
                 _sURL = _sURL + "&tiId=" + _ti_id + "&tiName=" + _ti_name + "&tiCode=" + _ti_code;
               }
               else
               {
                 _sURL = _sURL + "?tiId=" + _ti_id + "&tiName=" + _ti_name + "&tiCode=" + _ti_code;
               }
               _sURL+=">";
             }
           }
           _sURL+=_ti_name;
           if (!isLast && !_ti_url.equals(""))
             _sURL+="</a> ";
           _URL=" > "+_sURL+_URL;

         return getSubject(Integer.parseInt(_ti_upperid),false);
       }
     }
     return "0";
   }

   public static void main(String[] args) {
    NavigateBarGov navigateBar1 = new NavigateBarGov();
    //SubjectDetail sd= new SubjectDetail();

    //while (sd!=null)
    //{
    System.out.println(navigateBar1.getURL(31,true));
    //System.out.println(sd.sj_name+sd.sj_parentid);

    //}
  }

}