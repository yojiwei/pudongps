<!--
///////////////////////////////////////////////
//在页面上形成一个form，得到用户提交的数据，再把数据提交到进行数据转移的页面
document.write("<form name='dataupload' target=targetFrm action='http://usercenter.pudong.gov.cn/system/common/dataupload/DataHbjUpload.jsp' method='post'>");
document.write("<input type='hidden' name='CT_title' value=''>");
document.write("<input type='hidden' name='CT_content' value=''>");
document.write("<input type='hidden' name='CT_create_time' value=''>");
document.write("<input type='hidden' name='CT_source' value=''>");
document.write("<input type='hidden' name='AT_content' value=''>");
document.write("<input type='hidden' name='SJ_id' value=''>"); 
document.write("<input type='hidden' name='DT_id' value=''>");
document.write("<input type='hidden' name='at_type' value=''>");
document.write("</form>");

function getSbValues(title,content,createTime,source,attachStr,attachType,subjectId,dtId){
	
	document.dataupload.CT_title.value = title;
	document.dataupload.CT_content.value = content;
	document.dataupload.CT_create_time.value = createTime;
	document.dataupload.CT_source.value = source;
	document.dataupload.AT_content.value = attachStr;
	document.dataupload.DT_id.value = dtId;
	document.dataupload.at_type.value = attachType;
	
	document.dataupload.SJ_id.value = subjectId;
	dataupload.submit();
}

-->