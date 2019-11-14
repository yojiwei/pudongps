package com.beyondbit.struts.form;

import org.apache.struts.action.ActionForm;
import org.apache.struts.upload.FormFile;

public class PowstdStepForm extends ActionForm{
    private FormFile file1;
    private FormFile file2;
    //步骤名称
    private String stepname;
    //角色名称
    private String rolename;
    //前一步骤
    private String prevstepid;
    //后一步骤
    private String nextstepid;
    //是否是关键字
    private String iskey;
    //是否内部步骤
    private String isinner;
    //最长办理时限
    private String maxduetimelimit;
    //最大权限
    private String maxpslimit;
    //最大权限单位
    private String maxpslimitunit;
    //分组名
    private String groupname;
    //备注
    private String des;
    //事项编号
    private String psid;
    //分标准编号
    private String spsid;
    //步骤编号
    private String stepid;



    public PowstdStepForm() {
    }
    public FormFile getFile1() {
        return file1;
    }
    public FormFile getFile2() {
        return file2;
    }
    public String getStepname() {
        return stepname;
    }
    public void setFile1(FormFile file1) {
        this.file1 = file1;
    }
    public void setFile2(FormFile file2) {
        this.file2 = file2;
    }
    public void setStepname(String stepname) {
        this.stepname = stepname;
    }
    public String getDes() {
        return des;
    }
    public void setDes(String des) {
        this.des = des;
    }
    public void setGroupname(String groupname) {
        this.groupname = groupname;
    }
    public String getGroupname() {
        return groupname;
    }
    public String getIsinner() {
        return isinner;
    }
    public void setIsinner(String isinner) {
        this.isinner = isinner;
    }
    public void setIskey(String iskey) {
        this.iskey = iskey;
    }
    public String getIskey() {
        return iskey;
    }
    public String getMaxduetimelimit() {
        return maxduetimelimit;
    }
    public void setMaxduetimelimit(String maxduetimelimit) {
        this.maxduetimelimit = maxduetimelimit;
    }
    public void setMaxpslimit(String maxpslimit) {
        this.maxpslimit = maxpslimit;
    }
    public String getMaxpslimit() {
        return maxpslimit;
    }
    public String getNextstepid() {
        return nextstepid;
    }
    public void setNextstepid(String nextstepid) {
        this.nextstepid = nextstepid;
    }
    public String getPrevstepid() {
        return prevstepid;
    }
    public void setPrevstepid(String prevstepid) {
        this.prevstepid = prevstepid;
    }
    public void setPsid(String psid) {
        this.psid = psid;
    }
    public String getPsid() {
        return psid;
    }
    public String getRolename() {
        return rolename;
    }
    public void setRolename(String rolename) {
        this.rolename = rolename;
    }
    public void setSpsid(String spsid) {
        this.spsid = spsid;
    }
    public String getSpsid() {
        return spsid;
    }
    public String getStepid() {
        return stepid;
    }
    public void setStepid(String stepid) {
        this.stepid = stepid;
    }

    public String getMaxpslimitunit() {
        return maxpslimitunit;
    }
    public void setMaxpslimitunit(String maxpslimitunit) {
        this.maxpslimitunit = maxpslimitunit;
    }
}
