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
 * <p>Function:将原来因特奈的数据转换到现在使用的数据库</p>
 * <p>Create Time: 2006-6-2 13:39:48</p>
 * @author: yanker
 * @version: 
 */
public class DataTransfer {

	
	
	public int totalCnt = 0;
	
	
	
	public boolean doTransfer(String oldSjName,int newSjId,int number){
		boolean flag = false;
		int oldSjId = -1;
		ArrayList subOldId = null;
		try{
		System.out.println("insert" + oldSjName + " beginning!");
		//删除上次插入的记录
//		doDeleteTable(number);
		
		//用传入的栏目名称得到栏目ID
		oldSjId = getOldSjId(oldSjName);
//		System.out.println("---- oldSjId = " + oldSjId);
		Vector contentId = getContentId(oldSjId);
//		System.out.println("---- contentId = " + contentId);
		if(contentId != null){
			doInsertCAP(contentId,newSjId,number);
		}
		
		//得到该栏目下的子栏目
		subOldId = getSubOldSjId(oldSjId);
		//数据库插入操作
		dopInsertTable(subOldId,newSjId,number);
		System.out.println("insert" + oldSjName + "finished!");
		System.out.println(new java.util.Date());
		System.out.println("totalCnt = " + totalCnt);
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return flag;
	}
	
	private int getOldSjId(String oldSjName){
		int oldSjId = -1;
		String sql = "SELECT CATEGORYID FROM TBCATEGORY WHERE CATEGORYNAME = '"+ oldSjName +"'";
//		String sql = "SELECT CATEGORYID FROM TBCATEGORY WHERE CATEGORYNAME = '政策法规'";
//		String sql = "SELECT CATEGORYID FROM TBCATEGORY WHERE CATEGORYNAME = '统计数据'";
		ResultSet result = null;
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		try{
			result = dImpl.executeQuery(sql);
			if(result.next()){
				oldSjId = result.getInt("CATEGORYID");
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::getOldSjId " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		
		return oldSjId;
	}
	
//	private ArrayList getNewSubSjName(int parentId){
//		ArrayList newSubSjName = new ArrayList();
//		String sql = "SELECT SJ_NAME FROM TB_SUBJECT WHERE SJ_PARENTID =" + parentId;
//		Vector vector = new Vector();
//		CDataCn cDn = new CDataCn();
//		CDataImpl dImpl = new CDataImpl(cDn);
//		try{
//			vector = dImpl.splitPage(sql,30,1);
//			if(vector != null){
//				for(int k = 0;k < vector.size();k++){
//					newSubSjName.add(((Hashtable)vector.get(k)).get("sj_name").toString());
//				}
//			}
//		}catch(Exception ex){
//			System.out.println("SQLEXception::getSubOldSjId " + ex.getMessage());
//			cDn.closeCn();
//			dImpl.closeStmt();
//		}finally{
//			cDn.closeCn();
//			dImpl.closeStmt();
//		}
//		return newSubSjName;
//	}
	
	public ArrayList getSubOldSjId(int oldSjId){
		ArrayList oldParentId = new ArrayList();
//		ArrayList newSubSjName = getNewSubSjName(newSjId);
//		String name = "";
		String sql = "SELECT CATEGORYID,CATEGORYNAME FROM TBCATEGORY WHERE CATEGORYPARENTID =" 
				+ oldSjId + " and imp_status <> 1";
//		System.out.println("-- sql = " + sql);
		Vector vector = new Vector();
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		try{
			vector = dImpl.splitPage(sql,200,1);
			if(vector != null){
				for(int k = 0;k < vector.size();k++){
//					name = ((Hashtable)vector.get(k)).get("categoryname").toString();
//					if(!newSubSjName.contains(name))
						oldParentId.add(((Hashtable)vector.get(k)).get("categoryid").toString());
				}
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::getSubOldSjId " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
//		for(int j = 0;j < oldParentId.size();j++){
//			System.out.println("----oldParentId[" + j +"] = " + oldParentId.get(j));
//		}
//		System.out.println("-------- size = " + oldParentId.size());
		return oldParentId;
	}
	
	private String getSjId(String dtName,int parentId){
		String dtID = "";
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		try{
			Hashtable table = null;
			table = dImpl.getDataInfo("select sj_id from tb_subject where sj_name = '"+ dtName 
					+"' and sj_parentid = "+ parentId);
			if(table != null)
				dtID = table.get("sj_id").toString();
		}catch(Exception ex){
			System.out.println("SQLEXception::getDtId " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return dtID;
	}
	
	private boolean dopInsertTable(ArrayList subSjId,int parentId,int number){
		boolean flag = false;
		ArrayList nextSubSjId = null;
		Hashtable table = null;
		int oldSjId = -1;
		int newSjId = -1;
		String sjName = "";
		Vector contentId = null;
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		String sql = "";
		try{
			if(subSjId != null && subSjId.size()>= 1){
				for(int count = 0;count < subSjId.size();count++){
					cDn = new CDataCn();
					dImpl = new CDataImpl(cDn);
					oldSjId = Integer.parseInt(subSjId.get(count).toString());
					sql = " SELECT CATEGORYNAME FROM TBCATEGORY WHERE CATEGORYID = " 
						+ oldSjId + " and imp_status <> 1";
					table = dImpl.getDataInfo(sql);
					if(table != null){
						sjName = table.get("categoryname").toString();
						if(!"".equals(getSjId(sjName,parentId))){
							newSjId = Integer.parseInt(getSjId(sjName,parentId));
						}else{
							doInsertSubject(sjName,parentId,number,oldSjId);
							newSjId = getMaxID("tb_subject");
						}
						//得到该sjId 对应的记录插入对应的tb_content,tb_content,tb_image
						contentId = getContentId(oldSjId);
						doInsertCAP(contentId,newSjId,number);
					}
					nextSubSjId = getSubOldSjId(oldSjId);
					if(nextSubSjId != null && nextSubSjId.size() >= 1){
						dopInsertTable(nextSubSjId,newSjId,number);
					}
					cDn.closeCn();
					dImpl.closeStmt();
				}
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::dopInsertTable " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return flag;
	}
	
	//得到该sjId 对应的记录插入对应的tb_content,tb_content,tb_image
	private void doInsertCAP(Vector contentId,int newSubSjId,int number){
		int attachId = -1;
		int ct_id = -1;
		Hashtable table = null;
		Hashtable innerResult = null;
		
		if(contentId != null){
			for(int count = 0; count < contentId.size(); count++){
				table = (Hashtable) contentId.get(count);
				ct_id = Integer.parseInt(table.get("contentid").toString());
				innerResult = getContent(ct_id);
				boolean flag = doInsertContent(innerResult,number,ct_id);
				int newCtId = getMaxID("tb_content");
				//将TB_content和TB_subject的对应关系插入到TB_contentpublish
				if(flag){
					totalCnt++;
					System.out.println("newSubSjId = " + newSubSjId + " newCtId = " + newCtId);
					doInsertContentPublish(newSubSjId,newCtId,number);
				}
				//得到该content 对应的附件并插入附件表
				attachId = getAttachId(ct_id);
				if(attachId != -1){
					innerResult = getAttach(attachId);
					doInsertAttach(innerResult,newCtId,number,attachId);
				}
			}
		}
	}
	
	public Hashtable getAttach(int attachId){
		Hashtable table = null;
		String sql = " SELECT ATTACHMENTNAME,ATTACHMENTFILENAME,ATTACHMENTTYPE " 
				+ " FROM TBATTACHMENT WHERE ATTACHMENTID = " + attachId + " and imp_status <> 1";
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		try{
			table = dImpl.getDataInfo(sql);
		}catch(Exception ex){
			System.out.println("SQLEXception::getAttach " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return table;
	}
	
	private boolean doInsertAttach(Hashtable table,int ctId,int number,int attachId){
		boolean flag = false;
		String name = "";
		String fileName = "";
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		if(table == null)
			return false;
		try{
			if(table.get("attachmentname") != null)
				name = table.get("attachmentname").toString();
			if(table.get("attachmentfilename") != null)
				fileName = table.get("attachmentfilename").toString();
			dImpl.addNew("tb_image","IM_ID");
			dImpl.setValue("IM_PATH",fileName,CDataImpl.STRING);
			dImpl.setValue("IM_FILENAME",name,CDataImpl.STRING);
			dImpl.setValue("IM_NAME","import",CDataImpl.STRING);
			dImpl.setValue("CT_ID",String.valueOf(ctId),CDataImpl.INT);
			flag = dImpl.update();
			int newImId = getMaxID("tb_image");
			if(flag){
				dImpl.executeUpdate("update tbattachment set imp_status = 1 where attachmentid = " + attachId);
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_image','im_id'," + newImId + ",'Yes'," + number +")");
				
			}else{
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_image','im_id'," + newImId + ",'No'," + number +")");
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertAttach " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return flag;
	}
	
	private int getAttachId(int contentId){
		int attachId = -1;
		Hashtable table = null;
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		String sql ="SELECT ATTACHMENTID FROM TBCONTENT_ATTACHMENT WHERE CONTENTID = " + contentId;
		try{
			table = dImpl.getDataInfo(sql);
			if(table != null){
				attachId = Integer.parseInt(table.get("attachmentid").toString());
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::getAttachId " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return attachId;
	}
	
	private boolean doInsertContentPublish(int sjId,int contentId,int number){
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
//			System.out.println("-sjId = " + sjId + "   contentId = " + contentId);
			if(flag){
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_contentpublish','CP_ID'," + newCpId + ",'Yes'," + number +")");
				
			}else{
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_contentpublish','CP_ID'," + newCpId + ",'No'," + number +")");
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertContentPublish " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return flag;
	}
	
	private int getMaxID(String tablename){
		int maxId = 1;
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		Hashtable table = null;
		try{
			table = dImpl.getDataInfo("select rc_maxid from tb_rowcount where rc_tablename = '"+ tablename +"'");
			if(table != null){
				maxId = Integer.parseInt(table.get("rc_maxid").toString());
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
	
	private Vector getContentId(int categoryId){
//		int contentId = -1;
		Vector result = new Vector();
		String sql ="SELECT CONTENTID FROM TBCONTENT_CATEGORY WHERE CATEGORYID = " + categoryId + " ORDER BY CONTENTID DESC";
//		System.out.println("----sql = " + sql);
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		try{
			result = dImpl.splitPage(sql,1000,1);
//			if(result != null && result.size() > 0)
//				contentId = Integer.parseInt(((Hashtable)result.get(0)).get("contentid").toString());
			
		}catch(Exception ex){
			System.out.println("SQLEXception::getContentId " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return result;
	}
	
	//得到TBCONTENT的数据
	private Hashtable getContent(int contentId){
		Hashtable table= null;
		String sql = " SELECT CONTENTTITLE,CONTENTBODY,to_char(CONTENTSTARTDATE,'yyyy-MM-DD') as createtime "
				+ " FROM TBCONTENT WHERE CONTENTID = " + contentId + " AND IMP_STATUS <> 1";
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		try{
			table = dImpl.getDataInfo(sql);
		}catch(Exception ex){
			System.out.println("SQLEXception::getContent " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return table;
	}
	
	private boolean doInsertContent(Hashtable table,int number,int oldContentId){
		boolean flag = false;
		String title = "";
		String content = "";
		String createTime = "";
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		if(table == null)
			return false;
		try{
			
			if(table.get("contenttitle") != null)
				title = table.get("contenttitle").toString();
			if(table.get("contentbody") != null)
				content = table.get("contentbody").toString();
			if(table.get("createtime") != null)
				createTime = table.get("createtime").toString();
			dImpl.addNew("tb_content","CT_ID");
			dImpl.setValue("CT_TITLE",title,CDataImpl.STRING);
			dImpl.setValue("CT_INSERTTIME","20060614",CDataImpl.STRING);
			dImpl.setValue("CT_CREATE_TIME",createTime,CDataImpl.STRING);
			dImpl.setValue("CT_CONTENT",content,CDataImpl.SLONG);
			flag = dImpl.update();
			int newCtId = getMaxID("tb_content");
//			System.out.println("-newCtId = " + newCtId );
			if(flag){
				
				dImpl.executeUpdate("update tbcontent set imp_status = 1 where contentid = " + oldContentId);
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_content','CT_ID'," + newCtId + ",'Yes'," + number +")");
			}else{
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_content','CT_ID'," + newCtId + ",'No'," + number +")");
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertContent " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return flag;
	}
	
	private boolean doInsertSubject(String sjName,int parentId,int number,int oldSjId){
		boolean flag = false;
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		int newSjId = -1;
		try{
			dImpl.addNew("tb_subject","SJ_ID");
			dImpl.setValue("SJ_NAME",sjName,CDataImpl.STRING);
			dImpl.setValue("SJ_KIND","import",CDataImpl.STRING);
			dImpl.setValue("SJ_PARENTID",String.valueOf(parentId),CDataImpl.INT);
			flag = dImpl.update();
			newSjId = getMaxID("tb_subject");
//			System.out.println("      newSjId = " + newSjId);
			if(flag){
				dImpl.executeUpdate("update tbcategory set imp_status = 1 where categoryid = " + oldSjId);
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_subject','SJ_ID'," + newSjId + ",'Yes'," + number +")");
			}else{
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_subject','SJ_ID'," + newSjId + ",'No'," + number +")");
			}
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
	
//	public void doDeleteTable(int imp_num){
//		String sql = "select TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE from tb_impstatus where IMP_STATUS = 'Yes' " +
//				"and IMP_NUM = '"+ imp_num+"' ";
//		ResultSet result = null;
//		String tableName = "";
//		String fieldName = "";
//		String fieldValue = "";
//		String deleteSql = "";
//		CDataCn cDn = null;
//		CDataImpl dImpl = null;
//		try{
//			result = cImpl.executeQuery(sql);
//			while(result.next()){
//				cDn = new CDataCn();
//				dImpl = new CDataImpl(cDn);
//				tableName = result.getString("TABLE_NAME");
//				fieldName = result.getString("FIELD_NAME");
//				fieldValue = result.getString("NEW_FIELD_VALUE");
//				deleteSql = "delete from " + tableName + " where " + fieldName + " = '"+ fieldValue +"' ";
////				System.out.println("  sql = " + deleteSql);
//				dImpl.executeUpdate(deleteSql);
//				cDn.closeCn();
//				dImpl.closeStmt();
//			}
//			deleteSql = "delete from tb_impstatus where IMP_STATUS = 'Yes' and IMP_NUM = '"+ imp_num+"' ";
//			cImpl.executeUpdate(deleteSql);
//			System.out.println("DELETE FINISHED!");
//		}catch(Exception ex){
//			System.out.println("SQLEXception::doDeleteTable " + ex.getMessage());
//			
//		}finally{
//			cCn.closeCn();
//			cImpl.closeStmt();
//			cDn.closeCn();
//			dImpl.closeStmt();
//		}
//	}
	
	public static void main(String[] args){
		
		DataTransfer transfer = new DataTransfer();
		
		//39----
//		transfer.doTransfer("区委领导",319,11);
		
		//2573----
//		transfer = new DataTransfer();
//		transfer.doTransfer("浦东年鉴",355,50);
		
//		----
//		transfer = new DataTransfer();
//		transfer.doTransfer("区政府领导",319,50);
		
//		//浦东统计--338
//		transfer = new DataTransfer();
//		transfer.doTransfer("统计数据",332,50);
		
//		//政府规章----
//		transfer = new DataTransfer();
//		transfer.doTransfer("政策法规",326,50);
		
//		//33----
//		transfer = new DataTransfer();
//		transfer.doTransfer("浦东概览",463,50);
		
//		//39----
//		transfer = new DataTransfer();
//		transfer.doTransfer("区政府领导",340,12);
		
		//421
//		transfer = new DataTransfer();
//		transfer.doTransfer("政府公报",325,13);
		
//		transfer = new DataTransfer();----
//		transfer.doTransfer("政府部门",348,14);
		
//		transfer = new DataTransfer();----
//		transfer.doTransfer("街道、镇",349,15);
		
//		transfer = new DataTransfer();---无数据
//		transfer.doTransfer("其他机构",350,16);
		
//		transfer = new DataTransfer();--846
//		transfer = new DataTransfer();
//		transfer.doTransfer("浦东政务",333,18);
		
		//22
//		transfer = new DataTransfer();
//		transfer.doTransfer("价格服务",353,19);
		
//		transfer = new DataTransfer();----
//		transfer.doTransfer("值班电话",354,20);
		
		//2573----
//		transfer = new DataTransfer();
//		transfer.doTransfer("浦东年鉴",355,21);
		
		//----
//		transfer = new DataTransfer();
//		transfer.doTransfer("龙逗逗提醒",376,60);
		
		//----
//		transfer = new DataTransfer();
//		transfer.doTransfer("浦东人民广播电台",1703,61);
		
		//----
//		transfer = new DataTransfer();
//		transfer.doTransfer("《浦东开发》杂志",1704,62);
		
		//----
//		transfer = new DataTransfer();
//		transfer.doTransfer("图片集锦",18658,63);
		
		//----
//		transfer = new DataTransfer();
//		transfer.doTransfer("图片集锦",1728,64);
		
		//----
//		transfer = new DataTransfer();
//		transfer.doTransfer("图片集锦",468,65);
		
		//----
//		transfer = new DataTransfer();
//		transfer.doTransfer("先进性教育",1715,66);
		
		//----
//		transfer = new DataTransfer();
//		transfer.doTransfer("浦东先进人物风采录",1716,67);
		
		///----
//		transfer = new DataTransfer();
//		transfer.doTransfer("专题报道",377,68);
		
		//----
//		transfer = new DataTransfer();
//		transfer.doTransfer("计划规划",470,68);
		
		//----
//		transfer = new DataTransfer();
//		transfer.doTransfer("计划规划",356,68);
		
		//----
		transfer = new DataTransfer();
		transfer.doTransfer("服务热线",4857,68);
//		
//		transfer = new DataTransfer();
//		transfer.doTransfer("创新浦东特别报道",1719,68);
//		
//		transfer = new DataTransfer();
//		transfer.doTransfer("“沪东杯”身边的共产党员征文",20848,68);
//		
//		transfer = new DataTransfer();
//		transfer.doTransfer("爱满浦东",1718,68);
		
	}
}
