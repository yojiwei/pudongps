/*
 * 创建日期 2005-7-7
 * 
 * TODO 要更改此生成的文件的模板，请转至 窗口 － 首选项 － Java － 代码样式 － 代码模板
 */

package com.website;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Hashtable;
import java.util.Vector;
import com.component.database.*;
import com.util.CDate;

public class SessionXmlwsbs{ 

     public static String webhost = "";//Messages.getString("SessXml.3");

     public static String webfile = "";//Messages.getString("SessXml.5");

     public static String webadd = "";//Messages.getString("SessXml.4");

     public static void statrxml(String staDate, String endData) {
          java.util.Date dtendDate = Date.valueOf(endData);
          java.util.Date dtbegDate = Date.valueOf(staDate);
          CDataCn dCn = new CDataCn();
          CDataImpl dImpl = new CDataImpl(dCn);
          SimpleDateFormat dd = new SimpleDateFormat("yyyyMMdd");
          String mDate = dd.format(dtendDate);
          String bDate = dd.format(dtbegDate);
          XmlImpl xml = new XmlImpl();
          xml.setTerFilePath(webfile + "/gb/xml/gsci" + mDate + ".xml");
          xml.setXmlRoot("gsci");
          xml.addComment("各委办局网站主体信息内容"); 
          xml.addAttribute("version", "0.9");
          xml.setXMLTabSeed("title", "上海浦东", "subsite");
          xml.setXMLTabSeed("link", webhost, "subsite");
          xml.setXMLTabSeed("copyright", "上海市浦东新区人民政府版权所有", "subsite");
          xml.setXMLTabSeed("subsite", "浦东新区", "subsite");
          xml.setXMLTabSeed("location", "1", "subsite");
          xml.setXMLTabSeed("item", "", "subsite");

          String sql = "select a.ct_id, a.ct_title, b.sj_id,a.ct_create_time "
              + "from tb_content a,tb_subject b,tb_contentpublish p "
              + "where "
              + "p.sj_id=b.sj_id and p.ct_id=a.ct_id and p.cp_ispublish='1' and "
              + "b.sj_id in (select sj_id from tb_subject start with sj_dir='root' connect by prior sj_id=sj_parentid) and "
              + "a.CT_DELFLAG<>'1' and "
              + "to_date(a.CT_CREATE_TIME,'yyyy-mm-dd') <= to_date('"
              + mDate
              + "','yyyy-mm-dd')  and to_date(a.ct_create_time,'yyyy-mm-dd')>=to_date('" + bDate + "','yyyy-mm-dd')"
              + " order by a.ct_sequence, to_date(a.CT_CREATE_TIME,'yyyy-mm-dd hh:mi:ss') desc,"
              + " to_number(a.ct_id,'9999999') desc ";

    Vector vPage = dImpl.splitPage(sql, 10000, 1);
    Vector vecTitle = new Vector();
    Vector vecLink = new Vector();
    Vector vecPubDate = new Vector();
    Vector vecStatus = new Vector();
    if (vPage != null) {
         
         for ( int i = 0 ; i < vPage.size() ; i++ ) {
              Hashtable map = (Hashtable) vPage.get(i);
              String ct_title = map.get("ct_title").toString();
              String ct_id = map.get("ct_id").toString();
              String sj_id = map.get("sj_id").toString();
              String ct_create_time = map.get("ct_create_time")
                        .toString();
              String title = ct_title;
              String link = webhost + webadd + "?sjId=" + sj_id
                        + "&ct_id=" + ct_id + "";
              String pubDate = ct_create_time;

              vecTitle.add(title);
              vecLink.add(link);
              vecPubDate.add(pubDate);
              vecStatus.add("0");

         }    
    }
          
          
          xml.setXMLTableTree("title", vecTitle, "item");
          xml.setXMLTableTree("link", vecLink, "item");
          xml.setXMLTableTree("pubDate", vecPubDate, "item");
          xml.setXMLTableTree("status", vecStatus, "item");
          xml.XmlAddNew();
          dImpl.closeStmt();
          dCn.closeCn();

     }

