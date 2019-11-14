// Source File Name:   GetTicket.java

package edu.yale.its.tp.cas.servlet;

import edu.yale.its.tp.cas.ticket.*;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.*;
import javax.servlet.http.*;

public class GetTicket extends HttpServlet {

	private static final String TGC_ID = "CASTGC";
	private ServletContext app;
	private GrantorCache tgcCache;

	public void init(ServletConfig servletconfig) throws ServletException {
		app = servletconfig.getServletContext();
		tgcCache = (GrantorCache) app.getAttribute("tgcCache");
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String service = null;
		String serviceId = "";
		//¿Í»§¶ËURL
		if (request.getParameter("service") != null) {
			serviceId = request.getParameter("service");
			String ticket = "";
			Cookie acookie[] = request.getCookies();
			if (acookie != null) {
				for (int i = 0; i < acookie.length; i++) {
					if (acookie[i].getName().equals("casTicketYp")) {
						ticket = acookie[i].getValue();
						break;
					}
				}
			}
			if (ticket.equals(""))
				ticket = "no";
			if (serviceId.indexOf('?') == -1)
				service = serviceId + "?ticket=" + ticket;
			else
				service = serviceId + "&ticket=" + ticket;
			
			//System.out.println("GetTicket From Server = " + ticket);
			//System.out.println("Client's Service = " + service);
		}

		response.sendRedirect(service);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	public GetTicket() {
	}

	public void distory() {
		super.destroy();
	}
}
