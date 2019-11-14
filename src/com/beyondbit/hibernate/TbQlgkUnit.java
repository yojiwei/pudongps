package com.beyondbit.hibernate;

import java.io.Serializable;
import java.math.BigDecimal;
import org.apache.commons.lang.builder.ToStringBuilder;


/** @author Hibernate CodeGenerator */
public class TbQlgkUnit implements Serializable {

    /** identifier field */
    private Integer unitid;

    /** persistent field */
    private String ucode;

    /** persistent field */
    private String uname;

    /** nullable persistent field */
    private String phone;

    /** nullable persistent field */
    private String fax;

    /** nullable persistent field */
    private String homepage;

    /** nullable persistent field */
    private String address;

    /** nullable persistent field */
    private String linkman;

    /** nullable persistent field */
    private String type;

    /** nullable persistent field */
    private String groupname;

    /** nullable persistent field */
    private BigDecimal punitid;

    /** nullable persistent field */
    private BigDecimal sortorder;

    /** nullable persistent field */
    private BigDecimal numofrcds;

    /** nullable persistent field */
    private BigDecimal hidden;

    /** full constructor */
    public TbQlgkUnit(Integer unitid, String ucode, String uname, String phone, String fax, String homepage, String address, String linkman, String type, String groupname, BigDecimal punitid, BigDecimal sortorder, BigDecimal numofrcds, BigDecimal hidden) {
        this.unitid = unitid;
        this.ucode = ucode;
        this.uname = uname;
        this.phone = phone;
        this.fax = fax;
        this.homepage = homepage;
        this.address = address;
        this.linkman = linkman;
        this.type = type;
        this.groupname = groupname;
        this.punitid = punitid;
        this.sortorder = sortorder;
        this.numofrcds = numofrcds;
        this.hidden = hidden;
    }

    /** default constructor */
    public TbQlgkUnit() {
    }

    /** minimal constructor */
    public TbQlgkUnit(Integer unitid, String ucode, String uname) {
        this.unitid = unitid;
        this.ucode = ucode;
        this.uname = uname;
    }

    public Integer getUnitid() {
        return this.unitid;
    }

    public void setUnitid(Integer unitid) {
        this.unitid = unitid;
    }

    public String getUcode() {
        return this.ucode;
    }

    public void setUcode(String ucode) {
        this.ucode = ucode;
    }

    public String getUname() {
        return this.uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getPhone() {
        return this.phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getFax() {
        return this.fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getHomepage() {
        return this.homepage;
    }

    public void setHomepage(String homepage) {
        this.homepage = homepage;
    }

    public String getAddress() {
        return this.address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getLinkman() {
        return this.linkman;
    }

    public void setLinkman(String linkman) {
        this.linkman = linkman;
    }

    public String getType() {
        return this.type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getGroupname() {
        return this.groupname;
    }

    public void setGroupname(String groupname) {
        this.groupname = groupname;
    }

    public BigDecimal getPunitid() {
        return this.punitid;
    }

    public void setPunitid(BigDecimal punitid) {
        this.punitid = punitid;
    }

    public BigDecimal getSortorder() {
        return this.sortorder;
    }

    public void setSortorder(BigDecimal sortorder) {
        this.sortorder = sortorder;
    }

    public BigDecimal getNumofrcds() {
        return this.numofrcds;
    }

    public void setNumofrcds(BigDecimal numofrcds) {
        this.numofrcds = numofrcds;
    }

    public BigDecimal getHidden() {
        return this.hidden;
    }

    public void setHidden(BigDecimal hidden) {
        this.hidden = hidden;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("unitid", getUnitid())
            .toString();
    }

}
