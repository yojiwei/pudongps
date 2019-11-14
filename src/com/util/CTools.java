package com.util;

import java.io.*;
import java.util.*;
import java.sql.*;
import oracle.sql.*;
import java.lang.*;
import com.component.database.*;

/**
 * <p>
 * Title:
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2002
 * </p>
 * <p>
 * Company: beyondbit
 * </p>
 *
 * @author along0 tlboy
 * @version 1.0
 */

public class CTools implements CWordLib {

	public static final int TRIM = 1;

	public static final int NOTRIM = 2;

	public CTools() {
	}

	/**
	 * 解决中文问题，ISO转为GBK编码，用于POST，GET方式取得数据
	 *
	 * @param str
	 *            原始文本
	 * @return 转码后的文本
	 */
	public static String iso2gb(String str) {

		if (str != null) {
			byte[] tmpbyte = null;
			try {
				tmpbyte = str.getBytes("ISO8859_1");
			} catch (UnsupportedEncodingException e) {
				System.out.println("Error: Method: dbconn.iso2gb :"
						+ e.getMessage());
			}
			try {
				str = new String(tmpbyte, "GBK");
			} catch (UnsupportedEncodingException e) {
				System.out.println("Error: Method: dbconn.gb2iso :"
						+ e.getMessage());
			}
		}

		return str;

	}

	/**
	 * 解决中文问题，GBK转ISO编码，用于从数据库中存入转码
	 *
	 * @param str
	 *            原始文本
	 * @return 转换后文本
	 */
	public static String gb2iso(String str) {

		if (str != null) {
			byte[] tmpbyte = null;
			try {
				tmpbyte = str.getBytes("GBK");
			} catch (UnsupportedEncodingException e) {
				System.out.println("Error: Method: dbconn.gb2iso :"
						+ e.getMessage());
			}
			try {
				str = new String(tmpbyte, "ISO8859_1");
			} catch (UnsupportedEncodingException e) {
				System.out.println("Error: Method: dbconn.gb2iso :"
						+ e.getMessage());
			}
		} else {
			str = "";
		}

		return str;
	}

	/**
	 * 处理空字符
	 *
	 * @param str
	 * @return
	 */
	public static String dealNull(Object str) {
		if (str == null)
			return "";
		if (str.equals(""))
			return "";
		return str.toString();
	}

	public static String dealNull(Object str, String defaultValue) {
		if (str == null)
			return defaultValue;
		if (str.equals(""))
			return defaultValue;
		return str.toString();
	}

	/**
	 * 字符处理函数
	 *
	 * @param str
	 * @return
	 */
	public static String dealString(String str) {
		return iso2gb(dealNull(str));
	}

	/**
	 * 字符处理函数
	 *
	 * @param obj
	 * @return
	 */
	public static String dealString(Object obj) {
		if (obj == null) {
			return "";
		} else {
			return iso2gb(dealNull(obj));
		}

	}

	/**
	 * 字符处理函数
	 *
	 * @param obj
	 * @return
	 */
	public static String dealNumber(Object obj) {
		if (obj == null) {
			return "0";
		} else {
			String str = obj.toString();
			return dealNumber(str);
		}

	}

	/**
	 * 字符处理函数
	 *
	 * @param str
	 * @return
	 */
	public static String dealString(String str, int sType) {
		switch (sType) {
		case TRIM: {
			return dealString(str).trim();
		}

		case NOTRIM: {
			return dealString(str);
		}

		default: {
			return dealString(str).trim();
		}
		}
	}

	/**
	 *
	 * @param str
	 * @return
	 */
	public static String dealUploadString(String str) {
		return dealNull(str);
	}

	/**
	 * 去除字符串前后指定的字符串
	 *
	 * @param str1
	 *            原始文本
	 * @param str2
	 *            指定的字符串
	 * @return 去除字符串前后指定的字符串
	 */
	public static String trimEx(String str1, String str2) {
		if (str1 == null)
			return "";
		if (str1.equals(""))
			return "";

		while (str1.substring(0, str2.length()).equals(str2)) {
			str1 = str1.substring(str2.length());
			if (str1.equals(""))
				return "";
		}
		// System.out.println(str1);
		// System.out.println(str2);
		// if (str1.length() <= str2.length() ) return str1;
		str1 = "00000" + str1;
		while (str1.substring(str1.length() - str2.length()).equals(str2)) {
			str1 = str1.substring(0, str1.length() - str2.length());
			// System.out.println(str1);
			if (str1.equals(""))
				return "";
		}

		str1 = str1.substring(5);
		return str1;
	}

