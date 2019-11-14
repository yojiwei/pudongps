<%@page contentType="text/html; charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.component.database.*"%>
<%@ page import="com.beyondbit.web.publishinfo.Messages" %>
<%@page import="com.util.*,com.app.*"%>

<%
	if (session.getAttribute("_gisVal") != null) session.removeAttribute("_gisVal");	//如果坐标轴有值，清空
	com.jspsmart.upload.SmartUpload myUpload = new com.jspsmart.upload.SmartUpload();
	myUpload.initialize(pageContext);
	myUpload.setDeniedFilesList("exe,bat,jsp");
	myUpload.upload();
	//得到上一页面传过来的值
	String filePath = CTools.dealUploadString(myUpload.getRequest().getParameter("filePath"));
	String contextPath = "/attach/infoattach/imagesForGis/";
	String path = request.getRealPath("/") + contextPath;
	
	//String path = "D:\\pudongTYBS\\WebRoot\\attach\\infoattach\\imagesForGis\\";//Messages.getString("filepath");
	String fileName = "";		//附件路径
	String fileOwnName = "";	//文件名称
	String fileSysName = "";    //文件
	String picpath = "";		//传给巴士拓华的图片路径
		
	/**
	  *	附件上传
	**/
	
 	int count = myUpload.getFiles().getCount(); //上传文件个数
	if(count >= 1) {
		CDate oDate = new CDate();
		String sToday = oDate.getThisday();
		String[] filename = new String[count];
		String[] fileRealName = new String[count];
		if (filePath.equals("")) {	//附件的存放目录不存在 
			int numeral = 0;
			numeral =(int)(Math.random()*100000);
			filePath = sToday + Integer.toString(numeral);
			java.io.File newDir = new java.io.File(path + filePath);
			if(!newDir.exists())
			{
			  	newDir.mkdirs();
			}
		}
		
		myUpload.save(path + filePath,2);//保存文件 
	
		for(int i=0;i<count;i++) {
			filename[i] = myUpload.getFiles().getFile(i).getFileName();

			if(filename[i] == null || "".equals(filename[i].trim()) ){ continue;}

			int filenum = 0;
			filenum =(int)(Math.random()*100000);
			
			String realName = sToday + Integer.toString(filenum) + filename[i].substring(filename[i].indexOf("."));
			fileRealName[i] = realName;
			fileSysName = realName;
			
			java.io.File file = new java.io.File(path + filePath + "\\\\" +filename[i]);				//文件名称
			java.io.File file1 = new java.io.File(path + filePath + "\\\\" +realName);					//系统给予的文件名称
			fileName = String.valueOf(file1);
			fileOwnName  = String.valueOf(filename[i]);
			file.renameTo(file1);
			
		}
	}
	/**
	  *	附件上传结束
	**/
	
	//传给巴士拓华的图片路径
	
	if (!"".equals(fileSysName)) {
		picpath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + 
						  "/" + contextPath + filePath + "/" + fileSysName;
	}
	
	int type1 = 0;
	String staus = CTools.dealUploadString(myUpload.getRequest().getParameter("staus"));						//是否编辑状态
	String gisId = CTools.dealUploadString(myUpload.getRequest().getParameter("gisId"));						//需要更新的id
	String str = CTools.dealUploadString(myUpload.getRequest().getParameter("type1"));							//前页面传过来的类型
	String bigSort = CTools.dealUploadString(myUpload.getRequest().getParameter("BigSort"));					//大类
	String bigSortID = CTools.dealUploadString(myUpload.getRequest().getParameter("bigSortID"));				//大类ID
	String smallSort = CTools.dealUploadString(myUpload.getRequest().getParameter("SmallSort"));				//小类
	String gsPosition = CTools.dealUploadString(myUpload.getRequest().getParameter("gsPosition"));				//坐标位
	
	String sendStatus = staus.equals("Edit") ? "modify" : "add";	
	String homePage = "";													//主页
	String table = "";														//大类id
	String subType = "";													//小类id
	
	type1 = Integer.parseInt(str);
	
	String field1 = "";
	String field2 = "";
	String field3 = "";
	String field4 = "";
	String field5 = "";
	String field6 = "";
	String field7 = "";
	String field8 = "";
	String field9 = "";
	String field10 = "";
	String field11 = "";
	String field12 = "";
	String field13 = "";
	String field14 = "";
	String field15 = "";
	String field16 = "";
	String field17 = "";
	String field18 = "";
	String field19 = "";
	String field20 = "";
	String field21 = "";
	String field22 = "";
	String field23 = "";
	String field24 = "";
	String field25 = "";
	String field26 = "";
	String field27 = "";
	String field28 = "";
	String field29 = "";
	String field30 = "";
	String field31 = "";
	String field32 = "";
	String field33 = "";
	String field34 = "";
	String field35 = "";
	String field36 = "";
	String field37 = "";
	String field38 = "";
	String field39 = "";
	String field40 = "";
	String field41 = "";
	String field42 = "";
	String field43 = "";
	String field44 = "";
	String field45 = "";
	String field46 = "";
	String field47 = "";
	String field48 = "";
	String field49 = "";
	String field50 = "";
	String field51 = "";
	String field52 = "";
	String field53 = "";
	String field54 = "";

	//update20080122

