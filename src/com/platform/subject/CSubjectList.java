
package com.platform.subject;

import com.component.treeview.*;
import com.component.database.*;

public class CSubjectList extends CTreeList
{
  private static final String DIRNAME = "tb_subject";
  private static final String FILENAME = " ";
  private static final String DEPTNAME = "tb_deptinfo";
  private static final String USERNAME = "tb_userinfo";
  private static final String ROLENAME = "tb_roleinfo";
  private static final String IDNAME = "sj_id";
  private static final String TITLENAME = "sj_name";
  private static final String PARENTIDNAME = "sj_parentid";
  private static final String SORTNAME = "sj_sequence";
  private static final String FLAGNAME = "sj_counseling_flag";
  private static final String CODENAME = "sj_dir";

   public CSubjectList()
   {
     this(null);
   }

   /**
   @roseuid 3C099C1602FE
   */
   public CSubjectList(CDataCn dCn)
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
     CSubjectList jdo = new CSubjectList();
     String s = jdo.getListByCode("news","36");
     System.out.print(s);

   }
}
