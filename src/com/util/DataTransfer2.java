package com.util;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Vector;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

/**
 * <p>Program Name:浦东信息统一报送</p>
 * <p>Module Name:工具类</p>
 * <p>Function:将原来"政府信息公开目录"的数据转换到现在使用的数据库</p>
 * <p>Create Time: 2006-6-2 13:39:48</p>
 * @author: yanker
 * @version: 
 */
public class DataTransfer2 {

	public static int totalCnt = 0;
	
	public boolean doTransfer(String newClassify,int newSjId){
		boolean flag = false;
		ArrayList subOldId = null;
		
		//删除上次插入的记录
//		doDeleteTable(3);
		
		//得到该栏目下的子栏目
		subOldId = getSubOldSjId(newClassify,newSjId);
		//数据库插入操作
		dopInsertTable(subOldId,newSjId);
		System.out.println("插入 政府信息公开目录 完成");
		return flag;
	}
	
//	private ArrayList getNewSubSjName(int parentId){
//		ArrayList newSubSjName = new ArrayList();
//		String sql = "SELECT SJ_NAME FROM TB_SUBJECT WHERE SJ_PARENTID =" + parentId;
//		Vector vector = new Vector();
//		CDataCn cDn = new CDataCn();
//		CDataImpl dImpl = new CDataImpl(cDn);
//		try{
//			vector = dImpl.splitPage(sql,50,1);
//			if(vector != null){
//				for(int k = 0;k < vector.size();k++){
//					newSubSjName.add(((Hashtable)vector.get(k)).get("sj_name").toString());
//				}
//			}
//		}catch(Exception ex){
//			System.out.println("SQLEXception::getSubOldSjId " + ex.getMessage());
//		}finally{
//			cDn.closeCn();
//			dImpl.closeStmt();
//		}
//		return newSubSjName;
//	}
	
