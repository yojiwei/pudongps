<%@page contentType="text/html; charset=GBK"%>
<%
String strTitle = "计数器";
%>
<%@include file="/system/app/skin/head.jsp"%>
<br>

<table class="main-table" width="100%">
	<tr class="title1" align=center>
		<td colspan="3">
			网站页面访问量统计
		</td>
	</tr>
	<tr class="line-even">
		<td width="200" align="center">
			统计页面
		</td>
		<td width="100" align="center">
			点击数
		</td>
		<td></td>
	</tr>
	<tr class="line-even">
		<td align="center">
			浦东会计首页
		</td>
		<td align="center">
			<%
				//显示网站点击率
				CDataCn codCn = null;
				try {
					codCn = new CDataCn();
					CCount cCo = new CCount(codCn, "kuaijiIndex");
					//CCount cCo = new CCount(codCn,"home");
					out.println(cCo.getCount());
					codCn.closeCn();
				} catch (Exception ex) {
					System.out.println(new java.util.Date() + "--"
					+ request.getServletPath() + " : " + ex.getMessage());
				} finally {

					if (codCn != null)
						codCn.closeCn();
				}
				//显示网站点击率结束
			%>
		</td>
		<td></td>
	</tr>
	<!--tr class="title1" align="center">
    <td colspan="3"><input type="button" value="返回" class="bttn" onclick="javascript:history.go(-1)"></td>
  </tr-->
</table>
<%@include file="/system/app/skin/bottom.jsp"%>
