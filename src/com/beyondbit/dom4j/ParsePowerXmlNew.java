package com.beyondbit.dom4j;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.crypto.NoSuchPaddingException;

import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import sun.misc.BASE64Decoder;

import com.beyondbit.log.DataLog;
import com.beyondbit.lucene.index.LuceneControl;
import com.beyondbit.lucene.index.support.job.IndexPowerLawJob;
import com.beyondbit.lucene.index.support.job.IndexPowerProcessJob;
import com.beyondbit.lucene.index.support.job.IndexPowerStdJob;
import com.beyondbit.security.DESUtil;
import com.component.newdatabase.CDataCn;
import com.component.newdatabase.CDataImpl;
import com.util.CTools;


/**
 * @author zhanglun <br>
 * @date 2009-2-18 <br>
 * @description: 解析xml文件 并且持久化到数据库
 * 解析xml，获得权力事项以后，根据里面承办单位的数目来创建相应的承办单位
 * 再根据每个承办单位里的步骤来更新相应的步骤
 * 实现了总分标准后使用的接口
 *
 */
public class ParsePowerXmlNew {
	private static Logger logger = Logger.getLogger(ParsePowerXmlNew.class);
	
	/**
     * 要加密的字段
     */
    private List cryptFieldList = new ArrayList();
    
    public ParsePowerXmlNew(){
    	 try {
             LuceneControl.class.forName("java.lang.String");
         }
         catch (ClassNotFoundException ex) {
         }
         //初始化需要加密的字段名称
         //cryptFieldList.add("UNITCODE".toLowerCase());//单位Code
         cryptFieldList.add("UNITNAME".toLowerCase()); //单位名称
         cryptFieldList.add("CREATEUSERNAME".toLowerCase()); //创建人姓名
         cryptFieldList.add("COMPANYNAME".toLowerCase()); //申请人(企业)
         cryptFieldList.add("RESIDENTNAME".toLowerCase()); //申请人(市民)
         cryptFieldList.add("MEMO".toLowerCase()); //自定
         cryptFieldList.add("DES".toLowerCase()); //特殊说明
         cryptFieldList.add("SUPERVISEDES".toLowerCase()); //监管说明
    }
    