CDataCn dCn=null;   //新建数据库连接对象
CDataImpl dImpl=null;  //新建数据接口对象

try {
 dCn = new CDataCn(); 
 dImpl = new CDataImpl(dCn); 
	ResultSet rs = null;
	
	//取得大类id
	if ("".equals(bigSortID)) {
		String bigSQL = "select dd_code from TB_DATATDICTIONARY where dd_parentid = " +
						  "(select dd_id from TB_DATATDICTIONARY where dd_name = 'GIS分类') and  dd_name = '"+bigSort +"'";
		rs = dImpl.executeQuery(bigSQL);
		if (rs.next()) bigSortID = CTools.dealNull(rs.getString("dd_code"));
	}	
	
	//查询小类代码查询语句
	String smallSQL = "select dd_code from tb_datatdictionary where dd_name = '" + smallSort + "' " +
						"and dd_parentid=(select dd_id from tb_datatdictionary where dd_code='"+ bigSortID +"')";
	
	//取point_other代码
	if (!"".equals(bigSortID) && bigSortID.substring(0,5).equals("point")) {
		bigSortID = bigSortID.substring(0,11);
	}	
	
	//取得小类代码
	rs = dImpl.executeQuery(smallSQL);
	if (rs.next()) subType = CTools.dealNull(rs.getString("dd_code"));
	rs.close();

	  dCn.beginTrans();
		
	  dImpl.setTableName("tbgis");
	  dImpl.setPrimaryFieldName("gsid");
	  
  	  if (staus.equals("Edit"))	{
    	dImpl.edit("tbgis","gsid",Long.parseLong(gisId));
	  }
	  else {
	  	gisId = dImpl.addNew() + "";
  	  	dImpl.setValue("gssort",bigSort,CDataImpl.STRING);
  	 	dImpl.setValue("smallsort",smallSort,CDataImpl.STRING);
  	 	dImpl.setValue("isdel","0",CDataImpl.INT);
	  }
	  
	switch (type1) {
		//食	游	购	金融	娱
		case 1:
			field1 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsName1"));			//名称
			field2 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsAddr1"));			//地址
			field3 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsTel1"));				//电话
			field4 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsPost1"));			//邮编
		  	dImpl.setValue("field1",field1,CDataImpl.STRING);
		  	dImpl.setValue("field2",field2,CDataImpl.STRING);
		  	dImpl.setValue("field3",field3,CDataImpl.STRING);
		  	dImpl.setValue("field4",field4,CDataImpl.STRING);
			break;
		//单位	行(加油站)
		case 2:
			table = "point_other";
			field1 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsName2"));			//名称
			field2 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsAddr2"));			//地址
			field3 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsTel2"));				//电话
			field4 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsPost2"));			//邮编
			field5 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsCharger2"));			//负责人
		  	dImpl.setValue("field1",field1,CDataImpl.STRING);
		  	dImpl.setValue("field2",field2,CDataImpl.STRING);
		  	dImpl.setValue("field3",field3,CDataImpl.STRING);
		  	dImpl.setValue("field4",field4,CDataImpl.STRING);
		  	dImpl.setValue("field5",field5,CDataImpl.STRING);
			break;
		//行(公交走向信息)
		case 3:
			field1 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsUpDown3"));			//上下行
			field2 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsLineName3"));		//线路名
		  	dImpl.setValue("field1",field1,CDataImpl.STRING);
		  	dImpl.setValue("field2",field2,CDataImpl.STRING);
			break;
		//行(车站码头信息)
		case 4:
			field1 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsName4"));			//名称
			field2 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsLine4"));			//所属线路
		  	dImpl.setValue("field1",field1,CDataImpl.STRING);
		  	dImpl.setValue("field2",field2,CDataImpl.STRING);			
			break;
		//行(停车场)
		case 5:
			field1 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsName5"));			//单位全称
			field2 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsLinkAddr5"));		//联系地址
			field3 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsLinkTel5"));			//电话
			field4 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsPost5"));			//邮编
			field5 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsFounder5"));			//法人
			field6 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsLinkMan5"));			//联系人
			field7 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsRegAddr5"));			//注册地址
			field8 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsNum5"));				//许可证号
		  	dImpl.setValue("field1",field1,CDataImpl.STRING);
		  	dImpl.setValue("field2",field2,CDataImpl.STRING);
		  	dImpl.setValue("field3",field3,CDataImpl.STRING);
		  	dImpl.setValue("field4",field4,CDataImpl.STRING);
		  	dImpl.setValue("field5",field5,CDataImpl.STRING);
		  	dImpl.setValue("field6",field6,CDataImpl.STRING);
		  	dImpl.setValue("field7",field7,CDataImpl.STRING);
		  	dImpl.setValue("field8",field8,CDataImpl.STRING);
			break;
		//行(汽车维修点)
		case 6:
			field1 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsName6"));			//名称
			field2 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsLinkAddr6"));		//经营地址
			field3 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsLinkTel6"));			//电话
			field4 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsPost6"));			//邮编
			field5 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsFounder6"));			//法定代表人
			field6 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsCharger6"));			//负责人
			field7 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsRegAddr6"));			//住所(注册地址)
			field8 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsNum6"));				//许可证号
			field9 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsSpec6"));			//特约维修企业备案
			field10 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsdt6"));				//核准项目
			field11 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsKind6"));			//经济性质
		  	dImpl.setValue("field1",field1,CDataImpl.STRING);
		  	dImpl.setValue("field2",field2,CDataImpl.STRING);
		  	dImpl.setValue("field3",field3,CDataImpl.STRING);
		  	dImpl.setValue("field4",field4,CDataImpl.STRING);
		  	dImpl.setValue("field5",field5,CDataImpl.STRING);
		  	dImpl.setValue("field6",field6,CDataImpl.STRING);
		  	dImpl.setValue("field7",field7,CDataImpl.STRING);
		  	dImpl.setValue("field8",field8,CDataImpl.STRING);
		  	dImpl.setValue("field9",field9,CDataImpl.STRING);
		  	dImpl.setValue("field10",field8,CDataImpl.STRING);
		  	dImpl.setValue("field11",field10,CDataImpl.STRING);
			break;
		//住
		case 7:
			field1 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsName7"));			//名称
			field5 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsEast7"));			//东
			field6 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsWest7"));			//西
			field7 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsSouth7"));			//南
			field8 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsNorth7"));			//北
			field9 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsStreet7"));			//所属街道
			field10 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsBuild7"));			//所属房办
			field11 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsStaySay7"));		//居住、非居住分类描述
			field12 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsBuildNum7"));		//建筑数量
			field13 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsBuildsNum7"));		//套数
			field14 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsFamilyNum7"));		//户数
			field15 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsStaySay7"));		//基本描述
			field16 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsBuildSay7"));		//房屋描述
			field17 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsBuildArea7"));		//建筑面积
			field18 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsMuchSay7"));		//高层、多层分类描述
			field19 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsKindSay7"));		//性质分类描述
			field20 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsManageSay7"));		//管理分类描述
			field21 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsBuileMemo7"));		//建筑备注
			field22 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsAssMemo7"));		//辅助设施备注
			field23 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsFundMemo7"));		//基金备注
			field24 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsRecM7"));			//收费情况
			field25 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsYWH7"));			//业委会
			field26 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsJWH7"));			//居委会
			field27 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsWayManage7"));		//行业管理
			field28 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsStayId7"));			//序号
			field29 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsRecMoney7"));		//收费
			field30 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsEnvir7"));			//环境
		  	dImpl.setValue("field1",field1,CDataImpl.STRING);
		  	dImpl.setValue("field5",field5,CDataImpl.STRING);
		  	dImpl.setValue("field6",field6,CDataImpl.STRING);
		  	dImpl.setValue("field7",field7,CDataImpl.STRING);
		  	dImpl.setValue("field8",field8,CDataImpl.STRING);
		  	dImpl.setValue("field9",field9,CDataImpl.STRING);
		  	dImpl.setValue("field10",field10,CDataImpl.STRING);
		  	dImpl.setValue("field11",field11,CDataImpl.STRING);
		  	dImpl.setValue("field12",field12,CDataImpl.STRING);
		  	dImpl.setValue("field13",field13,CDataImpl.STRING);
		  	dImpl.setValue("field14",field14,CDataImpl.STRING);
		  	dImpl.setValue("field15",field15,CDataImpl.STRING);
		  	dImpl.setValue("field16",field16,CDataImpl.STRING);
		  	dImpl.setValue("field17",field17,CDataImpl.STRING);
		  	dImpl.setValue("field18",field18,CDataImpl.STRING);
		  	dImpl.setValue("field19",field19,CDataImpl.STRING);
		  	dImpl.setValue("field20",field20,CDataImpl.STRING);
		  	dImpl.setValue("field21",field21,CDataImpl.STRING);
		  	dImpl.setValue("field22",field22,CDataImpl.STRING);
		  	dImpl.setValue("field23",field23,CDataImpl.STRING);
		  	dImpl.setValue("field24",field24,CDataImpl.STRING);
		  	dImpl.setValue("field25",field25,CDataImpl.STRING);
		  	dImpl.setValue("field26",field26,CDataImpl.STRING);
		  	dImpl.setValue("field27",field27,CDataImpl.STRING);
		  	dImpl.setValue("field28",field28,CDataImpl.STRING);
		  	dImpl.setValue("field29",field29,CDataImpl.STRING);
		  	dImpl.setValue("field30",field30,CDataImpl.STRING);
			break;
		//学
		case 8:
			table = "hospital";
			field1 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsName8"));			//学校名称
			field2 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsLinkAddr8"));		//地址
			field3 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsLinkTel8"));			//电话
			field4 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsPost8"));			//邮编
			field5 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsCC8"));				//城乡
			field6 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsGDNZ8"));			//规定年制
			field7 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsJoinAge8"));			//入学年龄
			field8 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsNum8"));				//代码
			field9 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsDoKind8"));			//办别
			field10 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsKind8"));			//类别
			field11 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsMaster8"));			//校长
			field12 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsClassNum8"));		//班级数
			field13 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsStuNum8"));			//学生数
			field14 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsTeacherNum8"));		//教职工
			field15 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsSTNum8"));			//专任教师
			field16 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsKind18"));			//类型
			field17 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsFax8"));			//传真
			field18 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsPageAddr8"));		//主页地址
			homePage = field18;
			field19 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsEmail8"));			//电子信箱
		  	dImpl.setValue("field1",field1,CDataImpl.STRING);
		  	dImpl.setValue("field2",field2,CDataImpl.STRING);
		  	dImpl.setValue("field3",field3,CDataImpl.STRING);
		  	dImpl.setValue("field4",field4,CDataImpl.STRING);
		  	dImpl.setValue("field5",field5,CDataImpl.STRING);
		  	dImpl.setValue("field6",field6,CDataImpl.STRING);
		  	dImpl.setValue("field7",field7,CDataImpl.STRING);
		  	dImpl.setValue("field8",field8,CDataImpl.STRING);
		  	dImpl.setValue("field9",field9,CDataImpl.STRING);
		  	dImpl.setValue("field10",field10,CDataImpl.STRING);
		  	dImpl.setValue("field11",field11,CDataImpl.STRING);
		  	dImpl.setValue("field12",field12,CDataImpl.STRING);
		  	dImpl.setValue("field13",field13,CDataImpl.STRING);
		  	dImpl.setValue("field14",field14,CDataImpl.STRING);
		  	dImpl.setValue("field15",field15,CDataImpl.STRING);
		  	dImpl.setValue("field16",field16,CDataImpl.STRING);
		  	dImpl.setValue("field17",field17,CDataImpl.STRING);
		  	dImpl.setValue("field18",field18,CDataImpl.STRING);
		  	dImpl.setValue("field19",field19,CDataImpl.STRING);
			break;
		//医
		case 9:
			table = "school";
			field1 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsName9"));			//医院名称
			field2 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsAddr9"));			//地址
			field3 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsTel9"));				//电话
			field4 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsPost9"));			//邮编
			field5 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsPage9"));			//主页
			homePage = field5;
			field6 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsStreet9"));			//街道
			field7 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsCharger9"));			//负责人
			field8 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsTel19"));			//电话分机
			field9 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsBZCW9"));			//编制床位
			field10 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsSJCW9"));			//实际床位
			field11 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsZGZS9"));			//职工总数
			field12 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsWSJS9"));			//卫生技术人员
			field13 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsZYYS9"));		//职业医师
			field14 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsZYZYYS9"));		//中医职业医师
			field15 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsZYZLYS9"));		//职业助理医师
			field16 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsZYZYZLYS9"));	//中医职业助理医师
			field17 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsZCHS9"));		//注册护士
			field18 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsYJRY9"));		//药剂人员
			field19 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsZYYS9"));		//职业药师
			field20 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsZYZYS9"));		//职业中药师
			field21 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsJYRY9"));		//检验人员
			field22 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsQTWSJSRY9"));	//其他卫生技术人员
			field23 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsQTJSY9"));		//其他技术人员
			field24 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsGLRY9"));		//管理人员
			field25 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsGQRY9"));		//工勤人员
			field26 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsLTXRY9"));		//离退休人员
			field27 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsGJFWJZMJ9"));	//购建房屋建筑面积
			field28 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsYWYFMJ9"));		//业务用房面积
			field29 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsZFMJ9"));		//租房面积
			field30 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsZFYWYFMJ9"));	//租房业务用房面积
			field31 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsWYYSSBTS9"));	//万元以上设备台数
			field32 = CTools.dealUploadString(myUpload.getRequest().getParameter("gs201009"));		//20-100万元设备台数
			field33 = CTools.dealUploadString(myUpload.getRequest().getParameter("gs100YS9"));		//万元以上设备台数
			field34 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsZZC9"));		//总资产
			field35 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsLDZC9"));		//流动资产
			field36 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsDWTZ9"));		//对外投资
			field37 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsGDZC9"));		//固定资产
			field38 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsWXZCJKBF9"));	//无形资产及开办费
			field39 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsFZYJZC9"));		//负债与净资产
			field40 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsFZ9"));			//负债
			field41 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsJZC9"));		//净资产
			field42 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsSYJJ9"));		//事业基金
			field43 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsGDZJ9"));		//固定资金
			field44 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsZYZJ9"));		//专用资金
			field45 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsZSR9"));		//总收入
			field46 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsCZBZSR9"));		//财政补助收入
			field47 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsZXBZ"));		//专项补助
			field48 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsSZBZSR9"));		//上组补助收入
			field49 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsYWSRSYSR9"));	//业务收入事业收入
			field50 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsJYSR9"));		//经营收入
			field51 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsZZC19"));		//总支出
			field52 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsYWZCSYZC9"));	//业务支出事业支出
			field53 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsCZZXZC9"));		//财政专项支出
			field54 = CTools.dealUploadString(myUpload.getRequest().getParameter("gsRYJFZC9"));		//人员经费支出
		  	dImpl.setValue("field1",field1,CDataImpl.STRING);
		  	dImpl.setValue("field2",field2,CDataImpl.STRING);
		  	dImpl.setValue("field3",field3,CDataImpl.STRING);
		  	dImpl.setValue("field4",field4,CDataImpl.STRING);
		  	dImpl.setValue("field5",field5,CDataImpl.STRING);
		  	dImpl.setValue("field6",field6,CDataImpl.STRING);
		  	dImpl.setValue("field7",field7,CDataImpl.STRING);
		  	dImpl.setValue("field8",field8,CDataImpl.STRING);
		  	dImpl.setValue("field9",field9,CDataImpl.STRING);
		  	dImpl.setValue("field10",field10,CDataImpl.STRING);
		  	dImpl.setValue("field11",field11,CDataImpl.STRING);
		  	dImpl.setValue("field12",field12,CDataImpl.STRING);
		  	dImpl.setValue("field13",field13,CDataImpl.STRING);
		  	dImpl.setValue("field14",field14,CDataImpl.STRING);
		  	dImpl.setValue("field15",field15,CDataImpl.STRING);
		  	dImpl.setValue("field16",field16,CDataImpl.STRING);
		  	dImpl.setValue("field17",field17,CDataImpl.STRING);
		  	dImpl.setValue("field18",field18,CDataImpl.STRING);
		  	dImpl.setValue("field19",field19,CDataImpl.STRING);
		  	dImpl.setValue("field20",field19,CDataImpl.STRING);
		  	dImpl.setValue("field21",field21,CDataImpl.STRING);
		  	dImpl.setValue("field22",field22,CDataImpl.STRING);
		  	dImpl.setValue("field23",field23,CDataImpl.STRING);
		  	dImpl.setValue("field24",field24,CDataImpl.STRING);
		  	dImpl.setValue("field25",field25,CDataImpl.STRING);
		  	dImpl.setValue("field26",field26,CDataImpl.STRING);
		  	dImpl.setValue("field27",field27,CDataImpl.STRING);
		  	dImpl.setValue("field28",field28,CDataImpl.STRING);
		  	dImpl.setValue("field29",field29,CDataImpl.STRING);
		  	dImpl.setValue("field30",field30,CDataImpl.STRING);
		  	dImpl.setValue("field31",field31,CDataImpl.STRING);
		  	dImpl.setValue("field32",field32,CDataImpl.STRING);
		  	dImpl.setValue("field33",field33,CDataImpl.STRING);
		  	dImpl.setValue("field34",field34,CDataImpl.STRING);
		  	dImpl.setValue("field35",field35,CDataImpl.STRING);
		  	dImpl.setValue("field36",field36,CDataImpl.STRING);
		  	dImpl.setValue("field37",field37,CDataImpl.STRING);
		  	dImpl.setValue("field38",field38,CDataImpl.STRING);
		  	dImpl.setValue("field39",field39,CDataImpl.STRING);
		  	dImpl.setValue("field40",field40,CDataImpl.STRING);
		  	dImpl.setValue("field41",field41,CDataImpl.STRING);
		  	dImpl.setValue("field42",field42,CDataImpl.STRING);
		  	dImpl.setValue("field43",field43,CDataImpl.STRING);
		  	dImpl.setValue("field44",field44,CDataImpl.STRING);
		  	dImpl.setValue("field45",field45,CDataImpl.STRING);
		  	dImpl.setValue("field46",field46,CDataImpl.STRING);
		  	dImpl.setValue("field47",field47,CDataImpl.STRING);
		  	dImpl.setValue("field48",field48,CDataImpl.STRING);
		  	dImpl.setValue("field49",field49,CDataImpl.STRING);
		  	dImpl.setValue("field50",field50,CDataImpl.STRING);
		  	dImpl.setValue("field51",field51,CDataImpl.STRING);
		  	dImpl.setValue("field52",field52,CDataImpl.STRING);
		  	dImpl.setValue("field53",field53,CDataImpl.STRING);
		  	dImpl.setValue("field54",field54,CDataImpl.STRING);
			break;
	}
	
	  dImpl.setValue("time",CDate.getNowTime(),CDataImpl.DATE);
	  dImpl.setValue("gsposition",gsPosition,CDataImpl.STRING);
	  dImpl.setValue("type",str,CDataImpl.STRING);
	  
	  if (!"".equals(fileName)) {
	  	dImpl.setValue("gspicname",fileOwnName,CDataImpl.STRING);
	  	dImpl.setValue("gspicpath",fileName,CDataImpl.STRING);
	  }
	  
	  dImpl.update();
	  	  
	if (dCn.getLastErrString().equals("")){
		dCn.commitTrans();
		//out.println("<script language='javascript'>alert('操作已成功！');window.location='gisList.jsp';</script>");
	}
	else {
		dCn.rollbackTrans();
		out.println("<script language='javascript'>alert('发生错误，录入失败！');window.history.go(-1);</script>");
	}

	/**
	 * 记录部门报送的gis信息
	**/
    CMySelf mySelf = (CMySelf)session.getAttribute("mySelf");
  	String dtID = String.valueOf(mySelf.getDtId());
	String sql = "insert into tb_infostatic(ADDNUM,PUBNUM,UPDATENUM,OPERTIME,DEPTID,SCORE,INFOID,TYPE) values " + 
		  "(1,0,0,sysdate," + dtID + ",1," + gisId + ",1)";
	dImpl.executeUpdate(sql);

  	dImpl.closeStmt();
  	dCn.closeCn();
%>
<form name="formData" method="post" action="http://211.144.95.131/bianmin_luodi/luoDi.do">
	<!--公共信息-->
	<div style="display: none">
	<textarea name="table"><%=bigSortID%></textarea>
	<textarea name="bianmin"><%=subType%></textarea>
	<textarea name="sendID"><%=gisId%></textarea>
	<textarea name="method"><%=sendStatus%></textarea>
	<textarea name="name"><%=field1%></textarea>
	<textarea name="phone"><%=field3%></textarea>
	<textarea name="address"><%=field2%></textarea>
	<textarea name="homepage"><%=homePage%></textarea>
	<textarea name="imageurl"><%=picpath%></textarea>
	<textarea name="sendX"><%=gsPosition.split(",")[0]%></textarea>
	<textarea name="sendY"><%=gsPosition.split(",")[1]%></textarea>
	<!--begin 标记信息来源-->
	<textarea name="whereFrom">2</textarea>
	<!--end-->
	<!--医-->
	<!--textarea name="fj"><%=field5%></textarea-->
	<textarea name="principal"><%=field8%></textarea>
	<textarea name="postcode"><%=field4%></textarea>
	<textarea name="street"><%=field6%></textarea>
	<textarea name="bzcw"><%=field9%></textarea>
	<textarea name="sjcw"><%=field10%></textarea>
	<textarea name="zgzs"><%=field11%></textarea>
	<textarea name="wsjsry"><%=field12%></textarea>
	<textarea name="zyys"><%=field13%></textarea>
	<textarea name="zyzyys"><%=field14%></textarea>
	<textarea name="zyzlys"><%=field15%></textarea>
	<textarea name="zyzyzlys"><%=field16%></textarea>
	<textarea name="zchs"><%=field17%></textarea>
	<textarea name="yjry"><%=field18%></textarea>
	<textarea name="zhyys"><%=field19%></textarea>
	<textarea name="zyzys"><%=field20%></textarea>
	<textarea name="jyry"><%=field21%></textarea>
	<textarea name="qtwsjsry"><%=field22%></textarea>
	<textarea name="qtjsry"><%=field23%></textarea>
	<textarea name="glry"><%=field24%></textarea>
	<textarea name="gqry"><%=field25%></textarea>
	<textarea name="ltxry"><%=field26%></textarea>
	<textarea name="gjfwjzmj"><%=field27%></textarea>
	<textarea name="ywyfmj"><%=field28%></textarea>
	<textarea name="zfmj"><%=field29%></textarea>
	<textarea name="zfywyfmj"><%=field30%></textarea>
	<textarea name="sbts1"><%=field31%></textarea>
	<textarea name="sbts2"><%=field32%></textarea>
	<textarea name="sbts3"><%=field33%></textarea>
	<textarea name="zzc"><%=field34%></textarea>
	<textarea name="ldzc"><%=field35%></textarea>
	<textarea name="dwtz"><%=field36%></textarea>
	<textarea name="gdzc"><%=field37%></textarea>
	<textarea name="wxzcjkbf"><%=field38%></textarea>
	<textarea name="fzyjzc"><%=field39%></textarea>
	<textarea name="fz"><%=field40%></textarea>
	<textarea name="jzc"><%=field41%></textarea>
	<textarea name="syjj"><%=field42%></textarea>
	<textarea name="gdzj"><%=field43%></textarea>
	<textarea name="zyzj"><%=field44%></textarea>
	<textarea name="zsr"><%=field45%></textarea>
	<textarea name="czbzsr"><%=field46%></textarea>
	<textarea name="zxbz"><%=field47%></textarea>
	<textarea name="szbzsr"><%=field48%></textarea>
	<textarea name="ywsrsysr"><%=field49%></textarea>
	<textarea name="jysr"><%=field50%></textarea>
	<textarea name="zhzc"><%=field51%></textarea>
	<textarea name="ywzcsyzc"><%=field52%></textarea>
	<textarea name="czzxzc"><%=field53%></textarea>
	<textarea name="ryjfzc"><%=field54%></textarea>
	<!--食-->
	<textarea name="zsr"><%=field45%></textarea>
	<textarea name="czbzsr"><%=field46%></textarea>
	<textarea name="zxbz"><%=field47%></textarea>
	<textarea name="szbzsr"><%=field48%></textarea>
	<textarea name="ywsrsysr"><%=field49%></textarea>
	<textarea name="jysr"><%=field50%></textarea>
	<textarea name="zhzc"><%=field51%></textarea>
	<textarea name="ywzcsyzc"><%=field52%></textarea>
	<textarea name="czzxzc"><%=field53%></textarea>
	<textarea name="ryjfzc"><%=field54%></textarea>
	<!--学-->
	<textarea name="xxdmcode"><%=field8%></textarea>
	<textarea name="lb"><%=field10%></textarea>
	<textarea name="bb"><%=field9%></textarea>
	<textarea name="cx"><%=field5%></textarea>
	<textarea name="gdnz"><%=field6%></textarea>
	<textarea name="rxnl"><%=field7%></textarea>
	<textarea name="postcode"><%=field4%></textarea>
	<textarea name="master"><%=field11%></textarea>
	<textarea name="bjs"><%=field12%></textarea>
	<textarea name="xss"><%=field13%></textarea>
	<textarea name="jzg"><%=field14%></textarea>
	<textarea name="zrjs"><%=field15%></textarea>
	<textarea name="kind"><%=field16%></textarea>
	<textarea name="fax"><%=field17%></textarea>
	<textarea name="mail"><%=field18%></textarea>
</div>
</form>
<script>
	formData.submit();
	alert('操作已成功！');
	window.location='gisList.jsp';
</script>
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