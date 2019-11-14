package com.website;

import java.util.*;

import com.component.database.*;

public class LiWaXML {
	public static String webhost = Messages.getString("SessXml.3");

	Vector vecTitle;

	Vector vecLink;

	Vector vecPubDate;

	Vector vecStatus;

	public CDataCn dCn;

	public CDataImpl dImpl;

	public String thisday;
	
	public int i = 0;

	public LiWaXML() {
		this.dCn = new CDataCn();
		this.dImpl = new CDataImpl(dCn);
	}

	public void runxml(String _strday, String _endDay) {
		String wsbssql = "select pr_id,pr_name,pr_prokind,pr_time from tb_proceeding where "
				+ "to_date(pr_time,'yyyy-mm-dd')>to_date('"
				+ _strday
				+ "','yyyy-mm-dd') "
				+ "and to_date(pr_time,'yyyy-mm-dd')<to_date('"
				+ _endDay
				+ "','yyyy-mm-dd') "
				+ "and (pr_language='0' or pr_language is null)";
		this.wsbsrunxml(wsbssql);

		String xhglsql = "select s.sj_dir,s.sj_name,c.ct_create_time from tb_content c ,tb_subject s "
				+ "where  to_date(c.CT_CREATE_TIME,'yyyy-mm-dd') > to_date('"
				+ _strday
				+ "','yyyy-mm-dd') "
				+ "and to_date(c.CT_CREATE_TIME,'yyyy-mm-dd') < to_date('"
				+ _endDay
				+ "','yyyy-mm-dd') "
				+ "and  c.sj_id=s.sj_id "
				+ "and s.sj_dir in (select sj_dir from tb_subject where sj_parentid in (select sj_id from tb_subject where sj_dir='overview')) "
				+ "order by s.sj_sequence";
		this.xhglxml(xhglsql);

		String xhggxml = "select e.ti_id,e.ti_name ti_name,e.ti_extendvalue1,t.ti_name ti_uppername,t.ti_code ti_uppercode,e.ti_publishtime createtime "
				+ "from tb_title t,tb_title s,tb_title e  "
				+ "where t.ti_upperid=s.ti_id  "
				+ "and (s.ti_upperid =5 or t.ti_code = 'ggqita')  "
				+ "and e.ti_upperid = t.ti_id  "
				+ "and (e.ti_deleteflag='1' or e.ti_deleteflag is null)  "
				+ "and to_date(e.ti_publishtime,'yyyy-mm-dd') > to_date('"
				+ _strday
				+ "','yyyy-mm-dd') "
				+ "and to_date(e.ti_publishtime,'yyyy-mm-dd') < to_date('"
				+ _endDay + "','yyyy-mm-dd')";
		this.xhggxml(xhggxml);
		String xhghxml = "select t.ti_id,t.ti_name ti_name,t.tm_id,s.ti_name ti_uppername,s.ti_code ti_uppercode,s.tm_id ti_upperid,t.ti_publishtime createtime "
				+ "from tb_title t,tb_title s "
				+ "where t.ti_upperid=s.ti_id "
				+ "and s.ti_upperid =4 "
				+ "and (t.ti_deleteflag='1' or t.ti_deleteflag is null) "
				+ "and to_date(t.ti_publishtime,'yyyy-mm-dd') > to_date('"
				+ _strday
				+ "','yyyy-mm-dd')"
				+ "and to_date(t.ti_publishtime,'yyyy-mm-dd') < to_date('"
				+ _endDay + "','yyyy-mm-dd')";
		this.xhghxml(xhghxml);
		String xhgzxml = "select t.ti_id,t.ti_name ti_name,t.tm_id,s.ti_name ti_uppername,s.ti_code ti_uppercode,s.tm_id ti_upperid,t.ti_publishtime createtime "
				+ "from tb_title t,tb_title s "
				+ "where t.ti_upperid=s.ti_id "
				+ "and s.ti_upperid =1 "
				+ "and (t.ti_deleteflag='1' or t.ti_deleteflag is null) "
				+ "and to_date(t.ti_publishtime,'yyyy-mm-dd') > to_date('"
				+ _strday
				+ "','yyyy-mm-dd')"
				+ "and to_date(t.ti_publishtime,'yyyy-mm-dd') < to_date('"
				+ _endDay + "','yyyy-mm-dd')";
		this.xhgzxml(xhgzxml);
	}

