package com.platform.admin;

import com.component.database.*;
import com.component.treeview.*;
import com.util.*;
import javax.servlet.http.*;
import java.util.*;
import java.sql.*;

public class CAdminInfo extends CDataImpl{

  private static final String TABLENAME = "TB_ADMINISTRATOR";
  private static final String PRIMARYFIELDNAME = "AT_id";
  public static final String ORGANIZATION_ACCESS="AT_organizationids";
  public static final String STRUCTURE_ACCESS="AT_structureids";
  public static final String ROLE_ACCESS="AT_roleids";
  public static final String META_ACCESS="AT_metaids";
  private static final String PrimaryFieldDesc="AT_name"; //当前主字段描述

  private String _sql = "";
  private ResultSet rs = null;

  public CAdminInfo() {
  }

   /**
  @roseuid 3E12A18D006B
  */
  public CAdminInfo(CDataCn dCn)
  {
    super(dCn);
    setTableName(this.TABLENAME);
    setPrimaryFieldName(this.PRIMARYFIELDNAME);
    //setPrimaryFieldDesc(PrimaryFieldDesc);
    setDefaultUser();
  }

  public void setDefaultUser()
  {
    String _sql="select * from Administrator where at_realname='超级系统管理员'";
    Hashtable res=this.getDataInfo(_sql);
    if(res==null)
    {
      addNew();
      setValue("AT_loginname","administrator",STRING);
      setValue("AT_password","12345678",STRING);
      setValue("AT_realname","超级系统管理员",STRING);
      setValue("AT_isactive","1",LONG);
      update() ;
    }

    _sql="select * from Administrator where at_realname='超级系统管理员2'";
    res=this.getDataInfo(_sql);
    if(res==null)
    {
      addNew();
      setValue("AT_loginname","administrator2",STRING);
      setValue("AT_password","12345678",STRING);
      setValue("AT_realname","超级系统管理员2",STRING);
      setValue("AT_isactive","1",LONG);
      update() ;
    }


    _sql="select * from Administrator where at_realname='审计员'";
    res=this.getDataInfo(_sql);
    if(res==null)
    {
      addNew();
      setValue("AT_loginname","audit",STRING);
      setValue("AT_password","12345678",STRING);
      setValue("AT_realname","审计员",STRING);
      setValue("AT_isactive","1",LONG);
      update() ;
    }
  }

  /**
  * Method:delete(long id) <br>
  * Description: 根据id值删除相应的角色表及角色模块关系表，该过载父类
  * @param id 主字段的值
  * @return boolean
  @roseuid 3DFAD2720108
  */
  public boolean delete(long id)
  {
    if (id < 0) return false;
    _sql = "delete from StructurePurview where RL_id = " + id;

    try
    {
      dataCn.beginTrans() ;
      this.executeUpdate(_sql);
      super.delete(id);
      dataCn.commitTrans();
      return true;
    }catch(Exception ex){
      dataCn.rollbackTrans() ;
      raise(ex,"删除角色时出错！","CRoleInfo.delete");
    }
    return false;
  }

  /**
  * Method:getUsers(long id)
  * Description: 根据id值列出相应的用户集
  * @param id 主字段的值
  * @return String
  @roseuid 3DFAD3280240
  */
  public String getUsers(long id)
  {
    if (id < 0) return null;
    String _ids = "";
    _sql = "";
    try
    {
      _sql = "select RL_userids,rl_userids1,rl_userids2,rl_userids3,rl_userids4 from RoleInfo where RL_id = " + id;
      rs = this.executeQuery(_sql);
      if (rs.next())
      {
        _sql = "";
        /****************************************************************************/
        /***************modified by Terry********************************************/
        /****************************************************************************/

        _ids = CTools.dealNull(rs.getString("rl_userids")) + CTools.dealNull(rs.getString("rl_userids1"))+
                              CTools.dealNull(rs.getString("rl_userids2")) + CTools.dealNull(rs.getString("rl_userids3")) +
                             CTools.dealNull(rs.getString("rl_userids4"));
        if (_ids.equals("")) _ids =null;
        /****************************************************************************/
        if (_ids != null)
        {
          if (!_ids.equals(""))
          {
            _ids = "-1" + _ids + "-1";
            _sql = "select u.UR_id,u.UR_realname,d.ORG_name from UserInfo u , Organization d where u.ORG_id = d.ORG_id and u.UR_id in (" + _ids + ") order by d.ORG_sequence,u.UR_sequence" ;
          }
        }

      }
      rs.close();
    }catch(Exception ex){
      raise(ex,"根据id值列出相应的用户集时出错！","CRoleInfo.getUsers");
    }
    return _sql;
  }

