/**
 * @author hh
 * 2006-08-30
 * 将数据库中原本只有附件原始名称的数据增加一个随机生成的附件名称存入对应的数据库中
 * 同时将文件夹中存放的附件原始名称改名为随机生成的附件名称
 * 查询出数据表对应文件夹下的所有数据,依次去对应文件夹下取得对应的文件,
 * 然后富于此文件新的附件随机名称,将随机名称存入到指定的数据表的字段中
 */
package com.website;

import java.io.File;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Hashtable;
import java.util.Vector;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

public class ChangeAttachName {
	
	String realPath = "J:\\DefaultWebApp";			//文件存放目录
	
	/**
	 * 修改tb_infofile表下的数据
	 * 同时修改对应文件夹attach\\workattach\\下的文件名称
	 */
	public void cInfofile() {
		String path = realPath + "\\attach\\workattach\\";		//文件存放路径
		String if_path = "";									//随机生成的文件夹名称
		String strDate = "";									//随机生成的文件夹名称的前10位,及生成日期
		String fileName = "";									//文件名称
		String strPath = "";									//文件的全路径
		String rdName = "";										//随机生成的文件名称
		String if_id = "";										//自动生成编号
		int kk = 0;												//成功更新的数据记录条数
		int wrongI = 0;											//记录错误条数	
		int wrongJ = 0;											//修改数据库出错的记录条数
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		dCn.beginTrans();
		String sql = "select if_id,if_nick_name,if_path from tb_infofile";
		try {
			ResultSet rs = dImpl.executeQuery(sql);
			while (rs.next()) {
				if_id = rs.getString("if_id");
				fileName = rs.getString("if_nick_name");
				if_path = rs.getString("if_path");
				if (!"".equals(if_path) && if_path != null) {
					strDate = if_path.length() > 11 ? if_path.substring(0,10) : if_path;					
				}
				strPath = path + if_path + "\\" + fileName;
				File file = new File(strPath);
				if (file.exists()) {
		   		 	int filenum =(int)(Math.random()*100000);
		   		    rdName = strDate + Integer.toString(filenum) + fileName.substring(fileName.lastIndexOf("."));
		    		File file1 = new File(path + if_path + "\\" + rdName);
		    		/*if (updateDate("update tb_infofile set if_name = '" + rdName + "' where if_id = '" + if_id + "'") == true) { 
		    			file.renameTo(file1);
		    			kk++;
		    		}
		    		else {
						System.out.println("-------------NOT UPDATE DATA if_id: " + if_id);
		    			wrongJ++;
		    		}*/
				}
				else {
					System.out.println("-------------NOT FIND FILE: " + strPath);
					wrongI++;
				}
			}
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("==========ChangeAttachName_cInfoFile function WRONG! " + e);
		}
		if (!"".equals(dCn.getLastErrString())) {
			System.out.println("==========MODIFY NOT SUCCESSFULLY!========");
			dCn.rollbackTrans();
		}
		else {
			System.out.println("==========MODIFY SUCCESSFULLY!========");
			System.out.println(">>>>>>>>>>>>TOTAL MODIFY UCCESSFULLY = " + kk);
			System.out.println(">>>>>>>>>>>>TOTAL NOT FIND THE FILE = " + wrongI);
			System.out.println(">>>>>>>>>>>>TOTAL NOT UPDATE DATA = " + wrongJ);
			dCn.commitTrans();
		}
		dImpl.closeStmt();
		dCn.closeCn();
	}
	
	/**
	 * 修改tb_appealattach表下的数据
	 * 同时修改对应文件夹attach\\workattach\\下的文件名称
	 */
	public void cAppealAttach() {
		String path = realPath + "\\attach\\workattach\\";		//文件存放路径
		String if_path = "";									//随机生成的文件夹名称
		String strDate = "";									//随机生成的文件夹名称的前10位,及生成日期
		String fileName = "";									//文件名称
		String strPath = "";									//文件的全路径
		String rdName = "";										//随机生成的文件名称
		String if_id = "";										//自动生成编号
		int kk = 0;												//成功更新的数据记录条数
		int wrongI = 0;											//记录错误条数	
		int wrongJ = 0;											//修改数据库出错的记录条数
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		dCn.beginTrans();
		String sql = "select aa_id,aa_fileName,aa_path from tb_appealattach where aa_im_name is null";
		try {
			ResultSet rs = dImpl.executeQuery(sql);
			while (rs.next()) {
				if_id = rs.getString("aa_id");
				fileName = rs.getString("aa_fileName");
				if_path = rs.getString("aa_path");
				if (!"".equals(if_path) && if_path != null) {
					strDate = if_path.length() > 11 ? if_path.substring(0,10) : if_path;					
				}
				strPath = path + if_path + "\\" + fileName;
				File file = new File(strPath);
				if (file.exists()) {
		   		 	int filenum =(int)(Math.random()*100000);
		   		    rdName = strDate + Integer.toString(filenum) + fileName.substring(fileName.lastIndexOf("."));
		    		File file1 = new File(path + if_path + "\\" + rdName);
		    		if (updateDate("update tb_appealattach set aa_im_name = '" + rdName + "' where aa_id = '" + if_id + "'") == true) { 
		    			file.renameTo(file1);
		    			kk++;
		    		}
		    		else {
						System.out.println("-------------NOT UPDATE DATA aa_id: " + if_id);
		    			wrongJ++;
		    		}
				}
				else {
					System.out.println("-------------NOT FIND FILE: " + strPath);
					wrongI++;
				}
			}
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("==========ChangeAttachName_cInfoFile function WRONG! " + e);
		}
		if (!"".equals(dCn.getLastErrString())) {
			System.out.println("==========MODIFY NOT SUCCESSFULLY!========");
			dCn.rollbackTrans();
		}
		else {
			System.out.println("==========MODIFY SUCCESSFULLY!========");
			System.out.println(">>>>>>>>>>>>TOTAL MODIFY UCCESSFULLY = " + kk);
			System.out.println(">>>>>>>>>>>>TOTAL NOT FIND THE FILE = " + wrongI);
			System.out.println(">>>>>>>>>>>>TOTAL NOT UPDATE DATA = " + wrongJ);
			dCn.commitTrans();
		}
		dImpl.closeStmt();
		dCn.closeCn();
	}
	
