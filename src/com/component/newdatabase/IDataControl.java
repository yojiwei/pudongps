
package com.component.newdatabase;

import java.util.*;
import javax.servlet.http.*;

public interface IDataControl
{

   /**
   * Method:setTableName(String tableName)
   * Description: 设置数据表的表名称
   * @param tableName 表名称
   * @return void
   @roseuid 3BF1EC4C0015
   */
   public void setTableName(String tableName);

   /**
   * Method:setPrimaryFieldName(String fieldName)
   * Description: 设置主字段名称
   * @param fieldName 字段名称
   * @return void
   @roseuid 3BF1EC3C03D4
   */
   public void setPrimaryFieldName(String fieldName);

   /**
   * Method:addNew()
   * Description: 设置数据操作为新增状态，并取得最大ID，该操作必须在调用setTableName后执行
   * @return long maxID
   @roseuid 3BF1DDD20355
   */
   public long addNew();

   /**
   * Method:edit(long id)
   * Description: 设置数据操作为更改状态
   * @param id 记录id号
   * @return void
   @roseuid 3BF1E28802C3
   */
   public void edit(long id);

   /**
   * Method:setValue(String fieldName,Object value)
   * Description: 设置某一字段的值，并保存CDataBase私有的Hashtable变量，并不对ResultSet进行操作
   * @param fieldName 字段名称
   * @param value 数据值
   * @return void
   @roseuid 3BF1E3900128
   */
   public void setValue(String fieldName, Object fieldValue,int pMode);

   /**
   * Method:setValue(String fieldName,Object fieldValue,int type)
   * Description: 设置某一字段的值，并保存在CDataBase私有的HashTable变量，其type也保存在CDataBase私有的另一个HashTable变量中，并不对ResultSet进行操作
   * @param fieldName 字段名称
   * @param value 数据值
   * @param type 字段类型
   * @return void
   @roseuid 3BF1E52A0204
   */
   public void setValue();

   /**
   * Method:update()
   * Description: 保存数据到数据库。
首先判断操作方式，再遍历通过setValue设置的两个HashTable变量，组合相应的sql,再执行，若正确，返回真，若失败返回假
   * @return boolean
   @roseuid 3BF1E5FE019B
   */
   public boolean update();

   /**
   * Method:delete(long id)
   * Description: 根据id值删除相应的记录
   * @param id 主字段的值
   * @return long
   @roseuid 3BF1ECB503BA
   */
   public boolean delete(long id);

   /**
   * Method:delete(String tableName,String primaryFieldName,long id)
   * Description: 删除一条记录
   * @param tableName 表名称
   * @param primaryFieldName 主字段名称
   * @param id 主字段的值
   * @return long
   @roseuid 3BF1F60001B2
   */
   public boolean delete(String tableName, String primaryFieldName, long id);

   /**
   * Method:setClobValue(String fieldName,Object value)
   * Description: 保存一Clob字段类型的值到数据库,该操作一般紧跟在update()后执行
   * @param fieldName 字段名称
   * @param value 主字段的值
   * @return boolean
   @roseuid 3BF1F6B90294
   */
   public boolean setClobValue(String fieldName, Object value);

   /**
   * Method:setClobValue(String tableName,String primaryFieldName,long id,String fieldName,Object value)
   * Description: 保存一Clob字段类型的值到数据库
   * @param tableName 表名称
   * @param primaryFieldName 主字段名称
   * @param id 主字段的值
   * @param fieldName Clob字段名称
   * @param value Clob字段数据值
   * @return boolean
   @roseuid 3BF1F7550220
   */
   public boolean setClobValue(String tableName, String primaryFieldName, long id, String fieldName, Object value);

   /**
   * Method:setClobValue(Hashtable ht)
   * Description: 保存一Clob字段类型的值到数据库,该操作一般紧跟在update()后执行
   * @param ht ht.key:字段名称 ht.value:字段值
   * @return boolean
   @roseuid 3BF1FA920060
   */
   public boolean setClobValue(Hashtable ht);

   /**
   * Method:setClobValue(String tableName,String primaryFieldName,long id,Hashtable ht)
   * Description: 保存一Clob字段类型的值到数据库
   * @param tableName 表名称
   * @param primaryFieldName 主字段名称
   * @param id 主字段的值
   * @param ht ht.key:字段名称 ht.value:字段值
   * @return boolean
   @roseuid 3BF1FC370200
   */
   public boolean setClobValue(String tableName, String primaryFieldName, long id, Hashtable ht);

   /**
   * Method:setSequence(String paraName,String sequenceFieldName,HttpServletrequest request)
   * Description: 保存排序
   * @param paraName 设置排序的文本框前面的名称  例： name='module'+id
   * @param sequenceFieldName 排序字段名称
   * @param request
   * @return boolean
   @roseuid 3C0451460383
   */
   public boolean setSequence(String paraName, String sequenceFieldName, HttpServletRequest request);

   /**
   * Method: hasSameCode(String code,String codeFieldName,long id)
   * Description: 判断是否有相同的代码
   * @param code 模块代码
   * @param codeFieldName 代码对应的字段名称
   * @param id
   * @return boolean
   @roseuid 3C0CB5EB00EC
   */
   public boolean hasSameCode(String code, String codeFieldName, long id);

   /**
   * Method: hasSubModule(String parentIdFieldName,long id)
   * Description: 判断是否有子对象
   * @param id
   * @parentIdFieldName 上级目录ＩＤ对象的字段名称
   * @return boolean
   @roseuid 3C0CB5FE0194
   */
   public boolean hasSubObject(String parentIdFieldName, long id);
}
