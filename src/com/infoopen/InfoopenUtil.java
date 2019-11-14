// FrontEnd Plus GUI for JAD
// DeCompiled : InfoopenUtil.class

package com.infoopen;
/**
 * TODO 获取某单位条件范围内的依申请公开的信息。
 * <p>
 * gwba
 * com.infoopen
 * InfoopenUtil.java
 * </p>
 *@author yang
 *@vision
*/
import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.*;
import java.io.*;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.jdom.*;
import org.jdom.input.SAXBuilder;

public class InfoopenUtil
{

    public InfoopenUtil()
    {
    }

    public static void main(String args[])
    {
        String fileStr = "<?xml version=\"1.0\" encoding=\"GBK\"?><DEP_DataExchangeData><OperationType>LBOA</OperationType><MessageTitle>标题</MessageTitle><MessageID>11</MessageID><MessageBody><queryParam><queryDeptcode>XB0</queryDeptcode><startTime>2016-11-01</startTime><endTime>2017-01-20</endTime><queryNum>1</queryNum></queryParam><recallParam><![CDATA[]]></recallParam></MessageBody></DEP_DataExchangeData>";
        InfoopenUtil util = new InfoopenUtil();
        System.out.println(util.getInfoopenList(fileStr));        
    } 

    public String UpdateInfoStatus(String xmlStr)
    {
        boolean flag = false;
        Element root = initEle(xmlStr);
        String filePath = System.getProperty("user.dir") + System.getProperty("file.separator") + "InfoUpdateTemplate.xml";
        Element tempEle = initEle(getTemplateEle(filePath));
        StringBuffer errorStr = new StringBuffer("");
        errorStr = checkXml(root, tempEle, errorStr);
        if("".equals(errorStr.toString()))
            errorStr.append(doUpdateInfo(root));
        System.out.println(errorStr);
        return errorStr.toString();
    }

    private StringBuffer doUpdateInfo(Element root)
    {
        StringBuffer errorStr;
        errorStr = new StringBuffer("");
        List eleList = root.getChild("MessageBody").getChildren("infoopen");
        Element infoEle = null;
        String id = "";
        String status = "";
        String step = "";
        String dealtime = "";
        String memo = "";
        String sql = "";
        String tid = "";
        Hashtable table = null;
        CDataCn dCn = null;
        CDataImpl dImpl = null;
        try
        {
            dCn = new CDataCn();
            dImpl = new CDataImpl(dCn);
            if(eleList != null)
            {
                errorStr.append("<?xml version=\"1.0\" encoding=\"GBK\"?>");
                errorStr.append("<DEP_DataExchangeData><OperationType>FEEDBACK</OperationType><MessageTitle>返回状态修改结果</MessageTitle><MessageID>102</MessageID>");
                errorStr.append("<MessageBody>");
                for(int cnt = 0; cnt < eleList.size(); cnt++)
                {
                    infoEle = (Element)eleList.get(cnt);
                    id = infoEle.getChildTextTrim("id");
                    status = infoEle.getChildTextTrim("status");
                    step = infoEle.getChildTextTrim("step");
                    dealtime = infoEle.getChildTextTrim("dealtime");
                    memo = infoEle.getChildTextTrim("lastmessage");
                    dCn.beginTrans();
                    dImpl.edit("infoopen", "id", id);
                    dImpl.setValue("status", status, CDataImpl.STRING);
                    dImpl.setValue("step", step, CDataImpl.STRING);
                    if("5".equals(step))
                        dImpl.setValue("lastmessage", memo, CDataImpl.STRING);
                    else
                        dImpl.setValue("stepmessage", memo, CDataImpl.STRING);
                    dImpl.update();
                    sql = "select id from taskcenter where iid = '" + id + "' order by id desc";
                    table = dImpl.getDataInfo(sql);
                    if(table != null)
                        tid = CTools.dealNull(table.get("id"));
                    if("0".equals(step) || "1".equals(step) || "2".equals(step))
                        step = "0";
                    else
                    if("-1".equals(step) || "5".equals(step))
                        step = "2";
                    dImpl.edit("taskcenter", "id", tid);
                    dImpl.setValue("status", step, CDataImpl.STRING);
                    dImpl.setValue("endtime", dealtime, CDataImpl.DATE);
                    dImpl.update();
                    dCn.commitTrans();
                    errorStr.append("<MessageChild>");
                    errorStr.append("<id>");
                    errorStr.append(id);
                    errorStr.append("</id>");
                    errorStr.append("<status>");
                    if("".equals(dCn.getLastErrString()))
                        errorStr.append("success");
                    else
                        errorStr.append("fail");
                    errorStr.append("</status>");
                    errorStr.append("</MessageChild>");
                }

                errorStr.append("</MessageBody>");
                errorStr.append("<SourceUnitCode>123</SourceUnitCode><SourceCaseCode>\t\t\t\t1\t\t</SourceCaseCode>\t\t\t<DestUnit>\t\t\t\t<DestUnitCode>216</DestUnitCode>\t\t\t\t<DestCaseCode>371</DestCaseCode>\t\t\t\t<InterFaceCode>\t\t\t\t\t324\t\t\t\t</InterFaceCode>\t\t\t</DestUnit>\t\t\t<Sender>\u73AF\u4FDD\u5C40\u627F\u529E\u4EBA</Sender>\t\t\t<SendTime>\t\t\t\t2007-12-07\t\t\t</SendTime>\t\t\t<EndTime>\t\t\t\t2007-12-07\t\t\t</EndTime>");
                errorStr.append("</DEP_DataExchangeData>");
            }
        }
        catch(Exception e)
        {
            dCn.commitTrans();
            System.out.println("doUpdateInfo : " + e.getMessage());
        }
        finally
        {
            dImpl.closeStmt();
            dCn.closeCn();
        }
        return errorStr;
    }

