/*
 * Created on 2004-10-14
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.beyondbit.soft2.utils;

import java.util.Hashtable;

/**
 * @author along
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class CMessage {
	/*
	 * 主键
	 */
	String ms_id;

	/*
	 * 发送者id
	 */
	String ms_senderid;

	/**
	 * 发送者姓名
	 */
	String ms_sendername;

	/*
	 * 发送时间
	 */
	String ms_sendtime;

	/*
	 * 接受者id
	 */
	String ms_receiverid;

	/*
	 * 接受者姓名
	 */
	String ms_receivername;

	/*
	 * 接受时间
	 */
	String ms_receivetime;

	/*
	 * 是否阅读
	 */
	String ms_isnew;

	/*
	 * 标题
	 */
	String ms_title;

	/*
	 * 内容
	 */
	String ms_content;

	/*
	 * 消息类型id
	 */
	String mt_id;

	/*
	 * 消息关联表纪录id
	 */
	String ms_primaryid;

	/*
	 * 消息发送方向
	 */
	String ms_direction;

	/*
	 * 构造方法
	 *
	 */
	public CMessage() {
	}

	public String getMs_content() {
		return ms_content;
	}
	/**
	 * @param ms_content The ms_content to set.
	 */
	public void setMs_content(String ms_content) {
		this.ms_content = ms_content;
	}
	/**
	 * @return Returns the ms_direction.
	 */
	public String getMs_direction() {
		return ms_direction;
	}
	/**
	 * @param ms_direction The ms_direction to set.
	 */
	public void setMs_direction(String ms_direction) {
		this.ms_direction = ms_direction;
	}
	/**
	 * @return Returns the ms_id.
	 */
	public String getMs_id() {
		return ms_id;
	}
	/**
	 * @param ms_id The ms_id to set.
	 */
	public void setMs_id(String ms_id) {
		this.ms_id = ms_id;
	}
	/**
	 * @return Returns the ms_isnew.
	 */
	public String getMs_isnew() {
		return ms_isnew;
	}
	/**
	 * @param ms_isnew The ms_isnew to set.
	 */
	public void setMs_isnew(String ms_isnew) {
		this.ms_isnew = ms_isnew;
	}
	/**
	 * @return Returns the ms_primaryid.
	 */
	public String getMs_primaryid() {
		return ms_primaryid;
	}
	/**
	 * @param ms_primaryid The ms_primaryid to set.
	 */
	public void setMs_primaryid(String ms_primaryid) {
		this.ms_primaryid = ms_primaryid;
	}
	/**
	 * @return Returns the ms_receiverid.
	 */
	public String getMs_receiverid() {
		return ms_receiverid;
	}
	/**
	 * @param ms_receiverid The ms_receiverid to set.
	 */
	public void setMs_receiverid(String ms_receiverid) {
		this.ms_receiverid = ms_receiverid;
	}
	/**
	 * @return Returns the ms_receivername.
	 */
	public String getMs_receivername() {
		return ms_receivername;
	}
	/**
	 * @param ms_receivername The ms_receivername to set.
	 */
	public void setMs_receivername(String ms_receivername) {
		this.ms_receivername = ms_receivername;
	}
	/**
	 * @return Returns the ms_receivetime.
	 */
	public String getMs_receivetime() {
		return ms_receivetime;
	}
	/**
	 * @param ms_receivetime The ms_receivetime to set.
	 */
	public void setMs_receivetime(String ms_receivetime) {
		this.ms_receivetime = ms_receivetime;
	}
	/**
	 * @return Returns the ms_senderid.
	 */
	public String getMs_senderid() {
		return ms_senderid;
	}
	/**
	 * @param ms_senderid The ms_senderid to set.
	 */
	public void setMs_senderid(String ms_senderid) {
		this.ms_senderid = ms_senderid;
	}
	/**
	 * @return Returns the ms_sendname.
	 */
	public String getMs_sendername() {
    return ms_sendername;
	}
	/**
	 * @param ms_sendname The ms_sendname to set.
	 */
	public void setMs_sendername(String ms_sendername) {
    this.ms_sendername = ms_sendername;
	}
	/**
	 * @return Returns the ms_sendtime.
	 */
	public String getMs_sendtime() {
		return ms_sendtime;
	}
	/**
	 * @param ms_sendtime The ms_sendtime to set.
	 */
	public void setMs_sendtime(String ms_sendtime) {
		this.ms_sendtime = ms_sendtime;
	}
	/**
	 * @return Returns the ms_title.
	 */
	public String getMs_title() {
		return ms_title;
	}
	/**
	 * @param ms_title The ms_title to set.
	 */
	public void setMs_title(String ms_title) {
		this.ms_title = ms_title;
	}
	/**
	 * @return Returns the mt_id.
	 */
	public String getMt_id() {
		return mt_id;
	}
	/**
	 * @param mt_id The mt_id to set.
	 */
	public void setMt_id(String mt_id) {
		this.mt_id = mt_id;
	}

	public void reset(){
		ms_id = null;
		ms_senderid = null;
		ms_sendername = null;
		ms_sendtime = null;
		ms_receiverid = null;
		ms_receivername = null;
		ms_receivetime = null;
		ms_isnew = null;
		ms_title = null;
		ms_content = null;
		mt_id = null;
		ms_primaryid = null;
		ms_direction = null;
	}

	/**
	 * 填充消息内容
	 * @param this
	 * @param content
	 */
	void setMessageContent(Hashtable content) {
		setMs_content(content.get("ms_content").toString());
		setMs_direction(content.get("ms_direction").toString());
		setMs_id(content.get("ms_id").toString());
		setMs_isnew(content.get("ms_isnew").toString());
		setMs_primaryid(content.get("ms_primaryid").toString());
		setMs_receiverid(content.get("ms_receiverid").toString());
		setMs_receivername(content.get("ms_receivername_6").toString());
		setMs_receivetime(content.get("ms_receivetime").toString());
		setMs_senderid(content.get("ms_senderid").toString());
		setMs_sendername(content.get("ms_senderid").toString());
		setMs_sendtime(content.get("ms_sendtime").toString());
		setMs_title(content.get("ms_title").toString());
		setMt_id(content.get("mt_id").toString());
	}
}
