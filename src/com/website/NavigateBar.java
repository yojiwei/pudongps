package com.website;
import com.component.database.*;
import java.sql.*;

import com.util.*;
/**
 * <p>Title: oa-页面导航栏</p>
 * <p>Description:生成页面的导航栏 </p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: popteach</p>
 * @author honeyday
 * @version 1.0
 */

public class NavigateBar extends CDataControl {
  private String _URL="",_sql="",_sj_id="",_sj_name="",_sj_parentid="",_sj_dir="",_sj_url="";

  public String getURL(int sj_id)
  {
    return getURL(sj_id,true);
  }

  public String getURL(int sj_id,boolean isLast)
  {
    getSubject(sj_id,isLast);
    return _URL;
  }
  /**
   * Method:getSubject(int sj_id,boolean isLast)
   * Description: 递归目录生成导航条字符串
   * @param sj_id: 目录的ID
   * @param isLast:　是否最后一个
   * @return String
   */
  private String getSubject(int sj_id,boolean isLast)
  {

    ResultSet rs = null;
    Statement stmt = null;

    if (sj_id>=0){
      try{
        stmt = cn.createStatement();
        _sql="select sj_id,sj_parentid,sj_name,sj_dir,sj_url from tb_subject where sj_id=" + sj_id;
        rs = stmt.executeQuery(_sql);
        if (rs.next()){
          _sj_id=rs.getString("sj_id");
          _sj_name =rs.getString("sj_name");
          _sj_parentid  =rs.getString("sj_parentid");
          _sj_dir  =rs.getString("sj_dir");
          _sj_url  =CTools.dealNull(rs.getString("sj_url"));
          rs.close();
          stmt.close();
        }else{
          rs.close();
          stmt.close();
        }
      }
      catch(Exception e){
        System.out.println("Error! While getting subject list! --by honeyday.");
      }
      if (_sj_id.equals("0"))
      {
        if (!isLast)
          _URL="<A href=/web/index.jsp>首页</A>"+_URL;
        else
          _URL="首页"+_URL;
        return _sj_id;
      }
      else
      {
        String _sURL="";

          if (!isLast)
          {
            if (!_sj_url.equals(""))
            {
              _sURL+="<a href=";
              _sURL+=_sj_url;
              if(_sj_url.indexOf("?") > 0)
              {
                _sURL = _sURL + "&sjId=" + _sj_id + "&sjName=" + _sj_name + "&sjDir=" + _sj_dir;
              }
              else
              {
                _sURL = _sURL + "?sjId=" + _sj_id + "&sjName=" + _sj_name + "&sjDir=" + _sj_dir;
              }
              _sURL+=">";
            }
          }
          _sURL+=_sj_name;
          if (!isLast && !_sj_url.equals(""))
            _sURL+="</a> ";
          _URL=" > "+_sURL+_URL;

        return getSubject(Integer.parseInt(_sj_parentid),false);
      }
    }
    return "0";
  }


  public NavigateBar() {
  }
  public static void main(String[] args) {
    NavigateBar navigateBar1 = new NavigateBar();
    //SubjectDetail sd= new SubjectDetail();

    //while (sd!=null)
    //{
    System.out.println(navigateBar1.getURL(63,true));
    //System.out.println(sd.sj_name+sd.sj_parentid);

    //}
  }
}