	/**
	 * 修改tb_workattach表下的数据
	 * 同时修改对应文件夹attach\\workattach\\下的文件名称
	 */
	public void cWorkAttach() {
		String path = realPath + "\\attach\\workattach\\";		//文件存放路径
		String if_path = "";									//随机生成的文件夹名称
		String strDate = "";									//随机生成的文件夹名称的前10位,及生成日期
		String fileName = "";									//文件名称
		String strPath = "";									//文件的全路径
		String rdName = "";										//随机生成的文件名称
		String if_id = "";										//自动生成编号
		int kk = 0;												//成功更新的数据记录条数
		int wrongI = 0;											//记录错误条数	
		int wrongJ = 0;											//修改数据库出错的记录条数
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		dCn.beginTrans();
		String sql = "select wa_id,wa_fileName,wa_path from tb_workattach where wa_im_name is null";
		try {
			ResultSet rs = dImpl.executeQuery(sql);
			while (rs.next()) {
				if_id = rs.getString("wa_id");
				fileName = rs.getString("wa_fileName");
				if_path = rs.getString("wa_path");
				if (!"".equals(if_path) && if_path != null) {
					strDate = if_path.length() > 11 ? if_path.substring(0,10) : if_path;					
				}
				strPath = path + if_path + "\\" + fileName;
				File file = new File(strPath);
				if (file.exists()) {
		   		 	int filenum =(int)(Math.random()*100000);
		   		    rdName = strDate + Integer.toString(filenum) + fileName.substring(fileName.lastIndexOf("."));
		    		File file1 = new File(path + if_path + "\\" + rdName);
		    		if (updateDate("update tb_workattach set wa_im_name = '" + rdName + "' where wa_id = '" + if_id + "'") == true) { 
		    			file.renameTo(file1);
		    			kk++;
		    		}
		    		else {
						System.out.println("-------------NOT UPDATE DATA wa_id: " + if_id);
		    			wrongJ++;
		    		}
				}
				else {
					System.out.println("-------------NOT FIND FILE: " + strPath);
					wrongI++;
				}
			}
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("==========ChangeAttachName_cInfoFile function WRONG! " + e);
		}
		if (!"".equals(dCn.getLastErrString())) {
			System.out.println("==========MODIFY NOT SUCCESSFULLY!========");
			dCn.rollbackTrans();
		}
		else {
			System.out.println("==========MODIFY SUCCESSFULLY!========");
			System.out.println(">>>>>>>>>>>>TOTAL MODIFY UCCESSFULLY = " + kk);
			System.out.println(">>>>>>>>>>>>TOTAL NOT FIND THE FILE = " + wrongI);
			System.out.println(">>>>>>>>>>>>TOTAL NOT UPDATE DATA = " + wrongJ);
			dCn.commitTrans();
		}
		dImpl.closeStmt();
		dCn.closeCn();
	}
	
	/**
	 * 更新传进来的sql语句
	 * @param sql
	 * @return
	 */
	public boolean updateDate(String sql) {
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);

		dCn.beginTrans();
		
