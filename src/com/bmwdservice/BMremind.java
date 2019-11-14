package com.bmwdservice;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Hashtable;
import java.util.TimerTask;
import java.util.Vector;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.emailService.EmailModel;
import com.util.CTools;

/**
 * 便民提醒中的便民问答
 * @author Administrator
 *
 */
public class BMremind extends TimerTask{
	CDataCn dCn = null;
	CDataImpl dImpl = null;
	Vector vPage = null;
	Hashtable content = null;
	java.sql.Connection conn = null;
	Statement stmt = null;
	
	public BMremind(){}
//	/**
//	 * 连接NET数据库
//	 */
//	public void getNetConn(){
//		String driverClass = "com.microsoft.jdbc.sqlserver.SQLServerDriver";
//		String username = "sa";
//		String password = "123456";
//		String url = "jdbc:microsoft:sqlserver://31.6.130.53:1433;DatabaseName=pudong";
//		try{
//			Class.forName(driverClass);
//		    conn = DriverManager.getConnection(url,username,password);
//		    stmt = conn.createStatement();
//		    conn.setAutoCommit(false);
//		}catch(ClassNotFoundException e){
//			e.printStackTrace();
//		}catch(SQLException ex){
//			ex.printStackTrace();
//		}
//	}
	/**
	 * 调用信息发布接口插入到便民问答.net数据库
	 */	
	public void saveToNet(){
		String pa_id = "";
		String pa_ask = "";
		String pa_answer = "";
		String ac_date = "";
		String pa_content = "";
		String bmwds = "";
		boolean isnet = false;
		
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			
			String bmSql = "select pa_id,pr_id,pa_ask,pa_answer,ac_date from tb_proceeding_ask where ac_ispublic = 1 and ac_isnet=1 order by ac_date desc ";
			vPage = dImpl.splitPage(bmSql,20,1);
			if(vPage!=null){
				for(int i=0;i<vPage.size();i++){
					content = (Hashtable)vPage.get(i);
					pa_id = CTools.dealNull(content.get("pa_id"));
					pa_ask = CTools.dealNull(content.get("pa_ask"));
					pa_answer = CTools.dealNull(content.get("pa_answer"));
					ac_date = CTools.dealNull(content.get("ac_date"));
					pa_content = "问："+pa_ask+"&lt;br&gt;答："+pa_answer;//便民问答内容
					System.out.println("pa_content=="+pa_content);
					bmwds = this.sendXMLs(pa_id, pa_ask, pa_content,ac_date);
					//调用信息添加接口
					Web30ServiceTestCase wstc = new Web30ServiceTestCase("1");
					isnet = wstc.GetInfoData(bmwds);
					if(isnet){
						dImpl.edit("tb_proceeding_ask", "pa_id", pa_id);
						dImpl.setValue("ac_isnet","2", CDataImpl.STRING);//是否推送到.net数据库1未推送2已推送默认为1
						dImpl.update();
					}
				}
			}
		}catch(Exception ex){
			ex.printStackTrace();
			System.out.println("saveToNet=="+ex.getMessage());
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
	}
	/**
	 * 拼接需要发送的信息XMLS
	 * @param askid 便民问答ID
	 * @param title 便民问答标题
	 * @param content 内容
	 * @param strattime 发布时间
	 * @return 返回需要发送的信息XMLS
	 */
	public String sendXMLs(String askid,String title,String content,String strattime){
		StringBuffer askXml  =new StringBuffer();
		
		askXml.append("<OperationType>消息发起</OperationType>");
		askXml.append("<MessageTitle>"+title+"</MessageTitle>");//问答标题
		askXml.append("<MessageID></MessageID>"); 
		askXml.append("<MessageBody>");
		askXml.append("<ROOT>"); 
		askXml.append("<DATASEND>");
		askXml.append("<OPERATER>add</OPERATER>");//添加
		askXml.append("<ID>"+askid+"</ID>");//
		askXml.append("<SYSCODE></SYSCODE>");
		askXml.append("<FORMID></FORMID>");
		askXml.append("<SPECIAL>0</SPECIAL>");
		askXml.append("<LINK></LINK>");
		askXml.append("<TITLE>"+title+"</TITLE>");//标题
		askXml.append("<SUBJECTID>33963</SUBJECTID>");//栏目ID 便民问答栏目ID 33963、测试栏目33651
		askXml.append("<CONTENT>"+content+"</CONTENT>");//内容
		askXml.append("<STARTTIME>"+strattime+"</STARTTIME>");//开始时间
		askXml.append("<ENDTIME>2050-01-01</ENDTIME>");//结束时间
		askXml.append("<UPDATETIME></UPDATETIME>");//修改时间
		askXml.append("<SENDUNIT></SENDUNIT>");//
		askXml.append("<FILECODE></FILECODE>");//文件编号
		askXml.append("<INDEX></INDEX>");//索取号
		askXml.append("<PUBLISH>1</PUBLISH>");//公开类别1主动公开
		askXml.append("<CARRIER></CARRIER>");//载体类型
		askXml.append("<ANNAL></ANNAL>");//记录形式
		askXml.append("<SUBJECTCODE>newgovOpen_BMWD</SUBJECTCODE>");//栏目代号 便民问答 newgovOpen_BMWD、测试栏目testjg
		askXml.append("<SOURCE></SOURCE>");//来源
		askXml.append("<DESCRIBE></DESCRIBE>");//内容描述
		askXml.append("<KEY></KEY>");//关键字
		askXml.append("<DEPTCODE></DEPTCODE>");//
		askXml.append("<IMPORTANTFLAG>0</IMPORTANTFLAG>");//
//		askXml.append("<FILEPUBATTACH>");//
//		askXml.append("<PUBATTACH>");//
//		askXml.append("<FILENAME></FILENAME>");//
//		askXml.append("<FILETYPE></FILETYPE>");//
//		askXml.append("<FILELENGTH></FILELENGTH>");//
//		askXml.append("<FILECONTENT></FILECONTENT>");//
//		askXml.append("<FILEEXTENSION></FILEEXTENSION>");//
//		askXml.append("</PUBATTACH>");//
//		askXml.append("</FILEPUBATTACH>");//
		askXml.append("</DATASEND>");//
		askXml.append("</ROOT>");//
		askXml.append("</MessageBody>");//
		askXml.append("<SourceUnitCode></SourceUnitCode>");//
		askXml.append("<SourceCaseCode></SourceCaseCode>");//
		askXml.append("<DestUnit>");//
		askXml.append("<DestUnitCode></DestUnitCode>");//
		askXml.append("<DestCaseCode></DestCaseCode>");//
		askXml.append("<InterFaceCode></InterFaceCode>");//
		askXml.append("</DestUnit>");//
		askXml.append("<Sender>浦东门户网站</Sender>");//
		askXml.append("<SendTime>"+strattime+"</SendTime>");//
		askXml.append("<EndTime>"+strattime+"</EndTime>");//
		
		String emailMessage="<DEP_DataExchangeData>"+askXml+"</DEP_DataExchangeData>";
		return emailMessage;
	}
	/**
	 * 监听方法
	 */
	public void run(){
		this.saveToNet();
	}
	/**
	 * main
	 * @param args
	 */
	public static void main(String args[]){
		BMremind bmr = new BMremind();
		bmr.saveToNet();
	}

}
