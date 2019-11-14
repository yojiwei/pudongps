package com.beyondbit.web.publishinfo;

import org.apache.struts.action.ActionForm;
import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.beyondbit.web.form.PublishSUBForm;
import java.util.Hashtable;
import com.util.CTools;
import com.util.CDate;


public class PublishSUBOperate {

	PublishSUBForm form1 = null;
	CDataCn dCn = null;
	CDataImpl dImpl = null;	
	String parimaryId = "";
	
	/**
	 * 新增信息
	 * @param form 
	 * @return 信息ID
	 */
	public String addNew(PublishSUBForm form)
	{
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn);
		form1 = form;
		System.out.println("form1 = " + form1.getFilePath());
		System.out.println("form = " + form.getFilePath());
		//String parimaryId = "";
		//dCn.beginTrans();
		try
		{
			parimaryId = savePublish();
			form.setCtId(parimaryId);
			String [] fileName = form.getFileList();
			String [] realName = form.getFileRealName();
			if(fileName!=null&&fileName.length>0) saveAttach(fileName,realName);
			
			savePublishStatus();
			
			//dCn.commitTrans();
		}
		catch(Exception ex)
		{
			//dCn.rollbackTrans();
			ex.printStackTrace();
		}
		finally
		{
			dImpl.closeStmt();
			dCn.closeCn();			
		}
		
