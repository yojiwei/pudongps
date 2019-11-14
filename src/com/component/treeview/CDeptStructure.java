package com.component.treeview;

import com.component.treeview.CStructure;
import com.component.treeview.CTree;
import java.util.*;

public class CDeptStructure extends CStructure
{
  private static final String DIRNAME = "tb_deptinfo";
  private static final String FILENAME = "tb_userinfo";
  private static final String IDNAME = "dt_id";
  private static final String TITLENAME = "dt_name";
  private static final String PARENTIDNAME = "dt_parent_id";
  private static final String SORTNAME = "dt_sequence";
  private static final String FLAGNAME = "dt_active_flag";
  private static final String FILEIDNAME = "ui_id";
  private static final String FILETITLENAME = "ui_name";
  private static final String FILESORTNAME = "ui_sequence";
  private static final String FILEFLAGNAME = "ui_active_flag";
  private static final String FILEDIRNAME = "dt_id";
  private static final String FILETYPENAME = "ui_sex";


   public CDeptStructure()
   {
   }

   /**
   @roseuid 3C0DD36C02E7
   */
   protected void setStructureInfo(CTree tree)
   {
     tree.tableInfo.dirName = this.DIRNAME ;
     tree.tableInfo.fileName = this.FILENAME;
     tree.fieldInfo.idName = this.IDNAME;
     tree.fieldInfo.parentIdName = this.PARENTIDNAME;
     tree.fieldInfo.titleName = this.TITLENAME;
     tree.fieldInfo.sortName = this.SORTNAME;
     tree.fieldInfo.flagName = this.FLAGNAME;
     tree.fileFieldInfo.idName = this.FILEIDNAME ;
     tree.fileFieldInfo.titleName = this.FILETITLENAME;
     tree.fileFieldInfo.sortName = this.FILESORTNAME ;
     tree.fileFieldInfo.flagName = this.FILEFLAGNAME;
     tree.fileFieldInfo.dirIdName = this.FILEDIRNAME ;
     tree.fileFieldInfo.typeName = this.FILETYPENAME;


     setGenStructureInfo(tree);

     Hashtable fileType = new Hashtable();
     String a = new String("ÄÐ");
     String b = new String("Å®");
     fileType.put(a,"0");
     fileType.put(b,"1");
     tree.setFileType(fileType);
   }
}
