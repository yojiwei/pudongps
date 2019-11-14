// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   NavigateNewBar.java

package com.website;

import com.component.database.CDataCn;
import com.component.database.CDataControl;
import com.util.CTools;
import java.sql.*;
/**
 * 浦东动态页面导航页
 * @author Yo
 * @datetime 20110419
 */
public class NavigateNewBar extends CDataControl
{
    public String getURL(int sj_id)
    {
        return getURL(sj_id, true, 0);
    }

    public String getURL(int sj_id, boolean isLast)
    {
        getURL(sj_id, isLast, 0);
        return _URL;
    }

    public String getURL(int sj_id, boolean isLast, int lan)
    {
        switch(lan)
        {
        case 0: // '\0'
            _Lan = "\u9996\u9875";//首页
            _LanURL = _HomeURL.equals("") ? "/website/index.jsp" : _HomeURL;
            break;

        case 1: // '\001'
            _Lan = "Home";
            _LanURL = _HomeURL.equals("") ? "/english/index.jsp" : _HomeURL;
            break;

        default:
            _Lan = "\u9996\u9875";//首页
            _LanURL = _HomeURL.equals("") ? "/website/index.jsp" : _HomeURL;
            break;
        }
        getSubject(sj_id, isLast);
        return _URL;
    }
	  //update by yo 20110418
    public String getURL(String sjdir, boolean isLast)
    {
        getURL(sjdir, isLast, 0);
        return _URL;
    }
    /**
     * update by yo
     */
//    public String getURL(String sjdir, boolean isLast)
//    {
//        return "";
//    }

    public void setHomeURL(String url)
    {
        _HomeURL = url;
    }

    public String getURL(String sjdir, boolean isLast, int lan)
    {
        if(_HomeURL.equals(""))
            _HomeURL = "/website/index.jsp";
        switch(lan)
        {
        case 0: // '\0'
            _Lan = "\u9996\u9875";//首页
            _LanURL = _HomeURL.equals("") ? "http://www.pudong.gov.cn" : _HomeURL;
            break;

        case 1: // '\001'
            _Lan = "Home";
            _LanURL = _HomeURL.equals("") ? "/english/index.jsp" : _HomeURL;
            break;

        default:
            _Lan = "\u9996\u9875";
            _LanURL = _HomeURL.equals("") ? "/website/index.jsp" : _HomeURL;
            break;
        }
        getSubject(sjdir, isLast);
        return _URL;
    }