	public void runxml(String _thisday) {
		// this.thisday=_thisday;
		String wsbssql = "select pr_id,pr_name,pr_prokind,pr_time from tb_proceeding where "
				 + "to_date(pr_time,'yyyy-mm-dd')=to_date('"
				 + _thisday
				 + "','yyyy-mm-dd') "
				 + "and "
				+ "(pr_language='0' or pr_language is null)";
		this.wsbsrunxml(wsbssql);

		String xhglsql = "select s.sj_dir,s.sj_name,c.ct_create_time from tb_content c ,tb_subject s "
				+ "where  "
				 + "to_date(c.CT_CREATE_TIME,'yyyy-mm-dd') = to_date('"
				 + _thisday
				 + "','yyyy-mm-dd') "
				 + "and "
				 + "c.sj_id=s.sj_id "
				+ "and "
				+ "s.sj_dir in (select sj_dir from tb_subject where sj_parentid in (select sj_id from tb_subject where sj_dir='overview')) "
				+ "order by s.sj_sequence";
		this.xhglxml(xhglsql);

		String xhggxml = "select e.ti_id,e.ti_name ti_name,e.ti_extendvalue1,t.ti_name ti_uppername,t.ti_code ti_uppercode,e.ti_publishtime createtime "
				+ "from tb_title t,tb_title s,tb_title e  "
				+ "where t.ti_upperid=s.ti_id  "
				+ "and (s.ti_upperid =5 or t.ti_code = 'ggqita')  "
				+ "and e.ti_upperid = t.ti_id  "
				+ "and (e.ti_deleteflag='1' or e.ti_deleteflag is null)  "
		 + "and to_date(e.ti_publishtime,'yyyy-mm-dd') = to_date('"
		 + _thisday + "','yyyy-mm-dd') ";
		this.xhggxml(xhggxml);
		String xhghxml = "select t.ti_id,t.ti_name ti_name,t.tm_id,s.ti_name ti_uppername,s.ti_code ti_uppercode,s.tm_id ti_upperid,t.ti_publishtime createtime "
				+ "from tb_title t,tb_title s "
				+ "where t.ti_upperid=s.ti_id "
				+ "and s.ti_upperid =4 "
				+ "and (t.ti_deleteflag='1' or t.ti_deleteflag is null) "
		 + "and to_date(t.ti_publishtime,'yyyy-mm-dd') = to_date('"
		 + _thisday + "','yyyy-mm-dd')";
		this.xhghxml(xhghxml);
		String xhgzxml = "select t.ti_id,t.ti_name ti_name,t.tm_id,s.ti_name ti_uppername,s.ti_code ti_uppercode,s.tm_id ti_upperid,t.ti_publishtime createtime "
				+ "from tb_title t,tb_title s "
				+ "where t.ti_upperid=s.ti_id "
				+ "and s.ti_upperid =1 "
				+ "and (t.ti_deleteflag='1' or t.ti_deleteflag is null) "
		 + "and to_date(t.ti_publishtime,'yyyy-mm-dd') = to_date('"
		 + _thisday + "','yyyy-mm-dd')";
		this.xhgzxml(xhgzxml);

	}

	public void endxml() {
		System.out.println("总记录数为:"+i);
		this.dImpl.closeStmt();
		this.dCn.closeCn();

	}

	public static void main(String[] args) {
		LiWaXML lwxml = new LiWaXML();
		lwxml.runxml("2004-9-23");

	}

	// 徐汇信息公开----最新公众服务事项

	public void xhgzxml(String sql) {
		Vector vPage = this.dImpl.splitPage(sql, 10000, 1);
		if (vPage != null) {
			for (int i = 0; i < vPage.size(); i++) {
				Hashtable map = (Hashtable) vPage.get(i);
				String ti_id = map.get("ti_id").toString();
				String ti_name = map.get("ti_name").toString();
				String tm_id = map.get("tm_id").toString();
				String ti_uppername = map.get("ti_uppername").toString();
				String ti_uppercode = map.get("ti_uppercode").toString();
				String createtime = map.get("createtime").toString();
				String url = this.webhost
						+ "/website2005/infoopen/InfoServerContent.jsp?ti_id="
						+ ti_id + "&pageurl=plan&ti_code=" + ti_uppercode
						+ "&tm_id=" + tm_id + "";
				String title = "[" + ti_uppername + "]" + ti_name;
				this.vecTitle.add(title);
				this.vecLink.add(url);
				this.vecPubDate.add(createtime);
				this.vecStatus.add("0");
				this.i++;
			}
		}

	}

