
package com.component.treeview;

import com.component.treeview.*;

public class CMetaStructure extends CStructure
{

  private static final String DIRNAME = "tb_datatdictionary";
  private static final String FILENAME = "tb_datavalue";
  private static final String IDNAME = "dd_id";
  private static final String TITLENAME = "dd_name";
  private static final String PARENTIDNAME = "dd_parentid";
  private static final String SORTNAME = "dd_sequence";
  private static final String FLAGNAME = "dd_active_flag";
  private static final String CODENAME = "dd_code";

   public CMetaStructure()
   {
   }

   protected void setStructureInfo(CTree tree)
   {
     tree.tableInfo.dirName = this.DIRNAME ;
     tree.tableInfo.fileName = this.FILENAME;
     tree.fieldInfo.idName = this.IDNAME;
     tree.fieldInfo.parentIdName = this.PARENTIDNAME;
     tree.fieldInfo.titleName = this.TITLENAME;
     tree.fieldInfo.sortName = this.SORTNAME;
     tree.fieldInfo.flagName = this.FLAGNAME;
     tree.fieldInfo.codeName = this.CODENAME;
     setGenStructureInfo(tree);
   }
}
