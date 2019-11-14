// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   PublishOperate.java

package com.beyondbit.web.publishinfo;

import com.beyondbit.web.form.PublishForm;
import com.beyondbit.web.form.TaskBaseInfoForm;
import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.*;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.util.*;

public class PublishOperate
{

    PublishForm form1;
    CDataCn dCn;
    CDataImpl dImpl;
    String parimaryId;
    String cp_commend;

    public PublishOperate()
    {
        form1 = null;
        dCn = null;
        dImpl = null;
        parimaryId = "";
        cp_commend = "";
    }

    public String addNew(PublishForm form)
    {
        dCn = new CDataCn();
        dImpl = new CDataImpl(dCn);
        form1 = form;
        dCn.beginTrans();
        try
        {
            parimaryId = savePublish();
            form.setCtId(parimaryId);
            String fileName[] = form.getFileList();
            String realName[] = form.getFileRealName();
            if(fileName != null && fileName.length > 0)
                saveAttach(fileName, realName);
            savePublishStatus();
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
        return parimaryId;
    }

    public void editPublish(PublishForm form)
    {
        dCn = new CDataCn();
        dImpl = new CDataImpl(dCn);
        form1 = form;
        dCn.beginTrans();
        try
        {
            parimaryId = form.getCtId();
            form1.setUpdateTime((new Date()).toLocaleString().trim());
            savePublish();
            setUpdateLog();
            editContentPublish(form.getSjId(), parimaryId);
            String str = checkContentPulishLate();
            editContentPublishLate(str);
            String fileName[] = form.getFileList();
            String realName[] = form.getFileRealName();
            boolean booC = false;
            ResultSet rsCheck = dImpl.executeQuery("select ADDNUM from tb_infostatic where updatenum = 1 and infoid = " + parimaryId);
            if(!rsCheck.next())
                booC = true;
            rsCheck.close();
            if(booC)
            {
                ResultSet rsContent = dImpl.executeQuery("select dt_id from tb_content where ct_id=" + parimaryId + " ");
                if(rsContent.next())
                    dImpl.executeUpdate("insert into tb_infostatic(ADDNUM,PUBNUM,UPDATENUM,OPERTIME,DEPTID,SCORE,INFOID) values(0,0,1,sysdate," + rsContent.getInt("dt_id") + ",0," + parimaryId + ")");
                rsContent.close();
            }
            if(fileName != null && fileName.length > 0)
                saveAttach(fileName, realName);
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
        return;
    }

    public void checkPublish(PublishForm form)
    {
        dCn = new CDataCn();
        dImpl = new CDataImpl(dCn);
        form1 = form;
        dCn.beginTrans();
        try
        {
            parimaryId = form.getCtId();
            savePublish();
            String sjIds[] = form1.getSjId().split(",");
            boolean needShenpi = false;
            boolean needShenhe = false;
            ResultSet rsSubject = dImpl.executeQuery("select SJ_NEED_AUDIT,SJ_SHNAMES from tb_subject where sj_id=" + sjIds[0]);
            if(rsSubject.next())
            {
                needShenhe = !CTools.dealNull(rsSubject.getString("SJ_SHNAMES")).trim().equals("");
                needShenpi = CTools.dealNull(rsSubject.getString("SJ_NEED_AUDIT")).trim().equals("1");
            }
            String str = checkContentPulishLate();
            editContentPublishLate(str);
            String tcStatus = form.getTaskInfoForm().getTcStatus();
            String tcPersion = CTools.replace(CTools.replace(form.getTaskInfoForm().getTcPerson(), "'", ""), "\"", "").trim();
            String tcPersionName = CTools.replace(CTools.replace(form.getTaskInfoForm().getTcPersonName(), "'", ""), "\"", "").trim();
            String tcMemo = CTools.replace(CTools.replace(form.getTaskInfoForm().getTcMemo(), "'", ""), "\"", "").trim();
            if(tcStatus.equals("1"))
            {
                dImpl.executeUpdate("update tb_contentpublish set AUDIT_STATUS=1,AUDITER='" + tcPersionName + "',AUDITOPINIION='" + tcMemo + "' where ct_id=" + parimaryId + " and SJ_ID in(select sj_id from tb_subject where SJ_SHIDS like '%," + tcPersion + ",%')");
                dImpl.executeUpdate("update tb_contentpublish set CP_ISPUBLISH=1 where ct_id=" + parimaryId + " and SJ_ID in(select sj_id from tb_subject where SJ_SHIDS like '%," + tcPersion + ",%') and CHECK_STATUS=1");
                ResultSet rsCheck = dImpl.executeQuery("select ct_id from tb_contentpublish where ct_id=" + parimaryId + " and CP_ISPUBLISH<>1");
            } else
            if(tcStatus.equals("0"))
                dImpl.executeUpdate("update tb_contentpublish set AUDIT_STATUS=2,AUDITER='" + tcPersionName + "',AUDITOPINIION='" + tcMemo + "' where ct_id=" + parimaryId + " and SJ_ID in(select sj_id from tb_subject where SJ_SHIDS like '%," + tcPersion + ",%')");
            else
            if(tcStatus.equals("2"))
            {
                String sqlWhere_1 = needShenhe ? "AUDIT_STATUS = 0" : "AUDIT_STATUS = 1";
                String sqlWhere_2 = needShenpi ? "CHECK_STATUS = 0" : "CHECK_STATUS = 1";
                if(!"".equals(sqlWhere_1))
                    sqlWhere_2 = "," + sqlWhere_2;
                String sSql = "update tb_contentpublish set " + sqlWhere_1 + sqlWhere_2 + " where ct_id = " + parimaryId;
                dImpl.executeUpdate(sSql);
            }
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
        return;
    }

    public void submitPublish(PublishForm form)
    {
        dCn = new CDataCn();
        dImpl = new CDataImpl(dCn);
        form1 = form;
        dCn.beginTrans();
        try
        {
            parimaryId = form.getCtId();
            form1.setUpdateTime((new Date()).toLocaleString().trim());
            savePublish();
            setUpdateLog();
            editContentPublish(form.getSjId(), parimaryId);
            String str = checkContentPulishLate();
            editContentPublishLate(str);
            String fileName[] = form.getFileList();
            String realName[] = form.getFileRealName();
            String tcStatus = form.getTaskInfoForm().getPublishStatus();
            if(tcStatus.equals("1"))
            {
                dImpl.executeUpdate("update tb_contentpublish set CHECK_STATUS=1,CP_ISPUBLISH=1 where ct_id=" + parimaryId + " ");
                ResultSet rsContent = dImpl.executeQuery("select dt_id from tb_content where ct_id=" + parimaryId + " ");
                if(rsContent.next())
                    dImpl.executeUpdate("insert into tb_infostatic(ADDNUM,PUBNUM,UPDATENUM,OPERTIME,DEPTID,SCORE,INFOID) values(0,1,0,sysdate," + rsContent.getInt("dt_id") + ",4," + parimaryId + ")");
            } else
            {
                dImpl.executeUpdate("update tb_contentpublish set CHECK_STATUS=1,CP_ISPUBLISH=0  where ct_id=" + parimaryId + " ");
            }
            dCn.commitTrans();
        }
        catch(Exception ex)
        {
            dCn.rollbackTrans();
            System.out.println("===================PublishOperate_submitPublish: " + ex);
        }
        finally
        {
            dImpl.closeStmt();
            dCn.closeCn();
        }
        return;
    }

    public void resumePublish(PublishForm form)
    {
        dCn = new CDataCn();
        dImpl = new CDataImpl(dCn);
        form1 = form;
        dCn.beginTrans();
        try
        {
            parimaryId = form.getCtId();
            savePublish();
            String str = checkContentPulishLate();
            editContentPublishLate(str);
            String fileName[] = form.getFileList();
            String realName[] = form.getFileRealName();
            if(fileName != null && fileName.length > 0)
                saveAttach(fileName, realName);
            dImpl.executeUpdate("update tb_contentpublish set AUDIT_STATUS=1,CHECK_STATUS=1,CP_ISPUBLISH=1  where ct_id=" + parimaryId);
            ResultSet rsContent = dImpl.executeQuery("select dt_id from tb_content where ct_id=" + parimaryId + " ");
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
        return;
    }

    public PublishForm load(String id)
    {
        dCn = new CDataCn();
        dImpl = new CDataImpl(dCn);
        form1 = new PublishForm();
        try
        {
            String sqlStr = "select * from tb_content where ct_id='" + id + "'";
            Hashtable content = dImpl.getDataInfo(sqlStr);
            if(content != null)
            {
                form1.setCtTitle(content.get("ct_title").toString());
                form1.setCtContent(content.get("ct_content").toString());
                form1.setCtCreateTime(content.get("ct_create_time").toString());
                form1.setCtFeedbackFlag(content.get("ct_feedback_flag").toString());
                form1.setCtFileFlag(content.get("ct_fileflag").toString());
                form1.setCtFocusFlag(content.get("ct_specialflag").toString());
                form1.setCtInsertTime(content.get("ct_inserttime").toString());
                form1.setCtKeywords(content.get("ct_keywords").toString());
                form1.setCtSource(content.get("ct_source").toString());
                form1.setCtTitle(content.get("ct_title").toString());
                form1.setCtUrl(content.get("ct_url").toString());
                form1.setCtImgPath(content.get("ct_img_path").toString());
                form1.setSjId(content.get("sj_id").toString());
                form1.setUrId(content.get("ur_id").toString());
                form1.setDtId(content.get("dt_id").toString());
                form1.setSjSunId(content.get("sj_sunid").toString());
                form1.setSjSunName(content.get("sj_sunname").toString());
                form1.setCtRight(content.get("ct_right").toString());
                form1.setCtTimeLimit(content.get("ct_timelimit").toString());
                form1.setCtId(id);
                form1.setSjName(content.get("sj_name").toString());
                form1.setCatchNum(content.get("in_catchnum").toString());
                form1.setCateGory(content.get("in_category").toString());
                form1.setContentFlag(content.get("ct_contentflag").toString());
                form1.setDescRiption(content.get("in_description").toString());
                form1.setMediaType(content.get("in_mediatype").toString());
                form1.setInfoType(content.get("in_infotype").toString());
                form1.setFileNum(content.get("in_filenum").toString());
                form1.setIsComment(content.get("ct_iscomment").toString());
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
        return form1;
    }

    private String savePublish()
        throws Exception
    {
        String parimaryId = form1.getCtId();
        dImpl.setTableName("tb_content");
        boolean isAddNew = true;
        if(parimaryId.equals(""))
        {
            isAddNew = true;
            dImpl.setPrimaryFieldName("ct_id");
            parimaryId = Long.toString(dImpl.addNew());
        } else
        {
            isAddNew = false;
            dImpl.edit("tb_content", "ct_id", parimaryId);
            if(!form1.getUpdateTime().equals(""))
                dImpl.setValue("ct_updatetime", form1.getUpdateTime(), 5);
        }
        try
        {
            dImpl.setValue("ct_title", form1.getCtTitle(), 3);
            dImpl.setValue("ct_keywords", form1.getCtKeywords(), 3);
            dImpl.setValue("ct_source", form1.getCtSource(), 3);
            dImpl.setValue("ct_url", form1.getCtUrl(), 3);
            dImpl.setValue("ct_feedback_flag", form1.getCtFeedbackFlag(), 0);
            dImpl.setValue("ct_create_time", form1.getCtCreateTime(), 3);
            dImpl.setValue("sj_name", form1.getSjName(), 3);
            dImpl.setValue("sj_id", form1.getSjId(), 3);
            dImpl.setValue("ct_img_path", form1.getCtImgPath(), 3);
            dImpl.setValue("ct_specialflag", CTools.dealNumber(form1.getCtFocusFlag()), 0);
            dImpl.setValue("dt_id", form1.getDtId(), 0);
            dImpl.setValue("ur_id", form1.getUrId(), 0);
            dImpl.setValue("ct_inserttime", form1.getCtInsertTime(), 3);
            dImpl.setValue("ct_browse_num", form1.getCtBrowseNum(), 0);
            dImpl.setValue("ct_fileflag", form1.getCtFileFlag(), 3);
            dImpl.setValue("ct_filepath", form1.getFilePath(), 3);
            dImpl.setValue("ct_publish_flag", "1", 0);
            dImpl.setValue("IN_CATCHNUM", form1.getCatchNum(), 3);
            dImpl.setValue("IN_MEDIATYPE", form1.getMediaType(), 3);
            dImpl.setValue("IN_INFOTYPE", form1.getInfoType(), 3);
            dImpl.setValue("IN_DESCRIPTION", form1.getDescRiption(), 3);
            dImpl.setValue("IN_CATEGORY", form1.getCateGory(), 3);
            dImpl.setValue("IN_FILENUM", form1.getFileNum(), 3);
            dImpl.setValue("ct_contentflag", form1.getContentFlag(), 3);
            dImpl.setValue("ct_right", form1.getCtRight(), 3);
            dImpl.setValue("ct_timelimit", form1.getCtTimeLimit(), 3);
            dImpl.setValue("ct_iscomment", form1.getIsComment(), 3);
            dImpl.setValue("ct_guildtitle", form1.getCtGuildTitle(), 3);
            dImpl.setValue("ct_subtitle", form1.getCtSubTitle(), 3);
            dImpl.setValue("ct_id_old", form1.getCtId_old(), 3);
            dImpl.setValue("primarykey_id", form1.getPrimaryKey_id(), 3);
            dImpl.update();
            dImpl.setTableName("tb_contentdetail");
            if(isAddNew)
            {
                dImpl.setPrimaryFieldName("cd_id");
                dImpl.addNew();
                dImpl.setValue("ct_id", parimaryId, 0);
            } else
            {
                dImpl.setPrimaryFieldName("ct_id");
                dImpl.edit("tb_contentdetail", "ct_id", parimaryId);
                dImpl.setValue("ct_id", parimaryId, 0);
            }
            dImpl.update();
            dImpl.setClobValue("ct_content", form1.getCtContent());
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
            throw new Exception("=============PublsihOperate.java_inser error!");
        }
        return parimaryId;
    }

    private void saveAttach(String fileName[], String realName[])
        throws Exception
    {
        try
        {
            for(int i = 0; i < fileName.length; i++)
            {
                dImpl.setTableName("TB_image");
                dImpl.setPrimaryFieldName("im_id");
                dImpl.addNew();
                dImpl.setValue("ct_id", parimaryId, 0);
                dImpl.setValue("im_path", form1.getFilePath(), 3);
                dImpl.setValue("im_filename", fileName[i], 3);
                dImpl.setValue("im_name", realName[i], 3);
                dImpl.update();
            }

        }
        catch(Exception e)
        {
            throw new Exception("=============PublsihOperate.java_saveAttach() ERROR");
        }
    }

    private void setUpdateLog()
        throws Exception
    {
        String sjIds[] = form1.getSjId().split(",");
        try
        {
            for(int i = 0; i < sjIds.length; i++)
            {
                dImpl.setTableName("tb_subjectlog");
                dImpl.setPrimaryFieldName("sg_id");
                dImpl.addNew();
                dImpl.setValue("ct_id", parimaryId, 0);
                dImpl.setValue("sj_id", sjIds[i], 3);
                dImpl.setValue("dt_id", form1.getDtId(), 3);
                new CDate();
                dImpl.setValue("sj_updatetime", CDate.getThisday(), 5);
                dImpl.update();
            }

        }
        catch(Exception e)
        {
            throw new Exception("=============PublsihOperate.java_editPublishStatus() ERROR!");
        }
    }

    private void finishTask()
        throws Exception
    {
        int length = form1.getTaskInfoForm().getChkIDs().length();
        String orgIds = form1.getTaskInfoForm().getChkIDs().substring(0, length - 2);
        String tcId = form1.getTaskInfoForm().getTcParentId();
        String tcMemo = form1.getTaskInfoForm().getTcMemo();
        String tcTime = form1.getTaskInfoForm().getTctime();
        String person = form1.getTaskInfoForm().getTcSenderId();
        try
        {
            dImpl.executeUpdate("update tb_contentpublish set cp_ispublish='1' where ct_id='" + parimaryId + "' and sj_id in (" + orgIds + ")");
            dImpl.edit("tb_taskcenter", "tc_id", tcId);
            dImpl.setValue("tc_memo", tcMemo, 3);
            dImpl.setValue("tc_endtime", tcTime, 5);
            dImpl.setValue("tc_isfinished", "1", 0);
            dImpl.update();
            dImpl.executeUpdate("update tb_taskcenter set tc_isfinished='1' where ct_id='" + parimaryId + "' and tc_receiverid='" + form1.getUrId() + "'");
        }
        catch(Exception e)
        {
            throw new Exception("=============PublsihOperate.java_finishTask() ERROR!");
        }
    }

    private void savePublishStatus()
        throws Exception
    {
        String sjIds[] = form1.getSjId().split(",");
        cp_commend = "".equals(getCp_commend()) ? "0" : getCp_commend();
        try
        {
            for(int i = 0; i < sjIds.length; i++)
            {
                checkCmd(sjIds[i]);
                boolean needShenpi = false;
                boolean needShenhe = false;
                String isPublish = "0";
                ResultSet rsSubject = dImpl.executeQuery("select SJ_NEED_AUDIT,SJ_SHNAMES from tb_subject where sj_id=" + sjIds[i]);
                if(rsSubject.next())
                {
                    needShenhe = !CTools.dealNull(rsSubject.getString("SJ_SHNAMES")).trim().equals("");
                    needShenpi = CTools.dealNull(rsSubject.getString("SJ_NEED_AUDIT")).trim().equals("1");
                }
                CRoleAccess objAC = new CRoleAccess(dCn);
                String user = form1.getTaskInfoForm().getTcPerson();
                if(objAC.isInRole("新闻直通车", user))
                {
                    needShenhe = false;
                    needShenpi = false;
                }
                if(!needShenhe && !needShenpi)
                    isPublish = "1";
                dImpl.setTableName("tb_contentpublish");
                dImpl.setPrimaryFieldName("cp_id");
                dImpl.addNew();
                dImpl.setValue("ct_id", parimaryId, 0);
                dImpl.setValue("sj_id", sjIds[i], 3);
                dImpl.setValue("cp_commend", cp_commend, 0);
                dImpl.setValue("AUDIT_STATUS", needShenhe ? "0" : "1", 0);
                dImpl.setValue("CHECK_STATUS", needShenpi ? "0" : "1", 0);
                dImpl.setValue("cp_ispublish", isPublish, 3);
                dImpl.update();
                if(sjIds[i].equals("371"))
                    dImpl.executeUpdate("insert into tb_infostatic(ADDNUM,PUBNUM,UPDATENUM,OPERTIME,DEPTID,SCORE,INFOID) values(1,0,0,sysdate," + form1.getDtId() + ",1," + parimaryId + ")");
            }

        }
        catch(Exception e)
        {
            throw new Exception("=============PublsihOperate.java_savePublishStatus() ERROR");
        }
    }

    private String needCheck(String id)
        throws Exception
    {
        String sqlStr = "select sj_need_audit,ur_id from tb_subject where sj_id=" + id;
        try
        {
            Hashtable content = dImpl.getDataInfo(sqlStr);
            if(content != null && content.get("sj_need_audit").toString().equals("1"))
                return content.get("ur_id").toString();
        }
        catch(Exception e)
        {
            throw new Exception("=============PublsihOperate.java_needCheck() ERROR");
        }
        return "";
    }

    public String getCp_commend()
    {
        return cp_commend;
    }

    public void setCp_commend(String cp_commend)
    {
        this.cp_commend = cp_commend;
    }

    public void checkCmd(String str)
    {
        if("".equals(str))
            return;
        if(getCp_commend().equals("1"))
            try
            {
                CDataCn dCn1 = new CDataCn();
                CDataImpl dImpl1 = new CDataImpl(dCn);
                String sql = "update tb_contentpublish set cp_commend = 0 where sj_id = " + str;
                dImpl1.executeUpdate(sql);
                dImpl1.closeStmt();
                dCn1.closeCn();
            }
            catch(Exception e)
            {
                System.out.println("=============PublsihOperate.java_checkCmd() ERROR " + e);
            }
    }

    public void editContentPublish(String sjId, String ctId)
    {
        if(getCp_commend().equals("1"))
            try
            {
                CDataCn dCn1 = new CDataCn();
                CDataImpl dImpl1 = new CDataImpl(dCn);
                String sql = "update tb_contentpublish set cp_commend = 0 where sj_id in (" + sjId + ")";
                dImpl1.executeUpdate(sql);
                sql = "update tb_contentpublish set cp_commend = 1 where sj_id in (" + sjId + ") and ct_id in " + ctId;
                dImpl1.executeUpdate(sql);
                dImpl1.closeStmt();
                dCn1.closeCn();
            }
            catch(Exception e)
            {
                System.out.println("=============PublsihOperate.java_editContentPublish() ERROR " + e);
            }
    }

    public String checkContentPulishLate()
    {
        String sjIds[] = form1.getSjId().split(",");
        String ct_id = form1.getCtId();
        String sqlStr = "select sj_id from tb_contentpublish where ct_id = " + ct_id;
        String sqlDel = "delete from tb_contentpublish where ct_id = " + ct_id;
        String delWhere = "";
        String sqlPing = "";
        Vector vtId = new Vector();
        String str_sj_id = "";
        try
        {
            ResultSet rs;
            for(rs = dImpl.executeQuery(sqlStr); rs.next();)
            {
                str_sj_id = rs.getString("sj_id");
                for(int i = 0; i < sjIds.length; i++)
                {
                    if(!sjIds[i].equals(str_sj_id))
                        continue;
                    vtId.add(str_sj_id);
                    str_sj_id = "";
                    break;
                }

                if(!"".equals(str_sj_id))
                    delWhere = delWhere + str_sj_id + ",";
            }

            rs.close();
            if(!"".equals(delWhere))
            {
                sqlPing = sqlDel + " and sj_id in (" + delWhere.substring(0, delWhere.length() - 1) + ")";
                dImpl.executeUpdate(sqlPing);
            }
        }
        catch(Exception e)
        {
            System.out.println("=============PublsihOperate.java_editContentPulishLate ERROR: " + e);
        }
        String sj_id = "";
        String v_sj_id = "";
        String s_sj_id = "";
        if(vtId != null)
        {
            for(int i = 0; i < sjIds.length; i++)
            {
                s_sj_id = sjIds[i];
                for(int k = 0; k < vtId.size(); k++)
                {
                    v_sj_id = vtId.get(k).toString();
                    if(!s_sj_id.equals(v_sj_id))
                        continue;
                    s_sj_id = "";
                    break;
                }

                if(!"".equals(s_sj_id))
                    sj_id = sj_id + s_sj_id + ",";
            }

        }
        if(!"".equals(sj_id))
            sj_id = sj_id.substring(0, sj_id.length() - 1);
        return sj_id;
    }

    public void editContentPublishLate(String sj_id)
    {
        if("".equals(sj_id))
            return;
        String sjIds[] = sj_id.split(",");
        String ct_id = form1.getCtId();
        cp_commend = "".equals(getCp_commend()) ? "0" : getCp_commend();
        try
        {
            for(int i = 0; i < sjIds.length; i++)
            {
                checkCmd(sjIds[i]);
                boolean needShenpi = false;
                boolean needShenhe = false;
                String isPublish = "0";
                ResultSet rsSubject = dImpl.executeQuery("select SJ_NEED_AUDIT,SJ_SHNAMES from tb_subject where sj_id=" + sjIds[i]);
                if(rsSubject.next())
                {
                    needShenhe = !CTools.dealNull(rsSubject.getString("SJ_SHNAMES")).trim().equals("");
                    needShenpi = CTools.dealNull(rsSubject.getString("SJ_NEED_AUDIT")).trim().equals("1");
                }
                CRoleAccess objAC = new CRoleAccess(dCn);
                String user = form1.getTaskInfoForm().getTcPerson();
                if(objAC.isInRole("新闻直通车", user))
                {
                    needShenhe = false;
                    needShenpi = false;
                }
                if(!needShenhe && !needShenpi)
                    isPublish = "1";
                dImpl.setTableName("tb_contentpublish");
                dImpl.setPrimaryFieldName("cp_id");
                dImpl.addNew();
                dImpl.setValue("ct_id", ct_id, 0);
                dImpl.setValue("sj_id", sjIds[i], 3);
                dImpl.setValue("cp_commend", cp_commend, 0);
                dImpl.setValue("AUDIT_STATUS", needShenhe ? "0" : "1", 0);
                dImpl.setValue("CHECK_STATUS", needShenpi ? "0" : "1", 0);
                dImpl.setValue("cp_ispublish", isPublish, 3);
                dImpl.update();
            }

        }
        catch(Exception e)
        {
            System.out.println("=============PublsihOperate.java_editContentPublishLate ERROR: " + e);
        }
    }

    public static void main(String args[])
    {
    }
}
