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

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import sun.misc.BASE64Decoder;

import com.beyondbit.lucene.index.LuceneUtils;
import com.beyondbit.lucene.index.handler.imp.PowerLawCreateDocCallBackImpl;
import com.beyondbit.lucene.index.handler.imp.PowerProcessCallBackImpl;
import com.beyondbit.lucene.index.handler.imp.PowerStdCreateDocCallBackImpl;
import com.beyondbit.security.DESUtil;
import com.component.newdatabase.CDataCn;
import com.component.newdatabase.CDataImpl;
import com.util.CTools;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.*;

import javax.crypto.NoSuchPaddingException;
import java.net.URLEncoder;

/**
 * @author liuyang <br>
 * @date 2007-9-19 <br>
 * @description: 解析xml字符串 并且持久化 不适用于解析有属性的xml字符串
 * 没有实现总分标准使用的接口
 *
 */
public class ParsePowerXml {

    private static Logger logger = Logger.getLogger(ParsePowerXml.class);

    /**
     * 需要加密的字段
     */
    private List cryptFieldList = new ArrayList();

    public ParsePowerXml() {
        //初始化需要加密的字段名称
        //cryptFieldList.add("UNITCODE".toLowerCase());//单位Code
        cryptFieldList.add("UNITNAME".toLowerCase()); //单位名称
        cryptFieldList.add("CREATEUSERNAME".toLowerCase()); //创建人姓名
        cryptFieldList.add("COMPANYNAME".toLowerCase()); //申请人(企业)
        cryptFieldList.add("RESIDENTNAME".toLowerCase()); //申请人(市民)
        cryptFieldList.add("MEMO".toLowerCase()); //自定义
        cryptFieldList.add("DES".toLowerCase()); //特殊说明
        cryptFieldList.add("SUPERVISEDES".toLowerCase()); //监管说明

    }