     /**
      * @param stDate		生成日期
      * @param startDate	大于日期
      * @param endDate		小于日期
      * @param rootDate		固定日期
      */
     public static void VectorXML(String stDate,String startDate,String endDate,String rootDate,String rootDate1) {
          SimpleDateFormat dd = new SimpleDateFormat("yyyyMMdd");
          java.util.Date daDate = Date.valueOf(stDate);
          CDataCn dCn = new CDataCn();
          CDataImpl dImpl = new CDataImpl(dCn);
          /*
          String sql_info = "select ix_id from tb_infoxml where ix_date = '"
                    + daDate.toString() + "'";
          //System.out.println(sql_info);
          Hashtable infomap = dImpl.getDataInfo(sql_info);
         
          dImpl.setTableName("tb_infoxml");
          dImpl.setPrimaryFieldName("ix_id");
          
          if (infomap == null) {
               dImpl.addNew();
          } else {
               dImpl.edit("tb_infoxml", "ix_id", Integer.parseInt(infomap.get(
                         "ix_id").toString()));
          }
          dImpl.setValue("ix_date", daDate.toString(), CDataImpl.STRING);
          */
          try {
               XmlImpl xml = new XmlImpl();
               long myTime = (daDate.getTime() / 1000) - 60 * 60 * 24;
               daDate.setTime(myTime * 1000);
               String mDate = dd.format(daDate);
               xml.setTerFilePath(webfile + "/gb/xml/gsci" + mDate + ".xml");
               xml.setXmlRoot("gsci");
               xml.addComment("各委办局网站主体信息内容");
               xml.addAttribute("version", "0.9");
               xml.setXMLTabSeed("title", "上海浦东", "subsite");
               xml.setXMLTabSeed("link", webhost, "subsite");
               xml.setXMLTabSeed("copyright", "上海市浦东新区人民政府版权所有", "subsite");
               xml.setXMLTabSeed("subsite", "浦东新区", "subsite");
               xml.setXMLTabSeed("location", "1", "subsite");
               xml.setXMLTabSeed("item", "", "subsite");
               
               String sql = "select a.ct_id, a.ct_title, p.sj_id,a.ct_create_time from tb_content a," +
               				"tb_contentpublish p where p.ct_id=a.ct_id and p.cp_ispublish='1' and a.CT_DELFLAG<>'1' " +
               				"and (";
               
               if (!"".equals(endDate)) 
            	   sql += " to_date(a.CT_CREATE_TIME,'yyyy-mm-dd') <= to_date('" + endDate + "','yyyy-mm-dd')";
               
               if (!"".equals(startDate)) {
            	   if (!"".equals(endDate)) 
            		   sql += " and";
            	   sql += " to_date(a.CT_CREATE_TIME,'yyyy-mm-dd') >= to_date('" + startDate + "','yyyy-mm-dd')";
               }
               
               if (!"".equals(rootDate)) {
            	   if (!"".equals(endDate) || !"".equals(startDate))
            		   sql += " or";
            	   sql += " to_date(a.CT_CREATE_TIME,'yyyy-mm-dd') = to_date('" + rootDate + "','yyyy-mm-dd')";
               }
               if (!"".equals(rootDate1)) {
	        	   if (!"".equals(endDate) || !"".equals(startDate) || !"".equals(rootDate)) 
	        		   sql += " or";
            	   sql += " to_date(a.CT_CREATE_TIME,'yyyy-mm-dd') = to_date('" + rootDate1 + "','yyyy-mm-dd')";
               }
               sql += ")";
               
               System.out.println(sql);
               
               //String sql = "select a.ct_id, a.ct_title, p.sj_id,a.ct_create_time from tb_content a,tb_contentpublish p where p.ct_id=a.ct_id and p.cp_ispublish='1' and a.CT_DELFLAG<>'1'" + 
			   //			"and (to_date(a.CT_CREATE_TIME,'yyyy-mm-dd') >= to_date('2006-01-01','yyyy-mm-dd')" +
			   //			"and to_date(a.CT_CREATE_TIME,'yyyy-mm-dd') <= to_date('2006-08-30','yyyy-mm-dd')" +
			   //			" or to_date(a.CT_CREATE_TIME,'yyyy-mm-dd') = to_date('2006-12-08','yyyy-mm-dd'))";
               
               
               Vector vPage = dImpl.splitPage(sql, 1000000, 1);
               Vector vecTitle = new Vector();
               Vector vecLink = new Vector();
               Vector vecPubDate = new Vector();
               Vector vecStatus = new Vector();
               if (vPage != null) {
                    
                    for ( int i = 0 ; i < vPage.size() ; i++ ) {
                         Hashtable map = (Hashtable) vPage.get(i);
                         String ct_title = map.get("ct_title").toString();
                         String ct_id = map.get("ct_id").toString();
                         String sj_id = map.get("sj_id").toString();
                         String ct_create_time = map.get("ct_create_time")
                                   .toString();
                         String title = ct_title;
                         String link = webhost + webadd + "?sjId=" + sj_id
                                   + "&ct_id=" + ct_id + "";
                         String pubDate = ct_create_time;

                         vecTitle.add(title);
                         vecLink.add(link);
                         vecPubDate.add(pubDate);
                         vecStatus.add("0");

                    }    
               }
               /**
                * 
                * 例外的XML组合部分。
                * 
                * */
              
               LiWaXML lwxml = new LiWaXML();
               lwxml.setVecLink(vecLink);
               lwxml.setVecTitle(vecTitle);
               lwxml.setVecPubDate(vecPubDate);
               lwxml.setVecStatus(vecStatus);
               lwxml.runxml_01(mDate);
               vecLink=lwxml.getVecLink();
               vecTitle=lwxml.getVecTitle();
               vecPubDate=lwxml.getVecPubDate();
               vecStatus =lwxml.getVecStatus();
               lwxml.endxml();
               /**
                * 完成
                * 
                * 
                * */
               
               
               xml.setXMLTableTree("title", vecTitle, "item");
               xml.setXMLTableTree("link", vecLink, "item");
               xml.setXMLTableTree("pubDate", vecPubDate, "item");
               xml.setXMLTableTree("status", vecStatus, "item");
               xml.XmlAddNew();
               
               //dImpl.setValue("ix_result", "0", CDataImpl.STRING);
          } catch (Exception e) {
               System.out.println(e);
               //dImpl.setValue("ix_result", "1", CDataImpl.STRING);
          }
          //dImpl.update();
          dImpl.closeStmt();
          dCn.closeCn();

     }
     
     public static void everydayXml(String begtime,String endtime)
     {
    	 Date begdate= Date.valueOf(begtime);
    	 
    	 
    	 Date endate= Date.valueOf(endtime);
    	 
    	long daynum = (endate.getTime()-begdate.getTime()) / (24*60*60*1000);
    	
    	Calendar calendar = Calendar.getInstance();
    	calendar.setTime(begdate);
    	
    	for(int i=1;i<daynum;i++)
    	{
    		calendar.add(Calendar.DATE,1);
    		SimpleDateFormat simpledate = new SimpleDateFormat("yyyy-MM-dd");
    		System.out.println(simpledate.format(calendar.getTime()));
    		
    		//VectorXML(simpledate.format(calendar.getTime()));
    	}
    	
    	
    	 
     }

     public static void main(String[] args) {
         //statrxml("2004-08-01","2005-08-01");
			SessionXmlwsbs.VectorXML(CDate.getThisday(),"2006-12-12","2006-12-14","","");
    	 System.out.println("============== " + CDate.getThisday());
    	 
    	 	//VectorXML("2005-11-8");
    	 	
    	 
     }
     }