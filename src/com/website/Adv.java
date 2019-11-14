// FrontEnd Plus GUI for JAD
// DeCompiled : Adv.class

package com.website;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Adv extends CDataImpl
{

    private String _type;
    private String _filename;
    private String _filepath;
    private String _code;
    private String _script;
    private String _form;
    private String _path;
    private String _width;
    private String _height;
    private long _ID;
    private long _id;
    private String _position;
    private String _islink;
    private String _urllink;
    private CDataImpl dImpl;
    private String SqlStr_P;
    private String SqlStr_D;
    private String SqlStr_S;
    private StringBuffer TOutStr;
    private StringBuffer IStr;
    private String LinkStr;
    private String DStr;
    private ResultSet Rs;
    private ResultSet Rs_D;
    private ResultSet Rs_S;
    SimpleDateFormat df;
    Date newdate;
    final String NowDate;

    public Adv(CDataCn dCn)
    {
        super(dCn);
        _type = "";
        _filename = "";
        _filepath = "";
        _code = "";
        _script = "";
        _form = "";
        _path = "";
        _width = "";
        _height = "";
        _position = "";
        _islink = "";
        _urllink = "";
        SqlStr_P = "";
        SqlStr_D = "";
        SqlStr_S = "";
        TOutStr = new StringBuffer("");
        IStr = new StringBuffer("");
        LinkStr = "";
        DStr = "";
        Rs = null;
        Rs_D = null;
        Rs_S = null;
        df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        newdate = new Date();
        NowDate = df.format(newdate);
        dImpl = new CDataImpl(dCn);
    }

    public boolean SetPosition(String POSITION)
    {
        _position = POSITION;
        _path = dImpl.getInitParameter("adv_http_path");
        SqlStr_P = "select p.ap_id,p.ap_width,p.ap_height,f.af_code from tb_advposition p,tb_advform f where p.ap_form = f.af_id and p.ap_code = '" + POSITION + "'";
        Rs = executeQuery(SqlStr_P);
        try
        {
            if(Rs.next())
            {
                _width = Rs.getString("ap_width");
                _height = Rs.getString("ap_height");
                _form = Rs.getString("af_code");
                _ID = Rs.getInt("ap_id");
                return true;
            } else
            {
                return false;
            }
        }
        catch(SQLException ex)
        {
            return false;
        }
    }

    public String LastStr(String Value)
    {
        if(_form.equals("pop"))
            TOutStr = TOutStr.append("<script language='javascript'>window.open('/website/include/pop.jsp?OutStr=" + Value + "','ADV" + _ID + "','Top=100px,Left=200px,Width=" + _width + "px, Height=" + _height + "px,toolbar=no,location=no,derectories=no,status=no,menubar=no,scrollbars=no');</script>");
        else
        if(_form.equals("float"))
        {
            TOutStr = TOutStr.append("<DIV id='img" + _ID + "' style='LEFT: 50px; POSITION: absolute; TOP: 200px;'>");
            TOutStr = TOutStr.append("<TABLE><TR><TD>");
            TOutStr = TOutStr.append(Value);
            TOutStr = TOutStr.append("</TD></TR></TABLE>");
            TOutStr = TOutStr.append("<iframe src='javascript:false' style='position:absolute; visibility:inherit; top:0px; left:0px;z-index:-1; filter=progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0);' border=0 frameBorder=no height=" + _height + " scrolling=no width=" + _width + ">");
            TOutStr = TOutStr.append("</iframe></DIV>");
            TOutStr = TOutStr.append("<script language='javascript'>");
            TOutStr = TOutStr.append("var xPos02=50;");
            TOutStr = TOutStr.append("var yPos02=100;");
            TOutStr = TOutStr.append("var step02=1;");
            TOutStr = TOutStr.append("var delay02=30;");
            TOutStr = TOutStr.append("var height02=0;");
            TOutStr = TOutStr.append("var Hoffset02=0;");
            TOutStr = TOutStr.append("var Woffset02=0;");
            TOutStr = TOutStr.append("var yon02=0;");
            TOutStr = TOutStr.append("var xon02=0;");
            TOutStr = TOutStr.append("var pause02=true;");
            TOutStr = TOutStr.append("var interval02;");
            TOutStr = TOutStr.append("img" + _ID + ".style.top=yPos02;");
            TOutStr = TOutStr.append("function changePos02" + _ID + "(){");
            TOutStr = TOutStr.append("width02=document.body.clientWidth;");
            TOutStr = TOutStr.append("height02=document.body.clientHeight;");
            TOutStr = TOutStr.append("Hoffset02=img" + _ID + ".offsetHeight;");
            TOutStr = TOutStr.append("Woffset02=img" + _ID + ".offsetWidth;");
            TOutStr = TOutStr.append("img" + _ID + ".style.left=xPos02+document.body.scrollLeft;");
            TOutStr = TOutStr.append("img" + _ID + ".style.top=yPos02+document.body.scrollTop;");
            TOutStr = TOutStr.append("if(yon02){");
            TOutStr = TOutStr.append("yPos02=yPos02+step02;}");
            TOutStr = TOutStr.append("else{");
            TOutStr = TOutStr.append("yPos02=yPos02-step02;}");
            TOutStr = TOutStr.append("if(yPos02<0){");
            TOutStr = TOutStr.append("yon02=1;yPos02=0;");
            TOutStr = TOutStr.append("}");
            TOutStr = TOutStr.append("if(yPos02>=(height02-Hoffset02)){");
            TOutStr = TOutStr.append("yon02=0;yPos02=(height02-Hoffset02);");
            TOutStr = TOutStr.append("}");
            TOutStr = TOutStr.append("if(xon02){");
            TOutStr = TOutStr.append("xPos02=xPos02+step02;");
            TOutStr = TOutStr.append("}");
            TOutStr = TOutStr.append("else{");
            TOutStr = TOutStr.append("xPos02=xPos02-step02;");
            TOutStr = TOutStr.append("}");
            TOutStr = TOutStr.append("if(xPos02<0){");
            TOutStr = TOutStr.append("xon02=1;");
            TOutStr = TOutStr.append("xPos02=0;");
            TOutStr = TOutStr.append("}");
            TOutStr = TOutStr.append("if(xPos02>=(width02-Woffset02)){");
            TOutStr = TOutStr.append("xon02=0;");
            TOutStr = TOutStr.append("xPos02=(width02-Woffset02);");
            TOutStr = TOutStr.append("}");
            TOutStr = TOutStr.append("}");
            TOutStr = TOutStr.append("function start" + _ID + "() {");
            TOutStr = TOutStr.append("img" + _ID + ".visibility='visible';");
            TOutStr = TOutStr.append("interval02 = setInterval('changePos02" + _ID + "()', delay02);");
            TOutStr = TOutStr.append("}");
            TOutStr = TOutStr.append("start" + _ID + "();");
            TOutStr = TOutStr.append("</script>");
        } else
        {
            TOutStr = TOutStr.append(Value);
        }
        return TOutStr.toString();
    }

    public String IsType()
    {
        if(_type.equals("flash"))
        {
            IStr = IStr.append("<object classid=clsid:d27cdb6e-ae6d-11cf-96b8-444553540000 codebase=http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab version=7,0,0,0 width=" + _width + " height=" + _height + " id=bannerindex align=middle>");
            IStr = IStr.append("<param name=allowScriptAccess value=sameDomain />");
            IStr = IStr.append("<param name=movie value=" + _path + _filepath + "/" + _filename + " />");
            IStr = IStr.append("<param name=quality value=high />");
            IStr = IStr.append("<param name=wmode value=transparent />");
            IStr = IStr.append("<param name=bgcolor value=#ffffff />");
            IStr = IStr.append("<embed src=pop_fla.swf quality=high wmode=transparent bgcolor=#ffffff name=bannerindex align=middle allowScriptAccess=sameDomain type=application/x-shockwave-flash pluginspage=http://www.macromedia.com/go/getflashplayer />");
            IStr = IStr.append("</object>");
        } else
        if(_type.equals("gif"))
            IStr = IStr.append("<img width=" + _width + " height=" + _height + " border=0 src=" + _path + _filepath + "/" + _filename + ">");
        return IStr.toString();
    }

    public String Islink(String Value)
    {
        switch(Integer.parseInt(_islink))
        {
        case 0: // '\0'
            LinkStr = Value;
            break;

        case 1: // '\001'
            LinkStr = "<a href=\"http://www.xh.sh.cn/website/ADV/ShowD.jsp?aid=" + _id + "\" target=\"_blank\">" + Value + "</a>";
            break;

        case 2: // '\002'
            LinkStr = "<a href='" + _urllink + "' target='_blank'>" + Value + "</a>";
            break;
        }
        return LinkStr;
    }

    public String ShowDefault()
    {
        SqlStr_D = "select a.ap_filename,a.ap_filepath,t.at_code from tb_advposition a,tb_advtype t where a.ap_display = 1 and a.ap_type = t.at_id and a.ap_code='" + _position + "'";
        Rs_D = executeQuery(SqlStr_D);
        try
        {
            if(Rs_D.next())
            {
                _filename = Rs_D.getString("ap_filename");
                _filepath = Rs_D.getString("ap_filepath");
                _type = Rs_D.getString("at_code");
                DStr = IsType();
                DStr = LastStr(DStr);
            } else
            {
                DStr = "";
            }
        }
        catch(SQLException ex)
        {
            dImpl.raise(ex, "\u663E\u793A\u7684\u65F6\u5019\u51FA\u73B0\u5F02\u5E38\u9519\u8BEF", "ShowDefault()");
            DStr = "\u5E7F\u544A\u663E\u793A\u5931\u8D25";
        }
        return DStr;
    }

    public boolean GetAdvInfoByDay(int ai_id)
    {
        return false;
    }

    public boolean GetAdvInfoByWeek()
    {
        return false;
    }

    public boolean GetAdvInfoByMonth()
    {
        return false;
    }

    public boolean GetAdvInfoByYear()
    {
        return false;
    }

    public String ShowAdv(String Position)
    {
        return ShowAdv(Position, "0");
    }

    public String ShowAdv(String Position, String sj_id)
    {
        SetPosition(Position);
        String OutStr = "";
        try
        {
            SqlStr_S = "select a.ai_id,a.ai_type,a.ai_filename,a.ai_filepath,a.ai_islink,ai_urllink,t.at_code from tb_advinfo a,tb_advtype t where to_date('" + NowDate + "','yyyy-MM-dd hh24:mi:ss') >= to_date(to_char(a.ai_start_time,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd hh24:mi:ss') and to_date('" + NowDate + "','yyyy-MM-dd hh24:mi:ss') <= to_date(to_char(a.ai_end_time,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd hh24:mi:ss') and a.ai_filename is not null and a.ai_isok=1 and a.ai_type=t.at_id and a.ai_position='" + _ID + "' order by a.ai_pri desc";
            Rs_S = executeQuery(SqlStr_S);
            if(Rs_S.next())
            {
                _id = Rs_S.getLong("ai_id");
                _filename = Rs_S.getString("ai_filename");
                _filepath = Rs_S.getString("ai_filepath");
                _type = Rs_S.getString("at_code");
                _islink = Rs_S.getString("ai_islink");
                _urllink = Rs_S.getString("ai_urllink");
                _script = dImpl.getClobValue("tb_advinfo", "ai_id", _id, "ai_script");
                OutStr = _script + LastStr(Islink(IsType()));
            } else
            {
                OutStr = ShowDefault();
            }
        }
        catch(Exception ex)
        {
            dImpl.raise(ex, "\u663E\u793A\u7684\u65F6\u5019\u51FA\u73B0\u5F02\u5E38\u9519\u8BEF", "ShowAdv(String POSITION)");
            OutStr = "\u5E7F\u544A\u663E\u793A\u5931\u8D25";
        }
        return OutStr;
    }

    public static void main(String args[])
    {
        CDataCn dCn = new CDataCn();
        Adv a = new Adv(dCn);
        System.out.println(a.ShowAdv("home_index"));
        System.out.println(a.NowDate);
    }
}
