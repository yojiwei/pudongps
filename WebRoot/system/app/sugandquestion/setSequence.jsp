<%@ page contentType="text/html; charset=GBK" %>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@page import="com.util.*"%>
<%@page import="com.website.DataOper" %>

<%
	/*
	String list_id;
	boolean t ;
    list_id = CTools.dealNumber(request.getParameter("list_id")).trim();;
    CDataCn  dCn = new CDataCn();
    CDataImpl jdo = new CDataImpl(dCn);
    jdo.setTableName("tb_suggest");
    jdo.setPrimaryFieldName("sg_id");
    t = jdo.setSequence("module","sg_sequence",request);
	dCn.closeCn();
    response.sendRedirect("SuggestionList.jsp?sj_id="+list_id);
    */
    
       Hashtable ht = new Hashtable();
       Enumeration  enu =  null; 
       enu = request.getParameterNames();
       while(enu.hasMoreElements()) {
    	   String sg_name =    (String)enu.nextElement();
    	   String new_sg_sequence  =  request.getParameter(sg_name);
    	   if(new_sg_sequence != null && !"".equals(new_sg_sequence)) {
			   if (ht.get(sg_name) != null) {
				   ht.remove(sg_name);
			   	   ht.put(sg_name,new_sg_sequence);
			   }
			   else {
			   	   ht.put(sg_name,new_sg_sequence);
			   }
    	   }
       }    
       
       DataOper dataOper = new DataOper();
       dataOper.setSql(" update tb_suggest ");
       dataOper.doUpdate(ht,"sg_sequence","sg_id");
	   response.sendRedirect("SuggestionList.jsp");
       		
%>
