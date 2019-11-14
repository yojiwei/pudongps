package com.website;
import com.component.database.*;
import java.sql.*;

import com.util.*;
/**
 * <p>Title: 生成网站地图</p>
 * <p>Description: 用于动态生成网站地图</p>
 * <p>Copyright: Copyright (c) 2003</p>
 * <p>Company: </p>
 * @author honeyday
 * @version 1.0
 */

public class SiteMap extends CDataControl
{

  private StringBuffer _strMap=new StringBuffer();
  private String _sql="";
  private String _URL="",_sj_id="",_sj_name="",_sj_parentid="",_sj_dir="",_sj_url="";
  public void genMap(long id,int level,boolean isParent)
  {
    if (id>=0)
    {
      try
      {
        ResultSet rs = null;
        Statement stmt = null;
        stmt = cn.createStatement();
        if (isParent)
          _sql="select sj_id,sj_parentid,sj_name,sj_dir,sj_url from tb_subject where sj_display_flag=0 and sj_parentid=" + id + " order by sj_sequence";
        else
          _sql="select sj_id,sj_parentid,sj_name,sj_dir,sj_url from tb_subject where sj_display_flag=0 and sj_id=" + id + " order by sj_sequence";
        //System.out.println(_sql);

        rs = stmt.executeQuery(_sql);

        while (rs.next())
        {
          long curId = rs.getLong("sj_id");
          String sId = "";
          StringBuffer space = new StringBuffer("");
          _sj_id=rs.getString("sj_id");
          _sj_name =rs.getString("sj_name");
          _sj_parentid  =rs.getString("sj_parentid");
          _sj_dir  =rs.getString("sj_dir");
          _sj_url  =rs.getString("sj_url");
          sId   = sId.valueOf(curId);
          for (int i=1;i<level;i++)
            space.append("&nbsp;&nbsp;&nbsp;&nbsp;");

//////////////////
          _URL="<tr>";
          if (curId==0)
          {
            _URL+="<A href=/website/index.jsp><td class='mapnomal' onmouseover=\"this.className='mapover';\" onmouseout=\"this.className='mapnomal';\" onmousedown=\"this.className='mapclick';\">"+space+"<IMG SRC=\"/website/images/sitemap/tr_right.gif\">&nbsp;首页</td></A></tr>";

          }
          else
          {

            String _sURL="<a href=";
            _sURL+=_sj_url;
            if(_sj_url.indexOf("?") > 0)
            {
              _sURL = _sURL + "&sjId=" + _sj_id + "&sjName=" + _sj_name + "&sjDir=" + _sj_dir;
            }
            else
            {
              _sURL = _sURL + "?sjId=" + _sj_id + "&sjName=" + _sj_name + "&sjDir=" + _sj_dir;
            }
            if (level>0 && level<20)
              space.append("<IMG SRC=\"/website/images/sitemap/b"+level+".gif\">&nbsp;");
            _sURL+="><td class='mapnomal' onmouseover=\"this.className='mapover';\" onmouseout=\"this.className='mapnomal';\" onmousedown=\"this.className='mapclick';\">";
            _sURL+=space+_sj_name;
            _sURL+="</td></a></tr> ";
            _URL+=_sURL;
          }
          ///////////////////
          _strMap.append(_URL+"\n");
          space = null;
          genMap(curId , level+1,true);
        }
        rs.close();
        stmt.close() ;
      }
      catch(Exception e)
      {
        //System.out.println(e.toString());
      }
    }
  }

  public String getMap(long id,int level,boolean isParent)
  {
    genMap(id,level,isParent);
    return _strMap.toString();
  }
  public SiteMap()
  {
    this(null);
  }

  public SiteMap(CDataCn dCn)
  {
    super(dCn);
//    genMap(0,2,false);
//    System.out.println(_strMap);
  }

  public static void main(String[] args)
  {
    SiteMap siteMap1 = new SiteMap();
  }

}