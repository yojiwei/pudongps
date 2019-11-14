package com.webservise;

import java.io.*;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import org.w3c.dom.*;

import com.applyopenService.ApplyOpenSeService;
import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CBase64;
import com.util.CDate;
import com.util.CTools;
import com.util.TimeCalendar;

import javax.xml.parsers.*;

public class InfoOpenParseXml {

	/**
	 * 操作公文备案依申请公开处理系统数据
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		long lasting = System.currentTimeMillis();
		InfoOpenParseXml a =new InfoOpenParseXml();
		String xml = "<?xml version=\"1.0\" encoding=\"GBK\" ?><infoopen><systemname>%E6%B5%A6%E4%B8%9C%E9%97%A8%E6%88%B7%E7%BD%91%E4%B8%8A%E7%94%B3%E8%AF%B7%E5%85%AC%E5%BC%80 </systemname><sender>%E6%B5%A6%E4%B8%9C%E9%97%A8%E6%88%B7 </sender><sendtime>2009-12-29+12%3A45%3A02 </sendtime><messgaeid>1645 </messgaeid><operater>people </operater><name>%E9%BB%84%E6%B1%89%E7%9F%A5 </name><organ> </organ><papertype>%E8%BA%AB%E4%BB%BD%E8%AF%81 </papertype><papernumber>42900119780123331x </papernumber><address>%E8%8E%B1%E9%98%B3%E8%B7%AF817%E5%BC%8415%E5%8F%B7302%E5%AE%A4 </address><postalcode>200129 </postalcode><tel>13764281890 </tel><telother> </telother><peopleemail>huanghanzhi%40gmail.com </peopleemail><companyname> </companyname><companycode> </companycode><businesscard> </businesscard><deputy> </deputy><linkman> </linkman><companytel> </companytel><companytelother> </companytelother><companyemail> </companyemail><title>%E4%B8%8A%E6%B5%B7%E5%B8%82%E6%B5%A6%E4%B8%9C%E6%96%B0%E5%8C%BA%E8%8E%B1%E9%98%B3%E8%B7%AF817%E5%BC%8426%E5%8F%B7%E5%BB%BA%E8%AE%BE%E5%B7%A5%E7%A8%8B%E8%A7%84%E5%88%92%E8%AE%B8%E5%8F%AF%E8%AF%81%E7%9A%84%E5%BB%BA%E7%AD%91%E5%B7%A5%E7%A8%8B%E9%A1%B9%E7%9B%AE%E8%A1%A8%E5%8F%8A%E6%80%BB%E5%B9%B3%E9%9D%A2%E5%9B%BE </title><content><![CDATA[%E7%94%B3%E8%AF%B7%E8%8E%B7%E5%8F%96%E4%B8%8A%E6%B5%B7%E5%B8%82%E6%B5%A6%E4%B8%9C%E6%96%B0%E5%8C%BA%E8%8E%B1%E9%98%B3%E8%B7%AF817%E5%BC%8426%E5%8F%B7%EF%BC%88%E8%8E%B1%E9%87%91%E4%BD%B3%E5%9B%AD%E5%B0%8F%E5%8C%BA%E5%86%85%EF%BC%89%E7%9A%84%E5%BB%BA%E8%AE%BE%E5%B7%A5%E7%A8%8B%E8%A7%84%E5%88%92%E8%AE%B8%E5%8F%AF%E8%AF%81%E7%9A%84%E5%BB%BA%E7%AD%91%E5%B7%A5%E7%A8%8B%E9%A1%B9%E7%9B%AE%E8%A1%A8%E5%8F%8A%E6%80%BB%E5%B9%B3%E9%9D%A2%E5%9B%BE%E3%80%82 ]]></content><filecontent> </filecontent><filelength> </filelength><fileoldname> </fileoldname><filenewname> </filenewname><fileextension> </fileextension><catchnum>20091229120023860 </catchnum><purpose>%E6%9F%A5%E9%AA%8C%E8%87%AA%E8%BA%AB%E4%BF%A1%E6%81%AF%2C </purpose><remark><![CDATA[ ]]></remark><derate>yes </derate><free> </free><wennum> </wennum><offer>0 </offer><getmethod>0 </getmethod><dept>XB0 </dept></infoopen>";
		a.getInfoOpenXML(xml);
	}
	
	/**
	 * 插入XML 返回结果为 数字(接收信息的主键ID)表示 成功 其他失败
	 * @param xml
	 * @return   返回结果为 数字(接收信息的主键ID)表示 成功 其他失败
	 */
	public  String getInfoOpenXML(String xml){
		String resultStr="";//返回结果 数字成功
		try{
			DocumentBuilderFactory factory = DocumentBuilderFactory
					.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			InputStream iStream = new ByteArrayInputStream(xml.getBytes("GBK"));//转换成流
			Document doc = builder.parse(iStream);
			
			InfoOpenBean infoOpenBean = new InfoOpenBean();//网上申请信息公开实体
			NodeList nl = doc.getElementsByTagName("infoopen");
			if(nl.getLength()==1) {
				String thisTime = CDate.getNowTime();
				
				infoOpenBean.setSendtime(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("sendtime").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setSystemname(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("systemname").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setSender(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("sender").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setMessgaeid(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("messgaeid").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setSystemname(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("systemname").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setOperater(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("operater").item(0).getFirstChild().getNodeValue().trim()),"utf-8"));
				
				infoOpenBean.setName(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("name").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setOrgan(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("organ").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setPapertype(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("papertype").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setPapernumber(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("papernumber").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setAddress(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("address").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setPostalcode(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("postalcode").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setTel(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("tel").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setTelother(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("telother").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setPeopleemail(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("peopleemail").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				
				infoOpenBean.setCompanyname(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("companyname").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setCompanycode(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("companycode").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setBusinesscard(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("businesscard").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setDeputy(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("deputy").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setLinkman(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("linkman").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setCompanytel(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("companytel").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setCompanytelother(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("companytelother").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setCompanyemail(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("companyemail").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setTitle(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("title").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				
				//<![cdata[内容内容内容内容内容]]>
				String content = URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("content").item(0).getFirstChild().getNodeValue()).trim(),"utf-8");
				infoOpenBean.setContent(content);
				
				infoOpenBean.setFilecontent(doc.getElementsByTagName("filecontent").item(0).getFirstChild().getNodeValue());
				infoOpenBean.setFilelength(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("filelength").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setFileoldname(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("fileoldname").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setFilenewname(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("filenewname").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setFileextension(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("fileextension").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setFileId("");
				
					
				infoOpenBean.setCatchnum(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("catchnum").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				//新加
				infoOpenBean.setWennum(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("wennum").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setFree(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("free").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				
				
				infoOpenBean.setPurpose(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("purpose").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				
				//<![cdata[备注备注]]>
				String remark = URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("remark").item(0).getFirstChild().getNodeValue()).trim(),"utf-8");
				infoOpenBean.setRemark(remark);
				
				infoOpenBean.setDerate(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("derate").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setOffer(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("offer").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setGetmethod(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("getmethod").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				infoOpenBean.setDept(URLDecoder.decode(CTools.dealNull(doc.getElementsByTagName("dept").item(0).getFirstChild().getNodeValue()).trim(),"utf-8"));
				
				CDataCn cd=new CDataCn();
				CDataImpl cdI =new CDataImpl(cd);
				
				String sql1="select dt_id,dt_name from tb_deptinfo where dt_code='"+infoOpenBean.getDept()+"'" ;
				Hashtable intable = cdI.getDataInfo(sql1);
				String dDtid="";
				String dDtname="";
				if(intable!=null){
					dDtid = CTools.dealNull(intable.get("dt_id"));
					dDtname = CTools.dealNull(intable.get("dt_name"));
					if(dDtid.equals("") || dDtname.equals(""))return thisTime+"<dept>"+infoOpenBean.getDept()+"</dept>找不到对应的部门代码";
				}else return thisTime+"<dept>"+infoOpenBean.getDept()+"</dept>找不到对应的部门代码";
				if(infoOpenBean.getOperater().equals("people")){
					infoOpenBean.setOperater("0");
				}else if(infoOpenBean.getOperater().equals("company")){
					infoOpenBean.setOperater("1");
				}else{
					return thisTime+"<operater></operater>值应为: people或company";
				}
				if(infoOpenBean.getMessgaeid().equals("")){
				
					return thisTime+"<messageid></messageid>值应为:  空";
				}
				
				resultStr = insertInfoOpen(infoOpenBean).trim();
				//返回空代表插入公文备案数据库成功
				if(resultStr.equals(""))
					resultStr=infoOpenBean.getMessgaeid();
			}
		} catch (Exception e) {
			String result=CDate.getNowTime()+"网上申请信息公开数据传输--xml格式出错"+e.getMessage();
			return result;
		}
		
		return resultStr;
	}
	
	/**
	 * 插入数据库
	 * @param iobean
	 * @return 返回空字符表示插入成功,其他失败
	 */
	public String insertInfoOpen(InfoOpenBean bean){
		
		String keyId="";
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		String difTime = "";
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			dCn.beginTrans();
			String dt_id="";
			String dt_name="";
			String sql="select dt_id,dt_name from tb_deptinfo where dt_code='"+bean.getDept()+"'" ;
			System.out.println(sql);
			Hashtable intable = dImpl.getDataInfo(sql);
			if(intable!=null){
				dt_id=CTools.dealNull(intable.get("dt_id"));
				dt_name=CTools.dealNull(intable.get("dt_name"));
			}
			//判断此信息是否以存在,
			sql="select id from infoopen where infotitle='"+bean.getTitle()+"' and infoid='"+bean.getMessgaeid()+"'";
			intable = dImpl.getDataInfo(sql);
			
			if(intable==null){
			//表infoopen
			dImpl.setTableName("infoopen");
			dImpl.setPrimaryFieldName("id");
			keyId = String.valueOf(dImpl.addNew());
			dImpl.setValue("infoid",bean.getMessgaeid(),CDataImpl.INT);//门户系统里的信息主键
			
			dImpl.setValue("infotitle",bean.getTitle(),CDataImpl.STRING);//信息名称 
			dImpl.setValue("proposer",bean.getOperater(),CDataImpl.STRING);// 0 people为公民  1 company为公司
			dImpl.setValue("pname",bean.getName(),CDataImpl.STRING);//姓名
			dImpl.setValue("punit",bean.getOrgan(),CDataImpl.STRING);//工作单位
			dImpl.setValue("pcard",bean.getPapertype(),CDataImpl.STRING);//证件名称
			dImpl.setValue("pcardnum",bean.getPapernumber(),CDataImpl.STRING);//证件号码
			dImpl.setValue("paddress",bean.getAddress(),CDataImpl.STRING);//通信地址
			
			dImpl.setValue("pzipcode",bean.getPostalcode(),CDataImpl.STRING);//邮政编码
			dImpl.setValue("ptele",bean.getTel(),CDataImpl.STRING);//-联系电话 
			dImpl.setValue("pemail",bean.getPeopleemail(),CDataImpl.STRING);//emmail
			dImpl.setValue("ename",bean.getCompanyname(),CDataImpl.STRING);//-公司名　称
			dImpl.setValue("ecode",bean.getCompanycode(),CDataImpl.STRING);//公司代码
			dImpl.setValue("ebunissinfo",bean.getBusinesscard(),CDataImpl.STRING);//营业执照信息
			dImpl.setValue("edeputy",bean.getDeputy(),CDataImpl.STRING);//法人代表
			
			dImpl.setValue("elinkman",bean.getLinkman(),CDataImpl.STRING);//-联系人
			dImpl.setValue("etele",bean.getCompanytel(),CDataImpl.STRING);//联系电话
			dImpl.setValue("eemail",bean.getCompanyemail(),CDataImpl.STRING);//电子邮件
			dImpl.setValue("commentinfo",bean.getContent(),CDataImpl.STRING);//所需信息内容描述
			dImpl.setValue("flownum",bean.getCatchnum(),CDataImpl.STRING);//所需信息索取号 流水号
			dImpl.setValue("indexnum",bean.getWennum(),CDataImpl.STRING);//所需信息文号 新加*****
			dImpl.setValue("purpose",bean.getPurpose(),CDataImpl.STRING);//所需信息用途
			
			String ischarge="0";
			if(bean.getDerate().equals("yes"))ischarge="1";
			else if(bean.getDerate().equals("no"))ischarge="0";
			
			dImpl.setValue("ischarge",ischarge,CDataImpl.INT);//是否申请减免费用  0 no不申请  1 yes申请 
			dImpl.setValue("free",bean.getFree(),CDataImpl.STRING);// 申请减免费用 如:12  新加
			dImpl.setValue("step","2",CDataImpl.INT);// 申请的默认为2 直接为审批 如:12  新加
			String offermode=bean.getOffer();
			dImpl.setValue("offermode",offermode,CDataImpl.STRING);//所需信息的制定提供方式  用逗号隔开 如 纸面,电子邮件,  0,1,
			String gainmode=bean.getGetmethod();
			dImpl.setValue("gainmode",gainmode,CDataImpl.STRING);//获取信息方式 用逗号隔开 如 邮寄,快递,
			dImpl.setValue("signmode","0",CDataImpl.INT);//网上申请为0
			dImpl.setValue("did",dt_id,CDataImpl.INT);//部门ID
			dImpl.setValue("dname",dt_name,CDataImpl.STRING);//部门
			dImpl.setValue("flownum",bean.getCatchnum(),CDataImpl.STRING);//流水号
			dImpl.setValue("status","1",CDataImpl.INT);//状态：0认领中心）、1处理中、2已结束通过、3处理结束不通过
			dImpl.setValue("applytime",bean.getSendtime(),CDataImpl.DATE);//发送时间
			dImpl.setValue("isspot","0",CDataImpl.INT);//是否当场受理 0不是
			dImpl.setValue("isrunit","0",CDataImpl.INT);//"0"; //是否由当事人直接向职能单位提出申请
			dImpl.setValue("applymode","1",CDataImpl.INT);////处理方式，1收件，2代办，0由申请人另行申请
			
			//获取办理期限日期  15个工作日
	        difTime = getfifteenday(dImpl,bean.getSendtime());
	        
			dImpl.setValue("limittime",difTime,CDataImpl.DATE);//超时相关
			dImpl.setValue("olimittime",difTime,CDataImpl.DATE);//超时相关
			
			dImpl.setValue("memo",bean.getRemark(),CDataImpl.STRING);//备注
			dImpl.setValue("systemname",bean.getSystemname(),CDataImpl.STRING);//系统标识
			dImpl.setValue("sender",bean.getSender(),CDataImpl.STRING);//系统标识
			dImpl.update();
			
			//表taskcenter
			dImpl.setTableName("taskcenter");
			dImpl.setPrimaryFieldName("id");
			dImpl.addNew();
			dImpl.setValue("iid",keyId,CDataImpl.INT);//备注
			dImpl.setValue("did",dt_id,CDataImpl.INT);//部门ID
			dImpl.setValue("dname",dt_name,CDataImpl.STRING);//部门
			dImpl.setValue("starttime",bean.getSendtime(),CDataImpl.DATE);//备注
			dImpl.setValue("commentinfo",bean.getContent(),CDataImpl.STRING);//系统标识
			dImpl.setValue("status","0",CDataImpl.INT);//系统标识
			dImpl.setValue("genre","网上申请",CDataImpl.STRING);//系统标识
			dImpl.update();
			
			if(!(bean.getFilenewname().trim()).equals("")){//有附件
				dImpl.setTableName("tb_publishattach");
				dImpl.setPrimaryFieldName("pa_id");
				dImpl.addNew();
				dImpl.setValue("io_id",keyId,CDataImpl.INT);//信息公开主键
				dImpl.setValue("pa_name",bean.getFileoldname(),CDataImpl.STRING);//
				dImpl.setValue("pa_filename",bean.getFilenewname(),CDataImpl.STRING);//
				int numeral = 0;
				numeral =(int)(Math.random()*100000);
				String pa_path = CDate.getThisday()+ Integer.toString(numeral);
				dImpl.setValue("pa_path",pa_path,CDataImpl.STRING);
				
				String localPath=this.getClass().getResource("/").getPath();
				localPath = URLDecoder.decode(localPath);//转换编码 如空格
				localPath = localPath.substring(1,localPath.lastIndexOf("WEB-INF"));
				localPath+="attach/infoattach/"+pa_path+"/";//目录
				java.io.File newDir = new java.io.File(localPath);
				if(!newDir.exists())//生成目录
				{
				  newDir.mkdirs();
				}
				localPath+=bean.getFilenewname();//文件地址
				CBase64.saveDecodeStringToFile(bean.getFilecontent(),localPath);//生成文件
				dImpl.update();
			}
			
		}
			
		if(dCn.getLastErrString().equals("")){
			dCn.commitTrans();
			
		//调用依申请公开报送到上海市接口 update by yo 20100127
		ApplyOpenSeService aoss = new ApplyOpenSeService();
		aoss.sendShInfoopen("Ad",keyId);
		//调用依申请公开报送到上海市接口 update by yo 20100127
			
		}else{
			dCn.rollbackTrans();
			return "信息公开插入出错,";
		}
		
		
		
		}
		catch(Exception e){
			return "信息公开插入出错,";
		}
		finally{
			dImpl.closeStmt();
			dCn.closeCn(); 
		}
		return "";
	}
	/**
	 * 获取15日之后
	 * @param dImpl
	 * @param startTime
	 * @return
	 */
	public String getfifteenday(CDataImpl dImpl,String startTime){
		SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
		String yqdf_limittime = "";
		Hashtable yqdf_content = null;
		String strSql = "";
		try{
			startTime = ft.format(ft.parse(startTime));
			strSql = "select * from (select rownum,hd_date,hd_flag,dense_rank() over(order by hd_date) rank from tb_holiday where hd_date > to_date('"+startTime+"','yyyy-MM-dd') and hd_flag = 0 order by hd_date ) where rank = 15";
			yqdf_content = dImpl.getDataInfo(strSql);
			if (yqdf_content != null)
			{
				yqdf_limittime = CTools.dealNull(yqdf_content.get("hd_date"));//0工作日1节假日
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return yqdf_limittime;
	}
	
	/**
	 * 产生流水号
	 * @param applytime
	 * @param dImpl
	 * @return
	 */
	public String flownum(String applytime,CDataImpl dImpl){
		//项目流水号获取 YYYY+MM+DD+24HH+3位序号+3位随机号
		String flownum="";
		DateFormat df = DateFormat.getDateTimeInstance(DateFormat.DEFAULT,DateFormat.DEFAULT,Locale.CHINA);

		Calendar calendar = GregorianCalendar.getInstance();


		java.text.DecimalFormat l2 = new java.text.DecimalFormat("00");
		java.text.DecimalFormat l3 = new java.text.DecimalFormat("000");

		flownum += Integer.toString(calendar.get(Calendar.YEAR));
		flownum += l2.format(calendar.get(Calendar.MONTH)+1);
		flownum += l2.format(calendar.get(Calendar.DATE));
		if (calendar.get(Calendar.AM_PM) == 1)
		{
		  flownum += l2.format(calendar.get(Calendar.HOUR) + 12);
		}
		else 
		{
		  flownum += l2.format(calendar.get(Calendar.HOUR));
		}

		String countNumSql = "select count(*) as countnum from infoopen where to_date(to_char(applytime,'yyyy-mm-dd'),'yyyy-mm-dd') = to_date('"+ applytime+"','YYYY-MM-DD')";
		Hashtable countCon = dImpl.getDataInfo(countNumSql);
		if (countCon != null)
		{
		  flownum +=  l3.format(Integer.parseInt(countCon.get("countnum").toString()) + 1);
		}

		Random rnd=new Random();   
		for(int i=0;i<3;i++) {
			flownum += Integer.toString((int)(rnd.nextFloat()*10));
		}
		return flownum;
		
	}
}