  /**
  * Method:getUserList(long id,String userIds) <br>
  * Description: 为角色增加用户集
  * @param id 角色id
  * @param dirIds 部门id集
  * @param userIds 用户id集
  * @return boolean
  @roseuid 3DFAD3CD0306
  */
  public boolean setUsers(long id, String dirIds,String userIds)
  {
    if (id < 0 ) return false;
    if (dirIds == null && userIds == null ) return false;
    StringBuffer _strBuf = new StringBuffer();
    String _ids = "";
    if (dirIds != null)
    {
      if (!dirIds.equals(""))
      {
        CTreeIds tree = new CTreeIds(dataCn,"Module");
        _ids = tree.getSubDirIdsByIDS(dirIds);
      }
    }
    try
    {
      //取出用户的ids
      _sql = "";
      if (!_ids.equals("")) _sql = " and (ORG_id in (" + _ids + ")";
      if (userIds != null)
      {
        if (!userIds.equals(""))
        {
          if (!_sql.equals(""))
          {
            _sql += " or UR_id in (" + userIds + ")";
          }else{
            _sql += " and (UR_id in (" + userIds + ")";
          }
        }
      }
      if (!_sql.equals("")) _sql += ")";
      _sql = "SELECT UR_id FROM UserInfo WHERE 1=1 " + _sql;

      rs = this.executeQuery(_sql);
      while (rs.next())
      {
        _strBuf.append("," + rs.getString("UR_id"));
      }
      rs.close() ;

      //再取自已已经有的用户
      _sql = "SELECT RL_userids FROM " + this.TABLENAME + " WHERE " + this.PRIMARYFIELDNAME + " = " + id ;
      rs = this.executeQuery(_sql);
      if (rs.next())
      {
        _ids = rs.getString("RL_userids");
        if (_ids != null) _strBuf.append(_ids);
      }
      rs.close();
      _ids = _strBuf.toString();

      if (!_ids.equals(""))
      {
       // _ids += "," ;
        String div = ",";
        _ids = CTools.clearSameValue(_ids,div);
      }

      //保存到角色
      _sql = "UPDATE " + this.TABLENAME + " SET RL_userids = '" + _ids + "' WHERE " + this.PRIMARYFIELDNAME + " = " + id;
      //System.out.println(_sql);
      this.executeUpdate(_sql);
      return true;

    }catch(Exception ex){
      raise(ex,"在设置角色的用户时出错！","CRoleInfo.setUsers");
    }

    return false;
  }

  /**
  * Method:getUserList(long id,String ids)
  * Description: 删除相应的用户集
  * @param id
  * @param userIds 用户id集
  * @return boolean
  @roseuid 3DFAD467007C
  */
  public boolean delUsers(long id, String[] userIds)
  {
    if (id < 0 || userIds == null) return false;
    if (userIds.length == 0) return false;
    String[] _aIds = userIds;

    try
    {
      _sql = "SELECT RL_userids FROM " + this.TABLENAME + " WHERE " + this.PRIMARYFIELDNAME + " = " + id;
      rs = this.executeQuery(_sql);
      if (rs.next())
      {
        String _ids = rs.getString("RL_userids");
        if (_ids != null)
        {
          if (!_ids.equals(""))
          {
            //String[] _aIds = CTools.split(userIds,",");
            for(int i=0;i < _aIds.length;i++)
            {
               _ids = CTools.replace(_ids,","+_aIds[i]+",",",") ;
            }
            if (_ids.equals(",")) _ids = "";
            _sql = "UPDATE " + this.TABLENAME + " SET RL_userids = '" + _ids + "' WHERE " + this.PRIMARYFIELDNAME + " = " + id;
            this.executeUpdate(_sql);
            return true;
          }
        }
      }
      rs.close();
    }catch(Exception ex){
      raise(ex,"删除相应的用户集时出错！","CRoleInfo.delUsers");
    }
    return false;
  }

