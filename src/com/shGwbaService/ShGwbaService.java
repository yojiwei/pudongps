package com.shGwbaService;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.TimerTask;
import java.util.UUID;
import java.util.Vector;

import org.apache.commons.io.FileUtils;
import org.apache.http.client.HttpClient;

import com.alibaba.fastjson.JSONObject;
import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.component.database.MyCDataCn;
import com.component.database.MyCDataImpl;
import com.util.CTools;

/**
 * 2019年新点开发的上海市公文备案信息发布接口
 * @author Administrator
 *
 */
public class ShGwbaService  extends TimerTask{
	
	/**
	 * 执行监听的方法
	 */
	public void run(){
		//自动同步公文备案OA
		sendShGwbaAutoOa();
		//自动同步公文备案网站
		sendShGwbaAutoWeb();
	}
	
	
	/***
	 * 
	 * 公文备案对平台接口（OA）
	 * 新增、修改
	 * http://117.184.226.173/zwgk_interface/rest/archivebaserestaction/addoreditarchive_oa
	 * （政务外网）
	 * http://10.81.17.123:8080/EpointSHzwdt/rest/archivebaserestaction/addoreditarchive_oa
	 * 删除
	 * 互联网
	 * http://117.184.226.173/zwgk_interface/rest/archivebaserestaction/delarchive_oa
	 * （政务外网）
	   http://10.81.17.123:8080/EpointSHzwdt/rest/archivebaserestaction/delarchive_oa
	 */
	public void sendShGwbaAutoOa() {
		Map<String, Object> map = new HashMap<String, Object>();

		String ret = "";
		String xxgkJson = "";
		String xxgksql = "";
		String reback = "";
		String shUrl = "http://10.81.17.123:8080/EpointSHzwdt/rest/archivebaserestaction/addoreditarchive_oa";
		CDataCn cDn=null;
		CDataImpl dImpl=null;
		Hashtable table=null;
		Vector vPage=null;
		try {
			
			cDn = new CDataCn();
			dImpl =new CDataImpl(cDn);
			//发送2000年以后的，属于公文的
			xxgksql = "select c.ct_id as ct_id,c.ct_title as ct_title,c.in_filenum as in_filenum,d.dt_shortname as dt_name,decode(c.in_dzhhxx,0,'N',1,'Y','N') as " +
						"in_dzhhxx, c.ct_create_time as ct_create_time," +
						"decode(c.in_gongkaitype,0,'001',1,'002','2','003','3','003') as  in_gongkaitype,decode(c.in_govopencarriertype,'','其他',c.in_govopencarriertype) as in_govopencarriertype, " +
						"decode(c.in_colseid,1,'002','2','003','3','005','5','007') as in_colseid,cd.ct_content as ct_content,c.ct_memo as ct_memo,substr(replace(replace(replace(replace(replace(replace(replace(replace(in_filenum,'（','('),'）',')'),'〔','('),'〕',')'),'【','('),'】',')'),'[','('),']',')'),0,INSTR(replace(replace(replace(replace(replace(replace(replace(replace(in_filenum,'（','('),'）',')'),'〔','('),'〕',')'),'【','('),'】',')'),'[','('),']',')'), '(2')-1) as filenumber1,substr(replace(replace(replace(replace(replace(replace(replace(replace(in_filenum,'（','('),'）',')'),'〔','('),'〕',')'),'【','('),'】',')'),'[','('),']',')'),INSTR(replace(replace(replace(replace(replace(replace(replace(replace(in_filenum,'（','('),'）',')'),'〔','('),'〕',')'),'【','('),'】',')'),'[','('),']',')'), '(2')+1,4) as filenumber2,replace(replace(replace(replace(substr(replace(replace(replace(replace(replace(replace(replace(replace(in_filenum,'（','('),'）',')'),'〔','('),'〕',')'),'【','('),'】',')'),'[','('),']',')'),INSTR(replace(replace(replace(replace(replace(replace(replace(replace(in_filenum,'（','('),'）',')'),'〔','('),'〕',')'),'【','('),'】',')'),'[','('),']',')'), '(2')+6,100),'号',''),'第',''),'批次',''),')','') as filenumber3," +
						"decode(c.in_gongwentype,0,'命令（令）',1,'决定','2','公告','3','通告','4','通知','5','通报','6','议案','7','报告','8','请示','9','批复','10','意见','11','函','12','会议纪要') as in_gongwentype, " +
						"decode(c.in_subjectid,0,'机构职能',1,'政策法规','2','规划计划','3','业务类','9','其它') as in_subjectid, decode(c.in_draft,0,'N',1,'Y','N') as in_draft,decode(c.in_isgw,0,'N',1,'Y') as in_isgw," +
						"decode(c.in_specsfile,0,'N',1,'Y','N') as in_specsfile,decode(c.in_zutici1,'','12125',c.in_zutici1) as in_zutici1,decode(c.in_zutici2,'','12253',c.in_zutici2) as in_zutici2,decode(c.in_zupeitype,'','其它',c.in_zupeitype) as in_zupeitype,d.dt_zzjgdm,d.dt_shortname " +
						"from tb_content c,tb_deptinfo d,tb_contentdetail cd  where c.isgosh = '0'  and in_filenum is not null and in_filenum <> '无'   and in_isgw = 1 and ct_sendtime > '2019-01-01'  and c.dt_id = d.dt_id and c.ct_id = cd.ct_id  order by c.ct_id desc";
			
			System.out.println("sendShGwbaAutoOa---------"+xxgksql);
			
			StringBuffer strB= new StringBuffer();
			
			vPage = dImpl.splitPage(xxgksql, 10,1);//最多取100条
			if(vPage!=null){
				for(int i=0;i<vPage.size();i++){
					table =(Hashtable)vPage.get(i);
					
					
			HashMap<String, Object> record = new HashMap();
			record.put("rowguid", CTools.dealNull(table.get("ct_id")));
			record.put("doctitle", CTools.dealNull(table.get("ct_title")));
			record.put("formdate", CTools.dealNull(table.get("ct_create_time")));
			record.put("authunitname", CTools.dealNull(table.get("dt_shortname")));
			record.put("filenumber1", getIn_filenum(CTools.dealNull(table.get("filenumber1"))));
			record.put("filenumber2", getIn_filenum(CTools.dealNull(table.get("filenumber2"))));
			record.put("filenumber3", getIn_filenum(CTools.dealNull(table.get("filenumber3"))));
			record.put("opentype", CTools.dealNull(table.get("in_gongkaitype")));
			record.put("notopenreason", CTools.dealNull(table.get("in_colseid")));
			
			List<HashMap> attachFiles = new ArrayList<HashMap>();
//			File file1 = new File("xxx");
//			HashMap att1 = new HashMap();
//			att1.put("attcontent", FileUtils.readFileToByteArray(file1));
//			att1.put("attfilename", file1.getName());
			//attachFiles.add(att1);
			record.put("attachfiles", attachFiles);
			
			
			map.put("params", JSONObject.toJSONString(record));
			
			ret = RunPost.post(shUrl, map);
			System.out.println("result==============="+ret);
			
			//修改数据isgosh
			updateContent(CTools.dealNull(table.get("ct_id")),ret,dImpl);
			
				}
			}
		
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}finally{
				if(dImpl!=null)
					dImpl.closeStmt();
				if(cDn!=null)
					cDn.closeCn();
			}
	}
	
