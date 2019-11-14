package com.app.subject;

import java.util.Hashtable;

import com.beyondbit.web.form.SubjectSubForm;
import com.website.Messages;

/**
 * 栏目初始化dao实现类
 * @author chenjq	
 * @date  2006-06-08
 */
public class SubSubjectDaoImpl extends SubCDataImpl implements SubSubjectDao {

	/**
	 * 栏目新增初始化
	 */
	public void insert(SubjectSubForm form) throws SubjectChangeException {
		// TODO Auto-generated method stub		
		dImpl.executeUpdate("insert into tb_subjectsub (sj_id,sj_name,sj_bossid,dt_id,sj_parentid) values" +
				"('" + dImpl.getMaxId("tb_subjectsub") + "','" + form.getName() + "','" + form.getBossid() + "','" + form.getDtid() + "','0')");
	}

	/**
	 * 栏目修改
	 */
	public void update(SubjectSubForm form) throws SubjectChangeException {
		// TODO Auto-generated method stub
		if(!form.getBossid().equals(Messages.getString("subjectroot")))
			dImpl.executeUpdate("update tb_subjectsub set sj_name='" + form.getName() + "', " +
								"sj_bossid='" + form.getBossid() + "', dt_id='" + form.getDtid() + "'" +
								" where sj_id='" + form.getSjId() + "'");
	}
	
	/**
	 * 初始化删除
	 */
	public void delete(String id,String dtId) throws SubjectChangeException {
		// TODO Auto-generated method stub		
		dImpl.executeUpdate("delete from tb_subjectsub where sj_bossid not in (" + id + ") and dt_id='" + dtId + "'");
		

	}
	
	/**
	 * 判别新增、修改标示
	 */
	public boolean checkBossid(String id,String dtId) throws SubjectChangeException {
		// TODO Auto-generated method stub
		Hashtable content = dImpl.getDataInfo("select sj_id from tb_subjectsub where sj_bossid='" + id + "' and dt_id='" + dtId + "'");
		if(content!=null) return true;
		else return false;
	}
	
	/**
	 * 取栏目id
	 */
	public String getIdByBossAndDt(String bossid,String dtId) throws SubjectChangeException {
		Hashtable content = dImpl.getDataInfo("select sj_id from tb_subjectsub where sj_bossid='" + bossid + "' and dt_id='" + dtId + "'");
		System.out.println("select sj_id from tb_subjectsub where sj_bossid='" + bossid + "' and dt_id='" + dtId + "'");
		if(content!=null)
			return content.get("sj_id").toString();
		else
			return "";
	}
	
	/**
	 * 生成栏目树
	 */
	public void cleanParentId(String dtId) throws SubjectChangeException {
		   
		dImpl.executeUpdate("update tb_subjectsub sub set sj_parentid=" +
				"(select s.sj_id from tb_subjectsub s,tb_subject s2,tb_subject s3 " +
				"where s.sj_bossid=s2.sj_id and s3.sj_parentid=s2.sj_id and s3.sj_id=sub.SJ_BOSSID and s.dt_id='" + dtId + "') " +
				"where dt_id='" + dtId + "' and sj_bossid<>'" + Messages.getString("subjectroot") + "'");
		
		System.out.println("update tb_subjectsub sub set sj_parentid=" +
				"(select s.sj_id from tb_subjectsub s,tb_subject s2,tb_subject s3 " +
				"where s.sj_bossid=s2.sj_id and s3.sj_parentid=s2.sj_id and s3.sj_id=sub.SJ_BOSSID and s.dt_id='" + dtId + "') " +
				"where dt_id='" + dtId + "' and sj_bossid<>'" + Messages.getString("subjectroot") + "'");
	}
}