  /**
  * Method:delAllUsers(long id)
  * Description: 删除由id指定的角色的所有用户
  * @param id 主字段的值
  * @return boolean
  @roseuid 3DFAD4BE0104
  */
  public boolean delAllUsers(long id)
  {
    return false;
  }

  /**
  @roseuid 3DFAD58601D3
  */
  public String getAccess(long id,String fieldName)
  {
    if (id < 0) return "";
    String _sql;
    String ids = "";
    _sql="select "+fieldName+" from "+this.TABLENAME+" where "+this.PRIMARYFIELDNAME+"="+id;
    ids=CTools.dealNull(getDataInfo(_sql).get(fieldName.toLowerCase()));
    ids=CTools.trimEx(ids,",");
    return ids;
  }

  /**
  * Method:setAccess(long id,String fieldName, String moduleIds)
  * Description: 设置由id指定的角色的模块集
  * @param id 主字段的值
  * @param moduleIds 模块集
  * @return boolean
  @roseuid 3DFAD80D00ED
  */
  public boolean setAccess(long id,String fieldName, String moduleIds)
  {
    if (id < 0 || moduleIds == null) return false;
    if (moduleIds.equals("")) return false;

    try
    {
      dataCn.beginTrans();
      _sql = "Update Administrator set "+fieldName+"=',"+moduleIds+",' where AT_id = " + id;
      executeUpdate(_sql);
      dataCn.commitTrans() ;
      return true;
    }catch(Exception ex){
      dataCn.rollbackTrans();
      raise(ex,"设置由id指定的管理员设定机构集时出错！","CAdminInfo.setModules");
    }
    return false;
  }

  /**
  * Method:setAllModules(long id)
  * Description: 设置由id指定的角色的所有模块集
  * @param id 主字段的值
  * @return boolean
  @roseuid 3DFAD88002D4
  */
  public boolean setAllModules(long id)
  {
    return false;
  }

  /**
  * Method:delAllModules(long id)
  * Description: 删除由id指定的角色的所有模块集
  * @param id 主字段的值
  * @return boolean
  @roseuid 3DFAD8BA015A
  */
  public boolean delAllModules()
  {
    return false;
  }

  /**
   * Method:getSubjects(long id)<br>
   * Description: 获得用户拥有的静态栏目<br>
   * @param id 角色ID
   * @return String 返回用户拥有的静态栏目
   */
  public String getSubjects(long id)
  {
    if (id < 0) return "";
    String sId;
    String ids = "";
    try
    {
      _sql = "SELECT sj_id FROM tb_subjectrole WHERE RL_id = " + id;
      rs = this.executeQuery(_sql);
      while(rs.next())
      {
        sId = new String().valueOf(rs.getLong("sj_id"));
        ids += "," + sId;
      }
      rs.close();
    }catch(Exception ex){
      raise(ex,"取得某一角色的栏目集时出错！","CRoleInfo.getSubjects");
      return "";
    }
    if (ids != "")
    {
      ids = ids.substring(1);
    }
    return ids;
  }

