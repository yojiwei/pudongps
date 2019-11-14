/*
 * Copyright (c)Beyondbit Internet Software Co., Ltd.
 *
 * This software is the confidential and proprietary information of
 * Beyondbit Internet Software  Co., Ltd. ("Confidential Information").
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you
 * entered into with Beyondbit Internet Software Co., Ltd.
 */
package com.beyondbit.dom4j;

import java.io.*;
import java.math.*;
import java.security.*;
import java.security.spec.*;
import java.sql.*;
import java.util.*;
import javax.crypto.*;

import org.apache.log4j.*;
import org.dom4j.*;
import com.beyondbit.lucene.index.*;
import com.beyondbit.lucene.index.handler.imp.*;
import com.beyondbit.security.*;
import com.component.newdatabase.*;
import com.util.*;
import sun.misc.*;
//import java.util.Hashtable;
import com.beyondbit.log.DataLog;
import com.beyondbit.lucene.index.LuceneControl;
import com.beyondbit.lucene.index.support.job.IndexPowerStdJob;
import com.beyondbit.lucene.index.support.job.IndexPowerProcessJob;
import com.beyondbit.lucene.index.support.job.IndexPowerLawJob;

/**
 * @author liuyang <br>
 * @date 2007-9-19 <br>
 * @description: 解析xml字符\uFFFD\uFFFD 并且持久\uFFFD\uFFFD 不\uFFFD\uFFFD\uFFFD用于解析有属\uFFFD\uFFFD\uFFFD的xml字符\uFFFD\uFFFD
 * 实现了总分标准后使用的接口
 *
 */
public class CopyOfNewParsePowerXml {

    private static Logger logger = Logger.getLogger(CopyOfNewParsePowerXml.class);

    /**
     * \uFFFD\uFFFD要加密的字段
     */
    private List cryptFieldList = new ArrayList();

    public CopyOfNewParsePowerXml() {
        try {
            LuceneControl.class.forName("java.lang.String");
        }
        catch (ClassNotFoundException ex) {
        }
        //初始化需要加密的字段名称
        //cryptFieldList.add("UNITCODE".toLowerCase());//单位Code
        cryptFieldList.add("UNITNAME".toLowerCase()); //单位名称
        cryptFieldList.add("CREATEUSERNAME".toLowerCase()); //创建人姓\uFFFD\uFFFD
        cryptFieldList.add("COMPANYNAME".toLowerCase()); //申请\uFFFD\uFFFD(企业)
        cryptFieldList.add("RESIDENTNAME".toLowerCase()); //申请\uFFFD\uFFFD(市民)
        cryptFieldList.add("MEMO".toLowerCase()); //自定\uFFFD\uFFFD
        cryptFieldList.add("DES".toLowerCase()); //特殊说明
        cryptFieldList.add("SUPERVISEDES".toLowerCase()); //监管说明

    }

    /**
     * webservice公开方法，持久化权力规范xml，供AXIS调用
     * @param xml \uFFFD\uFFFD.Net后台传过来的xml字符\uFFFD\uFFFD
     * @return
     */
    public String presistentDataByXml(String xml) {
//        exportToFile(xml);
//           if(1==1) return "<?xml version=\"1.0\" encoding=\"UTF-8\"?><string>success</string>";
        try {
            logger.info("权利事项XML\uFFFD\uFFFD" + xml);
            List result = (List) parse(xml);
            String resultString = this.presistent(result);

            if (!"success".equals(resultString)) {
                exportToFile(xml);
            }
            return resultString;
        }
        catch (Exception ex) {
            ex.printStackTrace();
            exportToFile(xml);
            logger.error("持久化权力规范xml出错", ex);
            return ex.getMessage();
        }
    }

    public static void main(String args[]) throws UnsupportedEncodingException {
        //exportToFile("<a>测试</a>");

    }

