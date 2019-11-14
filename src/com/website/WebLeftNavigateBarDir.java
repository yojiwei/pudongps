package com.website;
import java.sql.Connection;
import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CTools;

import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.Hashtable;
import java.util.Vector;


public class WebLeftNavigateBarDir extends WebLeftNavigateAbstract implements WebLeftNavigate{
	
	private String sjDir,baseUrl,sjLayer,parDir;
	private Connection con;
	private String printHtml;
	
	public WebLeftNavigateBarDir(String sjDir,CDataCn dCn,String baseUrl){
		this.sjDir = sjDir;
		this.baseUrl = baseUrl;
		con = dCn.getConnection();	
	}
	
	public WebLeftNavigateBarDir(){
	}
	
	
	public void setParDir(String dir){
		this.parDir = dir;
	}
	
	public String getBaseUrl() {
		return baseUrl;
	}

	public void setBaseUrl(String baseUrl) {
		this.baseUrl = baseUrl;
	}
	
	public String getSjDir() {
		return sjDir;
	}

	public void setSjDir(String sjDir) {
		this.sjDir = sjDir;
	}

	public String getSjLayer() {
		return sjLayer;
	}

	public void setSjLayer(String sjLayer) {
		this.sjLayer = sjLayer;
	}
	
	public String createFirstLeftBar() {
		String returnValue = "";

		String value = LeftHtmlStyle.layerFirst;
		String [] tagArr = LeftHtmlStyle.originFirstTag;
		String [] repArr = new String [tagArr.length];    
		String sql = "select sj_id,sj_name,sj_url,sj_display_flag,sj_dir from tb_subject where sj_parentid=" +
					 "(select sj_id from tb_subject where sj_dir='" + this.sjDir + "') " +
					 "and sj_display_flag='0' order by sj_sequence";
		try {
			Statement stmt  = con.createStatement();			
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				String url = rs.getString("sj_url");
				String dir = rs.getString("sj_dir");
				dir=dir==null?"":dir;
				url=url==null?"":url;				
				repArr[0] = repFont(rs.getString("sj_name"),dir);
				repArr[2] = "fir-" + dir +"-";
				repArr[3] = createSecondLeftBar(dir,"-" + dir+"-");				
				repArr[4] = url.indexOf("http://")!=-1?"target='_blank'":"";
				//repArr[4] = url.indexOf("http://")!=-1?"target='_blank' title='" + rs.getString("sj_name") + "'":"title='" + rs.getString("sj_name") + "'";
				if(repArr[3].equals("")&&!url.equals("")) repArr[1] = dealLinkhref(url,"sj_dir=" + rs.getString("sj_dir") + "&pardir=" + this.parDir); 
				else if(!repArr[3].equals("")) repArr[1] = "javascript:expandGrid('" + repArr[2] + "')";
				else repArr[1] = "#";
				returnValue += replaceTag(value,tagArr,repArr);
			}
			rs.close();
			stmt.close();
			return returnValue;
		} catch (SQLException e) {
			System.out.println("createFirstLeftBar: " + sql);
			e.printStackTrace();
			return "";
		}
	}
	
	public String createSecondLeftBar(String sjDir,String objId){
		
		String returnValue = "";
		String value = LeftHtmlStyle.layerSecond;
		String [] tagArr = LeftHtmlStyle.originSecondTag;
		String [] repArr = new String [tagArr.length];
		String sql = "select sj_id,sj_name,sj_url,sj_display_flag,sj_dir from tb_subject where " +
					 "sj_parentid=(select sj_id from tb_subject where sj_dir='" + sjDir + "') " +
					 "and sj_display_flag='0' order by sj_sequence";
		try {
			Statement stmt1  = con.createStatement();
			ResultSet rs1 = stmt1.executeQuery(sql);
			int ii = 0;
			while(rs1.next()){
				ii++;
				String url = rs1.getString("sj_url");
				String dir = rs1.getString("sj_dir");
				dir=dir==null?"":dir;
				url=url==null?"":url;
				repArr[0] = rs1.getString("sj_name");
				if(repArr[0].length()>7) repArr[0] = repArr[0].substring(0,6) + "..";
					repArr[0] = repFont(repArr[0],dir);
				repArr[2] = "sec" + objId + dir + "-";
				repArr[3] = createThirdLeftBar(dir,objId + dir + "-");
				repArr[4] = url.indexOf("http://")!=-1 ? "target='_blank'" : "";
				if(repArr[3].equals("")&&!url.equals("")) repArr[1] = dealLinkhref(url,"sj_dir=" + rs1.getString("sj_dir") + "&pardir=" + this.parDir);
				else if(!repArr[3].equals("")) repArr[1] = "javascript:expandSecGrid('" + repArr[2] + "')";
				else repArr[1] = "#";
				
				//for hh
				repArr[5] = "title = '" + rs1.getString("sj_name") + "'";
				
				//repArr[5] = "sec" + objId + dir + "-";
				returnValue += replaceTag(value,tagArr,repArr);	
			}
			rs1.close();
			stmt1.close();
			if(ii!=0)				
				return returnValue;
			else
				return "";
			
			
		} catch (SQLException e) {	
			System.out.println("createSecondLeftBar: " + sql);		
			e.printStackTrace();
			return "";
		}
		
	}
	
	private String createThirdLeftBar(String sjDir,String objId){
		
		String returnValue = "";
		String sunValue = "";
		String parValue = LeftHtmlStyle.layerThirdParent;
		String [] parTagArr = LeftHtmlStyle.thirdParentTag;
		String [] parRepArr = new String [parTagArr.length];
		String value = LeftHtmlStyle.layerThirdSon;
		String [] tagArr = LeftHtmlStyle.thirdSonTag;
		String [] repArr = new String [tagArr.length];
		String sql = "select sj_id,sj_name,sj_url,sj_display_flag,sj_dir from tb_subject " +
					 "where sj_parentid=(select sj_id from tb_subject where sj_dir='" + sjDir + "') " +
					 "and sj_display_flag='0' order by sj_sequence";
		
		try { 
			Statement stmt2  = con.createStatement();
			ResultSet rs2 = stmt2.executeQuery(sql);
			int jj=0;
			while(rs2.next()){
				repArr[0] = rs2.getString("sj_name");
				if(repArr[0].length()>7) repArr[0] = repArr[0].substring(0,6) + "..";
				String url = rs2.getString("sj_url");
				String dir = rs2.getString("sj_dir");
				repArr[0] = repFont(repArr[0],dir);
				dir=dir==null?"":dir;
				url=url==null?"":url;
				repArr[1] = url.equals("")?"#":dealLinkhref(url,"sj_dir=" + rs2.getString("sj_dir") + "&pardir=" + this.parDir);
				//repArr[3] = url.indexOf("http://")!=-1?"target='_blank'":"";
				repArr[3] = url.indexOf("http://")!=-1?"target='_blank' title='" + rs2.getString("sj_name") + "'":"title='" + rs2.getString("sj_name") + "'";
				repArr[2] = "thd" + objId + dir + "-";
				sunValue += replaceTag(value,tagArr,repArr);
				jj++;
			}
			rs2.close();
			stmt2.close();
			parRepArr[0] = "sec" + sjDir;
			parRepArr[1] = sunValue;
			returnValue = replaceTag(parValue,parTagArr,parRepArr);
			if(jj!=0)
				return returnValue;
			else
				return "";
		} catch (SQLException e) {	
			System.out.println("createThirdLeftBar: " + sql);		
			e.printStackTrace();
			return "";
			
		}
		// 
	}
		
	public static void main(String [] args) {
		/*
		System.out.println("start");
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		String sql = "select sj_id,sj_dir from tb_subject where sj_parentid = (select sj_id from " +
					 "tb_subject where sj_dir='shpd')";
		Vector vect = dImpl.splitPageOpt(sql,1000,1);
		WebLeftNavigate barObj = null;

		if(vect!=null){
			for(int i=0;i<vect.size();i++) {
				Hashtable content11 = (Hashtable)vect.get(i);
				//System.out.println("<div id='par" + content11.get("sj_dir").toString() +"'>");
				barObj = new WebLeftNavigateBarDir(content11.get("sj_dir").toString(),dCn,"index.jsp");
				barObj.setParDir(content11.get("sj_dir").toString());
				barObj.createFirstLeftBar();
				//System.out.println(barObj.createFirstLeftBar());
				//System.out.println("</div>");
				//System.out.println("<br>");
			}
		}
		System.out.println("end");
		*/
	}
}
