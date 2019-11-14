package com.beyondbit.hibernate;

import java.io.Serializable;
import java.math.BigDecimal;
import org.apache.commons.lang.builder.ToStringBuilder;


/** @author Hibernate CodeGenerator */
public class TbQlgkPsfile implements Serializable {

    /** identifier field */
    private Integer fileid;

    /** nullable persistent field */
    private BigDecimal psid;

    /** nullable persistent field */
    private String filecode;

    /** nullable persistent field */
    private String filename;

    /** nullable persistent field */
    private Integer isopen;

    /** nullable persistent field */
    private Integer ismust;

    /** nullable persistent field */
    private Integer isinput;

    /** nullable persistent field */
    private Integer isoutput;

    /** nullable persistent field */
    private byte[] edocdata;

    /** nullable persistent field */
    private byte[] diagrampicdata;

    /** nullable persistent field */
    private String des;

    /** nullable persistent field */
    private String edocname;

    /** nullable persistent field */
    private String edoctype;

    /** nullable persistent field */
    private String diagrampicname;

    /** nullable persistent field */
    private String diagrampictype;

    /** full constructor */
    public TbQlgkPsfile(Integer fileid, BigDecimal psid, String filecode, String filename, Integer isopen, Integer ismust, Integer isinput, Integer isoutput, byte[] edocdata, byte[] diagrampicdata, String des, String edocname, String edoctype, String diagrampicname, String diagrampictype) {
        this.fileid = fileid;
        this.psid = psid;
        this.filecode = filecode;
        this.filename = filename;
        this.isopen = isopen;
        this.ismust = ismust;
        this.isinput = isinput;
        this.isoutput = isoutput;
        this.edocdata = edocdata;
        this.diagrampicdata = diagrampicdata;
        this.des = des;
        this.edocname = edocname;
        this.edoctype = edoctype;
        this.diagrampicname = diagrampicname;
        this.diagrampictype = diagrampictype;
    }

    /** default constructor */
    public TbQlgkPsfile() {
    }

    /** minimal constructor */
    public TbQlgkPsfile(Integer fileid) {
        this.fileid = fileid;
    }

    public Integer getFileid() {
        return this.fileid;
    }

    public void setFileid(Integer fileid) {
        this.fileid = fileid;
    }

    public BigDecimal getPsid() {
        return this.psid;
    }

    public void setPsid(BigDecimal psid) {
        this.psid = psid;
    }

    public String getFilecode() {
        return this.filecode;
    }

    public void setFilecode(String filecode) {
        this.filecode = filecode;
    }

    public String getFilename() {
        return this.filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public Integer getIsopen() {
        return this.isopen;
    }

    public void setIsopen(Integer isopen) {
        this.isopen = isopen;
    }

    public Integer getIsmust() {
        return this.ismust;
    }

    public void setIsmust(Integer ismust) {
        this.ismust = ismust;
    }

    public Integer getIsinput() {
        return this.isinput;
    }

    public void setIsinput(Integer isinput) {
        this.isinput = isinput;
    }

    public Integer getIsoutput() {
        return this.isoutput;
    }

    public void setIsoutput(Integer isoutput) {
        this.isoutput = isoutput;
    }

    public byte[] getEdocdata() {
        return this.edocdata;
    }

    public void setEdocdata(byte[] edocdata) {
        this.edocdata = edocdata;
    }

    public byte[] getDiagrampicdata() {
        return this.diagrampicdata;
    }

    public void setDiagrampicdata(byte[] diagrampicdata) {
        this.diagrampicdata = diagrampicdata;
    }

    public String getDes() {
        return this.des;
    }

    public void setDes(String des) {
        this.des = des;
    }

    public String getEdocname() {
        return this.edocname;
    }

    public void setEdocname(String edocname) {
        this.edocname = edocname;
    }

    public String getEdoctype() {
        return this.edoctype;
    }

    public void setEdoctype(String edoctype) {
        this.edoctype = edoctype;
    }

    public String getDiagrampicname() {
        return this.diagrampicname;
    }

    public void setDiagrampicname(String diagrampicname) {
        this.diagrampicname = diagrampicname;
    }

    public String getDiagrampictype() {
        return this.diagrampictype;
    }

    public void setDiagrampictype(String diagrampictype) {
        this.diagrampictype = diagrampictype;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("fileid", getFileid())
            .toString();
    }

    public boolean equals(Object obj) {
        if(obj instanceof TbQlgkPsfile){
            return this.fileid.equals(((TbQlgkPsfile)obj).getFileid());
        }
        return false;
   }


}
