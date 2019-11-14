package com.beyondbit.hibernate;

import java.io.Serializable;
import java.math.BigDecimal;
import org.apache.commons.lang.builder.ToStringBuilder;


/** @author Hibernate CodeGenerator */
public class TbQlgkPowerstdstep implements Serializable {

    /** identifier field */
    private Integer stepid;

    /** nullable persistent field */
    private String stepname;

    /** nullable persistent field */
    private BigDecimal psid;

    /** nullable persistent field */
    private String rolename;

    /** nullable persistent field */
    private String prevstepid;

    /** nullable persistent field */
    private String nextstepid;

    /** nullable persistent field */
    private BigDecimal iskey;

    /** nullable persistent field */
    private BigDecimal isinner;

    /** nullable persistent field */
    private BigDecimal maxduetimelimit;

    /** nullable persistent field */
    private BigDecimal maxpslimit;

    /** nullable persistent field */
    private String groupname;

    /** nullable persistent field */
    private String des;

    /** nullable persistent field */
    private byte[] audiodesdata;

    /** nullable persistent field */
    private byte[] diagrampic;

    /** nullable persistent field */
    private String audiodesname;

    /** nullable persistent field */
    private String audiodestype;

    private String maxpslimitunit;

    /** persistent field */
    private com.beyondbit.hibernate.TbQlgkSubpowerstd tbQlgkSubpowerstd;
    
    /**  add by zhanglun 2009-2-17   */
   private String cbid;
   
   private TbQlgkCBUnit cbunit;//步骤与承办单位的多对一关系

	public TbQlgkCBUnit getCbunit() {
		return cbunit;
	}
	
	public void setCbunit(TbQlgkCBUnit cbunit) {
		this.cbunit = cbunit;
	}

	/***             add  end            */

	public String getCbid() {
		return cbid;
	}

	public void setCbid(String cbid) {
		this.cbid = cbid;
	}

	/** full constructor */
    public TbQlgkPowerstdstep(Integer stepid, String stepname, BigDecimal psid, String rolename, String prevstepid, String nextstepid, BigDecimal iskey, BigDecimal isinner, BigDecimal maxduetimelimit, BigDecimal maxpslimit, String groupname, String des, byte[] audiodesdata, byte[] diagrampic, String audiodesname, String audiodestype, com.beyondbit.hibernate.TbQlgkSubpowerstd tbQlgkSubpowerstd) {
        this.stepid = stepid;
        this.stepname = stepname;
        this.psid = psid;
        this.rolename = rolename;
        this.prevstepid = prevstepid;
        this.nextstepid = nextstepid;
        this.iskey = iskey;
        this.isinner = isinner;
        this.maxduetimelimit = maxduetimelimit;
        this.maxpslimit = maxpslimit;
        this.groupname = groupname;
        this.des = des;
        this.audiodesdata = audiodesdata;
        this.diagrampic = diagrampic;
        this.audiodesname = audiodesname;
        this.audiodestype = audiodestype;
        this.tbQlgkSubpowerstd = tbQlgkSubpowerstd;
    }

    /** default constructor */
    public TbQlgkPowerstdstep() {
    }

    /** minimal constructor */
    public TbQlgkPowerstdstep(Integer stepid, com.beyondbit.hibernate.TbQlgkSubpowerstd tbQlgkSubpowerstd) {
        this.stepid = stepid;
        this.tbQlgkSubpowerstd = tbQlgkSubpowerstd;
    }

    public Integer getStepid() {
        return this.stepid;
    }

    public void setStepid(Integer stepid) {
        this.stepid = stepid;
    }

    public String getStepname() {
        return this.stepname;
    }

    public void setStepname(String stepname) {
        this.stepname = stepname;
    }

    public BigDecimal getPsid() {
        return this.psid;
    }

    public void setPsid(BigDecimal psid) {
        this.psid = psid;
    }

    public String getRolename() {
        return this.rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename;
    }

    public String getPrevstepid() {
        return this.prevstepid;
    }

    public void setPrevstepid(String prevstepid) {
        this.prevstepid = prevstepid;
    }

    public String getNextstepid() {
        return this.nextstepid;
    }

    public void setNextstepid(String nextstepid) {
        this.nextstepid = nextstepid;
    }

    public BigDecimal getIskey() {
        return this.iskey;
    }

    public void setIskey(BigDecimal iskey) {
        this.iskey = iskey;
    }

    public BigDecimal getIsinner() {
        return this.isinner;
    }

    public void setIsinner(BigDecimal isinner) {
        this.isinner = isinner;
    }

    public BigDecimal getMaxduetimelimit() {
        return this.maxduetimelimit;
    }

    public void setMaxduetimelimit(BigDecimal maxduetimelimit) {
        this.maxduetimelimit = maxduetimelimit;
    }

    public BigDecimal getMaxpslimit() {
        return this.maxpslimit;
    }

    public void setMaxpslimit(BigDecimal maxpslimit) {
        this.maxpslimit = maxpslimit;
    }

    public String getGroupname() {
        return this.groupname;
    }

    public void setGroupname(String groupname) {
        this.groupname = groupname;
    }

    public String getDes() {
        return this.des;
    }

    public void setDes(String des) {
        this.des = des;
    }

    public byte[] getAudiodesdata() {
        return this.audiodesdata;
    }

    public void setAudiodesdata(byte[] audiodesdata) {
        this.audiodesdata = audiodesdata;
    }

    public byte[] getDiagrampic() {
        return this.diagrampic;
    }

    public void setDiagrampic(byte[] diagrampic) {
        this.diagrampic = diagrampic;
    }

    public String getAudiodesname() {
        return this.audiodesname;
    }

    public void setAudiodesname(String audiodesname) {
        this.audiodesname = audiodesname;
    }

    public String getAudiodestype() {
        return this.audiodestype;
    }

    public void setAudiodestype(String audiodestype) {
        this.audiodestype = audiodestype;
    }

    public com.beyondbit.hibernate.TbQlgkSubpowerstd getTbQlgkSubpowerstd() {
        return this.tbQlgkSubpowerstd;
    }

    public void setTbQlgkSubpowerstd(com.beyondbit.hibernate.TbQlgkSubpowerstd tbQlgkSubpowerstd) {
        this.tbQlgkSubpowerstd = tbQlgkSubpowerstd;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("stepid", getStepid())
            .toString();
    }
    public String getMaxpslimitunit() {
        return maxpslimitunit;
    }
    public void setMaxpslimitunit(String maxpslimitunit) {
        this.maxpslimitunit = maxpslimitunit;
    }

}
