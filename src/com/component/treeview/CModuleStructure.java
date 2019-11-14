
package com.component.treeview;

import com.component.treeview.*;

public class CModuleStructure extends CStructure
{
   private static final String DIRNAME = "tb_function";
   private static final String FILENAME = " ";
   private static final String IDNAME = "ft_id";
   private static final String TITLENAME = "ft_name";
   private static final String PARENTIDNAME = "ft_parent_id";
   private static final String SORTNAME = "ft_sequence";
   private static final String FLAGNAME = "ft_active_flag";

   public CModuleStructure()
   {
   }

   /**
   @roseuid 3C0D95CC02E2
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
     //tree.fieldInfo.codeName = this.CODENAME;
     setGenStructureInfo(tree);
   }
}
