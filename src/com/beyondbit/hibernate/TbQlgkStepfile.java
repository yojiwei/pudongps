package com.beyondbit.hibernate;

import java.io.Serializable;
import java.math.BigDecimal;
import org.apache.commons.lang.builder.ToStringBuilder;


/** @author Hibernate CodeGenerator */
public class TbQlgkStepfile implements Serializable {

    /** identifier field */
    private Integer sfid;

    /** nullable persistent field */
    private BigDecimal sid;

    /** nullable persistent field */
    private BigDecimal psfid;

    /** nullable persistent field */
    private String ismust;

    /** nullable persistent field */
    private String isinput;

    /** nullable persistent field */
    private String isoutput;

    /** full constructor */
    public TbQlgkStepfile(Integer sfid, BigDecimal sid, BigDecimal psfid, String ismust, String isinput, String isoutput) {
        this.sfid = sfid;
        this.sid = sid;
        this.psfid = psfid;
        this.ismust = ismust;
        this.isinput = isinput;
        this.isoutput = isoutput;
    }

    /** default constructor */
    public TbQlgkStepfile() {
    }

    /** minimal constructor */
    public TbQlgkStepfile(Integer sfid) {
        this.sfid = sfid;
    }

    public Integer getSfid() {
        return this.sfid;
    }

    public void setSfid(Integer sfid) {
        this.sfid = sfid;
    }

    public BigDecimal getSid() {
        return this.sid;
    }

    public void setSid(BigDecimal sid) {
        this.sid = sid;
    }

    public BigDecimal getPsfid() {
        return this.psfid;
    }

    public void setPsfid(BigDecimal psfid) {
        this.psfid = psfid;
    }

    public String getIsmust() {
        return this.ismust;
    }

    public void setIsmust(String ismust) {
        this.ismust = ismust;
    }

    public String getIsinput() {
        return this.isinput;
    }

    public void setIsinput(String isinput) {
        this.isinput = isinput;
    }

    public String getIsoutput() {
        return this.isoutput;
    }

    public void setIsoutput(String isoutput) {
        this.isoutput = isoutput;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("sfid", getSfid())
            .toString();
    }

}
