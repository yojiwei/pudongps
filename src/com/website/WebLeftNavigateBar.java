package com.website;
import java.sql.Connection;
import com.component.database.CDataCn;
import com.util.CTools;

import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;


public class WebLeftNavigateBar  extends WebLeftNavigateAbstract implements WebLeftNavigate{
	
	private String sjId,baseUrl,sjLayer,parDir;
	private Connection con;
	private String printHtml;
	private Statement stmt;
	private ResultSet rs;
	
	public WebLeftNavigateBar(String sjId,CDataCn dCn,String baseUrl){
		this.sjId = sjId;
		this.baseUrl = baseUrl;
		con = dCn.getConnection();	
	}
	
	public WebLeftNavigateBar(){
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
	
	public String getSjId() {
		return sjId;
	}

	public void setSjId(String sjId) {
		this.sjId = sjId;
	}

	public String getSjLayer() {
		return sjLayer;
	}

	public void setSjLayer(String sjLayer) {
		this.sjLayer = sjLayer;
	}
	
	public String createFirstLeftBar(){
		String returnValue = "";
		
		String value = LeftHtmlStyle.layerFirst;
		String [] tagArr = LeftHtmlStyle.originFirstTag;
		String [] repArr = new String [tagArr.length];
		
		try {
			stmt  = con.createStatement();			
			rs = stmt.executeQuery("select sj_id,sj_name,sj_url,sj_display_flag,sj_dir from tb_subject where sj_parentid='" + this.sjId + "' and sj_display_flag='0' order by sj_sequence");
			while(rs.next()){
				String url = rs.getString("sj_url");
				url=url==null?"":url;
				repArr[0] = rs.getString("sj_name");
				repArr[2] = "fir-" + rs.getString("sj_id")+"-";
				repArr[3] = createSecondLeftBar(rs.getString("sj_id"),"-" + rs.getString("sj_id")+"-");
				if(repArr[3].equals("")) repArr[1] = dealLinkhref(url,"sj_id=" + rs.getString("sj_id") + "&pardir=" + this.parDir);					
				else repArr[1] = "javascript:expandGrid('" + repArr[2] + "')";
				returnValue += replaceTag(value,tagArr,repArr);
			}
			return returnValue;
		} catch (SQLException e) {			
			e.printStackTrace();
			return "";
		}
	}
	
	public String createSecondLeftBar(String sjId,String objId){
		
		String returnValue = "";
		String value = LeftHtmlStyle.layerSecond;
		String [] tagArr = LeftHtmlStyle.originSecondTag;
		String [] repArr = new String [tagArr.length];
		try {
			Statement stmt1  = con.createStatement();			
			ResultSet rs1 = stmt1.executeQuery("select sj_id,sj_name,sj_url,sj_display_flag,sj_dir from tb_subject where sj_parentid='" + sjId + "' and sj_display_flag='0' order by sj_sequence");
			int ii = 0;
			while(rs1.next()){
				ii++;
				String url = rs1.getString("sj_url");
				url=url==null?"":url;
				repArr[0] = rs1.getString("sj_name");
				repArr[2] = "sec" + objId + rs1.getString("sj_id") + "-";
				repArr[3] = createThirdLeftBar(rs1.getString("sj_id"),objId + rs1.getString("sj_id") + "-");
				if(repArr[3].equals("")) repArr[1] = url + "?sj_id=" + rs1.getString("sj_id") + "&pardir=" + this.parDir; 
				else repArr[1] = "javascript:expandSecGrid('" + repArr[2] + "')";
				repArr[4] = "sec" + objId + rs1.getString("sj_id") + "-";
				returnValue += replaceTag(value,tagArr,repArr);				
			}
			if(ii!=0)
				return returnValue;
			else
				return "";
			
			
		} catch (SQLException e) {			
			e.printStackTrace();
			return "";
		}
		
	}
	
	private String createThirdLeftBar(String sjId,String objId){
		
		String returnValue = "";
		String sunValue = "";
		String parValue = LeftHtmlStyle.layerThirdParent;
		String [] parTagArr = LeftHtmlStyle.thirdParentTag;
		String [] parRepArr = new String [parTagArr.length];
		String value = LeftHtmlStyle.layerThirdSon;
		String [] tagArr = LeftHtmlStyle.thirdSonTag;
		String [] repArr = new String [tagArr.length];
		
		try {
			Statement stmt2  = con.createStatement();
			ResultSet rs2 = stmt2.executeQuery("select sj_id,sj_name,sj_url,sj_display_flag,sj_dir from tb_subject where sj_parentid='" + sjId + "' and sj_display_flag='0' order by sj_sequence");
			int jj=0;
			while(rs2.next()){
				repArr[0] = rs2.getString("sj_name");
				if(repArr[0].length()>7) repArr[0] = repArr[0].substring(0,5) + "..";
				String url = rs2.getString("sj_url");
				url=url==null?"":url;
				repArr[1] = url;
				repArr[2] = "thd" + objId + rs2.getString("sj_id") + "-";
				sunValue += replaceTag(value,tagArr,repArr);
				jj++;
			}
			parRepArr[0] = "sec" + sjId;
			parRepArr[1] = sunValue;
			returnValue = replaceTag(parValue,parTagArr,parRepArr);
			
			if(jj!=0)
				return returnValue;
			else
				return "";
			
		} catch (SQLException e) {			
			e.printStackTrace();
			return "";
			
		}
		// 
	}
	
	public static void main(String [] args){
		CDataCn dCn = new CDataCn();
		WebLeftNavigateBar barObj = new WebLeftNavigateBar("293",dCn,"index.jsp");
		System.out.print(barObj.createFirstLeftBar());
		dCn.closeCn();
	}
}
