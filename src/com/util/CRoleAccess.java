package com.util;

import com.component.database.*;
import com.component.treeview.*;
import com.util.*;
import javax.servlet.http.*;
import java.util.*;
import java.sql.*;

public class CRoleAccess extends CDataImpl{

  public static final int OrganAccess=1;
  public static final int MetaAccess=2;
  public static final int RoleAccess=3;
  public static final int ModuleAccess=4;
  public static final int ColumnAccess=5;

  public static final int OrganSelAccess=7;
  public static final int MetaSelAccess=8;
  public static final int RoleSelAccess=9;
  public static final int ModuleSelAccess=10;
  public static final int ColumnSelAccess=11;

  public CRoleAccess() {
  }

  /**
  @roseuid 3E12A18D006B
  */
  public CRoleAccess(CDataCn dCn)
  {
    super(dCn);
  }

  public String getAccessByUser(String userid,int type)
  {

    String ids1="";
    String roleIds="";
	StringBuffer _strRoleIdsBuf = new StringBuffer("");
	StringBuffer _strAccessIdsBuf = new StringBuffer("");

    ResultSet rsRole=this.executeQuery("select TR_ID from TB_ROLEINFO where TR_USERIDS like '%,"+userid+",%'");
    try {
      while (rsRole.next())
      {
        String roleid=CTools.dealNull(rsRole.getString("TR_ID"));
        _strRoleIdsBuf.append(roleid+",");
      }
    }
    catch (SQLException ex) {
      return "";
    }
    
	if (_strRoleIdsBuf.length() > 0) {
		roleIds = _strRoleIdsBuf.toString() + ",";
	}

    String arrRoleIds[]=CTools.split(roleIds,",");
    for(int i=0;i<arrRoleIds.length;i++)
    {
      String id=CTools.dealNull(arrRoleIds[i]);
      if (!id.equals(""))
      {
        _strAccessIdsBuf.append(CTools.trimEx(getAccessByRole(id,type),",")+",");
      }
    }

	if (_strAccessIdsBuf.length() > 0) {
		ids1 = _strAccessIdsBuf.toString() + ",";
	}
	
    ids1=CTools.dealNull(ids1);
    if(!ids1.equals("")){
      ids1=CTools.clearSameValue(ids1,",");
      ids1=CTools.trimEx(ids1,",");
    }
    return ids1;
  }

  public String getAccessSqlByUser(String userid,int type)
  {
    String field="";
    switch(type)
    {
      case OrganSelAccess:
      case OrganAccess:
        field="dt_id";
        break;
      case MetaAccess:
      case MetaSelAccess:
        field="dd_id";
        break;
      case RoleAccess:
      case RoleSelAccess:
        field="TR_ID";
        break;
      case ModuleAccess:
      case ModuleSelAccess:
        field="ft_id";
        break;
      case ColumnAccess:
      case ColumnSelAccess:
        field="SJ_ID";
        break;
    }
    String sql=" and "+field+" in(-1)";
    String sql1="";
    
    
    String ids[]=CTools.split(getAccessByUser(userid,type),",");
	StringBuffer _strSqlBuf = new StringBuffer("");
    for(int i=0;i<ids.length;i++)
    {
      String id=CTools.dealNull(ids[i]);
      if (!id.equals(""))
      {
    	  _strSqlBuf.append(id+",");
    	  if((i%900==0 && i>0) ||(i%900!=0 && i==ids.length-1))
    	  {
    		  sql1+= "or "+field+" in ("+CTools.trimEx(_strSqlBuf.toString(),",") + ") "; 
    		  _strSqlBuf.delete(0,_strSqlBuf.length());
    	  }
      } 
    }
	if (!sql1.equals("")) {
		sql = " and (" + CTools.trimEx(sql1,"or") +")";
	}

    return sql;
  }

  public String getAccessByRole(String role,int type)
  {
    String ids="";
    String sql="select ACCESS_ID from TB_ACCESS where TB_TYPE="+type+" and RL_ID="+role;
    
    if (type==this.ModuleAccess || type==this.ModuleSelAccess)
    	sql="select ft_id as ACCESS_ID FROM tb_functionrole WHERE tr_id ="+role;
    
    ResultSet rs=this.executeQuery(sql);
	StringBuffer _strIdsBuf = new StringBuffer("");
    try {
      while (rs.next())
      {
    	  _strIdsBuf.append(rs.getString("ACCESS_ID")+",");
      }
    }
    catch (SQLException ex) {
    }
	
	if (_strIdsBuf.length() > 0) {
		ids = _strIdsBuf.toString() + ",";
	}
	
    ids=CTools.dealNull(ids);
    if(!ids.equals("")){
      ids=CTools.clearSameValue(ids,",");
      ids=CTools.trimEx(ids,",");
    }
    return ids;
  }


  public String getAccessSqlByRole(String role,int type)
  {
    String field="";
    switch(type)
    {
      case OrganSelAccess:
      case OrganAccess:
        field="dt_id";
        break;
      case MetaAccess:
      case MetaSelAccess:
        field="dd_id";
        break;
      case RoleAccess:
      case RoleSelAccess:
        field="TR_ID";
        break;
      case ModuleAccess:
      case ModuleSelAccess:
        field="ft_id";
        break;
      case ColumnAccess:
      case ColumnSelAccess:
        field="SJ_ID";
        break;
    }
    String sql=" and "+field+" in(-1)";
    String sql1="";
    String ids[]=CTools.split(getAccessByRole(role,type),",");
	StringBuffer _strSql1Buf = new StringBuffer("");
    for(int i=0;i<ids.length;i++)
    {
      String id=CTools.dealNull(ids[i]);
      if (!id.equals(""))
      {
    	  _strSql1Buf.append(id+",");
      }
    }
    
	if (_strSql1Buf.length() > 0) {
		sql1 = _strSql1Buf.toString() + ",";
	}

    sql1=CTools.trimEx(sql1,",");
    if(!sql1.equals("")) sql=CTools.replace(sql,"-1","-1,"+sql1);
    return sql;
  }

  public boolean isAdmin(String user)
  {
      return isInRole("超级管理员",user);
  }

  public boolean isInRole(String role,String user)
  {
    boolean res=false;

    try {
      ResultSet rsRole=this.executeQuery("select TR_ID from TB_ROLEINFO where TR_USERIDS like '%,"+user+",%' and TR_NAME='"+role+"'");
      return rsRole.next();
    }
    catch (SQLException ex) {
      return false;
    }
  }

  public void setAccess(String role,String AccessIds,int type)
  {
    executeUpdate("delete from TB_ACCESS where TB_TYPE="+type+" and RL_ID="+role);
    String ids[]=CTools.clearSameValue(CTools.split(AccessIds,","));
    for(int i=0;i<ids.length;i++)
    {
      String id=CTools.dealNull(ids[i]);
      if (!id.equals("")) 
      {
        executeUpdate("insert into TB_ACCESS(TB_ID,RL_ID,TB_TYPE,ACCESS_ID) values("+getMaxId("TB_ACCESS")+","+role+","+type+","+id+")");
      }
    }
  }


  public static void main(String[] args)
  {
    CDataCn dCn = new CDataCn();
    CRoleAccess jdo = new CRoleAccess(dCn);
    String sql1=jdo.getAccessSqlByUser("1307",jdo.ColumnAccess);

    dCn.closeCn();
  }
}