	/**
	 * 分割字串
	 *
	 * @param source
	 *            原始字符
	 * @param delim
	 *            分割符
	 * @return 字符串数组
	 */
	/*
	 * public static String[] split(String source,String delim){ int i = 0; int
	 * l = 0; if (source == null || delim == null) return new String[0]; if
	 * (source.equals("") || delim.equals("")) return new String[0];
	 *
	 * StringTokenizer st = new StringTokenizer(source,delim); l =
	 * st.countTokens(); String[] s = new String[l]; while(st.hasMoreTokens()){
	 * s[i++] = st.nextToken(); } return s; }
	 */
	public static String[] split(String source, String div) {
		int arynum = 0, intIdx = 0, intIdex = 0, div_length = div.length();
		if (source.compareTo("") != 0) {
			if (source.indexOf(div) != -1) {
				intIdx = source.indexOf(div);
				for (int intCount = 1;; intCount++) {
					if (source.indexOf(div, intIdx + div_length) != -1) {
						intIdx = source.indexOf(div, intIdx + div_length);
						arynum = intCount;
					} else {
						arynum += 2;
						break;
					}
				}
			} else
				arynum = 1;
		} else
			arynum = 0;

		intIdx = 0;
		intIdex = 0;
		String[] returnStr = new String[arynum];

		if (source.compareTo("") != 0) {
			if (source.indexOf(div) != -1) {
				intIdx = (int) source.indexOf(div);
				returnStr[0] = (String) source.substring(0, intIdx);
				for (int intCount = 1;; intCount++) {
					if (source.indexOf(div, intIdx + div_length) != -1) {
						intIdex = (int) source
								.indexOf(div, intIdx + div_length);
						returnStr[intCount] = (String) source.substring(intIdx
								+ div_length, intIdex);
						intIdx = (int) source.indexOf(div, intIdx + div_length);
					} else {
						returnStr[intCount] = (String) source.substring(intIdx
								+ div_length, source.length());
						break;
					}
				}
			} else {
				returnStr[0] = (String) source.substring(0, source.length());
				return returnStr;
			}
		} else {
			return returnStr;
		}
		return returnStr;
	}

	/**
	 * 字符串替换函数
	 *
	 * @param str
	 *            原始字符串
	 * @param substr
	 *            要替换的字符
	 * @param restr
	 *            替换后的字符
	 * @return 替换完成的字符串
	 */
	public static String replace(String str, String substr, String restr) {
		String[] tmp = split(str, substr);
		String returnstr = null;
		if (tmp.length != 0) {
			returnstr = tmp[0];
			for (int i = 0; i < tmp.length - 1; i++)
				returnstr = dealNull(returnstr) + restr + tmp[i + 1];
		}
		return dealNull(returnstr);
	}

	/**
	 * 登陆时单引号字符串替换函数
	 *
	 * @param str
	 *            原始字符串
	 * @return 替换完成的字符串
	 */
	public static String replacequote(String str) {
		return dealNull(replace(str, "'", "~"));

	}

	/**
	 * 取消Html标记
	 *
	 * @param txt
	 *            原始文本
	 * @return 取消Html标记后的文本
	 */
	public static String htmlEncode(String txt) {
		if (txt != null) {
			txt = replace(txt, "&", "&amp;");
			txt = replace(txt, "&amp;amp;", "&amp;");
			txt = replace(txt, "&amp;quot;", "&quot;");
			txt = replace(txt, "\"", "&quot;");
			txt = replace(txt, "&amp;lt;", "&lt;");
			txt = replace(txt, "<", "&lt;");
			txt = replace(txt, "&amp;gt;", "&gt;");
			txt = replace(txt, ">", "&gt;");
			txt = replace(txt, "&amp;nbsp;", "&nbsp;");
			// txt = replace(txt," ","&nbsp;");
		}
		return txt;
	}

	/**
	 * 返回Html标记
	 *
	 * @param txt
	 *            原始文本
	 * @return 返回Html后的文本
	 */
	public static String unHtmlEncode(String txt) {
		if (txt != null) {
			txt = replace(txt, "&amp;", "&");
			txt = replace(txt, "&quot;", "\"");
			txt = replace(txt, "&lt;", "<");
			txt = replace(txt, "&gt;", ">");
			txt = replace(txt, "&nbsp;", " ");
		}
		return txt;
	}
	/**
	 * 
	 * @param txt
	 * @return
	 */
	public static String unHtmlEncodekg(String txt) {
		if (txt != null) {
			txt = replace(txt, "&amp;", "&");
			txt = replace(txt, "&quot;", "\"");
			txt = replace(txt, "&lt;", "<");
			txt = replace(txt, "&gt;", ">");
		}
		return txt;
	}

	/**
	 * 处理数字型的字符串
	 *
	 * @param strNumber
	 * @return
	 */
	public static String dealNumber(String strNumber) {
		if (strNumber == null || strNumber.equals(""))
			strNumber = "0";
		return strNumber;
	}

