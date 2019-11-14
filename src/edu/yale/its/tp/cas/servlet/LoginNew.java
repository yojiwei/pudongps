// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   Login.java

package edu.yale.its.tp.cas.servlet;

import edu.yale.its.tp.cas.auth.*;
import edu.yale.its.tp.cas.ticket.*;
import java.io.IOException;
import java.io.PrintStream;
import java.sql.ResultSet;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.*;

import com.util.CTools;

public class LoginNew extends HttpServlet {

private static final String TGC_ID = "CASTGC";
private static final String PRIVACY_ID = "CASPRIVACY";
private static final String SERVICE = "service";
private static final String RENEW = "renew";
private static final String GATEWAY = "gateway";
private GrantorCache tgcCache;
private ServiceTicketCache stCache;
private LoginTicketCache ltCache;
private AuthHandler handler;
private String loginForm;
private String xfloginForm;
private String wsbloginForm;
private String fwwbloginForm;
private String dajloginForm;
private String daxxbdloginForm;
private String gsbdloginForm;
private String gsjloginForm;
private String hbjloginForm;
private String nmtloginForm;
private String nmtbdloginForm;
private String xdloginForm;
private String genericSuccess;
private String serviceSuccess;
private String confirmService;
private String redirect;
private ServletContext app;

	public void init(ServletConfig servletconfig) throws ServletException {
		app = servletconfig.getServletContext();
		tgcCache = (GrantorCache) app.getAttribute("tgcCache");
		stCache = (ServiceTicketCache) app.getAttribute("stCache");
		ltCache = (LoginTicketCache) app.getAttribute("ltCache");
		try {
			String s = app.getInitParameter("edu.yale.its.tp.cas.authHandler");
			if (s == null)
				throw new ServletException(
						"need edu.yale.its.tp.cas.authHandler");
			handler = (AuthHandler) Class.forName(s).newInstance();
			if (!(handler instanceof TrustHandler)
					&& !(handler instanceof PasswordHandler))
				throw new ServletException("unrecognized handler type: " + s);
		} catch (InstantiationException instantiationexception) {
			throw new ServletException(instantiationexception.toString());
		} catch (ClassNotFoundException classnotfoundexception) {
			throw new ServletException(classnotfoundexception.toString());
		} catch (IllegalAccessException illegalaccessexception) {
			throw new ServletException(illegalaccessexception.toString());
		}
		loginForm = this.app.getInitParameter("edu.yale.its.tp.cas.loginNewForm");

	    xfloginForm = this.app.getInitParameter("edu.yale.its.tp.cas.xfloginForm");

	    wsbloginForm = this.app.getInitParameter("edu.yale.its.tp.cas.wsbloginForm");

	    fwwbloginForm = this.app.getInitParameter("edu.yale.its.tp.cas.fwwbloginForm");

	    dajloginForm = this.app.getInitParameter("edu.yale.its.tp.cas.dajloginForm");

	    daxxbdloginForm = this.app.getInitParameter("edu.yale.its.tp.cas.daxxbdloginForm");

	    gsbdloginForm = this.app.getInitParameter("edu.yale.its.tp.cas.gsbdloginForm");

	    gsjloginForm = this.app.getInitParameter("edu.yale.its.tp.cas.gsjloginForm");

	    hbjloginForm = this.app.getInitParameter("edu.yale.its.tp.cas.hbjloginForm");

	    nmtloginForm = this.app.getInitParameter("edu.yale.its.tp.cas.nmtloginForm");

	    nmtbdloginForm = this.app.getInitParameter("edu.yale.its.tp.cas.nmtbdloginForm");
	    
	    xdloginForm = this.app.getInitParameter("edu.yale.its.tp.cas.xdloginForm");
	    
		serviceSuccess = app
				.getInitParameter("edu.yale.its.tp.cas.serviceSuccess");// 跳转页面
		genericSuccess = app
				.getInitParameter("edu.yale.its.tp.cas.genericSuccess");// 服务器端成功页面
		confirmService = app
				.getInitParameter("edu.yale.its.tp.cas.confirmService");// 服务器端警告页面
		redirect = app.getInitParameter("edu.yale.its.tp.cas.redirect");// 跳转页面

		
		if (xdloginForm == null || nmtbdloginForm == null ||nmtloginForm == null ||hbjloginForm == null ||gsjloginForm == null ||gsbdloginForm == null ||daxxbdloginForm == null ||dajloginForm == null ||fwwbloginForm == null ||wsbloginForm == null ||xfloginForm ==null||loginForm == null || genericSuccess == null || redirect == null
				|| confirmService == null)
			throw new ServletException(
					"need edu.yale.its.tp.cas.loginForm, -genericSuccess, -serviceSuccess, -redirect, and -confirmService");
		else
			return;
	}

