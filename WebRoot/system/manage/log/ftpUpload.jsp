<%@page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/import.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<%
//update by yo20090615
  CDataCn dCn = null;
  CDataImpl dImpl = null;
  Hashtable content = null;
  String ft_id = "";
  String ftpSql = "";
  String fileid = "";
  String filename = "";
  String filepath = "";
  String filedate = "";
  String filetable = "";
  String fileparentid = "";
  String filecount = "";
  String localfilepath = "";
	try{
   dCn = new CDataCn();
	 dImpl = new CDataImpl(dCn);
	 ft_id = CTools.dealString(request.getParameter("ft_id")).trim();//ft_id
	 ftpSql = "select ft_id,ft_path,ft_filename,ft_date,ft_issuccess,ft_parentable,ft_parentid,ft_count from tb_ftplog where ft_isupload =1 and ft_id = "+ft_id+"";
	 content = (Hashtable)dImpl.getDataInfo(ftpSql);
	 if(content!=null){
		 fileid = CTools.dealNull(content.get("ft_id"));
	   filename = CTools.dealNull(content.get("ft_filename"));
	   filepath = CTools.dealNull(content.get("ft_path"));
	   filedate = CTools.dealNull(content.get("ft_date"));
	   filetable = CTools.dealNull(content.get("ft_parentable"));
	   fileparentid= CTools.dealNull(content.get("ft_parentid"));
	   filecount = CTools.dealNull(content.get("ft_count"));
	   filecount = String.valueOf(Integer.parseInt(filecount)+1);
   }
   
		//上传该文件到ftp modify by yo
    com.ftpUpload.FTPList ftplist = new com.ftpUpload.FTPList();
    String path = dImpl.getInitParameter("workattach_save_path");
    path = path.replaceAll("\\\\","/");
		path = path.replaceAll("//","/");
    localfilepath = filepath.replaceAll("/attach/workattach2007",path);
    ftplist.uploadFileToo(localfilepath,filepath,filetable,fileparentid,filecount,ft_id);//本地路径、远程路径、关联的表、关联的字段ID、第几次上传
	  //modify by yo
		  
  }catch(Exception ex){
    System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
  }finally{
	 dImpl.closeStmt();
	 dCn.closeCn();
	 
	 out.write("<script language='javascript'>");
	 out.write("window.location.href='ftplogList.jsp'");
	 out.write("</script>");	 
	
  }
%>
