package com.util;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.StringTokenizer;
import java.util.Vector;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

public class XmlIntoTable {

	
	/**
	 * Description：初始化变量
	 * @param fileStr 一段xml的字符串
	 */
	public Element initEle(String fileStr){
		Document doc = null;

		SAXBuilder sb = null;

		Element element = null;
		try{
			sb = new SAXBuilder();
			InputStream inputStream = new  ByteArrayInputStream(fileStr.getBytes("gb2312"));
			doc = sb.build(inputStream);
			element = doc.getRootElement();
		}catch(Exception ex){
			System.out.println(" XML格式错误: " + ex.getMessage());
		}
		return element;
	}
	
	public void copyStream(InputStream is, OutputStream os) throws IOException {
        // 这个读过过程可以参阅 readToBuffer 中的注释
        String line;
        BufferedReader reader = new BufferedReader(new InputStreamReader(is,"gb2312"));
        PrintWriter writer = new PrintWriter(new OutputStreamWriter(os));
        line = reader.readLine();
        while (line != null) {
            writer.println(line);
            line = reader.readLine();
        }
        writer.flush();     // 最后确定要把输出流中的东西都写出去了
                            // 这里不关闭 writer 是因为 os 是从外面传进来的
                            // 既然不是从这里打开的，也就不从这里关闭
                            // 如果关闭的 writer，封装在里面的 os 也就被关了
    }

	
	/**
	 * 将传入的字符串转化插入相应的数据表
	 * @param fileStr 转化成base64的文件源
	 * @return boolean 提交成功返回 true ,失败返回 false
	 */
	public boolean doInsertTable2(String fileStr){
		Element ele = initEle(fileStr);
		return getContent(ele);
	}
	
	/**
	 * 将传入的字符串转化插入相应的数据表
	 * @param element 跟目录元素
	 * @return boolean 提交成功返回 true ,失败返回 false
	 */
	private boolean getContent(Element element){
		Element content = null;
		String ctName = "";
		List list = element.getChildren();
		boolean flag = false;
		for(int cnt = 0; cnt < list.size(); cnt++){
			content = (Element)list.get(cnt);
			ctName = content.getName().toString();
			
			if("TB_CONTENT".equals(ctName))
				flag = getContentInfo(content);
		}
		return flag;
	}
	
	/**
	 * 
	 * @param contentMap 包含内容主体的HashMap
	 * @param list 包含附件的 List
	 * @return  boolean 提交成功返回 true ,失败返回 false
	 */
	private boolean insertAttach(HashMap contentMap,ArrayList list){
		boolean flag = true;
		HashMap map = null;
		int ctId = doInsertContent(contentMap);
		CDataCn cDn = new CDataCn("oracle");
		CDataImpl cImpl = new CDataImpl(cDn);
		String newDir = getNewDir(cImpl.getInitParameter("info_save_path"));
		//----------todo
		//newDir = getNewDir("E:\\programImg\\");
		String newFileName = "";
		String atContent = "";
		String atType = "";
		int size = list.size();
		if(ctId != -1){
			for(int cnt = 0; cnt < size; cnt++){
				map = (HashMap) list.get(cnt);
				atContent = map.get("CT_BASE").toString();
				atType = map.get("CT_TYPE").toString();
				newFileName = newDir + "\\" + CDate.getThisTime() + cnt + "." + atType;
				CBase64.saveDecodeStringToFile(atContent,newFileName);
				flag = doInsertAttach(ctId,newDir,newFileName);
				
			}
		}
		return flag;
	}
	
	/**
	 * 插入附件表
	 * @param ctId ct_id
	 * @param newDir 附件存放的路径
	 * @param newFileName 附件名
	 * @return boolean 提交成功返回 true ,失败返回 false
	 */
	private boolean doInsertAttach(int ctId,String newDir,String newFileName){
		boolean flag = false;
		CDataCn cDn = new CDataCn("oracle");
		CDataImpl cImpl = new CDataImpl(cDn);
		try{
			cImpl.addNew("tb_image","IM_ID");
			cImpl.setValue("IM_PATH",newDir,CDataImpl.STRING);
			cImpl.setValue("IM_FILENAME",newFileName,CDataImpl.STRING);
//			cImpl.setValue("IM_CONTENT",atContent,CDataImpl.SLONG);
			cImpl.setValue("CT_ID",String.valueOf(ctId),CDataImpl.STRING);
			flag = cImpl.update();
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertContent " + ex.getMessage());
			cDn.closeCn();
			cImpl.closeStmt();
		}finally{
			cImpl.closeStmt();
			cDn.closeCn();
		}
		return flag;
	}
	
