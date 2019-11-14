package com.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;

import jcifs.smb.SmbFile;
import jcifs.smb.SmbFileInputStream;

public class ReadSmb {
	public static void main(String[] args) {
//		String smbMachine = "smb://administrator:4566@31.6.130.127/yanker/2009-01-13/B200900056.xml";
//		String localPath = "D:/temp";
//		File file = readFromSmb(smbMachine, localPath);
		getContentLocal("2006-07-10/o527.xml");
		//removeFile(file);
	}
	
	/**
	 * Description:返回文件的xml内容
	 * @param realpath xml文件在远程存放的具体路径
	 * @return xml内容
	 */
	public static String getContent(String realpath){
		ReadProperty pro = new ReadProperty();
		String webpassword = pro.getPropertyValue("webpassword");
		String webusername = pro.getPropertyValue("webusername");
		String webpath = pro.getPropertyValue("webpath");
		String savePath = pro.getPropertyValue("savepath");
		StringBuffer contentStr = new StringBuffer();
		
		File file= readFromSmb("smb://"+webusername+":"+webpassword+"@"+webpath+"/"+realpath,savePath);
		BufferedReader in = CFile.read(file);
		String tempStr = "";
		try{
			while((tempStr = in.readLine())!=null){
		 		contentStr.append(tempStr);
			}
		}catch(IOException e){
			System.out.println(CDate.getNowTime() + "-->" + "ReadSmb:getContent: " + e.getMessage());
		}
		//System.out.println(contentStr.toString());
		return contentStr.toString();
	}
	
	public static String getContentLocal(String realPath){
		StringBuffer contentStr = new StringBuffer();
		ReadProperty pro = new ReadProperty();
		String localPath = pro.getPropertyValue("localpath");
		//System.out.println("-------获取外事办办事xml内容的文件路径---" + localPath + "/" + realPath);
		File file= new File(localPath + "/" + realPath);
		BufferedReader in = CFile.read(file);
		String tempStr = "";
		try{
			while((tempStr = in.readLine())!=null){
		 		contentStr.append(tempStr);
			}
		}catch(IOException e){
			System.out.println(CDate.getNowTime() + "-->" + "ReadSmb:getContentLocal: " + e.getMessage());
		}
		//System.out.println(contentStr.toString());
		return contentStr.toString();
	}

	/***************************************************************************
	 * 从smbMachine读取文件并存储到localpath指定的路径
	 * 
	 * @param smbMachine
	 *            共享机器的文件,如smb://xxx:xxx@10.108.23.112/myDocument/测试文本.txt,xxx:xxx是共享机器的用户名密码
	 * @param localpath
	 *            本地路径
	 * @return
	 */
	public static File readFromSmb(String smbMachine, String localpath) {
		File localfile = null;
		InputStream bis = null;
		OutputStream bos = null;
		try {
			SmbFile rmifile = new SmbFile(smbMachine);
			String filename = rmifile.getName();
			bis = new BufferedInputStream(new SmbFileInputStream(rmifile));
			localfile = new File(localpath + File.separator + filename);
			bos = new BufferedOutputStream(new FileOutputStream(localfile));
			int length = rmifile.getContentLength();
			byte[] buffer = new byte[length];
			Date date = new Date();
			bis.read(buffer);
			bos.write(buffer);
			Date end = new Date();
			int time = (int) ((end.getTime() - date.getTime()) / 1000);
			if (time > 0)
				System.out.println("用时:" + time + "秒 " + "速度:" + length / time
						/ 1024 + "kb/秒");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println(e.getMessage());

		} finally {
			try {
				bos.close();
				bis.close();
			} catch (IOException e) {
				// // TODO Auto-generated catch block
				System.out.println(e.getMessage());
			}
		}
		return localfile;
	}

	public static boolean removeFile(File file) {
		return file.delete();
	}
}
