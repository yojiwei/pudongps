<%
	//out.print("1");if(true)return;
	String staticHtmlUrl=""+request.getRequestURI();
	String[] staticHtmlFilterFileName={"testindex.jsp","listkfzhAll.jsp","index22.jsp","content_iframe.jsp","workInfo.jsp","InfoContent.jsp","content.jsp","workList.jsp","InfoList.jsp","ListInfo.jsp","vote.jsp"};
	boolean staticHtmlNeedProcess=false;
	for(int staticHtmlIndex=0;staticHtmlIndex<staticHtmlFilterFileName.length;staticHtmlIndex++)
	{
		if(staticHtmlUrl.toLowerCase().indexOf(staticHtmlFilterFileName[staticHtmlIndex].toLowerCase())!=-1) staticHtmlNeedProcess=true;
	}

	//用户中心和后台不处理
	if(staticHtmlUrl.toLowerCase().indexOf("usercenter")!=-1 || staticHtmlUrl.toLowerCase().indexOf("system")!=-1) staticHtmlNeedProcess=false;

	//out.print("<11111"+staticHtmlNeedProcess+">");

	if(request.getMethod().equals("GET") && staticHtmlNeedProcess)
	{
		String staticHtmlFullUrl="",staticHtmlFileName="",staticHtmlFilePath="",staticHtmlSTemp="";
		//out.print("12");if(true)return;
		//获取当前访问的地址
		if(request.getQueryString()!=null) 
		staticHtmlUrl+="?"+request.getQueryString(); 
		
		//获取完整的访问地址
		staticHtmlFullUrl="http://127.0.0.1/"+staticHtmlUrl+"&testflag";
		//out.println("<111"+staticHtmlFullUrl+">");
		if(staticHtmlUrl.indexOf("&testflag")==-1)//避免循环抓取
		{
			//拼接静态页面地址
			staticHtmlFileName="html"+CTools.replace(staticHtmlUrl,"/","-");
			staticHtmlFileName=CTools.replace(staticHtmlFileName,"=","-");
			staticHtmlFileName=CTools.replace(staticHtmlFileName,"&","-");
			staticHtmlFileName=CTools.replace(staticHtmlFileName,"?","-");
			staticHtmlFileName=CTools.replace(staticHtmlFileName," ","")+".html";
			staticHtmlFilePath=getServletContext().getRealPath("/")+"temphtml\\"+staticHtmlFileName;

			//判断该页面是否静态化
			java.io.File staticHtmlFile = new java.io.File(staticHtmlFilePath);
			java.util.Date staticHtmlFd=new java.util.Date(staticHtmlFile.lastModified());
			int staticHtmlMinutes = (int) ( ((new java.util.Date()).getTime()-staticHtmlFd.getTime()) / (60 *1000) ); //文件已经生成的分钟数
			boolean staticHtmlIsFileExist=false;
			if (staticHtmlFile.exists()) 
			{
				staticHtmlIsFileExist=true;
				if(staticHtmlMinutes>=300) staticHtmlIsFileExist=false; //两个小时重新生成一次
			}
			else
			{
				staticHtmlIsFileExist=false;
			}

			if(staticHtmlIsFileExist){ //存在，读取这个文件，输出
				try { 
					// Create an BufferedReader so we can read a line at the time. 
					BufferedReader staticHtmlReader = new BufferedReader(new FileReader(staticHtmlFile)); 
					String staticHtmlInLine = staticHtmlReader.readLine(); 
					while (staticHtmlInLine != null) {
						staticHtmlInLine = staticHtmlReader.readLine(); 
						if(staticHtmlInLine != null && staticHtmlInLine != "null") out.print(staticHtmlInLine);
						out.print("\r\n");
					} 
					if(true)return;
				} 
				catch (IOException e) { 
					e.printStackTrace();
				} 
			}
			else
			{
				//读取页面地址对应的html代码
				java.net.URL staticHtmlOUrl = new java.net.URL(staticHtmlFullUrl);//建立URL对象，并实例化为url，获得要抓取的网页地址
				BufferedReader staticHtmlReader = new BufferedReader(new InputStreamReader(staticHtmlOUrl.openStream(),"GBK"));//这里的GB2312是要抓取的网页编码格式
				StringBuffer staticHtmlBuf = new StringBuffer(); 
				while(staticHtmlReader.ready())
				{
					staticHtmlBuf.append(new String(staticHtmlReader.readLine())+"\r\n"); 
				}
				staticHtmlReader.close();
				staticHtmlSTemp = staticHtmlBuf.toString(); 

				if (staticHtmlSTemp.length()>10)
				{
					//不存在，写静态化文件
					try {
							java.io.FileOutputStream staticHtmlFOut = null;
							staticHtmlFOut = new java.io.FileOutputStream(staticHtmlFile);
							staticHtmlFOut.write(staticHtmlSTemp.getBytes());
							staticHtmlFOut.flush(); //写入文件
							staticHtmlFOut.close(); //关闭
					}
					catch (java.io.FileNotFoundException e) {
						  e.printStackTrace();
					}
					catch (java.io.IOException ex) {
						  ex.printStackTrace();
					}
					out.print(staticHtmlSTemp);
					if(true)return;
				}
			}
		}
	}
%>