package org.Tools;

import java.io.IOException;
import java.util.Enumeration;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
/**
 * 防止通过URL地址SQL注入
 * @author Administrator
 *
 */
public class URLfilter implements Filter{
	
	private static String web_xml_url;
	
	private static String forward;
	 
	/**
	 * URL防止SQL注入方法
	 * @param request
	 * @return true
	 */
	public static boolean UrlFile(HttpServletRequest request)
	{
		//
		String web_xml[]=web_xml_url.split("\\|");
		StringBuffer str;
		String st[];
		StringBuffer keyName;
		Enumeration enu=request.getParameterNames();
		
		while(enu.hasMoreElements())
		{
			keyName=new StringBuffer((String)enu.nextElement());
			if(request.getParameter(keyName.toString())!=null)
			{
				str=new StringBuffer(request.getParameter(keyName.toString()));
				for(int i1=0;i1<web_xml.length;i1++)
				{
					if(str.lastIndexOf(web_xml[i1])!=-1)
					{
						return false;
					}
				}
				
			}
			else if(request.getParameterValues(keyName.toString())!=null)
			{
				st=request.getParameterValues(keyName.toString());
				for(int i=0;i<st.length;i++)
				{
					for(int j=0;j<web_xml.length;j++)
					{
						if(st[i].lastIndexOf(web_xml[j])!=-1)
						{
							return false;
						}
					}
				}
			}
		}
		return true;
	}
	/**
	 * 
	 */
	public void destroy() {
		// TODO Auto-generated method stub
		
	}
	/**
	 * 
	 */
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		
		boolean boo=URLfilter.UrlFile((HttpServletRequest)request);
		if(boo==false)
		{
			request.getRequestDispatcher(forward).forward(request, response);
		}
		else
		{
			chain.doFilter(request, response);
		}
		// TODO Auto-generated method stub
		
	}
	/**
	 * 
	 */
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		this.web_xml_url=filterConfig.getInitParameter("sql");
		this.forward=filterConfig.getInitParameter("forward");
		System.out.println(web_xml_url);
		
	}
//	public static boolean sql_inj(String str) 
//	 {
//	    String inj_str = "'|and|exec|execute|insert|select|delete|update|count|*|%|chr|mid|master|truncate|char|declare|;|or|-|+|,|like";
//	    String inj_stra[] = inj_str.split("|");
//	    for (int i=0 ; i < inj_stra.length ; i++ )
//	    {
//	        if (str.indexOf(inj_stra[i])>=0)
//	        {
//	            return true;
//	        }
//	    }
//	    return false;
//	 }

	public static String getWeb_xml_url() {
		return web_xml_url;
	}

	public static void setWeb_xml_url(String web_xml_url) {
		URLfilter.web_xml_url = web_xml_url;
	}

	public static String getForward() {
		return forward;
	}

	public static void setForward(String forward) {
		URLfilter.forward = forward;
	}

	

}
