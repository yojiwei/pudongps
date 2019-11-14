<%
//Update 20061231
String _WEBSTART = "http://" + request.getServerName();
if (request.getServerPort() != 80) { 
_WEBSTART += ":" + request.getServerPort();
}
%>