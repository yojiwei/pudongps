<?xml version="1.0" encoding="GBK" ?> 
<%@ page import="com.component.database.*" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.util.*,java.util.Hashtable"%>
<Root>
<%
  //update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); //新建数据接口对象

String code =  CTools.dealString(request.getParameter("code"));

Hashtable map =  dImpl.getDataInfo("select dd_id,dd_name from tb_datatdictionary where dd_code ='"+code+"'");

String sql  = "";
String dd_id="";
String dd_name = "";
String dd_desc = "";
String dd_englishName = "";
java.util.Vector vec = new java.util.Vector();
if(map!=null){
	 dd_id = map.get("dd_id").toString();
	 dd_name = map.get("dd_name").toString();
	 sql = " select dd_id as id,dd_name as name,1 as flag,dd_code as code,dd_sequence as sequence,dd_showflag as showflag,"
	 	 + " dd_desc as desc1,dd_englishname as englishname from tb_datatdictionary where dd_parentid = '"+ dd_id + "' "     
	 	 + " union select dv_id as id, dv_value as name,2 as flag,'' as code,dv_sequence as sequence,dd_showflag as showflag,"
	 	 + " dv_desc as desc1,dd_englishname as englishname from tb_datavalue where dd_id = " + dd_id ;
	 if("country_1".equals(code))
		 sql += " order by sequence,name,showflag,flag";
	 else
		 sql += " order by sequence,id,showflag,flag";
	 vec = dImpl.splitPage(sql,request,100);

}else{
dd_name = "没有该数据字典";

}

%>

	<TreeNode Title="<%=dd_name%>" > 
		
		<%
			if(vec!=null){
				for(int i = 0 ;i< vec.size();i++){
					Hashtable vecMap  = (Hashtable)vec.get(i);
					String id= vecMap.get("id").toString();
					String name= vecMap.get("name").toString();
					String flag= vecMap.get("flag").toString();
					String showFlag = vecMap.get("showflag").toString();
					dd_desc = vecMap.get("desc1").toString();
					if(vecMap.get("englishname") != null)
						dd_englishName = vecMap.get("englishname").toString();
					if(flag.equals("1")){
					
						String 	vecsql = " select dd_id as id,dd_name as name,1 as flag,dd_code as code,dd_sequence as sequence,dd_showflag as showflag,  "
									 	 + " dd_desc as desc1,dd_englishname as englishname from tb_datatdictionary where dd_parentid = '"+ id + "' "     
									 	 + " union select dv_id as id, dv_value as name,2 as flag,'' as code,dv_sequence as sequence,dd_showflag as showflag, "
									 	 + " dv_desc as desc1,dd_englishname as englishname from tb_datavalue where dd_id = " + id ;
						if("country_1".equals(code))
							vecsql += " order by sequence,name,showflag,flag";
						else
							vecsql += " order by sequence,id,showflag,flag";
						java.util.Vector vecVe =  dImpl.splitPage(vecsql,1000,1);
						if(vecVe!=null){
						%>
							<TreeNode Title="<%=name%>" >
						<%
							for(int j = 0 ;j< vecVe.size();j++){
								Hashtable vecVECMap  = (Hashtable)vecVe.get(j);
								String vecid= vecVECMap.get("id").toString();
								String vecname= vecVECMap.get("name").toString();
								String vecflag= vecVECMap.get("flag").toString();
								String dd_desc1 = vecVECMap.get("desc1").toString();
								String vecShowFlag = "";
								if(vecVECMap.get("showflag") != null)
									vecShowFlag = vecVECMap.get("showflag").toString();
								String vecEnglishName = "";
								if(vecVECMap.get("englishname") != null)
									vecEnglishName = vecVECMap.get("englishname").toString();
								%>
								<TreeNode Title="<%=vecname%>" Href="<%=vecname%>" Cont="<%= dd_desc1%>" EnglishName="<%= vecEnglishName%>" ShowFlag='<%= vecShowFlag%>'/> 
								<%
							}
							%>
							</TreeNode>
							<%
						}else{
							%>
							<TreeNode Title="<%=name%>" Href="<%=name%>" Cont="<%= dd_desc%>" EnglishName="<%= dd_englishName%>" ShowFlag='<%= showFlag%>'/> 
							<%
						}
					}else{
						%>
						<TreeNode Title="<%=name%>" Href="<%=name%>" Cont="<%= dd_desc%>" EnglishName="<%= dd_englishName%>" ShowFlag='<%= showFlag%>'/> 
						<%
					
					}
					
				}
			
			
			
			}
		%>
		
	</TreeNode>
</Root>

<% dCn.closeCn();%>
<%


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