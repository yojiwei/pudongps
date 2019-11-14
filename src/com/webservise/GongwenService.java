package com.webservise;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.gongwen.PushCatHttpBindingStub;
import com.gongwen.PushCatLocator;
import com.util.CDate;
import com.util.CFile;
import com.util.CTools;
import java.io.PrintStream;
import java.rmi.RemoteException;
import java.util.Hashtable;
import java.util.Vector;
import javax.xml.rpc.ServiceException;
import junit.framework.AssertionFailedError;

public class GongwenService
{
  public static void main(String[] args)
  {
    GongwenService service = new GongwenService();
    //service.sendToShanghai();
  }
  public GongwenService(){}

//  public Vector getAllDataToService()
//  {
//    String sql = "select cm_id,cm_type,ct_id,cm_dtcode,sj_id,(cm_sh_errornum+1)as cm_sh_errornum from tb_contentmessage where nvl(cm_sh_result,0)!=1 and nvl(cm_sh_errornum,0)<5   order by cm_id asc";
//
//    CDataCn dCn = null;
//    CDataImpl dImpl = null;
//    Vector result = null;
//    try
//    {
//      dCn = new CDataCn();
//      dImpl = new CDataImpl(dCn);
//      result = dImpl.splitPage(sql, 1000, 1);
//    } catch (Exception e) {
//      System.out.println(CDate.getNowTime() + "-->" + 
//        "GongwenService : getAllDataToService " + e.getMessage());
//    } finally {
//      dImpl.closeStmt();
//      dCn.closeCn();
//    }
//    return result;
//  }
//
//  public void sendToShanghai()
//  {
//    Vector result = getAllDataToService();
//    Hashtable contentTab = null;
//    String ct_id = "";
//    String cm_id = "";
//    String cm_type = "";
//    String cm_errornum = "";
//    StringBuffer xmlStr = new StringBuffer("");
//    String rtnStr = "";
//    StringBuffer xml = new StringBuffer("");
//
//    if (result != null)
//    {
//      for (int cnt = 0; cnt < result.size(); ++cnt) {
//        xml = new StringBuffer();
//        xml.append("<?xml version=\"1.0\" encoding=\"GB2312\"?>");
//        xml.append("<sync_docMetadatas>");
//        contentTab = (Hashtable)result.get(cnt);
//        cm_id = CTools.dealNull(contentTab.get("cm_id"));
//        ct_id = CTools.dealNull(contentTab.get("ct_id"));
//
//        cm_errornum = CTools.dealNull(contentTab.get("cm_sh_errornum"));
//        cm_type = CTools.dealNull(contentTab.get("cm_type"));
//        //
////        ct_id = "236772";
////        cm_type = "1";
//        
//        xmlStr = getContentXml(ct_id, cm_type);
//        
//        if ("1".equals(cm_type)) {
//          xml.append("<new_docMetadatas>");
//          xml.append(xmlStr);
//          xml.append("</new_docMetadatas>");
//        } else if ("2".equals(cm_type)) {
//          xml.append("<edit_docMetadatas>");
//          xml.append(xmlStr);
//          xml.append("</edit_docMetadatas>");
//        } else if ("3".equals(cm_type)) {
//          xml.append("<delete_docMetadata>");
//
//          xml.append("<org_id>");
//          xml.append(CTools.dealNull(contentTab.get("cm_dtcode")));
//          xml.append("</org_id>");
//
//          xml.append("<REMOTE_ID>");
//          xml.append(ct_id);
//          xml.append("</REMOTE_ID>");
//          xml.append("</delete_docMetadata>");
//        }
//        xml.append("</sync_docMetadatas>");
//        
//        
//        CDataCn dCn = null;
//        CDataImpl dImpl = null;
//        
//        try
//        {
//        	
//        	dCn = new CDataCn();
//            dImpl = new CDataImpl(dCn);
//        	
//          if ("".equals(xmlStr)) break;
//          rtnStr = HttpPortPushCat(xml.toString());
//          System.out.println(ct_id+"==================rtnStr-------------"+rtnStr.toString()+rtnStr.indexOf("成功"));
//          
//          //报错位置
//          if(rtnStr.indexOf("成功") < 0){
//        	  CFile.write(dImpl.getInitParameter("sendtosherror_path")+CDate.getThisday()+ct_id+".xml",rtnStr.toString()+"---------"+xml.toString());
//          }
//        }
//        catch (Exception e)
//        {
//          System.out.println(CDate.getNowTime() + "-->" + 
//            "GongwenService : sendToShanghai " + 
//            e.getMessage());
//        }finally{
//        	dImpl.closeStmt();
//            dCn.closeCn();
//        }
//        //updateContentMessage(cm_id, cm_errornum, rtnStr);
//      }
//    }
//  }
//
//  public String HttpPortPushCat(String xml)
//    throws Exception
//  {
//    String rtnStr = "";
//    try {
//      PushCatHttpBindingStub binding = (PushCatHttpBindingStub)new PushCatLocator().getPushCatHttpPort
//        ();
//      binding.setTimeout(60000);
//      rtnStr = binding.pushCat(xml);
//    } catch (ServiceException jre) {
//      if (jre.getLinkedCause() != null)
//        jre.getLinkedCause().printStackTrace();
//      throw new AssertionFailedError(
//        "JAX-RPC ServiceException caught: " + jre);
//    }
//    catch (RemoteException e) {
//      System.out.println(CDate.getNowTime() + "-->" + 
//        "GongwenService : HttpPortPushCat " + e.getMessage());
//    }
//    return rtnStr;
//  }
//
//  public boolean updateContentMessage(String cm_id, String cm_errornum, String rtnStr)
//  {
//    CDataCn dCn = null;
//    CDataImpl dImpl = null;
//    boolean flag = false;
//    try {
//      dCn = new CDataCn();
//      dImpl = new CDataImpl(dCn);
//      dImpl.edit("tb_contentmessage", "cm_id", cm_id);
//      if (rtnStr.indexOf("成功") != -1) {
//        dImpl.setValue("cm_sh_result", "1", 0);
//      }
//      else {
//        dImpl.setValue("cm_sh_result", "2", 0);
//
//        dImpl.setValue("cm_sh_errornum", String.valueOf(
//        Integer.parseInt(CTools.dealNumber(cm_errornum))),0);
//      }
//      dImpl.setValue("cm_updatetime", CDate.getThisday(),3);
//      flag = dImpl.update();
//
//      dImpl.setTableName("tb_contentmessagelog");
//      dImpl.setPrimaryFieldName("cl_id");
//      dImpl.addNew();
//      dImpl.setValue("cm_id", cm_id, 0);
//      dImpl.setValue("cl_returnmessage", rtnStr, 3);
//      flag = (flag) && (dImpl.update());
//    } catch (Exception e) {
//      System.out.println
//        (CDate.getNowTime() + "-->" + 
//        "GongwenService : updateContentMessage " + 
//        e.getMessage());
//    } finally {
//      dImpl.closeStmt();
//      dCn.closeCn();
//    }
//
//    return flag;
//  }
//
//  public StringBuffer getContentXml(String ct_id, String cm_type)
//  {
//    StringBuffer content = new StringBuffer();
//    String sql = "select in_catchnum,ct_title,in_filenum,to_char(to_date(ct_create_time,'yyyy-MM-dd'),'yyyy-MM-dd')||' 00:00:00.0' as ct_create_time,dt.dt_code,dt.dt_name,in_subjectid,in_gongwentype,in_gongkaitype,in_colseid,ct_memo,ct_keywords,in_carriertype,in_infotype,in_specsfile,in_draft from tb_content t,tb_deptinfo dt where t.dt_id = dt.dt_id and dt.dt_code not in ('XB7','XC6','XB8','XB4') and ct_id='" + 
//      ct_id + "'";
//    //System.out.println("sql===="+sql);
//    CDataCn dCn = null;
//    CDataImpl dImpl = null;
//    Hashtable contentTab = null;
//    try {
//      dCn = new CDataCn();
//      dImpl = new CDataImpl(dCn);
//
//      contentTab = dImpl.getDataInfo(sql);
//      
//      if ("1".equals(cm_type))
//        content.append("<new_docMetadata>");
//      else if ("2".equals(cm_type)) {
//        content.append("<edit_docMetadata>");
//      }
//
//      content.append("<REMOTE_ID>");
//      content.append(ct_id);
//      content.append("</REMOTE_ID>");
//
//      if(contentTab!=null){
//      
//      content.append("<docID>");
//      content.append(CTools.dealNull(contentTab.get("in_catchnum")));
//      content.append("</docID>");
//
//      content.append("<docTitle>");
//      content.append(CTools.dealNull(contentTab.get("ct_title")));
//      content.append("</docTitle>");
//
//      content.append("<docNum>");
//      content.append(CTools.dealNull(contentTab.get("in_filenum")));
//      content.append("</docNum>");
//
//      content.append("<createDate>");
//      content.append(
//        CTools.dealNull(contentTab.get("ct_create_time")));
//      content.append("</createDate>");
//
//      content.append("<org_id>");
//      content.append(CTools.dealNull(contentTab.get("dt_code")));
//      content.append("</org_id>");
//
//      content.append("<topic>");
//      if (CTools.dealNull(contentTab.get("in_catchnum")).trim().length() >= 4)
//        content.append(CTools.dealNull(contentTab.get("in_catchnum")).substring(3, 4));
//      else
//        content.append("9");
//      content.append("</topic>");
//
//      content.append("<category>");
//      content.append(
//        CTools.dealNull(contentTab.get("in_gongwentype")));
//      content.append("</category>");
//
//      content.append("<pubClass>");
//      content.append(
//        CTools.dealNull(contentTab.get("in_gongkaitype")));
//      content.append("</pubClass>");
//
//      content.append("<noPubDesc>");
//      content.append(CTools.dealNull(contentTab.get("in_colseid")));
//      content.append("</noPubDesc>");
//
//      content.append("<abstract>");
//      content.append(CTools.dealNull(contentTab.get("ct_memo")));
//      content.append("</abstract>");
//
//      content.append("<keyword>");
//      content.append(CTools.dealNull(contentTab.get("ct_keywords")));
//      content.append("</keyword>");
//
//      content.append("<format>");
//      content.append(
//        CTools.dealNull(contentTab.get("in_carriertype")));
//      content.append("</format>");
//
//      content.append("<type>");
//      content.append(CTools.dealNull(contentTab.get("in_infotype")));
//      content.append("</type>");
//
//      content.append("<normalSign>");
//      content.append(CTools.dealNull(contentTab.get("in_specsfile")));
//      content.append("</normalSign>");
//
//      content.append("<draftSign>");
//      content.append(CTools.dealNull(contentTab.get("in_draft")));
//      content.append("</draftSign>");
//
//      }
//      
//      if ("1".equals(cm_type)) {
//        content.append("</new_docMetadata>");
//      }
//      if ("2".equals(cm_type)) 
//    	  content.append("</edit_docMetadata>");
//      }
//    
//    catch (Exception e)
//    {
//      System.out.println(CDate.getNowTime() + "-->" + 
//        "GongwenService : getContentXml " + e.getMessage());
//    } finally {
//      dImpl.closeStmt();
//      dCn.closeCn();
//    }
//    return content;
//  }
}