	/**
	 * 插入tb_content 表
	 * @param map 包含内容主体的HashMap
	 * @return ctId 插入的记录的主键值
	 */
	private int doInsertContent(HashMap map){
		boolean flag = false;
		int ctId = -1;
		CDataCn cDn = null;
		CDataImpl cImpl = null;
		String ctTitle = map.get("CT_TITLE") == null ? "" : map.get("CT_TITLE").toString();
		String ctContent = map.get("CT_CONTENT") == null ? "" : map.get("CT_CONTENT").toString();
		String ctCreateTime = map.get("CT_CREATE_TIME") == null ? "" : map.get("CT_CREATE_TIME").toString();
		String ctSource = map.get("CT_SOURCE") == null ? "" : map.get("CT_SOURCE").toString();
		String dtId = map.get("DT_ID") == null ? "" : map.get("DT_ID").toString();
		String sjId = map.get("SJ_ID") == null ? "" : map.get("SJ_ID").toString();
		try{
			cDn = new CDataCn("oracle");
			cImpl = new CDataImpl(cDn);
			cImpl.addNew("tb_content","CT_ID");
			cImpl.setValue("CT_TITLE",ctTitle,CDataImpl.STRING);
			cImpl.setValue("CT_CONTENT",ctContent,CDataImpl.SLONG);
			cImpl.setValue("CT_CREATE_TIME",ctCreateTime,CDataImpl.STRING);
			cImpl.setValue("CT_SOURCE",ctSource,CDataImpl.STRING);
			cImpl.setValue("DT_ID",dtId,CDataImpl.STRING);
			cImpl.setValue("SJ_ID",sjId,CDataImpl.STRING);
			flag = cImpl.update();
			if(flag){
				ctId = getMaxID("tb_content");
				doInsertContentPublish(sjId,ctId,dtId);
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertContent " + ex.getMessage());
			cDn.closeCn();
			cImpl.closeStmt();
		}finally{
			cImpl.closeStmt();
			cDn.closeCn();
		}
		return ctId;
	}
	
	/**
	 * 插入tb_contentpublish 表  
	 * @param sjId sj_id
	 * @param ctId ct_id
	 * @param dtId dt_id
	 * @return boolean 提交成功返回 true ,失败返回 false 
	 */
	private boolean doInsertContentPublish(String sjId,int ctId,String dtId){
		boolean flag = true;
		CDataCn cDn = new CDataCn("oracle");
		CDataImpl cImpl = new CDataImpl(cDn);
		StringTokenizer token = new StringTokenizer(sjId,",");
		int len = token.countTokens();
		String[] str = new String[len];
		try{
			for(int cnt = 0; cnt < len; cnt++){
				str[cnt] = 	token.nextToken();
				
				cImpl.addNew("tb_contentpublish","CP_ID");
				cImpl.setValue("CT_ID",String.valueOf(ctId),CDataImpl.INT);
				cImpl.setValue("SJ_ID",str[cnt],CDataImpl.INT);
				cImpl.setValue("CP_ISPUBLISH","1",CDataImpl.INT);
				flag = flag && cImpl.update();
				//插入积分表
				doInsertScore(ctId,str[cnt],dtId);
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertContentPublish " + ex.getMessage());
			cDn.closeCn();
			cImpl.closeStmt();
		}finally{
			cImpl.closeStmt();
			cDn.closeCn();
		}
		return flag;
	}
	
	/**
	 * 
	 * @param content 包含内容主体的 HashMap
	 * @return boolean 提交成功返回 true ,失败返回 false
	 */
	private boolean getContentInfo(Element content){
		List subList = null;
		Element subEle = null;
		HashMap map = new HashMap();
		subList = content.getChildren();
		String innerName = "";
		String innerValue = "";
		ArrayList attachList = null;
		boolean flag = false;
		for(int len = 0; len < subList.size(); len++){
			subEle = (Element)subList.get(len);
			innerName = subEle.getName();
			
			innerValue = subEle.getText();
			if("CT_TITLE".equals(innerName))
				map.put("CT_TITLE",innerValue);
			else if("CT_CONTENT".equals(innerName))
				map.put("CT_CONTENT",innerValue);
			else if("CT_CREATE_TIME".equals(innerName))
				map.put("CT_CREATE_TIME",innerValue);
			else if("CT_SOURCE".equals(innerName))
				map.put("CT_SOURCE",innerValue);
			else if("SJ_ID".equals(innerName))
				map.put("SJ_ID",innerValue);
			else if("DT_ID".equals(innerName))
				map.put("DT_ID",innerValue);
			else if("ATTACH".equals(innerName)){
				attachList = getAttachInfo(subEle);
				if(attachList != null)
					flag = insertAttach(map,attachList);
			}
		}
		return flag;
	}
	
	/**
	 * 将附件信息存放在List中返回
	 * @param attach 包含附件信息的元素
	 * @return 存放附件的List
	 */
	private ArrayList getAttachInfo(Element attach){
		List subList = null;
		ArrayList list = new ArrayList();
		Element subEle = null;
		Element innerEle = null;
		List innerList = null;
		HashMap map = null;
		subList = attach.getChildren();
		String innerName = "";
		String innerValue = "";
		for(int len = 0; len < subList.size(); len++){
			subEle = (Element)subList.get(len);
			innerList = subEle.getChildren();
			map = new HashMap();
			
			for(int cnt = 0; cnt < innerList.size(); cnt++){
				innerEle = (Element) innerList.get(cnt);
				innerName = innerEle.getName();
				innerValue = innerEle.getTextTrim();
				if(!"".equals(innerName)){
					if("CT_BASE".equals(innerName))
						map.put("CT_BASE",innerValue);
					else if("CT_TYPE".equals(innerName))
						map.put("CT_TYPE",innerValue);
				}
			}
			list.add(map);
		}
		return list;
	}
	
	
	

	/**
	 * Description：积分表插入数据
	 * @param ctId 信息ID
	 * @param sjId 栏目ID
	 * @return 插入成功返回1
	 */
	private boolean doInsertScore(int ctId,String sjId,String dtId){
		boolean flag = false;
		CDataCn cDn = new CDataCn("oracle");
		CDataImpl cImpl = new CDataImpl(cDn);
		
		//执行插入操作
		try{
			//信息有对应的栏目
			if("0".endsWith(sjId)){
				cImpl.addNew("tb_score","SC_ID");
				cImpl.setValue("CT_ID",String.valueOf(ctId),CDataImpl.INT);
				cImpl.setValue("DT_ID",dtId,CDataImpl.INT);
				flag = cImpl.update();
			}
			
			//信息没有对应的栏目
			else{
				cImpl.addNew("tb_score","SC_ID");
				cImpl.setValue("CT_ID",String.valueOf(ctId),CDataImpl.INT);
				cImpl.setValue("DT_ID",dtId,CDataImpl.INT);
				cImpl.setValue("SC_SCORE","1",CDataImpl.INT);
				cImpl.setValue("SC_STATUS","1",CDataImpl.INT);
				flag = cImpl.update();
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::doInsertScore " + ex.getMessage());
			cDn.closeCn();
			cImpl.closeStmt();
		}finally{
			cImpl.closeStmt();
			cDn.closeCn();
		}
		return flag;
	}
	
	/**
	 * Description：在指定目录下为每个附件生成一个独立的子目录
	 * @param pa_path 指定目录
	 * @return 带子目录的完整目录结构
	 */
	public static String getNewDir(String pa_path){
		String newDir = "";
		String thisDay = CDate.getThisday();
		int randomNum = 0;
		randomNum = (int)(Math.random()*100000);
		newDir = thisDay + Integer.toString(randomNum);
		pa_path.replaceAll("/","\\");
		
		File fileDir = new File(pa_path + newDir);
		if(!fileDir.exists()){
			fileDir.mkdirs();
			newDir = pa_path + newDir;
		}else{
			newDir = getNewDir(pa_path);
		}
		newDir += "\\";
		return newDir ;
	}
	
	
	
	
	
	/**
	 * 取得给出的表的最大值
	 * 
	 * @param tableName
	 *            表名
	 * @return int 主键的最大值
	 */
	private int getMaxID(String tablename){
		int maxId = 1;
		CDataCn cDn = new CDataCn("oracle");
		CDataImpl dImpl = new CDataImpl(cDn);
		Vector vector = null;
		try{
			vector = dImpl.splitPage("select rc_maxid from tb_rowcount where rc_tablename = '"+ tablename +"'",5,1);
			if(vector != null){
				maxId = Integer.parseInt(((Hashtable)vector.get(0)).get("rc_maxid").toString());
			}
		}catch(Exception ex){
			System.out.println("SQLEXception::getMaxID " + ex.getMessage());
			cDn.closeCn();
			dImpl.closeStmt();
		}finally{
			cDn.closeCn();
			dImpl.closeStmt();
		}
		return maxId;
	}
	
	public static void main(String args[]){
		String xmls = "<?xml version=\"1.0\" encoding=\"GBK\"?><DEPTWEB><TB_CONTENT><CT_TITLE>你好，测试</CT_TITLE><CT_CONTENT>你好，测试内容</CT_CONTENT><CT_CREATE_TIME/><CT_SOURCE/><DT_ID>46</DT_ID><SJ_ID>30363</SJ_ID><ATTACH/></TB_CONTENT></DEPTWEB>";
		XmlIntoTable xit = new XmlIntoTable();
		boolean xx = xit.doInsertTable2(xmls);
		System.out.println("-----------over----------"+xx);
	}
	
}
