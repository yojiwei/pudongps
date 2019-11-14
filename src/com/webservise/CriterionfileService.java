package com.webservise;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Hashtable;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
import com.util.CBase64;
import com.util.CDate;
import com.util.CFile;
import com.util.CTools;
import com.util.ReadProperty;
/**
 * 规范性文件提供到浦东门户网站前台的方法
 * @author Administrator
 *
 */
public class CriterionfileService {
	private CDataCn dCn = null;
	private CDataImpl dImpl = null; 
	private Hashtable content = null;
	private ReadProperty rp = null;
	private String isCheck = ""; //提供验证XML的参考 1 提供 0不提供
	private String cf_content = "";
	public CriterionfileService(){}
	
	/**
	 * 获得bean
	 * @param cf_id
	 * @return
	 * 同步4次没成功不再同步
	 */
	public CriterionfileBean getcfBean(String cf_id){
		String cfSql = "select c.cf_id,c.cf_title,c.cf_filenumber,c.cf_userid,c.cf_createdeptid,c.cf_createdeptcode,to_char(c.cf_IssueTime,'yyyy-MM-dd') as cf_issuetime,to_char(c.cf_ActualizeTime,'yyyy-MM-dd') as cf_actualizetime,to_char(c.cf_CreateTime,'yyyy-MM-dd') as cf_createtime,to_char(c.cf_endTime,'yyyy-MM-dd') as cf_endtime,c.cf_validity,c.cf_serialnumber,c.cf_censorresult,c.cf_memo,f.cf_content,p.pu_title,p.pu_content,d.dt_name from tb_criterionfile c,tb_criterionfilecontent f,tb_policyunscramble p,tb_deptinfo d where " +
				"c.cf_id = f.cf_id and c.cf_id = p.cf_id(+) and c.cf_createdeptid = d.dt_id and c.cf_id = "+cf_id+" order by c.cf_id desc ";
		//System.out.println("cfSql=="+cfSql);
		CriterionfileBean cfBean = new CriterionfileBean();
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			content = (Hashtable)dImpl.getDataInfo(cfSql);
			//基本信息
			if(content!=null){
				cfBean.setCf_id(CTools.dealNull(content.get("cf_id")));
				cfBean.setCf_title(CTools.dealNull(content.get("cf_title")));
				cfBean.setCf_filenumber(CTools.dealNull(content.get("cf_filenumber")));
				cfBean.setCf_userid(CTools.dealNull(content.get("cf_userid")));
				cfBean.setCf_createDeptid(CTools.dealNull(content.get("cf_createdeptid")));
				//部门名称
				cfBean.setCf_createDeptCode(CTools.dealNull(content.get("dt_name")));
				//部门CODE
				//cfBean.setCf_createDeptCode(CTools.dealNull(content.get("cf_createdeptcode")));
				//
				cfBean.setCf_IssueTime(CTools.dealNull(content.get("cf_issuetime")));
				cfBean.setCf_ActualizeTime(CTools.dealNull(content.get("cf_actualizetime")));
				cfBean.setCf_CreateTime(CTools.dealNull(content.get("cf_createtime")));
				cfBean.setCf_endtime(CTools.dealNull(content.get("cf_endtime")));
				String validity = CTools.dealNull(content.get("cf_validity"));
				//时效性
				if("1".equals(validity)){
					validity = "全部";
				}else if("2".equals(validity)){
					validity = "已停止执行";
				}else if("3".equals(validity)){
					validity = "有效";
				}else if("4".equals(validity)){
					validity = "已被修改";
				} 
				cfBean.setCf_Validity(validity);
				cfBean.setCf_SerialNumber(CTools.dealNull(content.get("cf_serialnumber")));
				cfBean.setCf_CensorResult(CTools.dealNull(content.get("cf_censorresult")));
				cfBean.setCf_memo(CTools.dealNull(content.get("cf_memo")));
				//规范性文件内容
				cf_content = CTools.dealNull(content.get("cf_content"));
				cf_content = cf_content.replaceAll("&nbsp;", "　");
				cfBean.setCf_content(cf_content);
				//政策解读相关
				cfBean.setPu_title(CTools.dealNull(content.get("pu_title")));
				cfBean.setPu_content(CTools.dealNull(content.get("pu_content")));
			}
			//附件
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return cfBean;
	}
	
