package com.component.treeview;

import com.component.database.*;

public class CTreeList extends CTree implements ITreeList
{

   public CTreeList()
   {
   }

   /**
   @roseuid 3C09902E0084
   */
   public CTreeList(CDataCn dCn)
   {
     super(dCn);
   }

   /**
    * Method:CTree(CDataCn dCn,String dataType)
    * @param dCn 数据连接
    * @param dataType 数据类型 例： dept,meta,module,subject 程序会实例化相应的类
    * Description: 构造函数
   @roseuid 3E13C9F603B9
   */
   public CTreeList(CDataCn dCn, String dataType)
   {
     super(dCn);
     setStructureClassName(dataType);
   }

   /**
   @roseuid 3C0AF64D0008
   */
   public String getListByCode(String  code, String selectedId)
   {
     return getTreeList(this.LISTID,null,code,selectedId,null);
   }

   /**
   @roseuid 3C0AF64D00D0
   */
   public String getListByCurID(long id, String selectedId)
   {
     return getTreeList(this.LISTID,id,-1,selectedId,null);
   }

   /**
   @roseuid 3C0AF64D01A2
   */
   public String getListByParentID(long id, String selectedId)
   {
     return getTreeList(this.LISTID,-1,id,selectedId,null);
   }

   /**
   @roseuid 3C0AF64D0289
   */
   public String getListByInfo(String info, String selectedId)
   {
     return getTreeList(this.LISTID,info,null,selectedId,null);
   }

   /**
   @roseuid 3C0AF64D036F
   */
   public String getListByCode(int type, String code, String selectedValue, String tagName)
   {
     return getTreeList(this.LISTID,null,code,selectedValue,tagName);
   }

   /**
   @roseuid 3C0AF64E012B
   */
   public String getListByCurID(int type, long id, String selectedValue, String tagName)
   {
     return getTreeList(type,id,-1,selectedValue,tagName);
   }

   /**
   @roseuid 3C0AF64E032A
   */
   public String getListByParentID(int type, long id, String selectedValue, String tagName)
   {
     return getTreeList(type,-1,id,selectedValue,tagName);
   }

   /**
   @roseuid 3C0AF64F0119
   */
   public String getListByInfo(int type, String info, String selectedValue, String tagName)
   {
     return getTreeList(this.LISTID,info,null,selectedValue,tagName);
   }

   /*
   没有加入ROSE
   */

   /**
    * Method:setOnchange(boolean onchange)<br>
    * Description:设置是否需要输出onchange
    * @param onchange
    */
   public void setOnchange(boolean onchange)
   {
     _onchange = onchange;
   }

   /**
    * Method:setOutputSelect(boolean outputSelect)<br>
    * Description:设置是否需要输出select
    * @param outputSelect
    */
   public void setOutputSelect(boolean outputSelect)
   {
     _outputSelect = outputSelect;
   }


   /**
    * Method:getMultiListByCurID(int type, long id, String selectedValues, String tagName)<br>
    * Description:获取多选框的列表
    * @param type
    * @param id
    * @param selectedValues
    * @param tagName
    * @return
    */
   public String getMultiListByCurID(int type, long id, String selectedValues, String tagName,int outputType)
   {
     return getMultiTreeList(type,id,-1,selectedValues,tagName,outputType);
   }

   public String getMultiListByCurID(int type, long id, String selectedValues, String tagName)
   {
     return getMultiTreeList(type,id,-1,selectedValues,tagName);
   }

   public String getMultiListByCurID(long id, String selectedValues)
   {
     return getMultiTreeList(CTree.LISTID,id,-1,selectedValues,null);
   }


   public String getMultiListByCode(int type,String code,String selectValues,String tagName)
   {
     return getMultiTreeList(CTree.LISTID,code,selectValues,tagName);
   }

   public static void main(String[] args)
   {
     CDataCn dCn = new CDataCn();
     CTreeList tree = new CTreeList(dCn,"Meta");
     //CTreeList tree = new CTreeList(dCn,"Subject");
     //String list = tree.getListByCurID(1,"0");
     tree.setOnchange(false);
     String list = tree.getMultiListByCurID(CTree.LISTID,8,"43,37","aa",CTree.CHECKBOX);
     //String list = tree.getMultiListByCode(CTree.LISTID,"userkind","","aa");
     //long list = tree.getIdByCode("jmj");
     System.out.print(list);
     dCn.closeCn() ;
   }
}