	public void doPost(HttpServletRequest httpservletrequest,
			HttpServletResponse httpservletresponse) throws ServletException,
			IOException {
		doGet(httpservletrequest, httpservletresponse);
	}

	public void doGet(HttpServletRequest httpservletrequest,
			HttpServletResponse httpservletresponse) throws ServletException,
			IOException {

		httpservletresponse.setHeader("Pragma", "no-cache");
		httpservletresponse.setHeader("Cache-Control", "no-store");
		httpservletresponse.setDateHeader("Expires", -1);
		Cookie acookie[] = httpservletrequest.getCookies();
		TicketGrantingTicket ticketgrantingticket = null;

		if (acookie != null) {
			for (int i = 0; i < acookie.length; i++) {
				if (!acookie[i].getName().equals("CASTGC"))// castgc
					continue;
				ticketgrantingticket = (TicketGrantingTicket) tgcCache
						.getTicket(acookie[i].getValue());
				if (ticketgrantingticket != null
						&& httpservletrequest.getParameter("renew") == null) {
					grantForService(httpservletrequest, httpservletresponse,
							ticketgrantingticket, httpservletrequest
									.getParameter("service"), false);
					return;
				}
			}
		}
		if (httpservletrequest.getParameter("service") != null
				&& httpservletrequest.getParameter("gateway") != null) {
			httpservletrequest.setAttribute("serviceId", httpservletrequest
					.getParameter("service"));
			app.getRequestDispatcher(redirect).forward(httpservletrequest,
					httpservletresponse);
			return;
		}
		if (handler instanceof TrustHandler) {
			String s = ((TrustHandler) handler).getUsername(httpservletrequest);
			if (s != null) {
				if (ticketgrantingticket == null)
					ticketgrantingticket = sendTgc(s, httpservletrequest,
							httpservletresponse);
				else if (!ticketgrantingticket.getUsername().equals(s)) {
					ticketgrantingticket.expire();
					ticketgrantingticket = sendTgc(s, httpservletrequest,
							httpservletresponse);
				}
				sendPrivacyCookie(httpservletrequest, httpservletresponse);
				grantForService(httpservletrequest, httpservletresponse,
						ticketgrantingticket, httpservletrequest
								.getParameter("service"), true);
				return;
			} else {
				throw new ServletException("unable to authenticate user");
			}
		}
		if ((handler instanceof PasswordHandler)
				&& httpservletrequest.getParameter("username") != null
				&& httpservletrequest.getParameter("password") != null
				&& httpservletrequest.getParameter("lt") != null)
			if (ltCache.getTicket(httpservletrequest.getParameter("lt")) != null) {
				// 用户登录验证--SamplHandler.java
				if (((PasswordHandler) handler).authenticate(
						httpservletrequest, httpservletrequest
								.getParameter("username"), httpservletrequest
								.getParameter("password"))) {
					if (ticketgrantingticket == null)
						ticketgrantingticket = sendTgc(httpservletrequest
								.getParameter("username"), httpservletrequest,
								httpservletresponse);
					else if (!ticketgrantingticket.getUsername().equals(
							httpservletrequest.getParameter("username"))) {
						ticketgrantingticket.expire();
						ticketgrantingticket = sendTgc(httpservletrequest
								.getParameter("username"), httpservletrequest,
								httpservletresponse);
					}
					sendPrivacyCookie(httpservletrequest, httpservletresponse);
					grantForService(httpservletrequest, httpservletresponse,
							ticketgrantingticket, httpservletrequest
									.getParameter("service"), true);
					return;
				}
				httpservletrequest.setAttribute(
						"edu.yale.its.tp.cas.badUsernameOrPassword", "账号或密码错误");
			} else {
				httpservletrequest.setAttribute(
						"edu.yale.its.tp.cas.badLoginTicket", "");
				System.out.println("Login.java: " + new Date()
						+ ": invalid login ticket from "
						+ httpservletrequest.getRemoteAddr());
			}
		httpservletrequest.setAttribute("edu.yale.its.tp.cas.service",
				httpservletrequest.getParameter("service"));
		try {
			String s1 = ltCache.addTicket();
			httpservletrequest.setAttribute("edu.yale.its.tp.cas.lt", s1);
		} catch (TicketException ticketexception) {
			throw new ServletException(ticketexception);
		}
		if ((httpservletrequest.getParameter("optype").equals("dxpd")) || (httpservletrequest.getParameter("optype").equals("pudongForum")))
	      this.app.getRequestDispatcher(this.loginForm).forward(httpservletrequest, 
	        httpservletresponse);
	    else if (httpservletrequest.getParameter("optype").equals("xf"))
	      this.app.getRequestDispatcher(this.xfloginForm).forward(httpservletrequest, 
	        httpservletresponse);
	    else if (httpservletrequest.getParameter("optype").equals("wsb"))
	      this.app.getRequestDispatcher(this.wsbloginForm).forward(httpservletrequest, 
	        httpservletresponse);
	    else if (httpservletrequest.getParameter("optype").equals("fwwb"))
	      this.app.getRequestDispatcher(this.fwwbloginForm).forward(httpservletrequest, 
	        httpservletresponse);
	    else if (httpservletrequest.getParameter("optype").equals("daj"))
	      this.app.getRequestDispatcher(this.dajloginForm).forward(httpservletrequest, 
	        httpservletresponse);
	    else if (httpservletrequest.getParameter("optype").equals("daxxbd"))
	      this.app.getRequestDispatcher(this.daxxbdloginForm).forward(httpservletrequest, 
	        httpservletresponse);
	    else if (httpservletrequest.getParameter("optype").equals("gsbd"))
	      this.app.getRequestDispatcher(this.gsbdloginForm).forward(httpservletrequest, 
	        httpservletresponse);
	    else if (httpservletrequest.getParameter("optype").equals("gsj"))
	      this.app.getRequestDispatcher(this.gsjloginForm).forward(httpservletrequest, 
	        httpservletresponse);
	    else if (httpservletrequest.getParameter("optype").equals("hbj"))
	      this.app.getRequestDispatcher(this.hbjloginForm).forward(httpservletrequest, 
	        httpservletresponse);
	    else if (httpservletrequest.getParameter("optype").equals("nmt"))
	      this.app.getRequestDispatcher(this.nmtloginForm).forward(httpservletrequest, 
	        httpservletresponse);
	    else if (httpservletrequest.getParameter("optype").equals("nmtbd"))
	      this.app.getRequestDispatcher(this.nmtbdloginForm).forward(httpservletrequest, 
	        httpservletresponse);
	    else if (httpservletrequest.getParameter("optype").equals("xd"))
		      this.app.getRequestDispatcher(this.xdloginForm).forward(httpservletrequest, 
		        httpservletresponse);
	}

