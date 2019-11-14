package com.userdeptsevice;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.emailService.CASUtil;
import com.util.CTools;

/**
 * 部门同步操作
 * @author Administrator
 * 部门操作对应部门ID
 */
public class DeptService {
	//
	CDataCn dCn = null;
	CDataImpl dImpl = null;
	
	public DeptService(){}
	//
	public String getDeptService(String deptXmls){
		DeptModel deptmodel = new DeptModel();
		try{
			System.out.println("deptModel------------"+deptXmls);
			String action = CASUtil.getUserColumn(deptXmls, "UIACTION");
			deptmodel.setDt_id(CTools.dealNumber(CASUtil.getUserColumn(deptXmls, "DTID")));//部门ID
			deptmodel.setDt_name(CTools.dealNull(CASUtil.getUserColumn(deptXmls, "DTNAME")));//部门名称
			deptmodel.setDt_parentid(CTools.dealNumber(CASUtil.getUserColumn(deptXmls, "DTPARENTID")));//上级部门ID
			deptmodel.setDt_operid(CTools.dealNull(CASUtil.getUserColumn(deptXmls, "DTOPERID")));//部门CODE组织机构代码
			deptmodel.setDt_shortname(CTools.dealNull(CASUtil.getUserColumn(deptXmls, "DTSHORTNAME")));//部门简称
			//deptmodel.setDt_sequence(CTools.dealNumber(CASUtil.getUserColumn(deptXmls, "DTSEQUENCE")));//部门排序
			deptmodel.setDt_iswork(CTools.dealNumber(CASUtil.getUserColumn(deptXmls, "DTISWORK")));//是否前台显示1是0否
			//dt_infoopendept  是否信息公开受理、转办单位1是0否(浦东.net后来没有传递这个字段值过来)
			//操作
			
			if (action.equals("add")) { 
				String isadd = addDept(deptmodel);//去新增部门
				return isadd;
			}else if(action.equals("update")){
				String isupdate = updateDept(deptmodel);//去修改部门
				return isupdate;
			}else if(action.equals("delete")){
				String isdelete = deleteDept(deptmodel);//去删除部门
				return isdelete;
			}
		}catch(Exception ex){
			ex.printStackTrace();
			return "--------"+ex.toString();
		}
		return "action is failed!";
	}
	/**
	 * 新增部门
	 */
	public String addDept(DeptModel depts){
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			dImpl.addNewValue("tb_deptinfo", "dt_id", Integer.parseInt(depts.getDt_id()));
			//dImpl.addNew("tb_deptinfo", "dt_id");
			dImpl.setValue("dt_name",depts.getDt_name(),CDataImpl.STRING);//部门名称
			dImpl.setValue("dt_parent_id",depts.getDt_parentid(),CDataImpl.STRING);//部门上级ID
			dImpl.setValue("dt_operid",depts.getDt_operid(),CDataImpl.STRING);//部门CODE
			dImpl.setValue("dt_shortname",depts.getDt_shortname(),CDataImpl.STRING);//部门简称
			dImpl.setValue("dt_iswork",depts.getDt_iswork(),CDataImpl.STRING);//是否前台显示1是0否
			dImpl.setValue("dt_infoopendept","0",CDataImpl.STRING);//是否信息公开受理、转办单位1是0否*另加
			//dImpl.setValue("dt_sequence",depts.getDt_sequence(),CDataImpl.STRING);//部门排序
			dImpl.update();
		} catch (Exception ee) {
			return "add-dept----"+ee.toString();
		} finally {
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return "ok";
	}
	/**
	 * 修改部门
	 */
	public String updateDept(DeptModel depts){
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			dImpl.edit("tb_deptinfo", "dt_id",depts.getDt_id());
			dImpl.setValue("dt_name",depts.getDt_name(),CDataImpl.STRING);//部门名称
			dImpl.setValue("dt_parent_id",depts.getDt_parentid(),CDataImpl.STRING);//部门上级ID
			dImpl.setValue("dt_operid",depts.getDt_operid(),CDataImpl.STRING);//部门CODE
			dImpl.setValue("dt_shortname",depts.getDt_shortname(),CDataImpl.STRING);//部门简称
			dImpl.setValue("dt_iswork",depts.getDt_iswork(),CDataImpl.STRING);//是否前台显示1是0否
			//dImpl.setValue("dt_sequence",depts.getDt_sequence(),CDataImpl.STRING);//部门排序
			dImpl.update();
		} catch (Exception ee) {
			ee.printStackTrace();
			return "update-dept----"+ee.toString();
		} finally {
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return "ok";
	}
	/**
	 * 删除部门
	 */
	public String deleteDept(DeptModel depts){
		try {
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
			dImpl.delete("tb_deptinfo","dt_id",depts.getDt_id());
		} catch (Exception ee) {
			ee.printStackTrace();
			return "delete-dept----"+ee.toString();
		} finally {
			dImpl.closeStmt();
			dCn.closeCn();
		}
		return "ok";
	}
}
