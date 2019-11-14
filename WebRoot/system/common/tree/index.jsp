<%@page contentType="text/html; charset=GBK"%>
<%@ include file="/website/include/import.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title></title>
<%@include file="js.jsp"%>
</head>

<script type="text/javascript">
//向右边框架传递参数
function BrowseRight(id){
CurrentSelect(currentID,id);
//top.ContentFrame.location="../ArticleMain.jsp?ClassID="+ id;
}
</script>
<body>
<p style="padding-left:20px; padding-top:10px;margin:0;">上海浦东</p>
<ul>
<%@include file="tree.jsp"%>
</ul>
</body>
</html>
