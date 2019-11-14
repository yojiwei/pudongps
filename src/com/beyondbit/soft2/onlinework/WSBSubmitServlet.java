/*
 * Created on 2004-9-7
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.beyondbit.soft2.onlinework;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.component.database.*;
import com.beyondbit.soft2.utils.*;
import com.jspsmart.upload.*;
import com.util.CTools;
import com.website.User;
import com.util.CDate;

/**
 * @author along
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class WSBSubmitServlet
    extends HttpServlet {

    /**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = 127295698507497819L;	

	/* (non-Javadoc)
     * @see javax.servlet.http.HttpServlet#doPost(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     */
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException,
        IOException {
        // TODO Auto-generated method stub
        javax.servlet.jsp.PageContext pageContext = javax.servlet.jsp.
            JspFactory.getDefaultFactory().getPageContext(this, request,
            response, null, true, 8192, true);
        com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.
            SmartUpload();
        myUpload.initialize(pageContext);

        Document doc = XMLUtil.newDocument();
        Element root = doc.createElement("因公出国或赴港澳任务申请表");

        doc.appendChild(root);

        try {
            myUpload.setDeniedFilesList("exe,bat,jsp"); //设置上传文件后缀限制
            myUpload.upload();

            String pr_id = CTools.dealUploadString(myUpload.getRequest().
                getParameter("pr_id")).trim();
            String wo_id = CTools.dealUploadString(myUpload.getRequest().
                    getParameter("wo_id")).trim();
            String ow_id = CTools.dealUploadString(myUpload.getRequest().
                getParameter("ow_id")).trim();
            String owt1_id = CTools.dealUploadString(myUpload.getRequest().
                getParameter("owt1_id")).trim();
            String pr_name = CTools.dealUploadString(myUpload.getRequest().
                getParameter("pr_name")).trim();
            String ow_attpath = CTools.dealUploadString(myUpload.getRequest().
                getParameter("ow_attpath")).trim();

            User user = (User) request.getSession().getAttribute("user");

            if (user == null) { //如果用户没有登录，则新生成一个用户名，并登录
                response.sendRedirect(
                    "/website/login/Login.jsp?oPage=/website/onlinework/wsb.jsp?pr_id=" +
                    pr_id + "&ow_id=" + ow_id + "&owt1_id=" + owt1_id +
                    "&pr_name=" + pr_name);
            }
            String us_id = user.getId();

            // 组团信息
            // 申报单位
            String lwdw = CTools.dealUploadString(myUpload.getRequest().
                                                  getParameter("lwdw")).trim();
            // 组团单位
            String ztdw = CTools.dealUploadString(myUpload.getRequest().
                                                  getParameter("ztdw")).trim();
            // 组团单位
            String ztname = CTools.dealUploadString(myUpload.getRequest().
                getParameter("ztname")).trim();
            // 团组编号
            String ztdwdm = CTools.dealUploadString(myUpload.getRequest().
                getParameter("ztdwdm")).trim();
            // 申报人数
            String ztnum_b = CTools.dealUploadString(myUpload.getRequest().
                getParameter("ztnum_b")).trim();
            // 申报天数
            String cfts_b = CTools.dealUploadString(myUpload.getRequest().
                getParameter("cfts_b")).trim();
            // 出访任务
            String cfrw = CTools.dealUploadString(myUpload.getRequest().
                                                  getParameter("cfrw")).trim();
            // 出访事由
            String pjlx = CTools.dealUploadString(myUpload.getRequest().
                                                  getParameter("pjlx")).trim();
            Element temp = doc.createElement("组团信息");
            temp.setAttribute("lwdw", lwdw);
            temp.setAttribute("ztdw", ztdw);
            temp.setAttribute("ztname", ztname);
            temp.setAttribute("ztdwdm", ztdwdm);
            temp.setAttribute("ztnum_b", ztnum_b);
            temp.setAttribute("cfts_b", cfts_b);
            temp.setAttribute("cfrw", cfrw);
            temp.setAttribute("pjlx", pjlx);
            root.appendChild(temp);

            //System.out.println(lwdw);
            /*
             * 出访地点
             */
            // 序号
            String[] xuhao = myUpload.getRequest().getParameterValues("xuhao");
            // 出访地点
            String[] gjname = myUpload.getRequest().getParameterValues("gjname");
            // 是否过境
            String[] guojing = myUpload.getRequest().getParameterValues(
                "guojing");
            // 停留天数
            String[] tlsj = myUpload.getRequest().getParameterValues("tlsj");
            // 邀请方
            String[] yqzhong = myUpload.getRequest().getParameterValues(
                "yqzhong");
            // 出访（途径）时间
            String[] dddate = myUpload.getRequest().getParameterValues("dddate");
            String[] leftdate = myUpload.getRequest().getParameterValues(
                "leftdate");
            temp = doc.createElement("出访地点");
            Element temp1 = null;
            for (int i = 0; i < xuhao.length; i++) {
                if(gjname[i] != null && !gjname[i].equals("")){
                    temp1 = doc.createElement("地点");
                    temp1.setAttribute("xuhao", xuhao[i]);
                    temp1.setAttribute("gjname", gjname[i]);
                    temp1.setAttribute("guojing", guojing[i]);
                    temp1.setAttribute("tlsj", tlsj[i]);
                    temp1.setAttribute("yqzhong", yqzhong[i]);
                    temp1.setAttribute("dddate", dddate[i]);
                    temp1.setAttribute("leftdate", leftdate[i]);
                    temp.appendChild(temp1);
                }
            }
            root.appendChild(temp);

            /*
             * 人员组成
             */
            // 序号
            String[] recordnum = myUpload.getRequest().getParameterValues(
                "recordnum");
            // 姓名
            String[] name = myUpload.getRequest().getParameterValues("name");
            // 性别
            String[] xb = myUpload.getRequest().getParameterValues("xb");
            // 出生日期
            String[] csdate = myUpload.getRequest().getParameterValues("csdate");
            // 身份证
            String[] idcard = myUpload.getRequest().getParameterValues("idcard");
            // 工作单位
            String[] gzdw = myUpload.getRequest().getParameterValues("gzdw");
            // 职务
            String[] nzw = myUpload.getRequest().getParameterValues("nzw");
            // 级别
            String[] nzc = myUpload.getRequest().getParameterValues("nzc");
            temp = doc.createElement("人员组成");
            root.appendChild(temp);
            for (int i = 0; i < recordnum.length; i++) {
                if(name[i] != null && !gjname[i].equals("")){
                    temp1 = doc.createElement("人员");
                    temp1.setAttribute("recordnum", recordnum[i]);
                    temp1.setAttribute("name", name[i]);
                    temp1.setAttribute("xb", xb[i]);
                    temp1.setAttribute("csdate", csdate[i]);
                    temp1.setAttribute("idcard", idcard[i]);
                    temp1.setAttribute("gzdw", gzdw[i]);
                    temp1.setAttribute("dwzw", "");
                    temp1.setAttribute("nzw", nzw[i]);
                    temp1.setAttribute("nzc", nzc[i]);
                    temp.appendChild(temp1);
                }
            }

            /*
             * 出访费用
             */
            // 国际旅费
            String [] gjlf = myUpload.getRequest().getParameterValues("gjlf");
            String gjlfStr = "";
            if(gjlf != null){
                for (int i = 0; i < gjlf.length; i++) {
                    gjlfStr += gjlf[i] + ",";
                }
            }
            // 食费
            String [] sif = myUpload.getRequest().getParameterValues("sif");
            String sifStr = "";
            if(sif != null){
                for (int i = 0; i < sif.length; i++) {
                    sifStr += sif[i] + ",";
                }
            }
            // 宿费
            String [] suf = myUpload.getRequest().getParameterValues("suf");
            String sufStr = "";
            if(suf != null){
                for (int i = 0; i < suf.length; i++) {
                    sufStr += suf[i] + ",";
                }
            }
            // 公杂费
            String [] gzf = myUpload.getRequest().getParameterValues("gzf");
            String gzfStr = "";
            if(gzf != null){
                for (int i = 0; i < gzf.length; i++) {
                    gzfStr += gzf[i] + ",";
                }
            }
            // 零用金
            String [] lyj = myUpload.getRequest().getParameterValues("sif");
            String lyjStr = "";
            if(lyj != null){
                for (int i = 0; i < lyj.length; i++) {
                    lyjStr += lyj[i] + ",";
                }
            }
            // 备用金
            String [] byj = myUpload.getRequest().getParameterValues("byj");
            String byjStr = "";
            if(byj != null){
                for (int i = 0; i < byj.length; i++) {
                    byjStr += byj[i] + ",";
                }
            }
            // 其它
            String [] qt = myUpload.getRequest().getParameterValues("sif");
            String qtStr = "";
            if(qt != null){
                for (int i = 0; i < qt.length; i++) {
                    qtStr += qt[i] + ",";
                }
            }
            temp = doc.createElement("出访费用");
            temp.setAttribute("gjlf", gjlfStr);
            temp.setAttribute("sif", sifStr);
            temp.setAttribute("suf", sufStr);
            temp.setAttribute("gzf", gzfStr);
            temp.setAttribute("lyj", lyjStr);
            temp.setAttribute("byj", byjStr);
            temp.setAttribute("qt", qtStr);
            root.appendChild(temp);

            /*
             * 出访团组详细情况
             */
            // 1、邀请单位或邀请忍情况简介（包括地址、电话）及与被邀请者的关系
            String visitObjectRelation = CTools.dealUploadString(myUpload.
                getRequest().getParameter("visitObjectRelation")).trim();
            // 2、有无"两个中国"、"一中一台"或其他政治敏感问题
            String visitojectQuestion = CTools.dealUploadString(myUpload.
                getRequest().getParameter("visitojectQuestion")).trim();
            // 3、出访目的及出访理由
            String visitObjectReason = CTools.dealUploadString(myUpload.
                getRequest().getParameter("visitObjectReason")).trim();
            // 1、活动内容及日程（出访活动内容及详细日程安排）
            String visitObjectCalendar = CTools.dealUploadString(myUpload.
                getRequest().getParameter("visitObjectCalendar")).trim();
            // 1、出访人员各自的具体任务
            String personStructTask = CTools.dealUploadString(myUpload.
                getRequest().getParameter("personStructTask")).trim();
            // 2、如有与职务不同的对外身份的说明
            String personStructExplain = CTools.dealUploadString(myUpload.
                getRequest().getParameter("personStructExplain")).trim();
            // 3、如有离退休人员，派遣出访的特殊理由
            String personStructReason = CTools.dealUploadString(myUpload.
                getRequest().getParameter("personStructReason")).trim();
            // 4、局级干部两次以上出访理由说明
            String personTwoAccess = CTools.dealUploadString(myUpload.
                getRequest().getParameter("personTwoAccess")).trim();
            // 5、其他
            String Other = CTools.dealUploadString(myUpload.getRequest().
                getParameter("Other")).trim();
            temp = doc.createElement("出访团组详细情况");

            Element temp2 = doc.createElement("visitObjectRelation");
            temp2.appendChild(doc.createTextNode(visitObjectRelation));
            temp.appendChild(temp2);

            temp2 = doc.createElement("visitojectQuestion");
            temp2.appendChild(doc.createTextNode(visitojectQuestion));
            temp.appendChild(temp2);

            temp2 = doc.createElement("visitObjectReason");
            temp2.appendChild(doc.createTextNode(visitObjectReason));
            temp.appendChild(temp2);

            temp2 = doc.createElement("visitObjectCalendar");
            temp2.appendChild(doc.createTextNode(visitObjectCalendar));
            temp.appendChild(temp2);

            temp2 = doc.createElement("personStructTask");
            temp2.appendChild(doc.createTextNode(personStructTask));
            temp.appendChild(temp2);

            temp2 = doc.createElement("personStructExplain");
            temp2.appendChild(doc.createTextNode(personStructExplain));
            temp.appendChild(temp2);

            temp2 = doc.createElement("personStructReason");
            temp2.appendChild(doc.createTextNode(personStructReason));
            temp.appendChild(temp2);

            temp2 = doc.createElement("personTwoAccess");
            temp2.appendChild(doc.createTextNode(personTwoAccess));
            temp.appendChild(temp2);

            temp2 = doc.createElement("Other");
            temp2.appendChild(doc.createTextNode(Other));
            temp.appendChild(temp2);

            root.appendChild(temp);

            CDataCn dCn = new CDataCn();
            CDataImpl dImpl = new CDataImpl(dCn);
            /*
             * 附件
             */
            // 附件说明
            String[] pa_name = myUpload.getRequest().getParameterValues("fjsm1");
            if (pa_name != null) {
                /*
                int count = myUpload.getFiles().getCount();
                if (count > 0) {
                    String path = dImpl.getInitParameter("workattach_save_path");
                    if (ow_attpath.equals("")) { //附件的存放目录不存在
                        CDate oDate = new CDate();
                        String sToday = oDate.getThisday();
                        int numeral = 0;
                        numeral = (int) (Math.random() * 100000);
                        ow_attpath = sToday + Integer.toString(numeral);
                        java.io.File newDir = new java.io.File(path +
                            ow_attpath);
                        if (!newDir.exists()) { //如果目录不存在，则生成目录
                            newDir.mkdirs();
                        }
                    }
                    count = myUpload.save(path + ow_attpath); //保存文件
                }*/

                for (int i = 0; i < pa_name.length; i++) {
                    temp = doc.createElement("附件");
                    temp.setAttribute("name", pa_name[i].trim());
                    temp.setAttribute("filename",
                                      myUpload.getFiles().getFile(i).getFileName().trim());
                    File file = myUpload.getFiles().getFile(i);
                    int len = file.getSize();
                    byte[] fileArray = new byte[len];
                    for (int j = 0; j < len; j++) {
                        fileArray[j] = file.getBinaryData(j);
                    }
                    temp.setAttribute("contentsize", String.valueOf(len));
                    temp.setAttribute("contenttype", file.getFileExt());

                    /*
                    dImpl.addNew("tb_onlineworkattach", "oa_id", CDataImpl.PRIMARY_KEY_IS_VARCHAR);
                    dImpl.setValue("ow_id", ow_id, CDataImpl.STRING);
                    dImpl.setValue("");*/

                    byte[] base64Array = new org.apache.commons.codec.binary.
                        Base64().
                        encode(fileArray);

                    temp.appendChild(doc.createTextNode(new String(base64Array)));
                    root.appendChild(temp);
                }
            }
            String ow_content = XMLUtil.doc2String(doc);

            dCn.beginTrans();

            if (ow_id == null || ow_id.equals("")) {
                wo_id = dImpl.addNew("tb_work", "wo_id",
                                     CDataImpl.PRIMARY_KEY_IS_VARCHAR);
                dImpl.setValue("pr_id", pr_id, CDataImpl.STRING);
                dImpl.setValue("wo_applyPeople", user.getUserName(),
                               CDataImpl.STRING);
                dImpl.setValue("wo_contactpeople", user.getUserName(),
                               CDataImpl.STRING);
                dImpl.setValue("wo_tel", user.getTel(), CDataImpl.STRING);
                dImpl.setValue("us_id", us_id, CDataImpl.STRING);
                dImpl.setValue("wo_postcode", user.getZip(), CDataImpl.STRING);
                dImpl.setValue("wo_projectname", pr_name, CDataImpl.STRING);
                dImpl.setValue("wo_address", user.getAddress(),
                               CDataImpl.STRING);
                dImpl.setValue("wo_idcard", user.getIdCardNumber(),
                               CDataImpl.STRING);
                dImpl.setValue("WO_STATUS", "1", CDataImpl.STRING); //项目状态
                dImpl.setValue("WO_ISSTAT", "0", CDataImpl.STRING); //项目是否统计过
                dImpl.setValue("WO_APPLYTIME", new CDate().getNowTime(),
                               CDataImpl.DATE); //项目的申请时间
                dImpl.update();

                ow_id = dImpl.addNew("tb_onlinework", "ow_id",
                                     CDataImpl.PRIMARY_KEY_IS_VARCHAR);
                dImpl.setValue("wo_id", wo_id, CDataImpl.STRING);
                dImpl.setValue("ow_content", ow_content, CDataImpl.SLONG);
                dImpl.setValue("owt1_id", owt1_id, CDataImpl.STRING);
                dImpl.setValue("ow_attpath", ow_attpath, CDataImpl.STRING);
                dImpl.update();

                ow_id = dImpl.addNew("tb_owexch", "oe_id",
                                     CDataImpl.PRIMARY_KEY_IS_VARCHAR);
                dImpl.setValue("wo_id", wo_id, CDataImpl.STRING);
                dImpl.setValue("oe_status", "0", CDataImpl.INT);
                dImpl.update();

            }
            else{
                System.out.println("heeerer");
                
                dImpl.edit("tb_work", "wo_id", wo_id);
                dImpl.setValue("wo_status", "1", CDataImpl.STRING);
                dImpl.update();
                
                dImpl.edit("tb_onlinework", "ow_id", ow_id);
                dImpl.setValue("ow_content", ow_content, CDataImpl.SLONG);
                dImpl.setValue("ow_attpath", ow_attpath, CDataImpl.STRING);
                dImpl.update();
                
                ow_id = dImpl.addNew("tb_owexch", "oe_id",
                        CDataImpl.PRIMARY_KEY_IS_VARCHAR);
                dImpl.setValue("wo_id", wo_id, CDataImpl.STRING);
                dImpl.setValue("oe_status", "0", CDataImpl.INT);
                dImpl.update();
            }


            dCn.commitTrans();
            dImpl.closeStmt();
            dCn.closeCn();

            response.sendRedirect("/website/usercenter/index.jsp");
        }
        catch (ServletException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        catch (SmartUploadException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }

    }

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response) throws ServletException,
        IOException {
        //TODO Method stub generated by Lomboz
    }
}
