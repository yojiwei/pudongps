package com.util;

import java.io.*;
import java.util.*;
import com.component.database.*;
import com.util.*;

/**
 *
 * <p>Title: oa</p>
 * <p>Description:收发消息的类 </p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: shanghai internet co.ltd.</p>
 * @author wanghekun
 * @version 1.0
 */
public class CMessage1 {
    private CDataImpl _dImpl;
    private String _msgId; //消息id
    private String _msgTitle; //消息标题
    private String _msgContent; //消息内容
    private String _msgIsNew; //是否为新消息
    private String _msgReceiverId; //消息接收者id
    private String _msgReceiverName; //消息接受者姓名
    private String _msgSenderId; //消息发送者id
    private String _msgSenderName; //消息发送者的姓名
    private String _msgSenderDesc; //消息发送者的描述，一般是用部门名称代替
    private String _msgSendTime; //消息发送时间
    private String _msgReceiveTime; //消息接收时间
    private String _msgType; //消息类型
    private String _msgRelatedType;
    private String _msgPrimaryId;

    //声名常量，在setValue方法里用到
    public static final int msgId = 0;
    public static final int msgTitle = 1;
    public static final int msgContent = 2;
    public static final int msgIsNew = 3;
    public static final int msgReceiverId = 4;
    public static final int msgReceiverName = 5;
    public static final int msgSenderId = 6;
    public static final int msgSenderName = 7;
    public static final int msgSenderDesc = 8;
    public static final int msgSendTime = 9;
    public static final int msgReceiveTime = 10;
    public static final int msgType = 11;
    public static final int msgRelatedType = 12;
    public static final int msgPrimaryId = 13;

    private CMessage1() {
        _msgId = ""; //消息id
        _msgTitle = ""; //消息标题
        _msgContent = ""; //消息内容
        _msgIsNew = "1"; //是否为新消息
        _msgReceiverId = ""; //消息接收者id
        _msgReceiverName = ""; //消息接受者姓名
        _msgSenderId = ""; //消息发送者id
        _msgSenderName = ""; //消息发送者的姓名
        _msgSenderDesc = ""; //消息发送者的描述，一般是用部门名称代替
        _msgSendTime = ""; //消息发送时间
        _msgReceiveTime = ""; //消息接收时间
        _msgType = ""; //消息类型
        _msgRelatedType = "1"; //消息与什么类型的记录相关
        _msgPrimaryId = "";
        this._msgSendTime = new CDate().getNowTime(); //默认是当前时间发送
    }

    public CMessage1(CDataImpl dImpl) {
        this();
        this._dImpl = dImpl;
    }

    /**
     * 给选定字段赋值
     * @param field 要设置的字段
     * @param val 要给该字段的值
     */

    public void setValue(int field, String val) {
        switch (field) {
            case msgTitle:
                this._msgTitle = val;
                break;
            case msgContent:
                this._msgContent = val;
                break;
            case msgIsNew:
                this._msgIsNew = val;
                break;
            case msgReceiverId:
                this._msgReceiverId = val;
                break;
            case msgReceiverName:
                this._msgReceiverName = val;
                break;
            case msgSenderId:
                this._msgSenderId = val;
                break;
            case msgSenderName:
                this._msgSenderName = val;
                break;
            case msgSenderDesc:
                this._msgSenderDesc = val;
                break;
            case msgSendTime:
                this._msgSendTime = val;
                break;
            case msgReceiveTime:
                this._msgReceiveTime = val;
                break;
            case msgType:
                this._msgType = val;
                break;
            case msgRelatedType:
                this._msgRelatedType = val;
                break;
            case msgPrimaryId:
                this._msgPrimaryId = val;
                break;
        }
    }

    /**
     * 此方法用于已知消息id，要阅读消息的情况
     * @param dImpl 数据库接口对象
     * @param msgId  消息id
     */
    public CMessage1(CDataImpl dImpl, String msgId) {
        this(dImpl);
        String sqlStr = "select * from tb_message where ma_id='" + msgId + "'";
        Hashtable content = _dImpl.getDataInfo(sqlStr);
        if (content != null) {
            this._msgId = content.get("ma_id").toString();
            this._msgContent = content.get("ma_content").toString();
            this._msgTitle = content.get("ma_title").toString();
            this._msgReceiverId = content.get("ma_receiverid").toString();
            this._msgReceiverName = content.get("ma_receivername").toString();
            this._msgSenderId = content.get("ma_senderid").toString();
            this._msgSenderName = content.get("ma_sendername").toString();
            this._msgSenderDesc = content.get("ma_senderdesc").toString();
            this._msgSendTime = content.get("ma_sendtime").toString();
            this._msgReceiveTime = content.get("ma_receivetime").toString();
            this._msgType = content.get("ma_type").toString();
            this._msgRelatedType = content.get("ma_relatedtype").toString();
            this._msgPrimaryId = content.get("ma_primaryid").toString();
            this._msgSendTime = _msgSendTime.substring(0,
                _msgSendTime.length() - 2);
        }
    }

