package com.webservise;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.Hashtable;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CBase64;
import com.util.CDate;
import com.util.CFile;
import com.util.CTools;

/**
 * Description:将公文备案里的部门职能介绍信息报送到
 * @author yang
 *
 */
public class SendInfoopenToOA {
	
	public static void main(String[] args){
		SendInfoopenToOA sendInfoopenToOA = new SendInfoopenToOA();
		sendInfoopenToOA.getAllInfo();
	}

	/**
	 * 得到所有未交换的“职能介绍”数据
	 * @return 拼装成xml格式的“职能介绍”数据
	 */
	public String getAllInfo(){
		String addStr = "";
		String sqlStr = "select c.ct_title,c.ct_id,dt.dt_name,decode(cm.cm_type,1,0,2,1,3,2,0) cm_type," +
				"cm.sj_id,cm.cm_inserttime,c.dt_id,dt.dt_code from tb_content c,tb_contentmessage cm,tb_deptinfo dt  " +
				"where cm.ct_id=c.ct_id and c.dt_id=dt.dt_id and cm.sj_name='职能介绍'  " +
				"and (to_char(cm_inserttime,'yyyy-MM-dd')=to_char(sysdate,'yyyy-MM-dd') " +
				"or cm_updatetime=to_char(sysdate,'yyyy-MM-dd') )order by ct_inserttime,cm_type";
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Vector contentList = null;
		Hashtable content = null;
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			contentList = dImpl.splitPageOpt(sqlStr,100,1);
			if(contentList != null){
				for(int cnt = 0; cnt <contentList.size(); cnt++){
					content = (Hashtable) contentList.get(cnt);
					dealContent(content,dImpl);
				}
			}
		} catch (Exception e) {
			System.out.println(CDate.getNowTime() + "-->"
					+ "SendInfoopenToOA : getAllInfo " + e.getMessage());
		} finally {
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return addStr;
	}
	
