
package com.component.treeview;

import com.component.treeview.*;

public class CTitleStructure extends CStructure
{
  private static final String DIRNAME = "tb_title";
  private static final String FILENAME = " ";
  private static final String IDNAME = "ti_id";
  private static final String TITLENAME = "ti_name";
  private static final String PARENTIDNAME = "ti_upperid";
  private static final String SORTNAME = "ti_sequence";
  private static final String CODENAME = "ti_code";

   public CTitleStructure()
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
