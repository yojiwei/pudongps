/*
 * 创建日期 2005-7-7
 * 
 * TODO 要更改此生成的文件的模板，请转至 窗口 － 首选项 － Java － 代码样式 － 代码模板
 */

package com.website;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Hashtable;
import java.util.Vector;
import com.component.database.*;

public class SessionXml {

     public static String webhost = Messages.getString("SessXml.3");

     public static String webfile = Messages.getString("SessXml.5");

     public static String webadd = Messages.getString("SessXml.4");

     public static void statrxml(String staDate, String endData) {
          java.util.Date dtendDate = Date.valueOf(endData);
          CDataCn dCn = new CDataCn();
          CDataImpl dImpl = new CDataImpl(dCn);
          SimpleDateFormat dd = new SimpleDateFormat("yyyyMMdd");
          String mDate = dd.format(dtendDate);
          XmlImpl xml = new XmlImpl();
          xml.setTerFilePath(webfile + "/gb/xml/gsci" + mDate + ".xml");
          System.out.println("---"+webfile + "/gb/xml/gsci" + mDate + ".xml");
          xml.setXmlRoot("gsci");
          xml.addComment("各委办局网站主体信息内容");
          xml.addAttribute("version", "0.9");
          xml.setXMLTabSeed("title", "上海徐汇", "subsite");
          xml.setXMLTabSeed("link", webhost, "subsite");
          xml.setXMLTabSeed("copyright", "上海市徐汇区人民政府版权所有", "subsite");
          xml.setXMLTabSeed("subsite", "徐汇区", "subsite");
          xml.setXMLTabSeed("location", "2", "subsite");
          xml.setXMLTabSeed("item", "", "subsite");

          String sql = "select a.ct_id, a.ct_title, a.sj_id, a.ct_create_time, a.ct_newskind "
                    + "from tb_content a, tb_subject b "
                    + "where "
                    + "a.sj_id=b.sj_id and "
                    + "b.sj_dir in ('picture','impnews','latestnews','pickup','viewair') and "
                    + "a.ct_publish_flag=1 and "
                    + "to_date(a.CT_CREATE_TIME,'yyyy-mm-dd') >= to_date('"
                    + staDate
                    + "','yyyy-mm-dd') and  "
                    + "to_date(a.CT_CREATE_TIME,'yyyy-mm-dd') <=to_date('"
                    + endData
                    + "','yyyy-mm-dd') "
                    + "order by a.ct_sequence, to_date(a.CT_CREATE_TIME,'yyyy-mm-dd hh:mi:ss') desc, to_number(a.ct_id,'9999999') desc ";

         // System.out.println(sql);

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
          LiWaXML lwxml = new LiWaXML();
          lwxml.setVecLink(vecLink);
          lwxml.setVecTitle(vecTitle);
          lwxml.setVecPubDate(vecPubDate);
          lwxml.setVecStatus(vecStatus);
          lwxml.runxml(staDate,endData);
          vecLink=lwxml.getVecLink();
          vecTitle=lwxml.getVecTitle();
          vecPubDate=lwxml.getVecPubDate();
          vecStatus =lwxml.getVecStatus();
          lwxml.endxml();
          
          xml.setXMLTableTree("title", vecTitle, "item");
          xml.setXMLTableTree("link", vecLink, "item");
          xml.setXMLTableTree("pubDate", vecPubDate, "item");
          xml.setXMLTableTree("status", vecStatus, "item");
          xml.XmlAddNew();
          dImpl.closeStmt();
          dCn.closeCn();

     }

     public static void VectorXML(String stDate) {
          SimpleDateFormat dd = new SimpleDateFormat("yyyyMMdd");
          java.util.Date daDate = Date.valueOf(stDate);
          CDataCn dCn = new CDataCn();
          CDataImpl dImpl = new CDataImpl(dCn);
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
          try {
               XmlImpl xml = new XmlImpl();
               long myTime = (daDate.getTime() / 1000) - 60 * 60 * 24;
               daDate.setTime(myTime * 1000);
               String mDate = dd.format(daDate);
               xml.setTerFilePath(webfile + "/gb/xml/gsci" + mDate + ".xml");
               xml.setXmlRoot("gsci");
               xml.addComment("各委办局网站主体信息内容");
               xml.addAttribute("version", "0.9");
               xml.setXMLTabSeed("title", "上海徐汇", "subsite");
               xml.setXMLTabSeed("link", webhost, "subsite");
               xml.setXMLTabSeed("copyright", "上海市徐汇区人民政府版权所有", "subsite");
               xml.setXMLTabSeed("subsite", "徐汇区", "subsite");
               xml.setXMLTabSeed("location", "2", "subsite");
               xml.setXMLTabSeed("item", "", "subsite");
               String sql = "select a.ct_id, a.ct_title, a.sj_id,a.ct_create_time, a.ct_newskind "
                         + "from tb_content a,tb_subject b "
                         + "where "
                         + "a.sj_id=b.sj_id and "
                         + "b.sj_dir in ('picture','impnews','latestnews','pickup','viewair') and "
                         + "a.ct_publish_flag=1 and "
                         + "to_date(a.CT_CREATE_TIME,'yyyy-mm-dd') = to_date('"
                         + mDate
                         + "','yyyy-mm-dd') "
                         + "order by a.ct_sequence, to_date(a.CT_CREATE_TIME,'yyyy-mm-dd hh:mi:ss') desc,"
                         + " to_number(a.ct_id,'9999999') desc ";
               //System.out.println(sql);

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
               lwxml.runxml(mDate);
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
               dImpl.setValue("ix_result", "0", CDataImpl.STRING);
          } catch (Exception e) {
               System.out.println(e);
               dImpl.setValue("ix_result", "1", CDataImpl.STRING);
          }
          dImpl.update();
          dImpl.closeStmt();
          dCn.closeCn();

     }

     public static void main(String[] args) {
         // statrxml("2004-08-01","2005-08-01");
    	 	VectorXML("2005-8-6");
    	 	
    	 
     }
     }