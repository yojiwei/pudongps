<%@include file="/system/app/skin/import.jsp"%>
<%@include file="/system/app/islogin.jsp"%>
<%

  int skinIndex= 4;//Integer.parseInt(session.getAttribute("skin").toString());
  switch(skinIndex)
  {
      case 1:
%>
<%@include file="skin1/head.jsp"%>
<%
      break;
    case 2:
%>

<%@include file="skin2/head.jsp"%>
<%
      break;
    case 3:
%>
<%@include file="skin3/head.jsp"%>
<%
      break;
    case 4:
%>
<%@include file="skin4/head.jsp"%>
<%
			break;
  }
%>
<script language="javascript" src="/system/include/common.js"></script>