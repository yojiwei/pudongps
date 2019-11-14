
package com.platform.subject;

import com.component.treeview.*;
import com.component.database.*;

public class CTitleList extends CTreeList
{
  private static final String DIRNAME = "tb_title";
  private static final String FILENAME = " ";
  private static final String DEPTNAME = "tb_deptinfo";
  private static final String USERNAME = "tb_userinfo";
  private static final String ROLENAME = "tb_roleinfo";
  private static final String IDNAME = "ti_id";
  private static final String TITLENAME = "ti_name";
  private static final String PARENTIDNAME = "ti_upperid";
  private static final String SORTNAME = "ti_sequence";
  private static final String FLAGNAME = "ti_deleteflag";
  private static final String CODENAME = "ti_code";

   public CTitleList()
   {
     this(null);
   }

   /**
   @roseuid 3C099C1602FE
   */
   public CTitleList(CDataCn dCn)
   {
     super(dCn);
     tableInfo.dirName = this.DIRNAME ;
     tableInfo.fileName = this.FILENAME;
     tableInfo.deptName = this.DEPTNAME;
     tableInfo.userName = this.USERNAME;
     tableInfo.roleName = this.ROLENAME;
     fieldInfo.idName = this.IDNAME;
     fieldInfo.parentIdName = this.PARENTIDNAME;
     fieldInfo.titleName = this.TITLENAME;
     fieldInfo.sortName = this.SORTNAME;
     fieldInfo.flagName = this.FLAGNAME;
     fieldInfo.codeName = this.CODENAME ;
   }

   public static void main(String[] args) {
     //CTitleList jdo = new CTitleList();
     //String s = jdo.getListByCode("root","0");
     //String s = jdo.getListByCodeExceptLeaf("root","0");
     //System.out.print(s);

   }
}
