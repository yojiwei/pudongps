package com.component.treeview;


public abstract class CStructure
{
   protected static String DEPTNAME = "tb_deptinfo";
   protected static String USERNAME = "tb_userinfo";
   protected static String ROLENAME = "tb_roleinfo";
   protected static String MODULEROLENAME = "tb_functionrole";

   /**
    * Method:setStructureInfo(CTree tree)
    * Description: set data structure for custom
    * @param tree
    * return void
   @roseuid 3C0D8BB0009C
   */
   protected abstract void setStructureInfo(CTree tree);

   /**
    * Method:setGenStructureInfo(CTree tree)
    * Description: set data structure for general
    * @param tree
    * return void
   @roseuid 3E141BBC03BB
   */
   protected void setGenStructureInfo(CTree tree)
   {
     tree.tableInfo.deptName = this.DEPTNAME;
     tree.tableInfo.userName = this.USERNAME;
     tree.tableInfo.roleName = this.ROLENAME;
     tree.tableInfo.moduleRoleName = this.MODULEROLENAME;
   }
}