	/**
	 * Desc:将单条信息拼装成xml
	 * @param content 数据库取出的一条信息
	 * @param dImpl 数据库连接
	 * @return xml字符串
	 */
	private String dealContent(Hashtable content,CDataImpl dImpl){
		Hashtable nrContent = null;
		StringBuffer singleStr = new StringBuffer("");
		//添加xml固定的格式
		singleStr.append("<DEP_DataExchangeData>");
		singleStr.append("<OperationType/>");
		singleStr.append("<MessageTitle/>");
		singleStr.append("<MessageID/>");
		singleStr.append("<ROOT>");
		singleStr.append("<DATASEND>");
		
		//信息发布行为标志位：0:新建，1:修改，2:删除
		singleStr.append("<METHOD>");
		singleStr.append(CTools.dealNull(content.get("cm_type")));
		singleStr.append("</METHOD>");
		
		//MOSS站点SiteUrl
		singleStr.append("<SITEURL></SITEURL>");
		
		//MOSS站点WebUrl
		singleStr.append("<WEBURL></WEBURL>");
		
		//MOSS站点ListName
		singleStr.append("<LISTNAME></LISTNAME>");
		
		//此条信息的ID 
		singleStr.append("<NewsID>");
		singleStr.append(CTools.dealNull(content.get("ct_id")));
		singleStr.append("</NewsID>");
		
		//是否发布到外网：0表示false不发到外网只发布于内网，1表示true既发到外网也发布到内网
		singleStr.append("<IsToOut>0</IsToOut>");
		
		//此条信息的标题
		singleStr.append("<TITLE>");
		singleStr.append(CTools.dealNull(content.get("ct_title")));
		singleStr.append("</TITLE>");
		
		//发布单位名
		singleStr.append("<PublishUnit>");
		singleStr.append(CTools.dealNull(content.get("dt_name")));
		singleStr.append("</PublishUnit>");
		
		//PublishDept
		singleStr.append("<PublishDept>");
		singleStr.append(CTools.dealNull(content.get("dt_name")));
		singleStr.append("</PublishDept>");
		
		//此条信息的单位代码 
		singleStr.append("<filterword>");
		singleStr.append(CTools.dealNull(content.get("dt_code")));
		singleStr.append("</filterword>");
		
		//发布时间 
		singleStr.append("<SitePublishDate>");
		singleStr.append(CTools.dealNull(content.get("cm_inserttime")));
		singleStr.append("</SitePublishDate>");
		
		//发布人
		singleStr.append("<SiteAuthor/>");
		
		
		//页面内容(可能有图文混排的情况发生)
		nrContent = getNRContent(CTools.dealNull(content.get("ct_id")));
		singleStr.append("<CONTENT/><![CDATA[");
		if(nrContent != null){
			singleStr.append(CTools.dealNull(nrContent.get("ct_content")));
		}
		singleStr.append("]]></CONTENT>");
		
		//图片
		singleStr.append("<CONTENTIMG>");
		singleStr.append("<IMAGE>");
		singleStr.append("<IMAGENAME/>");
		singleStr.append("<IMAGETYPE/>");
		singleStr.append("<IMAGESIZE/>");
		singleStr.append("<IMAGECONTENT/>");
		singleStr.append("<FILEEXTENSION/>");
		singleStr.append("</IMAGE>");
		singleStr.append("</CONTENTIMG>");
		
		//附件
		singleStr.append(getAttachXml(CTools.dealNull(content.get("ct_id")), dImpl,nrContent));
		
		//尾部固定格式
		singleStr.append("</DATASEND>");
		singleStr.append("</ROOT>");
		singleStr.append("<MessageBody/>");
		singleStr.append("<SourceUnitCode/>"); 
		singleStr.append("<SourceCaseCode/>"); 
		singleStr.append("<DestUnit>");
		singleStr.append("<DestUnitCode/>"); 
		singleStr.append("<DestCaseCode/>"); 
		singleStr.append("<InterFaceCode/>"); 
		singleStr.append("</DestUnit>");
		singleStr.append(" <Sender/>"); 
		singleStr.append("<SendTime/>"); 
		singleStr.append(" <EndTime/>"); 
		singleStr.append("</DEP_DataExchangeData>");
		//
//		System.out.println(singleStr.toString());
		CFile.write("d:/temp/" + CTools.dealNull(content.get("ct_id")) + ".xml",singleStr.toString());
		return singleStr.toString();
	}
	
	/**
	 * Desc：根据主键得到内容列
	 * @param ct_id 信息主键
	 * @return 内容列
	 */
	private Hashtable getNRContent(String ct_id){
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Hashtable content = null;
		String sqlStr = "select ct_content from tb_contentdetail where ct_id =" + ct_id;
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			content = dImpl.getDataInfo(sqlStr);
		} catch (Exception e) {
			System.out.println(CDate.getNowTime() + "-->"
					+ "SendInfoopenToOA : getNRContent " + e.getMessage());
		} finally {
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return content;
	}
	