		dImpl.executeUpdate(sql);
		System.out.println(sql);
		if (!"".equals(dCn.getLastErrString())) {
			System.out.println("==========UPDATE WRONG!========");
			dCn.rollbackTrans();
			dImpl.closeStmt();
			dCn.closeCn();
			return false;
		}
		else {
			dCn.commitTrans();
		}
		dImpl.closeStmt();
		dCn.closeCn();
		return true;
	}
	
	/**
	 * 将老网站tb_titlelinkconn表中的数据导入到新的表中来
	 * @throws SQLException 
	 */
	public void trans_titlelinkconn() throws SQLException {
		String tc_id = "";
		String ti_id = "";
		String cp_id = "";
		String dt_id = "";
		//String old_sql = "select * from tb_titlelinkconn";
		String old_sql = "select * from tb_titlelinkconn where ti_id in (512,513,516,521,533)";
		CDataCn dCnOo =  new CDataCn();
		Connection cn_old;
		Statement stmt_old;
		cn_old = dCnOo.getConnection();
		stmt_old = cn_old.createStatement(java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,java.sql.ResultSet.CONCUR_UPDATABLE);
		ResultSet rs_old = stmt_old.executeQuery(old_sql);
		
		while (rs_old.next()) {
			ti_id = rs_old.getString("ti_id");
			cp_id = rs_old.getString("cp_id");
			dt_id = rs_old.getString("dt_id");
			tc_id = insert_titlelinkconn(ti_id,cp_id,dt_id);
			if ("".equals(tc_id)) break;
			System.out.println(">>>>>>>>>>>>>>>>>> " + cp_id);
		}

		dCnOo.closeCn();
		
	}
	
	/**
	 * 在表tb_titlelinkconn中导入老表数据
	 * @param ti_id
	 * @param cp_id
	 * @param dt_id
	 * @return
	 */
	public String insert_titlelinkconn(String ti_id,String cp_id,String dt_id) {
		
		String tc_id = "";
		String sql = "";
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
				
		tc_id = dImpl.addNew("tb_titlelinkconn","tc_id",CDataImpl.PRIMARY_KEY_IS_VARCHAR);
		sql = "insert into tb_titlelinkconn (tc_id,ti_id,cp_id,dt_id) values ('" +
		      tc_id.substring(1,tc_id.length()) + "'," + ti_id + ",'" + cp_id + "','" + dt_id + "')";
		//System.out.println("========== " + sql);
		dImpl.executeUpdate(sql);
		/*
		dImpl.setValue("ti_id",ti_id,CDataImpl.INT);
	    dImpl.setValue("cp_id",cp_id,CDataImpl.STRING);
	    dImpl.setValue("dt_id",dt_id,CDataImpl.STRING);
	    dImpl.update();
		*/
		
		dImpl.closeStmt();
		dCn.closeCn();
		return tc_id;
	}
	
	/**
	 * 取得tb_title中为街镇领导信箱的数据
	 * 将其中的ti_id作为tb_titlelinkconn表的ti_id关联
	 * @throws SQLException 
	 */
	public void trans_connproc() throws SQLException {
		String sql = "select ti_id,ti_name from tb_title where ti_upperid = (select ti_id from tb_title where ti_code='pudong_jz') order by ti_sequence";
		//String insertSql = "";
		String ti_id = "";
		String tc_id = "";
		String cp_id = "";
		String dt_id = "";
		String ti_name = "";
		ResultSet rs = null;
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		Vector vPage = dImpl.splitPage(sql,1000,1);
		if (vPage != null) {
			for (int i = 0;i < vPage.size();i++) {
				Hashtable content = (Hashtable)vPage.get(i);
				ti_id = content.get("ti_id").toString();
				ti_name = content.get("ti_name").toString();
				sql = "select cp_id,dt_id from tb_connproc where cp_name = '" + ti_name + "'";
				rs = dImpl.executeQuery(sql);
				if (rs.next()) {
					System.out.println("--------------ti_id = " + ti_id);
					cp_id = rs.getString("cp_id");
					dt_id = rs.getString("dt_id");
					tc_id = insert_titlelinkconn(ti_id,cp_id,dt_id);
					if ("".equals(tc_id)) break;
				}
				else {
					System.out.println(">>>>>>>>>>>>>ti_id = " + ti_id);
				}
			}
		}
		
		
		dImpl.closeStmt();
		dCn.closeCn();
	}
	
	/**
	 * 修改之前没有名称德信件
	 */
	public void cLetter() {
		String sql = "select cw_applyingname,cw_applyingdept,cw_subject from tb_connwork where cp_id is null";

		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		String cw_subject = "";			//镇长名称
		
		Vector vPage = dImpl.splitPage(sql,1000,1);
		if (vPage != null) {
			for (int i = 0;i < vPage.size();i++) {
				Hashtable content = (Hashtable)vPage.get(i);
				cw_subject = content.get("cw_subject").toString();
				System.out.println(">>>>>>>>>>>>> " + getName(cw_subject));
			}
		}
		
		dImpl.closeStmt();
		dCn.closeCn();
	}
	
	private String getName(String name) {
		String reStr = "";
		int subNameFirst = 0;
		int subNameEnd = 0;
		if (!"".equals(name)) {
			subNameFirst = name.indexOf(" ");
			subNameEnd = name.indexOf("的信");
			reStr = name.substring(subNameFirst,subNameEnd);
		}
		return reStr;
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ChangeAttachName can = new ChangeAttachName();
		can.cLetter();
		//System.out.println("------------ " + can.insert_titlelinkconn("1","2","3"));
		
	}

}
