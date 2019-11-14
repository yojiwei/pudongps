<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/website/include/import.jsp"%>
<%//Update 20061231%>
<link rel="stylesheet" href="/website/include/main.css" type="text/css">
<title>文件下载 </title>
<table width="500" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>
             <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="133" ><img src="/website/images/barhead.gif" width="133" height="33" border="0"></td>
                <td background="/website/images/barbg.gif"><div align="right" class="gray-title">表格下载</div></td>
                <td width="36"><img src="/website/images/barbottom.gif" width="36" height="33" border="0"></td>
              </tr>
			</table>
		</td>
        </tr>
        <tr>
          <td>
						<!-- 开始 -->
						<iframe id=downFrm name=downFrm  style="width:0px;height:0px;"></iframe>
				   <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#E3E3E3">
					   <tr>
							<td width="8%" height="25" bgcolor="#FFFFFF" align=center>编号</td>
							<td width="50%" height="25" bgcolor="#FFFFFF" align=center>文件名</td>
							<td width="8%" height="25" bgcolor="#FFFFFF" align=center nowrap>下载</td>
					   </tr>
					<%
					String downPr_id = "";
					String downStr = "";

					downPr_id = CTools.dealString(request.getParameter("pr_id")).trim();
					downStr = "select pa_name,pa_id from tb_proceedingattach_new where pr_id='"+downPr_id+"'";
					CDataCn dCn = null;
					CDataImpl dImpl = null;
					try{
						dCn = new CDataCn();
						dImpl = new CDataImpl(dCn); 
					Vector downVPage = dImpl.splitPage(downStr,100,1);
					if (downVPage!=null)
					{
						for( int i=0;i<downVPage.size();i++)
						{
							Hashtable downContent = (Hashtable)downVPage.get(i);
					%>
					<tr height=25>
						<td height="25" bgcolor="#FFFFFF" align=center><%=i+1%></td>
						<td height="25" bgcolor="#FFFFFF"><%=downContent.get("pa_name").toString()%></td>
						<td align=center height="25" bgcolor="#FFFFFF">
							<A HREF="/website/include/downloadcc.jsp?pa_id=<%=downContent.get("pa_id").toString()%>" target="downFrm" title="下载该文件">
								<img class="hand" border="0" src="/website/images/pub.gif" title="下载" WIDTH="16" HEIGHT="16">
							</a>
						</td>
					</tr>
					<%
						}
					}
					else
					{
						%>
						<tr height=25>
							<td colspan="3" height="25" bgcolor="#FFFFFF" align="left">
								&nbsp;&nbsp;没有需要下载的表格！
							</td>
						</tr>
						<%
					}
						}
					catch(Exception e){
						//e.printStackTrace();
						out.print(e.toString());
					}
					finally{
					dImpl.closeStmt();
					dCn.closeCn(); 
					}
					%>
				</table>

			<!-- 结束 -->
		  </td>
     </tr>
    </table>
	</td>
 </tr>
</table><br>
<table width="500" border="0" align="center" cellpadding="1" cellspacing="3">
	<tr>
		<td colspan="2" align="left"><b>下载表格说明：</b></td>
	</tr>
	<tr>
		<td align="center" valign="top">1、</td>
		<td align="left">鼠标点击“下载”栏中的<img src="/website/images/pub.gif" WIDTH="16" HEIGHT="16" align="absmiddle">图标（如果遇到不能下载或是直接打开文件的情况，请使用下载工具下载或者鼠标右键<img src="/website/images/pub.gif" WIDTH="16" HEIGHT="16" align="absmiddle">图标后选择“目标另存为”）；</td>
	</tr>
	<tr>
		<td align="center" valign="top">2、</td>
		<td align="left">在弹出的提示框中选择“将文件保存到磁盘”，并进一步将表格（文件）保存到本机磁盘上（如桌面，c盘等）；</td>
	</tr>
	<tr>
		<td align="center" valign="top">3、</td>
		<td align="left">在本机打开已保存的表格（文件），依照说明填写，确认无误后点击左上角的“保存文件”；</td>
	</tr>
	<tr>
		<td align="center" valign="top">4、</td>
		<td align="left">回到正在申请办事的页面，点击“在线申请”。</td>
	</tr>
</table>



