package com.website.filter;

import java.io.IOException;
import java.util.Arrays;
import java.util.Collection;
import java.util.Enumeration;
import java.util.Iterator;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.CTools;
/**
 * @date 2008-09-03
 * @author yaojiwei
 *
 */
public class ParameterFilter extends HttpServlet implements Filter {
	
	private FilterConfig filterConfig;
	private String paraName;
	private String paraValue;
	  
	public void init(FilterConfig filterConfig) throws ServletException {   
		this.filterConfig = filterConfig;  
		System.out.println("please come in !");
	}   
	
	public void doFilter(ServletRequest request, ServletResponse response,FilterChain filterChain) {   
		try {   
			HttpServletRequest httpRequest = (HttpServletRequest)request;
			HttpServletResponse httpResponse = (HttpServletResponse)response;
            boolean isValid = true;
            String kw = filterConfig.getInitParameter("keywords");
            if(kw!=null&&!kw.equals("")){
            	Collection col = Arrays.asList(kw.split(",")); 
            	Enumeration enu = httpRequest.getParameterNames();
            	label:
	            while(enu.hasMoreElements()){
					paraName = (String)enu.nextElement();
					paraValue = CTools.dealString(httpRequest.getParameter(paraName));
					paraValue.replaceAll("　", " ");//将全角空格替换为半角空格
					Iterator it = col.iterator();
					while(it.hasNext()){
						if((paraValue.toLowerCase()).indexOf((String)it.next())!=-1){
							isValid = false;
							break label;
						}
					}
	            }
            }
            if(isValid) {   
            	filterChain.doFilter(request, response);
            }else{
            	httpResponse.sendRedirect(filterConfig.getInitParameter("filtertopage"));
            }  
        } catch (IOException iox) {   
        	filterConfig.getServletContext().log(iox.getMessage());   
        } catch (ServletException e) {
			e.printStackTrace();
		}
    }   
  
    public void destroy() {
    	System.out.println("please go out !");
    }   

}
