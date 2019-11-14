<%@ page contentType="text/html; charset=GBK" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>飞鱼编辑器之应用</title>
</head>
<script LANGUAGE="javascript" src="./common/common.js"></script>
<script type="text/javascript" src="editor/fckeditor.js"></script>

<body style="overflow-x:hidden;overflow-y:auto">
<form name="formData" enctype="multipart/form-data" method="post">
<table width="552" height="107" border="0">
  <tr>
    <td height="19">飞鱼秀编辑之应用</td>
  </tr>
  <tr>
    <td><textarea  name="pr_by"  value="1"  style="display:none;WIDTH: 100%; HEIGHT: 200px">原数据</textarea>	
	<IFRAME ID="eWebEditor1" src="/system/common/edit/eWebEditor.jsp?id=pr_by&style=standard" frameborder="0" scrolling="no" width="100%" height="200"></IFRAME>	&nbsp;</td>
  </tr>
</table>
</form>
</body>
<script type="text/javascript" for=window event=onload>
	eWebEditor1.setHTML(document.all.pr_by.value);
</script>
</html>