	public static String ClobToString(Clob clob)// Clob转换成String
	{
		String result = "";
		try {
			// get character stream to retrieve clob data

			if (clob == null) {
			} else {
				Reader instream = clob.getCharacterStream();

				// create temporary buffer for read
				char[] buffer = new char[10];
				// length of characters read
				int length = 0;
				// fetch data
				while ((length = instream.read(buffer)) != -1) {
					for (int i = 0; i < length; i++)
						result = result + buffer[i];

				}
				// Close input stream
				instream.close();
			}
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
		return result;
	}

	public static String randomString(int j) {
		String serial[] = { "a", "b", "c", "d", "e", "f", "g", "h", "i", "j",
				"k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v",
				"w", "x", "y", "z" };
		String serialnum = "";
		for (int i = 0; i < j; i++) {
			int temp;
			temp = (int) (java.lang.Math.random() * 26);
			serialnum = serialnum + serial[temp];
		}
		return serialnum;
	}

	public static String setPublishFile(String strPublishFilePath,
			String strPublishFileName, String incontent) {
		try {
			byte bict[] = new byte[incontent.length()];
			bict = incontent.getBytes();

			File dir2 = new File(strPublishFilePath);
			dir2.mkdirs();

			File filein = new File(strPublishFilePath + strPublishFileName);
			filein.createNewFile();

			FileOutputStream fouts = new FileOutputStream(filein);
			fouts.write(bict);

			fouts.close();
			return "1";
		} catch (Exception ex) {
			// raise(ex,"发布文件时出错！","CPublishFile");
			System.out.println("error :" + ex.toString());
			return "";
		}
	}

	/**
	 * 删除相同的值
	 *
	 * @param value
	 * @return String[]
	 * @roseuid 3DFC355A02D7
	 */
	public static final String[] clearSameValue(String[] value) {
		if (value == null)
			return null;
		if (value.length == 0)
			return null;
		ArrayList l = new ArrayList();

		for (int i = 0; i < value.length; i++) {
			if (!value[i].equals("")) {
				if (!l.contains(value[i])) {
					l.add(value[i]);
				}
			}
		}
		String[] _ids = new String[l.size()];
		for (int i = 0; i < l.size(); i++) {
			_ids[i] = l.get(i).toString();
		}
		return _ids;
	}

	public static final String clearSameValue(String str, String div) {
		StringBuffer _strBuf = new StringBuffer("");
		String _ids = "";
		String[] _aIds = split(str, div);
		_aIds = clearSameValue(_aIds);

		for (int i = 0; i < _aIds.length; i++) {
			_strBuf.append("," + _aIds[i]);
		}
		if (_strBuf.length() > 0) {
			_ids = _strBuf.toString() + ",";
		}
		return _ids;
	}

	public static String[] splite(String str, String sp) {
		StringTokenizer token = new StringTokenizer(str, sp);
		String[] result = new String[token.countTokens()];
		int i = 0;
		while (token.hasMoreTokens()) {
			result[i] = token.nextToken();
			i++;
		}
		return result;
	}

	/**
	 * 将GB2312中文字符转换成Big5中文字符
	 *
	 * @param str
	 *            待转换GB2312中文字符串
	 * @return String Big5中文字符
	 */
	static String gb2big5(String str) {

		StringBuffer buffer = new StringBuffer();

		try {
			StringReader sr = new StringReader(str);
			Reader in = new BufferedReader(sr);
			int ch;
			while ((ch = in.read()) > -1) {
				if (_sGB.indexOf(ch) != -1) {
					buffer.append((char) _tGB.charAt(_sGB.indexOf(ch)));
				} else {
					buffer.append((char) ch);
				}
			}
			in.close();

			return new String(buffer.toString().getBytes("Big5"));
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}

	}

	public static String tableStr2Str(String source){
		String target = "";
		if(!"".equals(source)){
			StringTokenizer st = new StringTokenizer(source,"");
			  while(st.hasMoreTokens()){
				  target += "'" + st.nextToken() + "',";
			  }
			  target = target.substring(0,target.length()-1);
		}
		return target;
	}

	public static String Result2Str(Vector rs,String name){
		String target = "";
		Hashtable table = null;
		try{
			if(rs != null){
				for(int i = 0;i < rs.size();i++){
					table = (Hashtable)rs.get(i);
					target += table.get(name) + ",";
				}
				target = target.substring(0,target.length()-1);
			}
		}catch(Exception ex){
			System.out.println("Exception :Result2Str " + ex.getMessage());
		}
		return target;
	}














  /**
   * 清除数组中的重复数据
   * @param srcArr 包含重复数据的数组
   * @return 整理后的数组
   */
  public static Object[] clearRepeat(Object[] srcArr)
  {
    HashMap objHM=new HashMap();
    for(int i=0;i<srcArr.length;i++)
      objHM.put(srcArr[i],"");

    Set objSet=objHM.keySet();
    Object[] _arr=new Object[objSet.size()];
    objSet.toArray(_arr);

    return _arr;
  }

  /**
   * 显示进程条
   * @return 进度条的html代码
   */
  public static final String ShowProcessBar()
  {
    return ShowProcessBar("");
  }

  /**
   * 显示进程条
   * @param Msg 显示的信息
   * @return 进度条的html代码
   */
  public static final String ShowProcessBar(String Msg)
  {
    String mStr="";
    if(Msg.equals(""))
      Msg = "正在保存数据，请b稍候...";

    mStr = "<form name=loading>\r\n" +
           "<div align=center><br><p>\r\n" +
           Msg + "<br><font color=#0000ff>\r\n" +
           "<input name=chart size=45 style='background-color: white; color: #888888; font-family: Arial; font-weight: bolder; border-style: none; padding: 0px'>\r\n" +
           "<br>\r\n" +
           "<input name=percent size=53 style='color: #0000FF; text-align: center; border-style: none; border-width: medium'>\r\n" +
           "</font></div><br>\r\n" +
           "</form>\r\n" +
           "<script LANGUAGE=\"javascript\">\r\n" +
           "  <!--\r\n" +
           "  var m_bar = 0\r\n" +
           "  var Line = \"|\"\r\n" +
           "  var amount = \"\"\r\n" +
           "  count()\r\n" +
           "  function count(){\r\n" +
           "  m_bar = m_bar + 1\r\n" +
           "  amount = amount + Line\r\n" +
           "  document.loading.chart.value = amount\r\n" +
           "  document.loading.percent.value = m_bar + \"%\"\r\n" +
           "  if (m_bar<100)\r\n" +
           "  {setTimeout(\"count()\",50);}\r\n" +
           "  else\r\n" +
           "  {window.location = \"#\";}\r\n" +
           "  }//-->\r\n" +
           "  </script>";

    return mStr;
  }


  /**
   * 从str1里面去掉str2里面重复的数据
   * @param str1 要进行处理的字符串
   * @param str2 需要去掉的字符串
   * @return 处理后的字符串
   */
  public static final String clearSameValues(String str1,String str2)
  {
    String str="";
    String[] arrStr1=split(str1,",");
    String[] arrStr2=split(str2,",");
    for(int i=0;i<arrStr1.length;i++)
    {
      boolean bFounded=false;
      for(int j=0;j<arrStr2.length;j++)
      {
        if(arrStr1[i].equals(arrStr2[j])) bFounded=true;
      }
      if(!bFounded && !arrStr1[i].equals("")) str+=arrStr1[i]+",";
    }

    str=trimEx(str,",");
    return str;
  }

  /**
   * 判断指定的对象是否为空或者为字符串的空
   * @param obj 进行处理的对象
   * @return 如果为空返回True,否则返回false
   */
  public static final boolean isEmpty(Object obj)
  {
    if (obj == null) return true;
    if (obj.equals("") ) return true;
    return false;
  }

  /**
   * 格式化显示数字
   * @param str
   * @param iPointPosition
   * @return
   */
  public static String FormatNumber(String str,int iPointPosition)
  {
    if (!str.equals(""))
    {
      if (str.indexOf(".")==-1)
      {
        str=str+".00";
      }
      else
      {
        int r = str.indexOf(".")+1;
        String rstr = str.substring(r);
        int l = rstr.length();
          for (int k=0;k<iPointPosition-l;k++)
          {
            rstr =rstr+"0";
          }
          str = str.substring(0,r)+rstr;

      }
    }
    else
    {
      str="0.00";
    }
    return str;
  }

  /**
   * 格式化显示数字 123.00格式
   * @param str 包含数字的字符串
   * @return
   */
  public static String FormatNumber(String str)
  {
    java.lang.Double dNumber = new java.lang.Double(str);
    return FormatNumber(dNumber.doubleValue());
  }

  public static String FormatNumber(double d){
    java.text.DecimalFormat df = new java.text.DecimalFormat("#.##");
    return df.format(d);
  }

  public static String FormatNumber(float f)
  {
    java.text.DecimalFormat df = new java.text.DecimalFormat("#.##");
    return df.format(f);
  }

  /**
   * 获取字符串的左边n位字符
   * @param str 进行处理的字符串
   * @param num 要获取的字符串位数，从1开始
   * @return
   */
  public static String left(String str,int num)
  {
    return Left(str,num);
  }

  /**
   * 获取字符串的右边n位字符
   * @param str 进行处理的字符串
   * @param num 要获取的字符串位数，从1开始
   * @return
   */
  public static String right(String str,int num)
  {
    return Right(str,num);
  }

  /**
   * 获取字符串的右边n位字符
   * @param str 进行处理的字符串
   * @param num 要获取的字符串位数，从1开始
   * @return
   */
  public static String Right(String str,int len)
  {
    if(str.length()<=len)
      return str;
    else
      return str.substring(str.length()-len,str.length());
  }

  /**
   * 获取字符串的左边n位字符
   * @param str 进行处理的字符串
   * @param num 要获取的字符串位数，从1开始
   * @return
   */
  public static String Left(String str,int len)
  {
    if(str.length()<=len)
      return str;
    else
      return str.substring(0,len);
  }

  /**
   * 获取指定的两个字符串之间的匹配的第一个字符串,即搜索字符串中重复出现的特征字串 如：MidStr("00!!!123---56","!!!","---") 返回“123”
   * @param str 需要进行处理的字符串
   * @param strL 左面的搜索标记
   * @param strR 右面的搜索标记
   * @return 搜索到的匹配字符
   */
  public static String MidStr(String str,String strL,String strR)
  {
    int pos1=str.indexOf(strL);
    int pos2=str.indexOf(strR);
    if(pos1==-1 || pos2==-1) return "";

    return split(split(str,strL)[1],strR)[0];
  }

  /**
   * 获取指定的两个字符串之间的匹配的字符串数组 如：MidStr("00!!!123---56!!!456---","!!!","---") 返回数组包括“123”,"456"
   * @param str 需要进行处理的字符串
   * @param strL 左面的搜索标记
   * @param strR 右面的搜索标记
   * @return 搜索到的匹配字符串数组
   */
  public static String[] MidStrArr(String str,String strL,String strR)
  {
    ArrayList _arr=new ArrayList();
    int pos1=str.indexOf(strL);
    int pos2=str.indexOf(strR);
    if(pos1==-1 || pos2==-1) return null;
    String[] arrTmp=split(str,strL);
    for(int pos=1;pos<arrTmp.length;pos++)
    {
      String strTmp=arrTmp[pos];
      if(strTmp.indexOf(strR)!=-1)
      {
        strTmp=split(strTmp,strR)[0];
        _arr.add(strTmp);
      }
    }
    String[] res=null;
    res=new String[_arr.size()];
    _arr.toArray(res);
    return res;
  }

  /**
   * 判断CheckBox RadioBox Select控件是否选中，如 <input type=checkbox value=xx <%=check(value,"xx",true)%>>
   * @param Value1 该控件当前的值
   * @param Name 该控件固有的值
   * @param isRadio True表示该控件是CheckBox RadioBox，False表示该控件是Select
   * @return 如果是CheckBox RadioBox，若为选中状态，返回"checked"，Select控件返回"selected"
   */
  public static String check(String Value1,String Name,boolean isRadio)
  {
    String num=replace(""+Name," ","");
    String value[]=split(replace(""+Value1," ","")+",",",");
    for (int count=0 ;count< value.length;count++)
    {
            if(!trimEx(value[count]," ").equals(""))
            {
                    if ((""+num).equals(value[count]))
                    {
                            return isRadio?"checked":"selected";
                    }
            }
    }
    return "";
  }


  /**
   * 日期控件 显示？年？月？日 的格式，？处是下拉列表框
   * @param Name 控件名称
   * @param Value 控件当前的日期，便于系统处理默认日期的状态
   * @param type 是否显示日，true显示日下拉框
   * @return 控件的html代码
   */
  public static String SetDate(String Name,String Value1,boolean showDay)
  {
    if(dealNull(Value1).equals(""))Value1=CDate.getNowTime();
    java.util.Date Value=CDate.toDate(Value1);
    String html="";
    html+="<select name="+Name+"_Year>";
    for(int i=-10;i<50;i++)
    {
      html+="<option "+check(String.valueOf(CDate.getYear(Value)),String.valueOf((CDate.getNowYear()-i)),false)+" value="+(CDate.getNowYear()-i)+">"+(CDate.getNowYear()-i)+"</option>";
    }
    html+="</select>年";

    html+="<select name="+Name+"_Month>";
    for(int i=1;i<=12;i++)
    {
      html+="<option "+check(String.valueOf(CDate.getMonth(Value)),String.valueOf(i),false)+" value="+i+">"+i+"</option>";
    }
    html+="</select>月";


    html+="<span style='"+(showDay?"":"display:none")+"'><select name="+Name+"_Day>";
    for(int i=1;i<=31;i++)
    {
      html+="<option "+check(String.valueOf(CDate.getDay(Value)),String.valueOf(i),false)+" value="+i+">"+i+"</option>";
    }
    html+="</select>日</span>";

    return html;
  }

  /**
   * 日期控件 显示？年？月？日 的格式，？处是下拉列表框
   * @param Name 控件名称
   * @param Value 控件当前的日期，便于系统处理默认日期的状态
   * @return 控件的html代码
   */
  public static String SetDate(String Name,String Value)
  {
    return SetDate(Name,Value,true);
  }

  public static String SetRadio(String Name,String Value,String Sorts)
  {
    String html="";
    String[] Datas=split(Sorts,",");
    if (Value.equals("")) Value=Datas[0];
    for (int i=0;i<Datas.length;i++)
      html+=""+Datas[i]+"<input type=\"radio\" class=\"radio\" "+check(Value,Datas[i])+"  name=\""+Name+"\" value=\""+Datas[i]+"\">&nbsp;";
    return html;
  }

  public static String SetSort(String Name,String Value,String Sorts)
  {
    String html="";
    html+="<SELECT name="+Name+" id="+Name+">";
    if(Value.equals(""))Value="--请选择--";
    if (Value.equals("--请选择--")) html+= "<option value=\"\">--请选择--</option>";

    String[] Datas=split(Sorts,",");
    for (int i=0;i<Datas.length;i++)
      html+="<option "+check(Value,Datas[i],false)+" value=\""+Datas[i]+"\">"+Datas[i]+"</option>";
    html+="</SELECT>";
    return html;
  }


  public static String check(String Value1,String Name)
  {
    return check(Value1,Name,true);
  }

  public static String toHtml(String s)
  {
    s=""+s;
    String toHtml=replace(replace(s," ","&nbsp;"),"\r\n","<br>");
    return toHtml;
  }

  public static String getDate(String s)
  {
    return split(s+" "," ")[0];
  }

  public static String getDateEx(String s)
  {
    return split(s+".",".")[0];
  }

  public static String trimTitle(String s,int l)
  {
    return (s.length()<=l)?s:left(s,l)+"..";
  }


  public static String setSortCommon(String FormName,String BigSort,String SmallSort,String Code)
  {
    String html="",Js="",sql="";

    CDataCn dCn=new CDataCn();
    CDataImpl dImpl = new CDataImpl(dCn); //新建数据接口对象

    html+="<select name=\"BigSort\" onchange=\"changeSort1();\" class=\"input9\">";
    html+="            <option value=\"\">请选择类型</option>";
    Js="";
    String JsStr="";
    String UpperId="";
    sql="select dD_ID from tb_datatdictionary where dD_CODE ='"+Code+"'";
    ResultSet rs=dImpl.executeQuery(sql);
    try
    {
      if(rs.next())
      {
        UpperId=rs.getString("dD_ID");
      }
    }
    catch (SQLException ex)
    {
      return "系统错误[1]，创建列表控件失败";
    }

    if(UpperId.equals(""))return "系统错误，创建列表控件失败";

    dImpl.closeStmt();
    dImpl = new CDataImpl(dCn); //新建数据接口对象
    sql="select * from tb_datatdictionary where dD_PARENTID="+UpperId+" order by dD_SEQUENCE,dD_NAME";
    rs=dImpl.executeQuery(sql);
    int index=0;

    try
    {
      while(rs.next())
      {
        index++;
        String name=rs.getString("dD_NAME");
        String code=rs.getString("dD_Code");

        JsStr=name+",";
        sql="select * from tb_datatdictionary where dD_PARENTID="+rs.getString("dD_ID")+" order by dD_SEQUENCE,dD_NAME";
        CDataImpl dImpl1 = new CDataImpl(dCn); //新建数据接口对象
        ResultSet rs1=dImpl1.executeQuery(sql);
        while(rs1.next())
        {
          String name1=rs1.getString("dD_NAME");
          JsStr=JsStr + name1+",";
        }
        rs1.close();
        dImpl1.closeStmt();

        Js+= "CommonSort.push(\""+trimEx(JsStr,",")+"\");\r\n";

        html+="          <option  value=\""+name+"\" code=\""+code+"\" "+check(name,BigSort,false)+">"+name+"</option>\r\n";
      }
    }
    catch (SQLException ex)
    {
      return "系统错误[2]，创建列表控件失败";
    }

    html+="          </select>\r\n";
    html+="            <select name=\"SmallSort\" class=\"input9\">\r\n";
    html+="              <option value=\"\">请选择类型</option>\r\n";
    html+="           </select>\r\n";

    html+="<SCRIPT LANGUAGE=javascript>\r\n";
    html+="<!--\r\n";
    html+="        var CommonSort=new Array();\r\n";
    html+=Js+"\r\n";
    html+="        function changeSort1()\r\n";
    html+="        {\r\n";
    html+="                var objBig="+FormName+".BigSort;\r\n";
    html+="                var objSmall="+FormName+".SmallSort;\r\n";
    html+="                if (objBig.value==\"\")\r\n";
    html+="                {";
    html+="                        alert(\"请先选择大分类\");\r\n";
    html+="                        return;\r\n";
    html+="                }\r\n";
    html+="                document."+FormName+".SmallSort.length=1;\r\n";
    html+="                document."+FormName+".SmallSort.options[0].text=\"请选择类型\";\r\n";
    html+="                document."+FormName+".SmallSort.options[0].value=\"\";\r\n";
    html+="                for(var i=0;i<CommonSort.length;i++)\r\n";
    html+="                {\r\n";
    html+="                        var va=CommonSort[i].split(\",\");\r\n";
    html+="                        if (va[0]==objBig.value)\r\n";
    html+="                        {\r\n";
    html+="                                for(var j=1;j<va.length;j++)\r\n";
    html+="                                {\r\n";
    html+="                                        if (va[j].length>0)\r\n";
    html+="                                        {\r\n";
    html+="                                                document."+FormName+".SmallSort.length++;\r\n";
    html+="                                                document."+FormName+".SmallSort.options[j].text=va[j];\r\n";
    html+="                                                document."+FormName+".SmallSort.options[j].value=va[j];\r\n";
    html+="                                        }\r\n";
    html+="                    }\r\n";
    html+="                        }\r\n";
    html+="                }\r\n";
    html+="        }\r\n";
    html+="//-->\r\n";
    html+="</SCRIPT>\r\n";
    html+="<SCRIPT LANGUAGE=javascript>\r\n";
    html+="<!--\r\n";
    if (!BigSort.equals("")){
    html+="        changeSort1();\r\n";
    }
    if (!SmallSort.equals("")){
    html+="                var objSmall="+FormName+".SmallSort;\r\n";
    html+="                for(var i=0;i<objSmall.length;i++)\r\n";
    html+="                {\r\n";
    html+="                        if (objSmall.options[i].text==\""+SmallSort+"\") objSmall.selectedIndex=i;\r\n";
    html+="                }\r\n";
    }
    html+="//-->\r\n";
    html+="</SCRIPT>\r\n";
    return html;
  }


  public static String[] getSortByCode(String Code)
  {
    String[] Sorts=null;
    ArrayList arr=new ArrayList();
    CDataCn dCn=new CDataCn();

    try
    {
      String sql="select MD_NAME from metadir where MD_PARENTID in (select md_id from metadir where md_name='"+Code+"') order by MD_SEQUENCE,MD_NAME";
      CDataImpl dImpl1 = new CDataImpl(dCn); //新建数据接口对象
      ResultSet rs1=dImpl1.executeQuery(sql);
      while(rs1.next())
      {
        String name1=rs1.getString("MD_NAME");
        arr.add(name1);
      }
      if(arr!=null)
      {
        Sorts=new String[arr.size()];
        arr.toArray(Sorts);
      }
      rs1.close();
      dImpl1.closeStmt();
      dCn.closeCn();
    }
    catch (SQLException ex)
    {
    }

    return Sorts;
  }


  public static final String setToolBar(String op,String table,String info)
  {
    String html="";
    html+="							<img src=\"../../skin/skin1/images/split.gif\" align=\"middle\" border=\"0\"> \r\n";
    html+="							<input type=\"checkbox\" id=\"CheckList1\" title=\"选中所有的目录。\" style=\"cursor:hand\" value=\"全选\" onclick=\"SelectAll(checked);\">			   \r\n";
    html+="							<label for=\"CheckList1\" class=\"hand\" title=\"选中所有的目录。\">全选</label> 	 \r\n";
    if (op.indexOf("verify")!=-1){
      html+="		  					<img src=\"../../skin/skin1/images/split.gif\" align=\"middle\" border=\"0\"> 							  \r\n";
      html+="<select  onchange=\"CheckOperate('update','"+table+"','isVerify',this);\" id=selec6t1 name=sele6ct1> \r\n";
      html+="		  		<option value='' selected>请选择</option><option value=0>未审核 \r\n";
      html+="		  		<option value=1 >已审核 \r\n";
      html+="		  		</select> \r\n";
    }
    if (op.indexOf("recomend")!=-1){
      html+="							<img src=\"../../skin/skin1/images/split.gif\" align=\"middle\" border=\"0\"> 							  \r\n";
      html+="<select  onchange=\"CheckOperate('update','"+table+"','isRecomend',this);\" id=setlect1 name=seltect1> \r\n";
      html+="		  		<option value='' selected>请选择</option><option value=0>未推荐 \r\n";
      html+="		  		<option value=1 >已推荐 \r\n";
      html+="		  		</select>	 \r\n";
    }
    if (op.indexOf("delete")!=-1){
      html+="							<img src=\"../../skin/skin1/images/split.gif\" align=\"middle\" border=\"0\">    \r\n";
      html+="							<img src=\"../../images/dialog/delete.gif\" border=\"0\" title=\"删除选中的目录\" style=\"cursor:hand\" onclick=\"CheckOperate('delete','"+table+"');\" align=\"absmiddle\" WIDTH=\"16\" HEIGHT=\"16\">删除   \r\n";
    }
    html+="							<img src=\"../../skin/skin1/images/split.gif\" align=\"middle\" border=\"0\"> \r\n";
    html+="							<img src=\"../../images/dialog/return.gif\" border=\"0\" onclick=\"javascript:history.back();\" title=\"返回\" style=\"cursor:hand\" align=\"absmiddle\" WIDTH=\"14\" HEIGHT=\"14\">返回       \r\n";
    html+="							<img src=\"../../skin/skin1/images/split.gif\" align=\"middle\" border=\"0\">  \r\n";
    html+="<script> \r\n";
    html+="function SelectAll(flag) \r\n";
    html+="{		 \r\n";
    html+="	if (typeof(document.all.CheckList)!=\"undefined\") \r\n";
    html+="	{ \r\n";
    html+="		document.all.CheckList.checked=flag; \r\n";
    html+="		var Chk = document.all.CheckList ;	 \r\n";
    html+="		for (var i = 0; i <Chk.length; i++)  \r\n";
    html+="		{ \r\n";
    html+="			Chk[i].checked = flag ; \r\n";
    html+="		} \r\n";
    html+="	} \r\n";
    html+="} \r\n";
    html+=" \r\n";
    html+="function CheckOperate(op,table,field,obj) \r\n";
    html+="{ \r\n";
    html+="	\r\n";
    html+="		   //看看是否选中了至少一个要删除的文件 \r\n";
    html+="			var bHaveSelected=false; \r\n";
    html+="			var ids=\"\"; \r\n";
    html+="		  if (typeof(document.all.CheckList)!=\"undefined\") \r\n";
    html+="	       { \r\n";
    html+="				if (document.all.CheckList.checked==true) \r\n";
    html+="				{ \r\n";
    html+="					ids+=document.all.CheckList.value+\",\"; \r\n";
    html+="					bHaveSelected=true; \r\n";
    html+="				} \r\n";
    html+="				var o = document.all.CheckList;   \r\n";
    html+="				for (var i = 0; i < o.length; i++) {   \r\n";
    html+="					//如果选中了任何一个，设定标志 \r\n";
    html+="					if(o[i].checked ==true)  \r\n";
    html+="					{ \r\n";
    html+="						ids+=o[i].value+\",\"; \r\n";
    html+="						bHaveSelected=true; \r\n";
    html+="					} \r\n";
    html+="				}  \r\n";
    html+="		   } \r\n";
    html+="		    \r\n";
    html+="		   ids=ids.replace(\"undefined\",\"\"); \r\n";
    html+="		   		    \r\n";
    html+="		    \r\n";
    html+="		 if (!bHaveSelected)   \r\n";
    html+="		 {   \r\n";
    html+="		    alert(\"请选择需要操作的记录！\");   \r\n";
    html+="		    return false;   \r\n";
    html+="		 }   \r\n";
    html+="		  \r\n";
    html+="		 switch(op) \r\n";
    html+="		 {		  \r\n";
    html+="			case \"delete\": \r\n";
    html+="				if (confirm(\"确定要将选中的记录删除吗？\")) \r\n";
    html+="				{ \r\n";
    html+="					var ret=window.showModalDialog(\"../community/changeStatusEx.jsp?op=delete&ids=\"+ids+\"&table=\"+table+\"\",\"\",\"\"); \r\n";
    html+="					location.href=location.href; \r\n";
    html+="				} \r\n";
    html+="				break; \r\n";
    html+="			case \"update\": \r\n";
    html+="				if(obj.item(obj.selectedIndex).value=='')return; if (confirm(\"您确定要把该"+info+"的状态更改为\"+obj.item(obj.selectedIndex).text+\"吗？\")) \r\n";
    html+="				{ \r\n";
    html+="					var ret=window.showModalDialog(\"../community/changeStatusEx.jsp?op=update&fieldName=\"+field+\"&table=\"+table+\"&flag=\"+obj.item(obj.selectedIndex).value+\"&ids=\"+ids,\"\",\"\"); \r\n";
    html+="					location.href=location.href; \r\n";
    html+="				} \r\n";
    html+="				break; \r\n";
    html+="			} \r\n";
    html+="} \r\n";
    html+="</script> \r\n";
    return html;
  }

  public static String GetText(String Html)
  {
    String blob="",Text="";
    blob = replace(Html,"&lt;","<");
    blob = replace(blob,"&gt;",">");
    blob = replace(blob,"&amp;","&");
    blob = replace(blob,"&nbsp;","");
    int is_tag=0;
    for(int i=0;i<blob.length();i++)
    {

      String c=blob.substring (i,i+1);
      if (c.equals("<"))
        is_tag = 0;
      else if (c.equals(">"))
        is_tag = 1;
      else
        if(is_tag == 1) Text+= blob.substring(i,i+1);
    }
    return Text;
  }


        public static void fillClob(CLOB clob, String sContent) {
                try {
                        Writer outstream = clob.getCharacterOutputStream();
                        outstream.write(sContent);
                        outstream.close();
                } catch (Exception ex) {
                        System.out.println("填充CLOB数据错误" + ex);
                        // raise(ex,"填充CLOB数据错误","fillClob()");
                }
	}
/*
  function GetText(blob)
{
blob = replace("&lt;","<",blob);
blob = replace("&gt;",">",blob);
blob = replace("&amp;","&",blob);
blob = replace("&nbsp;","",blob);

  for($i=0;$i<strlen(blob);$i++)
   {
     switch (substr(blob,$i,1)) {
      case "<":
       $is_tag = 0;
       break;
      case ">":
       $is_tag = 1;
       break;
      default:
       if($is_tag == 1) $Text.= substr(blob,$i,1);
       break;
      }
     }
   return "&nbsp;&nbsp;&nbsp;".$Text;
}
  *//*
  public void downloadFile(String s, String s1, String s2, int i)
      throws ServletException, IOException, SmartUploadException
  {
    if(s == null)
      throw new IllegalArgumentException("File &acute;" + s +
          "&acute; not found (1040).");
    if(s.equals(""))
      throw new IllegalArgumentException("File &acute;" + s +
          "&acute; not found (1040).");
    if(!isVirtual(s) && m_denyPhysicalPath)
      throw new SecurityException("Physical path is denied (1035).");
    if(isVirtual(s))
      s = m_application.getRealPath(s);
    java.io.File file = new java.io.File(s);
    FileInputStream fileinputstream = new FileInputStream(file);
    long l = file.length();
    boolean flag = false;
    int k = 0;
    byte abyte0[] = new byte[i];
    if(s1 == null)
      m_response.setContentType("application/x-msdownload");
    else
      if(s1.length() == 0)
        m_response.setContentType("application/x-msdownload");
    else
      m_response.setContentType(s1);
    m_response.setContentLength((int)l);
    m_contentDisposition = m_contentDisposition != null ?
                           m_contentDisposition : "attachment;";
    if(s2 == null)
      m_response.setHeader("Content-Disposition",
                           m_contentDisposition + " filename=" +
                           toUtf8String(getFileName(s)));
    else
      if(s2.length() == 0)
        m_response.setHeader("Content-Disposition",
                             m_contentDisposition);
      else
        m_response.setHeader("Content-Disposition",
                             m_contentDisposition + " filename=" + toUtf8String(s2));
      while((long)k < l)
      {
        int j = fileinputstream.read(abyte0, 0, i);
        k += j;
        m_response.getOutputStream().write(abyte0, 0, j);
      }
      fileinputstream.close();
  }
*/
  /**
   * 将文件名中的汉字转为UTF8编码的串,以便下载时能正确显示另存的文件名.
   * 纵横软件制作中心雨亦奇2003.08.01
   * @param s 原文件名
   * @return 重新编码后的文件名
   */
  public static String toUtf8String(String s) {
    StringBuffer sb = new StringBuffer();
    for (int i=0;i<s.length();i++) {
      char c = s.charAt(i);
      if (c >= 0 && c <= 255) {
        sb.append(c);
      } else {
        byte[] b;
        try {
          b = Character.toString(c).getBytes("utf-8");
        } catch (Exception ex) {
          System.out.println(ex);
          b = new byte[0];
        }
        for (int j = 0; j < b.length; j++) {
          int k = b[j];
          if (k < 0) k += 256;
          sb.append("%" + Integer.toHexString(k).
                    toUpperCase());
        }
      }
    }
    return sb.toString();
  }













	public static void main(String argv[]) {
		// String s = CTools.replace("adf=eeeadsf=aseeedf=asdf=","eee","888");
		String s = CTools.htmlEncode("<");
		String strk = CTools.setSortCommon("xx","abc","sdf","unit");
		System.out.print(strk);
	}

}