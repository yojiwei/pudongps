package com.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Hashtable;
import java.util.List;
import java.util.Random;
import java.util.Vector;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;


public class JxlTools {

	public static HSSFWorkbook workbook = null;
	public static HSSFSheet sheet = null;
	public static String[] colName = new String[]{"pr_id","pr_gisaddress"};
	
	public JxlTools(){
		
	}
	
	/**
	 * excel 初始化
	 * @param realPath excel的本地绝对路径
	 */
	public JxlTools(String realPath){
		try {
			workbook = new HSSFWorkbook(new FileInputStream(realPath));
			sheet = workbook.getSheetAt(0);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public JxlTools(String realPath,int sheetNum){
		try {
			workbook = new HSSFWorkbook(new FileInputStream(realPath));
			sheet = workbook.getSheetAt(sheetNum);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 生成yyyymmdd+无位随机数的格式的文件夹名
	 * @return 文件夹名
	 */
	public String getNewDir(){
		String filePath ="";
		Calendar calendar = Calendar.getInstance();
		String year = String.valueOf(calendar.get(Calendar.YEAR));
		String month = String.valueOf(calendar.get(Calendar.MONTH)+1);
		String day = String.valueOf(calendar.get(Calendar.DAY_OF_MONTH));
		if(month.length() < 2)
			month = "0" + month;
		if(day.length() < 2)
			day = "0" + day;
		Random random = new Random();
		filePath = year + month + day + random.nextInt(10000); 
		return filePath;
	}
	
	/**
	 * 创建文件夹
	 * @param dirPath 文件夹路径
	 * @return 创建的完整的路径
	 */
	public String getFilePath(String dirPath){
		String filePath = "";
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			String path = dImpl.getInitParameter("info_save_path");
			filePath = path + "\\" + dirPath;
			java.io.File newDir = new java.io.File(filePath);
			if(!newDir.exists()){
			  newDir.mkdirs();
			}else{
				filePath = getFilePath(getNewDir());
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return filePath;
	}
	
	/**
	 * 封装CDataImpl的getInitParameter方法
	 * @return 文件路径
	 */
	public String getFileHttpPath(String paraName){
		String fileHttpPath = "";
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			fileHttpPath = dImpl.getInitParameter(paraName);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return fileHttpPath;
	}
	
	/**
	 * 将excel的一行记录插入到数据库
	 * @param row excel的一行记录
	 * @return 插入成功返回true，失败返回false
	 */
	private boolean doInsertTable(HSSFRow row){
		boolean flag = false;
		HSSFCell cell = null;
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		String value = "";
		int cellType = 0;
		int cols = 0;
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			cols = row.getPhysicalNumberOfCells();
			for(int colNum = 0; colNum < 2; colNum++){
				cell = row.getCell((short)colNum);
				value = cell.getStringCellValue().trim();
				if(colNum==0){
					dImpl.edit("tb_proceeding_new", "pr_id", value);
				}else{
					dImpl.setValue(colName[colNum],value,CDataImpl.STRING);
				}
				value = "";
			}
			flag = dImpl.update();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return flag;
	}
	
	/**
	 * 将数据库的数据导入、生成excel
	 * @param filePath 要生成的文件的路径
	 */
	public void expExl(String filePath){
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		Vector vec = null;
		Hashtable table = null;
		HSSFWorkbook wb = null;
		HSSFSheet sheet = null;
		HSSFRow row = null;
		HSSFCell cell = null;
		String cellValue = "";
		
		//数据库要取出的字段名
		String[] cellValues = new String[]{"ht_id","ht_code","ht_name","ht_sex","ht_photonum","ht_receivetime","ht_address","ht_occuraddr",
				"ht_type","ht_questiontype","ht_content","ht_receivedept","ht_resulttype",
				"ht_resultdetail","ht_mannertype","ht_mannerdetail"};
		
		//与数据库字段名对应的excel的栏目名
		String[] cells = new String[]{"序号","编号","姓名","性别","联系电话","来电时间","联系地址","问题发生地点",
				"来电类别","问题类别","问题描述","主办单位","办理结果","办理结果描述","办理态度","办理态度描述"}; 
		
		String sqlStr = "select ht_id,ht_code,ht_name,ht_sex,ht_photonum,ht_receivetime,ht_address,ht_occuraddr," +
		"ht_type,ht_questiontype,ht_content,ht_receivedept,ht_resulttype," +
		"ht_resultdetail,ht_mannertype,ht_mannerdetail from tb_hotlineservice order by ht_id";
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			vec = dImpl.splitPage(sqlStr,5000,1);
			wb = new HSSFWorkbook();// 建立新HSSFWorkbook对象

			sheet = wb.createSheet("hotlineService");// 建立新的sheet对象

			   // Create a row and put some cells in it. Rows are 0 based.
			
			row = sheet.createRow((short) 0);// 建立新行
			for(int cnt = 0; cnt < cells.length; cnt++){
				cell = row.createCell((short) cnt);
				cell.setEncoding(HSSFCell.ENCODING_UTF_16);// 设置cell编码解决中文高位字节截断
				cell.setCellValue("中文测试_Chinese Words Test");// 设置中西文结合字符串
				cell.setCellValue(cells[cnt]);// 设置中西文结合字符串
			}
			if(vec != null){
				for(int cnt = 0;cnt < vec.size(); cnt++){
					table = (Hashtable) vec.get(cnt);
					row = sheet.createRow((short) cnt+1);// 建立新行
					for(int count = 0; count < cellValues.length; count++){
						cell = row.createCell((short) count);
						cellValue = table.get(cellValues[count]) !=  null ? table.get(cellValues[count]).toString() : "";
						cell.setEncoding(HSSFCell.ENCODING_UTF_16);// 设置cell编码解决中文高位字节截断
						cell.setCellValue("中文测试_Chinese Words Test");// 设置中西文结合字符串
						cell.setCellValue(cellValue);// 设置中西文结合字符串
					}
				}
			}
			FileOutputStream fileOut = new FileOutputStream(filePath);

			wb.write(fileOut);

			fileOut.close();



		}catch(Exception e){
			e.printStackTrace();
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
	}
	
	public void updateGisaddress(){
		CDataCn dCn = null;
		CDataImpl dImpl = null;
		String pr_idStr = "";
		List pridList = new ArrayList();
		try{
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			Vector vector = dImpl.splitPageOpt("select distinct pr_gisaddress from tb_proceeding_new where pr_gisaddress is not null", 5000, 1);
			for(int i=0;i<vector.size();i++){
				Hashtable ht = (Hashtable)vector.get(i);
				String pr_gisaddress = CTools.dealNull(ht.get("pr_gisaddress"));
				if(pr_gisaddress.indexOf(",")==-1){
					String sql = "select pr_id from tb_proceeding_new where pr_gisaddress is null and pr_address like '%"+pr_gisaddress+"%'";
					Vector gis_vector = dImpl.splitPageOpt(sql, 5000, 1);
					if(gis_vector!=null){
					for(int j=0;j<gis_vector.size();j++){
						Hashtable ht1 = (Hashtable)gis_vector.get(j);
						String pr_id = CTools.dealNull(ht1.get("pr_id"));
						if(!pridList.contains(pr_id)){ 
							pridList.add(pr_id);	
							pr_idStr=pr_idStr+"'"+pr_id+"',";
						}
					}
					}
				}
			}
			System.out.println("*********"+pr_idStr+"************");
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			dImpl.closeStmt();
			dCn.closeCn();
		}
	}
	
	public static void main(String[] args){
		JxlTools jxl = new JxlTools("C:\\banshinew.xls");
		//jxl.updateGisaddress();
		int rows = jxl.sheet.getLastRowNum();
		HSSFRow row = null;
		
		for(int rowNum = 0; rowNum <= rows; rowNum++){
			row = jxl.sheet.getRow(rowNum);
			System.out.println(jxl.doInsertTable(row));
		}
		
		//JxlTools jxl = new JxlTools();
		//jxl.expExl("F:\\work_file\\test.XLS");
		//System.out.println(jxl.getFileHttpPath("info_http_path"));
		
//		JxlTools jxl = new JxlTools("F:\\work_file\\962151.XLS",2);
//		int rows = jxl.sheet.getLastRowNum();
//		HSSFRow row = null;
//		HSSFCell cell = null;
//		String tempStr = "";
//		StringBuffer sb = new StringBuffer("");
//		for(int rowNum = 0; rowNum < rows; rowNum++){
//			row = jxl.sheet.getRow(rowNum);
//			cell = row.getCell((short)2);
//			tempStr = cell.getStringCellValue().trim();
//			if(sb.indexOf(tempStr) > 0 ){
//				System.out.println("---- " + tempStr);
//			}else{
//				sb.append(tempStr);
//				sb.append(",");
//			}
//		}
//		System.out.println(sb.toString());
		
//		getExcelContent("D:\\backup备份\\单位测试.xls");
		
	}
	
	/**
	 * 获得Excel单元格字符串
	 * @param cell 要获得字符串的单元格
	 * @param type 指定的单元格实际类型，只对公式型(CELL_TYPE_FORMULA)单元格有效
	 * @return 单元格字符串
	 */
	public static String getCellValue(HSSFCell cell, int type){
		NumberFormat format = NumberFormat.getIntegerInstance();
		//format.setMaximumFractionDigits(0);
		format.setParseIntegerOnly(true);
		if(cell != null){
			switch(cell.getCellType()){
				case HSSFCell.CELL_TYPE_NUMERIC:
					return format.format(cell.getNumericCellValue()).replaceAll(",","");
				case HSSFCell.CELL_TYPE_STRING:
					return cell.getStringCellValue();
				case HSSFCell.CELL_TYPE_FORMULA:
					return getFormulaCellValue(cell,type);
				default:
					return "";
			}
		}
		else
			return null;
	}
	
	/**
	 * 获得Excel公式类型单元格字符串
	 * @param cell 要获得字符串的单元格
	 * @param type 指定的单元格实际类型
	 * @return 单元格字符串
	 */
	public static String getFormulaCellValue(HSSFCell cell, int type){
		if(cell != null && cell.getCellType() == HSSFCell.CELL_TYPE_FORMULA){
			switch(type){
				case HSSFCell.CELL_TYPE_NUMERIC:
					return String.valueOf(Integer.parseInt(new Double(cell.getNumericCellValue()).toString()));
				case HSSFCell.CELL_TYPE_STRING:
					return cell.getStringCellValue();
				default:
					return "";
			}
		}
		else 
			return "";
	}
	
	public static void getExcelContent(String filePath){
		HSSFWorkbook workbook = null;
		HSSFSheet sheet = null;
		HSSFRow row = null;
		HSSFCell c1 = null;
		String bm_title = "";
		try {
			workbook = new HSSFWorkbook(new FileInputStream(filePath));
			//获取第一张Sheet表
			sheet = workbook.getSheetAt(0);
			for(int i=0;i<sheet.getPhysicalNumberOfRows();i++){
				row = sheet.getRow(i);
				for(int j = 0; j < row.getLastCellNum(); j++){
					c1 = row.getCell((short)j);
					
					if(c1 != null){
						bm_title = CTools.dealNull(getCellValue(c1,c1.getCellType()));
					}else{
						bm_title = "";
					}
				}
				System.out.println("bm_title = "+ bm_title);
			}
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
}
