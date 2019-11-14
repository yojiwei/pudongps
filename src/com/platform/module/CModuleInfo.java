
package com.platform.module;

import com.component.database.*;
import javax.servlet.http.*;
import java.sql.SQLException;
import java.sql.*;
import com.util.*;
import java.util.*;
import java.net.*;
import java.io.*;

public class CModuleInfo extends CDataImpl
{
   private static final String TABLENAME = "tb_function";
   private static final String PRIMARYFIELDNAME = "FT_id";
   private boolean mode = true; //新增模式

   public CModuleInfo()
   {
     this(null);
   }

   /**
   @roseuid 3C031AB00180
   */
   public CModuleInfo(CDataCn dCn)
   {
     super(dCn);
     setTableName(this.TABLENAME);
     setPrimaryFieldName(this.PRIMARYFIELDNAME );
   }

   /**
   * Method: hasSameModule(String code,long id)
   * Description: 判断是否有相同的代码
   * @param code 模块代码
   * @param id
   * @return boolean
   @roseuid 3C0375D50072
   */
   public boolean hasSameModule(String code,long id)
   {
     return hasSameCode(code,"ft_code",id);
   }

   /**
   * Method: hasSubModule(long id)
   * Description: 判断是否有子模块
   * @param id
   * @return boolean
   @roseuid 3C04BEAF01B1
   */
   public boolean hasSubModule(long id)
   {
     return hasSubObject("ft_parent_id",id);
   }

   /**
   * Method:String getRoleIds(long moduleId)
   * Description: 获取该模块拥有的角色集id列表
   * @param moduleId 模块id
   * @return String 角色集id列表
   @roseuid 3C0475C20397
   */
   public String getRoleIds(long moduleId)
   {
    String roleIds="";
    String _sql="select tr_id from tb_functionrole where ft_id=" + moduleId;
    try {
      ResultSet rs =executeQuery(_sql);
       while(rs.next())
       {
         roleIds+=rs.getLong("tr_id") +",";
       }
       rs.close();
    }
    catch (SQLException ex) {
      return "";
    }
     return CTools.trimEx(roleIds,",");
   }

   /**
   * Method:String getRoleNames(long moduleId)
   * Description: 获取该模块拥有的角色集名称列表
   * @param moduleId 模块id
   * @return String 角色集名称列表
   @roseuid 3C0475C20397
   */
   public String getRoleNames(long moduleId)
   {
    String roleNames="";
    String roleIds=getRoleIds(moduleId);

    if(roleIds.equals("")) return "";

    String _sql="select tr_name from tb_roleinfo where tr_id in(" + roleIds +")";
    try {
      ResultSet rs =this.executeQuery(_sql);
       while(rs.next())
       {
         roleNames+=rs.getString("tr_name") +",";
       }
       rs.close();
    }
    catch (SQLException ex) {
      return "";
    }
     return CTools.trimEx(roleNames,",");
   }


   /**
   * Method:setSequence(HttpServletrequests request)
   * Description: 保存排序
   * @param request
   * @return boolean
   @roseuid 3C0475C20397
   */
   public boolean setSequence(HttpServletRequest request)
   {
     return setSequence("module","ft_sequence",request);
   }

   public static void main(String[] args) {
     CModuleInfo jdo = new CModuleInfo();
     //ado.setSequence("module","ft_sequence",null);
     //String s = "module";
     //System.out.print(jdo.hasSameModule("news",67));
     System.out.print(jdo.getRoleNames(714));

   }

}
