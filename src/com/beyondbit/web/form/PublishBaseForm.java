package com.beyondbit.web.form;

public abstract class PublishBaseForm {
	
	private String ctImgPath;

	/** dtId property */
	private String dtId;

	/** ctDir property */
	private String ctDir;

	/** ctCreateTime property */
	private String ctCreateTime;

	/** ctFileFlag property */
	private String ctFileFlag;

	/** ctContent property */
	private String ctContent;

	/** ctKeywords property */
	private String ctKeywords;

	/** ctFeedbackFlag property */
	private String ctFeedbackFlag;

	/** ctTitle property */
	private String ctTitle;

	/** ctInsertTime property */
	private String ctInsertTime;

	/** ctSequence property */
	private String ctSequence;

	/** ctUrl property */
	private String ctUrl;

	/** ctSource property */
	private String ctSource;

	/** ctFocusFlag property */
	private String ctFocusFlag;

	/** ctBrowseNum property */
	private String ctBrowseNum;
	
	private String sjId;
	
	private String sjName;
	
	private String authoIds;
	
	private String authoNames;
	
	private String infoStauts;
	
	private String [] fileList;
	
	private String urId;
	
	private String ctId;
	
	private String orgSjId;
	
	TaskInfoForm taskInfo;
	
	private String filePath;
	
    private String catchNum;
	
	private String fileNum;
	
	private String cateGory;
	
	private String descRiption;
	
	private String mediaType;
	
	private String infoType;
	
	private String showTime;
	
	private String contentFlag;
		
	
	//private FormFile file;

	// --------------------------------------------------------- Methods

	
	/** 
	 * Returns the ctImgPath.
	 * @return String
	 */
	public String getCtImgPath() {
		return ctImgPath;
	}

	/** 
	 * Set the ctImgPath.
	 * @param ctImgPath The ctImgPath to set
	 */
	public void setCtImgPath(String ctImgPath) {
		this.ctImgPath = ctImgPath;
	}

	/** 
	 * Returns the dtId.
	 * @return String
	 */
	public String getDtId() {
		return dtId;
	}

	/** 
	 * Set the dtId.
	 * @param dtId The dtId to set
	 */
	public void setDtId(String dtId) {
		this.dtId = dtId;
	}

	/** 
	 * Returns the ctDir.
	 * @return String
	 */
	public String getCtDir() {
		return ctDir;
	}

	/** 
	 * Set the ctDir.
	 * @param ctDir The ctDir to set
	 */
	public void setCtDir(String ctDir) {
		this.ctDir = ctDir;
	}

	/** 
	 * Returns the ctCreateTime.
	 * @return String
	 */
	public String getCtCreateTime() {
		return ctCreateTime;
	}

	/** 
	 * Set the ctCreateTime.
	 * @param ctCreateTime The ctCreateTime to set
	 */
	public void setCtCreateTime(String ctCreateTime) {
		this.ctCreateTime = ctCreateTime;
	}

	/** 
	 * Returns the ctFileFlag.
	 * @return String
	 */
	public String getCtFileFlag() {
		return ctFileFlag;
	}

	/** 
	 * Set the ctFileFlag.
	 * @param ctFileFlag The ctFileFlag to set
	 */
	public void setCtFileFlag(String ctFileFlag) {
		this.ctFileFlag = ctFileFlag;
	}

	/** 
	 * Returns the ctContent.
	 * @return String
	 */
	public String getCtContent() {
		return ctContent;
	}

	public String getSjId()
	{
		return sjId;
	}
	
	public String getSjName()
	{
		return sjName;
	}
	
	
	/** 
	 * Set the ctContent.
	 * @param ctContent The ctContent to set
	 */
	public void setCtContent(String ctContent) {
		this.ctContent = ctContent;
	}

	/** 
	 * Returns the ctKeywords.
	 * @return String
	 */
	public String getCtKeywords() {
		return ctKeywords;
	}

	/** 
	 * Set the ctKeywords.
	 * @param ctKeywords The ctKeywords to set
	 */
	public void setCtKeywords(String ctKeywords) {
		this.ctKeywords = ctKeywords;
	}

	/** 
	 * Returns the ctFeedbackFlag.
	 * @return String
	 */
	public String getCtFeedbackFlag() {
		return ctFeedbackFlag;
	}

	/** 
	 * Set the ctFeedbackFlag.
	 * @param ctFeedbackFlag The ctFeedbackFlag to set
	 */
	public void setCtFeedbackFlag(String ctFeedbackFlag) {
		this.ctFeedbackFlag = ctFeedbackFlag;
	}

	/** 
	 * Returns the ctTitle.
	 * @return String
	 */
	public String getCtTitle() {
		return ctTitle;
	}

	/** 
	 * Set the ctTitle.
	 * @param ctTitle The ctTitle to set
	 */
	public void setCtTitle(String ctTitle) {
		this.ctTitle = ctTitle;
	}

	/** 
	 * Returns the ctInsertTime.
	 * @return String
	 */
	public String getCtInsertTime() {
		return ctInsertTime;
	}

