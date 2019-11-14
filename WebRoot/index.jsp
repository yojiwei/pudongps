<%@page contentType="text/html; charset=GBK"%>
<%@ include file="/website/include/import.jsp" %>

<%//Update 20061231
	String domain=request.getRequestURL().toString().toLowerCase();
	String redirectPath="",title="";
	if (domain.indexOf("www.chuansha.gov.cn")!=-1) 
	{
		redirectPath="http://61.129.65.86/chuansha/index.jsp";
		title="川沙功能区域";
	}

	if (domain.indexOf("credit.pudong.gov.cn")!=-1) 
	{
		redirectPath="http://61.129.65.86/website/credit/index.jsp";
		title="浦东诚信";
	}
	
	if (domain.indexOf("dangwu.pudong.gov.cn")!=-1) 
	{
		redirectPath="http://61.129.65.86/dwgk/index.jsp";
		title="党务公开专网";
	}
	
	if (domain.indexOf("english.pudong.gov.cn")!=-1) 
	{
		redirectPath="http://61.129.65.86/english/index.jsp";
		title="Pudong";
	}
	
	if (domain.indexOf("kuaiji.pudong.gov.cn")!=-1) 
	{
		redirectPath="http://61.129.65.86/kuaiji/index.jsp";
		title="浦东会计";
	}
	
	if (domain.indexOf("news.pudong.gov.cn")!=-1) 
	{
		redirectPath="http://61.129.65.86/website/pudongNews/index.jsp";
		title="浦东新闻";
	}

	if (domain.indexOf("www.pscsp.gov.cn")!=-1) 
	{
		redirectPath="http://61.129.65.86/publicservice/index.jsp";
		title="浦东市民中心";
	}
	
	if (domain.indexOf("zhoubao.pudong.gov.cn")!=-1) 
	{
		redirectPath="http://61.129.65.86/pudongWeekly/index.jsp";
		title="浦东周报";
	}
	
	if (domain.indexOf("csr.pudong.gov.cn")!=-1) 
	{
		redirectPath="http://61.129.65.86/csr/index.jsp";
		title="浦东新区企业社会责任网";
	}
	
	if (domain.indexOf("www.shpdxf.gov.cn")!=-1) 
	{
		redirectPath="http://service.pudong.gov.cn/connonline/index.jsp";
		title="浦东新区网上信访（投诉）中心";
	}

	if (domain.indexOf("bbs.pudong.gov.cn")!=-1) 
	{
		redirectPath="http://61.129.65.86/website/pudongForum/index.jsp";
		title="浦东论坛";
	}
	
	if (domain.indexOf("17.pudong.gov.cn")!=-1) 
	{
		redirectPath="http://61.129.65.86/pd17da/index.jsp";
		title="浦东十七大";
	}
	
	if (domain.indexOf("quanli.pudong.gov.cn")!=-1) 
	{
		redirectPath="http://61.129.65.86:8229/qlgk/index.html";
		title="浦东新区权力公开专网";
	}
	
	if (domain.indexOf("lujiazui.pudong.gov.cn")!=-1) 
	{
		redirectPath="http://61.129.65.86/lgw/index.jsp";
		title="陆家嘴功能区域";
	}
	
	if (domain.indexOf("jinqiao.pudong.gov.cn")!=-1) 
	{
		redirectPath="http://61.129.65.86/jinqiao/index.jsp";
		title="金桥功能区域";
	}
	
	if (domain.indexOf("chuansha.pudong.gov.cn")!=-1) 
	{
		redirectPath="http://61.129.65.86/chuansha/index.jsp";
		title="川沙功能区域";
	}
	
	if (domain.indexOf("waigaoqiao.pudong.gov.cn")!=-1) 
	{
		redirectPath="http://61.129.65.86/waigaoqiao/index.jsp";
		title="外高桥功能区域";
	}
	
	if (domain.indexOf("zhangjiang.pudong.gov.cn")!=-1) 
	{
		redirectPath="http://61.129.65.86/zhangjiang/index.jsp";
		title="张江功能区域";
	}
	
	if (domain.indexOf("sanlin.pudong.gov.cn")!=-1) 
	{
		redirectPath="http://61.129.65.86/sanlin/index.jsp";
		title="三林世博功能区域";
	}
	
	if (domain.indexOf("dangjian.pudong.gov.cn")!=-1) 
	{
		redirectPath="http://61.129.65.86/pddjw/index.jsp";
		title="浦东党建";
	}
	//
	if (domain.indexOf("fwwb.pudong.gov.cn")!=-1) 
	{
		redirectPath="http://61.129.65.86/fwwb/index.jsp";
		title="浦东服务外包网";
	}
	
	if (domain.indexOf("hudong.gov.cn")!=-1) 
	{
		redirectPath="http://61.129.65.86/hdxcjd/index.jsp";
		title="浦东新区沪东街道";
	}
	
	if (domain.indexOf("service.pudong.gov.cn")!=-1) 
	{
		redirectPath="http://service.pudong.gov.cn/website/workHall/index.jsp";
		title="上海 · 浦东";
	}

	if (domain.indexOf("sbxf.pudong.gov.cn")!=-1) 
	{
		redirectPath="http://service.pudong.gov.cn/website/pddjwbbs/login.jsp";
		title="浦东党建网论坛";
	}

	if(redirectPath==""||redirectPath.equals(""))
		response.sendRedirect("website/index.jsp");
	else
	{
%>
<html>
<head>
<title><%=title%></title>
<meta content="text/html; charset=GBK" http-equiv=Content-Type>
<frameset border=false frameborder=0 framespacing=0 rows=0,* >
<frame marginheight=0 marginwidth=0 name=refresh noResize scrolling=no src="#">
<frame name=hl8 src="<%=redirectPath%>" scrolling="auto" noresize >
<noframes>
<body topmargin="0" leftmargin="0"><!--msnavigation-->
<p>This page uses frames, but your browser doesn't support them  .</p>
</body>
</noframes></frameset></html>
<%}%>
