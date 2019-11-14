package com.website;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.component.database.CDataCn;
import com.util.CTools;

public class ZXWebLeftBarDir extends WebLeftNavigateAbstract implements WebLeftNavigate {

	private String sjDir,baseUrl,sjLayer,parDir;
	private Connection con;
	private String printHtml;
	
	public ZXWebLeftBarDir(String sjDir,CDataCn dCn,String baseUrl){
		this.sjDir = sjDir;
		this.baseUrl = baseUrl;
		con = dCn.getConnection();	
	}
	
	public ZXWebLeftBarDir(){
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
	
	public String createFirstLeftBar(){
		String returnValue = "";
		
		String value = LeftHtmlStyle.layerZXFirst;
		String [] tagArr = LeftHtmlStyle.originZXFirstTag;
		String [] repArr = new String [tagArr.length];
		
		try {
			Statement stmt  = con.createStatement();			
			ResultSet rs = stmt.executeQuery("select sj_id,sj_name,sj_url,sj_display_flag,sj_dir from tb_subject where sj_parentid=" +
					"(select sj_id from tb_subject where sj_dir='" + this.sjDir + "') " +
							"and sj_display_flag='0' order by sj_sequence");
			while(rs.next()){
				String url = rs.getString("sj_url");
				String dir = rs.getString("sj_dir");
				dir=dir==null?"":dir;
				url=url==null?"":url;				
				repArr[0] = repFont(rs.getString("sj_name"),dir);
				//if(repArr[0].length()>6) repArr[0] = repArr[0].substring(0,5) + "..";
				repArr[2] = "fir-" + dir +"-";
				repArr[3] = createSecondLeftBar(dir,"-" + dir+"-");
				repArr[4] = url.indexOf("http://")!=-1?"target='_blank'":"";
				if(repArr[3].equals("")&&!url.equals("")) repArr[1] = dealLinkhref(url,"sj_dir=" + rs.getString("sj_dir") + "&pardir=" + this.parDir); 
				else if(!repArr[3].equals("")) repArr[1] = "javascript:expandGrid('" + repArr[2] + "')";
				else repArr[1] = "#";
		
				returnValue += replaceTag(value,tagArr,repArr);
			}
			rs.close();
			stmt.close();
			return returnValue;
		} catch (SQLException e) {			
			e.printStackTrace();
			return "";
		}
	}
	
	public String createSecondLeftBar(String sjId,String objId){
		
		String returnValue = "";
		String value = LeftHtmlStyle.layerZXSecond;
		String [] tagArr = LeftHtmlStyle.originZXSecondTag;
		String [] repArr = new String [tagArr.length];
		try {
			Statement stmt1  = con.createStatement();			
			ResultSet rs1 = stmt1.executeQuery("select sj_id,sj_name,sj_url,sj_display_flag,sj_dir from tb_subject where " +
					"sj_parentid=(select sj_id from tb_subject where sj_dir='" + sjId + "') " +
							"and sj_display_flag='0' order by sj_sequence");
			int ii = 0;
			while(rs1.next()){
				ii++;
				String url = rs1.getString("sj_url");
				String dir = rs1.getString("sj_dir");
				dir=dir==null?"":dir;
				url=url==null?"":url;
				repArr[0] = rs1.getString("sj_name");
				if(repArr[0].length()>6) repArr[0] = repArr[0].substring(0,6) + "..";
				repArr[0] = repFont(repArr[0],dir);
				repArr[2] = "sec" + objId + dir + "-";
				repArr[3] = createThirdLeftBar(dir,objId + dir + "-");
				repArr[4] = url.indexOf("http://")!=-1?"target='_blank'":"";
				if(repArr[3].equals("")&&!url.equals("")) repArr[1] = dealLinkhref(url,"sj_dir=" + rs1.getString("sj_dir") + "&pardir=" + this.parDir); 
				else if(!repArr[3].equals("")) repArr[1] = "javascript:expandSecGrid('" + repArr[2] + "')";
				else repArr[1] = "#";

				//for hh
				repArr[4] = "title='" + rs1.getString("sj_name") + "'";
				//repArr[4] = "sec" + objId + dir + "-";
				returnValue += replaceTag(value,tagArr,repArr);				
			}
			rs1.close();
			stmt1.close();
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
		String parValue = LeftHtmlStyle.layerZXThirdParent;
		String [] parTagArr = LeftHtmlStyle.thirdZXParentTag;
		String [] parRepArr = new String [parTagArr.length];
		String value = LeftHtmlStyle.layerZXThirdSon;
		String [] tagArr = LeftHtmlStyle.thirdZXSonTag;
		String [] repArr = new String [tagArr.length];
		
		try {
			Statement stmt2  = con.createStatement();
			ResultSet rs2 = stmt2.executeQuery("select sj_id,sj_name,sj_url,sj_display_flag,sj_dir from tb_subject " +
					"where sj_parentid=(select sj_id from tb_subject where sj_dir='" + sjId + "') " +
							"and sj_display_flag='0' order by sj_sequence");
			int jj=0;
			while(rs2.next()){
				repArr[0] = rs2.getString("sj_name");
				if(repArr[0].length()>6) repArr[0] = repArr[0].substring(0,6) + "..";
				String url = rs2.getString("sj_url");
				String dir = rs2.getString("sj_dir");
				dir=dir==null?"":dir;
				url=url==null?"":url;
				repArr[0] = repFont(repArr[0],dir);
				repArr[1] = url.equals("")?"#":dealLinkhref(url,"sj_dir=" + rs2.getString("sj_dir") + "&pardir=" + this.parDir);
				
				//if(repArr[3].equals(""))
				
				repArr[2] = "thd" + objId + dir + "-";
				repArr[3] = url.indexOf("http://")!=-1?"target='_blank' title='" + rs2.getString("sj_name") + "'":"title='" + rs2.getString("sj_name") + "'";
				//repArr[3] = url.indexOf("http://")!=-1?"target='_blank'":"";
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
			e.printStackTrace();
			return "";
			
		}
		// 
	}
}