    private String getSubject(int sj_id, boolean isLast)
    {
        ResultSet rs = null;
        Statement stmt = null;
        if(sj_id >= 0)
        {
            try
            {
                stmt = cn.createStatement();
                _sql = (new StringBuilder("select sj_id,sj_parentid,sj_name,sj_dir,sj_url from tb_subject where sj_id=")).append(sj_id).toString();
                rs = stmt.executeQuery(_sql);
                if(rs.next())
                {
                    _sj_id = rs.getString("sj_id");
                    _sj_name = rs.getString("sj_name");
                    _sj_parentid = rs.getString("sj_parentid");
                    _sj_dir = rs.getString("sj_dir");
                    _sj_url = CTools.dealNull(rs.getString("sj_url"));
                    rs.close();
                    stmt.close();
                } else
                {
                    rs.close();
                    stmt.close();
                    return "0";
                }
            }
            catch(Exception e)
            {
                System.out.println("Error! While getting subject list! --by honeyday.");
            }
            if(Messages.getString("rootid").indexOf((new StringBuilder(",")).append(_sj_id).append(",").toString()) != -1)
            {
                if(!isLast)
                    _URL = (new StringBuilder("<A href=")).append(_LanURL).append(" class='three'>").append(_Lan).append("</A>").append(_URL).toString();
                else
                    _URL = (new StringBuilder(String.valueOf(_Lan))).append(_URL).toString();
                return _sj_id;
            }
            String _sURL = "";
            if(!isLast && !_sj_url.equals(""))
            {
                _sURL = (new StringBuilder(String.valueOf(_sURL))).append("<a class='three' href=").toString();
                _sURL = (new StringBuilder(String.valueOf(_sURL))).append(_sj_url).toString();
                if(_sj_url.indexOf("?") > 0)
                    _sURL = (new StringBuilder(String.valueOf(_sURL))).append("&sj_id=").append(_sj_id).append("&sj_name=").append(_sj_name).append("&sj_dir=").append(_sj_dir).toString();
                else
                    _sURL = (new StringBuilder(String.valueOf(_sURL))).append("?sj_id=").append(_sj_id).append("&sj_name=").append(_sj_name).append("&sj_dir=").append(_sj_dir).toString();
                _sURL = (new StringBuilder(String.valueOf(_sURL))).append(">").toString();
            }
            _sURL = (new StringBuilder(String.valueOf(_sURL))).append(_sj_name).toString();
            if(!isLast && !_sj_url.equals(""))
                _sURL = (new StringBuilder(String.valueOf(_sURL))).append("</a> ").toString();
            _URL = (new StringBuilder(" > ")).append(_sURL).append(_URL).toString();
            return getSubject(Integer.parseInt(_sj_parentid), false);
        } else
        {
            return "0";
        }
    }
    /**
     * 
     * @param dir 栏目CODE
     * @param isLast true
     * @return
     */
    private String getSubject(String dir, boolean isLast)
    {
        ResultSet rs = null;
        Statement stmt = null;
        if(!dir.equals(""))
        {
            try
            {
                stmt = cn.createStatement();
                _sql = (new StringBuilder("select sj_id,sj_parentid,sj_name,sj_dir,sj_url from tb_subject where sj_dir='")).append(dir).append("'").toString();
                rs = stmt.executeQuery(_sql);
                if(rs.next())
                {
                    _sj_id = rs.getString("sj_id");
                    _sj_name = rs.getString("sj_name");
                    _sj_parentid = rs.getString("sj_parentid");
                    _sj_dir = rs.getString("sj_dir");
                    _sj_url = CTools.dealNull(rs.getString("sj_url"));
                    rs.close();
                    stmt.close();
                } else
                {
                    rs.close();
                    stmt.close();
                    return "0";
                }
            }
            catch(Exception e)
            {
                System.out.println("Error! While getting subject list! --by honeyday.");
            }
            if(Messages.getString("rootid").indexOf((new StringBuilder(",")).append(_sj_id).append(",").toString()) != -1)
            {
                if(!isLast)
                    _URL = (new StringBuilder("<A href=")).append(_LanURL).append(" class='three'>").append(_Lan).append("</A>").append(_URL).toString();
                else
                    _URL = (new StringBuilder(String.valueOf(_Lan))).append(_URL).toString();
                return _sj_id;
            }
            String _sURL = "";
            if(!isLast && !_sj_url.equals(""))
            {
                _sURL = (new StringBuilder(String.valueOf(_sURL))).append("<a href=").toString();
                _sURL = (new StringBuilder(String.valueOf(_sURL))).append(_sj_url).toString();
                if(_sj_url.indexOf("?") > 0)
                    _sURL = (new StringBuilder(String.valueOf(_sURL))).append("&sj_id=").append(_sj_id).append("&sj_name=").append(_sj_name).append("&sj_dir=").append(_sj_dir).toString();
                else
                    _sURL = (new StringBuilder(String.valueOf(_sURL))).append("?sj_id=").append(_sj_id).append("&sj_name=").append(_sj_name).append("&sj_dir=").append(_sj_dir).toString();
                _sURL = (new StringBuilder(String.valueOf(_sURL))).append(" class='three' >").toString();
            }
            _sURL = _sj_name;
            if(!isLast && !_sj_url.equals(""))
                _sURL = (new StringBuilder(String.valueOf(_sURL))).append("</a> ").toString();
            _URL = (new StringBuilder(" > <a href='#' class='three'>")).append(_sURL).append("</a>").append(_URL).toString();
            return getSubject(Integer.parseInt(_sj_parentid), false);
        } else
        {
            return "0";
        }
    }

    public NavigateNewBar()
    {
        _URL = "";
        _sql = "";
        _sj_id = "";
        _sj_name = "";
        _sj_parentid = "";
        _sj_dir = "";
        _sj_url = "";
        _Lan = "";
        _LanURL = "";
        _HomeURL = "";
    }

    public NavigateNewBar(CDataCn dCn)
    {
        super(dCn);
        _URL = "";
        _sql = "";
        _sj_id = "";
        _sj_name = "";
        _sj_parentid = "";
        _sj_dir = "";
        _sj_url = "";
        _Lan = "";
        _LanURL = "";
        _HomeURL = "";
    }

    public static void main(String args[])
    {
        NavigateNewBar navigateBar1 = new NavigateNewBar();
        System.out.println(navigateBar1.getURL(111, true, 1));
    }

    private String _URL;
    private String _sql;
    private String _sj_id;
    private String _sj_name;
    private String _sj_parentid;
    private String _sj_dir;
    private String _sj_url;
    private String _Lan;
    private String _LanURL;
    private String _HomeURL;
}