	/**
	 * 公文备案对平台接口（网站）
	 * 互联网地址
	 * http://117.184.226.173/zwgk_interface/rest/archivebaserestaction/addoreditarchive_web
	 * 政务网地址
	   http://10.81.17.123:8080/EpointSHzwdt/rest/archivebaserestaction/addoreditarchive_web
	 */
	public void sendShGwbaAutoWeb() {
		Map<String, Object> map = new HashMap<String, Object>();

		String ret = "";
		String xxgkJson = "";
		String xxgksql = "";
		String reback = "";
		String shUrl = "http://10.81.17.123:8080/EpointSHzwdt/rest/archivebaserestaction/addoreditarchive_web";
		MyCDataCn cDn=null;
		MyCDataImpl dImpl=null;
		Hashtable table=null;
		Vector vPage=null;
		try {
			
			cDn = new MyCDataCn();
			dImpl =new MyCDataImpl(cDn);
			//发送2000年以后的，属于公文的
			xxgksql = "select top 100 contentid as ct_id,title as ct_title,serialno as in_catchnum," + 
					"Substring(replace(replace(replace(replace(replace(replace(replace(replace(fileno,'（','('),'）',')'),'〔','('),'〕',')'),'【','('),'】',')'),'[','('),']',')'),0,CHARINDEX('(2',replace(replace(replace(replace(replace(replace(replace(replace(fileno,'（','('),'）',')'),'〔','('),'〕',')'),'【','('),'】',')'),'[','('),']',')'))) as filenumber1," + 
					"Substring(replace(replace(replace(replace(replace(replace(replace(replace(fileno,'（','('),'）',')'),'〔','('),'〕',')'),'【','('),'】',')'),'[','('),']',')') ,CHARINDEX('(2',replace(replace(replace(replace(replace(replace(replace(replace(fileno,'（','('),'）',')'),'〔','('),'〕',')'),'【','('),'】',')'),'[','('),']',')') )+1,4) as filenumber2," + 
					"replace(replace(replace(replace(Substring(replace(replace(replace(replace(replace(replace(replace(replace(fileno,'（','('),'）',')'),'〔','('),'〕',')'),'【','('),'】',')'),'[','('),']',')') ,CHARINDEX('(2',replace(replace(replace(replace(replace(replace(replace(replace(fileno,'（','('),'）',')'),'〔','('),'〕',')'),'【','('),'】',')'),'[','('),']',')') )+5,Len(replace(replace(replace(replace(replace(replace(replace(replace(fileno,'（','('),'）',')'),'〔','('),'〕',')'),'【','('),'】',')'),'[','('),']',')') )),'号',''),'第',''),'批次',''),')','') as filenumber3" + 
					",createtime as ct_create_time,starttime as ct_inserttime,'http://www.pudong.gov.cn/shpd/InfoOpen/InfoDetail.aspx?Id='+convert(varchar,contentid) as openurl,content as ct_content " + 
					"from content where fileno is not null and fileno <> '' and opentype = '1' and contentid_old is not null and isgosh = '0' and createtime > '2019-01-01' order by contentid desc";
			
			System.out.println("sendShGwbaAutoWeb---------"+xxgksql);
			
			StringBuffer strB= new StringBuffer();
			 
			vPage = dImpl.splitPage(xxgksql, 10,1);//最多取100条
			if(vPage!=null){
				for(int i=0;i<vPage.size();i++){
					table =(Hashtable)vPage.get(i);
					
					
			HashMap<String, Object> record = new HashMap();
			record.put("rowguid", CTools.dealNull(table.get("ct_id")));
			record.put("doctitle", CTools.dealNull(table.get("ct_title")));
			record.put("syid", CTools.dealNull(table.get("in_catchnum")));
			record.put("filenumber1", getIn_filenum(CTools.dealNull(table.get("filenumber1"))));
			record.put("filenumber2", getIn_filenum(CTools.dealNull(table.get("filenumber2"))));
			record.put("filenumber3", getIn_filenum(CTools.dealNull(table.get("filenumber3"))));
			
			record.put("archdate", CTools.dealNull(table.get("ct_create_time")));
			record.put("pubdate", CTools.dealNull(table.get("ct_inserttime")));
			record.put("openurl", CTools.dealNull(table.get("openurl")));
			record.put("content", CTools.dealNull(table.get("ct_content")).replaceAll("\"/attach/infoattach/", "\"http://www.pudong.gov.cn/UpLoadPath/PublishInfo/"));
			
			List<HashMap> attachFiles = new ArrayList<HashMap>();
//			File file1 = new File("xxx");
//			HashMap att1 = new HashMap();
//			att1.put("attcontent", FileUtils.readFileToByteArray(file1));
//			att1.put("attfilename", file1.getName());
			//attachFiles.add(att1);
			record.put("attachfiles", attachFiles);
			
			
			map.put("params", JSONObject.toJSONString(record));
			
			ret = RunPost.post(shUrl, map);
			System.out.println("result==============="+ret);
			
			//修改数据isgosh2
			updateContent2(CTools.dealNull(table.get("ct_id")),ret,dImpl);
			
				}
			}
		
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}finally{
				if(dImpl!=null)
					dImpl.closeStmt();
				if(cDn!=null)
					cDn.closeCn();
			}
	}
	
