package com.webservise;

public class MessageBean {

	/**
	 * @author 施建兵
	 * 推送信息BEAN
	 */
	public String MessageTitle="";//信息标题
	public String OPERATER="";//add 加 delete 删 edit 更新
	public String ID="";//ct_id
	public String FORMID="gwba";//gwba 系统标识
	public String SUBJECTID="";//栏目ID
	public String CONTENT="";//内容
	public String FILEDATE="";//本系统的发布时间
	public String SENDDATE="";//信息推送时间即为修改日期
	public String SendTime="";//开始时间 发布日期
	public String EndTime="";//结束时间  发布结束日期
	public String InsertTime = "";//信息录入日期
	
	public String SENDUNIT="";//部门名称
	public String FILECODE="";//文件编号
	public String INDEX="";//索取号 无可为空
	public String PUBLISH="";//公开类别 文字 
	public String GONGWENTYPE = "";//公文种类 -1 请选择 0 命令(令) 1 决定 2 公告 3 通告 4 通知 5 通报 6 议案 7 报告 8 请示 9 批复 10 意见 11 函 12 会议纪要
	public String CARRIER="";//载体类型 文字
	public String ANNAL="";//记录形式 文字
	public String SUBJECTCODE="";//本系统栏目代码
	public String SOURCE="";//来源
	public String DESCRIBE="";//摘要
	public String KEY="";//关键字
	
	public String Sender="浦东公文备案系统";//本系统名
	
	public String special="";// 1是特别提醒   0不是特别提醒
	public String link="";//链接 LINK
	public String dtCode = "";//部门代号 
	
	public String getLink() {
		return link;
	}



	public void setLink(String link) {
		this.link = link;
	}



	public String getSpecial() {
		return special;
	}



	public void setSpecial(String special) {
		this.special = special;
	}



	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}



	public String getANNAL() {
		return ANNAL;
	}



	public void setANNAL(String annal) {
		ANNAL = annal;
	}



	public String getCARRIER() {
		return CARRIER;
	}



	public void setCARRIER(String carrier) {
		CARRIER = carrier;
	}



	public String getCONTENT() {
		return CONTENT;
	}



	public void setCONTENT(String content) {
		CONTENT = content;
	}



	public String getDESCRIBE() {
		return DESCRIBE;
	}



	public void setDESCRIBE(String describe) {
		DESCRIBE = describe;
	}



	public String getEndTime() {
		return EndTime;
	}



	public void setEndTime(String endTime) {
		EndTime = endTime;
	}



	public String getFILECODE() {
		return FILECODE;
	}



	public void setFILECODE(String filecode) {
		FILECODE = filecode;
	}



	public String getFILEDATE() {
		return FILEDATE;
	}



	public void setFILEDATE(String filedate) {
		FILEDATE = filedate;
	}



	public String getFORMID() {
		return FORMID;
	}



	public void setFORMID(String formid) {
		FORMID = formid;
	}



	public String getID() {
		return ID;
	}



	public void setID(String id) {
		ID = id;
	}



	public String getINDEX() {
		return INDEX;
	}



	public void setINDEX(String index) {
		INDEX = index;
	}



	public String getKEY() {
		return KEY;
	}



	public void setKEY(String key) {
		KEY = key;
	}



	public String getMessageTitle() {
		return MessageTitle;
	}



	public void setMessageTitle(String messageTitle) {
		MessageTitle = messageTitle;
	}



	public String getOPERATER() {
		return OPERATER;
	}



	public void setOPERATER(String operater) {
		OPERATER = operater;
	}



	public String getPUBLISH() {
		return PUBLISH;
	}



	public void setPUBLISH(String publish) {
		PUBLISH = publish;
	}



	public String getSENDDATE() {
		return SENDDATE;
	}



	public void setSENDDATE(String senddate) {
		SENDDATE = senddate;
	}



	public String getSender() {
		return Sender;
	}



	public void setSender(String sender) {
		Sender = sender;
	}



	public String getSendTime() {
		return SendTime;
	}



	public void setSendTime(String sendTime) {
		SendTime = sendTime;
	}



	public String getSENDUNIT() {
		return SENDUNIT;
	}



	public void setSENDUNIT(String sendunit) {
		SENDUNIT = sendunit;
	}



	public String getSOURCE() {
		return SOURCE;
	}



	public void setSOURCE(String source) {
		SOURCE = source;
	}



	public String getSUBJECTCODE() {
		return SUBJECTCODE;
	}



	public void setSUBJECTCODE(String subjectcode) {
		SUBJECTCODE = subjectcode;
	}



	public String getSUBJECTID() {
		return SUBJECTID;
	}



	public void setSUBJECTID(String subjectid) {
		SUBJECTID = subjectid;
	}



	public String getDtCode() {
		return dtCode;
	}



	public void setDtCode(String dtCode) {
		this.dtCode = dtCode;
	}



	public String getGONGWENTYPE() {
		return GONGWENTYPE;
	}



	public void setGONGWENTYPE(String gongwentype) {
		GONGWENTYPE = gongwentype;
	}



	public String getInsertTime() {
		return InsertTime;
	}



	public void setInsertTime(String insertTime) {
		InsertTime = insertTime;
	}



}
