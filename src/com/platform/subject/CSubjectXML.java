package com.platform.subject;

import com.component.treeview.*;
import com.component.database.*;

/**
 * <p>Title: oa</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: popteach</p>
 * @author tlboy
 * @version 1.0
 */

public class CSubjectXML extends CTreeXML {

  private String _sql = "";

  class structure extends CSubjectStructure
  {
    public structure(){
     setStructureInfo(CSubjectXML.this);
    }
  };

  public CSubjectXML() {
    this(null);
  }

  public CSubjectXML(CDataCn dCn) {
    super(dCn);
    new structure();
  }

  public void setAccessByMyID(long id)
  {
    _sql  = "SELECT " + fieldInfo.idName + " FROM " + tableInfo.moduleRoleName + " WHERE " ;
    _sql += accessFieldInfo.roleIdFieldName + " in ((select " + accessFieldInfo.roleIdFieldName + " from " + tableInfo.roleName + " where " + accessFieldInfo.roleUserIdsFieldName + " like '%," + id + ",%'))";
    _sql += " or (" + accessFieldInfo.roleIdFieldName + " in (select " + accessFieldInfo.roleIdFieldName + " from " + tableInfo.roleName + " where " + accessFieldInfo.roleTypeFieldName + " = 0))";
    this._filterSql = " and " + fieldInfo.idName + " in (" + _sql + ")";
  }

  public static void main(String[] args) {
    CSubjectXML m = new CSubjectXML();
    //m.setAccessByMyID(1);
    System.out.print(m.getXMLByParentID(0));
    m.dataCn.closeCn();
  }
}