	/**
	 * 返回XMLS字符串
	 * @param cfBean
	 * @param operation add|update|delete
	 * @return
	 */
	public String getXmls(CriterionfileBean cfBean,String operation){
		String xmls = "";
		StringBuffer cfxmls = new StringBuffer("");
		cfxmls.append("<?xml version=\"1.0\" encoding=\"gbk\"?>");
		cfxmls.append("<ROOT>");
		cfxmls.append("<OPERATER>"+operation+"</OPERATER>");
		cfxmls.append("<ID>"+cfBean.getCf_id()+"</ID>");
		cfxmls.append("<TITLE><![CDATA[ "+cfBean.getCf_title()+" ]]></TITLE>");
		cfxmls.append("<FILENUMBER>"+cfBean.getCf_filenumber()+"</FILENUMBER>");
		cfxmls.append("<CREATEDEPTID>"+cfBean.getCf_createDeptid()+"</CREATEDEPTID>");
		cfxmls.append("<CREATEDEPTcode>"+cfBean.getCf_createDeptCode()+"</CREATEDEPTcode>");
		cfxmls.append("<SERIALNUMBER>"+cfBean.getCf_SerialNumber()+"</SERIALNUMBER>");
		cfxmls.append("<CENSORRESULT>"+cfBean.getCf_CensorResult()+"</CENSORRESULT>");
		
		cfxmls.append("<CONTENT><![CDATA[ "+cfBean.getCf_content()+" ]]></CONTENT>");
		cfxmls.append("<MEMO><![CDATA[ "+cfBean.getCf_memo()+" ]]></MEMO>");
		cfxmls.append("<STARTTIME>"+cfBean.getCf_IssueTime()+"</STARTTIME>");
		cfxmls.append("<ACTUALIZETIME>"+cfBean.getCf_ActualizeTime()+"</ACTUALIZETIME>");
		cfxmls.append("<CREATETIME>"+cfBean.getCf_CreateTime()+"</CREATETIME>");
		cfxmls.append("<ENDTIME>"+cfBean.getCf_endtime()+"</ENDTIME>");
		cfxmls.append("<VALIDITY>"+cfBean.getCf_Validity()+"</VALIDITY>");
		cfxmls.append("<ZCTITLE>"+cfBean.getPu_title()+"</ZCTITLE>");
		cfxmls.append("<ZCCONTENT><![CDATA[ "+cfBean.getPu_content()+" ]]></ZCCONTENT>");
		//追加附件
		//System.out.println("getAttachXmls==="+cfBean.getCf_id());
		cfxmls.append(getAttachXml(cfBean.getCf_id(), dImpl, cfBean));
		
		cfxmls.append("<SendTime>"+CDate.getThisday()+"</SendTime>");
		cfxmls.append("</ROOT>");
		
		
		xmls = cfxmls.toString();
		return xmls;
	}
	
