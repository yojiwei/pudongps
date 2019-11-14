package com.beyondbit.hibernate;

import java.io.Serializable;
import java.math.BigDecimal;
import org.apache.commons.lang.builder.ToStringBuilder;


/** @author Hibernate CodeGenerator */
public class TbQlgkPscategory implements Serializable {

    /** identifier field */
    private Integer cateid;

    /** persistent field */
    private String catecode;

    /** persistent field */
    private String categoryname;

    /** nullable persistent field */
    private BigDecimal pcateid;

    /** nullable persistent field */
    private String dsc;

    /** nullable persistent field */
    private BigDecimal sequence;

    /** full constructor */
    public TbQlgkPscategory(Integer cateid, String catecode, String categoryname, BigDecimal pcateid, String dsc, BigDecimal sequence) {
        this.cateid = cateid;
        this.catecode = catecode;
        this.categoryname = categoryname;
        this.pcateid = pcateid;
        this.dsc = dsc;
        this.sequence = sequence;
    }

    /** default constructor */
    public TbQlgkPscategory() {
    }

    /** minimal constructor */
    public TbQlgkPscategory(Integer cateid, String catecode, String categoryname) {
        this.cateid = cateid;
        this.catecode = catecode;
        this.categoryname = categoryname;
    }

    public Integer getCateid() {
        return this.cateid;
    }

    public void setCateid(Integer cateid) {
        this.cateid = cateid;
    }

    public String getCatecode() {
        return this.catecode;
    }

    public void setCatecode(String catecode) {
        this.catecode = catecode;
    }

    public String getCategoryname() {
        return this.categoryname;
    }

    public void setCategoryname(String categoryname) {
        this.categoryname = categoryname;
    }

    public BigDecimal getPcateid() {
        return this.pcateid;
    }

    public void setPcateid(BigDecimal pcateid) {
        this.pcateid = pcateid;
    }

    public String getDsc() {
        return this.dsc;
    }

    public void setDsc(String dsc) {
        this.dsc = dsc;
    }

    public BigDecimal getSequence() {
        return this.sequence;
    }

    public void setSequence(BigDecimal sequence) {
        this.sequence = sequence;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("cateid", getCateid())
            .toString();
    }

}