		return "";
	}
	
	public void editPublish(PublishSUBForm form)
	{
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn);
		form1 = form;
		//String parimaryId = "";
		dCn.beginTrans();
		try
		{
			
			parimaryId = form.getCtId();
			
			savePublish();
			//form.setCtId(parimaryId);
			editPublishStatus();
			String [] fileName = form.getFileList();
			String [] realName = form.getFileRealName();
			if(fileName!=null&&fileName.length>0) saveAttach(fileName,realName);
			dCn.commitTrans();
		}
		catch(Exception ex)
		{
			dCn.rollbackTrans();
			ex.printStackTrace();
		}
		finally
		{
			dImpl.closeStmt();
			dCn.closeCn();
			
		}		
	}
	
	public void checkPublish(PublishSUBForm form)
	{
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn);
		form1 = form;
		//String parimaryId = "";
		dCn.beginTrans();
		try
		{
			
			parimaryId = form.getCtId();
			savePublish();
			if(form.getTaskInfoForm().getTcStatus().equals("1"))
				finishTask();
			else
				goOnTask("2");
			
			dCn.commitTrans();
		}
		catch(Exception ex)
		{
			dCn.rollbackTrans();
			ex.printStackTrace();
		}
		finally
		{
			dImpl.closeStmt();
			dCn.closeCn();
		}	
	}
	
	
	public void submitPublish(PublishSUBForm form)
	{
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn);
		form1 = form;
		//String parimaryId = "";
		dCn.beginTrans();
		try
		{
			
			parimaryId = form.getCtId();
			savePublish();
			String [] fileName = form.getFileList();
			String [] realName = form.getFileRealName();
			if(fileName!=null&&fileName.length>0) saveAttach(fileName,realName);
			
			submitPublishStatus();
			
			goOnTask("0");
			
			dCn.commitTrans();
		}
		catch(Exception ex)
		{
			dCn.rollbackTrans();
			ex.printStackTrace();
		}
		finally
		{
			dImpl.closeStmt();
			dCn.closeCn();
		}	
	}
	
	public PublishSUBForm load(String id)
	{
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn);
		form1 = new PublishSUBForm();
		try
		{
			String sqlStr = "select * from tb_contentsub where ct_id='" + id + "'";			
			Hashtable content = dImpl.getDataInfo(sqlStr);
			if(content!=null)
			{
				form1.setCtTitle(content.get("ct_title").toString());
				form1.setCtContent(content.get("ct_content").toString());
				form1.setCtCreateTime(content.get("ct_create_time").toString());
				form1.setCtFeedbackFlag(content.get("ct_feedback_flag").toString());
				form1.setCtFileFlag(content.get("ct_fileflag").toString());
				form1.setCtFocusFlag(content.get("ct_specialflag").toString());
				form1.setCtInsertTime(content.get("ct_inserttime").toString());
				form1.setCtKeywords(content.get("ct_keywords").toString());
				//form1.setCtSequence(ctSequence);
				form1.setCtSource(content.get("ct_source").toString());
				form1.setCtTitle(content.get("ct_title").toString());
				form1.setCtUrl(content.get("ct_url").toString());	
				form1.setCtImgPath(content.get("ct_img_path").toString());
				form1.setSjId(content.get("sj_id").toString());	
				form1.setUrId(content.get("ur_id").toString());
				form1.setDtId(content.get("dt_id").toString());
				form1.setFilePath(content.get("ct_filepath").toString());
				
				form1.setCatchNum(content.get("in_catchnum").toString());
				form1.setCateGory(content.get("in_category").toString());
				form1.setContentFlag(content.get("ct_contentflag").toString());
				
				
				form1.setDescRiption(content.get("in_description").toString());
				form1.setMediaType(content.get("in_mediatype").toString());
				
				form1.setInfoType(content.get("in_infotype").toString());
				
				form1.setFileNum(content.get("in_filenum").toString());
				
				form1.setCtId(id); 
				form1.setSjName(content.get("sj_name").toString());			
			}
		}
		catch(Exception ex)
		{			
			ex.printStackTrace();
		}
		finally
		{
			dImpl.closeStmt();
			dCn.closeCn();
		}	
		System.out.println(form1.getCtId());
		return form1;
		
	}
	
	
	/**
	 * 更新tb_content表,插入新记录
	 * @return
	 * @throws Exception
	 */
	private String savePublish() throws Exception
	{
		String parimaryId = form1.getCtId();
		dImpl.setTableName("tb_contentsub");
		if(parimaryId.equals(""))
		{
			dImpl.setPrimaryFieldName("ct_id");
			parimaryId = Long.toString(dImpl.addNew());
		}
		else
		{
			dImpl.edit("tb_contentsub","ct_id",parimaryId);
		}
		try
		{
			dImpl.setValue("ct_title",(form1.getCtTitle()),CDataImpl.STRING);
		    dImpl.setValue("ct_keywords",(form1.getCtKeywords()),CDataImpl.STRING);
		    dImpl.setValue("ct_source",(form1.getCtSource()),CDataImpl.STRING);
		    dImpl.setValue("ct_url",(form1.getCtUrl()),CDataImpl.STRING);
		    dImpl.setValue("ct_sequence",(form1.getCtSequence()),CDataImpl.INT);		    
		    dImpl.setValue("ct_feedback_flag",(form1.getCtFeedbackFlag()),CDataImpl.INT);
		    dImpl.setValue("ct_create_time",(form1.getCtCreateTime()),CDataImpl.STRING);
		    dImpl.setValue("sj_name",(form1.getSjName()),CDataImpl.STRING);
		    //dImpl.setValue("ct_special_id",(form.gets),CDataImpl.INT);
		    dImpl.setValue("sj_id",(form1.getSjId()),CDataImpl.STRING);
		    dImpl.setValue("ct_content",(form1.getCtContent()),CDataImpl.SLONG);
		    dImpl.setValue("ct_img_path",(form1.getCtImgPath()),CDataImpl.STRING);
		    dImpl.setValue("ct_focus_flag",CTools.dealNumber(form1.getCtFocusFlag()),CDataImpl.INT);
		    //dImpl.setValue("ct_image_flag",CTools.dealNumber(form.getCtTitle()),CDataImpl.INT);
		   // dImpl.setValue("ct_message_flag",(form.getCtTitle()),CDataImpl.INT);
		    dImpl.setValue("dt_id",(form1.getDtId()),CDataImpl.INT);
		    dImpl.setValue("ur_id",(form1.getUrId()),CDataImpl.INT);
		    dImpl.setValue("ct_inserttime",(form1.getCtInsertTime()),CDataImpl.STRING);
		    dImpl.setValue("ct_browse_num",form1.getCtBrowseNum(),CDataImpl.INT);
			dImpl.setValue("ct_fileflag",(form1.getCtFileFlag()),CDataImpl.STRING);
			dImpl.setValue("ct_filepath",(form1.getFilePath()),CDataImpl.STRING);
			
			dImpl.setValue("IN_CATCHNUM",(form1.getCatchNum()),CDataImpl.STRING);
			dImpl.setValue("IN_MEDIATYPE",(form1.getMediaType()),CDataImpl.STRING);
			dImpl.setValue("IN_INFOTYPE",(form1.getInfoType()),CDataImpl.STRING);
			dImpl.setValue("IN_DESCRIPTION",(form1.getDescRiption()),CDataImpl.STRING);
			dImpl.setValue("IN_CATEGORY",(form1.getCateGory()),CDataImpl.STRING);
			dImpl.setValue("IN_FILENUM",(form1.getFileNum()),CDataImpl.STRING);
			dImpl.setValue("ct_specialflag",(form1.getContentFlag()),CDataImpl.STRING);
			dImpl.update();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			throw new Exception("inser error!");
		}
		
		return parimaryId;
	}
	
	/**
	 * 更新附件表
	 * @param fileName
	 */
	
	private void saveAttach(String [] fileName,String [] realName) throws Exception
	{
		try
		{
			for(int i=0;i<fileName.length;i++)
			{
				
				dImpl.setTableName("TB_FILEATTACH");
				dImpl.setPrimaryFieldName("FA_ID");		
				dImpl.addNew();
				dImpl.setValue("ct_id",parimaryId,CDataImpl.INT);  //项目id
				//dImpl.setValue("pa_name",fileName,CDataImpl.STRING);//附件说明
				dImpl.setValue("FA_PATH",form1.getFilePath(),CDataImpl.STRING);//附件存放路径
				
				dImpl.setValue("FA_FILENAME",fileName[i],CDataImpl.STRING);//附件文件名
				dImpl.setValue("fa_name",realName[i],CDataImpl.STRING);
				dImpl.update();
			}
		}
		catch(Exception e)
		{
			throw new Exception("saveAttach() ERROR");
		}
		
		
	}
	
	private void editPublishStatus() throws Exception
	{
		String orgId = form1.getOrgSjId();
		String [] sjIds = form1.getSjId().split(",");
		
		try
		{
			for(int i=0;i<sjIds.length;i++)
			{
				
				if(orgId.indexOf(sjIds[i])==-1)
				{
					
					dImpl.setTableName("tb_contentpublishsub");
					dImpl.setPrimaryFieldName("cp_id");		
					dImpl.addNew();
					dImpl.setValue("ct_id",parimaryId,CDataImpl.INT);
					dImpl.setValue("sj_id",sjIds[i],CDataImpl.STRING);
					if(needCheck(sjIds[i]).equals(""))
						dImpl.setValue("cp_ispublish","1",CDataImpl.STRING);
					else
						dImpl.setValue("cp_ispublish","0",CDataImpl.STRING);
					dImpl.update();
					
					if(!needCheck(sjIds[i]).equals("")) addTask(sjIds[i],"0",needCheck(sjIds[i]),"-1");
				}
			}
			
			//System.out.print("delete from tb_contentsubpublish where ct_id=" + parimaryId + " and sj_id not in(" + form1.getSjId().substring(0,form1.getSjId().length()-1) + ")");
			
			dImpl.executeUpdate("delete from tb_contentpublishsub where ct_id=" + parimaryId + " and sj_id not in(" + form1.getSjId().substring(0,form1.getSjId().length()-1) + ")");
		}
		catch(Exception e)
		{
			throw new Exception("editPublishStatus() ERROR!");
			
		}
	}
	
	
	/**
	 * 审核过程中审核通过，置发布状态位
	 *
	 */
	private void finishTask() throws Exception
	{
		int length = form1.getTaskInfoForm().getChkIDs().length();
		String orgIds = form1.getTaskInfoForm().getChkIDs().substring(0,length-1);
		String tcId = form1.getTaskInfoForm().getTcParentId();
		String tcMemo = form1.getTaskInfoForm().getTcMemo();
		String tcTime = form1.getTaskInfoForm().getTctime();
		String person = form1.getTaskInfoForm().getTcSenderId();
		//System.out.print("update tb_contentpublishsub set cp_ispublish='1' where ct_id='" + parimaryId + "' and sj_id in (" + orgIds + ")");
		
		try
		{
			System.out.print("update tb_contentpublishsub set cp_ispublish='1' where ct_id='" + parimaryId + "' and sj_id in (" + orgIds + ")");
			dImpl.executeUpdate("update tb_contentpublishsub set cp_ispublish='1' where ct_id='" + parimaryId + "' and sj_id in (" + orgIds + ")");
			
			
			System.out.println("&&" + tcId);
			dImpl.edit("tb_taskcentersub","tc_id",tcId);
			dImpl.setValue("tc_memo",tcMemo,CDataImpl.STRING);
			dImpl.setValue("tc_endtime",tcTime,CDataImpl.DATE);
			dImpl.setValue("tc_isfinished","1",CDataImpl.INT);
			dImpl.update();
			
			dImpl.executeUpdate("update tb_taskcentersub set tc_isfinished='1' where ct_id='" + parimaryId + "' and tc_receiverid='" + form1.getUrId() + "'");
		}
		catch(Exception e)
		{
			throw new Exception("finishTask() ERROR!");
		}
		
	}
	
	/**
	 * 审核过程中审核未通过，置发布状态位
	 *
	 */
	private void goOnTask(String taskType) throws Exception 
	{		
		String tcId = form1.getTaskInfoForm().getTcParentId();
		String tcMemo = form1.getTaskInfoForm().getTcMemo();
		String tcTime = form1.getTaskInfoForm().getTctime();
		String tcPerson = form1.getTaskInfoForm().getTcSenderId();
		String orgId = form1.getTaskInfoForm().getChkIDs().substring(0,form1.getTaskInfoForm().getChkIDs().length()-1);
		
		//dImpl.executeUpdate("update tb_contentpublishsub set cp_ispublish where ct_id='" + parimaryId + "' and sj_id in (" + orgIds + ")");
		
		try
		{
			dImpl.edit("tb_taskcentersub","tc_id",tcId);
			dImpl.setValue("tc_memo",tcMemo,CDataImpl.STRING);
			dImpl.setValue("tc_endtime",tcTime,CDataImpl.DATE);
			dImpl.setValue("tc_isfinished","1",CDataImpl.INT);
			dImpl.update();
			
			dImpl.executeUpdate("update tb_taskcentersub set tc_isfinished='1' where ct_id='" + parimaryId + "' and tc_receiverid='" + form1.getUrId() + "'");
			
			addTask(orgId,taskType,tcPerson,tcId);
		}
		catch(Exception e)
		{
			throw new Exception("goOnTask() ERROR!");
		}
		
	}
	
	
	/**
	 *更新发布状态
	 *
	 */
	private void savePublishStatus() throws Exception
	{
		String [] sjIds = form1.getSjId().split(",");
		int submitFlag = 0;
		try
		{
			for(int i=0;i<sjIds.length;i++)
			{
				
				dImpl.setTableName("tb_contentpublishsub");
				dImpl.setPrimaryFieldName("cp_id");		
				dImpl.addNew();
				dImpl.setValue("ct_id",parimaryId,CDataImpl.INT);
				dImpl.setValue("sj_id",sjIds[i],CDataImpl.STRING);
							
				if(!needCheck(sjIds[i]).trim().equals("")){
					submitFlag++;
					dImpl.setValue("cp_ispublish","0",CDataImpl.STRING);
				}
				else
					dImpl.setValue("cp_ispublish","1",CDataImpl.STRING);
				
				dImpl.update();
				
				if(!needCheck(sjIds[i]).equals("")) addTask(sjIds[i],"0",needCheck(sjIds[i]),"-1");
			}
			
			if(submitFlag == 0){
				form1.setCtId(parimaryId);
				PublishSubmit publishSubmit = new PublishSubmit(form1);
				publishSubmit.submit();
			}
		}
		catch(Exception e)
		{
			throw new Exception("savePublishStatus() ERROR");
		}
	}
	
	/**
	 *更新发布状态
	 *
	 */
	private void submitPublishStatus() throws Exception
	{
		String orgId = form1.getOrgSjId();
		String [] sjIds = form1.getSjId().split(",");
		
		try
		{
			for(int i=0;i<sjIds.length;i++)
			{
				
				if(orgId.indexOf(sjIds[i])==-1)
				{
					
					dImpl.setTableName("tb_contentpublishsub");
					dImpl.setPrimaryFieldName("cp_id");		
					dImpl.addNew();
					dImpl.setValue("ct_id",parimaryId,CDataImpl.INT);
					dImpl.setValue("sj_id",sjIds[i],CDataImpl.STRING);
					if(needCheck(sjIds[i]).equals(""))
						dImpl.setValue("cp_ispublish","1",CDataImpl.STRING);
					else
						dImpl.setValue("cp_ispublish","0",CDataImpl.STRING);
					dImpl.update();
					
					if(!needCheck(sjIds[i]).equals("")) addTask(sjIds[i],"0",needCheck(sjIds[i]),"-1");
				}
			}
			
			
			
			//System.out.print("delete from tb_contentpublishsub where ct_id=" + parimaryId + " and sj_id not in(" + form1.getSjId().substring(0,form1.getSjId().length()-1) + ")");
			
			dImpl.executeUpdate("delete from tb_contentpublishsub where ct_id=" + parimaryId + " and sj_id not in(" + form1.getSjId().substring(0,form1.getSjId().length()-1) + ")");
		}
		catch(Exception e)
		{
			throw new Exception("editPublishStatus() ERROR!");
			
		}
	}
	
	/**
	 * 信息审核人
	 * @param id
	 * @return 审核人id
	 */
	private String needCheck(String id) throws Exception
	{
		
		String sqlStr = "select sj_need_audit,ur_id from tb_subjectsub where sj_id=" + id;
		
		try
		{
			Hashtable content = dImpl.getDataInfo(sqlStr);
			if(content!=null)
			{	
				if(content.get("sj_need_audit").toString().equals("1"))
					return content.get("ur_id").toString();
			}
		}
		catch(Exception e)
		{
			throw new Exception("needCheck() ERROR");
		}
		return "";
	}
	
	/**
	 * 新增审核任务
	 * @param id
	 * @param status 0--审核 2--退回修改
	 * @param userid 接收人
	 * @param parentid 上级任务 
	 */
	private void addTask(String id,String status,String userId,String parentid) throws Exception
	{
		try
		{
			dImpl.setTableName("tb_taskcentersub");
			dImpl.setPrimaryFieldName("tc_id");
			dImpl.addNew();
			dImpl.setValue("ct_id",parimaryId,CDataImpl.INT);
			dImpl.setValue("tc_tasktype",status,CDataImpl.INT);
			dImpl.setValue("tc_senderid",form1.getUrId(),CDataImpl.INT);
			dImpl.setValue("tc_starttime",new CDate().getThisday(),CDataImpl.DATE);
			dImpl.setValue("tc_isfinished","0",CDataImpl.INT);
			dImpl.setValue("tc_receiverid",userId,CDataImpl.INT);
			//dImpl.setValue("tc_memo",tc_memo,CDataImpl.STRING);
			dImpl.setValue("tc_parentid",parentid,CDataImpl.INT);
			dImpl.setValue("sj_id",","+ id +",",CDataImpl.STRING);
			dImpl.update();
		}
		catch(Exception e)
		{
			throw new Exception("addTask() ERROR");
		}
		
	}
	
}
