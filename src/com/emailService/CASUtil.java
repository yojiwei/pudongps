package com.emailService;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.util.CFile;
import com.util.CTools;
/**
 * 配置于服务器端单点登录有关类
 * @author yaojiwei
 * version 1.5
 * 20081107
 */
public class CASUtil {
	/**
	 * 本地测试方法
	 * @param userXml
	 * @param column
	 * @return
	 */
	private static String getUserColumnTest(String userXml,String column){
		String regBegin="<"+column+">";
		String regEnd="</"+column+">";
		String regC=regBegin+"([\\w\\W]*?)"+regEnd;
		String returnStr="";
		Pattern p = null;
		Matcher m = null;
		p = Pattern.compile(regC);// 找出行如<id>id</id>
		m = p.matcher(userXml);
		
		while (m.find()) {
			returnStr = m.group();
			//update by yo 20091103
//			if("CONTENT".equals(column)){
//				returnStr = returnStr.replaceAll("%", "");
//			}
			//update by yo 20091103
			returnStr=returnStr.replace(regBegin,"");
			returnStr=returnStr.replace(regEnd, "");
			
			try{
			    returnStr=URLDecoder.decode(returnStr,"utf-8");
			}catch(IllegalArgumentException ex){
				CFile.write("f:/logs/"+CTools.dealString(CASUtil.getUserColumn(userXml, "NETLVID")).trim()+".txt", userXml+"=="+column+"--");
				System.out.println("catch=="+ex.getMessage());
			}
			catch(UnsupportedEncodingException e){
				System.out.println("CASUtil:"+e.getMessage());
			}
			return returnStr;
		}
		return	returnStr;
	}
	/**
	 * 正式调用方法，需要解码
	 * @param userXml
	 * @param column
	 * @return YJW 
	 */
	public static String getUserColumn(String userXml, String column)
    {
        String regBegin = "<" + column + ">";
        String regEnd = "</" + column + ">";
        String regC = regBegin + "([\\w\\W]*?)" + regEnd;
        String returnStr = "";
        Pattern p = null;
        Matcher m = null;
        p = Pattern.compile(regC);
        m = p.matcher(userXml);
        if(m.find())
        {
            returnStr = m.group();
            returnStr = returnStr.replace(regBegin, "");
            returnStr = returnStr.replace(regEnd, "");
            try
            {
                returnStr = URLDecoder.decode(returnStr, "utf-8");
            }
            catch(IllegalArgumentException ex){
				CFile.write("f:/logs/"+CTools.dealString(CASUtil.getUserColumn(userXml, "NETLVID")).trim()+".txt", userXml+"=="+column+"--");
				System.out.println("catch=="+ex.getMessage());
			}
			catch(UnsupportedEncodingException e){
				System.out.println("CASUtil:"+e.getMessage());
			}
            return returnStr;
        } else
        {
            return returnStr;
        }
    }
	/**
	 * 反馈不用解码
	 * @param userXml
	 * @param column
	 * @return
	 */
	public static String getUserNoColumn(String userXml, String column)
    {
        String regBegin = "<" + column + ">";
        String regEnd = "</" + column + ">";
        String regC = regBegin + "([\\w\\W]*?)" + regEnd;
        String returnStr = "";
        Pattern p = null;
        Matcher m = null;
        p = Pattern.compile(regC);
        m = p.matcher(userXml);
        if(m.find())
        {
            returnStr = m.group();
            returnStr = returnStr.replace(regBegin, "");
            returnStr = returnStr.replace(regEnd, "");
            
            return returnStr;
        } else
        {
            return returnStr;
        }
    }
	
	public static void main(String[] args) {
		//String emailXml="<XML><DEPTINFO><DTID> &nbsp;</DTID><DTNAME>test333</DTNAME><DTPARENTID>1</DTPARENTID><DTSEQUENCE>0</DTSEQUENCE><DTACTIVEFLAG></DTACTIVEFLAG><DTISWORK>1</DTISWORK><UIACTION>add<UIACTION></DEPTINFO></XML>";
		String emailXmls = "<?xml version=\"1.0\" encoding=\"GBK\"?><BZNETLVENCFEEDBACK><NETLVID>o55447</NETLVID><NOTICETYPE></NOTICETYPE><CONTENT>受理告知单&#xd; &#xd;蒋红先生/女士：&#xd;    您好！&#xd;    2010年01月12日，我单位收到您（贵单位）提出的关于（我是原南汇惠南镇卫星东路113弄金汇广场二期业主，于2006年年初向上海灏达置业发展有限公司购买金汇广场二期房屋购房款于预售合同签定后都已付清。根据预售合同，该公司应于2006年7月30日之前办理产证及交房手续，但至今已四年，却仍未办理正式交房手续，也未进行物业移交。目前70%以上业主因需要已预先领取了装修钥匙入住该小区，但长期来因小区内无物业管理、无卫生清扫人员、无保安，给业主们带来诸多不便及不安全因素，小区内经常发生盗窃行为特别是由于迟迟无法办理房产证，业主孩子的就学问题也无法解决，我们曾多次通过电话与开放商联系，对方总是说快了快了，却一直没有明确答复。我们也不知道这一类事应找区里哪个部门帮助协调，万般无奈之下只能恳请区长能帮助我们协调处理此事，急盼答复，谢谢！开发商：上海灏达置业发展有限公司法人代表：季惠平开发商联系电话： 13817691696）的事项，编号为浦邮20101000000000210。&#xd;    经研究，我单位决定受理。&#xd;    根据《信访条例》第三十三条规定，我单位将在受理之日起60日内办结，并给予书面答复意见。如延期，将另行告知。在办理期间，您如需了解办理情况，可持本告知单（原件）和身份证明，到指定的查询接待场所查询。&#xd;    特此告知。&#xd; &#xd;上海市浦东新区建设和交通委员会&#xd;2010年6月03日</CONTENT><STATUS>2</STATUS></BZNETLVENCFEEDBACK>";
		System.out.println(getUserNoColumn(emailXmls, "CONTENT"));
	}
}
