package com.util;

import java.sql.ResultSet;
import java.util.Hashtable;
import java.util.Vector;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

/**
 * <p>Program Name:浦东信息统一报送</p>
 * <p>Module Name:工具类</p>
 * <p>Function:将原来"政府信息公开指南"的数据转换到现在使用的数据库</p>
 * <p>Create Time: 2006-6-6 13:39:48</p>
 * @author: yanker
 * @version: 
 */
public class DataTransfer4 {

	private CDataCn cCn = null;
	private CDataImpl cImpl = null;
	private String[] deptInfo = {"区政府","政府部门","街道、镇"};
	
	private void doInsertTable(int newSjId){
		int subjectId = -1;
		int parentId = -1;
		String dtName = "";
		int dtId = -1;
		Vector vector = null;
		Vector subVector = null;
		String igId = ""; 
		String imgPath = "";
		String tempSjId = "-1";
		String igContent = "";
		String sql = "";
		CDataCn cDn = null;
		CDataImpl dImpl = null;
		try{
			for(int cnt = 0;cnt < deptInfo.length;cnt++){
				new CDataCn();
				dImpl = new CDataImpl(cDn);
				//将子栏目插入到“政府信息公开指南”
				parentId = Integer.parseInt(getSjId(deptInfo[cnt],323));
				if(parentId == -1){
					doInsertSubject(deptInfo[cnt],newSjId);
					parentId = getMaxID("tb_subject");
				}
				//得到该子栏目下的部门名称和ID
				if(cnt != 0){
					sql = "select dt_id,dt_name from tb_deptinfo where dt_type="+cnt + " and dt_name<>'区府办' " +
							"and dt_isinfoopen='1' order by dt_sequence";
					vector = dImpl.splitPage(sql,50,1);
					for(int count = 0;count < vector.size();count++){
						cDn = new CDataCn();
						dImpl = new CDataImpl(cDn);
						dtId = Integer.parseInt(((Hashtable)vector.get(count)).get("dt_id").toString());
						if(((Hashtable)vector.get(count)).get("dt_name") != null)
							dtName = ((Hashtable)vector.get(count)).get("dt_name").toString();
						tempSjId = getSjId(dtName,parentId);
						if("-1".equals(tempSjId)){
							doInsertSubject(dtName,parentId);
							subjectId = getMaxID("tb_subject");
						}else{
							subjectId = Integer.parseInt(tempSjId);
						}
//						System.out.println("---2 tempSjId = " + tempSjId);
						//得到部门的公开信息并插入到TB_CONTENT
						sql = "select ig_id,IG_CONTENT,IG_IMGPATH from tb_infoguide " +
								"where dt_id=" + dtId;
						subVector = dImpl.splitPage(sql,50,1);
//						System.out.println("sql = " + sql);
						if(subVector != null){
	//						System.out.println("-111-------- subVector = " + subVector.size());
							for(int k = 0;k< subVector.size();k++){
								if(((Hashtable)subVector.get(k)).get("ig_content") != null)
									igContent = ((Hashtable)subVector.get(k)).get("ig_content").toString();
								if(((Hashtable)subVector.get(k)).get("ig_imgpath") != null)
									imgPath = ((Hashtable)subVector.get(k)).get("ig_imgpath").toString();
								igId = ((Hashtable)subVector.get(k)).get("ig_id").toString();
								insertContent(subjectId,igContent,dtName,imgPath,igId);
							}
						}
					}
				}else{
					sql = "select g.IG_CONTENT as ig_content,d.dt_id as dt_id,d.dt_name as dt_name,g.ig_imgpath " +
							"as ig_imgpath from tb_infoguide g, tb_deptinfo d where g.dt_id=d.dt_id and imp_status <> 1 " +
							"and d.dt_name like '%政府%'";
					vector = dImpl.splitPage(sql,50,1);
//					System.out.println("---1 parentId = " + parentId);
					if(vector != null){
						for(int j = 0;j < vector.size();j++){
							dtName = ((Hashtable)vector.get(j)).get("dt_name").toString();
							tempSjId = getSjId(dtName,parentId);
//							System.out.println("---1 tempSjId = " + tempSjId);
							if("-1".equals(tempSjId)){
								doInsertSubject(dtName,parentId);
								subjectId = getMaxID("tb_subject");
							}else{
								subjectId = Integer.parseInt(tempSjId);
							}
							if(((Hashtable)vector.get(j)).get("ig_content") != null)
								igContent = ((Hashtable)vector.get(j)).get("ig_content").toString();
							if(((Hashtable)vector.get(j)).get("ig_imgpath") != null)
								imgPath = ((Hashtable)vector.get(j)).get("ig_imgpath").toString();
							if(((Hashtable)vector.get(j)).get("ig_id") != null)
								igId = ((Hashtable)vector.get(j)).get("ig_id").toString();
							insertContent(subjectId,igContent,dtName,imgPath,igId);
						}
					}
				}
			}
			cDn.closeCn();
			dImpl.closeStmt();
		}catch(Exception ex){
			System.out.println("SQLEXception::getMaxID " + ex.getMessage());
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
	
	public void insertContent(int subjectId,String content,String name,String imgPath,String igId){
		boolean flag = false;
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		try{
			dImpl.addNew("tb_content","CT_ID");
			dImpl.setValue("CT_CONTENT",content,CDataImpl.SLONG);
			dImpl.setValue("CT_TITLE",name,CDataImpl.STRING);
			dImpl.setValue("CT_IMG_PATH",imgPath,CDataImpl.STRING);
			flag = dImpl.update();
			int contentId = getMaxID("tb_content");
//			System.out.println("insertContent contentId = " + contentId);
			if(flag){
				dImpl.executeUpdate("update tb_infoguide set imp_status = 1 where ig_id = '"+ igId +"'");
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_content','CT_ID'," + contentId + ",'Yes','5')");
				doInsertContentPublish(subjectId,contentId);
			}else{
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_content','CT_ID'," + contentId + ",'No','5')");
			}
//			System.out.println("contentId = " + contentId + " subjectId = " + subjectId + " CT_TITLE = "+name);
		}catch(Exception ex){
			System.out.println("SQLEXception::getSjId " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
	}
	
	
	public DataTransfer4(){
		cCn = new CDataCn();
		cImpl = new CDataImpl(cCn);
	}
	
	private void closeConn(){
		cCn.closeCn();
		cImpl.closeStmt();
	}
	
	private String getSjId(String dtName,int parentId){
		String sjID = "-1";
		String sql = "select sj_id from tb_subject where sj_name = '"+ dtName 
				+"' and SJ_PARENTID = " + parentId + " order by sj_id";
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
//		System.out.println("------     getSjId sql = " + sql);
		try{
			Vector vector = null;
			vector = dImpl.splitPage(sql,30,1);
			if(vector != null)
				sjID = ((Hashtable)vector.get(0)).get("sj_id").toString();
		}catch(Exception ex){
			System.out.println("SQLEXception::getSjId " + ex.getMessage());
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return sjID;
	}
	
	
	public boolean doTransfer(int newSjId){
		boolean flag = false;
		
		
		//删除上次插入的记录
//		doDeleteTable(5);
		
		//数据库插入操作
		doInsertTable(newSjId);
		closeConn();
		System.out.println("插入 政府信息公开指南 完成");
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
			int newCpId = getMaxID("tb_contentpublish");
//			System.out.println("doInsertContentPublish  CT_ID = " +  contentId + "  SJ_ID =  " + sjId);
			if(flag){
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_contentpublish','CP_ID'," + newCpId + ",'Yes','5')");
			}else{
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_contentpublish','CP_ID'," + newCpId + ",'No','5')");
			}
			
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertContentPublish " + ex.getMessage());
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return flag;
	}
	
	private boolean doInsertSubject(String sjName,int parentId){
		boolean flag = false;
		CDataCn cDn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(cDn);
		try{
			
			dImpl.addNew("tb_subject","SJ_ID");
			dImpl.setValue("SJ_NAME",sjName,CDataImpl.STRING);
			dImpl.setValue("SJ_PARENTID",String.valueOf(parentId),CDataImpl.INT);
			flag = dImpl.update();
			int newSjId = getMaxID("tb_subject");
//			System.out.println(" ---------- newSjId = " + newSjId + " sjName =  " + sjName + "  parentId =   " + parentId);
			if(flag){
				
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_subject','SJ_ID'," + newSjId + ",'Yes','5')");
			}else{
				dImpl.executeUpdate("insert into tb_impstatus(TABLE_NAME,FIELD_NAME,NEW_FIELD_VALUE,IMP_STATUS,IMP_NUM" +
						")values('tb_subject','SJ_ID'," + newSjId + ",'No','5')");
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertSubject " + ex.getMessage());
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
		try{
			result = cImpl.executeQuery(sql);
			while(result.next()){
				cCn = new CDataCn();
				cImpl = new CDataImpl(cCn);
				tableName = result.getString("TABLE_NAME");
				fieldName = result.getString("FIELD_NAME");
				fieldValue = result.getString("NEW_FIELD_VALUE");
				deleteSql = "delete from " + tableName + " where " + fieldName + " = '"+ fieldValue +"' ";
				System.out.println("  sql = " + deleteSql);
				cImpl.executeUpdate(deleteSql);
				
			}
			deleteSql = "delete from tb_impstatus where IMP_STATUS = 'Yes' and IMP_NUM = '"+ imp_num+"' ";
			cImpl.executeUpdate(deleteSql);
			System.out.println("DELETE FINISHED!");
		}catch(Exception ex){
			System.out.println("SQLEXception::doDeleteTable " + ex.getMessage());
			cCn.closeCn();
			cImpl.closeStmt();
		}
		
	}
	
	public static void main(String[] args){
		DataTransfer4 transfer4 = new DataTransfer4();
		transfer4.doTransfer(323);
	}
}