	/**
	 * 删除公文备案OA数据
	 * http://117.184.226.173/zwgk_interface/rest/archivebaserestaction/delarchive_oa
	 * http://10.81.17.123:8080/EpointSHzwdt/rest/archivebaserestaction/delarchive_oa
	 */
	public void deleteShGwbaAutoOa(String ct_ids) {
		Map<String, Object> map = new HashMap<String, Object>();

		String ret = "";
		String xxgkJson = "";
		String xxgksql = "";
		String reback = "";
		String shUrl = "http://117.184.226.173/zwgk_interface/rest/archivebaserestaction/delarchive_oa";
		CDataCn cDn=null;
		CDataImpl dImpl=null;
		Hashtable table=null;
		Vector vPage=null;
		try {
			
			cDn = new CDataCn();
			dImpl =new CDataImpl(cDn);
						
			xxgksql = "select c.ct_id as ct_id from tb_content c  where c.ct_id in("+ct_ids+")  order by c.ct_id desc";
			
			System.out.println("---------"+xxgksql);
			
			StringBuffer strB= new StringBuffer();
			
			vPage = dImpl.splitPage(xxgksql, 10,1);//最多取10条
			if(vPage!=null){
				for(int i=0;i<vPage.size();i++){
					table =(Hashtable)vPage.get(i);
					
					
			HashMap<String, Object> record = new HashMap();
			record.put("rowguid", CTools.dealNull(table.get("ct_id")));

			map.put("params", JSONObject.toJSONString(record));
			
			ret = RunPost.post(shUrl, map);
			System.out.println("result==============="+ret);
			
			//删除数据isgosh
			updateContent(CTools.dealNull(table.get("ct_id")),ret,dImpl);
			
				}
			}
		
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}finally{
				if(dImpl!=null)
					dImpl.closeStmt();
				if(cDn!=null)
					cDn.closeCn();
			}
	}
	