	/** 
	 * Set the ctInsertTime.
	 * @param ctInsertTime The ctInsertTime to set
	 */
	public void setCtInsertTime(String ctInsertTime) {
		this.ctInsertTime = ctInsertTime;
	}

	/** 
	 * Returns the ctSequence.
	 * @return String
	 */
	public String getCtSequence() {
		return ctSequence;
	}

	/** 
	 * Set the ctSequence.
	 * @param ctSequence The ctSequence to set
	 */
	public void setCtSequence(String ctSequence) {
		this.ctSequence = ctSequence;
	}

	/** 
	 * Returns the ctUrl.
	 * @return String
	 */
	public String getCtUrl() {
		return ctUrl;
	}

	/** 
	 * Set the ctUrl.
	 * @param ctUrl The ctUrl to set
	 */
	public void setCtUrl(String ctUrl) {
		this.ctUrl = ctUrl;
	}

	/** 
	 * Returns the ctSource.
	 * @return String
	 */
	public String getCtSource() {
		return ctSource;
	}

	/** 
	 * Set the ctSource.
	 * @param ctSource The ctSource to set
	 */
	public void setCtSource(String ctSource) {
		this.ctSource = ctSource;
	}

	/** 
	 * Returns the ctFocusFlag.
	 * @return String
	 */
	public String getCtFocusFlag() {
		return ctFocusFlag;
	}

	/** 
	 * Set the ctFocusFlag.
	 * @param ctFocusFlag The ctFocusFlag to set
	 */
	public void setCtFocusFlag(String ctFocusFlag) {
		this.ctFocusFlag = ctFocusFlag;
	}

	/** 
	 * Returns the ctBrowseNum.
	 * @return String
	 */
	public String getCtBrowseNum() {
		return ctBrowseNum;
	}
	
	public void setSjId(String sjId)
	{
		this.sjId = sjId; 
	}
	
	public void setSjName(String sjName)
	{
		this.sjName = sjName;
	}
	
	public void setAuthoIds(String authoIds)
	{
		this.authoIds = authoIds;
	}
	
	public void setAuthoNames(String authoNames)
	{
		this.authoNames = authoNames;
	}
	
	public String getAuthoNames()
	{
		return authoNames;
	}
	
	public String getAuthoIds()
	{
		return authoIds;
	}
	
	public String getInfoStauts()
	{
		return infoStauts;
	}
	
	public void setInfoStauts(String infoStauts)
	{
		this.infoStauts = infoStauts;
	}
	
	public void setFileList(String [] fileList)
	{
		this.fileList = fileList;
	}
	
	public String [] getFileList()
	{
		return fileList;
	}
	
	public void setUrId(String urId)
	{
		this.urId = urId;
	}
	
	public String getUrId()
	{
		return urId;
	}
	
	public void setCtId(String ctId)
	{
		this.ctId = ctId;
	}
	
	public String getCtId()
	{
		return ctId;
	}
	
	public void setOrgSjId(String orgSjId)
	{
		this.orgSjId = orgSjId;
	}
	
	public String getOrgSjId()
	{
		return orgSjId;
	}
	
	public void setFilePath(String filePath)
	{
		this.filePath = filePath;
	}
	
	public String getFilePath()
	{
		return filePath;
	}
	
	/*
	public FormFile getFile()
	{
		return this.file;
	}
	
	public void setFile(FormFile file)
	{
		this.file = file;
	}
*/
	
	public void setTaskInfoForm(TaskInfoForm obj)
	{
		this.taskInfo = obj;
	}
	
	public TaskBaseInfoForm getTaskInfoForm()
	{
		return this.taskInfo;
	}
	
	/** 
	 * Set the ctBrowseNum.
	 * @param ctBrowseNum The ctBrowseNum to set
	 */
	public void setCtBrowseNum(String ctBrowseNum) {
		this.ctBrowseNum = ctBrowseNum;
	}

	public String getCatchNum() {
		return catchNum;
	}

	public void setCatchNum(String catchNum) {
		this.catchNum = catchNum;
	}

	public String getCateGory() {
		return cateGory;
	}

	public void setCateGory(String cateGory) {
		this.cateGory = cateGory;
	}

	public String getContentFlag() {
		return contentFlag;
	}

	public void setContentFlag(String contentFlag) {
		this.contentFlag = contentFlag;
	}

	public String getDescRiption() {
		return descRiption;
	}

	public void setDescRiption(String descRiption) {
		this.descRiption = descRiption;
	}

	public String getFileNum() {
		return fileNum;
	}

	public void setFileNum(String fileNum) {
		this.fileNum = fileNum;
	}

	public String getInfoType() {
		return infoType;
	}

	public void setInfoType(String infoType) {
		this.infoType = infoType;
	}

	public String getMediaType() {
		return mediaType;
	}

	public void setMediaType(String mediaType) {
		this.mediaType = mediaType;
	}

	public String getShowTime() {
		return showTime;
	}

	public void setShowTime(String showTime) {
		this.showTime = showTime;
	}

}
