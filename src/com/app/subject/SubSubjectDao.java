package com.app.subject;

import com.beyondbit.web.form.SubjectSubForm;
/**
 * 
 * @author chenjq
 * date: 2006-6-8
 * Description: 数据初始化dao接口
 */
public interface SubSubjectDao {	
	public void insert(SubjectSubForm form) throws SubjectChangeException;
	public void update(SubjectSubForm form) throws SubjectChangeException;
	public void delete(String id,String dtId) throws SubjectChangeException;
	public boolean checkBossid(String bossid,String dtId) throws SubjectChangeException;
	public String getIdByBossAndDt(String bossid,String dtId) throws SubjectChangeException;
	public void cleanParentId(String dtId) throws SubjectChangeException;
	
}
