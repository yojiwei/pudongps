package com.util;

/**
 * <p>Title: oa</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: popteach</p>
 * @author not attributable
 * @version 1.0
 */

import java.io.*;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.component.database.*;
import com.emailService.CASUtil;
import com.website.DateUtil;

public class test {
	private static String sm_nowtime = "";
    public test() {
    	new CDate();
        sm_nowtime = CDate.getNowTime();
    }
    
    public String getnowtime(){
    	return sm_nowtime;
    }
    public static void main(String [] args){
//        try {
//            FileInputStream fis = new FileInputStream(new File("G:\\bea\\user_projects\\mydomain\\applications\\DefaultWebApp\\attach\\prattach\\2003-09-0937087\\使锟斤拷锟斤拷锟斤拷f锟斤拷位锟角硷拷锟斤拷锟较憋拷.doc"));
//            FileOutputStream fos = new FileOutputStream(new File("g:\\test.doc"));
//
//            int c = fis.read();
//            while(c != -1){
//                fos.write(c);
//                c = fis.read();
//            }
//            fis.close();
//            fos.close();
//        }
//        catch (FileNotFoundException ex) {
//        }
//        catch (IOException ex) {
//        }
    	
    	//System.out.println("sm_nowtime===="+sm_nowtime);
    	
//    	String tt = "xianguo1212121.gif";
//    	if(tt.indexOf(".")>=0){
//    		tt = tt.substring(0,tt.indexOf("."));
//    	}else{
//    		tt = "xiaowei";
//    	}
//    	System.out.println(tt+"============");
    	
    	
//    	String abc = "123,456,789,012,345,678,901,";
//    	String aa[] = abc.split(",");
//    	for(int i=0;i<aa.length;i++){
//    		System.out.println(i+"--"+aa[i]);
//    	}
//    	String nonums[][] = {{"回","回执：","20"},{"权","公开权利人信息告知：","7"},{"征","权利人意见征询：","9"},{"补","补正告知：","16"},{"延","延期告知：","19"},{"答","答复：","4"},{"答","答复：","5"},{"答","答复：","6"},{"答","答复：","8"},{"答","答复：","10"},{"答","答复：","11"},{"答","答复：","12"},{"答","答复：","13"},{"答","答复：","14"},{"答","答复：","15"},{"答","答复：","18"}};
//    	for (int i = 0; i < nonums.length; i++) {
//    		System.out.println(nonums[i][0]+" ");
//    		System.out.println(nonums[i][1]+" ");
//    		System.out.println(nonums[i][2]+" ");
//    		System.out.println();
//		}
    	
//    	String aa = "123,456,789,012,234,567";
//    	for(int i=0;i<aa.split(",").length;i++){
//    		System.out.println(aa.split(",")[i]);
//    	}
    	
//    	Date myDate= CDate.toDate("2009-9-17 12:01:12");
//		int difDay=21;
//		GregorianCalendar   cal   =   (GregorianCalendar)Calendar.getInstance();   
//        cal.setTime(myDate); 
//        cal.add(5,   difDay);   
//        String difTime= CDate.getday(cal.getTime());
//    	System.out.println(cal.DAY_OF_MONTH+"-----------"+difTime);
    	
//        test tt = new test();
//        int cw_pass = (int)(Math.random()*1000000); 
        //System.out.println(cw_pass);
        
//        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//    	Calendar cal = Calendar.getInstance();
//    	Date nowtime = cal.getTime();
//    	Date votetimec = null;
//    	String ttt = "2009-10-15 10:59:23";
//		try {
//			votetimec = formatter.parse("2009-10-17 10:59:23");
//		} catch (ParseException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} 
//    	Date voteAddMinutec = DateUtil.addDate(votetimec,1);
//    	System.out.println(votetimec+"---"+voteAddMinutec);
        
        
//      DateFormat yqdf = DateFormat.getDateTimeInstance(DateFormat.DEFAULT,DateFormat.DEFAULT,Locale.CHINA);
//      Calendar cal = Calendar.getInstance();
//      SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
//      try{
//      cal.setTime(formatter.parse("2009-11-06"));
//      for (int i=0;i<5;i++) {
//	      cal.add(Calendar.DAY_OF_MONTH,1);
//	      String aa = yqdf.format(cal.getTime()).substring(0,yqdf.format(cal.getTime()).indexOf(" "));
//	      System.out.println(aa);
//      }
//      }catch(Exception ex){
//    	  ex.printStackTrace();
//      }
//      SimpleDateFormat formatter  = new SimpleDateFormat("yyyy-MM-dd HH:mm");//日期格式化
//      String sm_nowtime = CDate.getNowTime();//当前详细时间
//      String now_time = CDate.getThisday();//当前日期
//      String limit_truetime = now_time+" 11:00:00";
//      try{
//	      Date nowdate = formatter.parse(sm_nowtime);//当前详细时间  
//	      Date limitdate = formatter.parse(limit_truetime);//天气预报设定的具体时间
//	  	  System.out.println(nowdate+">>"+limitdate);
//	      if(nowdate.getTime()>=limitdate.getTime()){
//	  		  System.out.println(nowdate.getTime()+"---------"+limitdate.getTime());
//	  	  }else{
//	  		System.out.println(nowdate.getTime()+"========="+limitdate.getTime());
//	  	  }
//      }catch(Exception ex){
//    	  ex.printStackTrace();
//      }
        
//        Calendar c=Calendar.getInstance();
//		if(c.get(Calendar.DAY_OF_MONTH)<11){
//			c.add(Calendar.MONTH, -1);
//		}
//		System.out.println(c.get(Calendar.DAY_OF_MONTH)+"------------"+(c.get(Calendar.MONTH)+1));
    	
    	
//    	System.out.println("main " + test.exception());
//        System.out.println("over " + test.i);
    	
    	//String aa = "首页 > 信息公开 > 部门公开 > 政府部门 > 发改委（统计局、物价局） > 公开目录 > 业务 > 价格管理 > 新区行政事业性收费";
    	//String bb [] = aa.split(">");
    	//System.out.println(aa.replace("首页 > 信息公开 > 部门公开 > 政府部门 > ", ""));
    	
    	//new test().orderNumber();
    	String aa = "http://192.168.1.201/website/fts/SearchAll.aspx?q=%c6%d6%b6%ab";
    	String bb = "";
    	//aa = aa.substring(aa.indexOf("：")+1,aa.length());
    	//bb = aa.substring(aa.indexOf("=")+1,aa.length());
    	String regex = "\\s*|(\r\n)";
		String a = "dsfsfd<p><a href='#'>nihao</a>   shime</p>dfsfdsdfs";
		String pat="\\<p>(.+?)\\</p>";
		Pattern p = Pattern.compile(pat);
		Matcher m = p.matcher(a);
//		while (m.find()) {
//			System.out.println(m.group(1).replaceAll(regex, ""));
//		}
		String title = "名称：土地征收文件 内容描述：书面公开拟将申请人位于上海市浦东新区张江镇团结村北唐队唐家宅76号房屋所占集体土地变更为国有的土地征收法律文件及征地红线图和相关审批材料　补正内容：沪集宅（川沙）字第125242号《上海市农村宅基地使用证》，其中载明申请人房屋四至即“东至杨文忠住房，南至王秀宝住房，西至夏金土住房，北至夏兴（新）明住房”。浦建委房拆许字（2007）第48号《房屋拆迁许可证》载明四至范围“东申江路，西马家浜，南龙东大道，北东方花园和规划银柳路”。　　";
		//title = title.substring(title.indexOf("补正内容")+1,title.length());
		//System.out.println(title.substring(0,title.indexOf("补")));
		//System.out.println("pdrbj_ne1ws_picnews".indexOf("pdrbj_news"));
		String btitle = "";
		if(!"".equals(title)){
			btitle = title.substring(title.indexOf("：")+1,title.length());
			title = title.substring(0,title.indexOf("补"));
			btitle = "信息名称："+btitle+"　";
		}
		StringBuffer sb = new StringBuffer();
		sb.append("1");
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
//		try {
//			System.out.println("=========="+formatter.format(formatter.parse("2014-1-2")));
//		} catch (ParseException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		//System.out.println(decode(decode("%25E6%25B5%25A6%25E4%25B8%259C")));
		//System.out.println(encode("%E6%B5%A6%E4%B8%9C"));
		String content = "本人身份证丢失，目前不知道在哪里办理挂失？申请办理身份证丢失，申请重新办理的单位以及具体办理流程，谢谢！　补正内容：　已经完成补正，谢谢。　";
		String bcontent = "";
		String bcontent_ = "";
		if(!"".equals(content) && content.indexOf("补正内容：")>0){
			bcontent = content.substring(content.indexOf("补正内容：")+5,content.length());
			content = content.substring(0,content.indexOf("补正内容：")-1);//
			//bcontent_ = "申请的信息内容：" + bcontent;
			bcontent_ = bcontent;
		}
		System.out.println("bcontent_=============="+bcontent_);
		System.out.println("content=============="+content);
		
		char c = '文';
		int i = (int)c;
		//System.out.println(i);
		String ss=Integer.toHexString('文');
		//System.out.println(ss);
		
		
		
//		if(title.length()>5){
//			title = title.substring(0,title.indexOf("：")-5);
//		}
     	//System.out.println(title);
    	
    	//System.out.println(bb);
		//http://www.shyouth.net/html/shsxxhqnrxh/portal/index/index.htm
		String mms = "http://www.shyouth.net/html/shsxxhqnrxh/portal/index/index.htm";
		//int index = abc.LastIndexOf("\\", (abc.LastIndexOf("\\", abc.LastIndexOf("\\") - 1) - 1));
		String curl = "";
		curl = mms.substring(mms.lastIndexOf("/", mms.lastIndexOf("/",mms.lastIndexOf("/")-1)-1)+1,mms.lastIndexOf("/", mms.lastIndexOf("/") - 1));
		int cc = mms.indexOf("/");
		int aab = mms.indexOf("/",cc);
		//curl = mms.substring(mms.lastIndexOf("/"),mms.lastIndexOf("/")-1);
    	//System.out.println("curl=========="+curl);
    	
    	
    	String cul = "19";
    	String cull = "1,2,3,4,5,6,7,9,19,20,21,22,23,24,29";
    	//System.out.println("000000----mm"+cull.indexOf(cul));
    	String testS = "自身生活的需要,";
    	String s = testS.substring(testS.length()-1, testS.length()) ;
    	if(",".equals(s)){
	    	System.out.println(testS.lastIndexOf(",")+"testS=========,==="+testS.substring(0,testS.length()-1));
	    }else{
	    	System.out.println(testS.lastIndexOf(",")+"testS============"+testS.substring(0,testS.length()));
	    }
    	
    	int[] b = {15,10,6,};
		Random rand = new Random();
		int num = rand.nextInt(3);
		//System.out.println("抽奖======="+b[num]); 
    	String sss = "3不符合申请要求（申请内容不明确）";
    	String bbb = "不符合申请要求（申请内容不明确）";
    	System.out.println(sss+"ssss===="+bbb.replaceAll("\\d+",""));
    	
    	//拆分json
    	String jsontest = "|/jggf/userfiles/1/files/cms/article/2019/04/%E5%85%B3%E4%BA%8E%E5%B9%B3%E5%8F%B0%E9%A1%B5%E9%9D%A2%E6%A0%BC%E5%BC%8F%E9%94%99%E4%B9%B1%E9%97%AE%E9%A2%98%E5%A4%84%E7%90%86.docx|/jggf/userfiles/1/files/cms/article/2019/04/%E9%A1%B9%E7%9B%AE%E5%91%A8%E6%8A%A5-20190412-%E9%A1%B9%E7%9B%AE%E4%BA%A4%E4%BB%98%E4%B8%AD%E5%BF%83-%E5%A7%9A%E7%BA%AA%E4%BC%9F%20.doc";
    	List list = new ArrayList();
		String[] filess = jsontest.split("\\|");
		String filess_path = "";
		String filess_realpath = "";
		String filess_name = "";
		try{
		for(int mm=0;mm<filess.length;mm++){
			filess_realpath = filess[mm];
			filess_path = URLDecoder.decode(filess[mm],"UTF-8");
			filess_name = filess_path.substring(filess_path.lastIndexOf("/")+1,filess_path.length());
			list.add(0, filess_name);
			list.add(1, filess_realpath);
		}
		if(list.size()>0){
			for (int j = 0; j < list.size(); j++) {
				System.out.println(list.get(j));
			}
			
		}
		
		}catch(Exception ex){
			ex.printStackTrace();
		}
    	
    	
    	
    	
    	
    	
    }
    
    

