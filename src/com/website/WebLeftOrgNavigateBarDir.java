package com.website;
import java.sql.Connection;
import com.component.database.CDataCn;
import com.util.CTools;

import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;


public class WebLeftOrgNavigateBarDir  extends WebLeftNavigateAbstract implements WebLeftNavigate{
	
	private String sjDir,baseUrl,sjLayer,parDir;
	private Connection con;
	
	public WebLeftOrgNavigateBarDir(String sjDir,CDataCn dCn,String baseUrl){
		this.sjDir = sjDir;
		this.baseUrl = baseUrl;
		con = dCn.getConnection();	
	}
	
	public WebLeftOrgNavigateBarDir(){
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
		
		String value = LeftHtmlStyle.layerOrgFirst;
		String [] tagArr = LeftHtmlStyle.originOrgFirstTag;
		String [] repArr = new String [tagArr.length];
		
		try {
			Statement stmt  = con.createStatement();			
			ResultSet rs = stmt.executeQuery("select sj_id,sj_name,sj_url,sj_display_flag,sj_dir from tb_subject where sj_parentid=" +
					"(select sj_id from tb_subject where sj_dir='" + this.sjDir + "') " +
							"and sj_display_flag='0' order by sj_sequence");
			int i= 0;
			while(rs.next()){
				String url = rs.getString("sj_url");
				String dir = rs.getString("sj_dir");
				dir=dir==null?"":dir;
				url=url==null?"":url;
				repArr[0] = repFont(rs.getString("sj_name"),dir);
				repArr[2] = "fir-" + dir +"-";
				repArr[3] = createSecondLeftBar(dir,"-" + dir+"-",i);
				repArr[4] = url.indexOf("http://")!=-1?"target='_blank'":"";
				
				if(repArr[3].equals("")&&!url.equals("")) repArr[1] = dealLinkhref(url,"sj_dir=" + rs.getString("sj_dir") + "&pardir=" + this.parDir); 
				else if(!repArr[3].equals("")) repArr[1] = "javascript:expandGrid('" + repArr[2] + "')";
				else repArr[1] = "#";
				
				returnValue += replaceTag(value,tagArr,repArr);
				i++;
			}
			rs.close();
			stmt.close();
			return returnValue;
		} catch (SQLException e) {			
			e.printStackTrace();
			return "";
		}
	}
	
	public String createSecondLeftBar(String sjDir,String objId,int org) {
		
		String returnValue = "";
		String value = LeftHtmlStyle.layerOrgSecond;
		String [] tagArr = LeftHtmlStyle.originOrgSecondTag;
		String [] repArr = new String [tagArr.length];
		try {
			Statement stmt1  = con.createStatement();			
			ResultSet rs1 = stmt1.executeQuery("select sj_id,sj_name,sj_url,sj_display_flag,sj_dir from tb_subject where " +
					"sj_parentid=(select sj_id from tb_subject where sj_dir='" + sjDir + "') " +
							"and sj_display_flag='0' order by sj_sequence");
			int ii = 0;
			while(rs1.next()){				
				String url = rs1.getString("sj_url");
				String dir = rs1.getString("sj_dir");
				dir=dir==null?"":dir;
				url=url==null?"":url;				
				repArr[0] = rs1.getString("sj_name");
				if(repArr[0].length()>7) repArr[0] = repArr[0].substring(0,6) + "..";
				repArr[0] = repFont(repArr[0],dir);
				repArr[2] = "sec" + objId + dir + "-";
				repArr[3] = createThirdLeftBar(dir,objId + dir + "-",org,ii);
				repArr[4] = url.indexOf("http://")!=-1?"target='_blank'":"";
				repArr[6]=(org!=0)?"display:none":"display:";
				
				if(repArr[3].equals("")&&!url.equals("")) repArr[1] = dealLinkhref(url,"sj_dir=" + rs1.getString("sj_dir") + "&pardir=" + this.parDir); 
				else if(!repArr[3].equals("")) repArr[1] = "javascript:expandSecGrid('" + repArr[2] + "')";
				else repArr[1] = "#";
				
				repArr[4] = "title = '" + rs1.getString("sj_name") + "'";
				//repArr[4] = "sec" + objId + dir + "-";
				returnValue += replaceTag(value,tagArr,repArr);
				ii++;
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
	
	private String createThirdLeftBar(String sjDir,String objId,int org,int sec){
		
		String returnValue = "";
		String sunValue = "";
		String parValue = LeftHtmlStyle.layerThirdParent;
		String [] parTagArr = LeftHtmlStyle.thirdParentTag;
		String [] parRepArr = new String [parTagArr.length];
		String value = LeftHtmlStyle.layerOrgThirdSon;
		String [] tagArr = LeftHtmlStyle.thirdOrgSonTag;
		String [] repArr = new String [tagArr.length];
		
		try {
			Statement stmt2  = con.createStatement();
			ResultSet rs2 = stmt2.executeQuery("select sj_id,sj_name,sj_url,sj_display_flag,sj_dir from tb_subject " +
					"where sj_parentid=(select sj_id from tb_subject where sj_dir='" + sjDir + "') " +
							"and sj_display_flag='0' order by sj_sequence");
			int jj=0;
			while(rs2.next()){
				repArr[0] = rs2.getString("sj_name");
				if(repArr[0].length()>7) repArr[0] = repArr[0].substring(0,6) + "..";				
				String url = rs2.getString("sj_url");
				String dir = rs2.getString("sj_dir");
				dir=dir==null?"":dir;
				repArr[0] = repFont(repArr[0],dir);
				url=url==null?"":url;
				repArr[1] = url.equals("")?"#":dealLinkhref(url,"sj_dir=" + rs2.getString("sj_dir") + "&pardir=" + this.parDir);
				repArr[2] = "thd" + objId + dir + "-";
				repArr[3] = url.indexOf("http://")!=-1?"target='_blank' title='" + rs2.getString("sj_name") + "'":"title='" + rs2.getString("sj_name") + "'";	
				repArr[4]=(org!=0||sec!=0)?"display:none":"display:";
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

	
	public static void main(String [] args){
//		CDataCn dCn = new CDataCn();
//		WebLeftOrgNavigateBarDir barObj = new WebLeftOrgNavigateBarDir("govOpen",dCn,"index.jsp");
//		System.out.print(barObj.createFirstLeftBar());
//		dCn.closeCn();
	}
}
