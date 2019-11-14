package com.component.database;

import java.util.*;

public interface IDataInfo
{

   /**
   * Method:getDataInfo(String sql)
   * Description: 根据sql查询得到第一条记录，并转换为Hashtable，若为查询结果为空，则返回null
   * @param sql
   * @return HashTable
   @roseuid 3BF0B87B026E
   */
   public Hashtable getDataInfo(String sql);

   /**
   * Method:getDataInfo(long id)
   * Description: 根据主字段ID的值查询得到第一条记录，并转换为Hashtable，若为查询结果为空，则返回null
   * @param id
   * @return Hashtable
   @roseuid 3C0441D60222
   */
   public Hashtable getDataInfo(long id);
}