      private static final String enc = "UTF-8";

      public static String decode(String msg)
      {
        if ((msg != null) && (!"".equals(msg.trim()))) {
          try {
            msg = URLDecoder.decode(msg, "UTF-8");
          } catch (UnsupportedEncodingException e) {

            e.printStackTrace();
          }
        }
        return msg;
      }
      
      public static String encode(String msg)
      {
        if ((msg != null) && (!"".equals(msg.trim()))) {
          try {
            //msg = URLDecoder.decode(msg, "UTF-8");
            msg = URLEncoder.encode(msg);
          } catch (Exception e) {

            e.printStackTrace();
          }
        }
        return msg;
      }
    
    //这里填写所需输出的斐波拉契数列的长度
    public  String getArrays(int count){
    	int [] fibonacci = new int[count];
    	for(int i=0;i<count;i++){
    		if(i < 2){
    			fibonacci[i] = 1;
    		}else{
    			fibonacci[i] = fibonacci[i-2] + fibonacci[i-1];
    		}
    	}
    	return java.util.Arrays.toString(fibonacci);
    }
    //冒泡排序
    public void orderNumber(){
    	int[] abc = {1,58,98,5,6,88,4, 9, 23, 1, 45, 27, 5, 2};
    	for(int i=0;i<abc.length-1;i++){
    		int temp = 0; 
    		boolean isExchanged = false; 
    		for(int j=abc.length-1;j>i;j--){
    			if(abc[j]-(abc[j-1])<0){
    				temp = abc[j];
    				abc[j] = abc[j-1];
    				abc[j-1] = temp;
    				isExchanged = true; 
    			}
    		}
    		if(!isExchanged){
    			break;
    		}
    	}
    	StringBuffer sb = new StringBuffer();
//    	for (int data : abc) 
//    	{
//    		sb.append(","+data);
//    	} 
    	System.out.println("冒泡排序后："+sb.toString());
    }
    
    
    public static String getMessageContent(String ma_id){
    	String content = "";
    	CDataCn dCn = null;
        CDataImpl dImpl = null;
        Hashtable msgTable = null;
        String messageSql = "select * from tb_message where ma_id='"+ma_id+"'";
        File testFile = null;
        try{
        	dCn = new CDataCn();
            dImpl = new CDataImpl(dCn);
            msgTable = dImpl.getDataInfo(messageSql);
            testFile = new File("D:\\backup\\messageContent.txt");
            if(msgTable != null){
            	content = CTools.dealNull(msgTable.get("ma_title"));
            	CFile.append(testFile,content);
            }
            System.out.println(content);
        }catch(Exception e){
        	System.out.println(e.getMessage());
        }
    	return content;
    }

