package com.website;
import com.component.database.*;
import java.sql.*;
import java.util.*;
import java.util.Date;

import com.util.*;
public class UserTake extends CDataControl {
    private String ut_id="";
    private String ut_tel="";
    private String verifycode="";
    private Date codedate;
    private String status="";
    private CLog log = null;
    private String us_id="";
    
    public UserTake(){
    	log=new CLog();
    }
    
    public UserTake(CDataCn dCn){
    	super(dCn);
    	log=new CLog(dCn);
    }

	public Date getCodedate() {
		return codedate;
	}

	public void setCodedate(Date codedate) {
		this.codedate = codedate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getUs_id() {
		return us_id;
	}

	public void setUs_id(String us_id) {
		this.us_id = us_id;
	}

	public String getUt_id() {
		return ut_id;
	}

	public void setUt_id(String ut_id) {
		this.ut_id = ut_id;
	}

	public String getUt_tel() {
		return ut_tel;
	}

	public void setUt_tel(String ut_tel) {
		this.ut_tel = ut_tel;
	}

	public String getVerifycode() {
		return verifycode;
	}

	public void setVerifycode(String verifycode) {
		this.verifycode = verifycode;
	}
	
	public void setValue(CDataImpl dImpl){
    if (!ut_id.equals("")) {
        dImpl.setValue("ut_id", ut_id, CDataImpl.STRING);
    }
    if (!ut_tel.equals("")) {
        dImpl.setValue("ut_tel", ut_tel, CDataImpl.STRING);
    }
    if (!verifycode.equals("")) {
        dImpl.setValue("verifycode", verifycode, CDataImpl.STRING);
    }
    if (!codedate.equals("")) {
        dImpl.setValue("codedate", codedate, CDataImpl.STRING);
    }
    if (!status.equals("")) {
        dImpl.setValue("status", status, CDataImpl.STRING);
    }
    if (!us_id.equals("")) {
        dImpl.setValue("us_id", us_id, CDataImpl.STRING);
    }
	}
}
	

