package cas.jsp;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Hashtable;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CDate;
import com.util.CTools;

public class CASFilter extends HttpServlet implements Filter {

	/**
	 * 用于配置在服务器端的单点登录的Filter
	 * @date 20081031
	 * @author yaojiwei
	 */
	private FilterConfig filterConfig;

	public CASFilter() {
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
	}

	public void doFilter(ServletRequest httpRequest,
			ServletResponse httpResponse, FilterChain filterChain){
		HttpServletRequest request = (HttpServletRequest)httpRequest;
		HttpServletResponse response = (HttpServletResponse)httpResponse;
		
		try {
			String casUid = "";
			HttpSession session = request.getSession();
			if (session.getAttribute("casUid") != null)
				casUid = session.getAttribute("casUid").toString();
			
			String MyServer = "";
				MyServer = request.getRequestURL().toString();
			
			if (casUid.equals(""))// 如果session里没有casUid, 进去
			{
				if (request.getQueryString() != null)
					MyServer += "?" + request.getQueryString();
				String ticket = "";
				if (request.getParameter("ticket") != null)
					ticket = request.getParameter("ticket").toString();
				if (ticket.equals(""))// 如果参数里的ticket为空,去服务端取,如果不存在就会返回ticket为no
				{
					MyServer = URLEncoder.encode(MyServer);// 编码转换
					String ticketUrl = filterConfig
							.getInitParameter("cas.ticketUrl")//在本服务器端取票据
							+ "?" + "service=" + MyServer;
					response.sendRedirect(ticketUrl);
					return;
				}
				// 如果参数里的ticket不为空;服务端 存放在session里的ticket不为空也不为no,去服务端取用户信息
				if (!ticket.equals("no")) {
					MyServer = URLEncoder.encode(MyServer);// 编码转换
					String validateUrl = filterConfig
							.getInitParameter("cas.validate")//在本服务器端验证
							+ "?ticket=" + ticket + "&" + "service=" + MyServer;
					URL url = new URL(validateUrl);
					InputStream reader = url.openConnection().getInputStream();
					BufferedReader dis=new BufferedReader(new InputStreamReader(reader,"utf-8"));   
					 String   str   =   null;                           
					 StringBuffer sb =new StringBuffer();   
					 while((str =dis.readLine())!=null){
						 sb.append(str);
					 }
					String resp =sb.toString();
					System.out.println(CDate.getNowTime()+" = CAS接收的用户信息: "+resp);
					reader.close();
					if (CASUtil.getUserColumn(resp, "success").equals("yes")) { // 验证成功
						
						session.setAttribute("casUid", CASUtil.getUserColumn(resp, "uid")); // 保存用户登录的US_UID
						session.setAttribute("casTicket", ticket);// 保存当前Ticket
						// 在服务器端用户登陆开始...
						String user_ID="";
						String sql_getUser="";
						CDataCn dCn = null;
						CDataImpl dImpl = null;
						Hashtable hash = null;
						try{
							dCn = new CDataCn();
							dImpl = new CDataImpl(dCn);
							//应该是服务器端用户表
							sql_getUser = "select us_id from  tb_user where us_uid = '"+ CASUtil.getUserColumn(resp, "uid")+"' ";
							hash= dImpl.getDataInfo(sql_getUser);
							//说明服务器端已经登录成功
							if(hash!=null)  
							{
								user_ID = CTools.dealNull(hash.get("us_id"));
							}else{
								//服务器端没有此用户--新增
							}
							//保存用户登录信息开始......
							session.setAttribute("us_id",user_ID);
							//保存用户登录信息结束......
						}catch (Exception e) {
							System.out.println("CASFilter:做用户登陆出错--"+e.getMessage());
						}
						finally{
							dImpl.closeStmt();
							dCn.closeCn(); 
						}
						//在服务器端用户登陆结束...
						
					} else { // 验证不成功,去服务端登陆
						String loginurl = filterConfig
								.getInitParameter("cas.login")//在本服务器端登录
								+ "?" + "service=" + MyServer;
						response.sendRedirect(loginurl);
						return;
					}
				} else {// 如果URL里也没有ticket,ticket为no,服务端存放在session里也没有ticket;去服务端登陆
					if (MyServer.indexOf("?ticket=no") != -1)
						MyServer = MyServer.replaceAll("\\?ticket=no", "");// 去掉为no的ticket,如果有的话
					else if (MyServer.indexOf("&ticket=no") != -1)
						MyServer = MyServer.replaceAll("&ticket=no", "");// 去掉为no的ticket,如果有的话
					
					MyServer = URLEncoder.encode(MyServer);// 编码转换
					String loginurl = filterConfig
							.getInitParameter("cas.login") //在本服务器端登录
							+ "?" + "service=" + MyServer;
					response.sendRedirect(loginurl);
					return;
				}

			}
   
			filterChain.doFilter(request, response);
		} catch (IOException iox) {
			filterConfig.getServletContext().log(iox.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 销毁
	 */
	public void destroy() {
	}

}
