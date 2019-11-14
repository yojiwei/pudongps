package com.util;

import java.sql.ResultSet;
import java.util.Hashtable;
import java.util.Vector;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

/**
 * <p>Program Name:浦东信息统一报送</p>
 * <p>Module Name:工具类</p>
 * <p>Function:将原来"区政府文件/区政府会议"的数据转换到现在使用的数据库</p>
 * <p>Create Time: 2006-6-6 13:39:48</p>
 * @author: yanker
 * @version: 
 */
public class DataTransfer6 {

	public static int totalCnt = 0;
	
	private boolean doInsertImage(String id){
		boolean flag = false;
		Vector vector = null;
		String iaName = "";
		String imPath = "";
		String imFileName = "";
//		String imContent = "";
		String oaId = "";
		Hashtable table = null;
		int imId = -1;
		String sql = "";
		CDataCn cCn = new CDataCn();
		CDataImpl cImpl = new CDataImpl(cCn);
		try{
			sql = "select oa_id, oa_upname, oa_filename, oa_path,oa_content from tb_otherinfoattach " +
					"where oi_id='"+ id +"' and  imp_status <> 1";
			vector = cImpl.splitPage(sql,20,1);
			if(vector != null){
				for(int cnt = 0;cnt < vector.size();cnt++){
					CDataCn dCn = new CDataCn();
					CDataImpl dImpl = new CDataImpl(dCn);
					table = (Hashtable)vector.get(cnt);
					imPath = table.get("oa_path").toString();
					iaName = table.get("oa_upname").toString();
					imFileName = table.get("oa_filename").toString();;
//					imContent = table.get("oa_content").toString();
					oaId = table.get("oa_id").toString();
					dImpl.addNew("tb_image","IM_ID");
					dImpl.setValue("IM_PATH",imPath,CDataImpl.STRING);
					dImpl.setValue("IM_FILENAME",imFileName,CDataImpl.STRING);
//					dImpl.setValue("IM_CONTENT",imContent,CDataImpl.SLONG);
					dImpl.setValue("IM_NAME",iaName,CDataImpl.STRING);
					flag = dImpl.update();
					imId = getMaxID("tb_image");
					if(flag){
						dImpl.executeUpdate("update tb_otherinfoattach set imp_status = 1 where oa_id = '"+ oaId +"'");
						dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
								")values('tb_image','IM_ID'," + imId + ",'Yes','7')");
					}else{
						dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
								")values('tb_image','IM_ID'," + imId + ",'No','7')");
					}
					dCn.closeCn();
					dImpl.closeStmt();
				}
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertContentPublish " + ex.getMessage());
			cCn.closeCn();
			cImpl.closeStmt();
		}finally{
			cCn.closeCn();
			cImpl.closeStmt();
		}
		return flag;
	}
	
	public void doTransfer(String name,int newSjId){
		
		//删除上次插入的记录
//		doDeleteTable(7);
		
		doInsert(name,newSjId);
		
	}
	
	private int getMaxID(String tablename){
		int maxId = 1;
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		Vector vector = null;
		try{
			vector = dImpl.splitPage("select rc_maxid from tb_rowcount where rc_tablename = '"+ tablename +"'",5,1);
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
	
	public void doInsert(String name,int newSjId){
		String sql = "";
		sql = " select t.oi_title, t.oi_id,t.oi_content,t.oi_attachpath,to_char(t.oi_publishtime,'yyyy-MM-DD') "+
				"as oi_publishtime from tb_otherinfo t, tb_subject_new1 s " +
				"where t.imp_status <> 1 and t.sj_id=s.sj_id and t.sj_id in (select sj_id from tb_subject_new1 " +
				"where sj_dir='" + name + "') order by t.oi_publishtime desc";
		Vector vector = null;
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		String oiTitle = "";
		String oiContent = "";
		String oiId = "";
		String oiTime = "";
		Hashtable table = null;
		try{
			vector = dImpl.splitPage(sql,50,1);
			if(vector != null){
				for(int cnt = 0;cnt < vector.size();cnt++){
					table = (Hashtable)vector.get(cnt);
					oiId = table.get("oi_id").toString();
					if(table.get("oi_title") != null)
						oiTitle = table.get("oi_title").toString();
					if(table.get("oi_content") != null)
						oiContent = table.get("oi_content").toString();
					if(table.get("oi_publishtime") != null)
						oiTime = table.get("oi_publishtime").toString();
					
					//插入TB_CONTENT,TB-CONTENTPUBLISH
					insertContent(newSjId,oiContent,oiTitle,oiId,oiTime);
					
					//插入TB_IMAGE
					if(table.get("oi_attachpath") != null){
						doInsertImage(oiId);
					}
				}
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsert " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}
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
			int newCpId = getMaxID("tb_contentpublish");
			if(flag){
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_contentpublish','CP_ID'," + newCpId + ",'Yes','7')");
			}else{
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_contentpublish','CP_ID'," + newCpId + ",'No','7')");
			}
			
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertContentPublish " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return flag;
	}
	
	public void insertContent(int subjectId,String content,String name,String oiId,String oiTime){
		boolean flag = false;
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		try{
			dImpl.addNew("tb_content","CT_ID");
			dImpl.setValue("CT_CONTENT",content,CDataImpl.SLONG);
			dImpl.setValue("CT_TITLE",name,CDataImpl.STRING);
			dImpl.setValue("CT_CREATE_TIME",oiTime,CDataImpl.STRING);
//			System.out.println("CT_CONTENT = " + content + "   CT_TITLE = " + name + "  oiTime = " + oiTime);
			flag = dImpl.update();
			
			int contentId = getMaxID("tb_content");
//			System.out.println("----------contentId = " + contentId);
			if(flag){
				totalCnt++;
				dImpl.executeUpdate("update tb_otherinfo set imp_status = 1 where oi_id ='"+ oiId +"'");
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_content','CT_ID'," + contentId + ",'Yes','7')");
				doInsertContentPublish(subjectId,contentId);
			}else{
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_content','CT_ID'," + contentId + ",'No','7')");
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
	
	public void doDeleteTable(int imp_num){
		String sql = "select TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE from tb_impstatus where IMP_STATUS = 'Yes' " +
				"and IMP_NUM = '"+ imp_num+"' ";
		ResultSet result = null;
		String tableName = "";
		String fieldName = "";
		String fieldValue = "";
		String deleteSql = "";
		CDataCn cCn = null;
		CDataImpl cImpl = null;
		try{
			cCn = new CDataCn();
			cImpl = new CDataImpl(cCn);
			result = cImpl.executeQuery(sql);
			while(result.next()){
				CDataCn cDn = new CDataCn();
				CDataImpl dImpl = new CDataImpl(cDn);
				tableName = result.getString("TABLE_NAME");
				fieldName = result.getString("FIELD_NAME");
				fieldValue = result.getString("NEW_FIELD_VALUE");
				deleteSql = "delete from " + tableName + " where " + fieldName + " = '"+ fieldValue +"' ";
				System.out.println("  sql = " + deleteSql);
				dImpl.executeUpdate(deleteSql);
				cDn.closeCn();
				dImpl.closeStmt();
			}
			deleteSql = "delete from tb_impstatus where IMP_STATUS = 'Yes' and IMP_NUM = '"+ imp_num+"' ";
			cImpl.executeUpdate(deleteSql);
			System.out.println("DELETE FINISHED!");
		}catch(Exception ex){
			System.out.println("SQLEXception::doDeleteTable " + ex.getMessage());
			cCn.closeCn();
			cImpl.closeStmt();
		}finally{
			cCn.closeCn();
			cImpl.closeStmt();
		}
		
	}
	
	public static void main(String[] args){
		DataTransfer6 transfer = new DataTransfer6();
		
		//区政府会议
		transfer.doTransfer("govmeeting",328);
		
		//区政府文件
//		transfer.doTransfer("govfiles",327);
		
		System.out.println("totalCnt = " + DataTransfer6.totalCnt);
	}
}
