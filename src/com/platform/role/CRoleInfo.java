package com.platform.role;

import com.component.database.*;
import com.component.treeview.*;
import com.util.*;
import javax.servlet.http.*;
import java.util.*;
import java.sql.*;

public class CRoleInfo extends CDataImpl{

  private static final String TABLENAME = "tb_roleinfo";
  private static final String PRIMARYFIELDNAME = "tr_id";
  private String _sql = "";
  private ResultSet rs = null;

  public CRoleInfo() {
  }

  /**
  @roseuid 3E12A18D006B
  */
  public CRoleInfo(CDataCn dCn)
  {
    super(dCn);
    setTableName(this.TABLENAME);
    setPrimaryFieldName(this.PRIMARYFIELDNAME);
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
    _sql = "delete from tb_functionrole where tr_id = " + id;

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
      _sql = "select tr_userids from tb_roleinfo where tr_id = " + id;
      rs = this.executeQuery(_sql);
      if (rs.next())
      {
        _sql = "";
        _ids = rs.getString("tr_userids");

        if (_ids != null)
        {
          if (!_ids.equals(""))
          {
            _ids = "-1" + _ids + "-1";
            _sql = "select u.ui_uid,u.ui_id,u.ui_name,d.dt_name from tb_userinfo u , tb_deptinfo d where u.dt_id = d.dt_id and u.ui_id in (" + _ids + ") order by d.dt_sequence,u.ui_sequence" ;
          }
        }

      }
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
      if (!_ids.equals("")) _sql = " and (dt_id in (" + _ids + ")";
      if (userIds != null)
      {
        if (!userIds.equals(""))
        {
          if (!_sql.equals(""))
          {
            _sql += " or ui_id in (" + userIds + ")";
          }else{
            _sql += " and (ui_id in (" + userIds + ")";
          }
        }
      }
      if (!_sql.equals("")) _sql += ")";
      _sql = "SELECT ui_id FROM tb_userinfo WHERE 1=1 " + _sql;

      rs = this.executeQuery(_sql);
      while (rs.next())
      {
        _strBuf.append("," + rs.getString("ui_id"));
      }
      rs.close() ;

      //再取自已已经有的用户
      _sql = "SELECT tr_userids FROM " + this.TABLENAME + " WHERE " + this.PRIMARYFIELDNAME + " = " + id ;
      rs = this.executeQuery(_sql);
      if (rs.next())
      {
        _ids = rs.getString("tr_userids");
        if (_ids != null) _strBuf.append(_ids);
      }
      _ids = _strBuf.toString();

      if (!_ids.equals(""))
      {
        String div = ",";
        _ids = CTools.clearSameValue(_ids,div);
      }
      _ids=","+CTools.trimEx(_ids,",")+",";

      //保存到角色
      _sql = "UPDATE " + this.TABLENAME + " SET tr_userids = '" + _ids + "' WHERE " + this.PRIMARYFIELDNAME + " = " + id;
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
      _sql = "SELECT tr_userids FROM " + this.TABLENAME + " WHERE " + this.PRIMARYFIELDNAME + " = " + id;
      rs = this.executeQuery(_sql);
      if (rs.next())
      {
        String _ids = rs.getString("tr_userids");
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
            _sql = "UPDATE " + this.TABLENAME + " SET tr_userids = '" + _ids + "' WHERE " + this.PRIMARYFIELDNAME + " = " + id;
            this.executeUpdate(_sql);
            return true;
          }
        }
      }
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
  public String getModules(long id)
  {
    if (id < 0) return "";
    String sId;
    String ids = "";
	StringBuffer _strBuf = new StringBuffer("");
    try
    {
      _sql = "SELECT ft_id FROM tb_functionrole WHERE tr_id = " + id;
      rs = this.executeQuery(_sql);
      while(rs.next())
      {
        sId = new String().valueOf(rs.getLong("ft_id"));
		_strBuf.append("," + sId);
      }
    }catch(Exception ex){
      raise(ex,"取得某一角色的模块集时出错！","CRoleInfo.getModules");
      return "";
    }
	if (_strBuf.length() > 0) {
      ids = CTools.trimEx(_strBuf.toString(),",");
    }
    return ids;
  }

  /**
  * Method:setModules(long id,String moduleIds)
  * Description: 设置由id指定的角色的模块集
  * @param id 主字段的值
  * @param moduleIds 模块集
  * @return boolean
  @roseuid 3DFAD80D00ED
  */
  public boolean setModules(long id, String moduleIds)
  {
    if (id < 0 || moduleIds == null) return false;
    if (moduleIds.equals("")) return false;

    try
    {
      dataCn.beginTrans();
      _sql = "DELETE FROM tb_functionrole WHERE tr_id = " + id;
      this.executeUpdate(_sql);
      String[] ids = CTools.split(moduleIds,",");
      ids = CTools.clearSameValue(ids);
      for(int i=0;i<ids.length;i++)
      {
        _sql = "insert into tb_functionrole(tr_id,ft_id) values("+id+","+ids[i]+")";
        this.executeUpdate(_sql);
      }
      dataCn.commitTrans() ;
      return true;
    }catch(Exception ex){
      dataCn.rollbackTrans();
      raise(ex,"设置由id指定的角色的模块集时出错！","CRoleInfo.setModules");
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
	StringBuffer _strBuf = new StringBuffer("");
    try
    {
      _sql = "SELECT sj_id FROM tb_subjectrole WHERE tr_id = " + id;
      rs = this.executeQuery(_sql);
      while(rs.next())
      {
        sId = new String().valueOf(rs.getLong("sj_id"));
		_strBuf.append("," + sId);
      }
    }catch(Exception ex){
      raise(ex,"取得某一角色的栏目集时出错！","CRoleInfo.getSubjects");
      return "";
    }

	if (_strBuf.length() > 0) {
      ids = CTools.trimEx(_strBuf.toString(),",");
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

    try
    {
      dataCn.beginTrans();

      if (subjectIds.equals("")) //如果传递过来的标题id为空，说明要删除所有的subject
      {
        _sql = "DELETE FROM tb_subjectrole WHERE tr_id = " + id; //首先删除当前角色的记录
        this.executeUpdate(_sql);
      }
      else
      {
        _sql = "DELETE FROM tb_subjectrole WHERE tr_id = " + id; //首先删除当前角色的记录
        this.executeUpdate(_sql);
        String[] ids = CTools.split(subjectIds,",");
        ids = CTools.clearSameValue(ids); //过滤相同的值
        for(int i=0;i<ids.length;i++)
        {
          _sql = "insert into tb_subjectrole(tr_id,sj_id) values("+id+","+ids[i]+")"; //插入记录
          this.executeUpdate(_sql);
        }
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
   * Method:getAudits(long id)<br>
   * Description: 获得用户拥有审核栏目<br>
   * @param id 角色ID
   * @return String 返回用户拥有的审核栏目
   */
  public String getAudits(long id)
  {
    if (id < 0) return "";
    String sId;
    String ids = "";
	StringBuffer _strBuf = new StringBuffer("");
    try
    {
      _sql = "SELECT sj_id FROM tb_auditrole WHERE tr_id = " + id;
      rs = this.executeQuery(_sql);
      while(rs.next())
      {
        sId = new String().valueOf(rs.getLong("sj_id"));
		_strBuf.append("," + sId);
      }
    }catch(Exception ex){
      raise(ex,"取得某一角色的栏目集时出错！","CRoleInfo.getAudits");
      return "";
    }
	if (_strBuf.length() > 0) {
	      ids = CTools.trimEx(_strBuf.toString(),",");
	}
	
    return ids;
  }

  /**
   * Method:setAudits(long id, String subjectIds)
   * Description:设置角色拥有的审核栏目<br>
   * @param id 角色的ID
   * @param subjectIds 栏目列表集合
   * @return
   */
  public boolean setAudits(long id, String subjectIds)
  {
    if (id < 0 || subjectIds == null) return false;

    try
    {
      dataCn.beginTrans();

      if (subjectIds.equals(""))
      {
        _sql = "DELETE FROM tb_auditrole WHERE tr_id = " + id; //首先删除当前角色的记录
        this.executeUpdate(_sql);
      } 
      else
      {
        _sql = "DELETE FROM tb_auditrole WHERE tr_id = " + id; //首先删除当前角色的记录
        this.executeUpdate(_sql);
        String[] ids = CTools.split(subjectIds,",");
        ids = CTools.clearSameValue(ids); //过滤相同的值
        for(int i=0;i<ids.length;i++)
        {
          _sql = "insert into tb_auditrole(tr_id,sj_id) values("+id+","+ids[i]+")"; //插入记录
          this.executeUpdate(_sql);
        }
      }

      dataCn.commitTrans() ;
      return true;
    }catch(Exception ex){
      dataCn.rollbackTrans();
      raise(ex,"设置由id指定的角色的栏目集时出错！","CRoleInfo.setAudits");
    }
    return false;
  }

  public static void main(String[] args)
  {
    CDataCn dCn = new CDataCn();
    CRoleInfo jdo = new CRoleInfo(dCn);
    //System.out.println(jdo.delete(64));
    //String ids = "1,-1,100,90";
    //System.out.print(jdo.setModules(1,ids));
    //System.out.print(jdo.getModules(1));
    //jdo.setUsers(1,"1,9,2,10","9");
    //System.out.print(jdo.getUsers(1));
    //jdo.delUsers(1,",12,13,11,");

    dCn.closeCn();
  }
}