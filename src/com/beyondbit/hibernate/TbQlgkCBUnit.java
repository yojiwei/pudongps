package com.beyondbit.hibernate;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

public class TbQlgkCBUnit implements Serializable {
	//add by zhanglun 2009-2-20
	/** identifier field */
	private Integer id;
    private String cbid;
    
    /** nullable persistent field */
    private java.lang.Integer subid;
    
    /** nullable persistent field */
    private String cb;
    
    /** nullable persistent field */
    private String bjob;
    
    /** nullable persistent field */
    private String cbname;
    
    private TbQlgkSubpowerstd subpower;//承办单位与权力事项的多对一定对应关系
    
    private Set cbsteps = new HashSet(0);//承办单位与步骤的一对多
    
    public Set getCbsteps() {
		return cbsteps;
	}

	public void setCbsteps(Set cbsteps) {
		this.cbsteps = cbsteps;
	}

	public TbQlgkSubpowerstd getSubpower() {
		return subpower;
	}

	public void setSubpower(TbQlgkSubpowerstd subpower) {
		this.subpower = subpower;
	}

	/** default constructor */
    public TbQlgkCBUnit() {
    }

	public String getBjob() {
		return bjob;
	}

	public void setBjob(String bjob) {
		this.bjob = bjob;
	}

	public String getCb() {
		return cb;
	}

	public void setCb(String cb) {
		this.cb = cb;
	}

	public String getCbid() {
		return cbid;
	}

	public void setCbid(String cbid) {
		this.cbid = cbid;
	}

	public String getCbname() {
		return cbname;
	}

	public void setCbname(String cbname) {
		this.cbname = cbname;
	}

	public java.lang.Integer getSubid() {
		return subid;
	}

	public void setSubid(java.lang.Integer subid) {
		this.subid = subid;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
    
    

}