	private String getSjId(String dtName,int parentId){
		String dtID = "-1";
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		try{
			Vector vector = null;
			vector = dImpl.splitPage("select sj_id from tb_subject where sj_name = '"+ dtName +"' " +
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
	
	public ArrayList getSubOldSjId(String newClassify,int parentId){
		ArrayList oldParentId = new ArrayList();
		String sql = "select TI_ID,TI_NAME from tb_title where ti_upperid in (select ti_id from tb_title " +
				"where ti_code='"+ newClassify +"') and  imp_status <> 1 order by ti_sequence";
		Vector vector = new Vector();
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		try{
			vector = dImpl.splitPage(sql,50,1);
			if(vector != null){
				for(int k = 0;k < vector.size();k++){
//					name = ((Hashtable)vector.get(k)).get("ti_name").toString();
//					if(!newSubSjName.contains(name))
						oldParentId.add(((Hashtable)vector.get(k)).get("ti_id").toString());
				}
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::getSubOldSjId " + ex.getMessage());
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
//		for(int j = 0;j < oldParentId.size();j++){
//			System.out.println("----oldParentId[" + j +"] = " + oldParentId.get(j));
//		}
		return oldParentId;
	}
	
	private ArrayList getNextSubSjId(int sjId){
		ArrayList oldParentId = new ArrayList();
//		ArrayList newSubSjName = getNewSubSjName(sjId);
//		String name = "";
		String sql = "select TI_ID,	TI_NAME from tb_title where ti_upperid = "+ sjId+" and imp_status <> 1 order by ti_sequence";
		Vector vector = new Vector();
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		try{
			vector = dImpl.splitPage(sql,50,1);
			if(vector != null){
				System.out.println(" size = " + vector.size());
				for(int k = 0;k < vector.size();k++){
//					name = ((Hashtable)vector.get(k)).get("ti_name").toString();
//					if(!newSubSjName.contains(name))
						oldParentId.add(((Hashtable)vector.get(k)).get("ti_id").toString());
				}
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::getSubOldSjId " + ex.getMessage());
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return oldParentId;
	}
	
	private boolean dopInsertTable(ArrayList subSjId,int parentId){
		boolean flag = false;
		ArrayList nextSubSjId = null;
		Vector vector = new Vector();
		String sjName = "";
		int oldSjId = -1;
		ArrayList contentId = null;
		int newSjId = -1;
		String sql = "";
		CDataCn cDn = null;
		CDataImpl dImpl = null;
		
		if(subSjId != null && subSjId.size()>= 1){
			for(int count = 0;count < subSjId.size();count++){
				cDn = new CDataCn();
				dImpl = new CDataImpl(cDn);
				try{
					oldSjId = Integer.parseInt(subSjId.get(count).toString());
					sql = " SELECT TI_NAME FROM TB_TITLE WHERE TI_ID = " + oldSjId;
					vector = dImpl.splitPage(sql,30,1);
					if(vector != null){
						sjName = ((Hashtable)vector.get(0)).get("ti_name").toString();
						if(!"-1".equals(getSjId(sjName,parentId))){
							newSjId = Integer.parseInt(getSjId(sjName,parentId));
						}else{
							doInsertSubject(sjName,parentId,oldSjId);
							newSjId = getMaxID("tb_subject");
						}
						
						//得到该sjId 对应的记录插入对应的tb_content,tb_content,tb_image
						contentId = getContentId(oldSjId);
						if(contentId != null)
							doInsertCAP(contentId,newSjId);
					}
					nextSubSjId = getNextSubSjId(oldSjId);
					if(nextSubSjId != null && nextSubSjId.size() >= 1){
						dopInsertTable(nextSubSjId,newSjId);
					}
				}catch(Exception ex){
					System.out.println("SQLEXception::dopInsertTable " + ex.getMessage());
				}finally{
					cDn.closeCn();
					dImpl.closeStmt();
				}
				cDn.closeCn();
				dImpl.closeStmt();
			}
		}
		return flag;
	}
	
	//得到该sjId 对应的记录插入对应的tb_content,tb_content,tb_image
	private void doInsertCAP(ArrayList contentId,int newSubSjId){
		Vector innerResult = null;
		int inId = -1;
		int newCtId = -1;
		boolean flag = false;
		if(contentId != null){
			for(int cnt = 0;cnt < contentId.size();cnt++){
				inId = Integer.parseInt(contentId.get(cnt).toString());
				innerResult = getContent(inId);
				
				//插入TB_CONTENT
				flag = doInsertContent(innerResult,inId);
				
				//插入TB_IMAGE
				doInsertImage(inId);
				
				//将TB_content和TB_subject的对应关系插入到TB_contentpublish
				if(flag){
					totalCnt++;
					newCtId = getMaxID("tb_content");
					doInsertContentPublish(newSubSjId,newCtId);
				}
			
			}
		}
	}
	
	private boolean doInsertImage(int id){
		boolean flag = false;
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		Vector vector = null;
		String imPath = "";
		String imFileName = "";
//		String imContent = "";
		Hashtable table = null;
		int imId = -1;
		int iaId = -1;
		String sql = "";
		try{
			sql = "select IA_ID,IA_PATH,IA_FILENAME,IA_CONTENT from tb_infoattach " +
					"where  IN_ID = " + id + " and imp_status <> 1 ";
			vector = dImpl.splitPage(sql,20,1);
			if(vector != null){
				for(int cnt = 0;cnt < vector.size();cnt++){
					table = (Hashtable)vector.get(cnt);
					iaId = Integer.parseInt(table.get("ia_id").toString());
					imPath = table.get("ia_path").toString();
					imFileName = table.get("ia_filename").toString();;
//					imContent = table.get("ia_content").toString();
					dImpl.addNew("tb_image","IM_ID");
					dImpl.setValue("IM_PATH",imPath,CDataImpl.STRING);
					dImpl.setValue("IM_FILENAME",imFileName,CDataImpl.STRING);
//					dImpl.setValue("IM_CONTENT",imContent,CDataImpl.SLONG);
					flag = dImpl.update();
					imId = getMaxID("tb_image");
					if(flag){
						dImpl.executeUpdate("update tb_infoattach set imp_status = 1 where ia_id = " + iaId);
						dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
								")values('tb_image','IM_ID'," + imId + ",'Yes','3')");
					}else{
						dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
								")values('tb_image','IM_ID'," + imId + ",'No','3')");
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
	
	private boolean doInsertContentPublish(int sjId,int contentId){
		boolean flag = false;
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		try{
			
			dImpl.addNew("tb_contentpublish","CP_ID");
			dImpl.setValue("CT_ID",String.valueOf(contentId),CDataImpl.INT);
			dImpl.setValue("SJ_ID",String.valueOf(sjId),CDataImpl.INT);
			dImpl.setValue("CP_ISPUBLISH","1",CDataImpl.INT);
			dImpl.update();
			int newCpId = getMaxID("tb_contentpublish");
			if(flag){
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_contentpublish','CP_ID'," + newCpId + ",'Yes','3')");
			}else{
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_contentpublish','CP_ID'," + newCpId + ",'No','3')");
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
	
	private ArrayList getContentId(int categoryId){
		ArrayList contentId = new ArrayList();
		Vector result = new Vector();
		String sql ="SELECT IN_ID FROM TB_INFO WHERE TI_ID = " + categoryId + " and imp_status <> 1 ";
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		try{
			result = dImpl.splitPage(sql,50,1);
			if(result != null){
				for(int cnt = 0; cnt < result.size();cnt++){
				contentId.add(((Hashtable)result.get(cnt)).get("in_id").toString());
				}
			}
			
		}catch(Exception ex){
			System.out.println("SQLEXception::getContentId " + ex.getMessage());
		}finally{
			dCn.closeCn();
			dImpl.closeStmt();
		}
		return contentId;
	}
	
	//得到TBCONTENT的数据
	private Vector getContent(int contentId){
		Vector result = new Vector();
		String sql = " SELECT IN_TITLE,IN_CONTENT,to_char(IN_INPUTTIME,'yyyy-MM-DD') as IN_INPUTTIME FROM TB_INFO WHERE IN_ID = " + contentId;
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		try{
			result = dImpl.splitPage(sql,30,1);
		}catch(Exception ex){
			System.out.println("SQLEXception::getContent " + ex.getMessage());
		}finally{
			dCn.closeCn();
			dImpl.closeStmt();
		}
		return result;
	}
	
	private boolean doInsertContent(Vector vector,int inId){
		boolean flag = false;
		String title = "";
		String content = "";
		String ctCreateTime = "";
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		if(vector == null)
			return false;
		try{
			//result.first();
			if(((Hashtable)vector.get(0)).get("in_title") != null)
				title = ((Hashtable)vector.get(0)).get("in_title").toString();
			if(((Hashtable)vector.get(0)).get("in_content") != null)
				content = ((Hashtable)vector.get(0)).get("in_content").toString();
			if(((Hashtable)vector.get(0)).get("in_inputtime") != null)
				ctCreateTime = ((Hashtable)vector.get(0)).get("in_inputtime").toString();
			
			dImpl.addNew("tb_content","CT_ID");
			dImpl.setValue("CT_TITLE",title,CDataImpl.STRING);
			dImpl.setValue("CT_CONTENT",content,CDataImpl.SLONG);
			dImpl.setValue("CT_CREATE_TIME",ctCreateTime,CDataImpl.STRING);
			flag = dImpl.update();
			int newCtId = getMaxID("tb_content");
			if(flag){
				dImpl.executeUpdate("update tb_info set imp_status = 1 where in_id = " + inId);
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_content','CT_ID'," + newCtId + ",'Yes','3')");
			}else{
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_content','CT_ID'," + newCtId + ",'No','3')");
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertContent " + ex.getMessage());
			dCn.closeCn();
			dImpl.closeStmt();
		}finally{
			dCn.closeCn();
			dImpl.closeStmt();
		}
		return flag;
	}
	
	private boolean doInsertSubject(String sjName,int parentId,int oldSjId){
		boolean flag = false;
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		try{
			
			dImpl.addNew("tb_subject","SJ_ID");
			dImpl.setValue("SJ_NAME",sjName,CDataImpl.STRING);
			dImpl.setValue("SJ_PARENTID",String.valueOf(parentId),CDataImpl.INT);
			flag = dImpl.update();
			int newSjId = getMaxID("tb_subject");
			if(flag){
//				dImpl.executeUpdate("update tb_title set imp_status = 1 where ti_id = " + oldSjId);
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_subject','SJ_ID'," + newSjId + ",'Yes','3')");
			}else{
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_subject','SJ_ID'," + newSjId + ",'No','3')");
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertSubject " + ex.getMessage());
			dCn.closeCn();
			dImpl.closeStmt();
		}finally{
			dCn.closeCn();
			dImpl.closeStmt();
		}
		return flag;
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
	
	public void doDeleteTable(int imp_num){
		String sql = "select TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE from tb_impstatus where IMP_STATUS = 'Yes' " +
				"and IMP_NUM = '"+ imp_num+"' ";
		ResultSet result = null;
		String tableName = "";
		String fieldName = "";
		String fieldValue = "";
		String deleteSql = "";
		CDataCn cCn = new CDataCn();
		CDataImpl cImpl = new CDataImpl(cCn);
		try{
			result = cImpl.executeQuery(sql);
			while(result.next()){
				cCn = new CDataCn();
				cImpl = new CDataImpl(cCn);
				tableName = result.getString("TABLE_NAME");
				fieldName = result.getString("FIELD_NAME");
				fieldValue = result.getString("NEW_FIELD_VALUE");
				deleteSql = "delete from " + tableName + " where " + fieldName + " = '"+ fieldValue +"' ";
//				System.out.println("  sql = " + deleteSql);
				cImpl.executeUpdate(deleteSql);
				cCn.closeCn();
				cImpl.closeStmt();
			}
			deleteSql = "delete from tb_impstatus where IMP_STATUS = 'Yes' and IMP_NUM = '"+ imp_num+"' ";
			cImpl.executeUpdate(deleteSql);
			System.out.println("DELETE FINISHED!");
		}catch(Exception ex){
			System.out.println("SQLEXception::doDeleteTable " + ex.getMessage());
		}finally{
			cCn.closeCn();
			cImpl.closeStmt();
		}
		
	}
	
	public static void main(String[] args){
		DataTransfer2 transfer2 = new DataTransfer2();
		transfer2.doTransfer("newclassify",322);
		System.out.print("totalCnt = " + DataTransfer2.totalCnt);
	}
}
