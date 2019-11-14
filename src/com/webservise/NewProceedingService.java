package com.webservise;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Vector;
import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.newproceeding.SmartServiceSoap_BindingStub;
import com.service.log.LogservicePd;
import com.util.CFile;
import com.util.CTools;

/**
 * 调用苏顺机器人接口同步办事事项数据
 * http://192.168.152.221/WebService/SmartService.asmx
 * @author Administrator
 * 2011-11-3
 */
public class NewProceedingService {
	private String npsql = "";
	private String npattachsql = "";
	Hashtable content = null;
	Hashtable attachcontent = null;
	Vector vector = null;
	Vector initvector = null;
	Hashtable initcontent = null;
	CDataCn dCn=null;   //新建数据库连接对象
	CDataImpl dImpl=null;  //新建数据接口对象
	SimpleDateFormat prosdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	private String proxmls = "";
	/**
	 * 需要同步的XMLS
	 * @param operater add|update|delete
	 * @param pr_id
	 * @return
	 */
	public void proceeding(String operater,String pr_id){
		NewProceedingModel npm = new NewProceedingModel();
		
		ArrayList arrylist = new ArrayList();
		try{
			dCn = new CDataCn(); 
			dImpl = new CDataImpl(dCn); 
			npsql = "select p.pr_id,p.cw_id,m.cw_name,p.sw_id,s.sw_name,p.pr_name,d.dt_name,p.pr_money,p.pr_timelimit,p.pr_isaccept,p.pr_url,to_char(p.pr_edittime,'yyyy-MM-dd') as pr_edittime,p.pr_telephone,p.pr_tstype,p.pr_sxtype" +
					",p.pr_address,p.pr_tstel,p.pr_tsemail,p.pr_by,p.pr_area,p.pr_stuff,p.pr_blcx,p.pr_qt,p.pr_bc from tb_proceeding_new p,tb_sortwork s,tb_commonproceed_new c,tb_commonwork m,tb_deptinfo d where  p.pr_id ='"+pr_id+"' and p.sw_id = s.sw_id and p.pr_id=c.pr_id(+) and c.cw_id = m.cw_id(+) and p.dt_id = d.dt_id";
			
			content  = dImpl.getDataInfo(npsql);
			if(content!=null)
			{
				npm.setPR_ID(CTools.dealNull(content.get("pr_id")));
				npm.setCW_ID(CTools.dealNull(content.get("cw_name")));
				npm.setSW_ID(CTools.dealNull(content.get("sw_name")));
				npm.setPR_NAME(CTools.dealNull(content.get("pr_name")));
				npm.setDT_NAME(CTools.dealNull(content.get("dt_name")));
				npm.setPR_MONEY(CTools.dealNull(content.get("pr_money")));
				npm.setPR_TIMELIMIT(CTools.dealNull(content.get("pr_timelimit")));
				npm.setPR_ISACCEPT(CTools.dealNull(content.get("pr_isaccept")));
				npm.setPR_URL("http://usercenter.pudong.gov.cn/website/workHall/workInfo.jsp?sj_dir=affairUpdate_new&pr_id="+CTools.dealNull(content.get("pr_id")+"&sxtype=bszn"));
				npm.setPR_EDITTIME(CTools.dealNull(content.get("pr_edittime")));
				npm.setPR_TELEPHONE(CTools.dealNull(content.get("pr_telephone")));
				npm.setPR_TSTYPE(CTools.dealNull(content.get("pr_tstype")));
				npm.setPR_SXTYPE(CTools.dealNull(content.get("pr_sxtype")));
				npm.setPR_ADDRESS(CTools.dealNull(content.get("pr_address")));
				npm.setPR_TSTEL(CTools.dealNull(content.get("pr_tstel")));
				npm.setPR_TSEMAIL(CTools.dealNull(content.get("pr_tsemail")));
				npm.setPR_BY(CTools.dealNull(content.get("pr_by")));
				npm.setPR_AREA(CTools.dealNull(content.get("pr_area")));
				npm.setPR_STUFF(CTools.dealNull(content.get("pr_stuff")));
				npm.setPR_BLCX(CTools.dealNull(content.get("pr_blcx")));
				npm.setPR_QT(CTools.dealNull(content.get("pr_qt")));
				npm.setPR_BC(CTools.dealNull(content.get("pr_bc")));
			}

			//attach
			npattachsql = "select pa_name,pa_path,pa_filename from tb_proceedingattach_new where pr_id = '"+pr_id+"'";
			vector = dImpl.splitPage(npattachsql,20,1);
			if(vector!=null){
				for(int j=0;j<vector.size();j++)
	            {
					NewProceedingModel npmattach = new NewProceedingModel();
					attachcontent = (Hashtable)vector.get(j);
					npmattach.setAttachtitle(CTools.dealNull(attachcontent.get("pa_name")));
					npmattach.setAttachURL("http://usercenter.pudong.gov.cn/attach/prattach/"+CTools.dealNull(attachcontent.get("pa_path"))+"/"+CTools.dealNull(attachcontent.get("pa_filename")));
					
					arrylist.add(npmattach);
	            }
			}
			
			proxmls = this.proceedingXml(npm, arrylist);
			//<?xml version=\"1.0\" encoding=\"gbk\"?>
			proxmls = "<root><operater>"+operater+"</operater>"+proxmls+"</root>";
			
			//测试接口信息
			//proxmls = "<root><operater>add</operater><PR_ID>2499</PR_ID><CW_ID>社会保障</CW_ID><SW_ID>其他</SW_ID><PR_NAME>农业保险理赔</PR_NAME><DT_NAME>书院镇</DT_NAME><PR_MONEY>安信农业保险股份有限公司规定的标准</PR_MONEY><PR_TIMELIMIT>48小时内报案</PR_TIMELIMIT><PR_ISACCEPT>1</PR_ISACCEPT><PR_URL></PR_URL><PR_EDITTIME>2012-08-21</PR_EDITTIME><PR_TELEPHONE>68252730</PR_TELEPHONE><PR_TSTYPE></PR_TSTYPE><PR_SXTYPE>便民服务事项</PR_SXTYPE><PR_ADDRESS>浦东新区惠南镇拱极路2776号 </PR_ADDRESS><PR_TSTEL>58199714</PR_TSTEL><PR_TSEMAIL></PR_TSEMAIL><PR_BY>中华人民共和国农业法 国家建立和完善农业保险制度。,</PR_BY><PR_AREA>符合安信农业保险股份有限公司规定的条款 </PR_AREA><PR_STUFF></PR_STUFF><PR_BLCX></PR_BLCX><PR_QT></PR_QT><PR_BC></PR_BC><attach><title></title><attachURL></attachURL></attach><attach><title></title><attachURL></attachURL></attach></root>";
			
			
			//html encode 编码
			proxmls = htmEncode(proxmls);
			//替换掉所有的<br>
			proxmls = proxmls.replaceAll("<br>", "");
			//CFile.write("D:\\new\\proxmls_"+CTools.dealNull(content.get("pr_id"))+".xml", proxmls);
			String isok = this.runProceeding(proxmls);
			if(!isNumeric(isok)){
				CFile.write("D:\\new\\proxmls_"+CTools.dealNull(content.get("pr_id"))+".xml", proxmls);
			}
			System.out.println("Result======"+CTools.dealNull(content.get("pr_id"))+"===="+isok);
			//记录日志
			//this.writeLog(CTools.dealNull(content.get("PR_ID")), isok, CTools.dealNull(content.get("PR_NAME"))+"--------"+operater, "");
			
		}catch(Exception ex){
			System.out.print(ex.toString());
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
		
	}
	
	/**
	 * 拼成传递的XML字符串
	 * @param pro 办事事项对象
	 * @param list 附件集合
	 * @return xml字符串
	 */
	private String proceedingXml(NewProceedingModel pro,ArrayList list) {
		StringBuffer proXml  =new StringBuffer("");
		proXml.append("<PR_ID>"+pro.getPR_ID()+"</PR_ID>");//
		proXml.append("<CW_ID>"+pro.getCW_ID()+"</CW_ID>");//
		proXml.append("<SW_ID>"+pro.getSW_ID()+"</SW_ID>"); //
		proXml.append("<PR_NAME><![CDATA["+pro.getPR_NAME()+"]]></PR_NAME>");  //
		proXml.append("<DT_NAME>"+pro.getDT_NAME()+"</DT_NAME>"); //
		proXml.append("<PR_MONEY><![CDATA["+pro.getPR_MONEY()+"]]></PR_MONEY>");  //money
		proXml.append("<PR_TIMELIMIT>"+pro.getPR_TIMELIMIT()+"</PR_TIMELIMIT>"); //
		proXml.append("<PR_ISACCEPT>"+pro.getPR_ISACCEPT()+"</PR_ISACCEPT>");//
		proXml.append("<PR_URL><![CDATA["+pro.getPR_URL()+" ]]></PR_URL>"); //
		proXml.append("<PR_EDITTIME>"+pro.getPR_EDITTIME()+"</PR_EDITTIME>");//
		proXml.append("<PR_TELEPHONE>"+pro.getPR_TELEPHONE()+"</PR_TELEPHONE>");//
		proXml.append("<PR_TSTYPE><![CDATA["+getBASE64(pro.getPR_TSTYPE())+" ]]></PR_TSTYPE>");//
		proXml.append("<PR_SXTYPE><![CDATA["+getBASE64(pro.getPR_SXTYPE())+" ]]></PR_SXTYPE>");//
		proXml.append("<PR_ADDRESS><![CDATA["+getBASE64(pro.getPR_ADDRESS())+" ]]></PR_ADDRESS>");//
		proXml.append("<PR_TSTEL>"+pro.getPR_TSTEL()+"</PR_TSTEL>");//
		proXml.append("<PR_TSEMAIL>"+pro.getPR_TSEMAIL()+"</PR_TSEMAIL>");//
		proXml.append("<PR_BY><![CDATA["+getBASE64(pro.getPR_BY())+" ]]></PR_BY>");//
		proXml.append("<PR_AREA><![CDATA["+getBASE64(pro.getPR_AREA())+" ]]></PR_AREA>");//
		proXml.append("<PR_STUFF><![CDATA["+getBASE64(pro.getPR_STUFF())+" ]]></PR_STUFF>");//
		proXml.append("<PR_BLCX><![CDATA["+getBASE64(pro.getPR_BLCX())+" ]]></PR_BLCX>");//
		proXml.append("<PR_QT><![CDATA["+getBASE64(pro.getPR_QT())+" ]]></PR_QT>");//
		proXml.append("<PR_BC><![CDATA["+pro.getPR_BC()+" ]]></PR_BC>");//
		//如果有多份附件
		if(list.size()>0){
			for(int i=0;i<list.size();i++){
				NewProceedingModel prom = (NewProceedingModel)list.get(i);
				proXml.append("<attach>");
				proXml.append("<title><![CDATA["+prom.getAttachtitle()+"]]></title>");//附件主题
				proXml.append("<attachURL><![CDATA["+prom.getAttachURL()+"]]></attachURL>");//附件路径
				proXml.append("</attach>");
			}
		}
		return proXml.toString();
	}
	/**
	 * 同步办事事项调用苏顺机器人接口
	 * @param xmls
	 * @return
	 */
	private String runProceeding(String xmls){
		String results = "";
		try{
			SmartServiceSoap_BindingStub ssbs = (SmartServiceSoap_BindingStub)
                    new com.newproceeding.SmartServiceLocator().getSmartServiceSoap();
			results = ssbs.interface_Proceeding("admin", "123456", xmls);
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return results;
		
		
	}
	//htmlEncode
	public String htmEncode(String s)
	{
	        StringBuffer stringbuffer = new StringBuffer();
	        int j = s.length();
	        for(int i = 0; i < j; i++)
	        {
	            char c = s.charAt(i);
	            switch(c)
	            {
	            case 60: stringbuffer.append("<"); break;
	            case 62: stringbuffer.append(">"); break;
	            case 38: stringbuffer.append("&"); break;
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
	 * 记录日志
	 * @param pr_id 办事事项ID
	 * @param pr_name 办事事项
	 * @param log_levn 办事事项反馈
	 * @param log_success 办事事项日志成功与否的动作说明
	 */
	public void writeLog(String pr_id,String log_levn,String pr_name,String log_success){
		String log_descript = "";
		LogservicePd logservicepd = new LogservicePd();
		log_descript = "智能机器人在"+prosdf.format(new java.util.Date())+log_levn+" "+pr_id+"-"+pr_name;
		logservicepd.writeLog(log_levn,log_descript,log_success,"pudongps");
	}
	/**
	 * 将 String 进行 BASE64 编码 
	 * @param s 被传入的进行编码的字符串
	 * @return 返回编码后的字符串
	 */
	private static String getBASE64(String s) { 
		if (s == null) return null; 
		return (new sun.misc.BASE64Encoder()).encode( s.getBytes() ); 
	}
	/**
	 * 数据初始化
	 */
	private void startInit(){
		try{
			dCn = new CDataCn(); 
			dImpl = new CDataImpl(dCn);
			String sql = "select pr_id from tb_proceeding_new order by pr_edittime desc";
			initvector = dImpl.splitPage(sql,2700,1);
//			String abc[] = new String[]{"o3414","o3415","o3420","o3419","o3418","o3417","o3416","o928","o931","o930","o1586","o1584","o3421","o99","o2179","o1518","o1517","o1516","o1515","o1513","o1512","o3423","o3422","o555","o3462","o2490","o1571","o3493","o3687","o3610","o3168","o3149","o3146","o3145","o3144","o3142","o3141","o3140","o3132","o3131","o2917","o2916","o2915","o2914","o2913","o2912","o107","o106"};
//			if(abc.length>0){
//				for(int j=0;j<abc.length;j++)
//	            {
//					this.proceeding("add",abc[j],dImpl);
//					System.out.println(j);
//						
//					if(j%500==0){
//						dImpl.closeStmt();
//						dCn.closeCn();
//						//
//						dCn = new CDataCn(); 
//						dImpl = new CDataImpl(dCn);
//					}
//	            }
//			}
			
			if(initvector!=null){
				for(int j=0;j<initvector.size();j++)
	            {
					initcontent = (Hashtable)initvector.get(j);
					this.proceeding("add",CTools.dealNull(initcontent.get("pr_id")),dImpl);
					
					if(j%500==0){
						dImpl.closeStmt();
						dCn.closeCn();
						//
						dCn = new CDataCn(); 
						dImpl = new CDataImpl(dCn);
					}
	            }
			}
			System.out.println("--------数据初始化---------------over------------");
		}catch(Exception ex){
			ex.printStackTrace();
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
		
	}
	
	/**
	 * 需要同步的XMLS
	 * @param operater add|update|delete
	 * @param pr_id
	 * @return
	 */
	public void proceeding(String operater,String pr_id,CDataImpl dImpl){
		NewProceedingModel npm = new NewProceedingModel();
		
		ArrayList arrylist = new ArrayList();
		try{
			npsql = "select p.pr_id,p.cw_id,m.cw_name,p.sw_id,s.sw_name,p.pr_name,d.dt_name,p.pr_money,p.pr_timelimit,p.pr_isaccept,p.pr_url,to_char(p.pr_edittime,'yyyy-MM-dd') as pr_edittime,p.pr_telephone,p.pr_tstype,p.pr_sxtype" +
					",p.pr_address,p.pr_tstel,p.pr_tsemail,p.pr_by,p.pr_area,p.pr_stuff,p.pr_blcx,p.pr_qt,p.pr_bc from tb_proceeding_new p,tb_sortwork s,tb_commonproceed_new c,tb_commonwork m,tb_deptinfo d where  p.pr_id ='"+pr_id+"' and p.sw_id = s.sw_id and p.pr_id=c.pr_id(+) and c.cw_id = m.cw_id(+) and p.dt_id = d.dt_id";
			
			content  = dImpl.getDataInfo(npsql);
			if(content!=null)
			{
				npm.setPR_ID(CTools.dealNull(content.get("pr_id")));
				npm.setCW_ID(CTools.dealNull(content.get("cw_name")));
				npm.setSW_ID(CTools.dealNull(content.get("sw_name")));
				npm.setPR_NAME(CTools.dealNull(content.get("pr_name")));
				npm.setDT_NAME(CTools.dealNull(content.get("dt_name")));
				npm.setPR_MONEY(CTools.dealNull(content.get("pr_money")));
				npm.setPR_TIMELIMIT(CTools.dealNull(content.get("pr_timelimit")));
				npm.setPR_ISACCEPT(CTools.dealNull(content.get("pr_isaccept")));
				npm.setPR_URL("http://usercenter.pudong.gov.cn/website/workHall/workInfo.jsp?sj_dir=affairUpdate_new&pr_id="+CTools.dealNull(content.get("pr_id")+"&sxtype=bszn"));
				npm.setPR_EDITTIME(CTools.dealNull(content.get("pr_edittime")));
				npm.setPR_TELEPHONE(CTools.dealNull(content.get("pr_telephone")));
				npm.setPR_TSTYPE(CTools.dealNull(content.get("pr_tstype")));
				npm.setPR_SXTYPE(CTools.dealNull(content.get("pr_sxtype")));
				npm.setPR_ADDRESS(CTools.dealNull(content.get("pr_address")));
				npm.setPR_TSTEL(CTools.dealNull(content.get("pr_tstel")));
				npm.setPR_TSEMAIL(CTools.dealNull(content.get("pr_tsemail")));
				npm.setPR_BY(CTools.dealNull(content.get("pr_by")));
				npm.setPR_AREA(CTools.dealNull(content.get("pr_area")));
				npm.setPR_STUFF(CTools.dealNull(content.get("pr_stuff")));
				npm.setPR_BLCX(CTools.dealNull(content.get("pr_blcx")));
				npm.setPR_QT(CTools.dealNull(content.get("pr_qt")));
				npm.setPR_BC(CTools.dealNull(content.get("pr_bc")));
			}

			//attach
			npattachsql = "select pa_name,pa_path,pa_filename from tb_proceedingattach_new where pr_id = '"+CTools.dealNull(content.get("pr_id"))+"'";
			vector = dImpl.splitPage(npattachsql,20,1);
			if(vector!=null){
				for(int j=0;j<vector.size();j++)
	            {
					NewProceedingModel npmattach = new NewProceedingModel();
					attachcontent = (Hashtable)vector.get(j);
					npmattach.setAttachtitle(CTools.dealNull(attachcontent.get("pa_name")));
					npmattach.setAttachURL("http://usercenter.pudong.gov.cn/attach/prattach/"+CTools.dealNull(attachcontent.get("pa_path"))+"/"+CTools.dealNull(attachcontent.get("pa_filename")));
					
					arrylist.add(npmattach);
	            }
			}
			
			proxmls = this.proceedingXml(npm, arrylist);
			proxmls = "<root><operater>"+operater+"</operater>"+proxmls+"</root>";
			
			
			//html encode 编码
			proxmls = htmEncode(proxmls);
			//替换掉所有的<br>
			proxmls = proxmls.replaceAll("<br>", "");
			
			String isok = this.runProceeding(proxmls);
			
			if(!isNumeric(isok)){
				CFile.write("D:\\new\\proxmls_"+CTools.dealNull(content.get("pr_id"))+".xml", proxmls);
			}
			System.out.println("Result======"+CTools.dealNull(content.get("pr_id"))+"===="+isok);
			//记录日志
			//this.writeLog(CTools.dealNull(content.get("PR_ID")), isok, CTools.dealNull(content.get("PR_NAME"))+"--------"+operater, "");
			
		}catch(Exception ex){
			System.out.print(ex.toString());
		}
	}
	
	/**
	 * 判断是否为数字
	 */
	public static boolean isNumeric(String str){
		for (int i = 0; i < str.length(); i++){
		   if (!Character.isDigit(str.charAt(i))){
		    return false;
		   }
		}
		return true;
		}
	
	/**
	 * main
	 */
	public static void main(String args[]){
		NewProceedingService nps = new NewProceedingService();
		String operater = "add";
		String pr_id = "2520";
		nps.proceeding(operater, pr_id);
		//nps.startInit();
		System.out.println("----------over----------");
	}
}