    /**
     * webservice公开方法，持久化权力规范xml，供AXIS调用
     * @param xml 由.Net后台传过来的xml字符串
     * @return
     */
    public String presistentDataByXml(String xml) {
        exportToFile(xml);
//           if(1==1) return "<?xml version=\"1.0\" encoding=\"UTF-8\"?><string>success</string>";
        try {
            logger.info("权利事项XML：" + xml);
            Hashtable result = (Hashtable) parse(xml);
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
     * @param xml 由.Net后台传过来的xml字符串
     * @return
     */
    public String presistentPowerProcessDataByXml(String xml) {

//         exportToFile(xml);
//        if(1==1) return "<?xml version=\"1.0\" encoding=\"UTF-8\"?><string>success</string>";
        try {
            logger.info("权利运行XML：" + xml);
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

    //定义了sqlsever布尔型到Oracle数字型转换标准
    private Hashtable parseTOF = new Hashtable();
    {
        parseTOF.put("True", "1");
        parseTOF.put("False", "0");
    }

    private String parseNumberToStr(String str) {
        BigDecimal big = new BigDecimal(str);
        return "" + big.longValue();
    }

    //将xml中传过来的二进制字符串进行BASE64解码（.Net端使用BASE64编码）
    private byte[] decode(String input) throws Exception {
        BASE64Decoder decoder = new BASE64Decoder();
        if (input != null && !input.equals(""))
            return decoder.decodeBuffer(input);
        else
            return new byte[0];
    }

    /**
     * 解析xml字符串入口
     * @param xml xml字符串
     * @return 把所有的值封装到hashtable中
     * @throws Exception
     */
    private Object parse(String xml) throws Exception {
        Document powerDoc = DocumentHelper.parseText(xml);
        Element root = powerDoc.getRootElement();
        Iterator iter = root.elementIterator();
        Hashtable result = new Hashtable();
        Element powerstd = (Element) iter.next();
        parseElement(powerstd, result);
        return result;
    }

    /**
     * 解析xml字符串入口
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
     * @param element 需要解析的元素
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
    private String presistent(Hashtable result) throws Exception {
        CDataCn dCn = null;
        CDataImpl dImpl = null;
        String resultstr = "success";
        try {
            dCn = new CDataCn();
            dImpl = new CDataImpl(dCn);
            dCn.beginTrans();

            //持久化权力规范，包括持久化当前事项包含的权力依据
            presistentPowerStd(result, dImpl);

            //持久化权力规范步骤
            presistentPowerStdSteps(result, dImpl);
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
                logger.error("持久化权力规范xml权力事项中CDataCn执行报错：" +
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
        //这里在对象持久化完毕之后调用索引创建，可以避免索引创建占用数据库链接，而且确保对象持久化成功后再创建索引
        if ("success".equals(resultstr)) {
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
        return resultstr;
    }

    /**
     * 持久化权力过程数据
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
                throw new Exception("传入的xml格式 解析不成功");
            }
            dCn.beginTrans();
            Iterator iter = result.iterator();

            // 持久化权力过程
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
                logger.error("持久化权力规范xml权力过程中CDataCn执行报错：" +
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
        //这里在对象持久化完毕之后调用索引创建，可以避免索引创建占用数据库链接，而且确保对象持久化成功后再创建索引
        if ("success".equals(resultstr)) {
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
        return resultstr;
    }

    /**
     * 根据解析xml出来持久化或者更新权力事项及权力依据
     * @param result
     * @param dImpl
     * @throws IOException
     * @throws Exception
     */
    private void presistentPowerStd(Hashtable result, CDataImpl dImpl) throws
        Exception {
        String sql = "select psid from tb_qlgk_powerstd where psid = " +
            result.get("psid");
        dImpl.setTableName("tb_qlgk_powerstd");
        dImpl.setPrimaryFieldName("psid");
        dImpl.setPrimaryKeyType(CDataImpl.LONG);

        // 首先判断传过来的记录是否存在 存在就修改 不存在就新增
        Hashtable ht1 = dImpl.getDataInfo(sql);
        if (ht1 == null || ht1.size() == 0) {
            dImpl.addNew();
            dImpl.setValue("psid", result.get("psid"), CDataImpl.LONG); //权力标准主键ID
        }
        else {
            dImpl.edit(Long.parseLong(result.get("psid").toString())); //权力标准主键ID
        }
        //标准分类ID
        dImpl.setValue("cateid", result.get("cateid"), CDataImpl.LONG);
        //权力标准编号
        dImpl.setValue("pscode", result.get("pscode"), CDataImpl.STRING);
        //权力标准名称
        dImpl.setValue("psname", result.get("psname"), CDataImpl.STRING);
        //权力标准审批状态(当该值大于1时该权力事项才可以公开)
        if (result.get("state") != null &&
            !result.get("state").toString().trim().equals(""))
            dImpl.setValue("state", result.get("state"), CDataImpl.STRING);
            //生效日期
        if (result.get("validdate") != null &&
            !result.get("validdate").toString().trim().equals(""))
            dImpl.setValue("validdate", result.get("validdate"), CDataImpl.DATE);
            //失效日期(当超过失效日期时需要有提示)
        if (result.get("invaliddate") != null &&
            !result.get("invaliddate").toString().trim().equals(""))
            dImpl.setValue("invaliddate", result.get("invaliddate"),
                           CDataImpl.DATE);
            //是否归属市民中心(如果是则需要在界面上显示直接跳转到市民中心的快捷键)
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
            //职权主体代号
        dImpl.setValue("aunitcode", result.get("aunitcode"), CDataImpl.STRING);
        //职权主体名称
        dImpl.setValue("aunitname", result.get("aunitname"), CDataImpl.STRING);
        //责任人ID
        dImpl.setValue("auserid", result.get("auserid"), CDataImpl.STRING);
        //责任人姓名
        dImpl.setValue("ausername", result.get("ausername"), CDataImpl.STRING);
        //增加前置环节和后置环节
        dImpl.setValue("txtbefore",result.get("txtbefore"),CDataImpl.STRING);
        dImpl.setValue("txtafter",result.get("txtafter"),CDataImpl.STRING);


        //责任人职务
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
        //承办人姓名
        dImpl.setValue("busername", result.get("busername"), CDataImpl.STRING);
        //承办人职务
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

        //示意图(大)文件名
        dImpl.setValue("diagrampiclname", result.get("diagrampiclname"),
                       CDataImpl.STRING);
        //示意图(大)类型(可直接用于设置response.setContentType)
        dImpl.setValue("diagrampicltype", result.get("diagrampicltype"),
                       CDataImpl.STRING);
        //示意图(小)文件名
        dImpl.setValue("diagrampicsname", result.get("diagrampicsname"),
                       CDataImpl.STRING);
        //示意图(小)类型(可直接用于设置response.setContentType)
        dImpl.setValue("diagrampicstype", result.get("diagrampicstype"),
                       CDataImpl.STRING);
        //权利标准名称
        dImpl.setValue("lawname", result.get("lawbasisname"), CDataImpl.STRING);
        //权力标准的权限(如金额、土地面积等)
        if (result.get("pslimit") != null && !result.get("pslimit").equals(""))
            dImpl.setValue("pslimit",
                           parseNumberToStr(result.get("pslimit").toString()),
                           CDataImpl.FLOAT);

            //权力标准的权限单位(如万元，亩等)
        dImpl.setValue("pslimitunit", result.get("pslimitunit"),
                       CDataImpl.STRING);
        //权力标准的时限
        dImpl.setValue("duetimelimit", result.get("duetimelimit"),
                       CDataImpl.LONG);
        //权力标准公开范围(当值为2，即公开范围为“公众时才可以显示”)
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
        //申请人姓名
        dImpl.setValue("createusername", result.get("createusername"),
                       CDataImpl.STRING);
        //审核日期
        if (result.get("checkdate") != null &&
            !result.get("checkdate").toString().trim().equals(""))
            dImpl.setValue("checkdate", result.get("checkdate"), CDataImpl.DATE);
            //审核人ID
        dImpl.setValue("checkuserid", result.get("checkuserid"),
                       CDataImpl.STRING);
        //审核人姓名
        dImpl.setValue("checkusername", result.get("checkusername"),
                       CDataImpl.STRING);
        dImpl.update();
        dImpl.edit(Long.parseLong(result.get("psid").toString()));
        //示意图(大)二进制数据
        dImpl.setBlobValue("diagrampicldata",
                           decode(CTools.dealNull(result.get("diagrampicldata"))));
        //示意图(小)二进制数据
        dImpl.setBlobValue("diagrampicsdata",
                           decode(CTools.dealNull(result.get("diagrampicsdata"))));
        // 增加法律依据，首先判断是否有法律依据
        if (result.get("lawbasisname") != null &&
            !result.get("lawbasisname").equals("")) {
        	//这里判断



            sql = "select lawname from tb_qlgk_law where lawname = '" +
                result.get("lawbasisname") + "'";
            dImpl.setTableName("tb_qlgk_law");
            dImpl.setPrimaryFieldName("lawname");
            dImpl.setPrimaryKeyType(CDataImpl.STRING);
            //判断该依据是否存在
            Hashtable ht2 = dImpl.getDataInfo(sql);
            if (ht2 == null || ht2.size() == 0) {
                dImpl.addNew();
                //权利依据名称
                dImpl.setValue("lawname", result.get("lawbasisname"),
                               CDataImpl.STRING);
                dImpl.update();
            }
            dImpl.edit(result.get("lawbasisname").toString());


            //法律依据内容已内嵌XML的形式存储，需要二次解析
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

            //此处为了防止过久占用数据库链接而将权利依据的全文索引放到数据库操作之外进行
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

    /**
     * 获取执行子元素内容
     * @param e
     * @param subElementName子元素名称
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
     * 持久化权力规范步骤
     * @param results 解析xml产生的HashTable集合
     * @param dImpl 数据操作对象
     * @throws Exception
     * @throws Exception
     */
    private void presistentPowerStdSteps(Hashtable results, CDataImpl dImpl) throws
        Exception {
        if (! (results.get("powerstdsteps") instanceof ArrayList)) {
            return;
        }
        List steps = (List) results.get("powerstdsteps");
        String psid = results.get("psid").toString();
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
            // 首先判断传过来的记录是否存在 存在就修改 不存在就新增
            Hashtable ht = dImpl.getDataInfo(sql);
            if (ht == null || ht.size() == 0) {
                dImpl.addNew();
                //步骤主键ID
                dImpl.setValue("stepid", result.get("stepid"), CDataImpl.LONG);
            }
            else {
                dImpl.edit(Long.parseLong(result.get("stepid").toString()));
            }
            //步骤名称
            dImpl.setValue("stepname", result.get("stepname"), CDataImpl.STRING);
            //对应的权力标准ID
            dImpl.setValue("psid", psid, CDataImpl.LONG);
            //角色名称
            dImpl.setValue("rolename", result.get("rolename"), CDataImpl.STRING);
            //上一步ID(仅供显示参考，并不起到标示顺序的作用)
            dImpl.setValue("prevstepid", result.get("prevstepid"),
                           CDataImpl.STRING);
            //下一步ID(仅供显示参考，并不起到标示顺序的作用)
            dImpl.setValue("nextstepid", result.get("nextstepid"),
                           CDataImpl.STRING);
            //是否是关键步骤(如果值为1则在显示时在步骤名称上做标示)
            if (result.get("iskey") != null && parseTOF.get(result.get("iskey")) != null) {
                dImpl.setValue("iskey", parseTOF.get(result.get("iskey")),
                               CDataImpl.LONG);
            }
            //是否是内部步骤，如果是(值为1)则不能向公众展示
            if (result.get("isinner") != null &&
                parseTOF.get(result.get("isinner")) != null) {
                dImpl.setValue("isinner", parseTOF.get(result.get("isinner")),
                               CDataImpl.LONG);
            }
            //最长权力标准的时限
            if (result.get("maxduetimelimit") != null &&
                !result.get("maxduetimelimit").equals("")) {
                dImpl.setValue("maxduetimelimit",
                               parseNumberToStr(result.get("maxduetimelimit").
                                                toString()),
                               CDataImpl.LONG);
            }
            //最大权力标准的时限
            if (result.get("maxpslimit") != null &&
                !result.get("maxpslimit").equals("")) {
                dImpl.setValue("maxpslimit",
                               parseNumberToStr(result.get("maxpslimit").
                                                toString()),
                               CDataImpl.LONG);
            }
            //分组名
            dImpl.setValue("groupname", result.get("groupname"),
                           CDataImpl.STRING);
            //音频说明文件文件名
            dImpl.setValue("audiodesname", result.get("audiodesname"),
                           CDataImpl.STRING);
            //音频说明文件类型
            dImpl.setValue("audiodestype", result.get("audiodestype"),
                           CDataImpl.STRING);
            //备注
            dImpl.setValue("des", result.get("des"), CDataImpl.STRING);
            dImpl.update();
            dImpl.edit(Long.parseLong(result.get("stepid").toString()));
            //音频说明文件数据
            dImpl.setBlobValue("audiodesdata",
                               decode(CTools.dealNull(result.get("audiodesdata"))));

            // 获取步骤所需文件 持久化
            if (! (result.get("stepfiles") instanceof ArrayList)) {
                continue;
            }
            List stepfiles = (List) result.get("stepfiles");
            //持久化事项附件
            presistentPSFiles(stepfiles, dImpl, result.get("stepid").toString());
        }
    }

    /**
     * 持久化权力规范的步骤文件
     * @param list 步骤文件列表
     * @param dImpl 数据库操作对象
     * @throws IOException
     * @throws Exception
     */
    private void presistentPSFiles(List list, CDataImpl dImpl, String sid) throws
        Exception, IOException {
        if (list == null || list.size() == 0) {
            return;
        }
        for (int i = 0; i < list.size(); i++) {
            Hashtable result = (Hashtable) list.get(i);
            // 先判断是否存在

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
            //附件文档文件名
            dImpl.setValue("edocname", result.get("edocname"), CDataImpl.STRING);
            //附件文档文件类型(如doc、rtf等)
            dImpl.setValue("edoctype", result.get("edoctype"), CDataImpl.STRING);
            //附件示意图文件名
            dImpl.setValue("diagrampicname", result.get("diagrampicname"),
                           CDataImpl.STRING);
            //附件示意图文类型(如gif、jpg等)
            dImpl.setValue("diagrampictype", result.get("diagrampictype"),
                           CDataImpl.STRING);
            //备注
            dImpl.setValue("des", result.get("des"), CDataImpl.STRING);
            dImpl.update();
            dImpl.edit(Long.parseLong(result.get("fileid").toString()));
            //附件文档数据
            dImpl.setBlobValue("edocdata",
                               decode(CTools.dealNull(result.get("edocdata"))));
            //附件示意图数据
            dImpl.setBlobValue("diagrampicdata",
                               decode(CTools.dealNull(result.get(
                "diagrampicdata"))));
            sql = "delete from tb_qlgk_stepfiles where sid = " + sid;
            dImpl.executeUpdate(sql);
            // 持久化步骤文件映射对象
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
     * 检查是否可以公开
     * @param ppid 权力运行id
     * @return 是否可以公开 true是可以公开 false 是不可以公开
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
     * @param data map型数据
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
        //循环map的健值
        Iterator it = data.keySet().iterator();
        while (it.hasNext()) {
            //获得健值
            key = it.next();
            //如果该健内容需要加密
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
     * 持久化权力运行过程文件
     * @param result PowerProcess过程
     * @param dImpl 数据库操作对象
     * @throws IOException
     * @throws Exception
     */
    private void presistentPowerProcess(Hashtable result, CDataImpl dImpl) throws
        Exception {
        //是否加密,可以公开不加密，不可以公开则加密
		boolean needEncrypt = !this.checkPublic(String.valueOf(result.get("pscode")), dImpl);

    if (needEncrypt) {
			//如果需要加密则加密相关字段
			this.encrypt(result);

			//在hashtable中设置值，以便后面的程序确定是否需要创建索引
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
        }
        dImpl.edit(Long.parseLong(result.get("ppid").toString()));
        //事项ID(业务系统中原始ID,以后可作为参数链接到系统中)
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
        //开始日期
        if (result.get("begindate") != null &&
            !result.get("begindate").equals(""))
            dImpl.setValue("begindate", result.get("begindate"), CDataImpl.DATE);
            //结束日期
        if (result.get("enddate") != null && !result.get("enddate").equals(""))
            dImpl.setValue("enddate", result.get("enddate"), CDataImpl.DATE);
            //创建人ID
        dImpl.setValue("createuserid", result.get("createuserid"),
                       CDataImpl.STRING);
        //状态
        dImpl.setValue("state", result.get("state"), CDataImpl.STRING);
        //创建人姓名
        dImpl.setValue("createusername", result.get("createusername"),
                       CDataImpl.STRING);
        //上传日期
        if (result.get("uploaddate") != null &&
            !result.get("uploaddate").equals(""))
            dImpl.setValue("uploaddate", result.get("uploaddate"),
                           CDataImpl.DATE);
            //申请人(市民)
        dImpl.setValue("residentname", result.get("residentname"),
                       CDataImpl.STRING);
        //申请人(企业)
        dImpl.setValue("companyname", result.get("companyname"),
                       CDataImpl.STRING);
        //自定义
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
        //是否公开(只有标示为1或者该运行过程所对应的事项是可公开时该运行过程数据才可以显示)
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
        //持久化权力运行过程步骤数据
        presistentPowerProcessSteps(stepfiles, dImpl,
                                    result.get("ppid").toString());
    }

    /**
     * 持久化权力运行过程步骤数据
     * @param list 步骤集合
     * @param dImpl
     * @param ppid 过程编号
     * @throws Exception
     */
    private void presistentPowerProcessSteps(List list, CDataImpl dImpl,
                                             String ppid) throws Exception {
        String sql = "delete from tb_qlgk_powerprocessstep where ppid = " +
            ppid;
        dImpl.executeUpdate(sql);
        for (int i = 0; i < list.size(); i++) {
            Hashtable result = (Hashtable) list.get(i);
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
            //开始日期
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
                dImpl.setValue("pslimit", result.get("pslimit"), CDataImpl.FLOAT);
                //角色名称,可以是多个角色,中间用逗号隔开
            dImpl.setValue("rolenames", result.get("rolenames"),
                           CDataImpl.STRING);
            //最长办理时限
            if (result.get("maxduetimelimit") != null &&
                !result.get("maxduetimelimit").equals(""))
                dImpl.setValue("maxduetimelimit", result.get("maxduetimelimit"),
                               CDataImpl.LONG);
                //最大办理权限
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
            dImpl.update();
        }
    }
}
