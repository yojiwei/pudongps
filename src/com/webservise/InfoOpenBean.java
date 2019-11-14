package com.webservise;

public class InfoOpenBean {

	/**
	 * @author 施建兵
	 * 推送信息BEAN
	 */
	private String systemname="浦东门户网上申请公开";
	private String sender="浦东门户";//系统标识
	private String sendtime="";//发送时间
	private String messgaeid="";//信息主键
	private String operater="";//people为公民  company为公司
	
	private String name="";//姓名
	private String organ="";//工作单位
	private String papertype="";//证件名称
	private String papernumber="";//证件号码 
	private String address="";//通信地址
	private String postalcode="";//邮政编码
	private String tel="";//联系电话
	private String telother="";//其他联系电话
	private String peopleemail="";//电子邮件
	
	private String companyname="";//名　称
	private String companycode="";//组织机构代码
	private String businesscard="";//营业执照信息
	private String deputy="";//法人代表
	private String linkman="";//联系人
	private String companytel="";//联系人电话 
	private String companytelother="";//联系人其他电话
	private String companyemail="";//电子邮件
	
	private String title="";//信息名称
	private String content="";//内容
	private String catchnum="";//所需信息的索取号 可为空
	private String purpose="";//所需信息的用途
	private String remark="";//备注
	private String derate="";//是否申请减免费用  no不申请   yes申请
	private String offer="";//所需信息的制定提供方式 用逗号隔开 如 纸面,电子邮件,
	private String getmethod="";//获取信息方式 用逗号隔开 如 纸面,电子邮件,
	private String dept="";//选择相关受理部门名
	
	private String filecontent ="";//-文件编码 base64编码
	private String filelength ="";//- 文件大小,以字节算 
	private String fileoldname ="";//-附件原名
	private String filenewname ="";//-附件现在的名
	private String fileextension ="";//-附件扩展名
	private String fileId ="";//-附件扩展名
	
	//新加字段 by sjb 2009-04-22
	private String wennum="";//文号
	private String free="";//理由
	
	public String getFree() {
		return free;
	}

	public void setFree(String free) {
		this.free = free;
	}

	public String getWennum() {
		return wennum;
	}

	public void setWennum(String wennum) {
		this.wennum = wennum;
	}

	public String getFilecontent() {
		return filecontent;
	}

	public void setFilecontent(String filecontent) {
		this.filecontent = filecontent;
	}

	public String getFileextension() {
		return fileextension;
	}

	public void setFileextension(String fileextension) {
		this.fileextension = fileextension;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getFilelength() {
		return filelength;
	}

	public void setFilelength(String filelength) {
		this.filelength = filelength;
	}

	public String getFilenewname() {
		return filenewname;
	}

	public void setFilenewname(String filenewname) {
		this.filenewname = filenewname;
	}

	public String getFileoldname() {
		return fileoldname;
	}

	public void setFileoldname(String fileoldname) {
		this.fileoldname = fileoldname;
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getBusinesscard() {
		return businesscard;
	}

	public void setBusinesscard(String businesscard) {
		this.businesscard = businesscard;
	}

	public String getCatchnum() {
		return catchnum;
	}

	public void setCatchnum(String catchnum) {
		this.catchnum = catchnum;
	}

	public String getCompanycode() {
		return companycode;
	}

	public void setCompanycode(String companycode) {
		this.companycode = companycode;
	}

	public String getCompanyemail() {
		return companyemail;
	}

	public void setCompanyemail(String companyemail) {
		this.companyemail = companyemail;
	}

	public String getCompanyname() {
		return companyname;
	}

	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}

	public String getCompanytel() {
		return companytel;
	}

	public void setCompanytel(String companytel) {
		this.companytel = companytel;
	}

	public String getCompanytelother() {
		return companytelother;
	}

	public void setCompanytelother(String companytelother) {
		this.companytelother = companytelother;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public String getDeputy() {
		return deputy;
	}

	public void setDeputy(String deputy) {
		this.deputy = deputy;
	}

	public String getDerate() {
		return derate;
	}

	public void setDerate(String derate) {
		this.derate = derate;
	}

	public String getGetmethod() {
		return getmethod;
	}

	public void setGetmethod(String getmethod) {
		this.getmethod = getmethod;
	}

	public String getLinkman() {
		return linkman;
	}

	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}

	public String getMessgaeid() {
		return messgaeid;
	}

	public void setMessgaeid(String messgaeid) {
		this.messgaeid = messgaeid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getOffer() {
		return offer;
	}

	public void setOffer(String offer) {
		this.offer = offer;
	}

	public String getOperater() {
		return operater;
	}

	public void setOperater(String operater) {
		this.operater = operater;
	}

	public String getOrgan() {
		return organ;
	}

	public void setOrgan(String organ) {
		this.organ = organ;
	}

	public String getPapernumber() {
		return papernumber;
	}

	public void setPapernumber(String papernumber) {
		this.papernumber = papernumber;
	}

	public String getPapertype() {
		return papertype;
	}

	public void setPapertype(String papertype) {
		this.papertype = papertype;
	}

	public String getPeopleemail() {
		return peopleemail;
	}

	public void setPeopleemail(String peopleemail) {
		this.peopleemail = peopleemail;
	}

	public String getPostalcode() {
		return postalcode;
	}

	public void setPostalcode(String postalcode) {
		this.postalcode = postalcode;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getSendtime() {
		return sendtime;
	}

	public void setSendtime(String sendtime) {
		this.sendtime = sendtime;
	}

	public String getSystemname() {
		return systemname;
	}

	public void setSystemname(String systemname) {
		this.systemname = systemname;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getTelother() {
		return telother;
	}

	public void setTelother(String telother) {
		this.telother = telother;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
}
