<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="../../manage/head.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<%@include file="../../common/tree/js.jsp"%>
</head>

<script type="text/javascript">
//向右边框架传递参数
function BrowseRight(id){
	CurrentSelect(currentID,id);
	var value=GetTitle(id);
	var url = "publishList.jsp?sj_id="+id+"&node_title="+value;
	parent.frames("main").location.href = url;
}
</script>
<body>
<p style="padding-left:20px; padding-top:10px;margin:0;">上海浦东</p>
<%@include file="../../common/tree/tree.jsp"%>
</body>
</html>
