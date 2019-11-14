
package com.platform.log;

import com.component.database.*;

public class CLogInfo extends CDataImpl implements ILog
{
   public CLogInfo()
   {
   }

   /**
   @roseuid 3DF96B8E01BA
   */
   public CLogInfo(CDataCn dCn)
   {
     super(dCn);
     setTableName(this.TABLENAME);
     setPrimaryFieldName(this.PRIMARYFIELDNAME );
   }

   /**
   * Method:clearLog(int type)
   * Description: 清除由type指定的日志
   * @param type 日志类型
   * @return void
   @roseuid 3DF97060009C
   */
   public long clearLog(int type)
   {
     String sql ;

     if (type < 0) return -1;
     sql = "DELETE FROM " + this.TABLENAME + " WHERE " + this.TYPEFIELDNAME + " = " + type;
     try
     {
       executeUpdate(sql) ;
     }catch(Exception ex){
       raise(ex,"清除由type指定的日志时出错！","CLogInfo.clearLog");
     }
     return this.getUpdateCount() ;
   }
}
