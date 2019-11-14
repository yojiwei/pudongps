package com.beyondbit.hibernate;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import org.apache.commons.lang.builder.ToStringBuilder;


/** @author Hibernate CodeGenerator */
public class TbQlgkSubpowerstd implements Serializable {
    java.text.SimpleDateFormat sd = new java.text.SimpleDateFormat("yyyy-MM-dd");
    /** identifier field */
    private Integer id;

    /** nullable persistent field */
    private String createunitid;

    /** nullable persistent field */
    private String createunitname;

    /** nullable persistent field */
    private String createuserid;

    /** nullable persistent field */
    private String createusername;

    /** nullable persistent field */
    private Date createtime;

    /** nullable persistent field */
    private BigDecimal state;

    /** persistent field */
    private com.beyondbit.hibernate.TbQlgkPowerstd tbQlgkPowerstd;

    //Ö°È¨ï¿½ï¿½ï¿½ï¿½
    private String aunitname;
    private BigDecimal aunitid;
    private String aunitcode;
    private String ausername;
    private String auserid;
    private String ajob;

    //ï¿½Ð°ï¿½ï¿\uFFFD
    private String bunitname;
    private BigDecimal bunitid;
    private String bunitcode;
    private String busername;
    private String buserid;
    private String bjob;

    //ï¿½Ð°ï¿½ï¿\uFFFD
    private String checkunitname;
    private BigDecimal checkunitid;
    private String checkunitcode;
    private String checkusername;
    private String checkuserid;
    private Date checkdate;


    //ï¿½ï¿½Ê±ï¿½ï¿½ ï¿½ï¿½È¨ï¿½ï¿½
    private BigDecimal duetimelimit;
    private BigDecimal pslimit;
    private String pslimitunit;

    /** persistent field */
    private Set tbQlgkPowerstdsteps;
    
    //add by zhanglun 2009-2-20
    private Set subCbs = new HashSet(0);//È¨Á¦ÊÂÏîÓë³Ð°ìµ¥Î»µÄÒ»¶Ô¶à¹ØÏµ

    /**
     *
     */
    private String createuserjob;
    private String cb;
    private String zt;

    private BigDecimal attr1id;
    private String attr1name;

    private String txtbefore;
    private String txtafter;
    /** persistent field */
//    private Set tbQlgkLaws;


    /** full constructor */
    public TbQlgkSubpowerstd(Integer id, String createunitid, String createunitname, String createuserid, String createusername, Date createtime, BigDecimal state, com.beyondbit.hibernate.TbQlgkPowerstd tbQlgkPowerstd, Set tbQlgkPowerstdsteps) {
        this.id = id;
        this.createunitid = createunitid;
        this.createunitname = createunitname;
        this.createuserid = createuserid;
        this.createusername = createusername;
        this.createtime = createtime;
        this.state = state;
        this.tbQlgkPowerstd = tbQlgkPowerstd;
        this.tbQlgkPowerstdsteps = tbQlgkPowerstdsteps;
    }

    /** default constructor */
    public TbQlgkSubpowerstd() {
    }