	private void grantForService(HttpServletRequest httpservletrequest,
			HttpServletResponse httpservletresponse,
			TicketGrantingTicket ticketgrantingticket, String s, boolean flag)
			throws ServletException, IOException {
		try {
			if (s != null) {
				ServiceTicket serviceticket = new ServiceTicket(
						ticketgrantingticket, s, flag);
				String s1 = stCache.addTicket(serviceticket);// 产生Ticket
				// 保存开始
				Cookie cookie = new Cookie("casTicketYp", s1);
				// cookie.setSecure(true);//安全协议关闭
				cookie.setMaxAge(-1);
				httpservletresponse.addCookie(cookie);
				// 保存结束
				httpservletrequest.setAttribute("serviceId", s);
				httpservletrequest.setAttribute("token", s1);//
				if (!flag) {
					if (privacyRequested(httpservletrequest)) {
						app.getRequestDispatcher(confirmService).forward(
								httpservletrequest, httpservletresponse);
					} else {
						httpservletrequest.setAttribute("first", "false");
						app.getRequestDispatcher(serviceSuccess).forward(
								httpservletrequest, httpservletresponse);
					}
				} else {
					httpservletrequest.setAttribute("first", "true");
					app.getRequestDispatcher(serviceSuccess).forward(
							httpservletrequest, httpservletresponse);
				}
			} else {
				s = "http://sso.pudong.gov.cn:5203/success.jsp";
				ServiceTicket serviceticket = new ServiceTicket(
						ticketgrantingticket, s, flag);
				String s1 = stCache.addTicket(serviceticket);// 产生Ticket
				// 保存开始
				Cookie cookie = new Cookie("casTicketYp", s1);
				// cookie.setSecure(true);//安全协议关闭
				cookie.setMaxAge(-1);
				httpservletresponse.addCookie(cookie);
				// 保存结束
				// 保存服务器端用户登陆信息...可以不保存,判断是否登陆成功的页面会做登陆
				app.getRequestDispatcher(genericSuccess).forward(
						httpservletrequest, httpservletresponse);
			}
		} catch (TicketException ticketexception) {
			throw new ServletException(ticketexception.toString());
		}
	}

