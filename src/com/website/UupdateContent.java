/**
 * 更新指定记录tb_content表的ct_content字段的记录                            
 */
package com.website;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CTools;

public class UupdateContent {

	public CDataCn dCn;

	public CDataImpl dImpl;
	
	String sql = null;
	StringBuffer sb = null;
	ResultSet rs = null;

	public UupdateContent() {
		this.dCn = new CDataCn();
		this.dImpl = new CDataImpl(dCn);
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 更新结束
	 * 关闭链接
	 */
	public void endUpdate() {
		try {
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("UupdateContent_endUpdate IS WRONG: " + e);
		}
		this.dImpl.closeStmt();
		this.dCn.closeCn();
	}
	
	/**
	 * 取得所有指定sj_id栏目下的子栏目的记录
	 * @param sj_id
	 * @return
	 */
	public String getCtId(String sj_id) {
		sb = new StringBuffer();
		sql = "select ct_id from tb_contentpublish where sj_id in (select sj_id from tb_subject connect by prior sj_id = sj_parentid start with sj_id = " + sj_id + ")";
		rs = dImpl.executeQuery(sql);
		try {
			while (rs.next()) {
				sb.append(rs.getString("ct_id"));
				sb.append(",");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("UupdateContent_getCtid IS WRONG: " + e);
		}
		String ctIds = sb.toString();
		ctIds = ctIds.substring(0,ctIds.length()-1);
		return ctIds;
	}
	
	/**
	 * 根据指定的key将ctIds分割
	 * @param ctIds
	 * @param key
	 * @param field
	 * @param i
	 * @return
	 */
	public String checkLen(String ctIds,String key,String field,int i) {
		String str[] = ctIds.split(key);
		String id = null;
		sb = new StringBuffer(field + " in (");
		int k = 0;
		for (int j = 0;j < str.length;j++) {
			id = str[j];
			if (!"".equals(id) && id != null) {
				k++;
				sb.append(id + ",");
				if (k % i == 0) sb.append(") or " + field + " in (");
			}
		}
		id = sb.toString();
		id = CTools.replace(id,",)",")");
		id = id.substring(0,id.length() - 1) + ")";
		return id;
	}
	
	/**
	 * 查询所有ct_id下有rep的字符串替换成repResult字符串
	 * @param ctIds
	 * @param rep
	 * @param repResult
	 */
	public void selectAll(String ctIds,String rep,String repResult) {
		sql = "select ct_id,ct_content from tb_content where " + ctIds;
		String ct_id = null;
		String ct_content = null;	
		int totalUpdate = 0;
		rs = dImpl.executeQuery(sql);
		try {
			while (rs.next()) {
				ct_id = rs.getString("ct_id");
				ct_content = rs.getString("ct_content");
				if (checkCon(ct_content,rep)) {
					totalUpdate++;
					System.out.println("--ct_id=" + ct_id + " ct_content:" + ct_content);
					if (!replaceCon(ct_id,ct_content,rep,repResult)) 
						break;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("UupdateContent_updateCon IS WRONG: " + e);
		}
		System.out.println("更新数据结束，总共更新" + totalUpdate + "条信息");
	}
	
	/**
	 * 查询ct_content下是否有rep的字符串
	 * 如果有返回		true
	 * 没有则返回		false
	 * @param rep
	 * @param ct_content
	 * @return
	 */
	public boolean checkCon(String ct_content,String rep) {
		if (ct_content.indexOf(rep) != -1)
			return true;
		else
			return false;
	}
	
	/**
	 * 将查询的信息中有rep字符串的更新成repResult字段
	 * @param ct_id		
	 * @param content	内容
	 * @param rep		要替换的字符串
	 * @param repResult	替换成的字符串
	 * @return
	 */
	public boolean replaceCon(String ct_id,String content,String rep,String repResult) {
		boolean bool = false;
		CDataCn dCn = new CDataCn();
		CDataImpl dImpl = new CDataImpl(dCn);
		dCn.beginTrans();
		try {
		    dImpl.edit("tb_content","ct_id",ct_id);
	        //dImpl.setValue("ct_id",ct_id,CDataImpl.INT);
			content = CTools.replace(content,rep,repResult);
			System.out.println("==content: " + content);
			dImpl.setValue("ct_content",content,CDataImpl.SLONG);
	        dImpl.update();
			dCn.commitTrans();
			bool = true;
		}
		catch (Exception e) {
			dCn.rollbackTrans();
			bool = false;
			System.out.println("UupdateContent_replaceCon IS WRONG: " + e);
		}
		finally {
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return bool;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		UupdateContent upc = new UupdateContent();
		String ctIds = upc.getCtId("89");
		String key = ",";
		int i = 50;
		String field = "ct_id";
		String str = upc.checkLen(ctIds,key,field,i);
		String rep = ":7001";
		String repResult = "";
		upc.selectAll(str,rep,repResult);
		upc.endUpdate();
	}

}
