
package com.component.database;

import javax.servlet.http.*;
import java.util.*;

/**
数据分页接口
*/
public interface IDataSplitPage
{

   /**
   * Method:splitPage()
   * Description: 设置分页，把每条记录转换为HashTable，再组合成Vector对象
   * @param request JSP内置对象Request.
   * @return Vector
   @roseuid 3BF0BC3201E9
   */
   public Vector splitPage(HttpServletRequest request);

   /**
   * Method: getTail(HttpServletRequest request)
   * Description: 返回分页底部文件
   * @param request JSP内置Request对象
   * @return String
   @roseuid 3BF0BCD7004C
   */
   public String getTail(HttpServletRequest request);

   /**
   * Method: getTail(HttpServletRequest request)
   * Description: 返回分页底部文件
   * @param request JSP内置Request对象
   * @param mode  设置分页方式
   * @return String
   @roseuid 3BF1D567013A
   */
   public String getTail(HttpServletRequest request, int mode);

   /**
   * Method: setSql(String sql)
   * Description: 设置sql
   * @param sql
   * @return void
   @roseuid 3BF1D76F0228
   */
   public void setSql(String sql);

   /**
   * Method: setPageSize(int size)
   * Description: 设置每页的显示记录数
   * @param size
   * @param mode  设置分页方式
   * @return String
   @roseuid 3BF1D858002E
   */
   public void setPageSize(int intPageSize);

   /**
   * Method:getPageCount()
   * Description: 返回分页后的总页数
   * @return int
   @roseuid 3BF1DAA400F2
   */
   public int getPageCount();

   /**
   * Method:getPageNo()
   * Description: 返回当前页的页码数
   * @return int
   @roseuid 3BF1DD4000E9
   */
   public int getPageNo();
}
