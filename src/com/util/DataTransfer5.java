package com.util;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Vector;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

/**
 * <p>Program Name:浦东信息统一报送</p>
 * <p>Module Name:工具类</p>
 * <p>Function:将原来"部门信息公开"的数据转换到现在使用的数据库</p>
 * <p>Create Time: 2006-6-6 13:39:48</p>
 * @author: yanker
 * @version: 
 */
public class DataTransfer5 {

	
	private String[] deptInfo = {"政府部门","街道、镇"};
	private static int totalCnt = 0;
	
	private void doInsertTable(int parentId){
		int subjectId = -1;
		String dtName = "";
		String tempSjId = "";
		
		int dtId = -1;
		Vector vector = null;
		String sql = "";
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		try{
			for(int cnt = 0;cnt < deptInfo.length;cnt++){
				tempSjId = getSjId(deptInfo[cnt],parentId);
				if("-1".equals(tempSjId)){
					//将子栏目插入到“政府信息公开指南”
					doInsertSubject(deptInfo[cnt],parentId,-1);
					subjectId = getMaxID("tb_subject");
				}else{
					subjectId = Integer.parseInt(tempSjId);
				}
				
				//得到该子栏目下的部门名称和ID
				sql = "select dt_name,dt_id from tb_deptinfo where dt_type="+(cnt + 1) +
						" and dt_name not like '%新区人民政府%' and dt_isinfoopen='1' order by dt_sequence";
				
				vector = dImpl.splitPage(sql,70,1);
				if(vector != null){
					for(int count = 0;count < vector.size();count++){
						if(((Hashtable)vector.get(count)).get("dt_id") != null)
							dtId = Integer.parseInt(((Hashtable)vector.get(count)).get("dt_id").toString());
						if(((Hashtable)vector.get(count)).get("dt_name") != null)
							dtName = ((Hashtable)vector.get(count)).get("dt_name").toString();
						doInsert(dtId,dtName,subjectId);
					}
				}
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertTable " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
	}
	
	private int getMaxID(String tablename){
		int maxId = 1;
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		Vector vector = null;
		try{
			vector = dImpl.splitPage("select rc_maxid from tb_rowcount where rc_tablename = '"+ tablename +"'",10,1);
			if(vector != null){
				maxId = Integer.parseInt(((Hashtable)vector.get(0)).get("rc_maxid").toString());
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::getMaxID " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return maxId;
	}
	
	public void doInsert(int dtId,String dtName,int subjectId){
		String tempSjId = "";
		int nexSubjectId = -1;
		String tiName = "";
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		int tiId = -1;
		String sql = "";
		Vector vector = null;
		tempSjId = getSjId(dtName,subjectId);
		try{
			if("-1".equals(tempSjId)){
				//三极栏目
				doInsertSubject(dtName,subjectId,-1);
				nexSubjectId = getMaxID("tb_subject");
			}else{
				nexSubjectId = Integer.parseInt(tempSjId);
			}
			//得到部门在tb_title中的记录插入到TB_SUBJECT,TB_CONTENT
			sql = "select t.ti_id, t.ti_name,t.ti_ownerdtid from tb_title t where t.ti_upperid =0 " +
					"and (t.imp_status is null or t.imp_status = 0) " +
					"and (t.ti_ownerdtid=" + dtId + " or t.ti_ownerdtid=-1) order by t.ti_sequence";
			vector = dImpl.splitPage(sql,4000,1);
			if(vector != null){
				for(int k = 0;k< vector.size();k++){
					
					if(((Hashtable)vector.get(k)).get("ti_name") != null)
						tiName = ((Hashtable)vector.get(k)).get("ti_name").toString();
					
					if(((Hashtable)vector.get(k)).get("ti_id") != null)
						tiId = Integer.parseInt(((Hashtable)vector.get(k)).get("ti_id").toString());
					
					if(((Hashtable)vector.get(k)).get("ti_ownerdtid") == null)
						dtId = -1;
					else
						dtId = Integer.parseInt(((Hashtable)vector.get(k)).get("ti_ownerdtid").toString());
					doInsert2(tiId,tiName,nexSubjectId,dtId);
				}
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsert " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
	}
	
	private void doInsert2(int tiId,String tiName,int subjectId,int dtId){
		int nexSubjectId = -1;
		ArrayList nextSubTitIdList = new ArrayList();
		int nextSubTiId = -1;
		String nextSubTiName = "";
		String tempSjId = "";
		String inTitle = "";
		String inContent = "";
		String ctCreateTime = "";
		Hashtable table = null;
		int inId = -1;
		String sql = "";
//		System.out.println(" dtId= " + dtId + "   tiId = " + tiId);
		Vector vector = null;
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		
		if(!"-1".equals(String.valueOf(dtId)) && !"".equals(String.valueOf(dtId))){
			sql = "select t.in_title,t.in_content, t.in_id, to_char(t.in_inputtime,'yyyy-MM-DD') as in_inputtime, t.in_category,t.in_linkaddress " +
			"from tb_info t,tb_title s where t.imp_status <> 1 and t.ti_id=s.ti_id and t.in_publishdtid='"+ dtId +"' " +
			" and (t.in_deleteflag='1' or t.in_deleteflag is null) " //and s.ti_id = "+ tiId 
			+" order by t.in_sequence,t.in_publishtime desc";
		}else{
			sql = "select t.in_title, t.in_id, to_char(t.in_inputtime,'yyyy-MM-DD') as in_inputtime, t.in_category,in_linkaddress from tb_info t," +
					"tb_title s where 1=1 and t.ti_id=s.ti_id  and (t.in_deleteflag='1' or t.in_deleteflag is null) " 
					//+ " and s.ti_id = "+tiId 
					+ " order by t.in_sequence, t.in_publishtime desc";
		}
		
		
		try{
			tempSjId = getSjId(tiName,subjectId);
			//插入栏目
			if("-1".equals(tempSjId)){
				doInsertSubject(tiName,subjectId,tiId);
				nexSubjectId = getMaxID("tb_subject");
			}else{
				nexSubjectId = Integer.parseInt(tempSjId);
			}
			//插入栏目对应的信息
			vector = dImpl.splitPage(sql,5000,1);
			if(vector != null){
//				System.out.println(" vector= " + vector.size());
				for(int cnt = 0;cnt < vector.size();cnt++){
					table = (Hashtable)vector.get(cnt);
					if(table.get("in_title") != null)
							inTitle = table.get("in_title").toString();
					if(table.get("in_content") != null)
						inContent = table.get("in_content").toString();
					if(table.get("in_id") != null)
						inId = Integer.parseInt(table.get("in_id").toString());
					if(table.get("in_inputtime") != null)
						ctCreateTime = table.get("in_inputtime").toString();
					//插入TB_CONTENT TB_CONTENTPUBLISH
					insertContent(subjectId,inContent,inTitle,inId,ctCreateTime);
					
					//插入TB_IMAGE
					doInsertImage(inId);
				}
			}
			nextSubTitIdList = getNextSubTiIdList(tiId);
			if(nextSubTitIdList.size() > 0){
				for(int count = 0;count < nextSubTitIdList.size();count++){
					nextSubTiId = Integer.parseInt(((HashMap)nextSubTitIdList.get(count)).get("ti_id").toString());
					nextSubTiName = ((HashMap)nextSubTitIdList.get(count)).get("ti_name").toString();
					doInsert2(nextSubTiId,nextSubTiName,nexSubjectId,dtId);
				}
			}
			
		}catch(Exception ex){
			System.out.println("SQLEXception::getSjId " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
	}
	
	private boolean doInsertImage(int id){
		boolean flag = false;
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		Vector vector = null;
		String imPath = "";
		int iaId = -1;
		String imFileName = "";
//		String imContent = "";
		Hashtable table = null;
		int imId = -1;
		String sql = "";
		try{
			sql = "select IA_ID,IA_PATH,IA_FILENAME,IA_CONTENT from tb_infoattach " +
					"where  IN_ID = " + id + " and  imp_status <> 1";
			vector = dImpl.splitPage(sql,50,1);
			if(vector != null){
				for(int cnt = 0;cnt < vector.size();cnt++){
					table = (Hashtable)vector.get(cnt);
					imPath = table.get("ia_path").toString();
					imFileName = table.get("ia_filename").toString();;
//					imContent = table.get("ia_content").toString();
					iaId = Integer.parseInt(table.get("ia_id").toString());
					dImpl.addNew("tb_image","IM_ID");
					dImpl.setValue("IM_PATH",imPath,CDataImpl.STRING);
					dImpl.setValue("IM_FILENAME",imFileName,CDataImpl.STRING);
//					dImpl.setValue("IM_CONTENT",imContent,CDataImpl.SLONG);
					flag = dImpl.update();
					imId = getMaxID("tb_image");
					if(flag){
						dImpl.executeUpdate("update tb_infoattach set imp_status = 1 where ia_id = " + iaId);
						dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
								")values('tb_image','IM_ID'," + imId + ",'Yes','6')");
					}else{
						dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
								")values('tb_image','IM_ID'," + imId + ",'No','6')");
					}	
				}
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertContentPublish " + ex.getMessage());
			dCn.closeCn();
			dImpl.closeStmt();
		}finally{
			dCn.closeCn();
			dImpl.closeStmt();
		}
		return flag;
	}
	
	
	private ArrayList getNextSubTiIdList(int tiId){
		ArrayList list = new ArrayList();
		Vector vector = null;
		HashMap map = null;
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		String sql = "select ti_id,ti_name from tb_title where ti_upperid = " + tiId + " order by ti_sequence";
//		System.out.println("   sql 444  " + sql);
		try{
			vector = dImpl.splitPage(sql,100,1);
			if(vector != null){
				for(int cnt = 0;cnt < vector.size();cnt++){
					map =  new HashMap();
					map.put("ti_id",((Hashtable)vector.get(cnt)).get("ti_id").toString());
					map.put("ti_name",((Hashtable)vector.get(cnt)).get("ti_name").toString());
					list.add(map);
				}
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::getSjId " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return list;
	}
	
	public void insertContent(int subjectId,String content,String name,int inId,String ctCreateTime){
		boolean flag = false;
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		try{
			dImpl.addNew("tb_content","CT_ID");
			dImpl.setValue("CT_CONTENT",content,CDataImpl.SLONG);
			dImpl.setValue("CT_TITLE",name,CDataImpl.STRING);
			dImpl.setValue("CT_CREATE_TIME",ctCreateTime,CDataImpl.STRING);
			flag = dImpl.update();
			int contentId = getMaxID("tb_content");
//			System.out.println("----------contentId = " + contentId);
			if(flag){
				totalCnt++;
				dImpl.executeUpdate("update tb_info set imp_status = 1 where in_id = " + inId);
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_content','CT_ID'," + contentId + ",'Yes','6')");
				doInsertContentPublish(subjectId,contentId);
			}else{
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_content','CT_ID'," + contentId + ",'No','6')");
			}
			
		}catch(Exception ex){
			System.out.println("SQLEXception::getSjId " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
	}
	
	
	private String getSjId(String dtName,int parentId){
		String sjID = "-1";
		String sql = "select sj_id from tb_subject where sj_name = '"+ dtName 
				+"' and SJ_PARENTID = " + parentId;
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		try{
			Vector vector = null;
			vector = dImpl.splitPage(sql,10,1);
			if(vector != null)
				sjID = ((Hashtable)vector.get(0)).get("sj_id").toString();
		}catch(Exception ex){
			System.out.println("SQLEXception::getSjId " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return sjID;
	}
	
	
	public boolean doTransfer(int newSjId){
		boolean flag = false;
		
		
		//删除上次插入的记录
//		doDeleteTable(6);
		
		//数据库插入操作
		doInsertTable(newSjId);
		System.out.println("插入 部门信息公开 完成");
		return flag;
	}
	
	
	private boolean doInsertContentPublish(int sjId,int contentId){
		boolean flag = false;
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		try{
			dImpl.addNew("tb_contentpublish","CP_ID");
			dImpl.setValue("CT_ID",String.valueOf(contentId),CDataImpl.INT);
			dImpl.setValue("SJ_ID",String.valueOf(sjId),CDataImpl.INT);
			dImpl.setValue("CP_ISPUBLISH","1",CDataImpl.INT);
			dImpl.update();
//			System.out.println("doInsertContentPublish: contentId = " + contentId + " sjId =  "+ sjId);
			int newCpId = getMaxID("tb_contentpublish");
			if(flag){
				totalCnt++;
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_contentpublish','CP_ID'," + newCpId + ",'Yes','6')");
			}else{
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_contentpublish','CP_ID'," + newCpId + ",'No','6')");
			}
			
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertContentPublish " + ex.getMessage());
			
		} finally {
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return flag;
	}
	
	private boolean doInsertSubject(String sjName,int parentId,int tiId){
		boolean flag = false;
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		try{
			
			dImpl.addNew("tb_subject","SJ_ID");
			dImpl.setValue("SJ_NAME",sjName,CDataImpl.STRING);
			dImpl.setValue("SJ_PARENTID",String.valueOf(parentId),CDataImpl.INT);
			flag = dImpl.update();
			int newSjId = getMaxID("tb_subject");
			System.out.println("-----sj_id = " + newSjId + " sj_name = " + sjName);
			if(flag){
//				totalCnt++;
				if(tiId != -1)
					dImpl.executeUpdate("update tb_title set imp_status = 1 where ti_id = "+ tiId);
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_subject','SJ_ID'," + newSjId + ",'Yes','6')");
			}else{
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_subject','SJ_ID'," + newSjId + ",'No','6')");
			}
//			System.out.println(" ---------- newSjId = " + newSjId + " sjName =  " + sjName + "  parentId =   " + parentId);
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertSubject " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return flag;
	}
	
	public void doDeleteTable(int imp_num){
		String sql = "select TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE from tb_impstatus where IMP_STATUS = 'Yes' " +
				"and IMP_NUM = '"+ imp_num+"' ";
		ResultSet result = null;
		String tableName = "";
		String fieldName = "";
		String fieldValue = "";
		String deleteSql = "";
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		try{
			result = dImpl.executeQuery(sql);
			while(result.next()){
				CDataCn cDn1 = new CDataCn();
				CDataImpl dImpl1 = new CDataImpl(cDn1);
				tableName = result.getString("TABLE_NAME");
				fieldName = result.getString("FIELD_NAME");
				fieldValue = result.getString("NEW_FIELD_VALUE");
				deleteSql = "delete from " + tableName + " where " + fieldName + " = '"+ fieldValue +"' ";
//				System.out.println("  sql = " + deleteSql);
				dImpl1.executeUpdate(deleteSql);
				cDn1.closeCn();
				dImpl1.closeStmt();
			}
			deleteSql = "delete from tb_impstatus where IMP_STATUS = 'Yes' and IMP_NUM = '"+ imp_num+"' ";
			dImpl.executeUpdate(deleteSql);
			System.out.println("DELETE FINISHED!");
		}catch(Exception ex){
			System.out.println("SQLEXception::doDeleteTable " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		
	}
	
	public static void main(String[] args){
		DataTransfer5 transfer5 = new DataTransfer5();
		transfer5.doTransfer(324);
		System.out.println("totalCnt = " + DataTransfer5.totalCnt);
	}
}