    public String getInfoopenList(String fileStr)
    {
        String rtnStr = "";
        String filePath = System.getProperty("user.dir") + System.getProperty("file.separator") + "InfoQueryTemplate.xml";
        System.out.println("filePath==="+filePath);
        String queryParam[] = new String[3];
        Vector xmlVec = null;
        Element root = initEle(fileStr);
        Element templateEle = initEle(getTemplateEle(filePath));
        StringBuffer errorStr = new StringBuffer("");
        if(root != null)
        {
            errorStr = checkXml(root, templateEle, errorStr);
            if("".equals(errorStr.toString()))
            {
                queryParam = getQueryParam(root);
                xmlVec = getInfoopen(queryParam);
                if(xmlVec == null)
                {
                    errorStr.append("errorcode:1,没有代号为：" + queryParam[0] + "的部门在时间 " + queryParam[1] + " 到 " + queryParam[2] + "间的数据。");
                    rtnStr = errorStr.toString();
                } else
                {
                    rtnStr = parseInfoopenList(xmlVec, root);
                }
            } else
            {
                rtnStr = errorStr.toString();
            }
        } else
        {
            rtnStr = "errorcode:2,xml格式不能解析。";
        }
        return rtnStr;
    }

    private String getTemplateEle(String filepath)
    {
        StringBuffer source = new StringBuffer("");
        BufferedReader reader = null;
        try
        {
            for(reader = CFile.read(filepath); reader.ready(); source.append(new String(reader.readLine().getBytes("GBK"), "GBK")));
        }
        catch(IOException e)
        {
            System.err.println("ParseBeianXml:getTemplateEle " + e.getMessage());
        }
        return source.toString();
    }

    private StringBuffer checkXml(Element rootEle, Element templateEle, StringBuffer rtnStr)
    {
        List childList = null;
        Element child = null;
        String eleName = "";
        String eleValue = "";
        String compareValue = "";
        String compareTo = "";
        String parentName = "";
        String parentValue = "";
        String parentCompareTo = "";
        Element tempEle = null;
        Element parentEle = null;
        String notnull = "";
        String regEx = "";
        if(rootEle != null)
        {
            childList = rootEle.getChildren();
            if(childList != null)
            {
                for(int cnt = 0; cnt < childList.size(); cnt++)
                {
                    child = (Element)childList.get(cnt);
                    if(child.hasChildren())
                    {
                        checkXml(child, templateEle, rtnStr);
                    } else
                   {
                        eleName = child.getName();
                        eleValue = child.getTextTrim();
                        tempEle = templateEle.getChild(eleName);
                        if(tempEle != null)
                        {
                            compareTo = CTools.dealNull(tempEle.getAttributeValue("COMPARETO"));
                            notnull = CTools.dealNull(tempEle.getAttributeValue("NOTNULL"));
                            compareValue = CTools.dealNull(tempEle.getAttributeValue("COMPAREVALUE"));
                            parentName = CTools.dealNull(tempEle.getAttributeValue("PARENTNAME"));
                            regEx = CTools.dealNull(tempEle.getAttributeValue("REGEX"));
                            if(!"".equals(regEx) && !"".equals(eleValue) && !checkRegex(eleValue, regEx))
                            {
                                if("".equals(rtnStr.toString()))
                                    rtnStr.append("errorcode:2,xml格式错误。");
                                rtnStr.append(eleName);
                                rtnStr.append("节点格式错误,");
                            }
                            if(!"".equals(parentName))
                            {
                                parentEle = rootEle.getChild(parentName);
                                if(parentEle != null)
                                {
                                    parentValue = parentEle.getTextTrim();
                                    if(compareValue.equals(parentValue) || "".equals(compareValue) && !"".equals(parentValue))
                                    {
                                        parentCompareTo = CTools.dealNull(templateEle.getChild(parentName).getAttributeValue("COMPARETO"));
                                        if("Y".equals(notnull) && "".equals(eleValue))
                                        {
                                            if("".equals(rtnStr.toString()))
                                                rtnStr.append("errorcode:2,xml格式错误。");
                                            rtnStr.append(eleName);
                                            rtnStr.append("节点错误:");
                                            rtnStr.append(compareTo);
                                            if(!"".equals(parentCompareTo))
                                                if("".equals(compareValue))
                                                    rtnStr.append("在" + parentCompareTo + "不为空时，");
                                                else
                                                    rtnStr.append("在" + parentCompareTo + "选择为 " + compareValue + " 时，");
                                            rtnStr.append("不能为空；");
                                        }
                                    }
                                }
                            } else
                            if("Y".equals(notnull) && "".equals(eleValue))
                            {
                                if("".equals(rtnStr.toString()))
                                    rtnStr.append("errorcode:2,xml格式错误。");
                                rtnStr.append(eleName);
                                rtnStr.append("节点错误:");
                                rtnStr.append(compareTo);
                                rtnStr.append("不能为空；");
                            }
                        }
                    }
                }

            }
        }
        return rtnStr;
    }

