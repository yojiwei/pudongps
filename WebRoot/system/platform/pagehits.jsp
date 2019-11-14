<%@ taglib uri="counter" prefix="counter" %>

<html>

<head><title>JSP Tag Library Counter Example</title></head>

<body bgcolor=#ffffff>
<p>
<font face="Helvetica">

<h2>JSP Counter</h2>

<counter:increment/>

<blockquote>

<font face="Helvetica" size=6 color=red>

<p> This page has been visited <counter:display/> times! 
<p> <a href="./pagehits.jsp">Click Here</a> to visit again!

</font>
</blockquote>

</body>

</html>