	/**
	 * 删除公文备案网站数据
	 * http://117.184.226.173/zwgk_interface/rest/archivebaserestaction/delarchive_web
	 * http://10.81.17.123:8080/EpointSHzwdt/rest/archivebaserestaction/delarchive_web
	 */
	public void deleteShGwbaAutoWeb(String ct_ids) {
		Map<String, Object> map = new HashMap<String, Object>();

		String ret = "";
		String xxgkJson = "";
		String xxgksql = "";
		String reback = "";
		String shUrl = "http://117.184.226.173/zwgk_interface/rest/archivebaserestaction/delarchive_web";
		MyCDataCn cDn=null;
		MyCDataImpl dImpl=null;
		Hashtable table=null;
		Vector vPage=null;
		try {
			
			cDn = new MyCDataCn();
			dImpl =new MyCDataImpl(cDn);
						
			xxgksql = "select c.contentid as ct_id from content c  where c.contentid in("+ct_ids+")  order by c.contentid desc";
			
			System.out.println("---------"+xxgksql);
			
			StringBuffer strB= new StringBuffer();
			
			vPage = dImpl.splitPage(xxgksql, 10,1);//最多取10条
			if(vPage!=null){
				for(int i=0;i<vPage.size();i++){
					table =(Hashtable)vPage.get(i);
					
					
			HashMap<String, Object> record = new HashMap();
			record.put("rowguid", CTools.dealNull(table.get("ct_id")));

			map.put("params", JSONObject.toJSONString(record));
			
			ret = RunPost.post(shUrl, map);
			System.out.println("result==============="+ret);
			
			//删除数据isgosh2
			updateContent2(CTools.dealNull(table.get("ct_id")),ret,dImpl);
			
				}
			}
		
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}finally{
				if(dImpl!=null)
					dImpl.closeStmt();
				if(cDn!=null)
					cDn.closeCn();
			}
	}
	
	
	
