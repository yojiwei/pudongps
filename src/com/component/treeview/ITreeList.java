package com.component.treeview;


public interface ITreeList
{

   /**
    * Method:getListByCode(String code,String selectedId)
    * Description: 根据当前code取得list下拉列表
    * @param code 目录代码
    * @param selectedId 选择的值
    * return String
   @roseuid 3C0983EA03A0
   */
   public String getListByCode(String  code, String selectedId);

   /**
    * Method:getListByCurID(long id,String selectedId)
    * Description: 根据当前ID取得List
    * @param id 目录ID
    * @param selectedId 选择的值
    * return String
   @roseuid 3C0984030157
   */
   public String getListByCurID(long id, String selectedId);

   /**
    * Method:getListByParentID(long id)
    * Description: 根据上级目录ID取得List
    * @param id 上级目录ID
    * @param selectedId 选择的值
    * return String
   @roseuid 3C09842203C9
   */
   public String getListByParentID(long id, String selectedId);

   /**
    * Method:getListByParentID(String info)
    * Description: 根据目录名称info取得List
    * @param info 目录名称
    * @param selectedId 选择的值
    * return String
   @roseuid 3C098495022A
   */

   public String getListByInfo(String info, String selectedId);

   /**
    * Method:getListByCode(int type,String code,String selectedId,String tagName)
    * Description: 根据当前code取得list下拉列表
    * @param type　列表显示方式,LISTID:value值为ID,LISTNAME:value值为name
    * @param code 目录代码
    * @param selectedId 选择的值
    * @param tagName 列表框name的值
    * return String
   @roseuid 3C0AF1B400AF
   */
   public String getListByCode(int type, String code, String selectedValue, String tagName);

   /**
    * Method:getListByCurID(long id,String selectedId)
    * Description: 根据当前ID取得List
    * @param type　列表显示方式,LISTID:value值为ID,LISTNAME:value值为name
    * @param id 目录ID
    * @param selectedId 选择的值
    * @param tagName 列表框name的值
    * return String
   @roseuid 3C0AF5060329
   */
   public String getListByCurID(int type, long id, String selectedValue, String tagName);

   /**
    * Method:getListByParentID(long id)
    * Description: 根据上级目录ID取得List
    * @param type　列表显示方式,LISTID:value值为ID,LISTNAME:value值为name
    * @param id 上级目录ID
    * @param selectedId 选择的值
    * @param tagName 列表框name的值
    * return String
   @roseuid 3C0AF562017C
   */
   public String getListByParentID(int type, long id, String selectedValue, String tagName);

   /**
    * Method:getListByParentID(String info)
    * Description: 根据目录名称info取得List
    * @param type　列表显示方式,LISTID:value值为ID,LISTNAME:value值为name
    * @param info 目录名称
    * @param selectedId 选择的值
    * @param tagName 列表框name的值
    * return String
   @roseuid 3C0AF5C301B8
   */
   public String getListByInfo(int type, String info, String selectedValue, String tagName);
}