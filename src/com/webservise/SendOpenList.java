package com.webservise;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.Hashtable;
import java.util.List;
import java.util.Vector;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CFile;
import com.util.CTools;

/**
 * Descrption:将信息公开的数据报送到上海市
 * @author yang
 *
 */
public class SendOpenList {
	/**
	 * Description:根据传入的年月得到信息公开统计数据
	 * @param year 待查的年份
	 * @param month 待查的月份
	 * @return 统计数据的集合
	 */
	public Vector getAllOPenData(String year, String month) {
		String sql = "select sum(to_number(nvl(interviewapply, '0'), '9999999') +to_number(nvl(faxapply, '0'), '9999999') +to_number(nvl(emailapply, '0'), '9999999') +to_number(nvl(webapply, '0'), '9999999') +to_number(nvl(letterapply, '0'), '9999999') +to_number(nvl(otherapply, '0'), '9999999')) as totalshenqing,sum(to_number(nvl(aopen, '0'), '9999999') +to_number(nvl(apartopen, '0'), '9999999') +to_number(nvl(fgdszzfxxs, '0'), '9999999') +to_number(nvl(noinfo, '0'), '9999999') +to_number(nvl(nodept, '0'), '9999999') +to_number(nvl(nobound, '0'), '9999999') +to_number(nvl(noopen1, '0'), '9999999') +to_number(nvl(noopen2, '0'), '9999999') +to_number(nvl(noopen3, '0'), '9999999') +           to_number(nvl(noopen4, '0'), '9999999') +to_number(nvl(noopen5, '0'), '9999999') +to_number(nvl(noopen6, '0'), '9999999') +to_number(nvl(cfsqs, '0'), '9999999')) as totaldafu,sum(to_number(nvl(noopen1, '0'), '9999999') +to_number(nvl(noopen2, '0'), '9999999') +to_number(nvl(noopen3, '0'), '9999999') +to_number(nvl(noopen4, '0'), '9999999') +to_number(nvl(noopen5, '0'), '9999999') +to_number(nvl(noopen6, '0'), '9999999')) as totalbugongkai,sum(to_number(nvl(zdmailcharge, '0'), '9999999') +to_number(nvl(zdcopychargesheet, '0'), '9999999') +to_number(nvl(zdcopychargedisk, '0'), '9999999') +to_number(nvl(zdcopychargefdisk, '0'), '9999999')) as totalzdsf,sum(to_number(nvl(searchcharge, '0'), '9999999') +to_number(nvl(mailcharge, '0'), '9999999') +to_number(nvl(copychargesheet, '0'), '9999999') +to_number(nvl(copychargedisk, '0'), '9999999') +to_number(nvl(copychargefdisk, '0'), '9999999')) as totalysqsf,sum(to_number(nvl(zdmailcharge, '0'), '9999999') +to_number(nvl(zdcopychargesheet, '0'), '9999999') +to_number(nvl(zdcopychargedisk, '0'), '9999999') +to_number(nvl(zdcopychargefdisk, '0'), '9999999') +to_number(nvl(searchcharge, '0'), '9999999') +to_number(nvl(mailcharge, '0'), '9999999') +to_number(nvl(copychargesheet, '0'), '9999999') +to_number(nvl(copychargedisk, '0'), '9999999') +to_number(nvl(copychargefdisk, '0'), '9999999')) as totalshoufei,sum(io.interviewapply) as interviewapply,sum(io.faxapply) as faxapply,sum(io.emailapply) as emailapply,sum(io.webapply) as webapply,sum(io.letterapply) as letterapply,sum(io.otherapply) as otherapply,sum(io.aopen) as aopen,sum(io.apartopen) as apartopen,sum(io.noinfo) as noinfo,sum(io.nodept) as nodept,sum(io.nobound) as nobound,sum(io.noopen1) as noopen1,sum(io.noopen2) as noopen2,sum(io.noopen3) as noopen3,sum(io.noopen4) as noopen4,sum(io.noopen5) as noopen5,sum(io.noopen6) as noopen6,sum(io.searchcharge) as searchcharge,sum(io.mailcharge) as mailcharge,sum(io.copychargesheet) as copychargesheet,sum(io.copychargedisk) as copychargedisk,sum(io.copychargefdisk) as copychargefdisk,sum(io.fgdszzfxxs) as fgdszzfxxs,sum(io.zdmailcharge) as zdmailcharge,sum(io.zdcopychargesheet) as zdcopychargesheet,sum(io.zdcopychargedisk) as zdcopychargedisk,sum(io.zdcopychargefdisk) as zdcopychargefdisk,sum(io.cfsqs) as cfsqs  from iostat io where io.reportyear = '"+year+"'  and io.reportmonth = '"+month+"'";
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Vector list = null;
		System.out.println("------"+sql);
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			list = dImpl.splitPage(sql, 1000, 1);
		} catch (Exception e) {
			System.err.println("SendOpenList:getAllOPenData " + e.getMessage());
		} finally {
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return list;
	}