	// 徐汇信息公开----最新规划和计划
	public void xhghxml(String sql) {
		Vector vPage = this.dImpl.splitPage(sql, 10000, 1);
		if (vPage != null) {
			for (int i = 0; i < vPage.size(); i++) {
				Hashtable map = (Hashtable) vPage.get(i);
				String ti_id = map.get("ti_id").toString();
				String ti_name = map.get("ti_name").toString();
				String tm_id = map.get("tm_id").toString();
				String ti_uppername = map.get("ti_uppername").toString();
				String ti_uppercode = map.get("ti_uppercode").toString();
				String createtime = map.get("createtime").toString();
				String url = this.webhost
						+ "/website2005/infoopen/InfoPlanContent.jsp?ti_id=" + ti_id
						+ "&pageurl=plan&ti_code=" + ti_uppercode + "&tm_id="
						+ tm_id + "";
				String title = "[" + ti_uppername + "]" + ti_name;
				this.vecTitle.add(title);
				this.vecLink.add(url);
				this.vecPubDate.add(createtime);
				this.vecStatus.add("0");
				this.i++;
			}
		}
	}

	// 徐汇信息公开----最新公告
	public void xhggxml(String sql) {
		Vector vPage = this.dImpl.splitPage(sql, 10000, 1);
		if (vPage != null) {
			for (int i = 0; i < vPage.size(); i++) {
				Hashtable map = (Hashtable) vPage.get(i);
				String ti_id = map.get("ti_id").toString();
				String ti_name = map.get("ti_name").toString();
				String ti_extendvalue1 = map.get("ti_extendvalue1").toString();
				String ti_uppername = map.get("ti_uppername").toString();
				String ti_uppercode = map.get("ti_uppercode").toString();
				String createtime = map.get("createtime").toString();
				String url = this.webhost
						+ "/website2005/infoopen/InfoProceedContent.jsp?ti_id="
						+ ti_id + "&pageurl=Proceed&ti_code=" + ti_uppercode
						+ "";
				String title = "";
				if (ti_extendvalue1.equals("")) {
					title = "[" + ti_uppername + "]" + ti_name;
				} else {
					title = "[" + ti_extendvalue1 + "]" + ti_name;
				}
				this.vecTitle.add(title);
				this.vecLink.add(url);
				this.vecPubDate.add(createtime);
				this.vecStatus.add("0");
				this.i++;
			}

		}

	}

	// 徐汇概览
	public void xhglxml(String sql) {
		Vector vPage = this.dImpl.splitPage(sql, 10000, 1);
		if (vPage != null) {
			for (int i = 0; i < vPage.size(); i++) {
				Hashtable map = (Hashtable) vPage.get(i);
				String sj_dir = map.get("sj_dir").toString();
				String sj_name = map.get("sj_name").toString();
				String ct_create_time = map.get("ct_create_time").toString();
				String url = this.webhost
						+ "/website2005/overview/viewcontent.jsp?sj_dir=" + sj_dir;
				this.vecTitle.add(sj_name);
				this.vecLink.add(url);
				this.vecPubDate.add(ct_create_time);
				this.vecStatus.add("0");
				this.i++;
			}
		}

	}

	// 网上办事
	public void wsbsrunxml(String sql) {
		Vector vPage = this.dImpl.splitPage(sql, 10000, 1);
		if (vPage != null) {
			for (int i = 0; i < vPage.size(); i++) {
				Hashtable map = (Hashtable) vPage.get(i);
				String pr_id = map.get("pr_id").toString();
				String pr_name = map.get("pr_name").toString();
				String pr_prokind = map.get("pr_prokind").toString();
				String pr_time = map.get("pr_time").toString();
				String url = this.webhost
						+ "/website2005/usercenter/ProjectDetail.jsp?pr_id=" + pr_id;
				String title = "";
				if (!pr_prokind.equals("")) {
					switch (Integer.parseInt(pr_prokind)) {
					case 0:
						title = "［行政审批］";
						break;
					case 1:
						title = "［公共服务］";
						break;
					case 2:
						title = "［便民服务］";
						break;
					case 3:
						title = "［便民服务］";
						break;
					}
				} else {
					title = "［行政审批］";
				}
				title = title + pr_name;
				this.vecTitle.add(title);
				this.vecLink.add(url);
				this.vecPubDate.add(pr_time);
				this.vecStatus.add("0");
				this.i++;
			}

		}

	}

	public Vector getVecLink() {
		return vecLink;
	}

	public void setVecLink(Vector vecLink) {
		this.vecLink = vecLink;
	}

	public Vector getVecPubDate() {
		return vecPubDate;
	}

	public void setVecPubDate(Vector vecPubDate) {
		this.vecPubDate = vecPubDate;
	}

	public Vector getVecStatus() {
		return vecStatus;
	}

	public void setVecStatus(Vector vecStatus) {
		this.vecStatus = vecStatus;
	}

	public Vector getVecTitle() {
		return vecTitle;
	}

	public void setVecTitle(Vector vecTitle) {
		this.vecTitle = vecTitle;
	}

}
