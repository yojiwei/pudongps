package com.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.util.Date;
import java.util.TimerTask;

import jcifs.smb.SmbException;
import jcifs.smb.SmbFile;
import jcifs.smb.SmbFileInputStream;
import jcifs.smb.SmbFileOutputStream;

/**
 * <p>
 * Program Name:浦东门户网站2008
 * </p>
 * <p>
 * Module Name:工具类
 * </p>
 * <p>
 * Function Name:远程文件操作的类
 * </p>
 * <p>
 * Creat Time:20120801
 * </p>
 * 
 * @author yao
 * 
 */
public class FolderFileChange extends TimerTask {

	// 附件存放的物理路径
	private String attachPath = "";

	// 读取资源文件的类
	private ReadProperty readpro = null;

	// 远程服务器用户名
	private String webusername = "";

	// 远程服务器密码
	private String webpassword = "";

	// 远程服务器ip地址
	private String webmachineip = "";

	// 远程服务器共享文件夹名
	private String websharePath = "";

	public void run() {
		// TODO Auto-generated method stub
		FolderFileChange FolderFileChangedel = new FolderFileChange();
		FolderFileChangedel.deleteNullFolder(attachPath);
		FolderFileChange FolderFileChange = new FolderFileChange();
		FolderFileChange.getChangeList("");
	}

	/**
	 * Description:默认构造函数，初始化参数
	 * 
	 */
	public FolderFileChange() {
		readpro = new ReadProperty();
		attachPath = readpro.getPropertyValue("attachPath");
		webpassword = readpro.getPropertyValue("webpassword");
		webusername = readpro.getPropertyValue("webusername");
		webmachineip = readpro.getPropertyValue("webmachineip");
		websharePath = readpro.getPropertyValue("websharePath");
	}

	/**
	 * Description:测试主方法
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		FolderFileChange FolderFileChangedel = new FolderFileChange();
		FolderFileChangedel.deleteNullFolder("d:/attach");
		FolderFileChange FolderFileChange = new FolderFileChange();
		FolderFileChange.getChangeList("");
	}

	/**
	 * Description：删除空文件夹
	 * 
	 * @param path
	 *            要删除的文件夹路径
	 */
	public void deleteNullFolder(String path) {
		File file = null;// 文件夹
		File[] childFile = null;// 子文件夹
		try {
			file = new File(path);
			childFile = file.listFiles();
			if (childFile.length > 0) {
				for (int cnt = 0; cnt < childFile.length; cnt++) {
					//删除空的文件夹
					if(!childFile[cnt].isFile()){
						if(childFile[cnt].listFiles().length==0){
							childFile[cnt].delete();
						}else{
							deleteNullFolder(childFile[cnt].getAbsolutePath());
						}
					}
						
				}
			}
		} catch (Exception ioe) {
			System.out.println(CDate.getNowTime() + "-->"
					+ this.getClass().getName() + ":deleteNullFolder:"
					+ ioe.getMessage());
		}
	}

	/**
	 * Description：得到要进行文件转移的列表
	 * 
	 * @param path
	 *            要操作的本地路径
	 */
	public void getChangeList(String path) {
		File file = null;// 文件夹
		File[] childFile = null;// 子文件夹
		String smbStr = "smb://" + webusername + ":" + webpassword + "@"
				+ webmachineip + "/" + websharePath + "/" + path;// 要操作的远程地址字符串
		
		try {
			if (!path.equals(attachPath))
				path = attachPath + "/" + path;
			file = new File(path);
			if (file.exists()) {
				childFile = file.listFiles();
				if (childFile.length > 0) {
					for (int cnt = 0; cnt < childFile.length; cnt++) {
						if (childFile[cnt].isFile()) {
							saveToSmb(smbStr, childFile[cnt].getAbsolutePath());
						} else {
							getChangeList(getAttachPath(childFile[cnt]
									.getAbsolutePath()));
						}
					}
				}
			}
		} catch (Exception ioe) {
			System.out.println(CDate.getNowTime() + "-->"
					+ this.getClass().getName() + ":" + ioe.getMessage());
		}
	}

	/**
	 * Description：在远程服务器上生成文件件
	 * @param rmifile 远程文件名
	 * @param smbMachine 远程连接
	 */
	private void makeDir(SmbFile rmifile, String smbMachine) {
		String[] path = smbMachine.split("/");
		String smbPath = "";
		try {
			if (path.length > 0) {
				smbPath = path[0];
				for (int cnt = 1; cnt < path.length; cnt++) {
					smbPath += "/" + path[cnt];
					rmifile = new SmbFile(smbPath);
					if (!rmifile.exists())
						rmifile.mkdir();
				}
			}
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SmbException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * Description:取得文件的相对路径
	 * 
	 * @param path
	 *            文件绝对路径
	 * @return path
	 */
	public String getAttachPath(String path) {
		path = path.replaceAll("\\\\", "/");
		path = path.substring(path.indexOf(attachPath) + attachPath.length(),
				path.length());
		return path;
	}

	/**
	 * 从localfileapth读取文件并存储到smbMachine指定的路径
	 * 
	 * @param smbMachine
	 *            共享机器的文件,如smb://xxx:xxx@10.108.23.112/myDocument/测试文本.txt,xxx:xxx是共享机器的用户名密码
	 * @param localpath
	 *            本地路径
	 * @return flag 文件操作成功返回true，否则返回false
	 */
	public boolean saveToSmb(String smbMachine, String localfileapth) {
		InputStream bis = null;// 输入流
		OutputStream bos = null;// 输出流
		String filename = "";// 本地文件名
		SmbFile rmifile = null;// 远程文件名
		File file = null;// 本地文件
		boolean flag = false;// 保存是否成功
		try {
			// 初始化远程文件，若没有，创建文件以及文件夹
			makeDir(rmifile, smbMachine);
			rmifile = new SmbFile(smbMachine);
			if (!rmifile.exists())
				rmifile.mkdir();
			// 初始化本地文件
			file = new File(localfileapth);
			filename = file.getName();
			
			//System.out.println(smbMachine + File.separator + filename+"---------localfilepath========"+localfileapth);
			// 将本地文件的内容写入远程文件
			bis = new BufferedInputStream(new FileInputStream(file));
			rmifile = new SmbFile(smbMachine + File.separator + filename);
			bos = new BufferedOutputStream(new SmbFileOutputStream(rmifile));
			int length = (int) file.length();
			byte[] buffer = new byte[length];

			Date start = new Date();// 记录操作开始时间
			bis.read(buffer);
			bos.write(buffer);
			bis.close();
			bos.close();
			
			file.delete();// 远程文件保存后删除本地文件
			this.deleteNullFolder(attachPath);// 远程文件保存后删除本地空的文件夹

			flag = true;// 操作结束将标志设置为成功

			Date end = new Date();// 记录操作结束时间
			int time = (int) ((end.getTime() - start.getTime()) / 1000);
			if (time > 0)
				System.out.println("用时:" + time + "秒 " + "速度:" + length / time
						/ 1024 + "kb/秒");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out
					.println(CDate.getNowTime() + "-->"
							+ this.getClass().getName() + ":saveToSmb "
							+ e.getMessage());

		} finally {
			try {
				bos.close();
				bis.close();
			} catch (IOException e) {
				// // TODO Auto-generated catch block
				System.out.println(CDate.getNowTime() + "-->"
						+ this.getClass().getName() + ":saveToSmb "
						+ e.getMessage());
			}
		}
		return flag;
	}

	/**
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
				e.printStackTrace();
			}
		}
		return localfile;
	}
}
