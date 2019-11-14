<%
  int skinIndexBottom = 4;//Integer.parseInt(session.getAttribute("skin").toString());
  switch(skinIndexBottom)
  {
      case 1:
%>
<%@include file="skin1/bottom.jsp"%>
<%
      break;
    case 2:
%>
<%@include file="skin2/bottom.jsp"%>
<%
      break;
    case 3:
%>
<%@include file="skin3/foot.jsp"%>
<%
      break;
    case 4:
%>
<%@include file="skin4/bottom.jsp"%>
<%
      break;
  }
%>