	/**
	 * 得到附件相关XML
	 * @param ct_id 信息主键
	 * @param dImpl 数据库连接
	 * @param content 信息内容的数据列
	 * @return 附件的xml字符串
	 */
	private StringBuffer getAttachXml(String ct_id,CDataImpl dImpl,Hashtable content) {
		StringBuffer strB= new StringBuffer();
		Hashtable table =null;
		String pa_id="";
		String pa_name="";
		String pa_path="";
		String pa_filename="";
		String fileSize="";
		String filetype="";//扩展名
		
		String sql ="select pa_path,pa_filename from tb_publishattach where ct_id="+ ct_id + " order by pa_id";
		Vector vPage = dImpl.splitPage(sql,60,1);//最多取60个附件
		String localPath=this.getClass().getResource("/").getPath();
		localPath = URLDecoder.decode(localPath);//转换编码 如空格
		localPath = localPath.substring(1,localPath.lastIndexOf("WEB-INF"));
		String allLocalPath=localPath+"attach/infoattach/";
		strB.append("<FILEPUBATTACH>");//附件开始
		if(vPage!=null){
			for(int i=0;i<vPage.size();i++){
				table = (Hashtable)vPage.get(i);
				pa_filename=CTools.dealNull(table.get("pa_filename"));
				pa_path=CTools.dealNull(table.get("pa_path"));
				filetype="";//扩展名初始化
				if(pa_filename.lastIndexOf(".")!=-1)filetype=pa_filename.substring(pa_filename.lastIndexOf(".")+1);
				String localFilePath=allLocalPath+pa_path+"/"+pa_filename;
				File file = new File(localFilePath);
//				System.out.println(localFilePath);
				if(file.exists()){
					strB.append("<PUBATTACH><FILENAME>"+pa_filename+"</FILENAME>");
					strB.append("<FILETYPE>"+filetype+"</FILETYPE>");
					try{
						FileInputStream fis = null;
						fis = new FileInputStream(file);
						fileSize =String.valueOf(fis.available());
						strB.append("<FILELENGTH>"+fileSize+"</FILELENGTH>");
						strB.append("<FILECONTENT>");//文件内容 base64
						strB.append(CBase64.getFileEncodeString(localFilePath));
						strB.append(" </FILECONTENT>");
						strB.append("<FILEEXTENSION>"+filetype+"</FILEEXTENSION>");
					}catch(IOException fnfe){
						System.out.println("JavaClientNetService.java:推送附件没找到"+fnfe.getMessage());
					}
					strB.append("</PUBATTACH>");//System.out.println(strB.toString());
				}
			}
		}
//		正则查找正文中的附件 进行附件追加
		String regPic = "/attach/infoattach/[^\"]*\"";
		String labelContent = CTools.dealNull(content.get("ct_content"));
		
		String picStr="";
		Pattern p = null;
		Matcher m = null;
		p = Pattern.compile(regPic);
		m = p.matcher(labelContent);
		allLocalPath=localPath+"attach/infoattach/";
		while(m.find()) {
			picStr=m.group();
			if(!picStr.equals(""))picStr=picStr.substring(0, picStr.length()-1);//去掉最后一个引号
			else continue;//空 退出当前
	
			pa_filename=picStr.substring(picStr.lastIndexOf("/")+1);
			
			String tempPicStr=picStr.substring(0,picStr.lastIndexOf("/"));
			pa_path = tempPicStr.substring(tempPicStr.lastIndexOf("/")+1);
			
			filetype="";//扩展名初始化
			if(pa_filename.lastIndexOf(".")!=-1)filetype=pa_filename.substring(pa_filename.lastIndexOf(".")+1);
			String localFilePath=allLocalPath+pa_path+"/"+pa_filename;
			File file = new File(localFilePath);
			if(file.exists()){
				strB.append("<PUBATTACH><FILENAME>"+pa_filename+"</FILENAME>");
				strB.append("<FILETYPE>"+filetype+"</FILETYPE>");
				try{
					FileInputStream fis = null;
					fis = new FileInputStream(file);
					fileSize =String.valueOf(fis.available());
					strB.append("<FILELENGTH>"+fileSize+"</FILELENGTH>");
					strB.append("<FILECONTENT>");//文件内容 base64
					strB.append(CBase64.getFileEncodeString(localFilePath));
					strB.append(" </FILECONTENT>");
					strB.append("<FILEEXTENSION>"+filetype+"</FILEEXTENSION>");
				}catch(IOException fnfe){
					System.out.println("JavaClientNetService.java:推送正文中的附件没找到"+fnfe.getMessage());
				}
				strB.append("</PUBATTACH>");//System.out.println(strB.toString());
			}
		}
		strB.append("</FILEPUBATTACH>");//附件结束 
		return strB;
	}
	
}
