package com.platform.user;

import java.sql.*;
import com.component.database.*;
import javax.servlet.http.*;
import com.util.*;

public class CDeptInfo extends CDataImpl
{
   private String TABLENAME = "tb_deptinfo"; //表名称
   private String PRIMARYFIELDNAME = "dt_id";
   private String PARENTIDNAME = "dt_parent_id";
   private StringBuffer _strBuf; //递归字符串
   private String _tagName; //选择框的名字
   private long _selectedId; //被选中的ID

   public CDeptInfo()
   {
     this(null);
   }

   /**
   @roseuid 3C04CE3C0057
   */
   public CDeptInfo(CDataCn dCn)
   {
     super(dCn);
     setTableName(this.TABLENAME);
     setPrimaryFieldName(this.PRIMARYFIELDNAME);
   }

   /**
   * Method:setSequence(HttpServletRequest request)
   * Description: 保存排序
   * @param request
   * @return boolean
   @roseuid 3C0DE8EF037C
   */
   public boolean setSequence(HttpServletRequest request)
   {
     return setSequence("dept","dt_sequence",request);
   }

   /**
   @roseuid 3C0DE91F0000
   */
   public boolean hasSubDept(long id)
   {
     return hasSubObject("dt_parent_id",id);
   }

   /**
   @roseuid 3C0DE938011E
   */
   public boolean isSubDept()
   {
     return true;
   }

   /**
    * method:getDeptList(String selectedValue) <br>
    * Description:获得部门列表
    * @param selectedValue
    * @return
    */
   public String getDeptList(String selectedValue)
   {
     /*如果传入的参数是空，返回空字符串*/
     /*
     if(selectedValue==null || selectedValue.equals(""))
     {
       return "";
     }
     */

     setSelectedId(selectedValue);
     /*默认选择框的名字是dt_id*/
     if(_tagName==null || _tagName.equals(""))
     {
       _tagName = "dt_id";
     }

     _strBuf = new StringBuffer("<select class=select-a name='" + _tagName + "' size='1' onchange=javascript:onChange()>");

     listDept(1,1,false);

     _strBuf.append("</select>");
     return _strBuf.toString();
   }

   public String getDeptList(String selectedValue,String tagName)
   {
     setTagName(tagName);
     return getDeptList(selectedValue);
   }

   /**
    * Method:setSelectedId(String selectedValue)
    * Description:设置当前选中的部门ID
    * @param selectedValue
    */
   public void setSelectedId(String selectedValue)
   {
     _selectedId = Long.parseLong(CTools.dealNumber(selectedValue));
   }

   public void setTagName(String tagName)
   {
     _tagName = tagName;
   }


   public void listDept(long id, int level, boolean isParent)
   {
     try
     {
       Statement rStmt = null;
       ResultSet rRs = null;
       String sSql;
       rStmt = cn.createStatement();

       /*
       判断是否从parent中选出记录
       */
       if(isParent)
       {
         sSql = "select dt_id,dt_name from "  + TABLENAME + " where " + PRIMARYFIELDNAME + " = " + Long.toString(id);
       }
       else
       {
         sSql = "select dt_id,dt_name from " + TABLENAME + " where " + PARENTIDNAME + " = " + Long.toString(id);
       }

       rRs = rStmt.executeQuery(sSql);
       while(rRs.next())
       {
           long curId = rRs.getLong(PRIMARYFIELDNAME);
           String sId = "";
           String selected;
           StringBuffer space = new StringBuffer("");
           String dirName = rRs.getString("dt_name");

           sId   = sId.valueOf(curId);
           for (int i=1;i<level;i++){
             space.append("&nbsp;&nbsp;&nbsp;&nbsp;");
           }

           if(curId == _selectedId)
           {
               selected = " selected";
           }
           else
           {
               selected = "";
           }

           _strBuf.append("<option value='"+sId+"'"+selected+">"+space.toString()+rRs.getString("dt_name")+"</option>");

           space = null;

           listDept(curId , level+1,isParent);

       }
       rRs.close();
       rStmt.close() ;

     }
     catch(Exception ex)
     {
       raise(ex,"递归列出部门的时候出错","listDept(long id, int level, boolean isParent)");
     }
   }

   public static void main(String[] args) {
        CDeptInfo i = new CDeptInfo();
        System.out.println(i.getDeptList("2"));
        //System.out.println(tree.getTreeXML(tree.DEFAULT,0,-1));
        //System.out.println(tree.getDirIds("0",false));
    }
}
