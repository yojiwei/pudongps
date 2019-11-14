package com.util;

import java.sql.ResultSet;
import java.util.Hashtable;
import java.util.Vector;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

/**
 * <p>Program Name:浦东信息统一报送</p>
 * <p>Module Name:工具类</p>
 * <p>Function:将原来"englishWeb/会计之窗/浦东诚信"的数据转换到现在使用的数据库</p>
 * <p>Create Time: 2006-6-6 13:39:48</p>
 * @author: yanker
 * @version: 
 */
public class DataTransfer7 {

	public static int totalCnt = 0;
	
	public void doTransfer(String name,int parentId){
		//二级栏目在tb_subject_new 中的 sj_id
		int newSjId = -1;
		
		//判断此二级栏目是否已经存在，若不存在，则插入此栏目
		newSjId = Integer.parseInt(getSjId(name,parentId));
		if(newSjId == -1){
			if(doInsertSubject(name,parentId))
				newSjId = Integer.parseInt(getSjId(name,parentId));
			
		}
		
		//得到此二级栏目的sj_id
		int oldSjId = Integer.parseInt(getOldSjId(name));
		//取出此栏目在tb_subject中的子目录
		Vector sjList = getSubOldSubject(oldSjId);
		doInsert(sjList,newSjId);
		System.out.println("insert " + name + "finished");
	}
	
