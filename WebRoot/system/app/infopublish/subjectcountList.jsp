<%@page contentType="text/html; charset=GBK"%>
<%
String strTitle = "信息报送";
%>

<%@ include file="../skin/head.jsp"%>
<%
	//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	
	String sj_parentid = CTools.dealString(request.getParameter("sj_parentid"));
	
	
	String sqlWhere  = "";
	String [] sjName = null;
	String [] sjCount = null;
	String [] sjId = null;
	Vector vectorPage= null;
	if(!sj_parentid.equals(""))
	{
		sqlWhere = " and sj_parentid='" + sj_parentid + "' ";
		
		String sql = "select sj_id,sj_name from tb_subject where sj_parentid='" + sj_parentid + "' order by sj_sequence";
		//out.println(sql);
		vectorPage = dImpl.splitPage(sql,request,100);
		
		Hashtable contentMain = new Hashtable();
		Hashtable contentSub = new Hashtable();
		if(vectorPage!=null){
			sjName = new String[vectorPage.size()];
			sjCount = new String[vectorPage.size()];
			sjId = new String[vectorPage.size()];
			for(int i=0;i<vectorPage.size();i++){
				contentMain = (Hashtable)vectorPage.get(i);
				sjName[i]=contentMain.get("sj_name").toString();
				sjId[i] = contentMain.get("sj_id").toString();
				contentSub = dImpl.getDataInfo("select sum(sj_countnum) as count from ( select sj_countnum from tb_subject where sj_id in (select sj_id from tb_subject connect by prior sj_id=sj_parentid start with sj_id = '" + contentMain.get("sj_id").toString() + "' ))");
				//out.println("select sum(sj_countnum) as count from ( select sj_countnum from tb_subject where sj_id in (select sj_id from tb_subject connect by prior sj_id=sj_parentid start with sj_id = '" + contentMain.get("sj_id").toString() + "' ))");
				sjCount[i]=contentSub.get("count").toString();
			}
		}
	}
	
	//out.print(sql);
      
%>

<table class="content-table" width="100%">
		      
   
         <tr class="bttn">
            <td width="100%" class="outset-table" colspan="6"><b>栏目浏览人数统计</b></td>
                
        </tr>
		<%if(vectorPage==null){
		%>
			 <tr class="bttn">
				<td width="100%" class="outset-table" colspan="6"><b>该栏目下没有子栏目！</b></td>
                
			</tr>
		<%
		}
		else{%>
        <tr class="bttn">
        	<!--td width="6%" class="outset-table"><b>排名</b></td-->
            <td width="50%" class="outset-table"><b>栏目名称</b></td>
            <td width="50%" class="outset-table"><b>浏览数</b></td>
          
        </tr>
<%
 
    if(sjName!=null){

	for(int j=0;j<sjName.length;j++)
    {
      if(j % 2 == 0)  out.print("<tr class=\"line-even\">");
      else out.print("<tr class=\"line-odd\">");
%>

                <!--td align="center"--><%//=(j+1)%><!--/td-->
                <td ><a href='?sj_parentid=<%=sjId[j]%>'><%=sjName[j]%></a></td>
                <!-- td align="center"></td -->
                <td align="center"><%=sjCount[j]%></td>
            </tr>
<%
    }
	}
		}
%>
</form>

</table>

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
<%@ include file="../skin/bottom.jsp"%>