	private TicketGrantingTicket sendTgc(String username,
			HttpServletRequest httpservletrequest,
			HttpServletResponse httpservletresponse) throws ServletException {
		try {
			TicketGrantingTicket ticketgrantingticket = new TicketGrantingTicket(
					username);//s用户名
			String s1 = tgcCache.addTicket(ticketgrantingticket);
			Cookie cookie = new Cookie("CASTGC", s1);
			cookie.setSecure(true);
			cookie.setMaxAge(-1);
			cookie.setPath(httpservletrequest.getContextPath());
			httpservletresponse.addCookie(cookie);
			return ticketgrantingticket;
		} catch (TicketException ticketexception) {
			throw new ServletException(ticketexception.toString());
		}
	}

	private void sendPrivacyCookie(HttpServletRequest httpservletrequest,
			HttpServletResponse httpservletresponse) throws ServletException {
		if (httpservletrequest.getParameter("warn") != null) {
			Cookie cookie = new Cookie("CASPRIVACY", "enabled");
			cookie.setSecure(true);
			cookie.setMaxAge(-1);
			cookie.setPath(httpservletrequest.getContextPath());
			httpservletresponse.addCookie(cookie);
		} else if (privacyRequested(httpservletrequest)) {
			Cookie cookie1 = new Cookie("CASPRIVACY", "disabled");
			cookie1.setSecure(true);
			cookie1.setMaxAge(0);
			cookie1.setPath(httpservletrequest.getContextPath());
			httpservletresponse.addCookie(cookie1);
		}
	}

	private boolean privacyRequested(HttpServletRequest httpservletrequest) {
		Cookie acookie[] = httpservletrequest.getCookies();
		if (acookie != null) {
			for (int i = 0; i < acookie.length; i++)
				if (acookie[i].getName().equals("CASPRIVACY")
						&& acookie[i].getValue().equals("enabled"))
					return true;

		}
		return false;
	}

	public LoginNew() {
	}
}