    private boolean checkRegex(String value, String regEx)
    {
        Pattern p = Pattern.compile(regEx);
        Matcher m = p.matcher(value);
        String s = m.replaceAll("");
        return "".equals(s);
    }

    private static Element initEle(String fileStr)
    {
        Document doc = null;
        SAXBuilder sb = null;
        Element element = null;
        try
        { 
            sb = new SAXBuilder();
            java.io.InputStream inputStream = new ByteArrayInputStream(fileStr.getBytes("GBK"));
            doc = sb.build(inputStream);
            element = doc.getRootElement();
        }
        catch(UnsupportedEncodingException ex)
        {
            System.err.println("ParseInfoopen\uFF1AinitEle XML\u7F16\u7801\u9519\u8BEF:UnsupportedEncodingException " + ex.getMessage());
        }
        catch(JDOMException ex)
        {
            System.err.println("ParseInfoopen\uFF1AinitEle XML\u89E3\u6790\u9519\u8BEF:JDOMException " + ex.getMessage());
        }
        return element;
    }

    private Vector getInfoopen(String queryParam[])
    {
        Vector vec;
        vec = null;
        String dtcode = queryParam[0];
        String startTime = queryParam[1];
        String endTime = queryParam[2];
        String sql = "";
        CDataCn dCn = null;
        CDataImpl dImpl = null;
        if("".equals(startTime) && "".equals(endTime))
        {
            startTime = endTime = CDate.getThisday();
            sql = "select parentid,id,infoid,infotitle,proposer,pname,punit,pcard,pcardnum,paddress,pzipcode, decode(ptele,'',etele,ptele) as ptele,decode(pemail,'',eemail,pemail) as pemail,ename, ecode,ebunissinfo,edeputy,elinkman,etele,eemail,to_char(applytime,'yyyy-MM-dd') applytime,commentinfo,indexnum,purpose,ischarge,offermode, gainmode,othermode,feedback,status,dealmode,finishtime,ispublish,signmode,did,dname,flownum,isspot,isrunit, fdid,fdname,applymode,to_char(limittime,'yyyy-MM-dd') limittime,olimittime,memo,us_id,checktype,isovertime,systemname,sender,putstatus,step, stepmessage,status_name,lastmessage,free,isfb from infoopen  where did=(select dt_id from tb_deptinfo where dt_code='" + dtcode + "') " + " and step in(2,12) " + " and to_char(applytime,'yyyy-MM-dd') >= to_char(to_date('" + startTime + "','yyyy-MM-dd'),'yyyy-MM-dd')" + " and to_char(applytime,'yyyy-MM-dd') <= to_char(to_date('" + endTime + "','yyyy-MM-dd'),'yyyy-MM-dd') order by id desc";
        } else
        if("".equals(startTime))
            sql = "select parentid,id,infoid,infotitle,proposer,pname,punit,pcard,pcardnum,paddress,pzipcode, decode(ptele,'',etele,ptele) as ptele,decode(pemail,'',eemail,pemail) as pemail,ename, ecode,ebunissinfo,edeputy,elinkman,etele,eemail,to_char(applytime,'yyyy-MM-dd') applytime,commentinfo,indexnum,purpose,ischarge,offermode, gainmode,othermode,feedback,status,dealmode,finishtime,ispublish,signmode,did,dname,flownum,isspot,isrunit, fdid,fdname,applymode,to_char(limittime,'yyyy-MM-dd') limittime,olimittime,memo,us_id,checktype,isovertime,systemname,sender,putstatus,step, stepmessage,status_name,lastmessage,free,isfb from infoopen  where did=(select dt_id from tb_deptinfo where dt_code='" + dtcode + "') " + " and step in(2,12) " + " and to_char(applytime,'yyyy-MM-dd') <= to_char(to_date('" + endTime + "','yyyy-MM-dd'),'yyyy-MM-dd')  order by id desc";
        else
        if("".equals(endTime))
            sql = "select parentid,id,infoid,infotitle,proposer,pname,punit,pcard,pcardnum,paddress,pzipcode, decode(ptele,'',etele,ptele) as ptele,decode(pemail,'',eemail,pemail) as pemail,ename, ecode,ebunissinfo,edeputy,elinkman,etele,eemail,to_char(applytime,'yyyy-MM-dd') applytime,commentinfo,indexnum,purpose,ischarge,offermode, gainmode,othermode,feedback,status,dealmode,finishtime,ispublish,signmode,did,dname,flownum,isspot,isrunit, fdid,fdname,applymode,to_char(limittime,'yyyy-MM-dd') limittime,olimittime,memo,us_id,checktype,isovertime,systemname,sender,putstatus,step, stepmessage,status_name,lastmessage,free,isfb from infoopen  where did=(select dt_id from tb_deptinfo where dt_code='" + dtcode + "') " + " and step in(2,12) " + " and to_char(applytime,'yyyy-MM-dd') >= to_char(to_date('" + startTime + "','yyyy-MM-dd'),'yyyy-MM-dd')  order by id desc";
        else
        if(!"".equals(startTime) && !"".equals(endTime))
            sql = "select parentid,id,infoid,infotitle,proposer,pname,punit,pcard,pcardnum,paddress,pzipcode, decode(ptele,'',etele,ptele) as ptele,decode(pemail,'',eemail,pemail) as pemail,ename, ecode,ebunissinfo,edeputy,elinkman,etele,eemail,to_char(applytime,'yyyy-MM-dd') applytime,commentinfo,indexnum,purpose,ischarge,offermode, gainmode,othermode,feedback,status,dealmode,finishtime,ispublish,signmode,did,dname,flownum,isspot,isrunit, fdid,fdname,applymode,to_char(limittime,'yyyy-MM-dd') limittime,olimittime,memo,us_id,checktype,isovertime,systemname,sender,putstatus,step, stepmessage,status_name,lastmessage,free,isfb from infoopen  where did=(select dt_id from tb_deptinfo where dt_code='" + dtcode + "') " + " and step in(2,12) " + " and to_char(applytime,'yyyy-MM-dd') >= to_char(to_date('" + startTime + "','yyyy-MM-dd'),'yyyy-MM-dd')" + " and to_char(applytime,'yyyy-MM-dd') <= to_char(to_date('" + endTime + "','yyyy-MM-dd'),'yyyy-MM-dd')  order by id desc";
        System.out.println("sql =" + sql);
        try
        {
            dCn = new CDataCn();
            dImpl = new CDataImpl(dCn);
            vec = dImpl.splitPageOpt(sql, 500, 1);
        }
        catch(Exception e)
        {
            System.out.println("getInfoopen : " + e.getMessage());
        }
        finally
        {
            dImpl.closeStmt();
            dCn.closeCn();
        }
        return vec;
    }

