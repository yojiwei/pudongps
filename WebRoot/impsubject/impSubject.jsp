<%@ page language="java" pageEncoding="GBK"%> 
<%@include file="/website/include/import.jsp"%>
<%
	CDataCn dCn = null;
	CDataImpl dImpl = null;
	try{
	dCn = new CDataCn();
    dImpl = new CDataImpl(dCn);
	String sql = "";
	Vector vector = null;
	Hashtable content = null;
	String sj_dir = "";
	String sj_id = "";
	String sj_parent_id1 = request.getParameter("sj_id1");
	String sj_parent_id2 = request.getParameter("sj_id2");
	String sj_sequence =  request.getParameter("sj_sequence")==null?"0":request.getParameter("sj_sequence");
	String sj_sequence1 =  request.getParameter("sj_sequence1")==null?"44":request.getParameter("sj_sequence1");
	sql = "select sj_name,sj_dir,sj_acdid,sj_copytoid,sj_display_flag,sj_sequence from tb_subject where sj_parentid=(select sj_id from tb_subject where sj_dir='PNJ2006') and sj_sequence>"+sj_sequence+" and sj_sequence<"+sj_sequence1+" order by sj_sequence";
	out.print(sql);
	vector = dImpl.splitPageOpt(sql,request,50);
			if (vector != null) {
				for (int i=0;i<vector.size();i++)
				{
					content = (Hashtable)vector.get(i);
					dImpl.setTableName("tb_subject");
					dImpl.setPrimaryFieldName("sj_id");
					String sj_acdid1 = new String(""+dImpl.addNew());
					dImpl.setPrimaryKeyType(CDataImpl.PRIMARY_KEY_IS_NUMBER);
					dImpl.setValue("sj_name",content.get("sj_name")+"",CDataImpl.STRING);
					dImpl.setValue("sj_parentid",sj_parent_id1,CDataImpl.STRING);
					dImpl.setValue("sj_display_flag",content.get("sj_display_flag")+"",CDataImpl.STRING);
					dImpl.setValue("sj_copytoid",content.get("sj_copytoid")+"",CDataImpl.STRING);
					dImpl.setValue("sj_sequence",content.get("sj_sequence")+"",CDataImpl.STRING);
					dImpl.setValue("sj_dir",(content.get("sj_dir")+"").replaceAll("6","7"),CDataImpl.STRING);
					dImpl.update();
					dImpl.setTableName("tb_subject");
					dImpl.setPrimaryFieldName("sj_id");
					String sj_acdid2 = new String(""+dImpl.addNew());
					dImpl.setPrimaryKeyType(CDataImpl.PRIMARY_KEY_IS_NUMBER);
					dImpl.setValue("sj_name",content.get("sj_name")+"",CDataImpl.STRING);
					dImpl.setValue("sj_parentid",sj_parent_id2,CDataImpl.STRING);
					dImpl.setValue("sj_display_flag",content.get("sj_display_flag")+"",CDataImpl.STRING);
					dImpl.setValue("sj_sequence",content.get("sj_sequence")+"",CDataImpl.STRING);
					dImpl.setValue("sj_copytoid",content.get("sj_copytoid")+"",CDataImpl.STRING);
					dImpl.setValue("sj_acdid",sj_acdid1,CDataImpl.STRING);
					dImpl.setValue("sj_dir",(content.get("sj_dir")+"").replaceAll("J2006","2007"),CDataImpl.STRING);
					dImpl.update();
					dImpl.edit("tb_subject","sj_id",sj_acdid1);
					dImpl.setValue("sj_acdid",sj_acdid2,CDataImpl.STRING);
					dImpl.update();
					sql = "select sj_name,sj_dir,sj_acdid,sj_copytoid,sj_display_flag,sj_sequence from tb_subject where sj_parentid=(select sj_id from tb_subject where sj_dir='"+content.get("sj_dir")+"') order by sj_sequence";
					Vector vector1 = dImpl.splitPageOpt(sql,request,30);
					if (vector1!= null) {
							for (int j=0;j<vector1.size();j++)
							{
								Hashtable content1 = (Hashtable)vector1.get(j);
								dImpl.setTableName("tb_subject");
								dImpl.setPrimaryFieldName("sj_id");
								String sj_acdid3 = new String(""+dImpl.addNew());
								dImpl.setPrimaryKeyType(CDataImpl.PRIMARY_KEY_IS_NUMBER);
								dImpl.setValue("sj_name",content1.get("sj_name")+"",CDataImpl.STRING);
								dImpl.setValue("sj_parentid",sj_acdid1,CDataImpl.STRING);
								dImpl.setValue("sj_display_flag",content1.get("sj_display_flag")+"",CDataImpl.STRING);
								dImpl.setValue("sj_sequence",content1.get("sj_sequence")+"",CDataImpl.STRING);
								dImpl.setValue("sj_copytoid",content1.get("sj_copytoid")+"",CDataImpl.STRING);
								dImpl.setValue("sj_dir",(content1.get("sj_dir")+"").replaceAll("6","7"),CDataImpl.STRING);
								dImpl.update();
							}
				      }
					
				}
		 }
	out.print("导入成功！");
%>
<%
	}catch(Exception ex)
	{
		out.print("<br>"+ex);
	}
	finally
	{
		if(dImpl!=null)
		{
			dImpl.closeStmt();
		}
		if(dCn!=null)
		{
			dCn.closeCn();
		}
	}
%>