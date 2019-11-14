<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%@ page import="com.app.CMySelf"%>
<%@ page import="com.platform.role.*"%>

<%

  com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.SmartUpload();
  myUpload.initialize(pageContext);
  myUpload.setDeniedFilesList("exe,bat,jsp");
  myUpload.upload();

  String OPType="";//操作方式 Add是添加 Edit是修改
  String strId="";//编号
  String SJ_name="";//名称
  String SJ_parentid="0";//父id
  String SJ_dir="";//目录名
  String SJ_url="";//URL
  String SJ_counseling_flag="0";//是否支持咨询
  String SJ_desc="";//描述
  String IsStatic="";
  String NeedAudit="",SJ_SHNames="",SJ_SHIds="",NeedShenHe="0";//需要审核
  String SJ_display_flag;
  String skind="";		//栏目分类
  String splitflag=",";
  String ur_id = "";
  String SJ_ispublic_flag = "";
  String sj_modelid = "";
  String ModuleacdDirIds = "";
  String sj_acdstatus = "";
  String sj_codeacd = "";
  String sj_copytoid = "";//同时发布到的ID
	sj_copytoid=CTools.dealUploadString(myUpload.getRequest().getParameter("ModulecopytoDirIds")).trim();
		if(!sj_copytoid.equals(""))sj_copytoid=","+sj_copytoid+",";