	/**
	 * Description:得到待查年月的信息公开数据的xml字符串
	 * @param year 待查的年份
	 * @param month 待查的月份
	 */
	public String doPushList(String year, String month) throws Exception {
		Calendar calendar = Calendar.getInstance();
		String sendResult = "";
		if("".equals(year))
			year = String.valueOf(calendar.get(Calendar.YEAR));
		if("".equals(month))
			month = String.valueOf(calendar.get(Calendar.MONTH));
		StringBuffer rtnStr = new StringBuffer("");
		Vector vec = getAllOPenData(year, month);// 得到所有的报送信息
		
		//得到模板xml根元素
		String templateStr = "";
		String tempFile = System.getProperty("user.dir")
				+ System.getProperty("file.separator") + "OpenListTemplate.xml";
		templateStr = getTemplateEle(tempFile);
		Element templateEle = initEle(templateStr);

		Element root = templateEle.getChild("districtStat").getChild("district");
		Hashtable table = null;
		if(vec != null){
			rtnStr = new StringBuffer(
					"<?xml version=\"1.0\" encoding=\"gb2312\"?>");
	
			// 加入根元素以及年份属性、月度属性
			rtnStr.append("<stat month=\"" + month + "\" year=\""+year+"\">");
			rtnStr.append("<districtStat>");
			
			for(int cnt = 0; cnt < vec.size(); cnt++){
				table = (Hashtable) vec.get(cnt);
				setXml(root,table,rtnStr);
			}
			
			rtnStr.append("</districtStat>");
			rtnStr.append("</stat>");
			
			//CFile.write("D:/bsshs/"+year+"-"+month+"-gwba.xml",rtnStr.toString());
			rtnStr = new StringBuffer("<?xml version=\"1.0\" encoding=\"gb2312\"?><stat month=\"11\" year=\"2009\"><districtStat><district><name>浦东新区</name><id>SH00PD</id><sqzs>192</sqzs><dmsqs>25</dmsqs><czsqs>0</czsqs><dzyjsqs>0</dzyjsqs><wssqs>166</wssqs><xhsqs>1</xhsqs><qtxssqs>0</qtxssqs><dsqddfzs>112</dsqddfzs><tygkdfs>72</tygkdfs><tybfgkdfs>0</tybfgkdfs><fjgkdfzs>3</fjgkdfzs><fgdszzfxxs>2</fgdszzfxxs><xxbczs>11</xxbczs><fbbmzws>17</fbbmzws><sqnrbmqs>3</sqnrbmqs><mygkfw1s>0</mygkfw1s><mygkfw2s>2</mygkfw2s><mygkfw3s>0</mygkfw3s><mygkfw4s>0</mygkfw4s><mygkfw5s>0</mygkfw5s><mygkfw6s>1</mygkfw6s><cfsqs>4</cfsqs><sqrzdcxs>0</sqrzdcxs><fzfxxgksqs>0</fzfxxgksqs><fyzs>61</fyzs><zdfyzs>46</zdfyzs><zdyjf>23</zdyjf><zddsf>0</zddsf><zdfzfzz>21</zdfzfzz><zdfzfgp>1</zdfzfgp><zdfzfrp>1</zdfzfrp><ysqfyzs>15</ysqfyzs><ysqjsf>1</ysqjsf><ysqyjf>1</ysqyjf><ysqdsf>0</ysqdsf><ysqfzfzz>11</ysqfzfzz><ysqfzfgp>1</ysqfzfgp><ysqfzfrp>1</ysqfzfrp><ysqqtsf>0</ysqqtsf></district></districtStat></stat>");
			sendResult = pushStat(rtnStr.toString());
			System.out.println(rtnStr);
		}
		return sendResult;
	}
	
