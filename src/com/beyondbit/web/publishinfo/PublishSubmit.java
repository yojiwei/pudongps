package com.beyondbit.web.publishinfo;

import com.beyondbit.web.form.*;
import com.component.database.CDataImpl;
import com.component.database.CDataCn;
import com.util.CDate;
import com.util.CTools;
import java.util.Vector;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Hashtable;
public class PublishSubmit {
	
	
	private PublishBaseForm form = null;
	private CDataCn dCn = null;
	private CDataImpl dImpl = null;
	private String subId = "";
	private String parimaryId = "";
	private String sjParID = "";
	private String sjParNAME = "";

	public PublishSubmit(PublishBaseForm obj)
	{
		form  = obj;
	}
	
	
	public boolean submit()
	{						
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn);
		try
		{
			dCn.beginTrans();
			this.subId = form.getCtId(); 
			boolean flag = dbChange();
			submitAttach();
			//System.out.print("submitScore=" + Messages.getString("submitScore"));
			setScore(Messages.getString("submitScore"),"0");
			if(flag)
				setScore(Messages.getString("accept"),"1");

			
		}
		catch(Exception e)
		{
			dCn.rollbackTrans();
		}
		finally
		{
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return true;
	}
	
	public void acceptInfo(String aStatus,String pass)
	{
		dCn = new CDataCn();
		dImpl = new CDataImpl(dCn);
		parimaryId = form.getCtId();
		try
		{
			dCn.beginTrans();
			accept(aStatus);
			savePublishStatus();
			setScore(Messages.getString(pass),"1"); 
		}
		catch(Exception e)
		{
			dCn.rollbackTrans();
		}
		finally
		{
			dImpl.closeStmt();
			dCn.closeCn();
		}
	}

	private boolean dbChange() throws Exception
	{		
		dImpl.setTableName("tb_content");
		dImpl.setPrimaryFieldName("ct_id");
		parimaryId = Long.toString(dImpl.addNew());					
		try
		{
			dImpl.setValue("ct_title",(form.getCtTitle()),CDataImpl.STRING);
		    dImpl.setValue("ct_keywords",(form.getCtKeywords()),CDataImpl.STRING);
		    dImpl.setValue("ct_source",(form.getCtSource()),CDataImpl.STRING);
		    dImpl.setValue("ct_url",(form.getCtUrl()),CDataImpl.STRING);
		    dImpl.setValue("ct_sequence",(form.getCtSequence()),CDataImpl.INT);		    
		    dImpl.setValue("ct_feedback_flag",(form.getCtFeedbackFlag()),CDataImpl.INT);
		    dImpl.setValue("ct_create_time",(form.getCtCreateTime()),CDataImpl.STRING);
		    dImpl.setValue("sj_sunname",(form.getSjName()),CDataImpl.STRING);
		    //dImpl.setValue("ct_special_id",(form.gets),CDataImpl.INT);
		    dImpl.setValue("sj_sunid",(form.getSjId()),CDataImpl.STRING);
		    dImpl.setValue("ct_content",(form.getCtContent()),CDataImpl.SLONG);
		    dImpl.setValue("ct_img_path",(form.getCtImgPath()),CDataImpl.STRING);
		    dImpl.setValue("ct_specialflag",CTools.dealNumber(form.getCtFocusFlag()),CDataImpl.INT);
		    //dImpl.setValue("ct_image_flag",CTools.dealNumber(form.getCtTitle()),CDataImpl.INT);
		    // dImpl.setValue("ct_message_flag",(form.getCtTitle()),CDataImpl.INT);
		    dImpl.setValue("dt_id",(form.getDtId()),CDataImpl.INT);
		    dImpl.setValue("ur_id",(form.getUrId()),CDataImpl.INT);
		    dImpl.setValue("ct_inserttime",(new CDate().getThisday()),CDataImpl.STRING);
		    dImpl.setValue("ct_browse_num",form.getCtBrowseNum(),CDataImpl.INT);
			dImpl.setValue("ct_fileflag",(form.getCtFileFlag()),CDataImpl.STRING);
			dImpl.setValue("ct_filepath",(form.getFilePath()),CDataImpl.STRING);
			
			dImpl.setValue("IN_CATCHNUM",(form.getCatchNum()),CDataImpl.STRING);
			dImpl.setValue("IN_MEDIATYPE",(form.getMediaType()),CDataImpl.STRING);
			dImpl.setValue("IN_INFOTYPE",(form.getInfoType()),CDataImpl.STRING);
			dImpl.setValue("IN_DESCRIPTION",(form.getDescRiption()),CDataImpl.STRING);
			dImpl.setValue("IN_CATEGORY",(form.getCateGory()),CDataImpl.STRING);
			dImpl.setValue("IN_FILENUM",(form.getFileNum()),CDataImpl.STRING);
			dImpl.setValue("ct_contentflag",(form.getContentFlag()),CDataImpl.STRING);
			dImpl.update();
			dImpl.executeUpdate("update tb_contentsub set ct_publish_flag='1',ct_newid='" + parimaryId + "' where ct_id = '" + form.getCtId() + "'");
			
			if(setSJID()) {
				System.out.println("update tb_content set sj_id='" + this.sjParID + "', sj_name = '" + this.sjParNAME + "' where ct_id='" + parimaryId + "'");
				dImpl.executeUpdate("update tb_content set sj_id='" + this.sjParID + "', sj_name = '" + this.sjParNAME + "' where ct_id='" + parimaryId + "'");
				
				accept();
				  
				return true;
			}
			else{
				System.out.println("update tb_content set sj_id='" + this.sjParID + "', sj_name = '" + this.sjParNAME + "' where ct_id='" + parimaryId + "'");
				dImpl.executeUpdate("update tb_content set sj_id='" + this.sjParID + "', sj_name = '" + this.sjParNAME + "' where ct_id='" + parimaryId + "'");
				return false;
			}
			
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			throw new Exception("dbChange() ERROR!");
		}
	}
	
