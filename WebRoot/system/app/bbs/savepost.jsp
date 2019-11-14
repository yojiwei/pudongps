<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%@page import="com.util.*" %>

<%!String sql,Note_Singid,Note_Title,Note_Content,Note_Icon,Note_Signid,Board_Id,Return_Id,sort_id;%>
<%
  com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.SmartUpload();
  myUpload.initialize(pageContext);
  myUpload.setDeniedFilesList("exe,bat,jsp");
  myUpload.upload();
  
  

//update20080122
CDataCn dCn = null;
try{
	dCn = new CDataCn();
  CDataImpl dImpl = new CDataImpl(dCn);
  
  Note_Title = CTools.dealUploadString(myUpload.getRequest().getParameter("title"));
  //Note_Title=yy.ex_chinese(Note_Title);
  Note_Content = CTools.dealUploadString(myUpload.getRequest().getParameter("content"));
  String type_post = CTools.dealUploadString(myUpload.getRequest().getParameter("type_post"));
  String post_id = CTools.dealUploadString(myUpload.getRequest().getParameter("post_id"));
  
 //Note_Content=yy.ex_chinese(Note_Content);
  Note_Icon = CTools.dealUploadString(myUpload.getRequest().getParameter("icon"));
  Note_Singid = CTools.dealUploadString(myUpload.getRequest().getParameter("signid"));
  Board_Id = CTools.dealUploadString(myUpload.getRequest().getParameter("fid"));
  sort_id = CTools.dealUploadString(myUpload.getRequest().getParameter("sort_id"));
  Return_Id = CTools.dealUploadString(myUpload.getRequest().getParameter("returnid"));
  String guestName = CTools.dealUploadString(myUpload.getRequest().getParameter("Guest_Sign"));
  
    CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
    java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-M-d HH:mm:ss");
    java.util.Date date = new java.util.Date();
    String datestr = df.format(date);

  String userName = "BBS_Guest" ;
  if(mySelf != null){
    userName = mySelf.getMyUid()+"";
  }


  
  //guestName=yy.ex_chinese(guestName);
  if(guestName==null){
    guestName="";
  }
  //if(!guestName.equals(""))
  //{
     //userName = guestName;
  //}
//out.println(userName);
//out.close();
  //userName = userName + guestName;
  if (Return_Id.toString().equals("null"))
      Return_Id="0";
  if (Note_Title.equals("")||Note_Content.equals(""))
  {
    response.sendRedirect("err.jsp?id=1");
  }else
  {

    Connection con = dCn.getConnection();
    Statement  stmt = con.createStatement();
  
   if (Return_Id!="0")
   {
      sql="update forum_post set post_reply_count=post_reply_count+1,post_replier='" + userName + "',post_reply_date=to_date('"+datestr+"','YYYY-MM-DD HH24:MI:SS') where post_id="+Return_Id;
      stmt.executeUpdate(sql);
      sql="update forum_board set fm_post_count=fm_post_count+1,fm_last_poster='"+userName+"',fm_last_post_date=to_date('"+datestr+"','YYYY-MM-DD HH24:MI:SS') where fm_id="+Board_Id;
      stmt.executeUpdate(sql);
       
      
   }else
   {
     sql="update forum_board set fm_post_count=fm_post_count+1,fm_last_poster='"+userName+"',fm_main_post_count=fm_main_post_count+1 where fm_id="+Board_Id;
     stmt.executeUpdate(sql);        
   }
    String parimaryId = "";
    if ("".equals(type_post)) {
        dImpl.setTableName("forum_post");
        dImpl.setPrimaryFieldName("post_id");
        parimaryId = Long.toString(dImpl.addNew());
            dImpl.setValue("post_author",userName,CDataImpl.STRING);
            dImpl.setValue("post_reply_date",datestr,CDataImpl.DATE);
            dImpl.setValue("post_reply_count","0",CDataImpl.STRING);
            dImpl.setValue("post_click_count","0",CDataImpl.STRING);
    }
    else {
      dImpl.edit("forum_post","post_id",post_id);
    }
    dImpl.setValue("post_board_id",Board_Id,CDataImpl.STRING);
    
    dImpl.setValue("post_reply_id",Return_Id,CDataImpl.STRING);
    dImpl.setValue("post_title",Note_Title,CDataImpl.STRING);
    dImpl.setValue("post_content",Note_Content,CDataImpl.SLONG);
    dImpl.setValue("post_date",datestr,CDataImpl.DATE);

    dImpl.setValue("post_length",String.valueOf(Note_Content.length()),CDataImpl.STRING);
    dImpl.setValue("post_show_sign",Note_Singid,CDataImpl.STRING);
    dImpl.setValue("post_image",Note_Icon,CDataImpl.STRING);
    dImpl.setValue("post_ip",request.getRemoteAddr(),CDataImpl.STRING); 
    dImpl.setValue("post_replier",userName,CDataImpl.STRING);
    dImpl.setValue("post_guest_sign",guestName,CDataImpl.STRING);
    if(!"".equals(sort_id)){
    dImpl.setValue("post_board_id",sort_id,CDataImpl.STRING);//如果有重选栏目则翻盖栏目ＩＤ
    }
    dImpl.update();
    
    if(!"".equals(sort_id)){
    //如果有重选栏目则翻盖栏目ＩＤ
    String new_sql="select post_id,post_board_id from forum_post where post_reply_id='"+post_id+"'";
    Hashtable new_content = null;
    CDataCn new_dCn = null;
    CDataImpl new_dImpl = null;
    try{
    new_dCn = new CDataCn();
    new_dImpl = new CDataImpl(new_dCn);
    //System.out.print(new_sql);
    Vector vPage = dImpl.splitPage(new_sql,10000,1);
    String new_post_board_id="";
    String new_post_id="";
    if (vPage!=null){
   
        for(int i=0;i<vPage.size();i++){      
            new_content = (Hashtable)vPage.get(i);           
            new_post_id=new_content.get("post_id").toString();                 
            new_dImpl.edit("forum_post","post_id",new_post_id);
            new_dImpl.setValue("post_board_id",sort_id,CDataImpl.STRING);
            new_dImpl.update();
 
        }
     }
    }catch(Exception e){
    out.print("重选所属分类出错"+e.toString());
    }
    finally{
    new_dImpl.closeStmt();
    new_dCn.closeCn(); 
    }        
    }
    
    int count = myUpload.getFiles().getCount(); //上传文件个数
    
    
    if (count >= 1) {
    
      String [] filename = null;
      String [] fileRealName = null;
      String contextPath = dImpl.getInitParameter("bbs_attach");//"attach\\bbs\\";
      String path = request.getRealPath("/") + contextPath;
      String filePath = "";
    
      CDate oDate = new CDate();
      String sToday = oDate.getThisday();
      //附件的存放目录不存在
      if (filePath.equals("")) {
        int numeral = 0;
        numeral =(int)(Math.random()*100000);
        filePath = sToday + Integer.toString(numeral);
        java.io.File newDir = new java.io.File(path + filePath);
        if(!newDir.exists()) {
          newDir.mkdirs();
        }
      }
      count = myUpload.save(path + filePath,2);//保存文件
    
      if(count>=1) {
        filename = new String[count];
        fileRealName = new String[count];
      }
    
      for(int i=0;i<count;i++) {
        filename[i] = myUpload.getFiles().getFile(i).getFileName();
    
        int filenum = 0;
        filenum =(int)(Math.random()*100000);
    
        String realName = sToday + Integer.toString(filenum) + filename[i].substring(filename[i].indexOf("."));
        fileRealName[i] = realName;
    
        java.io.File file = new java.io.File(path + filePath + "\\" +filename[i]);
        java.io.File file1 = new java.io.File(path + filePath + "\\" +realName);
        file.renameTo(file1);
    
      }
    
      for (int j = 0;j < count;j++) {   
            
        dImpl.setTableName("tb_bimage");
        dImpl.setPrimaryFieldName("bi_id");
        dImpl.addNew();         
        dImpl.setValue("bi_tablename","forum_post",CDataImpl.STRING);
		if(!"".equals(parimaryId))
		  {
        dImpl.setValue("bi_table_id",parimaryId,CDataImpl.STRING);
		  }
        dImpl.setValue("bi_path",filePath,CDataImpl.STRING);
        dImpl.setValue("bi_filename",filename[j],CDataImpl.STRING);
        dImpl.setValue("bi_radomname",fileRealName[j],CDataImpl.STRING);
		if(!"".equals(post_id)){
        dImpl.setValue("bi_table_id",post_id,CDataImpl.STRING);
		}
        dImpl.update();
      }
      
    }
     if (Return_Id!="0")
   {      
       //更新话题回复数
    sql="update forum_post set post_reply_count=(select count(*)as count from forum_post where post_board_id='"+Board_Id+"' and post_reply_id='"+Return_Id+"') where post_id='"+Return_Id+"'";
    stmt.executeUpdate(sql);
  }
   if (Return_Id=="0")
   {
    response.sendRedirect("board.jsp?fid="+Board_Id);
%>
<html>

<body>
<p>&nbsp;</p>
<meta http-equiv='refresh' content='2;url=board.jsp?fid=<%=Board_Id%>'>
<table width="75%" border="1" align="center" cellpadding="5" cellspacing="0">
  <tr>
    <td bgcolor="e9e9e9">系统提示：</td>
  </tr>
  <tr>
    <td><font size=2 color=blue>您的贴子发表成功，正在处理您的提交信息，稍后自动返回。</font></td>
  </tr>
</table>
<%
   }else
{
    response.sendRedirect("shownote.jsp?fid="+Board_Id+"&noteid="+Return_Id);
%>
<html>
<meta http-equiv='refresh' content='2;url=shownote.jsp?fid=<%=Board_Id%>&noteid=<%=Return_Id%>'>
<body>
<p>&nbsp;</p>
<table width="75%" border="1" align="center" cellpadding="5" cellspacing="0">
  <tr>
    <td bgcolor="e9e9e9">系统提示：</td>
  </tr>
  <tr>
    <td><font size=2 color=blue>您的贴子发表成功，正在处理您的提交信息，稍后自动返回。</font></td>
  </tr>
</table>
<%
}

  }
 dImpl.closeStmt();
 dCn.closeCn();
%>
</body>
</html>


<%


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dCn != null)
	dCn.closeCn();
}

%>