	/**
	 * Description:根据模板解析的数据得到一条记录放入到xml字符串
	 * @param root 模板元素
	 * @param table 数据集
	 * @param rtnStr xml字符串
	 * @return 添加后的xml
	 */
	private StringBuffer setXml(Element root,Hashtable table,StringBuffer rtnStr){
		List list = (List)root.getChildren();
		Element child = null;
		String eleName = "";
		String eleValue = "";
		String columnName = "";
		rtnStr.append("<district>");
		for(int cnt = 0; cnt < list.size(); cnt++){
			child = (Element)list.get(cnt);
			eleName = child.getName();
			columnName = child.getAttributeValue("columnname");
			if(!"".equals(columnName)){
				if(eleName.equals("name")){
					eleValue = "浦东新区";
				}else if(eleName.equals("id")){
					eleValue="SH00PD";
				}
				else	
					eleValue = CTools.dealNumber(table.get(columnName));
			}
			rtnStr.append("<" + eleName + ">");
			rtnStr.append(eleValue);
			rtnStr.append("</" + eleName + ">");
		}
		rtnStr.append("</district>");
		return rtnStr;
	}
	
	/**
	 * Description：初始化变量
	 * 
	 * @param fileStr
	 *            一段xml的字符串
	 */
	private static Element initEle(String fileStr) {
		Document doc = null;

		SAXBuilder sb = null;

		Element element = null;
		try {
			sb = new SAXBuilder();
			InputStream inputStream = new ByteArrayInputStream(fileStr
					.getBytes("gb2312"));
			doc = sb.build(inputStream);
			element = doc.getRootElement();
		} catch (UnsupportedEncodingException ex) {
			System.err.println("SendOpenList：initEle XML编码错误: "
					+ ex.getMessage());
		} catch (JDOMException ex) {
			System.err.println("SendOpenList：initEle XML解析错误: "
					+ ex.getMessage());
		}
		return element;
	}

	/**
	 * Description：得到文件的字符串
	 * 
	 * @param 文件路径
	 * @return 模板的字符串
	 */
	private String getTemplateEle(String filepath) {
		StringBuffer source = new StringBuffer("");
		BufferedReader reader = null;
		try {
			reader = CFile.read(filepath);
			while (reader.ready()) {
				source.append(new String(reader.readLine().getBytes("gb2312"),
						"gb2312"));
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.err
					.println("SendOpenList:getTemplateEle " + e.getMessage());
		}
		return source.toString();
	}
	
	/**
	 * Description：得到数据表的字段名
	 * 
	 * @param tableName
	 *            表名
	 */
	public void getColumnName(String tableName) {
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		String columnName = "";
		StringBuffer finallyStr = new StringBuffer("");
		Vector vec = null;
		Hashtable table = null;
		tableName = tableName.toUpperCase();
		String sql = "select lower(column_name) as column_name from user_tab_columns where table_name='"
				+ tableName + "'";
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			vec = dImpl.splitPage(sql, 200, 1);
			if (vec != null) {
				for (int count = 0; count < vec.size(); count++) {
					table = (Hashtable) vec.get(count);
					columnName = table.get("column_name") != null ? table.get(
							"column_name").toString() : "";
					finallyStr.append(columnName);
					if (count != vec.size() - 1)
						finallyStr.append(",");

				}
			}
			System.out.println(finallyStr.toString());
		} catch (Exception ex) {
			System.err
					.println("SendOpenList:getAllOPenData " + ex.getMessage());
		} finally {
			dImpl.closeStmt();
			dCn.closeCn();
		}
	}
	/**
	 * 上报到上海市
	 * @param xmls 按照上海市要求的格式拼装的XML
	 * @return
	 * @throws Exception
	 */
	public String pushStat(String xmls) throws Exception {
		com.openList.PushStatHttpBindingStub binding;
        try {
            binding = (com.openList.PushStatHttpBindingStub)
                          new com.openList.PushStatLocator().getPushStatHttpPort();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        binding.setTimeout(60000);
        java.lang.String value = null;
        value = binding.pushStat(xmls);
        return value;
	}
	/**
	 * main方法
	 * @param args
	 */
	public static void main(String[] args) {
		SendOpenList openList = new SendOpenList();
		try {
			System.out.println("----------"+openList.doPushList("2009","11"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// openList.getColumnName("infoopen");
	}

}
