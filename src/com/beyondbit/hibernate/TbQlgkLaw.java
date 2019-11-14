package com.beyondbit.hibernate;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import org.apache.commons.lang.builder.ToStringBuilder;


/** @author Hibernate CodeGenerator */
public class TbQlgkLaw implements Serializable {

    /** identifier field */
    private java.lang.Integer id;

    /** nullable persistent field */
    private String lawname;

    /** nullable persistent field */
    private String lawbasic;

    /** nullable persistent field */
    private String authorityby;

    /** nullable persistent field */
    private String bykind;

    /** nullable persistent field */
    private String consteorgan;

    /** nullable persistent field */
    private Date constedate;

    /** nullable persistent field */
    private String describe;

    /** persistent field */
    private com.beyondbit.hibernate.TbQlgkPowerstd tbQlgkPowerstd;

    /** full constructor */
    public TbQlgkLaw(java.lang.Integer id, String lawname, String lawbasic, String authorityby, String bykind, String consteorgan, Date constedate, String describe, com.beyondbit.hibernate.TbQlgkPowerstd tbQlgkPowerstd) {
        this.id = id;
        this.lawname = lawname;
        this.lawbasic = lawbasic;
        this.authorityby = authorityby;
        this.bykind = bykind;
        this.consteorgan = consteorgan;
        this.constedate = constedate;
        this.describe = describe;
        this.tbQlgkPowerstd = tbQlgkPowerstd;
    }

    /** default constructor */
    public TbQlgkLaw() {
    }

    /** minimal constructor */
    public TbQlgkLaw(java.lang.Integer id, com.beyondbit.hibernate.TbQlgkPowerstd tbQlgkPowerstd) {
        this.id = id;
        this.tbQlgkPowerstd = tbQlgkPowerstd;
    }

    public java.lang.Integer getId() {
        return this.id;
    }

    public void setId(java.lang.Integer id) {
        this.id = id;
    }

    public String getLawname() {
        return this.lawname;
    }

    public void setLawname(String lawname) {
        this.lawname = lawname;
    }

    public String getLawbasic() {
        return this.lawbasic;
    }

    public void setLawbasic(String lawbasic) {
        this.lawbasic = lawbasic;
    }

    public String getAuthorityby() {
        return this.authorityby;
    }

    public void setAuthorityby(String authorityby) {
        this.authorityby = authorityby;
    }

    public String getBykind() {
        return this.bykind;
    }

    public void setBykind(String bykind) {
        this.bykind = bykind;
    }

    public String getConsteorgan() {
        return this.consteorgan;
    }

    public void setConsteorgan(String consteorgan) {
        this.consteorgan = consteorgan;
    }

    public Date getConstedate() {
        return this.constedate;
    }

    public void setConstedate(Date constedate) {
        this.constedate = constedate;
    }

    public String getDescribe() {
        return this.describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public com.beyondbit.hibernate.TbQlgkPowerstd getTbQlgkPowerstd() {
        return this.tbQlgkPowerstd;
    }

    public void setTbQlgkPowerstd(com.beyondbit.hibernate.TbQlgkPowerstd tbQlgkPowerstd) {
        this.tbQlgkPowerstd = tbQlgkPowerstd;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

}
