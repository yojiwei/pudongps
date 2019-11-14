<%@ include file="/website/include/import.jsp" %>
<%
	String ids=" and SJ_ID in(-1,20755,21905,20824,20826)";

	ids=CTools.MidStr(ids,"and SJ_ID in(",")");
	String[] idsArr=CTools.split(ids,",");
	int j=0;
	String sqlSpec="SJ_ID in(";
	for(int i=0;i<idsArr.length;i++)
	{
		String id=CTools.dealNull(idsArr[i]);
		if(!id.equals(""))
		{
			j++;
			sqlSpec+=id+",";
			if(j==800)
			{
				j=0;
				sqlSpec+=") or SJ_ID in(";
			}
		}
	}

	sqlSpec=" and ("+CTools.replace(sqlSpec+")",",)",")")+")";

	out.println(sqlSpec);

%>
