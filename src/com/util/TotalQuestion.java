package com.util;

import java.util.Hashtable;
import java.util.Vector;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

public class TotalQuestion {

	private String qn_code = "";
	public TotalQuestion(String qn_code)
	{
		this.qn_code = qn_code;
	}
	public String getThemeOption(String thId, String qt_sequence) {
		StringBuffer thContent = new StringBuffer("");

		CDataCn dCn = null; // 新建数据库连接对象
		CDataImpl dImpl = null; // 新建数据接口对象
		Hashtable content = null;
		String th_title = "";
		String th_type = "";
		String th_scale = "";
		String thOption = "";
		String sql = "select th_title,th_type,th_scale from tb_theme where th_id="
				+ thId;
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			content = dImpl.getDataInfo(sql);
			if (content != null) {
				th_title = content.get("th_title") != null ? content.get(
						"th_title").toString() : "";
				th_type = content.get("th_type") != null ? content.get(
						"th_type").toString() : "";
				th_scale = content.get("th_scale") != null ? content.get(
						"th_scale").toString() : "";
				thContent.append(th_title);

				// 判断题目类型，返回相应的答案列1 单选； 0 多选； 2 是非题； 3 文本框；4 文本域
				if ("1".equals(th_type)) {
					thOption = getCheckboxStr(thId);
				} else if ("0".equals(th_type)) {
					thOption = getRadioStr(thId);
				} else if ("2".equals(th_type)) {
					thOption = getDisputeStr(thId);
				} else if ("3".equals(th_type)) {
					thOption = getTextStr(thId);
				} else if ("4".equals(th_type)) {
					thOption = getTextAreaStr(thId);
				}
				thContent.append(thOption);

			}
		} catch (Exception e) {
			System.out.println("-----getThemeOption------" + e.getMessage());
		} finally {
			dCn.closeCn();
			dImpl.closeStmt();
		}
		return thContent.toString();
	}

	private String getCheckboxStr(String thId) {
		CDataCn dCn = null; // 新建数据库连接对象
		CDataImpl dImpl = null; // 新建数据接口对象
		String sql = "select to_id,to_title,to_isright,to_isaddtext from tb_themeoption where th_id = "
				+ thId + " order by to_sequence";
		StringBuffer thOption = new StringBuffer("");
		String to_title = "";
		String to_id = "";
		String to_isaddtext = "";
		Vector vec = null;
		Hashtable content = null;
		Hashtable totalThme = null;
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			vec = dImpl.splitPage(sql, 20, 1);
			
			if (vec != null) {
				thOption
						.append("<table border=\"0\" align=\"center\" width=\"100%\" style=\"PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px\" cellspacing=\"2\">");
				for (int count = 0; count < vec.size(); count++) {
					content = (Hashtable) vec.get(count);
					to_isaddtext = content.get("to_isaddtext") != null ? content.get(
							"to_isaddtext").toString() : "";
					to_title = content.get("to_title") != null ? content.get(
							"to_title").toString() : "";
					to_id = content.get("to_id") != null ? content.get("to_id")
							.toString() : "";
					
					String sql1 = "select to_id,nvl(count(ud_id),'0') num from tb_ufdetail where uf_id in "+
					"(select f.uf_id from tb_userfeedback f,tb_questionnaire q where q.qn_code = '"+this.qn_code+"' "+
					"and q.qn_id = f.qn_id ) and th_id="+thId+" group by to_id";
					totalThme = dImpl.getDataInfo(sql1);
					
					if (count % 4 == 0 && count != 0)
						thOption.append("<tr>");
					thOption.append("<td>");
					/*thOption.append("<INPUT type=\"checkbox\" name=\"chk_"
							+ thId + "_" + to_id + "\" value=\"" + to_id
							+ "\" >");*/
					thOption.append(to_title);
					thOption.append(totalThme.get("num").toString());
					if("1".equals(to_isaddtext))
						thOption.append("<a href=''>查看</a>");
					thOption.append("</td>");
					if (count % 4 == 3 && count != 0)
						thOption.append("</tr>");
				}
				thOption.append("</table>");
			}
		} catch (Exception e) {
			System.out.println("-----getCheckboxStr------" + e.getMessage());
		} finally {
			dCn.closeCn();
			dImpl.closeStmt();
		}
		return thOption.toString();
	}

	public static String[] splitStr(String original, String regex) {
		
		// 取子串的起始位置
		int startIndex = 0;

		// 将结果数据先放入Vector中
		Vector v = new Vector();

		// 返回的结果字符串数组
		String[] str = null;

		// 存储取子串时起始位置
		int index = 0;

		// 获得匹配子串的位置
		startIndex = original.indexOf(regex);

		// System.out.println("0" + startIndex);
		// 如果起始字符串的位置小于字符串的长度，则证明没有取到字符串末尾。

		// -1代表取到了末尾
		while (startIndex < original.length() && startIndex != -1){

			String temp = original.substring(index, startIndex);

			// System.out.println(" " + startIndex);

			// 取子串
			v.addElement(temp);

			// 设置取子串的起始位置
			index = startIndex + regex.length();

			// 获得匹配子串的位置
			startIndex = original.indexOf(regex, startIndex + regex.length());

		}

		// 取结束的子串
		v.addElement(original.substring(index));

		// 将Vector对象转换成数组

		str = new String[v.size()];
		for (int i = 0; i < v.size(); i++){
			str[i] = (String) v.elementAt(i);
		}
		
		// 返回生成的数组
		return str;

	}

	private String getRadioStr(String thId) {
		CDataCn dCn = null; // 新建数据库连接对象
		CDataImpl dImpl = null; // 新建数据接口对象
		String sql = "select to_id,to_title,to_isright,to_isaddtext from tb_themeoption where th_id = "
				+ thId + " order by to_sequence";
		StringBuffer thOption = new StringBuffer("");

		String to_title = "";
		String to_id = "";
		String to_isaddtext = "";
		Vector vec = null;
		Hashtable content = null;
		Hashtable totalThme = null;
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			vec = dImpl.splitPage(sql, 20, 1);
			if (vec != null) {
				thOption
						.append("<table border=\"0\" align=\"center\" width=\"100%\" style=\"PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px\" cellspacing=\"2\">");
				for (int count = 0; count < vec.size(); count++) {
					content = (Hashtable) vec.get(count);
					to_isaddtext = content.get("to_isaddtext") != null ? content.get(
							"to_isaddtext").toString() : "";
					to_title = content.get("to_title") != null ? content.get(
							"to_title").toString() : "";
					to_id = content.get("to_id") != null ? content.get("to_id")
							.toString() : "";
					if (count % 4 == 0 && count != 0)
						thOption.append("<tr>");
					thOption.append("<td>");
					/*thOption.append("<input type=\"radio\" name=\"rd_" + thId
							+ "\" value=\"" + to_id + "\" >");*/
					String sql1 = "select to_id,nvl(count(ud_id),'0') num from tb_ufdetail where uf_id in "+
					"(select f.uf_id from tb_userfeedback f,tb_questionnaire q where q.qn_code = '"+this.qn_code+"' "+
					"and q.qn_id = f.qn_id ) and th_id="+thId+" group by to_id";
					totalThme = dImpl.getDataInfo(sql1);
					thOption.append(to_title);
					thOption.append(totalThme.get("num").toString());
					if("1".equals(to_isaddtext))
						/*thOption.append("<input type=\"text\" name=\"txt_" + thId
								+ "_" + to_id
								+ "\"  style=\"WIDTH:27%;\"  class=\"doc_text\" >");*/
						thOption.append("<a href=''>查看</a>");
					thOption.append("</td>");
					if (count % 4 == 3 && count != 0)
						thOption.append("</tr>");
				}
				thOption.append("</table>");
			}
		} catch (Exception e) {
			System.out.println("-----getCheckboxStr------" + e.getMessage());
		} finally {
			dCn.closeCn();
			dImpl.closeStmt();
		}
		return thOption.toString();
	}

	private String getDisputeStr(String thId) {
		CDataCn dCn = null; // 新建数据库连接对象
		CDataImpl dImpl = null; // 新建数据接口对象
		String sql = "select to_id,to_title,to_isright,to_isaddtext from tb_themeoption where th_id = "
				+ thId + " order by to_sequence";
		StringBuffer thOption = new StringBuffer("");

		String to_title = "";
		String to_id = "";
		String to_isaddtext = "";
		Vector vec = null;
		Hashtable content = null;
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			vec = dImpl.splitPage(sql, 20, 1);
			if (vec != null) {
				thOption
						.append("<table border=\"0\" align=\"center\" width=\"100%\" style=\"PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px\" cellspacing=\"2\">");
				thOption.append("<tr>");
				thOption.append("<td>");
				for (int count = 0; count < vec.size(); count++) {
					content = (Hashtable) vec.get(count);
					to_isaddtext = content.get("to_isaddtext") != null ? content.get(
							"to_isaddtext").toString() : "";
					to_title = content.get("to_title") != null ? content.get(
							"to_title").toString() : "";
					to_id = content.get("to_id") != null ? content.get("to_id")
							.toString() : "";
					/*thOption.append("<input type=\"radio\" name=\"dsp_" + thId
							+ "_" + to_id + "\" value=\"" + to_id + "\" >");*/
					thOption.append(to_title);
					if("1".equals(to_isaddtext))
						/*thOption.append("<input type=\"text\" name=\"txt_" + thId
								+ "_" + to_id
								+ "\"  style=\"WIDTH:27%;\"  class=\"doc_text\" >");*/
					thOption.append("<a href=''>查看</a>");
					thOption.append("&nbsp;&nbsp;&nbsp;&nbsp;");
				}
				thOption.append("</td>");
				thOption.append("</tr>");
				thOption.append("</table>");
			}
		} catch (Exception e) {
			System.out.println("-----getCheckboxStr------" + e.getMessage());
		} finally {
			dCn.closeCn();
			dImpl.closeStmt();
		}
		return thOption.toString();
	}

	private String getTextStr(String thId) {
		CDataCn dCn = null; // 新建数据库连接对象
		CDataImpl dImpl = null; // 新建数据接口对象
		String sql = "select to_id,to_title,to_isright from tb_themeoption where th_id = "
				+ thId + " order by to_sequence";
		StringBuffer thOption = new StringBuffer("");

		String to_title = "";
		String to_id = "";
		Vector vec = null;
		Hashtable content = null;
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			vec = dImpl.splitPage(sql, 20, 1);
			if (vec != null) {
				thOption
						.append("<table border=\"0\" align=\"center\" width=\"100%\" style=\"PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px\" cellspacing=\"2\">");
				thOption.append("<tr>");
				thOption.append("<td>");
				for (int count = 0; count < vec.size(); count++) {
					content = (Hashtable) vec.get(count);
					to_title = content.get("to_title") != null ? content.get(
							"to_title").toString() : "";
					to_id = content.get("to_id") != null ? content.get("to_id")
							.toString() : "";
					thOption.append("<input type=\"text\" name=\"txt_" + thId
							+ "_" + to_id
							+ "\"  style=\"WIDTH:17%;\"  class=\"doc_text\" >");
					thOption.append(to_title);
					thOption.append("&nbsp;&nbsp;");
				}
				thOption.append("</td>");
				thOption.append("</tr>");
				thOption.append("</table>");
			}
		} catch (Exception e) {
			System.out.println("-----getCheckboxStr------" + e.getMessage());
		} finally {
			dCn.closeCn();
			dImpl.closeStmt();
		}
		return thOption.toString();
	}

	private String getTextAreaStr(String thId) {
		CDataCn dCn = null; // 新建数据库连接对象
		CDataImpl dImpl = null; // 新建数据接口对象
		String sql = "select to_id,to_title,to_isright from tb_themeoption where th_id = "
				+ thId + " order by to_sequence";
		StringBuffer thOption = new StringBuffer("");

		String to_title = "";
		String to_id = "";
		Vector vec = null;
		Hashtable content = null;
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			vec = dImpl.splitPage(sql, 20, 1);
			if (vec != null) {
				thOption
						.append("<table border=\"0\" align=\"center\" width=\"100%\" style=\"PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px\" cellspacing=\"2\">");
				thOption.append("<tr>");
				thOption.append("<td>");
				for (int count = 0; count < vec.size(); count++) {
					content = (Hashtable) vec.get(count);
					to_title = content.get("to_title") != null ? content.get(
							"to_title").toString() : "";
					to_id = content.get("to_id") != null ? content.get("to_id")
							.toString() : "";
					thOption
							.append("<textarea rows=\"4\" name=\"txtr_"
									+ thId
									+ "_"
									+ to_id
									+ "\"  style=\"WIDTH:99%;\" cols=\"30\" field_type=\"text\" >");
					thOption.append(to_title);
					thOption.append("</textarea>");
					thOption.append("&nbsp;&nbsp;");
				}
				thOption.append("</td>");
				thOption.append("</tr>");
				thOption.append("</table>");
			}
		} catch (Exception e) {
			System.out.println("-----getCheckboxStr------" + e.getMessage());
		} finally {
			dCn.closeCn();
			dImpl.closeStmt();
		}
		return thOption.toString();
	}
	
	public static void main(String[] args){
		System.out.print(ThemeUtil.splitStr("ths_aaa_ss","_"));
	}
}