// out.print(sj_copytoid);if(true)return;

  strId=CTools.dealUploadString(myUpload.getRequest().getParameter("strId")).trim();
  SJ_name=CTools.dealUploadString(myUpload.getRequest().getParameter("SJ_name"));
  SJ_SHIds=CTools.dealNull(myUpload.getRequest().getParameter("userFileIds")).trim();
  SJ_SHNames=CTools.dealUploadString(myUpload.getRequest().getParameter("user"));
  SJ_parentid=CTools.dealUploadString(myUpload.getRequest().getParameter("sj_id"));
  SJ_dir=CTools.dealUploadString(myUpload.getRequest().getParameter("SJ_dir"));
  SJ_url=CTools.dealUploadString(myUpload.getRequest().getParameter("SJ_url"));
  SJ_ispublic_flag=CTools.dealUploadString(myUpload.getRequest().getParameter("SJ_ispublic_flag"));
  SJ_counseling_flag=CTools.dealNumber (myUpload.getRequest().getParameter("SJ_counseling_flag"));
  SJ_display_flag=CTools.dealNumber (myUpload.getRequest().getParameter("SJ_display_flag"));
  SJ_desc=CTools.unHtmlEncode(CTools.dealUploadString(myUpload.getRequest().getParameter("SJ_desc")));

  sj_modelid=CTools.unHtmlEncode(CTools.dealUploadString(myUpload.getRequest().getParameter("sj_modelid")));
  ModuleacdDirIds = CTools.dealUploadString(myUpload.getRequest().getParameter("ModuleacdDirIds"));
  out.println(ModuleacdDirIds);
  ur_id = CTools.dealNumber (myUpload.getRequest().getParameter("urId"));
  sj_codeacd = CTools.dealUploadString(myUpload.getRequest().getParameter("sj_codeacd"));
  OPType=myUpload.getRequest().getParameter("OPType");
  IsStatic=CTools.dealString(myUpload.getRequest().getParameter("IsStatic"));
  sj_acdstatus = CTools.dealString(myUpload.getRequest().getParameter("sj_acdstatus"));
  NeedAudit=CTools.dealNumber(myUpload.getRequest().getParameter("SJ_need_audit"));
  String sj_acdid = CTools.dealString(myUpload.getRequest().getParameter("sj_acdid"));
  String[] sj_kind=myUpload.getRequest().getParameterValues("sj_kind");
  String  ModuleacdDirIds11 = CTools.dealUploadString(myUpload.getRequest().getParameter("ModuleextidDirIds"));

  SJ_SHIds=CTools.trimEx(CTools.replace(SJ_SHIds,",,",","),",");
  if(SJ_SHIds.equals(""))
    SJ_SHNames="";
  else
    SJ_SHIds=","+SJ_SHIds+",";


  if(sj_kind!=null)
  {
    for(int i=0;i<sj_kind.length;i++)
    {
      if (i==sj_kind.length-1) splitflag="";
      skind=skind+sj_kind[i]+splitflag;
    }
  }

 //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 



  CMySelf self = (CMySelf)session.getAttribute("mySelf");
  String user_name =CTools.dealNull(String.valueOf(self.getMyName()));
  String user_id = String.valueOf(self.getMyID());
  CRoleAccess ado=new CRoleAccess(dCn);

  String sjFirId = strId;
  String sjSunId = "";

  Hashtable contAcdid = dImpl.getDataInfo("select sj_id from tb_subject where ( sj_acdid<>'" + strId + "' and sj_acdid is not null ) and (sj_id = '" + ModuleacdDirIds11 + "')");

  if(contAcdid!=null) {
    out.println("<script language='javascript'>");
    out.println("alert('对应栏目下已有对应栏目！');");
    dImpl.closeStmt();
    dCn.closeCn();
    out.println("window.history.back(-1);");
    out.println("</script>");
  }
  try
  {


    //增加专题附件
    String filePath = CTools.dealUploadString(myUpload.getRequest().getParameter("filePath")).trim();
    String filePath1 = filePath;
    CDate oDate = new CDate();
    String sToday = oDate.getThisday();
    int count = myUpload.getFiles().getCount(); //上传文件个数
    if (count > 0) {
      String [] filename = null;
      String [] fileRealName = null;
      String path = request.getRealPath("/") + "/attach/ztbdattach/";

      int numeral = 0;
      numeral =(int)(Math.random()*100000);
      filePath = sToday + Integer.toString(numeral);
      java.io.File newDir = new java.io.File(path + filePath);
      if(!newDir.exists()) {
        newDir.mkdirs();
      }

      count = myUpload.save(path + filePath,2);//保存文件

      if (count == 0) {
        java.io.File delDir = new java.io.File(path + filePath);
        if(delDir.exists()) {
          filePath = filePath1;
          delDir.delete();
        }
      }

      if(count >= 1) {
        java.io.File delfilePath = new java.io.File(path + filePath1);
        if(delfilePath.exists()) {
          delfilePath.delete();
        }
        filename = new String[count];
        fileRealName = new String[count];

        for(int i = 0;i < count;i++) {
          filename[i] = myUpload.getFiles().getFile(i).getFileName();

          int filenum = 0;
          filenum =(int)(Math.random()*100000);

          String realName = sToday + Integer.toString(filenum) + filename[i].substring(filename[i].indexOf("."));
          fileRealName[i] = realName;

          java.io.File file = new java.io.File(path + filePath + "\\" + filename[i]);
          java.io.File file1 = new java.io.File(path + filePath + "\\" + realName);
          file.renameTo(file1);
        }
      }

    }
    //end 附件


    dImpl.setTableName("tb_subject");
    dImpl.setPrimaryFieldName("sj_id");
    if (OPType.equals("Add"))
    {
      sjFirId = String.valueOf(dImpl.addNew());
      strId=sjFirId;
      dImpl.setValue("SJ_ispublic",(ado.isAdmin(user_id)?SJ_ispublic_flag:"0"),CDataImpl.INT);
    	dImpl.setValue("sj_sequence","-10",CDataImpl.STRING);
    }
    else if (OPType.equals("Edit")) {
      dImpl.edit("tb_subject","sj_id",Integer.parseInt(strId));
      dImpl.setValue("SJ_ispublic",SJ_ispublic_flag,CDataImpl.INT);
    }

	dImpl.setValue("sj_copytoid",sj_copytoid,CDataImpl.STRING);
    dImpl.setValue("sj_name",SJ_name,CDataImpl.STRING);
    dImpl.setValue("sj_parentid",SJ_parentid,CDataImpl.INT);
    dImpl.setValue("sj_dir",SJ_dir,CDataImpl.STRING);
    dImpl.setValue("sj_url",SJ_url,CDataImpl.STRING);
    dImpl.setValue("sj_counseling_flag",SJ_counseling_flag,CDataImpl.STRING);
    dImpl.setValue("sj_display_flag",SJ_display_flag,CDataImpl.STRING);
    dImpl.setValue("sj_desc",SJ_desc,CDataImpl.SLONG);
    dImpl.setValue("sj_kind",skind,CDataImpl.STRING);
    dImpl.setValue("sj_need_audit",NeedAudit,CDataImpl.INT);
    dImpl.setValue("sj_shids",SJ_SHIds,CDataImpl.STRING);
    dImpl.setValue("sj_shnames",SJ_SHNames,CDataImpl.STRING);
    dImpl.setValue("sj_im_path",filePath,CDataImpl.STRING);

    if(!ur_id.equals("0")) dImpl.setValue("ur_id",ur_id,CDataImpl.INT	);
    dImpl.update() ;

    dImpl.executeUpdate("update tb_subject set sj_acdid='' where sj_id='" + sj_acdid + "' or sj_id='" + strId + "'");
    //下面是栏目同时发布中同步所有同时栏目的sj_copytoid代码
    out.println("同时发布ＩＤ"+sj_copytoid);
    if(!sj_copytoid.equals("")){
    sj_copytoid+=strId+",";
    sj_copytoid = sj_copytoid.substring(1,sj_copytoid.length()-1); //去掉前后的逗号
    
    String sj_copytoid_split [] = sj_copytoid.split(",");
    String sj_copytoid_now="";
    String sj_copytoid_info="";//最后放入的同时发布ID组合
    for(int s=0; s<sj_copytoid_split.length;s++){
        sj_copytoid_info="";//初始化组合ＩＤ
        sj_copytoid_now = sj_copytoid_split[s];
        //下面FOR是组合同时发布ID
        for(int h=0;h<sj_copytoid_split.length;h++){
        //如果是当前ＩＤ就不组合此ＩＤ
        if(!sj_copytoid_now.equals(sj_copytoid_split[h]))sj_copytoid_info+=sj_copytoid_split[h]+",";    
        //out.print("第"+h+"个"+sj_copytoid_split[h]);   
        }
        
         //在组合ＩＤ前加个逗号
         sj_copytoid_info=","+sj_copytoid_info;
         //out.println(sj_copytoid_now+"组合ＩＤ"+sj_copytoid_info);
        //下面是把组合的ID存入同时发布栏目中的sj_copytoid字段
        if(!sj_copytoid_now.equals(strId)){
        dImpl.edit("tb_subject","sj_id",Integer.parseInt(sj_copytoid_now));
        dImpl.setValue("sj_copytoid",sj_copytoid_info,CDataImpl.STRING);
        dImpl.update() ;
        }
    }
    
    
    }
    
 
    
    if (OPType.equals("Add"))
    {
      //对于非超级管理员登陆后增加栏目，应该将该栏目的权限赋予该普通管理员的用户角色
      //System.out.println("1");
      if(!ado.isAdmin(user_id))
      {
        //System.out.println("2");
        String filterSql="";

        String sql="select tr_id from tb_roleinfo where tr_type=1 and tr_userids='," +user_id+",'";
        Hashtable content2=dImpl.getDataInfo(sql);
        String tr_id="-1";
        if(content2!=null)
          tr_id=CTools.dealNull(content2.get("tr_id"));
        else
        {
          CRoleInfo jdo = new CRoleInfo(dCn);
          tr_id = new String().valueOf(jdo.addNew());
          jdo.setValue("tr_type","1",jdo.INT );
          jdo.setValue("tr_name",user_name,jdo.STRING);
          jdo.setValue("tr_detail","Private",jdo.STRING);
          jdo.setValue("tr_level","1",jdo.INT );
          jdo.setValue("tr_createby","admin",jdo.STRING);
          jdo.setValue("tr_userids",","+user_id+",",jdo.STRING);
          jdo.update() ;
          jdo.closeStmt();
        }

        dImpl.executeUpdate("insert into TB_ACCESS(TB_ID,RL_ID,TB_TYPE,ACCESS_ID) values("+dImpl.getMaxId("TB_ACCESS")+","+tr_id+",5,"+strId+")");
      }
    }

    if(sj_acdstatus.equals("1")) {
      String sqlStrSun = "select sj_id,sj_name from tb_subject where sj_name='" + SJ_name +  "' and sj_parentid='" + ModuleacdDirIds + "'";
      Hashtable sqlStrSunContent = dImpl.getDataInfo(sqlStrSun);
      if(sqlStrSunContent != null) {
        sjSunId = sqlStrSunContent.get("sj_id").toString();
        dImpl.edit("tb_subject","sj_id",Integer.parseInt(sjFirId));
        dImpl.setValue("sj_acdid",sjSunId,CDataImpl.INT);
        dImpl.update() ;

        dImpl.edit("tb_subject","sj_id",Integer.parseInt(sjSunId));
        dImpl.setValue("sj_acdid",sjFirId,CDataImpl.INT);
        dImpl.update() ;

      } else {
        sjSunId = String.valueOf(dImpl.addNew());
        dImpl.setValue("sj_name",SJ_name,CDataImpl.STRING);
        dImpl.setValue("sj_parentid",ModuleacdDirIds,CDataImpl.INT);
        dImpl.setValue("sj_dir",sj_codeacd,CDataImpl.STRING);
        dImpl.setValue("sj_url",SJ_url,CDataImpl.STRING);
        dImpl.setValue("sj_counseling_flag",SJ_counseling_flag,CDataImpl.STRING);
        dImpl.setValue("sj_display_flag",SJ_display_flag,CDataImpl.STRING);
        dImpl.setValue("sj_desc",SJ_desc,CDataImpl.SLONG);
        dImpl.setValue("sj_kind",skind,CDataImpl.STRING);
        dImpl.setValue("sj_need_audit",NeedAudit,CDataImpl.INT);
        dImpl.setValue("sj_acdid",sjFirId,CDataImpl.INT);

        if(!ur_id.equals("0")) dImpl.setValue("ur_id",ur_id,CDataImpl.INT	);
        dImpl.update() ;

        dImpl.edit("tb_subject","sj_id",Integer.parseInt(sjFirId));
        dImpl.setValue("sj_acdid",sjSunId,CDataImpl.INT);
        dImpl.update() ;


      //对于非超级管理员登陆后增加栏目，应该将该栏目的权限赋予该普通管理员的用户角色
        //System.out.println("1");
        if(!ado.isAdmin(user_id))
        {
          //System.out.println("2");
          String filterSql="";

          String sql="select tr_id from tb_roleinfo where tr_type=1 and tr_userids='," +user_id+",'";
          Hashtable content2=dImpl.getDataInfo(sql);
          String tr_id="-1";
          if(content2!=null)
            tr_id=CTools.dealNull(content2.get("tr_id"));
          else
          {
            CRoleInfo jdo = new CRoleInfo(dCn);
            tr_id = new String().valueOf(jdo.addNew());
            jdo.setValue("tr_type","1",jdo.INT );
            jdo.setValue("tr_name",user_name,jdo.STRING);
            jdo.setValue("tr_detail","Private",jdo.STRING);
            jdo.setValue("tr_level","1",jdo.INT );
            jdo.setValue("tr_createby","admin",jdo.STRING);
            jdo.setValue("tr_userids",","+user_id+",",jdo.STRING);
            jdo.update() ;
            jdo.closeStmt();
          }

          dImpl.executeUpdate("insert into TB_ACCESS(TB_ID,RL_ID,TB_TYPE,ACCESS_ID) values("+dImpl.getMaxId("TB_ACCESS")+","+tr_id+",5,"+sjSunId+")");
        }
      }

    }



    if(sj_acdstatus.equals("2")) {
      ModuleacdDirIds = CTools.dealUploadString(myUpload.getRequest().getParameter("ModuleextidDirIds"));
      dImpl.edit("tb_subject","sj_id",Integer.parseInt(sjFirId));
      dImpl.setValue("sj_acdid",ModuleacdDirIds,CDataImpl.INT);
      dImpl.update() ;

      dImpl.edit("tb_subject","sj_id",Integer.parseInt(ModuleacdDirIds));
      dImpl.setValue("sj_acdid",sjFirId,CDataImpl.INT);
      dImpl.update() ;
    }


    session.setAttribute("_InfoSubject","");



    dImpl.closeStmt();
    dCn.closeCn();  
    if (IsStatic.equals("true"))
    {
      out.print("<SCRIPT LANGUAGE=\"JavaScript\">");
      out.print("alert('修改成功！');");
      out.print("history.go(-1);");
      out.print("</SCRIPT>");
    }
    else
    {
      String urlRedirect="subjectList.jsp?sj_id="+ SJ_parentid;
      response.sendRedirect(urlRedirect);
    }
  }
  catch(Exception e)
  {
    out.println("error message:" + e.toString()) ;
  }
  } catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>