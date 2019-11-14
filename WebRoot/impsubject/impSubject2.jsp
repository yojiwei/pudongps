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
	String sj_sequence =  request.getParameter("sj_sequence")==null?"0":request.getParameter("sj_sequence");
	String sj_sequence1 =  request.getParameter("sj_sequence1")==null?"0":request.getParameter("sj_sequence1");
	sql = "select sj_name,sj_dir,sj_acdid,sj_copytoid,sj_display_flag,sj_sequence from tb_subject where sj_parentid=(select sj_id from tb_subject where sj_dir='PNJ2007') and sj_sequence>"+sj_sequence+" and sj_sequence<"+sj_sequence1+" order by sj_sequence";
	String sql1 = "select sj_id,sj_name,sj_dir,sj_acdid,sj_copytoid,sj_display_flag,sj_sequence from tb_subject where sj_parentid=(select sj_id from tb_subject where sj_dir='PN2007') and sj_sequence>"+sj_sequence+" order by sj_sequence";
	out.println(sql);
    out.println(sql1);
	vector = dImpl.splitPageOpt(sql,request,50);
	Vector vector1 = dImpl.splitPageOpt(sql1,request,50);
			if (vector != null) {
				for (int i=0;i<vector.size();i++)
				{
					content = (Hashtable)vector.get(i);
					Hashtable content1 = (Hashtable)vector1.get(i);
					sql = "select sj_id,sj_name,sj_dir,sj_acdid,sj_copytoid,sj_display_flag,sj_sequence from tb_subject where sj_parentid=(select sj_id from tb_subject where sj_dir='"+content.get("sj_dir")+"') order by sj_sequence";
					Vector vector2 = dImpl.splitPageOpt(sql,request,30);
					if (vector2!= null) {
							for (int j=0;j<vector2.size();j++)
							{
								Hashtable content3 = (Hashtable)vector2.get(j);
								dImpl.setTableName("tb_subject");
								dImpl.setPrimaryFieldName("sj_id");
								String sj_acdid4 = new String(""+dImpl.addNew());
								dImpl.setPrimaryKeyType(CDataImpl.PRIMARY_KEY_IS_NUMBER);
								dImpl.setValue("sj_name",content3.get("sj_name")+"",CDataImpl.STRING);
								dImpl.setValue("sj_parentid",content1.get("sj_id")+"",CDataImpl.STRING);
								dImpl.setValue("sj_display_flag",content3.get("sj_display_flag")+"",CDataImpl.STRING);
								dImpl.setValue("sj_sequence",content3.get("sj_sequence")+"",CDataImpl.STRING);
								dImpl.setValue("sj_acdid",content3.get("sj_id")+"",CDataImpl.STRING);
								dImpl.setValue("sj_copytoid",content3.get("sj_copytoid")+"",CDataImpl.STRING);
								dImpl.setValue("sj_dir",(content3.get("sj_dir")+"").replaceAll("j07","07"),CDataImpl.STRING);
								dImpl.update();
								dImpl.edit("tb_subject","sj_id",content3.get("sj_id")+"");
								dImpl.setValue("sj_acdid",sj_acdid4,CDataImpl.STRING);
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