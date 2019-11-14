package com.beyondbit.hibernate;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import org.apache.commons.lang.builder.ToStringBuilder;


/** @author Hibernate CodeGenerator */
public class TbQlgkPowerstdlog implements Serializable {

    /** identifier field */
    private BigDecimal id;

    /** nullable persistent field */
    private Date updatetime;

    /** nullable persistent field */
    private Integer powerstdId;

    /** nullable persistent field */
    private BigDecimal subpowerstdId;

    /** nullable persistent field */
    private BigDecimal powerprocessId;

    /** nullable persistent field */
    private BigDecimal updatetype;

    /** full constructor */
    public TbQlgkPowerstdlog(BigDecimal id, Date updatetime, Integer powerstdId, BigDecimal subpowerstdId, BigDecimal powerprocessId, BigDecimal updatetype) {
        this.id = id;
        this.updatetime = updatetime;
        this.powerstdId = powerstdId;
        this.subpowerstdId = subpowerstdId;
        this.powerprocessId = powerprocessId;
        this.updatetype = updatetype;
    }

    /** default constructor */
    public TbQlgkPowerstdlog() {
    }

    /** minimal constructor */
    public TbQlgkPowerstdlog(BigDecimal id) {
        this.id = id;
    }

    public BigDecimal getId() {
        return this.id;
    }

    public void setId(BigDecimal id) {
        this.id = id;
    }

    public Date getUpdatetime() {
        return this.updatetime;
    }

    public void setUpdatetime(Date updatetime) {
        this.updatetime = updatetime;
    }

    public Integer getPowerstdId() {
        return this.powerstdId;
    }

    public void setPowerstdId(Integer powerstdId) {
        this.powerstdId = powerstdId;
    }

    public BigDecimal getSubpowerstdId() {
        return this.subpowerstdId;
    }

    public void setSubpowerstdId(BigDecimal subpowerstdId) {
        this.subpowerstdId = subpowerstdId;
    }

    public BigDecimal getPowerprocessId() {
        return this.powerprocessId;
    }

    public void setPowerprocessId(BigDecimal powerprocessId) {
        this.powerprocessId = powerprocessId;
    }

    public BigDecimal getUpdatetype() {
        return this.updatetype;
    }

    public void setUpdatetype(BigDecimal updatetype) {
        this.updatetype = updatetype;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

}