    private String[] getQueryParam(Element root)
    {
        String queryParam[] = new String[3];
        Element element = null;
        element = root.getChild("MessageBody").getChild("queryParam").getChild("queryDeptcode");
        if(element != null)
            queryParam[0] = element.getTextTrim();
        element = root.getChild("MessageBody").getChild("queryParam").getChild("startTime");
        if(element != null)
            queryParam[1] = element.getTextTrim();
        element = root.getChild("MessageBody").getChild("queryParam").getChild("endTime");
        if(element != null)
            queryParam[2] = element.getTextTrim();
        return queryParam;
    }

    private String parseInfoopenList(Vector vec, Element root)
    {
        StringBuffer targetStr = new StringBuffer("");
        Hashtable table = null;
        String filePath = System.getProperty("user.dir") + System.getProperty("file.separator") + "InfoFeedbackTemplate.xml";
        Element templateroot = initEle(getTemplateEle(filePath));
        Element templateEle = null;
        if(templateroot != null)
            templateEle = templateroot.getChild("MessageBody").getChild("MessageChild");
        String eleName = "";
        List list = templateEle.getChildren();
        Element child = null;
        targetStr.append("<?xml version=\"1.0\" encoding=\"GBK\"?>");
        targetStr.append("<DEP_DataExchangeData>");
        targetStr.append("<OperationType>FEEDBACK</OperationType>");
        targetStr.append("<MessageTitle>返回查询结果</MessageTitle>");
        targetStr.append("<MessageID>101</MessageID>");
        targetStr.append("<MessageBody>");
        
        CDataCn dCn = null;
		CDataImpl dImpl = null;
		
		try {
			
			dCn = new CDataCn();
			dImpl = new CDataImpl(dCn);
        
        for(int cnt = 0; cnt < vec.size(); cnt++)
        {
            targetStr.append("<MessageChild>");
            table = (Hashtable)vec.get(cnt);
            for(int count = 0; count < list.size(); count++)
            {
                child = (Element)list.get(count);
                eleName = child.getName();
                if("FILEPUBATTACH".equals(eleName))
                {
                    targetStr.append(getAttachXml(CTools.dealNull(table.get("id"))));
                } else
                {
                    targetStr.append("<" + eleName + ">");
					//信息名称或者信息内容描述 update 20101029
					if("commentinfo".equals(eleName) || "infotitle".equals(eleName)){
						targetStr.append("<![CDATA["+CTools.dealNull(table.get(eleName))+"]]>");
					}else{
						targetStr.append(CTools.dealNull(table.get(eleName)));
					}
					//
                    targetStr.append("</" + eleName + ">");
                }
            }

            targetStr.append("</MessageChild>");
        }

        targetStr.append("</MessageBody>");
        targetStr.append(getRecallStr(root));
        targetStr.append("</DEP_DataExchangeData>");
        CFile.write(System.getProperty("user.dir") + System.getProperty("file.separator") + "infoopenutil_test.xml", targetStr.toString());
    } catch (Exception e) {
		// TODO: handle exception
	}finally{
		dImpl.closeStmt();
		dCn.closeCn();
	}
        return targetStr.toString();
    }