    /**
     * 新增一条记录
     * @return 返回新记录的id
     */
    public String addNew() {
        this._msgId = this._dImpl.addNew("tb_message", "ma_id",
                                         CDataImpl.PRIMARY_KEY_IS_VARCHAR);

        return this._msgId;
    }

    /**
     * 新增一条完整的新消息
     */
    public void update() {
        this._dImpl.setValue("ma_title", _msgTitle, CDataImpl.STRING);
        this._dImpl.setValue("ma_senderid", _msgSenderId, CDataImpl.STRING);
        this._dImpl.setValue("ma_senderName", _msgSenderName, CDataImpl.STRING);
        this._dImpl.setValue("ma_senderDesc", _msgSenderDesc, CDataImpl.STRING);
        this._dImpl.setValue("ma_receiverId", _msgReceiverId, CDataImpl.STRING);
        this._dImpl.setValue("ma_receiverName", _msgReceiverName,
                             CDataImpl.STRING);
        this._dImpl.setValue("ma_isNew", _msgIsNew, CDataImpl.STRING);
        this._dImpl.setValue("ma_sendTime", _msgSendTime, CDataImpl.DATE);
        this._dImpl.setValue("ma_type", _msgType, CDataImpl.STRING);
        this._dImpl.setValue("ma_RelatedType", _msgRelatedType,CDataImpl.STRING);
        this._dImpl.setValue("ma_primaryid", _msgPrimaryId, CDataImpl.STRING);
        this._dImpl.update();
        this._dImpl.setClobValue("ma_content", _msgContent);
    }

    public void update(int fieldName, String val) {
        if (!_msgId.equals("")) {
            this._dImpl.edit("tb_message", "ma_id", _msgId);
            setValue(fieldName, val);
            update();
        }
        else {
            System.out.println("错误:在未定位记录的情况下，试图修改记录属性!");
        }
    }

    public String getValue(int fieldName) {
        String result = "";
        switch (fieldName) {
            case msgId:
                result = this._msgId;
                break;
            case msgTitle:
                result = this._msgTitle;
                break;
            case msgContent:
                result = this._msgContent;
                break;
            case msgIsNew:
                result = this._msgIsNew;
                break;
            case msgReceiverId:
                result = this._msgReceiverId;
                break;
            case msgReceiverName:
                result = this._msgReceiverName;
                break;
            case msgSenderId:
                result = this._msgSenderId;
                break;
            case msgSenderName:
                result = this._msgSenderName;
                break;
            case msgSenderDesc:
                result = this._msgSenderDesc;
                break;
            case msgSendTime:
                result = this._msgSendTime;
                break;
            case msgReceiveTime:
                result = this._msgReceiveTime;
                break;
            case msgType:
                result = this._msgType;
                break;
            case msgRelatedType:
                result = this._msgRelatedType;
                break;
            case msgPrimaryId:
                result = this._msgPrimaryId;
                break;
            default:
                result = "";
        }
        return result;
    }

    public static void main(String[] args) {
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        CMessage1 msg = new CMessage1(dImpl,"o163");
        try {
            dCn.beginTrans();
            String id = msg.addNew();
                   msg.setValue(CMessage.msgTitle,"测试类");
                   msg.setValue(CMessage.msgContent,"简单测试");
                   msg.setValue(CMessage.msgReceiverId,"o141");
                   msg.setValue(CMessage.msgReceiverName,"汪贺坤");
                   msg.setValue(CMessage.msgSenderId,"4");
                   msg.setValue(CMessage.msgSenderName,"管理员");
                   msg.setValue(CMessage.msgSenderDesc,"劳保局");
                   msg.setValue(CMessage.msgIsNew,"1");
                   msg.setValue(CMessage.msgType,"2");
                   msg.setValue(CMessage.msgPrimaryId,"o61");
                   msg.update();
                   msg.update(CMessage1.msgPrimaryId, "088");
            dCn.commitTrans();
            //System.out.println(id);
        }
        catch (Exception e) {
            System.out.println(e.getMessage());
            dCn.rollbackTrans();
        }
        dImpl.closeStmt();
        dCn.closeCn();
    }
}