    /** minimal constructor */
    public TbQlgkSubpowerstd(Integer id, com.beyondbit.hibernate.TbQlgkPowerstd tbQlgkPowerstd, Set tbQlgkPowerstdsteps) {
        this.id = id;
        this.tbQlgkPowerstd = tbQlgkPowerstd;
        this.tbQlgkPowerstdsteps = tbQlgkPowerstdsteps;
    }

    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }



    public String getCreateunitname() {
        return this.createunitname;
    }

    public void setCreateunitname(String createunitname) {
        this.createunitname = createunitname;
    }

    public String getCreateuserid() {
        return this.createuserid;
    }

    public void setCreateuserid(String createuserid) {
        this.createuserid = createuserid;
    }

    public String getCreateusername() {
        return this.createusername;
    }

    public void setCreateusername(String createusername) {
        this.createusername = createusername;
    }

    public Date getCreatetime() {
        return this.createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public BigDecimal getState() {
        return this.state;
    }

    public void setState(BigDecimal state) {
        this.state = state;
    }

    public com.beyondbit.hibernate.TbQlgkPowerstd getTbQlgkPowerstd() {
        return this.tbQlgkPowerstd;
    }

    public void setTbQlgkPowerstd(com.beyondbit.hibernate.TbQlgkPowerstd tbQlgkPowerstd) {
        this.tbQlgkPowerstd = tbQlgkPowerstd;
    }

    public Set getTbQlgkPowerstdsteps() {
        return this.tbQlgkPowerstdsteps;
    }

    public void setTbQlgkPowerstdsteps(Set tbQlgkPowerstdsteps) {
        this.tbQlgkPowerstdsteps = tbQlgkPowerstdsteps;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();

    }
    public String getCreateuserjob() {
        return createuserjob;
    }
    public void setCreateuserjob(String createuserjob) {
        this.createuserjob = createuserjob;
    }
    public String getAjob() {
        return ajob;
    }
    public String getAunitcode() {
        return aunitcode;
    }
  public String getAunitname() {
    return aunitname;
  }
  public String getAuserid() {
    return auserid;
  }
  public String getAusername() {
    return ausername;
  }
  public String getBjob() {
    return bjob;
  }
  public String getBunitcode() {
    return bunitcode;
  }
  public String getBunitname() {
    return bunitname;
  }
  public String getBusername() {
    return busername;
  }
  public void setBusername(String busername) {
    this.busername = busername;
  }
  public void setBunitname(String bunitname) {
    this.bunitname = bunitname;
  }
  public void setBunitcode(String bunitcode) {
    this.bunitcode = bunitcode;
  }
  public void setBjob(String bjob) {
    this.bjob = bjob;
  }
  public void setAusername(String ausername) {
    this.ausername = ausername;
  }
  public void setAuserid(String auserid) {
    this.auserid = auserid;
  }
  public void setAunitname(String aunitname) {
    this.aunitname = aunitname;
  }
  public void setAunitcode(String aunitcode) {
    this.aunitcode = aunitcode;
  }
  public void setAjob(String ajob) {
    this.ajob = ajob;
  }

  public void setPslimitunit(String pslimitunit) {
    this.pslimitunit = pslimitunit;
  }
  public void setSd(java.text.SimpleDateFormat sd) {
    this.sd = sd;
  }
  public java.text.SimpleDateFormat getSd() {
    return sd;
  }
  public String getPslimitunit() {
    return pslimitunit;
  }

  public String getCheckusername() {
    return checkusername;
  }
  public String getCheckunitname() {
    return checkunitname;
  }
  public String getCheckunitcode() {
    return checkunitcode;
  }
  public Date getCheckdate() {
    return checkdate;
  }
  public void setCheckdate(Date checkdate) {
    this.checkdate = checkdate;
  }
  public void setCheckunitcode(String checkunitcode) {
    this.checkunitcode = checkunitcode;
  }
  public void setCheckunitname(String checkunitname) {
    this.checkunitname = checkunitname;
  }
  public void setCheckusername(String checkusername) {
    this.checkusername = checkusername;
  }
//    public Set getTbQlgkLaws() {
//        return tbQlgkLaws;
//    }
//    public void setTbQlgkLaws(Set tbQlgkLaws) {
//        this.tbQlgkLaws = tbQlgkLaws;
//    }
    public BigDecimal getDuetimelimit() {
        return duetimelimit;
    }
    public void setDuetimelimit(BigDecimal duetimelimit) {
        this.duetimelimit = duetimelimit;
    }
    public void setPslimit(BigDecimal pslimit) {
        this.pslimit = pslimit;
    }
    public BigDecimal getPslimit() {
        return pslimit;
    }
    public BigDecimal getAunitid() {
        return aunitid;
    }
    public void setAunitid(BigDecimal aunitid) {
        this.aunitid = aunitid;
    }
    public void setBunitid(BigDecimal bunitid) {
        this.bunitid = bunitid;
    }
    public BigDecimal getBunitid() {
        return bunitid;
    }
    public String getBuserid() {
        return buserid;
    }
    public void setBuserid(String buserid) {
        this.buserid = buserid;
    }
    public void setCheckunitid(BigDecimal checkunitid) {
        this.checkunitid = checkunitid;
    }
    public BigDecimal getCheckunitid() {
        return checkunitid;
    }
    public String getCheckuserid() {
        return checkuserid;
    }
    public void setCheckuserid(String checkuserid) {
        this.checkuserid = checkuserid;
    }
    public void setCreateunitid(String createunitid) {
        this.createunitid = createunitid;
    }
    public String getCreateunitid() {
        return createunitid;
    }
    public String getCb() {
        return cb;
    }
    public void setCb(String cb) {
        this.cb = cb;
    }
    public String getZt() {
        return zt;
    }
    public void setZt(String zt) {
        this.zt = zt;
    }
    public BigDecimal getAttr1id() {
        return attr1id;
    }
    public String getAttr1name() {
        return attr1name;
    }
    public void setAttr1id(BigDecimal attr1id) {
        this.attr1id = attr1id;
    }
    public void setAttr1name(String attr1name) {
        this.attr1name = attr1name;
    }
    public String getTxtafter() {
        return txtafter;
    }
    public String getTxtbefore() {
        return txtbefore;
    }
    public void setTxtafter(String txtafter) {
        this.txtafter = txtafter;
    }
    public void setTxtbefore(String txtbefore) {
        this.txtbefore = txtbefore;
    }

	public Set getSubCbs() {
		return subCbs;
	}

	public void setSubCbs(Set subCbs) {
		this.subCbs = subCbs;
	}



}
