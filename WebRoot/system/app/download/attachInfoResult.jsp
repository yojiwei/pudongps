<%@page contentType="text/html; charset=GBK"%>
<%@include file="../skin/import.jsp"%>
<%
//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
  String path = dImpl.getInitParameter("attach_save_path"); //获取路径
  dImpl.closeStmt();
  dCn.closeCn();

  long size=0;

  try
  {
    String sDocument = "";
    String sSavePath = "";

    com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.SmartUpload();
    //SmartUpload myUpload = new SmartUpload();

    int count=0;//上传文件个数
    myUpload.initialize(pageContext);
    //myUpload.setTotalMaxFileSize(10485760);//设置上传文件大小限制
    myUpload.setDeniedFilesList("exe,bat,jsp");//设置上传文件后缀限制
    myUpload.upload();

    sDocument = request.getParameter("DL_directory_name");

    if (sDocument == null || sDocument.equals("") )
    {
      CDate oDate = new CDate();
      String sToday = oDate.getThisday();

      int numeral = 0;
      boolean bEndFlag = false;

      while (!bEndFlag)
      {
        numeral =(int)(Math.random()*100000);
        sDocument = sToday + Integer.toString(numeral);
        sSavePath = path + sDocument;
        java.io.File newDir=new java.io.File(sSavePath);
        if(!newDir.exists())
        {
          newDir.mkdirs();
          bEndFlag = true;
        }
      }
    }
    else
    {
      sSavePath = path + sDocument;
    }

    count = myUpload.save(sSavePath,2);

    response.sendRedirect("/system/app/download/attachInfo.jsp?DL_directory_name="+sDocument);

  }
  catch (Exception e)
  {
    System.err.println(e.getMessage());

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