	/**
	 * 公文备案对平台接口（网站）
	 * 互联网地址
	 * http://117.184.226.173/zwgk_interface/rest/archivebaserestaction/infostat
	 * 政务网地址
	   http://10.81.17.123:8080/EpointSHzwdt/rest/archivebaserestaction/infostat
	 */
	public void gwbaCount() {
		Map<String, Object> map = new HashMap<String, Object>();

		String ret = "";
		String shUrl = "http://117.184.226.173/zwgk_interface/rest/archivebaserestaction/infostat";

		try {
			
			StringBuffer strB= new StringBuffer();
			
			HashMap<String, Object> record = new HashMap();
			record.put("infocount", "1");
			record.put("infotype", "policyinfo");//全网站当月更新信息数量：cmsinfo，公文当月更新数量：docinfo，政策解读当月更新数量：policyinfo
			record.put("statdate", "2019-10-16");
			record.put("website", "http://www.pudong.gov.cn");
			
			map.put("params", JSONObject.toJSONString(record));
			
			ret = RunPost.post(shUrl, map);
			System.out.println("result==============="+ret);
			
			
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
	}
	
	
	/**
	 * 修改信息isgosh
	 * @param ct_id
	 * @param reback
	 */
	public void updateContent(String ct_id,String reback,CDataImpl dImpl){
		try {
			dImpl.executeUpdate("update tb_content set isgosh='"+reback+"' where ct_id='" + ct_id + "'");
			dImpl.update();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	/**
	 * 同步公文备案网站成功
	 * 修改信息isgosh2
	 * @param ct_id
	 * @param reback
	 * @param dImpl
	 */
	public void updateContent2(String ct_id,String reback,MyCDataImpl dImpl){
		try {
			dImpl.executeUpdate("update content set isgosh='"+reback+"' where contentid='" + ct_id + "'");
			dImpl.update();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	/**
	 * 获取主题词值
	 * @param dv_id
	 * @return
	 */
	public String getZctValue(CDataImpl dImpl,String dv_id){
		Hashtable ztcContent = null;
		String ztcSql = "";
		String dv_value = "";
		try {
			ztcSql = "select dv_value from tb_datavalue where dv_id = "+dv_id;
			ztcContent=dImpl.getDataInfo(ztcSql);
			if(ztcContent!=null){
				dv_value = CTools.dealNumber(ztcContent.get("dv_value"));
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return dv_value;
	}
	/**
	 * 文号格式修改
	 * @param in_filenum
	 * @return
	 */
	public String getIn_filenum(String in_filenum){
		if(!"".equals(in_filenum)){
		in_filenum = in_filenum.replace('[','〔');
		in_filenum = in_filenum.replace(']','〕');
		
		in_filenum = in_filenum.replace('(','〔');
		in_filenum = in_filenum.replace(')','〕');
		
		in_filenum = in_filenum.replace('（','〔');
		in_filenum = in_filenum.replace('）','〕');
		
		in_filenum = in_filenum.replace('﹝','〔');
		in_filenum = in_filenum.replace('﹞','〕');
		
		in_filenum = in_filenum.replace('【','〔');
		in_filenum = in_filenum.replace('】','〕');
		
		}
		
		return in_filenum;
		
	}
	
	/**
	 * main方法
	 * @param args
	 */
	public static void main(String args[]) {
		ShGwbaService sgs = new ShGwbaService();

		String ct_ids = "485956";
		
		//新增公文备案OA
		//sgs.sendShGwbaAutoOa();
		//新增公文备案网站
		//sgs.sendShGwbaAutoWeb();
		//删除公文备案OA
		//sgs.deleteShGwbaAutoOa(ct_ids);
		//删除公文备案网站
		//sgs.deleteShGwbaAutoWeb(ct_ids);
		//信息更新量
		sgs.gwbaCount();
		
	}
	
	
}