    private StringBuffer getAttachXml(String io_id)
    {
        StringBuffer target;
        target = new StringBuffer("");
        String sql = "select pa_path,pa_filename,pa_name from tb_publishattach where io_id = '" + io_id + "'";
        System.out.println("attach sql = " + sql);
        CDataCn dCn = null;
        CDataImpl dImpl = null;
        Vector vec = null;
        Hashtable table = null;
        String filePath = "";
        String fileStr = "";
        try
        {
            dCn = new CDataCn();
            dImpl = new CDataImpl(dCn);
            filePath = dImpl.getInitParameter("info_save_path");
            vec = dImpl.splitPage(sql, 100, 1);
            if(vec != null)
            {
                target.append("<FILEPUBATTACH>");
                for(int cnt = 0; cnt < vec.size(); cnt++)
                {
                    table = (Hashtable)vec.get(cnt);
                    target.append("<PUBATTACH>");
                    target.append("<FILENAME>");
                    target.append(CTools.dealNull(table.get("pa_filename")));
                    target.append("</FILENAME>");
                    target.append("<FILEREALNAME>");
                    target.append(CTools.dealNull(table.get("pa_name")));
                    target.append("</FILEREALNAME>");
                    target.append("<FILECONTENT>");
                    filePath = filePath + "\\" + CTools.dealNull(table.get("pa_path")) + "\\" + CTools.dealNull(table.get("pa_filename"));
                    //System.out.println("----------------" + filePath);
                    fileStr = CBase64.getFileEncodeString(filePath);
                    target.append(fileStr);
                    target.append("</FILECONTENT>");
                    target.append("</PUBATTACH>");
                }

                target.append("</FILEPUBATTACH>");
            } else
            {
                target.append("<FILEPUBATTACH/>");
            }
        }
        catch(Exception e)
        {
            System.out.println("getAttachXml: " + e.getMessage());
        }
        finally
        {
            dImpl.closeStmt();
            dCn.closeCn();
        }
        return target;
    }

    private String getRecallStr(Element root)
    {
        String rtnStr = "";
        Element recall = root.getChild("MessageBody").getChild("recallParam");
        if(recall != null)
            rtnStr = recall.getTextTrim();
        return rtnStr;
    }
}
