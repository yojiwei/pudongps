package com.app.event;

import com.component.database.CDataCn;
import com.beyondbit.soft2.utils.XMLUtil;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.xpath.XPathResult;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;

public class AppEventInform {
	
	private String informMessages="",dtId="",urId="";
	private CDataCn dCn = null;
	private Connection con = null;

	public AppEventInform(String dtId,String urId,CDataCn dCn){
		setDtId(dtId);
		setDCn(dCn);
		setUrId(urId);
		
	}
	
	public String getInformMessages() {
		return informMessages;
	}

	public void setInformMessages(String informMessages) {
		this.informMessages = informMessages;
	}

	public String getDtId() {
		return dtId;
	}

	public void setDtId(String dtId) {
		this.dtId = dtId;
	}

	public void setDCn(CDataCn cn) {
		con = cn.getConnection();
	}
	
	public void operation(HttpServletRequest request){		
		String modelName = "";
		String modelUrl = "";
		String modelId = "";
		try{
			
			Document doc = XMLUtil.getDocument(request.getRealPath("") + "\\WEB-INF\\" + "event-config.xml"); 
			XPathResult result = XMLUtil.parseConfig(doc, "//appevents/*");
			Node node;
			while ( (node = result.iterateNext()) != null){	        	
	        	modelName = node.getAttributes().getNamedItem("name").getNodeValue();
	        	modelUrl = node.getAttributes().getNamedItem("url").getNodeValue();
	        	modelId = node.getAttributes().getNamedItem("modelid").getNodeValue();
	        	if(hasModelRole(modelId)){
	        		AppEvent obj = AppEventFactory.getInstance(node.getAttributes().getNamedItem("class").getNodeValue());
	        		this.informMessages += "<tr class='line-even' width='100%' colspan='2'><td valign='center' width='15%' align='left'>&nbsp;&nbsp;" 
	        					+ modelName + "&nbsp;&nbsp;:<a href='" + modelUrl + "'>" + obj.createInformation(this.dtId,this.con) + "</a>" +
	        					"</td></tr>";
	        	}
	        }
		}
		catch(Exception e){
			
			e.printStackTrace();
		}
	}
	

	
	private boolean hasModelRole(String modelId){
		String sql = "select tr_id from tb_functionrole where ft_id='" + modelId + "' and " +
				"exists (select tr_id from tb_roleinfo where tb_functionrole.tr_id = tb_roleinfo.tr_id " +
				"and tr_userids like '%," + urId + ",%')";
		System.out.print(sql);
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) return true;
			else return false;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		finally{
			try {
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		

		
	}
	
	public String getUrId() {
		return urId;
	}

	public void setUrId(String urId) {
		this.urId = urId;
	}
	
	public static void main(String [] args){
		CDataCn dCn = new CDataCn();
		AppEventInform inform = new AppEventInform("107","4",dCn);
		//inform.operation();
		System.out.println(inform.getInformMessages());
		dCn.closeCn();
	}

}
