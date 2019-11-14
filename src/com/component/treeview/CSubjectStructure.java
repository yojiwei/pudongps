
package com.component.treeview;

import com.component.treeview.*;

public class CSubjectStructure extends CStructure
{
  private static final String DIRNAME = "tb_subject";
  private static final String FILENAME = " ";
  private static final String IDNAME = "sj_id";
  private static final String TITLENAME = "sj_name";
  private static final String PARENTIDNAME = "sj_parentid";
  private static final String SORTNAME = "sj_sequence";
  private static final String CODENAME = "sj_dir";

   public CSubjectStructure()
   {
   }

   /**
   @roseuid 3E141A760362
   */
   protected void setStructureInfo(CTree tree)
   {
     tree.tableInfo.dirName = this.DIRNAME ;
     tree.tableInfo.fileName = this.FILENAME;
     tree.fieldInfo.idName = this.IDNAME;
     tree.fieldInfo.parentIdName = this.PARENTIDNAME;
     tree.fieldInfo.titleName = this.TITLENAME;
     tree.fieldInfo.sortName = this.SORTNAME;
     tree.fieldInfo.codeName = this.CODENAME ;
     setGenStructureInfo(tree);
   }
}