    static void exportToFile(String xml) {
        try {
            String fileName = "c:\\qlgklogs\\" + System.currentTimeMillis() +
                ".xml";
            java.io.FileWriter writer = new java.io.FileWriter(fileName);
            writer.write(xml);
            writer.close();
        }
        catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    /**
     * webservice公开方法，根据传入的权力运行过程的xml持久化权力过程数据，供AXIS调用
     * @param xml \uFFFD\uFFFD.Net后台传过来的xml字符\uFFFD\uFFFD
     * @return
     */
    public String presistentPowerProcessDataByXml(String xml) {

//         exportToFile(xml);
//        if(1==1) return "<?xml version=\"1.0\" encoding=\"UTF-8\"?><string>success</string>";
        try {
            logger.info("权利运行XML\uFFFD\uFFFD" + xml);
            List result = (List) parseReturnList(xml);
            String resultString = this.presistentProcess(result);
            if (!"success".equals(resultString)) {
                exportToFile(xml);
            }

            return resultString;
        }
        catch (Exception ex) {
            ex.printStackTrace();
            exportToFile(xml);
            logger.error("持久化权力规范xml权力过程数据", ex);
            return ex.getMessage();
        }
    }

    //定义了sqlsever布尔型到Oracle数字型转换标\uFFFD\uFFFD
    private Hashtable parseTOF = new Hashtable();
    {
        parseTOF.put("True", "1");
        parseTOF.put("False", "0");
    }

    private String parseNumberToStr(String str) {
        BigDecimal big = new BigDecimal(str);
        return "" + big.longValue();
    }

    //将xml中传过来的二进制字符串进行BASE64解码\uFFFD\uFFFD.Net端使用BASE64编码\uFFFD\uFFFD
    private byte[] decode(String input) throws Exception {
        BASE64Decoder decoder = new BASE64Decoder();
        if (input != null && !input.equals(""))
            return decoder.decodeBuffer(input);
        else
            return new byte[0];
    }

    /**
     * 解析xml字符串入\uFFFD\uFFFD
     * @param xml xml字符\uFFFD\uFFFD
     * @return 把所有的值封装到hashtable\uFFFD\uFFFD
     * @throws Exception
     */
    private Object parse(String xml) throws Exception {
        Document powerDoc = DocumentHelper.parseText(xml);
        Element root = powerDoc.getRootElement();
        Iterator iter = root.elementIterator();
//        Hashtable result = new Hashtable();
        List list = new ArrayList();
//        Element powerstd = (Element) iter.next();
//        parseElement(powerstd, result);
        parsesubElement(root, list);
        return list;
    }

    /**
     * 解析xml字符串入\uFFFD\uFFFD
     * @param xml
     * @return 将XML转换成DOC对象的List
     * @throws Exception
     */
    private Object parseReturnList(String xml) throws Exception {
        Document powerDoc = DocumentHelper.parseText(xml);
        Element root = powerDoc.getRootElement();
        List list = new ArrayList();
        parsesubElement(root, list);
        return list;
    }

    /**
     * 解析元素 将整个XML文件解析为以字段对应的hashtable方便后续操作
     * @param element \uFFFD\uFFFD要解析的元素
     * @param result 储存值的HashTable
     */
    private void parseElement(Element element, Hashtable result) {
        Iterator iter = element.elementIterator();
        while (iter.hasNext()) {
            Element e = (Element) iter.next();
            if (e.elements().size() == 0) {
                result.put(e.getName().toLowerCase(), e.getText());
            }
            else {
                List list = new ArrayList();
                parsesubElement(e, list);
                result.put(e.getName().toLowerCase(), list);
            }
        }
    }

    /**
     * 解析重复元素 将整个XML文件解析为以字段对应的hashtable方便后续操作
     * @param element
     * @param list
     */
    private void parsesubElement(Element element, List list) {
        Iterator iter = element.elementIterator();
        while (iter.hasNext()) {
            Element e = (Element) iter.next();
            Hashtable result = new Hashtable();
            parseElement(e, result);
            list.add(result);
        }
    }

    /**
     * 持久化权利事项对象，包括调用后续的权力事项步骤和权力依据的持久化
     * @param result
     */
    private String presistent(List result) throws Exception {
        CDataCn dCn = null;
        CDataImpl dImpl = null;
        String resultstr = "success";
        try {
            dCn = new CDataCn();
            dImpl = new CDataImpl(dCn);
            dCn.beginTrans();

            //持久化权力规范，包括持久化当前事项包含的权力依据
            // 持久化权力过\uFFFD\uFFFD
            Iterator iter = result.iterator();
            while (iter.hasNext()) {

//              presistentPowerProcess( (Hashtable) iter.next(), dImpl);
               presistentPowerStd((Map) iter.next(), dImpl);
           }



            if (dCn.getLastErrString() == null ||
                dCn.getLastErrString().length() == 0) {
                dCn.commitTrans();
            }
            else {
                logger.error("持久化权力规范xml权力事项出错:" + dCn.getLastErrString());
                dCn.rollbackTrans();
                resultstr = dCn.getLastErrString();
            }
        }
        catch (Exception ex) {
            ex.printStackTrace();
            logger.error("持久化权力规范xml权力事项", ex);
            dCn.rollbackTrans();
            resultstr = ex.getMessage();
        }
        finally {
            if (dCn != null && dCn.getLastErrString() != null &&
                dCn.getLastErrString().length() > 0) {
                logger.error("持久化权力规范xml权力事项中CDataCn执行报错\uFFFD\uFFFD" +
                             dCn.getLastErrString());
            }

            try {
                if (dImpl != null) {
                    dImpl.closeStmt();
                }
            }
            catch (Exception ex1) {
            }
            try {
                if (dCn != null) {
                    dCn.closeCn();
                }
            }
            catch (Exception ex2) {
            }

        }
        //这里在对象持久化完毕之后调用索引创建，可以避免索引创建占用数据库链接，\uFFFD\uFFFD\uFFFD且确保对象持久化成功后再创建索\uFFFD\uFFFD
        if ("success".equals(resultstr)) {
            LuceneControl.addJob(new IndexPowerStdJob(result));
            LuceneControl.addJob(new IndexPowerLawJob(result));
           /**
            //创建权力事项索引
            String fileurl = LuceneUtils.class.getClassLoader().getResource("").
                getFile() + "../lucene_index/ps";
            File f = new File(fileurl);
            if (!f.exists()) {
                f.mkdirs();
                LuceneUtils.syncCreateIndex(fileurl, true, result,
                                            new PowerStdCreateDocCallBackImpl());
            }
            else {
                LuceneUtils.syncCreateIndex(fileurl, false, result,
                                            new PowerStdCreateDocCallBackImpl());
            }
            //创建权力依据索引
            Vector vec = (Vector) result.get("pslaws");
            if (vec != null) {
                fileurl = LuceneUtils.class.getClassLoader().getResource("").
                    getFile() +
                    "../lucene_index/pl";
                f = new File(fileurl);
                if (!f.exists()) {
                    f.mkdirs();
                    LuceneUtils.syncCreateIndex(fileurl, true, vec,
                                                new
                                                PowerLawCreateDocCallBackImpl());
                }
                else {
                    LuceneUtils.syncCreateIndex(fileurl, false, vec,
                                                new
                                                PowerLawCreateDocCallBackImpl());
                }
            }
            }
           **/
      }
        return resultstr;
    }

    /**
     * 持久化权力过程数\uFFFD\uFFFD
     * @param result
     */
    private String presistentProcess(List result) throws Exception {
        CDataCn dCn = null;
        CDataImpl dImpl = null;
        String resultstr = "success";
        try {
            dCn = new CDataCn();
            dImpl = new CDataImpl(dCn);

            if (result == null) {
                throw new Exception("传入的xml格式 解析不成\uFFFD\uFFFD");
            }
            dCn.beginTrans();
            Iterator iter = result.iterator();

            // 持久化权力过\uFFFD\uFFFD
            while (iter.hasNext()) {
                presistentPowerProcess( (Hashtable) iter.next(), dImpl);
            }

            if (dCn.getLastErrString() == null ||
                dCn.getLastErrString().trim().equals("")) {
                dCn.commitTrans();
            }
            else {
                logger.error("持久化权力规范xml权力过程出错:" + dCn.getLastErrString());
                dCn.rollbackTrans();
                resultstr = dCn.getLastErrString();
            }
        }
        catch (Exception ex) {
            ex.printStackTrace();
            logger.error("持久化权力规范xml权力过程", ex);
            dCn.rollbackTrans();
            resultstr = ex.getMessage();
        }
        finally {
            if (dCn != null && dCn.getLastErrString() != null &&
                dCn.getLastErrString().length() > 0) {
                logger.error("持久化权力规范xml权力过程中CDataCn执行报错\uFFFD\uFFFD" +
                             dCn.getLastErrString());
            }
            try {
                if (dImpl != null) {
                    dImpl.closeStmt();
                }
            }
            catch (Exception ex1) {
            }
            try {
                if (dCn != null) {
                    dCn.closeCn();
                }
            }
            catch (Exception ex2) {
            }

        }
        //这里在对象持久化完毕之后调用索引创建，可以避免索引创建占用数据库链接，\uFFFD\uFFFD\uFFFD且确保对象持久化成功后再创建索\uFFFD\uFFFD
        if ("success".equals(resultstr)) {
            LuceneControl.addJob(new IndexPowerProcessJob(result));
           /**
            //创建权力运行过程索引
            String fileurl = LuceneUtils.class.getClassLoader().getResource("").
                getFile() + "../lucene_index/pp";
            File f = new File(fileurl);
            if (!f.exists()) {
                f.mkdirs();
                LuceneUtils.syncCreateIndex(fileurl, true, result,
                                            new PowerProcessCallBackImpl());
            }
            else {
                LuceneUtils.syncCreateIndex(fileurl, false, result,
                                            new PowerProcessCallBackImpl());
            }
            }
           **/
      }
        return resultstr;
    }

    /**
     * 根据解析xml出来持久化或者更新权力事项及权力依据
     * @param result
     * @param dImpl
     * @throws IOException
     * @throws Exception
     */
    private void presistentPowerStd(Map result, CDataImpl dImpl) throws
        Exception {

        if ("99".equals(result.get("state"))) {
            //删除主表及其子表，步\uFFFD\uFFFD 附件\uFFFD\uFFFD//删除子标\uFFFD\uFFFD ，删除所有步骤，删除 材料\uFFFD\uFFFD
            String sql = "delete tb_qlgk_powerstd where psid = '" +
                result.get("psid") + "'";//删除主表,根据数据库关联，\uFFFD\uFFFD有子记录自动删除

            dImpl.executeUpdate(sql);


            //记录日志
            DataLog.logDataOperate(dImpl, (String) result.get("psid"),
                                   "powerstd",
                                   "12");

            return;
        }

        String sql = "select psid from tb_qlgk_powerstd where psid = " +
            result.get("psid");
        dImpl.setTableName("tb_qlgk_powerstd");
        dImpl.setPrimaryFieldName("psid");
        dImpl.setPrimaryKeyType(CDataImpl.LONG);

        // 首先判断传过来的记录是否存在 存在就修\uFFFD\uFFFD 不存在就新增
        Hashtable ht1 = dImpl.getDataInfo(sql);
        if (ht1 == null || ht1.size() == 0) {
            dImpl.addNew();
            dImpl.setValue("psid", result.get("psid"), CDataImpl.LONG); //权力标准主键ID
            //记录日志
            DataLog.logDataOperate(dImpl, (String) result.get("psid"),
                                   "powerstd",
                                   "10");

        }
        else {
            dImpl.edit(Long.parseLong(result.get("psid").toString())); //权力标准主键ID
            //记录日志
            DataLog.logDataOperate(dImpl, (String) result.get("psid"),
                                   "powerstd",
                                   "11");

        }
        //标准分类ID
        dImpl.setValue("cateid", result.get("cateid"), CDataImpl.LONG);
        //权力标准编号
        dImpl.setValue("pscode", result.get("pscode"), CDataImpl.STRING);
        //权力标准名称
        dImpl.setValue("psname", result.get("psname"), CDataImpl.STRING);
        //权力标准审批状\uFFFD\uFFFD\uFFFD(当该值大\uFFFD\uFFFD1时该权力事项才可以公\uFFFD\uFFFD)
        if (result.get("state") != null &&
            !result.get("state").toString().trim().equals(""))
            dImpl.setValue("state", result.get("state"), CDataImpl.STRING);
            //生效日期
        if (result.get("validdate") != null &&
            !result.get("validdate").toString().trim().equals(""))
            dImpl.setValue("validdate", result.get("validdate"), CDataImpl.DATE);
            //失效日期(当超过失效日期时\uFFFD\uFFFD要有提示)
        if (result.get("invaliddate") != null &&
            !result.get("invaliddate").toString().trim().equals(""))
            dImpl.setValue("invaliddate", result.get("invaliddate"),
                           CDataImpl.DATE);
            //是否归属市民中心(如果是则\uFFFD\uFFFD要在界面上显示直接跳转到市民中心的快捷键)
        if (result.get("ispc") != null && parseTOF.get(result.get("ispc")) != null) {
            dImpl.setValue("ispc", parseTOF.get(result.get("ispc")),
                           CDataImpl.LONG);
        }
        //申请部门ID
        if (result.get("createunitid") != null &&
            !result.get("createunitid").toString().trim().equals(""))
            dImpl.setValue("createunitid", result.get("createunitid"),
                           CDataImpl.LONG);
            //申请部门代号
        dImpl.setValue("createunitcode", result.get("createunitcode"),
                       CDataImpl.STRING);
        //申请部门名称
        dImpl.setValue("createunitname", result.get("createunitname"),
                       CDataImpl.STRING);
        //审核机关ID
        if (result.get("checkunitid") != null &&
            !result.get("checkunitid").toString().trim().equals(""))
            dImpl.setValue("checkunitid", result.get("checkunitid"),
                           CDataImpl.LONG);
            //审核机关代号
        dImpl.setValue("checkunitcode", result.get("checkunitcode"),
                       CDataImpl.STRING);
        //审核机关名称
        dImpl.setValue("checkunitname", result.get("checkunitname"),
                       CDataImpl.STRING);
        //职权主体ID
        if (result.get("aunitid") != null &&
            !result.get("aunitid").toString().trim().equals(""))
            dImpl.setValue("aunitid", result.get("aunitid"), CDataImpl.LONG);
        //行为领域
        dImpl.setValue("domain", result.get("domain"), CDataImpl.STRING);

        //增加前置环节和后置环节
        dImpl.setValue("txtbefore",result.get("txtbefore"),CDataImpl.STRING);
        dImpl.setValue("txtafter",result.get("txtafter"),CDataImpl.STRING);


        //职权主体代号
        dImpl.setValue("aunitcode", result.get("aunitcode"), CDataImpl.STRING);
        //职权主体名称
        dImpl.setValue("aunitname", result.get("aunitname"), CDataImpl.STRING);
        //责任人ID
        dImpl.setValue("auserid", result.get("auserid"), CDataImpl.STRING);
        //责任人姓\uFFFD\uFFFD
        dImpl.setValue("ausername", result.get("ausername"), CDataImpl.STRING);
        //责任人职\uFFFD\uFFFD
        dImpl.setValue("ajob", result.get("ajob"), CDataImpl.STRING);
        //承办机构ID
        if (result.get("bunitid") != null &&
            !result.get("bunitid").toString().trim().equals(""))
            dImpl.setValue("bunitid", result.get("bunitid"), CDataImpl.LONG);
            //承办机构代号
        dImpl.setValue("bunitcode", result.get("bunitcode"), CDataImpl.STRING);
        //承办机构名称
        dImpl.setValue("bunitname", result.get("bunitname"), CDataImpl.STRING);
        //承办人ID
        dImpl.setValue("buserid", result.get("buserid"), CDataImpl.STRING);
        //承办人姓\uFFFD\uFFFD
        dImpl.setValue("busername", result.get("busername"), CDataImpl.STRING);
        //承办人职\uFFFD\uFFFD
        dImpl.setValue("bjob", result.get("bjob"), CDataImpl.STRING);
        //行为领域ID
        if (result.get("attr1id") != null &&
            !result.get("attr1id").toString().trim().equals(""))
            dImpl.setValue("attr1id", result.get("attr1id"), CDataImpl.LONG);
            //行为领域名称，对应属性表
        dImpl.setValue("attr1name", result.get("attr1name"), CDataImpl.STRING);
        //预留字段
        if (result.get("attr2id") != null &&
            !result.get("attr2id").toString().trim().equals(""))
            dImpl.setValue("attr2id", result.get("attr2id"), CDataImpl.LONG);
            //预留字段
        dImpl.setValue("attr2name", result.get("attr2name"), CDataImpl.STRING);
        //预留字段
        if (result.get("attr3id") != null &&
            !result.get("attr3id").toString().trim().equals(""))
            dImpl.setValue("attr3id", result.get("attr13d"), CDataImpl.LONG);
            //预留字段
        dImpl.setValue("attr3name", result.get("attr3name"), CDataImpl.STRING);
        //预留字段
        if (result.get("attr4id") != null &&
            !result.get("attr4id").toString().trim().equals(""))
            dImpl.setValue("attr4id", result.get("attr4id"), CDataImpl.LONG);
            //预留字段
        dImpl.setValue("attr4name", result.get("attr4name"), CDataImpl.STRING);
        //预留字段
        if (result.get("attr5id") != null &&
            !result.get("attr5id").toString().trim().equals(""))
            dImpl.setValue("attr5id", result.get("attr5id"), CDataImpl.LONG);
        //预留字段
        dImpl.setValue("attr5name", result.get("attr5name"), CDataImpl.STRING);

        //示意\uFFFD\uFFFD(\uFFFD\uFFFD)文件\uFFFD\uFFFD
        dImpl.setValue("diagrampiclname", result.get("diagrampiclname"),
                       CDataImpl.STRING);
        //示意\uFFFD\uFFFD(\uFFFD\uFFFD)类型(可直接用于设置response.setContentType)
        dImpl.setValue("diagrampicltype", result.get("diagrampicltype"),
                       CDataImpl.STRING);
        //示意\uFFFD\uFFFD(\uFFFD\uFFFD)文件\uFFFD\uFFFD
        dImpl.setValue("diagrampicsname", result.get("diagrampicsname"),
                       CDataImpl.STRING);
        //示意\uFFFD\uFFFD(\uFFFD\uFFFD)类型(可直接用于设置response.setContentType)
        dImpl.setValue("diagrampicstype", result.get("diagrampicstype"),
                       CDataImpl.STRING);
        //权利标准名称
        dImpl.setValue("lawname", result.get("lawbasisname"), CDataImpl.STRING);
        //权力标准的权\uFFFD\uFFFD(如金额\uFFFD\uFFFD\uFFFD土地面积等)
        if (result.get("pslimit") != null && !result.get("pslimit").equals(""))
            dImpl.setValue("pslimit",
                           parseNumberToStr(result.get("pslimit").toString()),
                           CDataImpl.FLOAT);

            //权力标准的权限单\uFFFD\uFFFD(如万元，亩等)
        dImpl.setValue("pslimitunit", result.get("pslimitunit"),
                       CDataImpl.STRING);
        //权力标准的时\uFFFD\uFFFD
        dImpl.setValue("duetimelimit", result.get("duetimelimit"),
                       CDataImpl.LONG);
        //权力标准公开范围(当\uFFFD\uFFFD\uFFFD为2，即公开范围为\uFFFD\uFFFD\uFFFD公众时才可以显示\uFFFD\uFFFD\uFFFD)
        if (result.get("openscope") != null &&
            !result.get("openscope").toString().trim().equals(""))
            dImpl.setValue("openscope", result.get("openscope"), CDataImpl.LONG);
            //申请日期
        if (result.get("createdate") != null &&
            !result.get("createdate").toString().trim().equals(""))
            dImpl.setValue("createdate", result.get("createdate"),
                           CDataImpl.DATE);
            //申请人ID
        dImpl.setValue("createuserid", result.get("createuserid"),
                       CDataImpl.STRING);
        //申请人姓\uFFFD\uFFFD
        dImpl.setValue("createusername", result.get("createusername"),
                       CDataImpl.STRING);
        //审核日期
        if (result.get("checkdate") != null &&
            !result.get("checkdate").toString().trim().equals(""))
            dImpl.setValue("checkdate", result.get("checkdate"), CDataImpl.DATE);
            //审核人ID
        dImpl.setValue("checkuserid", result.get("checkuserid"),
                       CDataImpl.STRING);
        //审核人姓\uFFFD\uFFFD
        dImpl.setValue("checkusername", result.get("checkusername"),
                       CDataImpl.STRING);
        dImpl.update();
        dImpl.edit(Long.parseLong(result.get("psid").toString()));

//        dImpl.dataCn.beginTrans();
        //示意\uFFFD\uFFFD(\uFFFD\uFFFD)二进制数\uFFFD\uFFFD
        dImpl.setBlobValue("diagrampicldata",
                           decode(CTools.dealNull(result.get("diagrampicldata"))));
        //示意\uFFFD\uFFFD(\uFFFD\uFFFD)二进制数\uFFFD\uFFFD
        dImpl.setBlobValue("diagrampicsdata",
                           decode(CTools.dealNull(result.get("diagrampicsdata"))));
//        dImpl.dataCn.commitTrans();

        if (result.get("basises") != null &&
            result.get("basises") instanceof List) {
            //保存法律依据
            saveBasises( (String) result.get("psid"),
                        (List) result.get("basises"), dImpl);
        }

        if (result.get("subpowerstds") != null &&
            result.get("subpowerstds") instanceof List) {
            //保存权力标准
            saveSubPowerStds( (String) result.get("psid"),
                             (List) result.get("subpowerstds"), dImpl);
        }

        /**
                 // 增加法律依据，首先判断是否有法律依据
                 if (result.get("lawbasisname") != null &&
            !result.get("lawbasisname").equals("")) {
            //这里判断



            sql = "select lawname from tb_qlgk_law where lawname = '" +
                result.get("lawbasisname") + "'";
            dImpl.setTableName("tb_qlgk_law");
            dImpl.setPrimaryFieldName("lawname");
            dImpl.setPrimaryKeyType(CDataImpl.STRING);
            //判断该依据是否存\uFFFD\uFFFD
            Hashtable ht2 = dImpl.getDataInfo(sql);
            if (ht2 == null || ht2.size() == 0) {
                dImpl.addNew();
                //权利依据名称
                dImpl.setValue("lawname", result.get("lawbasisname"),
                               CDataImpl.STRING);
                dImpl.update();
            }
            dImpl.edit(result.get("lawbasisname").toString());


            //法律依据内容已内嵌XML的形式存储，\uFFFD\uFFFD要二次解\uFFFD\uFFFD
            Document lawbasis = DocumentHelper.parseText( (String) result.get(
                "lawbasis"));
            Element rootelement = lawbasis.getRootElement();
            rootelement.element("");
            //权利依据名称(管理后台传过来的权利依据名称，和LAWNAMW内容相同)
            dImpl.setValue("authorityby",
                           getSubElementText(rootelement, "AuthorityBy"),
                           CDataImpl.STRING);
            //权利依据类型
            dImpl.setValue("bykind", getSubElementText(rootelement, "ByKind"),
                           CDataImpl.STRING);
            //制定机关
            dImpl.setValue("consteorgan",
                           getSubElementText(rootelement, "ConsteOrgan"),
                           CDataImpl.STRING);
            //制定日期
            if (getSubElementText(rootelement, "ConsteDate") != null
                && !"".equals(getSubElementText(rootelement, "ConsteDate")))
                dImpl.setValue("constedate",
                               getSubElementText(rootelement, "ConsteDate"),
                               CDataImpl.DATE);
            dImpl.update();
            //描述
            dImpl.setClobValue("describe",
                               getSubElementText(rootelement, "Describe"));

            //此处为了防止过久占用数据库链接\uFFFD\uFFFD\uFFFD将权利依据的全文索引放到数据库操作之外进行
            Hashtable ht = new Hashtable();
            ht.put("lawname", result.get("lawbasisname"));
            //ht.put("authorityby", rootelement.element("AuthorityBy"));
            //ht.put("bykind", rootelement.element("ByKind"));
            //ht.put("consteorgan", rootelement.element("ConsteOrgan"));
            //ht.put("describe", rootelement.element("Describe"));

         ht.put("authorityby", getSubElementText(rootelement, "AuthorityBy"));
            ht.put("bykind", getSubElementText(rootelement, "ByKind"));
         ht.put("consteorgan", getSubElementText(rootelement, "ConsteOrgan"));
            ht.put("describe", getSubElementText(rootelement, "Describe"));
            Vector vec = new Vector();
            vec.add(ht);
            result.put("pslaws", vec);
                 }
         }
         }**/
    }

    /**
     * saveSubPowerStds
     * 保存子权力标\uFFFD\uFFFD
     * @param object Object
     * @param dImpl CDataImpl
     */
    private void saveSubPowerStds(String powerStdid, List list, CDataImpl dImpl) throws
        Exception {
        for (int i = 0; i < list.size(); i++) {
            Hashtable result = (Hashtable) list.get(i);

            if ("99".equals(result.get("state"))) {
                //删除主表及其子表，步\uFFFD\uFFFD 附件\uFFFD\uFFFD
                String sql = "delete tb_qlgk_subpowerstd where id = '" +
                    result.get("id") + "'";
                dImpl.executeUpdate(sql);

                //记录日志
                DataLog.logDataOperate(dImpl, (String) result.get("id"),
                                       "subpowerstd",
                                       "12");

                continue;
            }

            String sql = "select id from tb_qlgk_subpowerstd where id = " +
                result.get("id");
            dImpl.setTableName("tb_qlgk_subpowerstd");
            dImpl.setPrimaryFieldName("id");
            dImpl.setPrimaryKeyType(CDataImpl.LONG);

            // 首先判断传过来的记录是否存在 存在就修\uFFFD\uFFFD 不存在就新增
            Hashtable ht1 = dImpl.getDataInfo(sql);
            if (ht1 == null || ht1.size() == 0) {
                dImpl.addNew();
                dImpl.setValue("id", result.get("id"), CDataImpl.LONG); //权力标准主键ID
                //记录日志
                DataLog.logDataOperate(dImpl, (String) result.get("id"),
                                       "subpowerstd",
                                       "10");

            }
            else {
                dImpl.edit(Long.parseLong(result.get("id").toString())); //权力标准主键ID
                //记录日志
                DataLog.logDataOperate(dImpl, (String) result.get("id"),
                                       "subpowerstd",
                                       "11");

            }

            //与\uFFFD\uFFFD\uFFFD标准的外健
            dImpl.setValue("powerstd_id", result.get("powerstd_id"),
                           CDataImpl.LONG);

            //权力标准审批状\uFFFD\uFFFD\uFFFD(当该值大\uFFFD\uFFFD1时该权力事项才可以公\uFFFD\uFFFD)
            if (result.get("state") != null &&
                !result.get("state").toString().trim().equals(""))
                dImpl.setValue("state", result.get("state"), CDataImpl.STRING);

                //申请部门ID
            if (result.get("createunitid") != null &&
                !result.get("createunitid").toString().trim().equals(""))
                dImpl.setValue("createunitid", result.get("createunitid"),
                               CDataImpl.LONG);

                //申请部门名称
            dImpl.setValue("createunitname", result.get("createunitname"),
                           CDataImpl.STRING);

            //职位
            if (result.get("createuserjob") != null &&
                !"".equals(result.get("createuserjob"))) {
                dImpl.setValue("createuserjob", result.get("createuserjob"),
                               CDataImpl.STRING);
            }

            //申请日期
            if (result.get("createdate") != null &&
                !result.get("createdate").toString().trim().equals(""))
                dImpl.setValue("createtime", result.get("createdate"),
                               CDataImpl.DATE);
                //申请人ID
            dImpl.setValue("createuserid", result.get("createuserid"),
                           CDataImpl.STRING);
            //申请人姓\uFFFD\uFFFD
            dImpl.setValue("createusername", result.get("createusername"),
                           CDataImpl.STRING);

            /**修改后增\uFFFD\uFFFD**/

            //审核机关ID
            if (result.get("checkunitid") != null &&
                !result.get("checkunitid").toString().trim().equals(""))
                dImpl.setValue("checkunitid", result.get("checkunitid"),
                               CDataImpl.LONG);
                //审核机关代号
            dImpl.setValue("checkunitcode", result.get("checkunitcode"),
                           CDataImpl.STRING);
            //审核机关名称
            dImpl.setValue("checkunitname", result.get("checkunitname"),
                           CDataImpl.STRING);
            //职权主体ID
            if (result.get("aunitid") != null &&
                !result.get("aunitid").toString().trim().equals(""))
                dImpl.setValue("aunitid", result.get("aunitid"), CDataImpl.LONG);
                //职权主体代号
            dImpl.setValue("aunitcode", result.get("aunitcode"),
                           CDataImpl.STRING);
            //职权主体名称
            dImpl.setValue("aunitname", result.get("aunitname"),
                           CDataImpl.STRING);
            //责任人ID
            dImpl.setValue("auserid", result.get("auserid"), CDataImpl.STRING);
            //责任人姓\uFFFD\uFFFD
            dImpl.setValue("ausername", result.get("ausername"),
                           CDataImpl.STRING);
            //责任人职\uFFFD\uFFFD
            dImpl.setValue("ajob", result.get("ajob"), CDataImpl.STRING);
            //承办机构ID
            if (result.get("bunitid") != null &&
                !result.get("bunitid").toString().trim().equals(""))
                dImpl.setValue("bunitid", result.get("bunitid"), CDataImpl.LONG);
                //承办机构代号
            dImpl.setValue("bunitcode", result.get("bunitcode"),
                           CDataImpl.STRING);
            //承办机构名称
            dImpl.setValue("bunitname", result.get("bunitname"),
                           CDataImpl.STRING);
            //承办人ID
            dImpl.setValue("buserid", result.get("buserid"), CDataImpl.STRING);
            //承办人姓\uFFFD\uFFFD
            dImpl.setValue("busername", result.get("busername"),
                           CDataImpl.STRING);
            //承办人职\uFFFD\uFFFD
            dImpl.setValue("bjob", result.get("bjob"), CDataImpl.STRING);

            //权力标准的权\uFFFD\uFFFD
            dImpl.setValue("pslimit", result.get("pslimit"),
                           CDataImpl.STRING);

            //权力标准的权限单\uFFFD\uFFFD(如万元，亩等)
            dImpl.setValue("pslimitunit", result.get("pslimitunit"),
                           CDataImpl.STRING);
            //权力标准的时\uFFFD\uFFFD
            dImpl.setValue("duetimelimit", result.get("duetimelimit"),
                           CDataImpl.LONG);
            //审核日期
            if (result.get("checkdate") != null &&
                !result.get("checkdate").toString().trim().equals(""))
                dImpl.setValue("checkdate", result.get("checkdate"),
                               CDataImpl.DATE);
                //审核人ID
            dImpl.setValue("checkuserid", result.get("checkuserid"),
                           CDataImpl.STRING);
            //审核人姓\uFFFD\uFFFD
            dImpl.setValue("checkusername", result.get("checkusername"),
                           CDataImpl.STRING);
            //职权主体手写
            dImpl.setValue("zt", result.get("zt"),
                           CDataImpl.STRING);
            //承办单位手写
            dImpl.setValue("cb", result.get("cb"),
                           CDataImpl.STRING);
            //三重\uFFFD\uFFFD\uFFFD\uFFFD
            if (result.get("attr1") != null &&
                !result.get("attr1").toString().trim().equals(""))
                dImpl.setValue("attr1id", result.get("attr1"), CDataImpl.LONG);
                //三重\uFFFD\uFFFD\uFFFD\uFFFD
            if (result.get("attr1name") != null &&
                !result.get("attr1name").toString().trim().equals(""))
                dImpl.setValue("attr1name", result.get("attr1name"), CDataImpl.STRING);


            //执行更新
            dImpl.update();
            /**
             *  持久\uFFFD\uFFFD<b>\uFFFD\uFFFD</b>权力规范步骤
             */
            presistentSubPowerStdSteps(result, dImpl);
            /**
             * 放到主表中去保存
             *
            //保存法律依据
            if (result.get("basises") != null &&
                result.get("basises") instanceof List) {
                //保存法律依据
                saveBasises( (String) result.get("psid"),
                            (List) result.get("basises"), dImpl);
            }
            **/
        }

    }

    //保存法律依据
    private void saveBasises(String psid, List list, CDataImpl dImpl) {


        //遍历\uFFFD\uFFFD有的法律依据，\uFFFD\uFFFD\uFFFD条增加
        for (int i = 0; i < list.size(); i++) {
            Hashtable result = (Hashtable) list.get(i);
            //先删除所有的法律依据，再增加
//            String sql = "delete tb_qlgk_law where id = '" +
//                result.get("id") + "'";
//            dImpl.executeUpdate(sql);


            String sql = "select id from tb_qlgk_law where id = " +
                result.get("id");
            dImpl.setTableName("tb_qlgk_law");
            dImpl.setPrimaryFieldName("id");
            dImpl.setPrimaryKeyType(CDataImpl.LONG);

            // 首先判断传过来的记录是否存在 存在就修\uFFFD\uFFFD 不存在就新增
            Hashtable ht1 = dImpl.getDataInfo(sql);
            if (ht1 == null || ht1.size() == 0) {
                dImpl.addNew();
                dImpl.setValue("id", result.get("id"), CDataImpl.LONG); //权力标准主键ID
                dImpl.update();
            }
//            else {
                dImpl.edit(Long.parseLong(result.get("id").toString())); //权力标准主键ID
//            }

            dImpl.setTableName("tb_qlgk_law");
            dImpl.setPrimaryFieldName("id");
            dImpl.setPrimaryKeyType(CDataImpl.LONG);
//            long id = dImpl.addNew();
            //建立索引时需要用到该\uFFFD\uFFFD

            dImpl.setValue("id", result.get("id"),
                           CDataImpl.LONG);
//            dImpl.edit(id);
//            dImpl.edit(result.get("name").toString());
            //权利依据名称
            dImpl.setValue("lawname", result.get("name"),
                           CDataImpl.STRING);

            //权利依据名称(管理后台传过来的权利依据名称，和LAWNAMW内容相同)
            dImpl.setValue("authorityby",
                           result.get("name"),
                           CDataImpl.STRING);

            //外键值，与权力标准的关联
            dImpl.setValue("psid", psid, CDataImpl.LONG);

            //权利依据类型
            dImpl.setValue("bykind", result.get("type"),
                           CDataImpl.STRING);
            //制定机关
            dImpl.setValue("consteorgan",
                           result.get("unitname"),
                           CDataImpl.STRING);
            //制定日期
            if (result.get("effectdate") != null
                && !"".equals(result.get("effectdate")))
                dImpl.setValue("constedate",
                               result.get("effectdate"),
                               CDataImpl.DATE);
            dImpl.update();
//            dImpl.dataCn.commitTrans();
//            dImpl.dataCn.beginTrans();
            //描述
            dImpl.setClobValue("describe",
                               result.get("content"));
//            dImpl.dataCn.commitTrans();
            //此处为了防止过久占用数据库链接\uFFFD\uFFFD\uFFFD将权利依据的全文索引放到数据库操作之外进行
//          Hashtable ht = new Hashtable();
//          ht.put("lawname", result.get("lawbasisname"));
            //ht.put("authorityby", rootelement.element("AuthorityBy"));
            //ht.put("bykind", rootelement.element("ByKind"));
            //ht.put("consteorgan", rootelement.element("ConsteOrgan"));
            //ht.put("describe", rootelement.element("Describe"));

//          ht.put("authorityby", getSubElementText(rootelement, "AuthorityBy"));
//          ht.put("bykind", getSubElementText(rootelement, "ByKind"));
//          ht.put("consteorgan", getSubElementText(rootelement, "ConsteOrgan"));
//          ht.put("describe", getSubElementText(rootelement, "Describe"));
//          Vector vec = new Vector();
//          vec.add(ht);
//          result.put("pslaws", vec);

        }
    }

    /**
     * 获取执行子元素内\uFFFD\uFFFD
     * @param e
     * @param subElementName子元素名\uFFFD\uFFFD
     * @return
     */
    private String getSubElementText(Element e, String subElementName) {
        List children = e.elements();
        Element child = null;
        for (int i = 0; i < children.size(); i++) {
            child = (Element) children.get(i);
            if (subElementName != null &&
                subElementName.equalsIgnoreCase(child.getName())) {
                return child.getTextTrim();
            }
        }
        return null;
    }

    /**
     * 持久化权力规范步\uFFFD\uFFFD
     * @param results 解析xml产生的HashTable集合
     * @param dImpl 数据操作对象
     * @throws Exception
     * @throws Exception
     */
    private void presistentSubPowerStdSteps(Hashtable results, CDataImpl dImpl) throws
        Exception {
        if (! (results.get("powerstdsteps") instanceof ArrayList)) {
            return;
        }
        List steps = (List) results.get("powerstdsteps");
        String psid = results.get("powerstd_id").toString();
        if (steps == null || steps.size() == 0) {
            return;
        }
        for (int i = 0; i < steps.size(); i++) {
            Hashtable result = (Hashtable) steps.get(i);
            String sql =
                "select stepid from tb_qlgk_powerstdstep where stepid = " +
                result.get("stepid");
            dImpl.setTableName("tb_qlgk_powerstdstep");
            dImpl.setPrimaryFieldName("stepid");
            dImpl.setPrimaryKeyType(CDataImpl.LONG);
            // 首先判断传过来的记录是否存在 存在就修\uFFFD\uFFFD 不存在就新增
            Hashtable ht = dImpl.getDataInfo(sql);
            if (ht == null || ht.size() == 0) {
                dImpl.addNew();
                //步骤主键ID
                dImpl.setValue("stepid", result.get("stepid"), CDataImpl.LONG);
            }
            else {
                dImpl.edit(Long.parseLong(result.get("stepid").toString()));
            }
            //与分标准表的外键
            dImpl.setValue("subpowerstd_id", results.get("id"), CDataImpl.LONG);

            //步骤名称
            dImpl.setValue("stepname", result.get("stepname"), CDataImpl.STRING);
            //对应的权力标准ID
            dImpl.setValue("psid", psid, CDataImpl.LONG);
            //角色名称
            dImpl.setValue("rolename", result.get("rolename"), CDataImpl.STRING);
            //上一步ID(仅供显示参\uFFFD\uFFFD\uFFFD，并不起到标示顺序的作\uFFFD\uFFFD)
            dImpl.setValue("prevstepid", result.get("prevstepid"),
                           CDataImpl.STRING);
            //下一步ID(仅供显示参\uFFFD\uFFFD\uFFFD，并不起到标示顺序的作\uFFFD\uFFFD)
            dImpl.setValue("nextstepid", result.get("nextstepid"),
                           CDataImpl.STRING);
            //是否是关键步\uFFFD\uFFFD(如果值为1则在显示时在步骤名称上做标示)
            if (result.get("iskey") != null && parseTOF.get(result.get("iskey")) != null) {
                dImpl.setValue("iskey", parseTOF.get(result.get("iskey")),
                               CDataImpl.LONG);
            }
            //是否是内部步骤，如果\uFFFD\uFFFD(值为1)则不能向公众展示
            if (result.get("isinner") != null &&
                parseTOF.get(result.get("isinner")) != null) {
                dImpl.setValue("isinner", parseTOF.get(result.get("isinner")),
                               CDataImpl.LONG);
            }
            //\uFFFD\uFFFD长权力标准的时限
            if (result.get("maxduetimelimit") != null &&
                !result.get("maxduetimelimit").equals("")) {
                dImpl.setValue("maxduetimelimit",
                               parseNumberToStr(result.get("maxduetimelimit").
                                                toString()),
                               CDataImpl.LONG);
            }
            //\uFFFD\uFFFD大权力标准的权限
            if (result.get("maxpslimit") != null &&
                !result.get("maxpslimit").equals("")) {
                dImpl.setValue("maxpslimit",
                               parseNumberToStr(result.get("maxpslimit").
                                                toString()),
                               CDataImpl.LONG);
            }

            //\uFFFD\uFFFD大权力标准的权限单位
            if (result.get("maxpslimitunit") != null &&
                !result.get("maxpslimitunit").equals("")) {
                dImpl.setValue("maxpslimitunit",
                               parseNumberToStr(result.get("maxpslimitunit").
                                                toString()),
                               CDataImpl.STRING);
            }

            //分组\uFFFD\uFFFD
            dImpl.setValue("groupname", result.get("groupname"),
                           CDataImpl.STRING);
            //音频说明文件文件\uFFFD\uFFFD
            dImpl.setValue("audiodesname", result.get("audiodesname"),
                           CDataImpl.STRING);
            //音频说明文件类型
            dImpl.setValue("audiodestype", result.get("audiodestype"),
                           CDataImpl.STRING);
            //备注
            dImpl.setValue("des", result.get("des"), CDataImpl.STRING);
            dImpl.update();
//            dImpl.edit(Long.parseLong(result.get("stepid").toString()));
            //音频说明文件数据
            dImpl.setBlobValue("audiodesdata",
                               decode(CTools.dealNull(result.get("audiodesdata"))));

            // 获取步骤\uFFFD\uFFFD\uFFFD\uFFFD文件 持久\uFFFD\uFFFD
            if (! (result.get("stepfiles") instanceof List)) {
                continue;
            }
            List stepfiles = (List) result.get("stepfiles");
            //持久化事项附\uFFFD\uFFFD
            presistentPSFiles(stepfiles, dImpl, result.get("stepid").toString(),psid);
        }
    }

    /**
     * 持久化权力规范的步骤文件
     * @param list 步骤文件列表
     * @param dImpl 数据库操作对\uFFFD\uFFFD
     * @throws IOException
     * @throws Exception
     */
    private void presistentPSFiles(List list, CDataImpl dImpl, String sid,String psid) throws
        Exception, IOException {
        if (list == null || list.size() == 0) {
            return;
        }
        for (int i = 0; i < list.size(); i++) {
            Hashtable result = (Hashtable) list.get(i);
            // 先判断是否存\uFFFD\uFFFD

            String sql = "select fileid from tb_qlgk_psfile where fileid = " +
                result.get("fileid");
            dImpl.setTableName("tb_qlgk_psfile");
            dImpl.setPrimaryFieldName("fileid");
            dImpl.setPrimaryKeyType(CDataImpl.LONG);
            Hashtable ht = dImpl.getDataInfo(sql);
            if (ht == null || ht.size() == 0) {
                dImpl.addNew();
                //主键ID
                dImpl.setValue("fileid", result.get("fileid"), CDataImpl.LONG);
            }
            else {
                dImpl.edit(Long.parseLong(result.get("fileid").toString()));
            }
            //文件代号
            dImpl.setValue("filecode", result.get("filecode"), CDataImpl.STRING);
            //权利事项ID(不用)
            dImpl.setValue("psid", result.get("psid"), CDataImpl.STRING);
            //文件名称
            dImpl.setValue("filename", result.get("filename"), CDataImpl.STRING);
            //是否公开
            if (result.get("isopen") != null &&
                parseTOF.get(result.get("isopen")) != null) {
                dImpl.setValue("isopen", parseTOF.get(result.get("isopen")),
                               CDataImpl.LONG);
            }
            //是否必须
            if (result.get("ismust") != null &&
                parseTOF.get(result.get("ismust")) != null) {
                dImpl.setValue("ismust", parseTOF.get(result.get("ismust")),
                               CDataImpl.LONG);
            }
            //是否输入
            if (result.get("isinput") != null &&
                parseTOF.get(result.get("isinput")) != null) {
                dImpl.setValue("isinput", parseTOF.get(result.get("isinput")),
                               CDataImpl.LONG);
            }
            //是否输出
            if (result.get("isoutput") != null &&
                parseTOF.get(result.get("isoutput")) != null) {
                dImpl.setValue("isoutput", parseTOF.get(result.get("isoutput")),
                               CDataImpl.LONG);
            }
            //附件权力标准id
            dImpl.setValue("psid",psid,CDataImpl.LONG);
            //附件文档文件\uFFFD\uFFFD
            dImpl.setValue("edocname", result.get("edocname"), CDataImpl.STRING);
            //附件文档文件类型(如doc、rtf\uFFFD\uFFFD)
            dImpl.setValue("edoctype", result.get("edoctype"), CDataImpl.STRING);
            //附件示意图文件名
            dImpl.setValue("diagrampicname", result.get("diagrampicname"),
                           CDataImpl.STRING);
            //附件示意图文类型(如gif、jpg\uFFFD\uFFFD)
            dImpl.setValue("diagrampictype", result.get("diagrampictype"),
                           CDataImpl.STRING);
            //备注
            dImpl.setValue("des", result.get("des"), CDataImpl.STRING);
            dImpl.update();
            dImpl.edit(Long.parseLong(result.get("fileid").toString()));

            dImpl.dataCn.beginTrans();
            //附件文档数据
            dImpl.setBlobValue("edocdata",
                               decode(CTools.dealNull(result.get("edocdata"))));
            //附件示意图数\uFFFD\uFFFD
            dImpl.setBlobValue("diagrampicdata",
                               decode(CTools.dealNull(result.get(
                "diagrampicdata"))));
//            dImpl.dataCn.commitTrans();

            sql = "delete from tb_qlgk_stepfiles where sid = " + sid;
            dImpl.executeUpdate(sql);
            // 持久化步骤文件映射对\uFFFD\uFFFD
            sql = "select sfid from tb_qlgk_stepfiles where sfid = " +
                result.get("sfid");
            dImpl.setTableName("tb_qlgk_stepfiles");
            dImpl.setPrimaryFieldName("sfid");
            dImpl.setPrimaryKeyType(CDataImpl.LONG);
            if (dImpl.getDataInfo(sql) == null) {
                dImpl.addNew();
                //主键ID
                dImpl.setValue("sfid", result.get("sfid"), CDataImpl.LONG);
            }
            else {
                dImpl.edit(Long.parseLong(result.get("sfid").toString()));
            }
            //步骤ID
            dImpl.setValue("sid", sid, CDataImpl.LONG);
            //附件ID
            dImpl.setValue("psfid", result.get("fileid"), CDataImpl.LONG);
            //是否必须
            if (result.get("ismust") != null &&
                parseTOF.get(result.get("ismust")) != null) {
                dImpl.setValue("ismust", parseTOF.get(result.get("ismust")),
                               CDataImpl.LONG);
            }
            //是否输入文件
            if (result.get("isinput") != null &&
                parseTOF.get(result.get("isinput")) != null) {
                dImpl.setValue("isinput", parseTOF.get(result.get("isinput")),
                               CDataImpl.LONG);
            }
            //是否输出文件
            if (result.get("isoutput") != null &&
                parseTOF.get(result.get("isoutput")) != null) {
                dImpl.setValue("isoutput", parseTOF.get(result.get("isoutput")),
                               CDataImpl.LONG);
            }
            dImpl.update();
        }
    }

    /**
     * \uFFFD\uFFFD查是否可以公\uFFFD\uFFFD
     * @param ppid 权力运行id
     * @return 是否可以公开 true是可以公\uFFFD\uFFFD false 是不可以公开
     * @throws SQLException
     */
    private boolean checkPublic(String pscode, CDataImpl dImpl) throws
        SQLException {
        ResultSet rs = null;
        try {
            String sql = "select t2.openscope from "
                +
                "tb_qlgk_powerstd t2 where t2.openscope=2" +
                " and t2.pscode=" + pscode;
            rs = dImpl.executeQuery(sql);

            if (rs.next()) {
                return true;
            }
            return false;
        }
        catch (SQLException e) {
            // TODO Auto-generated catch block
            throw e;
        }
        finally {
            if (rs != null) {
                try {
                    rs.close();
                }
                catch (SQLException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * 加密数据，将data 中需要加密的字段加密
     * @param data map型数\uFFFD\uFFFD
     * @throws NoSuchPaddingException
     * @throws InvalidKeySpecException
     * @throws NoSuchAlgorithmException
     * @throws InvalidKeyException
     * @throws UnsupportedEncodingException
     */
    private void encrypt(Map data) throws InvalidKeyException,
        NoSuchAlgorithmException, InvalidKeySpecException,
        NoSuchPaddingException, UnsupportedEncodingException {
        DESUtil des = new DESUtil();
        if (data == null)
            return;
        Object key = null;
        Object value = null;
        //循环map的健\uFFFD\uFFFD
        Iterator it = data.keySet().iterator();
        while (it.hasNext()) {
            //获得健\uFFFD\uFFFD\uFFFD
            key = it.next();
            //如果该健内容\uFFFD\uFFFD要加\uFFFD\uFFFD
            if (this.cryptFieldList.contains(key)) {
                value = data.get(key);
                //加密内容
                if (value != null && value instanceof String) {
                    data.put(key, des.encrypt( (String) value));
                }
            }
        }

    }

    /**
     * 持久化权力运行过程文\uFFFD\uFFFD
     * @param result PowerProcess过程
     * @param dImpl 数据库操作对\uFFFD\uFFFD
     * @throws IOException
     * @throws Exception
     */
    private void presistentPowerProcess(Hashtable result, CDataImpl dImpl) throws
        Exception {
        //新规定中如果state则要求这里删\uFFFD\uFFFD
        if ("99".equals(result.get("state"))) {
            //删除主表及其子表，步\uFFFD\uFFFD 附件\uFFFD\uFFFD
            String sql = "select ppid from tb_qlgk_powerprocess where ppid = '" +
                result.get("ppid") + "'";

            //记录日志
            DataLog.logDataOperate(dImpl, (String) result.get("ppid"),
                                   "powerprocess",
                                   "22");

            return;
        }

        //是否加密,可以公开不加密，不可以公\uFFFD\uFFFD则加\uFFFD\uFFFD
        boolean needEncrypt = !this.checkPublic(String.valueOf(result.get(
            "pscode")), dImpl);

        if (needEncrypt) {
            //如果\uFFFD\uFFFD要加密则加密相关字段
            this.encrypt(result);

            //在hashtable中设置\uFFFD\uFFFD\uFFFD，以便后面的程序确定是否需要创建索\uFFFD\uFFFD
            result.put("_NEEDINDEX", "NO");
        }

        if (result == null) {
            System.out.println("没有处理过程");
            return;
        }
        String sql = "select ppid from tb_qlgk_powerprocess where ppid = '" +
            result.get("ppid") + "'";
        dImpl.setTableName("tb_qlgk_powerprocess");
        dImpl.setPrimaryFieldName("ppid");
        dImpl.setPrimaryKeyType(CDataImpl.LONG);
        Hashtable ht = dImpl.getDataInfo(sql);
        if (ht == null || ht.size() == 0) {
            dImpl.addNew();
            //主键ID
            dImpl.setValue("ppid", result.get("ppid"), CDataImpl.LONG);
            dImpl.update();
            DataLog.logDataOperate(dImpl, (String) result.get("ppid"),
                                   "powerprocess",
                                   "20");
        }
        else {
            DataLog.logDataOperate(dImpl, (String) result.get("ppid"),
                                   "powerprocess",
                                   "21");
        }
        dImpl.edit(Long.parseLong(result.get("ppid").toString()));

        //外健关联，与子标准的关联 新增2008-02-28
        dImpl.setValue("SubPowerStd_ID", result.get("subpowerstd_id"),
                       CDataImpl.LONG);

        //事项ID(业务系统中原始ID,以后可作为参数链接到系统\uFFFD\uFFFD)
        dImpl.setValue("id", result.get("id"), CDataImpl.STRING);
        //事项编号
        dImpl.setValue("code", result.get("code"), CDataImpl.STRING);
        //单位ID
        dImpl.setValue("unitid", result.get("unitid"), CDataImpl.LONG);
        //单位Code
        dImpl.setValue("unitcode", result.get("unitcode"), CDataImpl.STRING);
        //单位名称
        dImpl.setValue("unitname", result.get("unitname"), CDataImpl.STRING);
        //权力编号
        dImpl.setValue("pscode", result.get("pscode"), CDataImpl.STRING);
        //\uFFFD\uFFFD始日\uFFFD\uFFFD
        if (result.get("begindate") != null &&
            !result.get("begindate").equals(""))
            dImpl.setValue("begindate", result.get("begindate"), CDataImpl.DATE);
            //结束日期
        if (result.get("enddate") != null && !result.get("enddate").equals(""))
            dImpl.setValue("enddate", result.get("enddate"), CDataImpl.DATE);
            //创建人ID
        dImpl.setValue("createuserid", result.get("createuserid"),
                       CDataImpl.STRING);
        //状\uFFFD\uFFFD\uFFFD
        dImpl.setValue("state", result.get("state"), CDataImpl.STRING);
        //创建人姓\uFFFD\uFFFD
        dImpl.setValue("createusername", result.get("createusername"),
                       CDataImpl.STRING);
        //上传日期
        if (result.get("uploaddate") != null &&
            !result.get("uploaddate").equals(""))
            dImpl.setValue("uploaddate", result.get("uploaddate"),
                           CDataImpl.DATE);
            //申请\uFFFD\uFFFD(市民)
        dImpl.setValue("residentname", result.get("residentname"),
                       CDataImpl.STRING);
        //申请\uFFFD\uFFFD(企业)
        dImpl.setValue("companyname", result.get("companyname"),
                       CDataImpl.STRING);
        //自定\uFFFD\uFFFD
        dImpl.setValue("memo", result.get("memo"), CDataImpl.STRING);
        //实际处理时限
        if (result.get("duetime") != null &&
            !result.get("duetime").toString().trim().equals(""))
            dImpl.setValue("duetime", result.get("duetime"), CDataImpl.LONG);
            //实际处理权限
        if (result.get("pslimit") != null &&
            !result.get("pslimit").toString().trim().equals(""))
            dImpl.setValue("pslimit", result.get("pslimit"), CDataImpl.FLOAT);
            //是否结束
        if (result.get("isfinished") != null &&
            parseTOF.get(result.get("isfinished")) != null) {
            dImpl.setValue("isfinished", parseTOF.get(result.get("isfinished")),
                           CDataImpl.LONG);
        }
        //是否超过时限
        dImpl.setValue("isoutofduetimelimit", result.get("isoutofduetimelimit"),
                       CDataImpl.LONG);
        //是否公开(只有标示\uFFFD\uFFFD1或\uFFFD\uFFFD\uFFFD该运行过程\uFFFD\uFFFD对应的事项是可公\uFFFD\uFFFD时该运行过程数据才可以显\uFFFD\uFFFD)
        if (result.get("isopen") != null && parseTOF.get(result.get("isopen")) != null) {
            dImpl.setValue("isopen", parseTOF.get(result.get("isopen")),
                           CDataImpl.LONG);
        }
        //是否超过权限
        if (result.get("isoutofpslimit") != null &&
            parseTOF.get(result.get("isoutofpslimit")) != null) {
            dImpl.setValue("isoutofpslimit",
                           parseTOF.get(result.get("isoutofpslimit")),
                           CDataImpl.LONG);
        }
        //特殊说明
        dImpl.setValue("des", result.get("des"), CDataImpl.STRING);
        dImpl.update();
        dImpl.edit(Long.parseLong(result.get("ppid").toString()));
        //监管说明
        dImpl.setValue("supervisedes", result.get("supervisedes"),
                       CDataImpl.STRING);
        dImpl.update();
        if (! (result.get("powerprocesssteps") instanceof ArrayList)) {
            return;
        }
        List stepfiles = (List) result.get("powerprocesssteps");
        if (stepfiles == null || stepfiles.size() == 0)
            return;
        //持久化权力运行过程步骤数\uFFFD\uFFFD
        presistentPowerProcessSteps(stepfiles, dImpl,
                                    result.get("ppid").toString());
    }

    /**
     * 持久化权力运行过程步骤数\uFFFD\uFFFD
     * @param list 步骤集合
     * @param dImpl
     * @param ppid 过程编号
     * @throws Exception
     */
    private void presistentPowerProcessSteps(List list, CDataImpl dImpl,
                                             String ppid) throws Exception {
//        String sql = "delete from tb_qlgk_powerprocessstep where ppid = " +
//            ppid;
//        dImpl.executeUpdate(sql);
        for (int i = 0; i < list.size(); i++) {
            Map result = (Map) list.get(i);
            //删除当前的步骤
            String sql = "delete from tb_qlgk_powerprocessstep where ppsid = " +
                result.get("ppsid");
            dImpl.executeUpdate(sql);


            dImpl.setTableName("tb_qlgk_powerprocessstep");
            dImpl.setPrimaryFieldName("ppsid");
            dImpl.setPrimaryKeyType(CDataImpl.LONG);

            //if (dImpl.getDataInfo(sql) == null) {
            dImpl.addNew();
            //主键ID
            dImpl.setValue("ppsid", result.get("ppsid"), CDataImpl.LONG);
            //dImpl.update();
            //}
            //dImpl.edit(Long.parseLong(result.get("ppsid").toString()));
            //运行过程ID
            dImpl.setValue("ppid", ppid, CDataImpl.LONG);
            //原始ID
            dImpl.setValue("id", result.get("id"), CDataImpl.LONG);
            //指向权利事项步骤主键ID
            dImpl.setValue("psstepid", result.get("psstepid"), CDataImpl.LONG);
            //步骤名称
            dImpl.setValue("name", result.get("name"), CDataImpl.STRING);
            //\uFFFD\uFFFD始日\uFFFD\uFFFD
            if (result.get("begindate") != null &&
                !result.get("begindate").equals(""))
                dImpl.setValue("begindate", result.get("begindate"),
                               CDataImpl.DATE);
                //结束日期
            if (result.get("enddate") != null &&
                !result.get("enddate").equals(""))
                dImpl.setValue("enddate", result.get("enddate"), CDataImpl.DATE);
                //顺序
            dImpl.setValue("sequence", result.get("sequence"), CDataImpl.STRING);
            //实际时限
            if (result.get("duetime") != null &&
                !result.get("duetime").toString().trim().equals(""))
                dImpl.setValue("duetime", result.get("duetime"), CDataImpl.LONG);
                //实际权限
            if (result.get("pslimit") != null &&
                !result.get("pslimit").toString().trim().equals(""))
                dImpl.setValue("pslimit", result.get("pslimit"),
                               CDataImpl.FLOAT);
                //角色名称,可以是多个角\uFFFD\uFFFD,中间用\uFFFD\uFFFD\uFFFD号隔开
            dImpl.setValue("rolenames", result.get("rolenames"),
                           CDataImpl.STRING);
            //\uFFFD\uFFFD长办理时\uFFFD\uFFFD
            if (result.get("maxduetimelimit") != null &&
                !result.get("maxduetimelimit").equals(""))
                dImpl.setValue("maxduetimelimit", result.get("maxduetimelimit"),
                               CDataImpl.LONG);
                //\uFFFD\uFFFD大办理权\uFFFD\uFFFD
            if (result.get("maxpslimit") != null &&
                !result.get("maxpslimit").equals(""))
                dImpl.setValue("maxpslimit", result.get("maxpslimit"),
                               CDataImpl.LONG);
                //备注
            dImpl.setValue("des", result.get("des"), CDataImpl.STRING);
            //是否超过时限
            if (result.get("isoutofduetimelimit") != null &&
                parseTOF.get(result.get("isoutofduetimelimit")) != null) {
                dImpl.setValue("isoutofduetimelimit",
                               parseTOF.get(result.get("isoutofduetimelimit")),
                               CDataImpl.LONG);
            }
            //是否超过权限
            if (result.get("isoutofpslimit") != null &&
                parseTOF.get(result.get("isoutofpslimit")) != null) {
                dImpl.setValue("isoutofpslimit",
                               parseTOF.get(result.get("isoutofpslimit")),
                               CDataImpl.LONG);
            }
            //是否超出角色权利范围
            if (result.get("isoverstep") != null &&
                parseTOF.get(result.get("isoverstep")) != null) {
                dImpl.setValue("isoverstep",
                               parseTOF.get(result.get("isoverstep")),
                               CDataImpl.LONG);
            }
            //预留字段
            dImpl.setValue("memo", result.get("memo"), CDataImpl.STRING);
            //用户ID
            dImpl.setValue("userid", result.get("userid"), CDataImpl.STRING);
            //用户姓名
            dImpl.setValue("username", result.get("username"), CDataImpl.STRING);
            try {
                dImpl.update();
            }
            catch (Exception ex) {
                System.out.println("bb:[" + result.get("begindate")+"]["+result.get("enddate")+"]");
                throw ex;
            }
        }
    }
    
}
