package com.ftpUpload;

import java.io.FileInputStream;  
import java.io.IOException;  
import java.text.SimpleDateFormat;
import java.util.StringTokenizer;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.ReadProperty;
  
import sun.net.TelnetOutputStream;  
import sun.net.ftp.FtpClient;

/** 
 * 用sun.net.ftp.FtpClient实现简单的Java FTP 上传文件代码例子 
 * 
 * <p>Title: is a Class</p> 
 * 
 * <p>Description: 类</p> 
 * 
 * <p>Copyright: Copyright (c) 2006</p> 
 * 
 * <p>Company: sunrise</p> 
 * 
 * @author islph 
 * @version 1.0 
 */  
public class FTPList {
	
private CDataCn dCn;
private CDataImpl dImpl;
private SimpleDateFormat df = null;
/**
 * 构造函数
 */
public FTPList(){
	dCn = null;
    dImpl = null;
    df = new SimpleDateFormat("yyyy-MM-dd");
}
/**
 * 在FTP服务器上建立指定的目录,当目录已经存在的情下不会影响目录下的文件,这样用以判断FTP
 * 上传文件时保证目录的存在目录格式必须以"/"根目录开头
 * @param pathList String
 * @throws Exception
 */
 public static void buildList(FtpClient ftpClient,String pathList) throws Exception {
    ftpClient.ascii();
    StringTokenizer s = new StringTokenizer(pathList, "/"); //sign
    int count = s.countTokens();
    String pathName = "";
    while (s.hasMoreElements()) {
        pathName = pathName + "/" + (String) s.nextElement();
        try {
            ftpClient.sendServer("XMKD " + pathName + "\r\n");
        } catch (Exception e) {
            e = null;
        }
        int reply = ftpClient.readServerResponse();
    }
    ftpClient.binary();
}
 /**
  * 第一次上传被调用的方法
  * @param filepath
  */
 public static void uploadFile(String localpath,String remotepath,String tablename,String tid,String ft_count){
	boolean isupok = false;
	String ft_id = "";
	FTPList ftpl = new FTPList();
	isupok = FTPList.uploadWill(localpath, remotepath);
	ftpl.writeLogs(isupok,remotepath,tablename,tid,ft_count,ft_id);
 }
 /**
  * 再次上传被调用的方法
  * @param localpath
  * @param remotepath
  * @param tablename
  * @param tid
  * @param ft_count
  */
 public static void uploadFileToo(String localpath,String remotepath,String tablename,String tid,String ft_count,String ft_id){
		boolean isupok = false;
		FTPList ftpl = new FTPList();
		if(Integer.parseInt(ft_count)<3){
			isupok = FTPList.uploadWill(localpath, remotepath);
			ftpl.writeLogs(isupok,remotepath,tablename,tid,ft_count,ft_id);
		}else{
			System.out.println("上传次数超过三次");
		}
	 }
 /**
  * 上传FTP的方法
  * @param localpath
  * @param remotepath
  * @return
  */
 private static boolean uploadWill(String localpath,String remotepath){
	 // TODO 自动生成方法存根  
	 ReadProperty pro = new ReadProperty();
	  String server = pro.getPropertyValue("ftp_server");
	  String user = pro.getPropertyValue("ftp_user");
	  String password = pro.getPropertyValue("ftp_password");
	  
	  String remoteFilePath = remotepath;  
	  String localFilePath = localpath;//本地
	  String localfilename = "";
	  FtpClient ftpClient; 
	  boolean isupload = false;
	  remoteFilePath = remotepath.substring(0,remotepath.lastIndexOf("/"));
	  try {  
	   // server：FTP服务器的IP地址；user:登录FTP服务器的用户名  
	   // password：登录FTP服务器的用户名的口令；path：FTP服务器上的路径  
	   ftpClient = new FtpClient();  
	   ftpClient.openServer(server);  
	   ftpClient.login(user, password);
	   // path是ftp服务下主目录的子目录  
	   if (remoteFilePath.length() != 0){
		   try{
			   ftpClient.cd(remoteFilePath);
		   }catch(java.io.FileNotFoundException fx ){
			   buildList(ftpClient,remoteFilePath);
			   ftpClient.cd(remoteFilePath);
		   }
	   }
	   // 用2进制上传  
	   ftpClient.binary();
	   TelnetOutputStream os = null;  
	   FileInputStream is = null;  
	   try {  
	    // "descfile.txt"用ftp上传后的新文件名  
		localfilename = remotepath.substring(remotepath.lastIndexOf("/")+1);
	    os = ftpClient.put(localfilename);  
	    java.io.File file_in = new java.io.File(localFilePath);  
	    if (file_in.length() == 0) {  
	     throw new Exception("上传文件为空!");  
	    }  
	    is = new FileInputStream(file_in);  
	    byte[] bytes = new byte[1024];  
	    int c;  
	    while ((c = is.read(bytes)) != -1) {  
	     os.write(bytes, 0, c);  
	    }  
	   } finally {  
	    if (is != null) {  
	     is.close();  
	    }  
	    if (os != null) {  
	     os.close();  
	    }  
	   }
	   isupload = true;
	   System.out.println("上传ftp文件成功!");
	  } catch (Exception e) {
		  isupload = false;
		  e.printStackTrace();  
	  }
	  return isupload;
 }
 /**
  * 写日志
  * @param isok
  */
 public void writeLogs(boolean isok,String ftppath,String tablename,String tid,String ft_count,String ft_id){
	 try{
		 String filename = ftppath.substring(ftppath.lastIndexOf("/")+1);
		 String issuccess = "";
		 String isupload = "";
		 if(isok){
			 isupload="0";//上传成功
			 issuccess = "成功";
		 }else{
			 isupload="1";//上传失败
			 issuccess = "失败";
		 }
		 dCn = new CDataCn();
         dImpl = new CDataImpl(dCn);
         if("".equals(ft_id)){
        	 dImpl.addNew("tb_ftplog", "ft_id");
         }else{
        	 dImpl.edit("tb_ftplog","ft_id",ft_id);
         }
 		 dImpl.setValue("ft_path",ftppath,CDataImpl.STRING);
 		 dImpl.setValue("ft_filename",filename,CDataImpl.STRING);
 		 dImpl.setValue("ft_parentable",tablename,CDataImpl.STRING);//上传的关联的表
 		 dImpl.setValue("ft_parentid",tid,CDataImpl.STRING);//上传的关联的ID
 		 dImpl.setValue("ft_date",df.format(new java.util.Date()),CDataImpl.DATE);
    	 dImpl.setValue("ft_issuccess",issuccess,CDataImpl.STRING);//是否上传成功的说明（成功、失败）
    	 dImpl.setValue("ft_isupload",isupload,CDataImpl.STRING);//是否上传成功的标志0上传成功1上传失败
    	 dImpl.setValue("ft_count",ft_count,CDataImpl.STRING);//上传的次数
    	 dImpl.update();
	 }catch(Exception ex){
		 ex.printStackTrace();
	 }
	 dImpl.closeStmt();
     dCn.closeCn();
 }
 /** 
  * @param args 
  */  
 public static void main(String[] args) {  
    FTPList ftplist = new FTPList();
    //ftplist.uploadFile("e:/Struts中文详解.CHM", "/hello/wode.CHM","tb_proceeding_new","pr_id","0");
    String ft_count = "0";
    System.out.println("-----"+String.valueOf(Integer.parseInt(ft_count)+1));
 }
} 