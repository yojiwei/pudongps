package com.beyondbit.web.form;

public class TaskSUBInfoForm extends TaskBaseInfoForm{
	
	private String tcPerson;
	
	private String tcMemo;
	
	private String tcTime;
	
	private String tcParentId;
	
	private String tcSenderId;
	
	private String tcStatus; 
	
	private String chkIDs;
	
	public void setTcPerson(String tcPerson)
	{
		this.tcPerson = tcPerson;
	}
	
	public String getTcPerson()
	{
		return this.tcPerson;
	}
	
	
	public void setTcMemo(String tcMemo)
	{
		this.tcMemo = tcMemo;
	}
	
	public String getTcMemo()
	{
		return this.tcMemo;
	}
	
	public void setTcTime(String tcTime)
	{
		this.tcTime = tcTime;
	}
	
	public String getTctime()
	{
		return this.tcTime;
	}
	
	public void setTcParentId(String tcParentId)
	{
		this.tcParentId = tcParentId;
	}
	
	public String getTcParentId()
	{
		return this.tcParentId;
	}
	
	public void setTcStatus(String tcStatus)
	{
		this.tcStatus = tcStatus;
	}
	
	public String getTcStatus()
	{
		return this.tcStatus;
	}
	
	public void seTcSenderId(String tcSenderId)
	{
		this.tcSenderId = tcSenderId;
	}
	
	public String getTcSenderId()
	{
		return this.tcSenderId;
	}
	
	public void setChkIDs(String chkIds)
	{
		this.chkIDs = chkIds;
	}
	
	public String getChkIDs()
	{
		return this.chkIDs;
	}

}