    /**
     * webservice公开方法，持久化权力规范xml，供AXIS调用
     * @param xml .Net后台传过来的符合xml标准的字符集
     * @return
     */
    public String presistentDataByXml(String xml) {
        try {
            logger.info("权利事项XML名称" + xml);
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
    
    /**
     * 
     * 
     */
    static void exportToFile(String xml) {
        try {
            String fileName = "c:\\qlgklogs\\" + System.currentTimeMillis() + ".xml";
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
     * @param xml .Net后台传过来的xml字符文件
     * @return
     */
    public String presistentPowerProcessDataByXml(String xml) {
        try {
            logger.info("权利运行XML名称" + xml);
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
    
    //定义了sqlsever布尔型到Oracle数字型转换标识
    private Hashtable parseTOF = new Hashtable();
    {
        parseTOF.put("True", "1");
        parseTOF.put("False", "0");
    }
    
    //精确计算的转换
    private String parseNumberToStr(String str) {
        BigDecimal big = new BigDecimal(str);
        return "" + big.longValue();
    }
    
    //将xml中传过来的二进制字符串进行BASE64解码，.Net端使用BASE64编码
    private byte[] decode(String input) throws Exception {
        BASE64Decoder decoder = new BASE64Decoder();
        if (input != null && !input.equals(""))
            return decoder.decodeBuffer(input);
        else
            return new byte[0];
    }
    
    /**
     * 解析xml字符串并将其封装到hashtable中
     * @param xml xml字符串
     * @return 把所有的值封装到hashtable中
     * @throws Exception
     */
    private Object parse(String xml) throws Exception {
        Document powerDoc = DocumentHelper.parseText(xml);
        Element root = powerDoc.getRootElement();
        //Iterator iter = root.elementIterator();
        List list = new ArrayList();
        parsesubElement(root, list);
        return list;
    }
    
    /**
     * 解析xml字符串并将其封装到doc对象的list中
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
     * @param element 要解析的元素
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
     * @param element 文档元素
     * @param list 要存放的list对象
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
            // 持久化权力过程
            if (result == null) {
                throw new Exception("传入的xml格式 解析不成功");
            }
            
            Iterator iter = result.iterator();
            while (iter.hasNext()) {
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
                logger.error("持久化权力规范xml权力事项中CDataCn执行报错:" +
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
        //这里在对象持久化完毕之后调用索引创建，可以避免索引创建占用数据库链接，且确保对象持久化成功后再创建索引
      if ("success".equals(resultstr)) {
        	IndexPowerStdJob a =null;
        	IndexPowerLawJob b=null;
        	a = new IndexPowerStdJob(result);
        	b=new IndexPowerLawJob(result);
            LuceneControl.addJob(a);
            LuceneControl.addJob(b);
      }
        return resultstr;
    }
    
    /**
     * 持久化权力过程数据
     * @param result 需要持久化list
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
                logger.error("持久化权力规范xml权力过程中CDataCn执行报错：" + dCn.getLastErrString());
            }
            try {
                if (dImpl != null) {
                    dImpl.closeStmt();
                }
            }catch (Exception ex1) {
            }
            try {
                if (dCn != null) {
                    dCn.closeCn();
                }
            }catch (Exception ex2) {
            }

        }
        //这里在对象持久化完毕之后调用索引创建，可以避免索引创建占用数据库链接，且确保对象持久化成功后再创建索引
        if ("success".equals(resultstr)) {
            LuceneControl.addJob(new IndexPowerProcessJob(result));
      }
        return resultstr;
    }
    
    /**
     * 根据解析xml出来持久化或者更新权力事项及权力依据 解析xml入口
     * @param result
     * @param dImpl
     * @throws IOException
     * @throws Exception
     */
    private void presistentPowerStd(Map result, CDataImpl dImpl) throws Exception {
        if ("99".equals(result.get("state"))) {
            //删除主表及其子表，步骤 附件 //删除子标表 ，删除所有步骤，删除 材料
            String sql = "delete tb_qlgk_powerstd where psid = '" + result.get("psid") + "'";//删除主表,根据数据库关联，所有子记录自动删除
            dImpl.executeUpdate(sql);

            //记录日志
            DataLog.logDataOperate(dImpl, (String) result.get("psid"), "powerstd","12");
            return;
        }

        String sql = "select psid from tb_qlgk_powerstd where psid = " + result.get("psid");
        dImpl.setTableName("tb_qlgk_powerstd");
        dImpl.setPrimaryFieldName("psid");
        dImpl.setPrimaryKeyType(CDataImpl.LONG);

        // 首先判断传过来的记录是否存在 存在就修改 不存在就新增
        Hashtable ht1 = dImpl.getDataInfo(sql);
        if (ht1 == null || ht1.size() == 0) {
            dImpl.addNew();
            dImpl.setValue("psid", result.get("psid"), CDataImpl.LONG); //权力标准主键ID
            //记录日志
           DataLog.logDataOperate(dImpl, (String) result.get("psid"),"powerstd", "10");

        }else {
            dImpl.edit(Long.parseLong(result.get("psid").toString())); //权力标准主键ID
            //记录日志
            DataLog.logDataOperate(dImpl, (String) result.get("psid"), "powerstd","11");

        }
        //标准分类ID
        if (result.get("cateid") != null && !result.get("cateid").toString().equals(""))
        	dImpl.setValue("cateid", result.get("cateid"), CDataImpl.LONG);
        //权力标准编号
        if (result.get("pscode") != null && !result.get("pscode").toString().equals(""))
        	dImpl.setValue("pscode", result.get("pscode"), CDataImpl.STRING);
        //权力标准名称
        if (result.get("psname") != null && !result.get("psname").toString().equals(""))
        	dImpl.setValue("psname", result.get("psname"), CDataImpl.STRING);
        //权力标准审批状态(当该值>1时该权力事项才可以公开)
        if (result.get("state") != null && !result.get("state").toString().equals(""))
            dImpl.setValue("state", result.get("state"), CDataImpl.STRING);
        //生效日期
        if (result.get("validdate") != null && !result.get("validdate").toString().equals(""))
            dImpl.setValue("validdate", result.get("validdate"), CDataImpl.DATE);
        //失效日期(当超过失效日期时要有提示)
        if (result.get("invaliddate") != null && !result.get("invaliddate").toString().equals(""))
            dImpl.setValue("invaliddate", result.get("invaliddate"),CDataImpl.DATE);
        //是否归属市民中心(如果是则要在界面上显示直接跳转到市民中心的快捷键)
        if (result.get("ispc") != null && parseTOF.get(result.get("ispc")) != null) {
            dImpl.setValue("ispc", parseTOF.get(result.get("ispc")),CDataImpl.LONG);
        }
        //权力标准的时限
        if (result.get("duetimelimit") != null && !result.get("duetimelimit").toString().equals(""))
        	dImpl.setValue("duetimelimit", result.get("duetimelimit"), CDataImpl.LONG);
        //权力标准的权限(如金额、土地面积等)
        if (result.get("pslimit") != null && !result.get("pslimit").equals(""))
            dImpl.setValue("pslimit", parseNumberToStr(result.get("pslimit").toString()), CDataImpl.FLOAT);
        //权力标准公开范围(当为2，即公开范围为公众时才可以显示)
        if (result.get("openscope") != null && !result.get("openscope").toString().equals(""))
            dImpl.setValue("openscope", result.get("openscope"), CDataImpl.LONG);
        //des
        if (result.get("des") != null && !result.get("des").toString().equals(""))
        	dImpl.setValue("des",result.get("des"),CDataImpl.STRING);
        //申请部门ID
        if (result.get("createunitid") != null && !result.get("createunitid").toString().equals(""))
        	dImpl.setValue("createunitid", result.get("createunitid"), CDataImpl.LONG);
        //申请日期
        if (result.get("createdate") != null && !result.get("createdate").toString().equals(""))
            dImpl.setValue("createdate", result.get("createdate"), CDataImpl.DATE);
        //申请人ID
        if (result.get("createuserid") != null && !result.get("createuserid").toString().equals(""))
        	dImpl.setValue("createuserid", result.get("createuserid"), CDataImpl.STRING);       
        //申请人姓名
        if (result.get("createusername") != null && !result.get("createusername").toString().equals(""))
        	dImpl.setValue("createusername", result.get("createusername"), CDataImpl.STRING);
        //审核机关ID
        if (result.get("checkunitid") != null && !result.get("checkunitid").toString().equals(""))
            dImpl.setValue("checkunitid", result.get("checkunitid"), CDataImpl.LONG);        
        //审核日期
        if (result.get("checkdate") != null && !result.get("checkdate").toString().equals(""))
            dImpl.setValue("checkdate", result.get("checkdate"), CDataImpl.DATE);
        //审核人ID
        if (result.get("checkuserid") != null && !result.get("checkuserid").toString().equals(""))
        	dImpl.setValue("checkuserid", result.get("checkuserid"), CDataImpl.STRING);       
        //审核人姓名
        if (result.get("checkusername") != null && !result.get("checkusername").toString().equals(""))
        	dImpl.setValue("checkusername", result.get("checkusername"), CDataImpl.STRING);  
        //权利标准名称
        if (result.get("lawbasisname") != null && !result.get("lawbasisname").toString().equals(""))
        	dImpl.setValue("lawname", result.get("lawbasisname"), CDataImpl.STRING);
        //职权主体ID
        if (result.get("aunitid") != null && !result.get("aunitid").toString().equals(""))
            dImpl.setValue("aunitid", result.get("aunitid"), CDataImpl.LONG);
        //责任人ID
        if (result.get("auserid") != null && !result.get("auserid").toString().equals(""))
        	dImpl.setValue("auserid", result.get("auserid"), CDataImpl.STRING);       
        //责任人姓名
        if (result.get("ausername") != null && !result.get("ausername").toString().equals(""))
        	dImpl.setValue("ausername", result.get("ausername"), CDataImpl.STRING);
        //责任人职务
        if (result.get("ajob") != null && !result.get("ajob").toString().equals(""))
        	dImpl.setValue("ajob", result.get("ajob"), CDataImpl.STRING);       
        //承办机构ID
        if (result.get("bunitid") != null && !result.get("bunitid").toString().equals(""))
            dImpl.setValue("bunitid", result.get("bunitid"), CDataImpl.LONG);      
        //承办人ID
        if (result.get("buserid") != null && !result.get("buserid").toString().equals(""))
        	dImpl.setValue("buserid", result.get("buserid"), CDataImpl.STRING);
        //承办人姓名
        if (result.get("busername") != null && !result.get("busername").toString().equals(""))
        	dImpl.setValue("busername", result.get("busername"), CDataImpl.STRING);      
        //承办人职务
        if (result.get("bjob") != null && !result.get("bjob").toString().equals(""))
        	dImpl.setValue("bjob", result.get("bjob"), CDataImpl.STRING);      
        //前置步骤
        if (result.get("prevstep") != null && !result.get("prevstep").toString().equals(""))
        	dImpl.setValue("prevstep",result.get("prevstep"),CDataImpl.STRING);
        //后置步骤
        if (result.get("nextstep") != null && !result.get("nextstep").toString().equals(""))
        	dImpl.setValue("nextstep",result.get("nextstep"),CDataImpl.STRING);
        //行为领域ID
        if (result.get("attr1id") != null && !result.get("attr1id").toString().equals(""))
            dImpl.setValue("attr1id", result.get("attr1id"), CDataImpl.LONG);
        //行为领域名称，对应属性表
        if (result.get("attr1name") != null && !result.get("attr1name").toString().equals(""))
        	dImpl.setValue("attr1name", result.get("attr1name"), CDataImpl.STRING);
        //预留字段
        if (result.get("attr2id") != null && !result.get("attr2id").toString().equals(""))
            dImpl.setValue("attr2id", result.get("attr2id"), CDataImpl.LONG);
        //预留字段
        if (result.get("attr2name") != null && !result.get("attr2name").toString().equals(""))
        	dImpl.setValue("attr2name", result.get("attr2name"), CDataImpl.STRING);
        //预留字段
        if (result.get("attr3id") != null && !result.get("attr3id").toString().equals(""))
            dImpl.setValue("attr3id", result.get("attr13d"), CDataImpl.LONG);
        //预留字段
        if (result.get("attr3name") != null && !result.get("attr3name").toString().equals(""))
        	dImpl.setValue("attr3name", result.get("attr3name"), CDataImpl.STRING);
        //预留字段
        if (result.get("attr4id") != null && !result.get("attr4id").toString().equals(""))
            dImpl.setValue("attr4id", result.get("attr4id"), CDataImpl.LONG);
        //预留字段
        if (result.get("attr4name") != null && !result.get("attr4name").toString().equals(""))
        	dImpl.setValue("attr4name", result.get("attr4name"), CDataImpl.STRING);
        //预留字段
        if (result.get("attr5id") != null && !result.get("attr5id").toString().equals(""))
            dImpl.setValue("attr5id", result.get("attr5id"), CDataImpl.LONG);
        //预留字段
        if (result.get("attr5name") != null && !result.get("attr5name").toString().equals(""))
        	dImpl.setValue("attr5name", result.get("attr5name"), CDataImpl.STRING);
        //申请部门名称
        if (result.get("createunitname") != null && !result.get("createunitname").toString().equals(""))
        	dImpl.setValue("createunitname", result.get("createunitname"), CDataImpl.STRING);
        //审核机关名称
        if (result.get("checkunitname") != null && !result.get("checkunitname").toString().equals(""))
        	dImpl.setValue("checkunitname", result.get("checkunitname"), CDataImpl.STRING);
        //职权主体名称
        if (result.get("aunitname") != null && !result.get("aunitname").toString().equals(""))
        	dImpl.setValue("aunitname", result.get("aunitname"), CDataImpl.STRING);
        //承办机构名称
        if (result.get("bunitname") != null && !result.get("bunitname").toString().equals(""))
        	dImpl.setValue("bunitname", result.get("bunitname"), CDataImpl.STRING);
        /**
         * xml文件中没有相对应的元素
        //applydate
        if (result.get("applydate") != null && !result.get("applydate").toString().trim().equals(""))
            dImpl.setValue("applydate", result.get("applydate"), CDataImpl.DATE);       
        */
        //申请部门代号
        if (result.get("createunitcode") != null && !result.get("createunitcode").toString().equals(""))
        	dImpl.setValue("createunitcode", result.get("createunitcode"), CDataImpl.STRING);
        //审核机关代号
        if (result.get("checkunitcode") != null && !result.get("checkunitcode").toString().equals(""))
        	dImpl.setValue("checkunitcode", result.get("checkunitcode"), CDataImpl.STRING);
        //职权主体代号
        if (result.get("aunitcode") != null && !result.get("aunitcode").toString().equals(""))
        	dImpl.setValue("aunitcode", result.get("aunitcode"), CDataImpl.STRING);
        //承办机构代号
        if (result.get("bunitcode") != null && !result.get("bunitcode").toString().equals(""))
        	dImpl.setValue("bunitcode", result.get("bunitcode"), CDataImpl.STRING);
        //示意图(大)文件名
        if (result.get("diagrampiclname") != null && !result.get("diagrampiclname").toString().equals(""))
        	dImpl.setValue("diagrampiclname", result.get("diagrampiclname"), CDataImpl.STRING);
        //示意图(大)类型(可直接用于设置response.setContentType)
        if (result.get("diagrampicltype") != null && !result.get("diagrampicltype").toString().equals(""))
        	dImpl.setValue("diagrampicltype", result.get("diagrampicltype"), CDataImpl.STRING);
        //示意图(小)文件名
        if (result.get("diagrampicsname") != null && !result.get("diagrampicsname").toString().equals(""))
        	dImpl.setValue("diagrampicsname", result.get("diagrampicsname"), CDataImpl.STRING);
        //示意图(小)类型(可直接用于设置response.setContentType)
        if (result.get("diagrampicstype") != null && !result.get("diagrampicstype").toString().equals(""))
        	dImpl.setValue("diagrampicstype", result.get("diagrampicstype"), CDataImpl.STRING);
        //权力标准的权限单位(如万元，亩等)
        if (result.get("pslimitunit") != null && !result.get("pslimitunit").toString().equals(""))
        	dImpl.setValue("pslimitunit", result.get("pslimitunit"), CDataImpl.STRING);
        /**
        //CONSUMER
        dImpl.setValue("consumer",result.get("consumer"),CDataImpl.STRING);
        *xml中暂时没有相应的元素。表中有字段
         */
        //行为领域
        if (result.get("domain") != null && !result.get("domain").toString().equals(""))
        	dImpl.setValue("domain", result.get("domain"), CDataImpl.STRING);
        dImpl.update();
        dImpl.edit(Long.parseLong(result.get("psid").toString()));
        //示意图(大)二进制数据
        if (result.get("diagrampicldata") != null && !result.get("diagrampicldata").toString().equals(""))
        	dImpl.setBlobValue("diagrampicldata", decode(CTools.dealNull(result.get("diagrampicldata"))));
        //示意图(小)二进制数据
        if (result.get("diagrampicsdata") != null && !result.get("diagrampicsdata").toString().equals(""))
        	dImpl.setBlobValue("diagrampicsdata", decode(CTools.dealNull(result.get("diagrampicsdata"))));
        
        if (result.get("basises") != null && result.get("basises") instanceof List) {
            //保存法律依据
            saveBasises( (String) result.get("psid"), (List) result.get("basises"), dImpl);
        }
        if (result.get("subpowerstds") != null && result.get("subpowerstds") instanceof List) {
            //保存权力标准
            saveSubPowerStds( (String) result.get("psid"),(List) result.get("subpowerstds"), dImpl);
        }
    }
    
    /**
     * saveSubPowerStds
     * 保存子权力标准
     * @param powerStdid 字权力标准id
     * @param list xml文件中subpowerstd的list结果集
     * @param dImpl CDataImpl
     */
    private void saveSubPowerStds(String powerStdid, List list, CDataImpl dImpl) throws Exception {
        	if(list != null && list.size()>0){
        		for (int i = 0; i < list.size(); i++) {
        			Hashtable result = (Hashtable) list.get(i);
        			if ("99".equals(result.get("state"))) {
        				//删除主表及其子表，步骤 附件
        				String sql = "delete tb_qlgk_subpowerstd where id = '" + result.get("id") + "'";
        				dImpl.executeUpdate(sql);
        				
        				//记录日志
        				DataLog.logDataOperate(dImpl, (String) result.get("id"), "subpowerstd", "12");
        				continue;
        			}
        			
        			String sql = "select id from tb_qlgk_subpowerstd where id = " + result.get("id");
        			dImpl.setTableName("tb_qlgk_subpowerstd");
        			dImpl.setPrimaryFieldName("id");
        			dImpl.setPrimaryKeyType(CDataImpl.LONG);
        			
        			// 首先判断传过来的记录是否存在 存在就修改 不存在就新增
        			Hashtable ht1 = dImpl.getDataInfo(sql);
        			if (ht1 == null || ht1.size() == 0) {
        				dImpl.addNew();
        				dImpl.setValue("id", result.get("id"), CDataImpl.LONG); //权力标准主键ID
        				//记录日志
        				DataLog.logDataOperate(dImpl, (String) result.get("id"), "subpowerstd", "10");
        			}else {
        				dImpl.edit(Long.parseLong(result.get("id").toString())); //权力标准主键ID
        				//记录日志
        				DataLog.logDataOperate(dImpl, (String) result.get("id"), "subpowerstd", "11");
        			}
        			//与权力标准的外健
        			if (result.get("powerstd_id") != null && !result.get("powerstd_id").toString().equals(""))
        				dImpl.setValue("powerstd_id", result.get("powerstd_id"), CDataImpl.LONG);
        			//申请部门ID
        			if (result.get("createunitid") != null && !result.get("createunitid").toString().equals(""))
        				dImpl.setValue("createunitid", result.get("createunitid"), CDataImpl.LONG);
        			//申请部门名称
        			if (result.get("createunitname") != null && !result.get("createunitname").toString().equals(""))
        				dImpl.setValue("createunitname", result.get("createunitname"), CDataImpl.STRING);
        			//申请人ID
        			if (result.get("createuserid") != null && !result.get("createuserid").toString().equals(""))
        				dImpl.setValue("createuserid", result.get("createuserid"), CDataImpl.STRING);
        			//申请人姓名
        			if (result.get("createusername") != null && !result.get("createusername").toString().equals(""))
        				dImpl.setValue("createusername", result.get("createusername"), CDataImpl.STRING);
        			//申请日期
        			if (result.get("createdate") != null && !result.get("createdate").toString().equals(""))
        				dImpl.setValue("createtime", result.get("createdate"), CDataImpl.DATE);
        			//权力标准审批状态(当该值>1时该权力事项才可以公开)
        			if (result.get("state") != null && !result.get("state").toString().equals(""))
        				dImpl.setValue("state", result.get("state"), CDataImpl.STRING);
        			//职位
        			if (result.get("createuserjob") != null && !"".equals(result.get("createuserjob"))) {
        				dImpl.setValue("createuserjob", result.get("createuserjob"), CDataImpl.STRING);
        			}
        			/**
        			 * xml文件中没有相对应的字段
        			 * BUSYTIME
        			 * if (result.get("busytime") != null && !result.get("busytime").toString().trim().equals(""))
        			 * dImpl.setValue("busytime", result.get("busytime"), CDataImpl.String);
        			 */
        			/**
        			 * xml文件中没有相对应的字段
        			 * DEALFLOOR
        			 * if (result.get("dealfloor") != null && !result.get("dealfloor").toString().trim().equals(""))
        			 * dImpl.setValue("dealfloor", result.get("dealfloor"), CDataImpl.String);
        			 */
        			//审核机关ID
        			if (result.get("checkunitid") != null && !result.get("checkunitid").toString().equals(""))
        				dImpl.setValue("checkunitid", result.get("checkunitid"), CDataImpl.LONG);
        			//审核日期
        			if (result.get("checkdate") != null && !result.get("checkdate").toString().equals(""))
        				dImpl.setValue("checkdate", result.get("checkdate"), CDataImpl.DATE);
        			//审核人ID
        			if (result.get("checkuserid") != null && !result.get("checkuserid").toString().equals(""))
        				dImpl.setValue("checkuserid", result.get("checkuserid"), CDataImpl.STRING);
        			//审核人姓名
        			if (result.get("checkusername") != null && !result.get("checkusername").toString().equals(""))
        				dImpl.setValue("checkusername", result.get("checkusername"), CDataImpl.STRING);
        			//职权主体ID
        			if (result.get("aunitid") != null && !result.get("aunitid").toString().equals(""))
        				dImpl.setValue("aunitid", result.get("aunitid"), CDataImpl.LONG);
        			//责任人ID
        			if (result.get("auserid") != null && !result.get("auserid").toString().equals(""))
        				dImpl.setValue("auserid", result.get("auserid"), CDataImpl.STRING);
        			//责任人姓名
        			if (result.get("ausername") != null && !result.get("ausername").toString().equals(""))
        				dImpl.setValue("ausername", result.get("ausername"), CDataImpl.STRING);
        			//责任人职务
        			if (result.get("ajob") != null && !result.get("ajob").toString().equals(""))
        				dImpl.setValue("ajob", result.get("ajob"), CDataImpl.STRING);
        			//承办机构ID
        			if (result.get("bunitid") != null && !result.get("bunitid").toString().equals(""))
        				dImpl.setValue("bunitid", result.get("bunitid"), CDataImpl.LONG);
        			//承办人ID
        			if (result.get("buserid") != null && !result.get("buserid").toString().equals(""))
        				dImpl.setValue("buserid", result.get("buserid"), CDataImpl.STRING);
        			//承办人姓名
        			if (result.get("busername") != null && !result.get("busername").toString().equals(""))
        				dImpl.setValue("busername", result.get("busername"), CDataImpl.STRING);
        			//承办人职务
        			if (result.get("bjob") != null && !result.get("bjob").toString().equals(""))
        				dImpl.setValue("bjob", result.get("bjob"), CDataImpl.STRING); 
        			//承办机构代号
        			if (result.get("bunitcode") != null && !result.get("bunitcode").toString().equals(""))
        				dImpl.setValue("bunitcode", result.get("bunitcode"), CDataImpl.STRING);
        			//承办机构名称
        			if (result.get("bunitname") != null && !result.get("bunitname").toString().equals(""))
        				dImpl.setValue("bunitname", result.get("bunitname"), CDataImpl.STRING);
        			//审核机关代号
        			if (result.get("checkunitcode") != null && !result.get("checkunitcode").toString().equals(""))
        				dImpl.setValue("checkunitcode", result.get("checkunitcode"), CDataImpl.STRING);
        			//职权主体名称
        			if (result.get("aunitname") != null && !result.get("aunitname").toString().equals(""))
        				dImpl.setValue("aunitname", result.get("aunitname"), CDataImpl.STRING);
        			//职权主体代号
        			if (result.get("aunitcode") != null && !result.get("aunitcode").toString().equals(""))
        				dImpl.setValue("aunitcode", result.get("aunitcode"), CDataImpl.STRING);
        			//权力标准的权限单位(如万元，亩等)
        			if (result.get("pslimitunit") != null && !result.get("pslimitunit").toString().equals(""))
        				dImpl.setValue("pslimitunit", result.get("pslimitunit"), CDataImpl.STRING);
        			//权力标准的时限
        			if (result.get("duetimelimit") != null && !result.get("duetimelimit").toString().equals(""))
        				dImpl.setValue("duetimelimit", result.get("duetimelimit"), CDataImpl.LONG);
        			//权力标准的权限
        			if (result.get("pslimit") != null && !result.get("pslimit").toString().equals(""))
        				dImpl.setValue("pslimit", result.get("pslimit"), CDataImpl.STRING);
        			//审核机关名称
        			if (result.get("checkunitname") != null && !result.get("checkunitname").toString().equals(""))
        				dImpl.setValue("checkunitname", result.get("checkunitname"), CDataImpl.STRING);
        			//承办单位手写
        			if (result.get("cb") != null && !result.get("cb").toString().equals(""))
        				dImpl.setValue("cb", result.get("cb"), CDataImpl.STRING);
        			//职权主体手写
        			if (result.get("zt") != null && !result.get("zt").toString().equals(""))
        				dImpl.setValue("zt", result.get("zt"), CDataImpl.STRING);
        			//三重一大id
        			if (result.get("attr1") != null && !result.get("attr1").toString().equals(""))
        				dImpl.setValue("attr1id", result.get("attr1"), CDataImpl.LONG);
        			//三重一大name
        			if (result.get("attr1name") != null && !result.get("attr1name").toString().equals(""))
        				dImpl.setValue("attr1name", result.get("attr1name"), CDataImpl.STRING);
        			//增加前置环节和后置环节TB_QLGK_SUBPOWERSTD表中的字段
        			if (result.get("txtbefore") != null && !result.get("txtbefore").toString().equals(""))
        				dImpl.setValue("txtbefore",result.get("txtbefore"),CDataImpl.STRING);
        			if (result.get("txtafter") != null && !result.get("txtafter").toString().equals(""))
        				dImpl.setValue("txtafter",result.get("txtafter"),CDataImpl.STRING);    			
        			
        			//执行更新
        			dImpl.update();
        			/**
        			 * 持久化承办机构
        			 */
        			presistentSubcbs(result, dImpl);
        		}
        	}
    }

    /**
     * saveBasises
     * 保存法律依据
     * @param psid tb_qlgk_powerstd的主键id
     * @param list xml文件中basis的list大小
     * @param dImpl CDataImpl
     */
    private void saveBasises(String psid, List list, CDataImpl dImpl) {
    	if(list != null && list.size()>0){
    		//遍历所有的法律依据，有多少条增加
    		for (int i = 0; i < list.size(); i++) {
    			Hashtable result = (Hashtable) list.get(i);
    			String sql = "select id from tb_qlgk_law where id = " + result.get("id");
    			dImpl.setTableName("tb_qlgk_law");
    			dImpl.setPrimaryFieldName("id");
    			dImpl.setPrimaryKeyType(CDataImpl.LONG);
    			
    			// 首先判断传过来的记录是否存在 存在就修改 不存在就新增
    			Hashtable ht1 = dImpl.getDataInfo(sql);
    			if (ht1 == null || ht1.size() == 0) {
    				dImpl.addNew();
    				dImpl.setValue("id", result.get("id"), CDataImpl.LONG); //权力标准主键ID
    				dImpl.update();
    			}
    			dImpl.edit(Long.parseLong(result.get("id").toString())); //权力标准主键ID
    			
    			dImpl.setTableName("tb_qlgk_law");
    			dImpl.setPrimaryFieldName("id");
    			dImpl.setPrimaryKeyType(CDataImpl.LONG);
    			//建立索引时需要用到该id
    			if (result.get("id") != null && !"".equals(result.get("id")))
    				dImpl.setValue("id", result.get("id"), CDataImpl.LONG);
    			//权利依据名称
    			if (result.get("name") != null && !"".equals(result.get("name")))
    				dImpl.setValue("lawname", result.get("name"),CDataImpl.STRING);
    			/**
    			 *xml文件中没有相对应的元素 
    			//LAWBASIC
    			dImpl.setValue("lawbasic", result.get("lawbasic"), CDataImpl.LONG);
    			 */
    			//权利依据名称(管理后台传过来的权利依据名称，和LAWNAMW内容相同)
    			if (result.get("name") != null && !"".equals(result.get("name")))
    				dImpl.setValue("authorityby",result.get("name"),CDataImpl.STRING);
    			//权利依据类型
    			if (result.get("type") != null && !"".equals(result.get("type")))
    					dImpl.setValue("bykind", result.get("type"),CDataImpl.STRING);
    			//制定机关
    			if (result.get("unitname") != null && !"".equals(result.get("unitname")))
    			dImpl.setValue("consteorgan",result.get("unitname"),CDataImpl.STRING);
    			//制定日期
    			if (result.get("effectdate") != null && !"".equals(result.get("effectdate")))
    				dImpl.setValue("constedate",result.get("effectdate"), CDataImpl.DATE);
    			//外键值，与权力标准的关联
    			dImpl.setValue("psid", psid, CDataImpl.LONG);
    			dImpl.update();
    			//描述
    			if (result.get("content") != null && !"".equals(result.get("content"))){
    	            dImpl.setClobValue("describe", result.get("content"));
    			}
    			
    		}
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
     * 持久化承办单位
     * @param results 解析xml产生的HashTable集合 results是<subpowerstds></subpowerstds>中间的集合
     * @param dImpl 数据操作对象
     * @throws Exception
     */
    private void presistentSubcbs(Hashtable results, CDataImpl dImpl) throws Exception {
    	//承办单位	
    	ArrayList cbs = null;
    	cbs = (ArrayList)results.get("powerstdcbs");
    	String cbid = "";
    	String id = "";
    	if(results.get("powerstdcbs") != null && cbs != null && cbs.size()>0){
    		for(int j=0;j<cbs.size();j++){
    			Hashtable result = (Hashtable)cbs.get(j);
    			cbid = result.get("cbunit").toString()+results.get("id").toString();
    			String sql = "select id from tb_qlgk_cbunit where cbid = '" + cbid +"'";
    			dImpl.setTableName("tb_qlgk_cbunit");
    			dImpl.setPrimaryFieldName("id");
    			dImpl.setPrimaryKeyType(CDataImpl.LONG);
    			//首先判断传过来的记录是否存在 存在就修改 不存在就新增
    			Hashtable ht = dImpl.getDataInfo(sql);
    			if (ht == null || ht.size() == 0) {
	                id = CTools.dealNumber(dImpl.addNew()+"");
	                //步骤主键ID
	               dImpl.setValue("id", id, CDataImpl.LONG);
	            }
	            else {
	            	id = CTools.dealNumber(ht.get("id"));
	                dImpl.edit("tb_qlgk_cbunit","id",Long.parseLong(id));
	            }
    			//与分标准表的外键
    			if (cbid != null && !"".equals(cbid))
    					dImpl.setValue("cbid", cbid, CDataImpl.STRING);
    			//与分标准表的外键
    			if (results.get("id") != null && !"".equals(results.get("id")))
    				dImpl.setValue("subid", results.get("id"), CDataImpl.LONG);
	            //承办单位名称
    			if (result.get("cbunit") != null && !"".equals(result.get("cbunit")))
    				dImpl.setValue("cb", result.get("cbunit"), CDataImpl.STRING);
	            //承办负责人
    			if (result.get("busername") != null && !"".equals(result.get("busername")))
    				dImpl.setValue("cbname",result.get("busername"),CDataImpl.STRING);
	            //承办责任人职务
    			if (result.get("bjob") != null && !"".equals(result.get("bjob")))
    				dImpl.setValue("bjob", result.get("bjob"),CDataImpl.STRING);
	            dImpl.update();
    			/**
    			 *  持久化权力规范步骤
    			 */
    			presistentSubPowerStdSteps(result, dImpl,results.get("powerstd_id").toString(),results.get("id").toString(),id);
    		}
    	}
    	
    	
    }
    
    /**
     * 持久化权力规范步骤
     * @param results 解析xml产生的HashTable集合 results是<powerstdCB></powerstdCB>中间的集合
     * @param dImpl 数据操作对象
     * @param psid 权力事项id
     * @param id 子标准id
     * @throws Exception
     */
    private void presistentSubPowerStdSteps(Hashtable results, CDataImpl dImpl,String psid,String id,String cbid) throws Exception {
    	//承办单位
    			Object obj = null;
    			List steps = null;
    			obj = results.get("powerstdsteps");
    			if(obj != null && !("").equals(obj)){
    				steps = (List) obj;
    					//步骤
    					if(steps.size()>0){
    						for (int i = 0; i < steps.size(); i++) {
    							Hashtable result = (Hashtable) steps.get(i);
    							String sql = "select stepid from tb_qlgk_powerstdstep where stepid = " + result.get("stepid");
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
    							//承办机构id 与承办结构表的外键
    							if (cbid != null && !"".equals(cbid))
    								dImpl.setValue("cbid", cbid, CDataImpl.STRING);
    							//与分标准表的外键
    							if (results.get("id") != null && !"".equals(results.get("id")))
    								dImpl.setValue("subpowerstd_id", results.get("id"), CDataImpl.LONG);
    							//步骤名称
    							if (result.get("stepname") != null && !"".equals(result.get("stepname")))
    								dImpl.setValue("stepname", result.get("stepname"), CDataImpl.STRING);
    							//对应的权力标准ID
    							if (psid != null && !"".equals(psid))
    								dImpl.setValue("psid", psid, CDataImpl.LONG);
    							//角色名称
    							if (result.get("rolename") != null && !"".equals(result.get("rolename")))
    								dImpl.setValue("rolename", result.get("rolename"), CDataImpl.STRING);
    							//上一步ID(仅供显示参考，并不起到标示顺序的作用)
    							if (result.get("prevstepid") != null && !"".equals(result.get("prevstepid")))
    								dImpl.setValue("prevstepid", result.get("prevstepid"), CDataImpl.STRING);
    							//下一步ID(仅供显示参考，并不起到标示顺序的作用)
    							if (result.get("nextstepid") != null && !"".equals(result.get("nextstepid")))
    								dImpl.setValue("nextstepid", result.get("nextstepid"), CDataImpl.STRING);
    							//是否是关键步骤(如果值为1则在显示时在步骤名称上做标示)
    							if (result.get("iskey") != null && parseTOF.get(result.get("iskey")) != null) {
    								dImpl.setValue("iskey", parseTOF.get(result.get("iskey")), CDataImpl.LONG);
    							}
    							//是否是内部步骤，如果(值为1)则不能向公众展示
    							if (result.get("isinner") != null && parseTOF.get(result.get("isinner")) != null) {
    								dImpl.setValue("isinner", parseTOF.get(result.get("isinner")), CDataImpl.LONG);
    							}
    							//最长权力标准的时限
    							if (result.get("maxduetimelimit") != null && !result.get("maxduetimelimit").equals("")) {
    								dImpl.setValue("maxduetimelimit", parseNumberToStr(result.get("maxduetimelimit").toString()), CDataImpl.LONG);
    							}
    							//最大权力标准的权限
    							if (result.get("maxpslimit") != null && !result.get("maxpslimit").equals("")) {
    								dImpl.setValue("maxpslimit", parseNumberToStr(result.get("maxpslimit").toString()), CDataImpl.LONG);
    							}
    							//分组名
    							if (result.get("groupname") != null && !"".equals(result.get("groupname")))
    								dImpl.setValue("groupname", result.get("groupname"), CDataImpl.STRING);
    							//备注
    							if (result.get("des") != null && !"".equals(result.get("des")))
    								dImpl.setValue("des", result.get("des"), CDataImpl.STRING);
    							//音频说明文件文件名
    							if (result.get("audiodesname") != null && !"".equals(result.get("audiodesname")))
    								dImpl.setValue("audiodesname", result.get("audiodesname"), CDataImpl.STRING);
    							//音频说明文件类型
    							if (result.get("audiodestype") != null && !"".equals(result.get("audiodestype")))
    								dImpl.setValue("audiodestype", result.get("audiodestype"), CDataImpl.STRING);
    							
    							
    							//最大权力标准的权限单位
    							if (result.get("maxpslimitunit") != null && !result.get("maxpslimitunit").equals("")) {
    								dImpl.setValue("maxpslimitunit", parseNumberToStr(result.get("maxpslimitunit").toString()), CDataImpl.STRING);
    							}
    							
    							dImpl.update();
    							//音频说明文件数据
    							if (result.get("audiodesdata") != null && !"".equals(result.get("audiodesdata")))
    								dImpl.setBlobValue("audiodesdata", decode(CTools.dealNull(result.get("audiodesdata"))));
    							if (result.get("diagrampic") != null && !"".equals(result.get("diagrampic")))
    								dImpl.setBlobValue("diagrampic", decode(CTools.dealNull(result.get("diagrampic"))));
    							
    							// 获取步骤附件文件 持久化
    							if (! (result.get("stepfiles") instanceof List)) {
    								continue;
    							}else{    			            	
    								List stepfiles = (List) result.get("stepfiles");
    								if(stepfiles.size()>0){    			            	
    									//持久化事项附件
    									presistentPSFiles(stepfiles, dImpl, result.get("stepid").toString(),psid);
    								}
    							}
    						}
    					}
    			}
    }

    /**
     * 持久化权力规范的步骤文件
     * @param list 步骤文件列表
     * @param dImpl 数据库操作对象
     * @throws IOException
     * @throws Exception
     */
    private void presistentPSFiles(List list, CDataImpl dImpl, String sid,String psid) throws
        Exception, IOException {
        if (list != null && list.size() > 0) {
	        for (int i = 0; i < list.size(); i++) {
	            Hashtable result = (Hashtable) list.get(i);
	            // 先判断是否存在
	
	            String sql = "select fileid from tb_qlgk_psfile where fileid = " + result.get("fileid");
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
	            //附件权力标准id
	            if (psid != null && !"".equals(psid))
	            	dImpl.setValue("psid",psid,CDataImpl.LONG);
	            //文件代号
	            if (result.get("filecode") != null && !"".equals(result.get("filecode")))
	            	dImpl.setValue("filecode", result.get("filecode"), CDataImpl.STRING);
	            //权利事项ID(不用)
	            //dImpl.setValue("psid", result.get("psid"), CDataImpl.STRING);
	            //文件名称
	            if (result.get("filename") != null && !"".equals(result.get("filename")))
	            	dImpl.setValue("filename", result.get("filename"), CDataImpl.STRING);
	            //是否公开
	            if (result.get("isopen") != null && parseTOF.get(result.get("isopen")) != null) {
	                dImpl.setValue("isopen", parseTOF.get(result.get("isopen")), CDataImpl.LONG);
	            }
	            //是否必须
	            if (result.get("ismust") != null && parseTOF.get(result.get("ismust")) != null) {
	                dImpl.setValue("ismust", parseTOF.get(result.get("ismust")), CDataImpl.LONG);
	            }
	            //是否输入
	            if (result.get("isinput") != null && parseTOF.get(result.get("isinput")) != null) {
	                dImpl.setValue("isinput", parseTOF.get(result.get("isinput")), CDataImpl.LONG);
	            }
	            //是否输出
	            if (result.get("isoutput") != null && parseTOF.get(result.get("isoutput")) != null) {
	                dImpl.setValue("isoutput", parseTOF.get(result.get("isoutput")), CDataImpl.LONG);
	            }
	            //备注
	            if (result.get("des") != null && !"".equals(result.get("des")))
	            	dImpl.setValue("des", result.get("des"), CDataImpl.STRING);
	            //附件文档文件名
	            if (result.get("edocname") != null && !"".equals(result.get("edocname")))
	            	dImpl.setValue("edocname", result.get("edocname"), CDataImpl.STRING);
	            //附件文档文件类型(如doc、rtf)
	            if (result.get("edoctype") != null && !"".equals(result.get("edoctype")))
	            	dImpl.setValue("edoctype", result.get("edoctype"), CDataImpl.STRING);
	            //附件示意图文件名
	            if (result.get("diagrampicname") != null && !"".equals(result.get("diagrampicname")))
	            	dImpl.setValue("diagrampicname", result.get("diagrampicname"),CDataImpl.STRING);
	            //附件示意图文类型(如gif、jpg)
	            if (result.get("diagrampictype") != null && !"".equals(result.get("diagrampictype")))
	            	dImpl.setValue("diagrampictype", result.get("diagrampictype"),CDataImpl.STRING);
	            dImpl.update();
	            dImpl.edit(Long.parseLong(result.get("fileid").toString()));
	
	            dImpl.dataCn.beginTrans();
	            //附件文档数据
	            if (result.get("edocdata") != null && !"".equals(result.get("edocdata")))
	            	dImpl.setBlobValue("edocdata", decode(CTools.dealNull(result.get("edocdata"))));
	            //附件示意图数
	            if (result.get("diagrampicdata") != null && !"".equals(result.get("diagrampicdata")))
	            	dImpl.setBlobValue("diagrampicdata",decode(CTools.dealNull(result.get("diagrampicdata"))));
	            dImpl.dataCn.commitTrans();
	
	            sql = "delete from tb_qlgk_stepfiles where sid = " + sid;
	            dImpl.executeUpdate(sql);
	            // 持久化步骤文件映射
	            sql = "select sfid from tb_qlgk_stepfiles where sfid = " + result.get("sfid");
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
	            if (sid != null && !"".equals(sid))
	            dImpl.setValue("sid", sid, CDataImpl.LONG);
	            //附件ID
	            if (result.get("fileid") != null && !"".equals(result.get("fileid")))
	            dImpl.setValue("psfid", result.get("fileid"), CDataImpl.LONG);
	            //是否必须
	            if (result.get("ismust") != null && parseTOF.get(result.get("ismust")) != null) {
	                dImpl.setValue("ismust", parseTOF.get(result.get("ismust")),CDataImpl.LONG);
	            }
	            //是否输入文件
	            if (result.get("isinput") != null && parseTOF.get(result.get("isinput")) != null) {
	                dImpl.setValue("isinput", parseTOF.get(result.get("isinput")),CDataImpl.LONG);
	            }
	            //是否输出文件
	            if (result.get("isoutput") != null && parseTOF.get(result.get("isoutput")) != null) {
	                dImpl.setValue("isoutput", parseTOF.get(result.get("isoutput")),CDataImpl.LONG);
	            }
	            dImpl.update();
	        }
        }
    }

    /**
     * 是否可以公开
     * @param ppid 权力运行id
     * @return 是否可以公开 true是可以公开 false是不可以公开
     * @throws SQLException
     */
    private boolean checkPublic(String pscode, CDataImpl dImpl) throws SQLException {
        ResultSet rs = null;
        try {
            String sql = "select t2.openscope from " + "tb_qlgk_powerstd t2 where t2.openscope=2" + " and t2.pscode=" + pscode;
            rs = dImpl.executeQuery(sql);

            if (rs.next()) {
                return true;
            }
            return false;
        }
        catch (SQLException e) {
            throw e;
        }
        finally {
            if (rs != null) {
                try {
                    rs.close();
                }
                catch (SQLException e) {
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
        //循环map的键值
        Iterator it = data.keySet().iterator();
        while (it.hasNext()) {
            //获得键值key
            key = it.next();
            //如果该键内容要加密
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
    	if(result.get("ppid") != null && !("").equals(result.get("ppid"))){ 		
    		//新规定中如果state则要求这里删除
    		if ("99".equals(result.get("state"))) {
    			//删除主表及其子表，步骤 附件
    			if(result.get("ppid") != null && !result.get("ppid").toString().equals("")){        		
    				String sql = "select ppid from tb_qlgk_powerprocess where ppid = '" + result.get("ppid") + "'";
    				dImpl.executeUpdate(sql);
    			}
    			
    			//记录日志
    			DataLog.logDataOperate(dImpl, (String) result.get("ppid"),"powerprocess","22");
    			return;
    		}
    		
    		//是否加密,可以公开不加密，不可以公开则加密
    		boolean needEncrypt = !this.checkPublic(String.valueOf(result.get("pscode")), dImpl);
    		
    		if (needEncrypt) {
    			//如果要加密则加密相关字段
    			this.encrypt(result);
    			
    			//在hashtable中设置创建索引标识，以便后面的程序确定是否需要创建索引
    			result.put("_NEEDINDEX", "NO");
    		}
    		
    		if (result == null) {
    			//System.out.println("没有处理过程");
    			return;
    		}
    		String sql = "select ppid from tb_qlgk_powerprocess where ppid = '" + result.get("ppid") + "'";
    		dImpl.setTableName("tb_qlgk_powerprocess");
    		dImpl.setPrimaryFieldName("ppid");
    		dImpl.setPrimaryKeyType(CDataImpl.LONG);
    		Hashtable ht = dImpl.getDataInfo(sql);
    		if (ht == null || ht.size() == 0) {
    			dImpl.addNew();
    			//主键ID
    			dImpl.setValue("ppid", result.get("ppid"), CDataImpl.LONG);
    			dImpl.update();
    			DataLog.logDataOperate(dImpl, (String) result.get("ppid"),"powerprocess","20");
    		}
    		else {
    			DataLog.logDataOperate(dImpl, (String) result.get("ppid"),"powerprocess","21");
    		}
    		dImpl.edit(Long.parseLong(result.get("ppid").toString()));
    		
    		//外健关联，与子标准的关联 新增2008-02-28
    		if (result.get("subpowerstd_id") != null && !"".equals(result.get("subpowerstd_id")))
    			dImpl.setValue("SubPowerStd_ID", result.get("subpowerstd_id"),CDataImpl.LONG);
    		
    		//事项ID(业务系统中原始ID,以后可作为参数链接到系统)
    		if (result.get("id") != null && !"".equals(result.get("id")))
    			dImpl.setValue("id", result.get("id"), CDataImpl.STRING);
    		//事项编号
    		if (result.get("code") != null && !"".equals(result.get("code")))
    			dImpl.setValue("code", result.get("code"), CDataImpl.STRING);
    		//单位ID
    		if (result.get("unitid") != null && !"".equals(result.get("unitid")))
    			dImpl.setValue("unitid", result.get("unitid"), CDataImpl.LONG);
    		//单位Code
    		if (result.get("unitcode") != null && !"".equals(result.get("unitcode")))
    			dImpl.setValue("unitcode", result.get("unitcode"), CDataImpl.STRING);
    		//单位名称
    		if (result.get("unitname") != null && !"".equals(result.get("unitname")))
    			dImpl.setValue("unitname", result.get("unitname"), CDataImpl.STRING);
    		//权力编号
    		if (result.get("pscode") != null && !"".equals(result.get("pscode")))
    			dImpl.setValue("pscode", result.get("pscode"), CDataImpl.STRING);
    		//开始日期
    		if (result.get("begindate") != null && !result.get("begindate").equals(""))
    			dImpl.setValue("begindate", result.get("begindate"), CDataImpl.DATE);
    		//结束日期
    		if (result.get("enddate") != null && !result.get("enddate").equals(""))
    			dImpl.setValue("enddate", result.get("enddate"), CDataImpl.DATE);
    		//创建人ID
    		if (result.get("createuserid") != null && !"".equals(result.get("createuserid")))
    			dImpl.setValue("createuserid", result.get("createuserid"), CDataImpl.STRING);
    		//状态
    		if (result.get("state") != null && !"".equals(result.get("state")))
    			dImpl.setValue("state", result.get("state"), CDataImpl.STRING);
    		//创建人姓名
    		if (result.get("createusername") != null && !"".equals(result.get("createusername")))
    			dImpl.setValue("createusername", result.get("createusername"), CDataImpl.STRING);
    		//上传日期
    		if (result.get("uploaddate") != null && !result.get("uploaddate").equals(""))
    			dImpl.setValue("uploaddate", result.get("uploaddate"),CDataImpl.DATE);
    		//申请人(市民)
    		if (result.get("residentname") != null && !"".equals(result.get("residentname")))
    			dImpl.setValue("residentname", result.get("residentname"),CDataImpl.STRING);
    		//申请人(企业)
    		if (result.get("companyname") != null && !"".equals(result.get("companyname")))
    			dImpl.setValue("companyname", result.get("companyname"),CDataImpl.STRING);
    		//自定
    		if (result.get("memo") != null && !"".equals(result.get("memo")))
    			dImpl.setValue("memo", result.get("memo"), CDataImpl.STRING);
    		//实际处理时限
    		if (result.get("duetime") != null && !result.get("duetime").toString().trim().equals(""))
    			dImpl.setValue("duetime", result.get("duetime"), CDataImpl.LONG);
    		//实际处理权限
    		if (result.get("pslimit") != null && !result.get("pslimit").toString().trim().equals(""))
    			dImpl.setValue("pslimit", result.get("pslimit"), CDataImpl.FLOAT);
    		//是否结束
    		if (result.get("isfinished") != null && parseTOF.get(result.get("isfinished")) != null) {
    			dImpl.setValue("isfinished", parseTOF.get(result.get("isfinished")),CDataImpl.LONG);
    		}
    		//是否超过时限
    		if (result.get("isoutofduetimelimit") != null && !"".equals(result.get("isoutofduetimelimit")))
    			dImpl.setValue("isoutofduetimelimit", result.get("isoutofduetimelimit"),CDataImpl.LONG);
    		//是否公开(只有标示为1或该运行过程对应的事项是可公开时该运行过程数据才可以显示)
    		if (result.get("isopen") != null && parseTOF.get(result.get("isopen")) != null) {
    			dImpl.setValue("isopen", parseTOF.get(result.get("isopen")),CDataImpl.LONG);
    		}
    		//是否超过权限
    		if (result.get("isoutofpslimit") != null && parseTOF.get(result.get("isoutofpslimit")) != null) {
    			dImpl.setValue("isoutofpslimit",parseTOF.get(result.get("isoutofpslimit")),CDataImpl.LONG);
    		}
    		//特殊说明
    		if (result.get("des") != null && !"".equals(result.get("des")))
    			dImpl.setValue("des", result.get("des"), CDataImpl.STRING);
    		dImpl.update();
    		dImpl.edit(Long.parseLong(result.get("ppid").toString()));
    		//监管说明
    		if (result.get("supervisedes") != null && !"".equals(result.get("supervisedes")))
    			dImpl.setValue("supervisedes", result.get("supervisedes"),CDataImpl.STRING);
    		dImpl.update();
    		if (! (result.get("powerprocesssteps") instanceof ArrayList)) {
    			return;
    		}
    		List stepfiles = (List) result.get("powerprocesssteps");
    		if (stepfiles == null || stepfiles.size() == 0)
    			return;
    		//持久化权力运行过程步骤数据
    		presistentPowerProcessSteps(stepfiles, dImpl, result.get("ppid").toString());
    	}
    }

    /**
     * 持久化权力运行过程步骤数据
     * @param list 步骤集合
     * @param dImpl
     * @param ppid 过程编号
     * @throws Exception
     */
    private void presistentPowerProcessSteps(List list, CDataImpl dImpl, String ppid) throws Exception {
    	if(list != null && list.size()>0){   	
    		for (int i = 0; i < list.size(); i++) {
    			Map result = (Map) list.get(i);
    			if(null != result.get("ppsid") && !("").equals(result.get("ppsid"))){        		
    				//删除当前的步骤
    				String sql = "delete from tb_qlgk_powerprocessstep where ppsid = " + result.get("ppsid");
    				dImpl.executeUpdate(sql);
    				
    				dImpl.setTableName("tb_qlgk_powerprocessstep");
    				dImpl.setPrimaryFieldName("ppsid");
    				dImpl.setPrimaryKeyType(CDataImpl.LONG);
    				
    				dImpl.addNew();
    				//主键ID
    				if (result.get("ppsid") != null && !"".equals(result.get("ppsid")))
    					dImpl.setValue("ppsid", result.get("ppsid"), CDataImpl.LONG);
    				//运行过程ID
    				if (ppid != null && !"".equals(ppid))
    					dImpl.setValue("ppid", ppid, CDataImpl.LONG);
    				//原始ID
    				if (result.get("id") != null && !"".equals(result.get("id")))
    					dImpl.setValue("id", result.get("id"), CDataImpl.LONG);
    				//指向权利事项步骤主键ID
    				if (result.get("psstepid") != null && !"".equals(result.get("psstepid")))
    					dImpl.setValue("psstepid", result.get("psstepid"), CDataImpl.LONG);
    				//步骤名称
    				if (result.get("name") != null && !"".equals(result.get("name")))
    					dImpl.setValue("name", result.get("name"), CDataImpl.STRING);
    				//开始日期
    				if (result.get("begindate") != null && !result.get("begindate").equals(""))
    					dImpl.setValue("begindate", result.get("begindate"), CDataImpl.DATE);
    				//结束日期
    				if (result.get("enddate") != null && !result.get("enddate").equals(""))
    					dImpl.setValue("enddate", result.get("enddate"), CDataImpl.DATE);
    				//顺序
    				if (result.get("sequence") != null && !"".equals(result.get("sequence")))
    					dImpl.setValue("sequence", result.get("sequence"), CDataImpl.STRING);
    				//实际时限
    				if (result.get("duetime") != null && !result.get("duetime").toString().trim().equals(""))
    					dImpl.setValue("duetime", result.get("duetime"), CDataImpl.LONG);
    				//实际权限
    				if (result.get("pslimit") != null && !result.get("pslimit").toString().trim().equals(""))
    					dImpl.setValue("pslimit", result.get("pslimit"), CDataImpl.FLOAT);
    				//角色名称,可以是多个角色,中间用、号隔开
    				if (result.get("rolenames") != null && !"".equals(result.get("rolenames")))
    					dImpl.setValue("rolenames", result.get("rolenames"), CDataImpl.STRING);
    				//最长办理时间
    				if (result.get("maxduetimelimit") != null && !result.get("maxduetimelimit").equals(""))
    					dImpl.setValue("maxduetimelimit", result.get("maxduetimelimit"),CDataImpl.LONG);
    				//最大办理权限
    				if (result.get("maxpslimit") != null && !result.get("maxpslimit").equals(""))
    					dImpl.setValue("maxpslimit", result.get("maxpslimit"), CDataImpl.LONG);
    				//备注
    				if (result.get("des") != null && !"".equals(result.get("des")))
    					dImpl.setValue("des", result.get("des"), CDataImpl.STRING);
    				//是否超过时限
    				if (result.get("isoutofduetimelimit") != null && parseTOF.get(result.get("isoutofduetimelimit")) != null) {
    					dImpl.setValue("isoutofduetimelimit", parseTOF.get(result.get("isoutofduetimelimit")), CDataImpl.LONG);
    				}
    				//是否超过权限
    				if (result.get("isoutofpslimit") != null && parseTOF.get(result.get("isoutofpslimit")) != null) {
    					dImpl.setValue("isoutofpslimit", parseTOF.get(result.get("isoutofpslimit")), CDataImpl.LONG);
    				}
    				//是否超出角色权利范围
    				if (result.get("isoverstep") != null && parseTOF.get(result.get("isoverstep")) != null) {
    					dImpl.setValue("isoverstep", parseTOF.get(result.get("isoverstep")), CDataImpl.LONG);
    				}
    				//预留字段
    				if (result.get("memo") != null && !"".equals(result.get("memo")))
    					dImpl.setValue("memo", result.get("memo"), CDataImpl.STRING);
    				//用户ID
    				if (result.get("userid") != null && !"".equals(result.get("userid")))
    					dImpl.setValue("userid", result.get("userid"), CDataImpl.STRING);
    				//用户姓名
    				if (result.get("username") != null && !"".equals(result.get("username")))
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
    }

}
