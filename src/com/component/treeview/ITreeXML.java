package com.component.treeview;


public interface ITreeXML
{

   /**
    * Method:getXMLByCurID(long id)
    * Description: 根据当前ID取得XML
    * @param id 目录ID
    * return String
   @roseuid 3C01D7890246
   */
   public String getXMLByCurID(long id);

   /**
    * Method:getXMLByParentID(long id)
    * Description: 根据上级目录ID取得XML
    * @param id 上级目录ID
    * return String
   @roseuid 3C01D7960141
   */
   public String getXMLByParentID(long id);

   /**
    * Method:getXMLByParentID(String info)
    * Description: 根据目录名称info取得XML
    * @param info 目录名称
    * return String
   @roseuid 3C01D79F027A
   */
   public String getXMLByInfo(long id);
}