    public byte[] getByteArray(String pa_id) {
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);

        String filePath = dImpl.getInitParameter("prattach_save_path");

        String sqlStr = "";
        String zipFile = "";
        String pa_path = "";
        try {
            if (!pa_id.equals("")) {
                sqlStr =
                    "select pa_filename,pa_path from tb_proceedingattach where pa_id='" +
                    pa_id + "'";
                Hashtable content = dImpl.getDataInfo(sqlStr);
                if (content != null) {
                    zipFile = new String(content.get("pa_filename").toString().
                                         getBytes("GBK"));
                    pa_path = content.get("pa_path").toString();
                    filePath += pa_path;
                }
            }

            dImpl.closeStmt();
            dCn.closeCn();

            // System.out.println(file);

            //file = CTools.iso2gb(file);

            OutputStreamWriter osw = new OutputStreamWriter(new
                FileOutputStream(new File("g:\\test.html")));
            osw.write(filePath + "" + zipFile);
            osw.close();

            File f = new File(filePath + "\\\\" + zipFile);
            byte[] bt = new byte[ (int) f.length()];

            FileInputStream fis = new FileInputStream(f);

            fis.read(bt);
            fis.close();
            System.out.println("read " + bt.length + " bytes");
            return bt;
        }
        catch (FileNotFoundException ex) {
            ex.printStackTrace();
        }
        catch (IOException ex) {
            ex.printStackTrace();
        }

        return null;
    }
    
    
    /**
	 * 判断是否是电话号码
	 * @param phone 用户手机号码
	 * @return true 正常手机号码 false 错误手机号码
	 */
	public boolean checkPhone(String phone){
        Pattern pattern = Pattern.compile("^13\\d{9}||15[0,1,8,9]\\d{8}$");
        Matcher matcher = pattern.matcher(phone);
        
        if (matcher.matches()){
            return true;
        }
        return false;
    }
	
	public static int i = 0;

    public static int exception(){
        try {
            throw new Exception();
        }catch(Exception e){
        	System.out.println(e.toString());
            return ++i;
        }finally{
            System.out.println("finally " + ++i);
            //return ++i; //行100
        }
    }


	
	
}