	/**
	 * 得到附件相关XML
	 * @param cf_id 规范性文件主键
	 * @param dImpl 数据对象
	 * @return StringBuffer 附件相关XML
	 */
	private StringBuffer getAttachXml(String cf_id,CDataImpl dImpl,CriterionfileBean cfBean) {
			StringBuffer strB= new StringBuffer();
			Hashtable table =null;
			String cf_name="";
			String cf_path="";
			String pa_filename="";
			String fileSize="";
			String filetype="";//扩展名
			
			String sql ="select cf_path,cf_name,cf_filename from tb_CriterionFileAttach where cf_id="+ cf_id + " order by  cfa_id";
			Vector vPage = dImpl.splitPage(sql,60,1);//最多取60个附件
			String localPath=this.getClass().getResource("/").getPath();
			localPath = URLDecoder.decode(localPath);//转换编码 如空格
			localPath = localPath.substring(1,localPath.lastIndexOf("WEB-INF"));
			String allLocalPath=localPath+"attach/infoattach/";
			
			strB.append("<FILEPUBATTACH>");//附件开始
			if(vPage!=null){
				for(int i=0;i<vPage.size();i++){
					table = (Hashtable)vPage.get(i);
					pa_filename=CTools.dealNull(table.get("cf_filename"));
					cf_path=CTools.dealNull(table.get("cf_path"));
					cf_name=CTools.dealNull(table.get("cf_name"));
					filetype="";//扩展名初始化
					if(pa_filename.lastIndexOf(".")!=-1)
						filetype=pa_filename.substring(pa_filename.lastIndexOf(".")+1);
					
				
					String localFilePath=allLocalPath+cf_path+"/"+pa_filename;
					File file = new File(localFilePath);
					if(file.exists()){
						if(!"".equals(cf_name) &&!".".equals(cf_name)){
							if(cf_name.lastIndexOf(".") != -1)
								pa_filename=cf_name;
							else
								pa_filename=cf_name + pa_filename.substring(pa_filename.lastIndexOf("."));
						}
						
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
						strB.append("</PUBATTACH>");
					}
				}
			}
			//正则查找正文中的附件 进行附件追加
			String regPic = "/attach/infoattach/[^\"]*\"";
			String labelContent = cfBean.getCf_content();
			
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
				cf_path = tempPicStr.substring(tempPicStr.lastIndexOf("/")+1);
				
				filetype="";//扩展名初始化
				if(pa_filename.lastIndexOf(".")!=-1)
					filetype=pa_filename.substring(pa_filename.lastIndexOf(".")+1);
				String localFilePath=allLocalPath+cf_path+"/"+pa_filename;
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
						System.out.println("CriterionfileService.java:推送正文中的附件没找到"+fnfe.getMessage());
					}
					strB.append("</PUBATTACH>");
				}
			}
			strB.append("</FILEPUBATTACH>");//附件结束 
			return strB;
	}
	
	
	/**
	 * 调用浦东门户网站前台接口
	 * @param cf_id 规范性文件ID
	 * @param operation 规范性文件操作 Add|Edit|Delete
	 */
	public String sendCritertionfileXmls(String cf_id,String operation){
		String critertionfilexmls = "";
		String warin = "";
		String returnStr = "";
		String returnBck = "";
		String backXmls = "";
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			critertionfilexmls = this.getXmls(this.getcfBean(cf_id), operation);
			//
			//CFile.write(dImpl.getInitParameter("criterionfile_path")+CDate.getThisday()+CDate.getThisTime()+"o.xml",critertionfilexmls);
			
			System.out.println("critertionfilexmls====="+critertionfilexmls);
			//html encode 编码
			//critertionfilexmls = htmEncode(critertionfilexmls);
			//替换掉所有的<br>
			//critertionfilexmls = critertionfilexmls.replaceAll("<br>", "");
			//调用浦东门户网站前台显示的接口
			InterfacegradeTestCase iftc = new InterfacegradeTestCase(critertionfilexmls);
			backXmls = iftc.sendXmls(critertionfilexmls);
			System.out.println("backXmls========="+backXmls);
			//提供验证XML的参考
			rp = new ReadProperty();
			isCheck = rp.getPropertyValue("ischeck");
			if("1".equals(isCheck)){
				//CFile.write(dImpl.getInitParameter("criterionfile_path")+CDate.getThisday()+CDate.getThisTime()+".xml",critertionfilexmls+"=ischeck="+backXmls);
			}
			//
			
			if(!"".equals(backXmls)){
				warin = this.getUserColumn(backXmls, "error").trim();
				if("".equals(warin)){
					dImpl.executeUpdate("update tb_criterionfilemessage set fm_result = 1 where cf_id = "+cf_id+"");
				}else{
					//CFile.write(dImpl.getInitParameter("criterionfile_path")+CDate.getThisday()+CDate.getThisTime()+".xml",critertionfilexmls+"==="+backXmls);
					//4次
					String countSql = "select nvl(fm_count,0) as count from tb_criterionfilemessage where cf_id="+cf_id+"";
					int countfm = 0;
					Hashtable vtcontent = (Hashtable)dImpl.getDataInfo(countSql);
					if(vtcontent!=null){
						countfm = Integer.parseInt(CTools.dealNumber(vtcontent.get("count")));
					}
					if(countfm>4){
						dImpl.executeUpdate("update tb_criterionfilemessage set fm_result = 2,fm_count = fm_count+1 where cf_id = "+cf_id+"");
					}else{
						dImpl.executeUpdate("update tb_criterionfilemessage set fm_count = fm_count+1 where cf_id = "+cf_id+"");
					}
				}
			}
			//记录日志-----
		 	dImpl.setTableName("tb_contentmessagelog");
		    dImpl.setPrimaryFieldName("cl_id");
		    dImpl.addNew();
		    dImpl.setValue("cm_id",cf_id,CDataImpl.INT);//关联tb_criterionfile表主键
		    if("".equals(warin)){
		    	returnStr = "规范性文件"+operation+"同步浦东门户：成功";
		    	returnBck = "ok";
		    }else{
		    	returnStr = "规范性文件"+operation+"同步浦东门户：失败 "+warin;
		    	returnBck = "failed";
		    }
		    dImpl.setValue("cl_returnmessage",returnStr,CDataImpl.STRING);//反馈信息
		    dImpl.update();
		    
		    
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
		return returnBck;
	}
	//
	public String htmEncode(String s)
	{
	        StringBuffer stringbuffer = new StringBuffer();
	        int j = s.length();
	        for(int i = 0; i < j; i++)
	        {
	            char c = s.charAt(i);
	            switch(c)
	            {
	            case 60: stringbuffer.append("&lt;"); break;
	            case 62: stringbuffer.append("&gt;"); break;
	            case 38: stringbuffer.append("&amp;"); break;
	            case 34: stringbuffer.append("&quot;"); break;
	            case 169: stringbuffer.append("&copy;"); break;
	            case 174: stringbuffer.append("&reg;"); break;
	            case 165: stringbuffer.append("&yen;"); break;
	            case 8364: stringbuffer.append("&euro;"); break;
	            case 8482: stringbuffer.append("&#153;"); break;
	            case 13:
	              if(i < j - 1 && s.charAt(i + 1) == 10)
	              {stringbuffer.append("<br>");
	               i++;
	              }
	              break;
	            case 32:
	              if(i < j - 1 && s.charAt(i + 1) == ' ')
	                {
	                  stringbuffer.append(" &nbsp;");
	                  i++;
	                  break;
	                }
	            default:
	                stringbuffer.append(c);
	                break;
	            }
	        }
	      return new String(stringbuffer.toString());
	} 
	
	/**
	 * 解析
	 * @param userXml
	 * @param column
	 * @return
	 */
	public String getUserColumn(String cfXml, String column)
    {
        String regBegin = "<" + column + ">";
        String regEnd = "</" + column + ">";
        String regC = regBegin + "([\\w\\W]*?)" + regEnd;
        String returnStr = "";
        Pattern p = null;
        Matcher m = null;
        p = Pattern.compile(regC);
        try {
        	cfXml = URLDecoder.decode(cfXml, "utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        m = p.matcher(cfXml);
        if(m.find())
        {
            returnStr = m.group();
            returnStr = returnStr.replaceAll(regBegin, "");
            returnStr = returnStr.replaceAll(regEnd, "");
            return returnStr;
        } else
        {
            return returnStr;
        }
    }
	/**
	 * main方法
	 * @param args
	 */
	public static void main(String args[]){
		CriterionfileService cfs = new CriterionfileService();
		String cf_id = "385";
		String operation = "Add";
		cfs.sendCritertionfileXmls(cf_id, operation);
		System.out.println(CDate.getThisday()+CDate.getThisTime());
		//CFile.write("D:\\bsshs\\com\\"+CDate.getThisday()+CDate.getThisTime()+".xml", "121212");
		
		System.out.println("--over--");
	}
	
	
}