	private void doInsert(Vector sjList,int parentId){
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		String sjName = "";
		int oldSjId = -1;
		int newSjId = -1;
		Hashtable table = null;
		Vector subSjList = null;
		try{
			if(sjList != null){
				for(int cnt = 0; cnt < sjList.size(); cnt++){
					table = (Hashtable) sjList.get(cnt);
					sjName = table.get("sj_name").toString();
					oldSjId = Integer.parseInt(table.get("sj_id").toString());
					
					//判断栏目是否存在于新的表中tb_subject_new
					newSjId = Integer.parseInt(getSjId(sjName,parentId));
					if(newSjId == -1){
						doInsertSubject(sjName,parentId);
						newSjId = Integer.parseInt(getSjId(sjName,parentId));
					}
					
					//将该栏目对应的tb_content的数据插入tb_content_new,并将对应关系插入tb_contentpublish表
					getOldContent(oldSjId,newSjId);
					
					//判断该栏目是否有子栏目
					subSjList = getSubOldSubject(oldSjId);
					if(subSjList != null)
						doInsert(subSjList,newSjId);
					
				}
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsert " + ex.getMessage());
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
	}
	
//	private Vector getVector(String sql,int cnt){
//		CDataCn cCn = new CDataCn();
//		CDataImpl cImpl = new CDataImpl(cCn);
//		Vector vector = null;
//		try{
//			vector = cImpl.splitPage(sql,10,cnt);
//		}catch(Exception ex){
//			System.out.println("SALException:: getVector " + ex.getMessage());
//		}finally{
//			cCn.closeCn();
//			cImpl.closeStmt();
//		}
//		return vector;
//	}
//	
//	private int getTotalCnt(int sj_id){
//		int maxId = 1;
//		CDataCn cDn = new CDataCn();
//		CDataImpl dImpl = new CDataImpl(cDn);
//		Vector vector = null;
//		try{
//			vector = dImpl.splitPage("select count(ct_id) as maxId from tb_content where sj_id = " + sj_id,5,1);
//			if(vector != null){
//				maxId = Integer.parseInt(((Hashtable)vector.get(0)).get("maxid").toString());
//			}
//		}catch(Exception ex){
//			System.out.println("SQLEXception::getTotalCnt " + ex.getMessage());
//			cDn.closeCn();
//			dImpl.closeStmt();
//		}finally{
//			cDn.closeCn();
//			dImpl.closeStmt();
//		}
//		return maxId;
//	}
	
	private Vector getOldContent(int oldSjid,int newSjId){
		Vector vector = null;
		CDataCn cDn = null;
		CDataImpl dImpl = null;
		try{
			cDn = new CDataCn();
			dImpl = new CDataImpl(cDn);
			String sql = "select CT_ID,CT_TITLE,CT_CONTENT,CT_CREATE_TIME,CT_FOCUS_FLAG,CT_KEYWORDS,CT_SOURCE,CT_IMG_PATH," +
					"CT_PUBLISH_FLAG,CT_BROWSE_NUM,CT_IMAGE_FLAG,CT_MESSAGE_FLAG,CT_SPECIAL_ID,CT_TRADE_ID,SJ_ID," +
					"TP_ID,DT_ID,CT_FEEDBACK_FLAG,CT_URL,CT_SEQUENCE,CT_SPECIALFLAG,CT_INSERTTIME,CT_FILEFLAG," +
					"CT_ISVERTICAL from tb_content where sj_id = " + oldSjid + " and imp_status <> 1";
			vector = dImpl.splitPage(sql,500,1);
			if(vector != null){
				doInsertContent(vector,newSjId);
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::getOldContent " + ex.getMessage());
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return vector;
	}
	
	private void doInsertContent(Vector vector,int sj_id){
		Hashtable table = null;
		CDataCn cDn = null;
		CDataImpl dImpl = null;
		boolean flag = false;
		int ctId = -1;
		try{
			for(int cnt = 0; cnt < vector.size(); cnt++){
				cDn = new CDataCn();
				dImpl = new CDataImpl(cDn);
				table = (Hashtable)vector.get(cnt);
				dImpl.addNew("tb_content_new","ct_id");
				if(table.get("ct_title") != null && !"".equals(table.get("ct_title")))
					dImpl.setValue("CT_TITLE",table.get("ct_title"),CDataImpl.STRING);
				if(table.get("ct_content") != null && !"".equals(table.get("ct_content")))
					dImpl.setValue("CT_CONTENT",table.get("ct_content"),CDataImpl.SLONG);
				if(table.get("ct_create_time") != null && !"".equals(table.get("ct_create_time")))
					dImpl.setValue("CT_CREATE_TIME",table.get("ct_create_time"),CDataImpl.STRING);
				if(table.get("ct_focus_flag") != null && !"".equals(table.get("ct_focus_flag")))
					dImpl.setValue("CT_FOCUS_FLAG",table.get("ct_focus_flag"),CDataImpl.INT);
				if(table.get("ct_keywords") != null && !"".equals(table.get("ct_keywords")))
					dImpl.setValue("CT_KEYWORDS",table.get("ct_keywords"),CDataImpl.STRING);
				if(table.get("ct_source") != null && !"".equals(table.get("ct_source")))
					dImpl.setValue("CT_SOURCE",table.get("ct_source"),CDataImpl.STRING);
				if(table.get("ct_img_path") != null && !"".equals(table.get("ct_img_path")))
					dImpl.setValue("CT_IMG_PATH",table.get("ct_img_path"),CDataImpl.STRING);
				if(table.get("ct_publish_flag") != null && !"".equals(table.get("ct_publish_flag")))
					dImpl.setValue("CT_PUBLISH_FLAG",table.get("ct_publish_flag"),CDataImpl.INT);
				if(table.get("ct_browse_num") != null && !"".equals(table.get("ct_browse_num")))
					dImpl.setValue("CT_BROWSE_NUM",table.get("ct_browse_num"),CDataImpl.INT);
				if(table.get("ct_image_flag") != null && !"".equals(table.get("ct_image_flag")))
					dImpl.setValue("CT_IMAGE_FLAG",table.get("ct_image_flag"),CDataImpl.INT);
				if(table.get("ct_message_flag") != null && !"".equals(table.get("ct_message_flag")))
					dImpl.setValue("CT_MESSAGE_FLAG",table.get("ct_message_flag"),CDataImpl.INT);
				if(table.get("ct_special_id") != null && !"".equals(table.get("ct_special_id")))
					dImpl.setValue("CT_SPECIAL_ID",table.get("ct_special_id"),CDataImpl.INT);
				if(table.get("ct_trade_id") != null && !"".equals(table.get("ct_trade_id")))
					dImpl.setValue("CT_TRADE_ID",table.get("ct_trade_id"),CDataImpl.INT);
				if(table.get("sj_id_old") != null && !"".equals(table.get("sj_id_old")))
					dImpl.setValue("SJ_ID_OLD",table.get("sj_id_old"),CDataImpl.INT);
				if(table.get("tp_id") != null && !"".equals(table.get("tp_id")))
					dImpl.setValue("TP_ID",table.get("tp_id"),CDataImpl.INT);
				if(table.get("dt_id") != null && !"".equals(table.get("dt_id")))
					dImpl.setValue("DT_ID",table.get("dt_id"),CDataImpl.INT);
				if(table.get("ct_feedback_flag") != null && !"".equals(table.get("ct_feedback_flag")))
					dImpl.setValue("CT_FEEDBACK_FLAG",table.get("ct_feedback_flag"),CDataImpl.INT);
				if(table.get("ct_url") != null && !"".equals(table.get("ct_url")))
					dImpl.setValue("CT_URL",table.get("ct_url"),CDataImpl.STRING);
				if(table.get("ct_sequence") != null && !"".equals(table.get("ct_sequence")))
					dImpl.setValue("CT_SEQUENCE",table.get("ct_sequence"),CDataImpl.INT);
				if(table.get("ct_specialflag") != null && !"".equals(table.get("ct_specialflag")))
					dImpl.setValue("CT_SPECIALFLAG",table.get("ct_specialflag"),CDataImpl.STRING);
				if(table.get("ct_inserttime") != null && !"".equals(table.get("ct_inserttime")))
					dImpl.setValue("CT_INSERTTIME",table.get("ct_inserttime"),CDataImpl.STRING);
				if(table.get("ct_fileflag") != null && !"".equals(table.get("ct_fileflag")))
					dImpl.setValue("CT_FILEFLAG",table.get("ct_fileflag"),CDataImpl.STRING);
				if(table.get("ct_isvertical") != null && !"".equals(table.get("ct_isvertical")))
					dImpl.setValue("CT_ISVERTICAL",table.get("ct_isvertical"),CDataImpl.STRING);
				dImpl.setValue("SJ_ID",sj_id + ",",CDataImpl.STRING);
				flag = dImpl.update();
				
				if(flag){
					totalCnt++;
					ctId = getMaxID("tb_content_new");
					dImpl.executeUpdate("update tb_content set imp_status = 1 where ct_id = " 
							+ Integer.parseInt(table.get("ct_id").toString()));
					dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
							")values('tb_content_new','CT_ID'," + ctId + ",'Yes','27')");
					doInsertContentPublish(sj_id,ctId);
				}else{
					dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
							")values('tb_content_new','CT_ID'," + ctId + ",'No','27')");
				}
				cDn.closeCn();
				dImpl.closeStmt();
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertContent " + ex.getMessage());
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
	}
	
	public Vector getSubOldSubject(int parentId){
		String sql = "select sj_id,sj_name from tb_subject where sj_parentid = "+ parentId;
		Vector vector = new Vector();
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		try{
			vector = dImpl.splitPage(sql,50,1);
		}catch(Exception ex){
			System.out.println("SQLEXception::getSubOldSubject " + ex.getMessage());
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return vector;
	}
	
	private boolean doInsertSubject(String sjName,int parentId){
		boolean flag = false;
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
//		Vector vector = getSubject(sjName,parentId);
		try{
//			if(vector != null){
//				Hashtable table = (Hashtable)vector.get(0);
				dImpl.addNew("tb_subject_new","SJ_ID");
				dImpl.setValue("SJ_NAME",sjName,CDataImpl.STRING);
				dImpl.setValue("SJ_PARENTID",String.valueOf(parentId),CDataImpl.INT);
//				if(table.get("sj_url") != null && !"".equals(table.get("sj_url")))
//					dImpl.setValue("SJ_URL",table.get("sj_url"),CDataImpl.STRING);
//				if(table.get("sj_dir") != null && !"".equals(table.get("sj_dir")))
//					dImpl.setValue("SJ_DIR",table.get("sj_dir"),CDataImpl.STRING);
//				if(table.get("sj_sequence") != null && !"".equals(table.get("sj_sequence")))
//					dImpl.setValue("SJ_SEQUENCE",table.get("sj_sequence"),CDataImpl.INT);
//				if(table.get("sj_counseling_flag") != null && !"".equals(table.get("sj_counseling_flag")))
//					dImpl.setValue("SJ_COUNSELING_FLAG",table.get("sj_counseling_flag"),CDataImpl.INT);
//				if(table.get("sj_img") != null && !"".equals(table.get("sj_img")))
//					dImpl.setValue("SJ_IMG",table.get("sj_img"),CDataImpl.STRING);
//				if(table.get("sj_desc") != null && !"".equals(table.get("sj_desc")))
//					dImpl.setValue("SJ_DESC",table.get("sj_desc"),CDataImpl.SLONG);
//				if(table.get("sj_create_time") != null && !"".equals(table.get("sj_create_time")))
//					dImpl.setValue("SJ_CREATE_TIME",table.get("sj_create_time"),CDataImpl.DATE);
//				if(table.get("sj_special_id") != null && !"".equals(table.get("sj_special_id")))
//					dImpl.setValue("SJ_SPECIAL_ID",table.get("sj_special_id"),CDataImpl.INT);
//				if(table.get("sj_trade_id") != null && !"".equals(table.get("sj_trade_id")))
//					dImpl.setValue("SJ_TRADE_ID",table.get("sj_trade_id"),CDataImpl.INT);
//				if(table.get("sj_need_audit") != null && !"".equals(table.get("sj_need_audit")))
//					dImpl.setValue("SJ_NEED_AUDIT",table.get("sj_need_audit"),CDataImpl.INT);
//				if(table.get("sj_display_flag") != null && !"".equals(table.get("sj_display_flag")))
//					dImpl.setValue("SJ_DISPLAY_FLAG",table.get("sj_display_flag"),CDataImpl.STRING);
//				if(table.get("sj_kind") != null && !"".equals(table.get("sj_kind")))
//					dImpl.setValue("SJ_KIND",table.get("sj_kind"),CDataImpl.STRING);
//				if(table.get("sj_position") != null && !"".equals(table.get("sj_position")))
//					dImpl.setValue("SJ_POSITION",table.get("sj_position"),CDataImpl.STRING);
//				if(table.get("sj_content_type") != null && !"".equals(table.get("sj_content_type")))
//					dImpl.setValue("SJ_CONTENT_TYPE",table.get("sj_content_type"),CDataImpl.STRING);
				flag = dImpl.update();
				int newSjId = getMaxID("tb_subject_new");
	//			System.out.println(" ---------- newSjId = " + newSjId + " sjName =  " + sjName + "  parentId =   " + parentId);
				if(flag){
					
					dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
							")values('tb_subject_new','SJ_ID'," + newSjId + ",'Yes','27')");
				}else{
					dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
							")values('tb_subject_new','SJ_ID'," + newSjId + ",'No','27')");
				}
//			}
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertSubject " + ex.getMessage());
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return flag;
	}
	
	private String getSjId(String sjName,int parentId){
		String dtID = "-1";
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		Vector vector = null;
		try{
			
			vector = dImpl.splitPage("select sj_id from tb_subject_new where sj_name = '"+ sjName +"' " +
					" and sj_parentid = " + parentId,20,1);
			if(vector != null)
				dtID = ((Hashtable)vector.get(0)).get("sj_id").toString();
		}catch(Exception ex){
			System.out.println("SQLEXception::getDtId " + ex.getMessage());
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return dtID;
	}
	
//	private Vector getSubject(String sjName,int parentId){
//		CDataCn cDn = new CDataCn();
//		CDataImpl dImpl = new CDataImpl(cDn);
//		Vector vector = null;
//		try{
//			vector = dImpl.splitPage("select SJ_NAME,SJ_URL,SJ_DIR,SJ_SEQUENCE,SJ_COUNSELING_FLAG,SJ_IMG," +
//					"SJ_DESC,SJ_CREATE_TIME,SJ_SPECIAL_ID,SJ_TRADE_ID,SJ_NEED_AUDIT,SJ_DISPLAY_FLAG,SJ_KIND," +
//					"SJ_POSITION,SJ_CONTENT_TYPE,SJ_IMG_PATH,SJ_IS_VERTICAL from tb_subject " +
//					"where sj_name = '"+ sjName +"' and sj_parentid = " + parentId,20,1);
//		}catch(Exception ex){
//			System.out.println("SQLEXception::getDtId " + ex.getMessage());
//		}finally{
//			cDn.closeCn();
//			dImpl.closeStmt();
//		}
//		return vector;
//	}
	
	private String getOldSjId(String sjName){
		String dtID = "-1";
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		try{
			Vector vector = null;
//			vector = dImpl.splitPage("select sj_id from tb_subject where sj_name = 'englishWeb' and sj_parentid = 0",20,1);
			
			vector = dImpl.splitPage("select sj_id from tb_subject where sj_name = '会计之窗' and sj_parentid = 0",20,1);
			
//			vector = dImpl.splitPage("select sj_id from tb_subject where sj_name = '浦东诚信' and sj_parentid = 0",20,1);
			
			if(vector != null)
				dtID = ((Hashtable)vector.get(0)).get("sj_id").toString();
		}catch(Exception ex){
			System.out.println("SQLEXception::getDtId " + ex.getMessage());
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return dtID;
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
						")values('tb_contentpublish','CP_ID'," + newCpId + ",'Yes','27')");
			}else{
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_contentpublish','CP_ID'," + newCpId + ",'No','27')");
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertContentPublish " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}
		System.out.println(" contentId = " + contentId + " sjId = " + sjId);
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
		DataTransfer7 transfer = new DataTransfer7();
		
//		transfer.doTransfer("上海浦东英文版",0);
		transfer.doTransfer("会计之窗",2221);
//		transfer.doTransfer("浦东诚信",293);
		
		System.out.println("totalCnt = " + DataTransfer7.totalCnt);
	}
}