  /**
   * Method:setSubjects(long id, String subjectIds)
   * Description:设置角色拥有的静态栏目<br>
   * @param id 角色的ID
   * @param subjectIds 栏目列表集合
   * @return
   */
  public boolean setSubjects(long id, String subjectIds)
  {
    if (id < 0 || subjectIds == null) return false;
    if (subjectIds.equals("")) return false;

    try
    {
      dataCn.beginTrans();
      _sql = "DELETE FROM tb_subjectrole WHERE RL_id = " + id; //首先删除当前角色的记录
      this.executeUpdate(_sql);
      String[] ids = CTools.split(subjectIds,",");
      ids = CTools.clearSameValue(ids); //过滤相同的值
      for(int i=0;i<ids.length;i++)
      {
        _sql = "insert into tb_subjectrole(RL_id,sj_id) values("+id+","+ids[i]+")"; //插入记录
        this.executeUpdate(_sql);
      }
      dataCn.commitTrans() ;
      return true;
    }catch(Exception ex){
      dataCn.rollbackTrans();
      raise(ex,"设置由id指定的角色的栏目集时出错！","CRoleInfo.setSubjects");
    }
    return false;
  }

  /**
   * Method:synAccess(long curId,long parentId,String strType)
   * Description:权限同步，即实现新增一个子节点的时候，如果其他管理员对该节点的父节点有权限，那末他对新增的子节点也应该有权限。
   * @param curId 新增的节点的ID
   * @param parentId 该节点的父节点的id
   * @param strType 权限类型
   * @return
   */
  public boolean synAccess(long curId,long loginId,String strType)
  {
    _sql="update administrator set "+strType+"="+strType +"'"+curId+",' where at_id="+loginId;
    executeUpdate(_sql);
    return true;
  }

  /**
   * Method:synAccess(long curId,long parentId,String strType)
   * Description:权限同步(角色同步专用)，即实现新增一个子节点的时候，如果其他管理员对该节点的父节点有权限，那末他对新增的子节点也应该有权限。
   * @param curId 新增的节点的ID
   * @param roleId 角色的ID
   * @return
   */
  public boolean synAccess(long curId,long loginId)
  {
    String _sql="";
    try {
      _sql="update administrator set AT_roleids=AT_roleids" +"'"+curId+",' where at_id = "+loginId;
      executeUpdate(_sql);
    }
    catch (Exception ex) {
      raise(ex,"产生错误，原因:" + ex.getMessage() + ",SQL语句:" +_sql,"CAdminInfo.synAccess(long curId,long loginId)");
      return false;
    }
    return true;
  }

  /**
   * Method: boolean isSuper(String userLongName)
   * Description:返回指定的用户是否是超级管理员。
   * @param userLoginName 用户的登陆名
   * @return 布尔值
   */
  public boolean isSuper(String userLoginName)
  {
    userLoginName=CTools.dealNull(userLoginName);
    return (userLoginName.toLowerCase().equals("administrator"))||userLoginName.toLowerCase().equals("administrator2")?true:false;
  }

  /**
   * Method: boolean isSuper(String userLongName)
   * Description:返回指定的用户是否是审计员。
   * @param userLoginName 用户的登陆名
   * @return 布尔值
   */
  public boolean isAudit(String userLoginName)
  {
    userLoginName=CTools.dealNull(userLoginName);
    return (userLoginName.toLowerCase().equals("audit"))?true:false;
  }

  public static void main(String[] args)
  {
    CDataCn dCn = new CDataCn();
    CAdminInfo jdo = new CAdminInfo(dCn);
    //System.out.println(jdo.delete(64));
    //String ids = "1,-1,100,90";
    //System.out.print(jdo.setModules(1,ids));
    //System.out.print(jdo.getModules(1));
    //jdo.setUsers(1,"1,9,2,10","9");
    //System.out.print(jdo.getUsers(1));
    //jdo.delUsers(1,",12,13,11,");
    //jdo.setAccess(4,jdo.ROLE_ACCESS,"2,3,4");
    System.out.println(jdo.getAccess(7,jdo.ROLE_ACCESS));
    //jdo.synAccess(12,2,jdo.META_ACCESS);
    dCn.closeCn();
  }
}