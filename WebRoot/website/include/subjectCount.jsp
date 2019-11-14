
<%//Update 20061231
	if(!sj_dir.equals(""))  sqlStr = "update tb_subject set sj_countnum = sj_countnum+1 where sj_dir='" + sj_dir + "'";
	//out.println("update tb_subject set sj_countnum = sj_countnum+1 where sj_dir='" + sj_dir + "'");
	dImpl.executeUpdate(sqlStr);
%>