	private boolean setSJID(){
		String [] sjIDs = CTools.split(form.getSjId(),",");
		boolean sjFlag = true;
		for(int i=0;i<sjIDs.length;i++){
			String sjParid = getParSJID(sjIDs[i]);
			if(!sjParid.equals("")){
				dImpl.setTableName("tb_contentpublish");
				dImpl.setPrimaryFieldName("cp_id");		
				dImpl.addNew();
				dImpl.setValue("ct_id",parimaryId,CDataImpl.INT);
				dImpl.setValue("sj_id",sjParid,CDataImpl.STRING);
				try {
					System.out.println("check=" + needCheck(sjParid) + "&&&&&&&&&");
					if(needCheck(sjParid).equals("")){
						dImpl.setValue("cp_ispublish","1",CDataImpl.STRING);
					}
					else{
						dImpl.setValue("cp_ispublish","0",CDataImpl.STRING);
						sjFlag = false;
					}
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				dImpl.update();
				
				
				
			}
		}
		
		
		
		return sjFlag;
		
	}
	
	
	
	private String getParSJID(String sjid){
		Hashtable content = dImpl.getDataInfo("select sj_id,sj_name from tb_subject where sj_id=(select sj_bossid from tb_subjectsub where sj_id='" + sjid + "')");
		if(content!=null){
			//System.out.println(content.get("sj_id").toString() + "&&" + content.get("sj_name").toString());
			this.sjParID += content.get("sj_id").toString() + ",";
			this.sjParNAME += content.get("sj_name").toString() + ",";
			return content.get("sj_id").toString();
		}
		else 
			return "";
	}
	
	
	
	
	private boolean accept()
	{		
		dImpl.edit("tb_content","ct_id",parimaryId);
		
		try
		{
			dImpl.setValue("sj_id",(this.sjParID),CDataImpl.STRING);
		    dImpl.setValue("sj_name",(this.sjParNAME),CDataImpl.STRING);
		    dImpl.setValue("ct_publish_flag","1",CDataImpl.STRING);		   
			dImpl.update();	
			
			return true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			return false;				
		}
		
	}
	
	
	private void submitAttach()
	{		
		Vector Vect = dImpl.splitPage("select fa_path,fa_filename,fa_name from tb_fileattach where ct_id='" + this.subId + "'",10,1);				
		try {
			if(Vect!=null)
			{
				for(int i=0;i<Vect.size();i++)
				{				
					Hashtable content = (Hashtable)Vect.get(i);
					
					dImpl.setTableName("tb_image");
					dImpl.setPrimaryFieldName("im_id");
					String attachId = Long.toString(dImpl.addNew());
					dImpl.setValue("im_path",content.get("fa_path").toString(),CDataImpl.STRING);
					dImpl.setValue("im_filename",content.get("fa_filename").toString(),CDataImpl.STRING);
					
					dImpl.setValue("im_name",content.get("fa_name").toString(),CDataImpl.STRING);
					
					dImpl.setValue("ct_id",this.parimaryId,CDataImpl.INT);
					dImpl.update();
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private boolean accept(String aStatus)
	{		
		dImpl.edit("tb_content","ct_id",form.getCtId());
		
		try
		{
			dImpl.setValue("sj_id",(form.getSjId()),CDataImpl.STRING);
		    dImpl.setValue("sj_name",(form.getSjName()),CDataImpl.STRING);
		    dImpl.setValue("ct_publish_flag",aStatus,CDataImpl.STRING);		   
			dImpl.update();	
			
			return true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			return false;				
		}
		
	}
	
	private void savePublishStatus() throws Exception
	{
		String [] sjIds = form.getSjId().split(",");
		
		try
		{
			for(int i=0;i<sjIds.length;i++)
			{
				
				dImpl.setTableName("tb_contentpublish");
				dImpl.setPrimaryFieldName("cp_id");		
				dImpl.addNew();
				dImpl.setValue("ct_id",parimaryId,CDataImpl.INT);
				dImpl.setValue("sj_id",sjIds[i],CDataImpl.STRING);
				dImpl.setValue("cp_ispublish","1",CDataImpl.STRING);		
				dImpl.update();
				
				
			}
		}
		catch(Exception e)
		{
			throw new Exception("savePublishStatus() ERROR");
		}
	}
	
	private void setScore(String score,String status) throws Exception
	{
		dImpl.setTableName("tb_score");
		dImpl.setPrimaryFieldName("sc_id");
		dImpl.addNew();		
		try
		{
			dImpl.setValue("ct_id",parimaryId,CDataImpl.INT);	    
		    dImpl.setValue("dt_id",(form.getDtId()),CDataImpl.INT);
		    dImpl.setValue("sc_score",score,CDataImpl.INT);
		    dImpl.setValue("sc_scoretime",new CDate().getThisday(),CDataImpl.DATE);
		    dImpl.setValue("sc_submittime",new CDate().getThisday(),CDataImpl.DATE);
		    dImpl.setValue("sc_status",status,CDataImpl.STRING);
		    if(!subId.equals(""))
		    	dImpl.setValue("ct_orgid",subId,CDataImpl.INT);
			dImpl.update();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			throw new Exception("setScore() ERROR!");
		}
	}
	
	private String needCheck(String id) throws Exception
	{
		
		System.out.println("select sj_need_audit,ur_id from tb_subject where sj_id=" + id);
		String sqlStr = "select sj_need_audit,ur_id from tb_subject where sj_id=" + id;
		
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
}
