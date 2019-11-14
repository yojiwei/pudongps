<%@page contentType="text/html; charset=GBK"%>
<%@include file="/system/app/skin/head.jsp"%>
<%
        String GW_ID = "";
        String sql = "";
        String GW_NAME = "";
        String GW_SEQUENCE = "";
		String DT_ID = "";
        String actiontype="add";
		String ui_uid ="";
        //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn);
  CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
  ui_uid = mySelf.getMyUid();
        String strTitle="新增分类办事";
        GW_ID=CTools.dealString(request.getParameter("GW_ID"));
        if(!GW_ID.equals(""))
        {
                sql = "select * from tb_gasortwork where gw_id = '" + GW_ID + "'";
                Hashtable content = dImpl.getDataInfo(sql);
               if (content!=null)
                {
                 GW_NAME=content.get("gw_name").toString();
                 GW_SEQUENCE=content.get("gw_sequence").toString();
				 DT_ID=content.get("dt_id").toString();
                 actiontype="modify";
                 strTitle="修改分类办事";
	        }
         }
		  DT_ID = Long.toString(mySelf.getDtId());
	String sqlStr = "select * from tb_deptinfo where dt_iswork=1 order by dt_id";
    Vector vPage = dImpl.splitPage(sqlStr,request,100);
%>

<form action="SortWorkResult.jsp" method="post" name="formData">
	<table WIDTH="100%" CELLPADDING="0" BORDER="0" class="main-table">
		<tr>
			<td width="100%" align="left" valign="top" colspan="2">
				<table class="content-table" width="100%">
					<tr class="title1">
						<td align="center" colspan=2>
							<%=strTitle %>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr class="line-odd">
			<td width="30%" align="right">
				事项名称：
			</td>
			<td align="left">
				<input type="text" name="GW_NAME" value="<%=GW_NAME%>"
					class="text-line">
			</td>
		</tr>
		<tr class="line-even">
			<td align="right">
				所属单位：
			</td>
			<td align="left">
				<select class="select-a" name="commonWork">
					<%
						if(ui_uid.equals("admin")){
                        if (vPage!=null)
                        {
                                for(int i=0;i<vPage.size();i++)
                                {
                                        Hashtable content_dt = (Hashtable)vPage.get(i);
                                        String dt_id = content_dt.get("dt_id").toString();
                                        String dt_name = content_dt.get("dt_name").toString();
                                        %>
					<option value="<%=dt_id%>"
						<%if(dt_id.equals(DT_ID)) out.print("selected");%>>
						<%=dt_name%>
					</option>
					<%
                                }
                        }
					}
					else
						{
						sqlStr = "select dt_name from tb_deptinfo where dt_iswork=1 and dt_id="+DT_ID+" order by dt_id";
						vPage = dImpl.splitPage(sqlStr,request,100);
                        if (vPage!=null)
                        {
                                for(int i=0;i<vPage.size();i++)
                                {
                                        Hashtable content_dt = (Hashtable)vPage.get(i);
										%>
                                        <option value="<%=DT_ID%>"><%=content_dt.get("dt_name").toString()%>
										<%
								}
						}
						}
                        %>
				</select>
			</td>
		</tr>
		<tr class="line-odd">
			<td align="right">
				事项序号：
			</td>
			<td align="left">
				<input type="text" name="GW_SEQUENCE" value="<%=GW_SEQUENCE%>"
					class="text-line">
			</td>
		</tr>
		<tr class=title1>
			<td align=center colspan=2>
				<input type=submit name=b1 value="提交" class="bttn">
				&nbsp;
				<input type=reset name=b1 value="重填" class="bttn">
			</td>
		</tr>
	</table>
	<input type=hidden name=actiontype value=<%=actiontype%>>
	<input type=hidden name=GW_ID value=<%=GW_ID%>>
</form>

<%
dImpl.closeStmt();
dCn.closeCn();


} catch (Exception ex) {
	System.out.println(new java.util.Date() + "--"
			+ request.getServletPath() + " : " + ex.getMessage());
} finally {
	if(dImpl != null)
	dImpl.closeStmt();
	if(dCn != null)
	dCn.closeCn();
}
%>
<%@include file="/system/app/skin/bottom.jsp"%>
