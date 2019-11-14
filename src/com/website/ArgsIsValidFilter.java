package com.website;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
/**
 * 外域访问提交限制
 * @author Administrator
 *
 */
public class ArgsIsValidFilter{

	private static Log log = LogFactory.getLog(ArgsIsValidFilter.class);
	/**
	 * 注销
	 */
	public void destroy() {
	}
	/**
	 * 是否正常提交
	 * @return
	 * @throws IOException
	 * @throws ServletException
	 */
    public boolean istureValid(ServletRequest arg0,ServletResponse arg1) throws IOException, ServletException {
       HttpServletRequest request = (HttpServletRequest) arg0;
	   HttpServletResponse response = (HttpServletResponse) arg1;
	   String servername_str = request.getServerName();
	   String currentURI = request.getRequestURI();
	   Enumeration headerValues = request.getHeaders("Referer");
	   String tmpHeaderValue = "";
	   boolean isValid = true;
	   
	   // 指定需要跳过拦截的页面地址，如果需要新增，可直接在数组中添加。
	   // “建议”
	   String [] ignoreURIS={"/back/","/Info.jsp","/pzxx.jsp"};
	   while (headerValues.hasMoreElements()) {
	    // 得到完整的路径：如“http://www.domain.com.cn:8023/front/zwgk/zwgk.jsp?id=1283”
	    tmpHeaderValue = (String) headerValues.nextElement();
	   }
	  
	   if(log.isInfoEnabled()){
	    log.info(" 获得的参数url为: " + tmpHeaderValue );
	    log.info(" 系统取得的url为："+ currentURI);
	   }
	
	   if ("".equals(tmpHeaderValue)) {
	    isValid = false;
	    if(log.isInfoEnabled()){
	     log.info(" 获得的参数url为: empty");
	     log.info(" 系统取得的url为："+ currentURI);
	     log.info("系统提示：请求可能来自外域！"); 
	    }
	
	   } else {
	    if(log.isInfoEnabled()){
	     log.info("获得的参数长度为:"+tmpHeaderValue.length());
	    }
	    tmpHeaderValue = tmpHeaderValue.toLowerCase();
	    servername_str = servername_str.toLowerCase();
	
	    int len = 0;
	    if (tmpHeaderValue.startsWith("https://")) {
	     len = 8;
	    } else if (tmpHeaderValue.startsWith("http://")) {
	     len = 7;
	    }
	    
	    if(log.isInfoEnabled()){
	     log.info("截取前的字符串为：" + tmpHeaderValue );
	     log.info( "从第 " + len + " 位开始截取，截取长度为：" + servername_str.length());
	    }
	    String tmp = tmpHeaderValue.substring(len, servername_str.length() + len);
	    if(log.isInfoEnabled()){
	     log.info("截取后的字符串为：" + tmp);
	    }
	    if (tmp.length() < servername_str.length()) { // 长度不够
	     isValid = false;
	     if(log.isInfoEnabled()){
	      log.info("截取后的字符串长度不够,请求可能来自外域！");
	     }
	    } else if (!tmp.equals(servername_str)) {// 比较字符串（主机名称）是否相同
	     isValid = false;
	     if(log.isInfoEnabled()){
	      log.info("域名匹配失败，请求来自外域！");
	     }
	    }
	   }
  
   // 跳过指定需要拦截的页面地址
  /* for (String ignoreURI:ignoreURIS) {
    if(currentURI.contains(ignoreURI)){
     isValid=true;
     if(log.isInfoEnabled()){
      log.info("系统已跳过检查以下url："+currentURI);
     }
    }
   }*/
	   return isValid;
    }
    /**
     * 调用测试
     * @throws IOException
     * @throws ServletException
     */
    public void checkValid(ServletRequest arg0,ServletResponse arg1) throws IOException, ServletException{
	   if (!istureValid(arg0,arg1)) {
		    if(log.isInfoEnabled()){
		     log.info("系统提示信息：URL为跨域请求，即将重定向到首页。 ");
		    }
		    System.out.println("跳转到index.jsp");
		   } else {
		    System.out.println("继续往下走");
		   }
    }
    /**
     * 初始化
     * @param arg0
     * @throws ServletException
     */
	//public void init(FilterConfig arg0) throws ServletException {

	//}

}
