
package com.platform.module;

import com.component.treeview.*;
import com.component.database.*;

public class CModuleXML extends CTreeXML
{

  private String _sql = "";

  class structure extends CModuleStructure
  {
    public structure(){
      setStructureInfo(CModuleXML.this);
    }
   };

   public CModuleXML()
   {
     this(null);
   }

   /**
   @roseuid 3C031A7F0161
   */
   public CModuleXML(CDataCn dCn)
   {
     super(dCn);
     new structure();
   }

   /**
    * Method:setAccessByMyID(long id)
    * Description: 根据当前用户的ID，设置过滤后的模块树 <br> 程序通过设置CTree的_filterSql来实现
    * @param id
    * return void
   @roseuid 3E06F38601BB
   */
   public void setAccessByMyID(long id)
   {
      _sql  = "SELECT " + fieldInfo.idName + " FROM " + tableInfo.moduleRoleName + " WHERE " ;
      _sql += accessFieldInfo.roleIdFieldName + " in ((select " + accessFieldInfo.roleIdFieldName + " from " + tableInfo.roleName + " where " + accessFieldInfo.roleUserIdsFieldName + " like '%," + id + ",%'))";
      _sql += " or (" + accessFieldInfo.roleIdFieldName + " in (select " + accessFieldInfo.roleIdFieldName + " from " + tableInfo.roleName + " where " + accessFieldInfo.roleTypeFieldName + " = 0))";
      this._filterSql = " and " + fieldInfo.idName + " in (" + _sql + ")";
      
   }

   public static void main(String[] args) {
     CModuleXML m = new CModuleXML();
     m.setAccessByMyID(1);
     System.out.print(m.getXMLByParentID(0));
     m.dataCn.closeCn();
   }
}
