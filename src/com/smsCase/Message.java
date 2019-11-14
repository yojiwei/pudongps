/**
 * Message.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.smsCase;

public class Message  implements java.io.Serializable {
    private int id;

    private java.lang.String senderId;

    private java.lang.String senderName;

    private java.lang.String senderTel;

    private java.lang.String senderTelSuffix;

    private java.lang.String addresseeId;

    private java.lang.String addresseeName;

    private java.lang.String addresseeTel;

    private java.lang.String addresseeTelSuffix;

    private java.lang.String content;

    private java.util.Calendar createTime;

    private java.util.Calendar sendTime;

    private com.smsCase.MessageType type;

    private com.smsCase.MessageStatus status;

    private java.lang.String guid;

    private java.lang.String appCode;

    private java.lang.String appName;

    public Message() {
    }

    public Message(
           int id,
           java.lang.String senderId,
           java.lang.String senderName,
           java.lang.String senderTel,
           java.lang.String senderTelSuffix,
           java.lang.String addresseeId,
           java.lang.String addresseeName,
           java.lang.String addresseeTel,
           java.lang.String addresseeTelSuffix,
           java.lang.String content,
           java.util.Calendar createTime,
           java.util.Calendar sendTime,
           com.smsCase.MessageType type,
           com.smsCase.MessageStatus status,
           java.lang.String guid,
           java.lang.String appCode,
           java.lang.String appName) {
           this.id = id;
           this.senderId = senderId;
           this.senderName = senderName;
           this.senderTel = senderTel;
           this.senderTelSuffix = senderTelSuffix;
           this.addresseeId = addresseeId;
           this.addresseeName = addresseeName;
           this.addresseeTel = addresseeTel;
           this.addresseeTelSuffix = addresseeTelSuffix;
           this.content = content;
           this.createTime = createTime;
           this.sendTime = sendTime;
           this.type = type;
           this.status = status;
           this.guid = guid;
           this.appCode = appCode;
           this.appName = appName;
    }


    /**
     * Gets the id value for this Message.
     * 
     * @return id
     */
    public int getId() {
        return id;
    }


    /**
     * Sets the id value for this Message.
     * 
     * @param id
     */
    public void setId(int id) {
        this.id = id;
    }


    /**
     * Gets the senderId value for this Message.
     * 
     * @return senderId
     */
    public java.lang.String getSenderId() {
        return senderId;
    }


    /**
     * Sets the senderId value for this Message.
     * 
     * @param senderId
     */
    public void setSenderId(java.lang.String senderId) {
        this.senderId = senderId;
    }


    /**
     * Gets the senderName value for this Message.
     * 
     * @return senderName
     */
    public java.lang.String getSenderName() {
        return senderName;
    }


    /**
     * Sets the senderName value for this Message.
     * 
     * @param senderName
     */
    public void setSenderName(java.lang.String senderName) {
        this.senderName = senderName;
    }


    /**
     * Gets the senderTel value for this Message.
     * 
     * @return senderTel
     */
    public java.lang.String getSenderTel() {
        return senderTel;
    }


    /**
     * Sets the senderTel value for this Message.
     * 
     * @param senderTel
     */
    public void setSenderTel(java.lang.String senderTel) {
        this.senderTel = senderTel;
    }


    /**
     * Gets the senderTelSuffix value for this Message.
     * 
     * @return senderTelSuffix
     */
    public java.lang.String getSenderTelSuffix() {
        return senderTelSuffix;
    }


    /**
     * Sets the senderTelSuffix value for this Message.
     * 
     * @param senderTelSuffix
     */
    public void setSenderTelSuffix(java.lang.String senderTelSuffix) {
        this.senderTelSuffix = senderTelSuffix;
    }


    /**
     * Gets the addresseeId value for this Message.
     * 
     * @return addresseeId
     */
    public java.lang.String getAddresseeId() {
        return addresseeId;
    }


    /**
     * Sets the addresseeId value for this Message.
     * 
     * @param addresseeId
     */
    public void setAddresseeId(java.lang.String addresseeId) {
        this.addresseeId = addresseeId;
    }


    /**
     * Gets the addresseeName value for this Message.
     * 
     * @return addresseeName
     */
    public java.lang.String getAddresseeName() {
        return addresseeName;
    }


    /**
     * Sets the addresseeName value for this Message.
     * 
     * @param addresseeName
     */
    public void setAddresseeName(java.lang.String addresseeName) {
        this.addresseeName = addresseeName;
    }


    /**
     * Gets the addresseeTel value for this Message.
     * 
     * @return addresseeTel
     */
    public java.lang.String getAddresseeTel() {
        return addresseeTel;
    }


    /**
     * Sets the addresseeTel value for this Message.
     * 
     * @param addresseeTel
     */
    public void setAddresseeTel(java.lang.String addresseeTel) {
        this.addresseeTel = addresseeTel;
    }


    /**
     * Gets the addresseeTelSuffix value for this Message.
     * 
     * @return addresseeTelSuffix
     */
    public java.lang.String getAddresseeTelSuffix() {
        return addresseeTelSuffix;
    }


    /**
     * Sets the addresseeTelSuffix value for this Message.
     * 
     * @param addresseeTelSuffix
     */
    public void setAddresseeTelSuffix(java.lang.String addresseeTelSuffix) {
        this.addresseeTelSuffix = addresseeTelSuffix;
    }


    /**
     * Gets the content value for this Message.
     * 
     * @return content
     */
    public java.lang.String getContent() {
        return content;
    }


    /**
     * Sets the content value for this Message.
     * 
     * @param content
     */
    public void setContent(java.lang.String content) {
        this.content = content;
    }


    /**
     * Gets the createTime value for this Message.
     * 
     * @return createTime
     */
    public java.util.Calendar getCreateTime() {
        return createTime;
    }


    /**
     * Sets the createTime value for this Message.
     * 
     * @param createTime
     */
    public void setCreateTime(java.util.Calendar createTime) {
        this.createTime = createTime;
    }


    /**
     * Gets the sendTime value for this Message.
     * 
     * @return sendTime
     */
    public java.util.Calendar getSendTime() {
        return sendTime;
    }


    /**
     * Sets the sendTime value for this Message.
     * 
     * @param sendTime
     */
    public void setSendTime(java.util.Calendar sendTime) {
        this.sendTime = sendTime;
    }


    /**
     * Gets the type value for this Message.
     * 
     * @return type
     */
    public com.smsCase.MessageType getType() {
        return type;
    }


    /**
     * Sets the type value for this Message.
     * 
     * @param type
     */
    public void setType(com.smsCase.MessageType type) {
        this.type = type;
    }


    /**
     * Gets the status value for this Message.
     * 
     * @return status
     */
    public com.smsCase.MessageStatus getStatus() {
        return status;
    }


    /**
     * Sets the status value for this Message.
     * 
     * @param status
     */
    public void setStatus(com.smsCase.MessageStatus status) {
        this.status = status;
    }


    /**
     * Gets the guid value for this Message.
     * 
     * @return guid
     */
    public java.lang.String getGuid() {
        return guid;
    }


    /**
     * Sets the guid value for this Message.
     * 
     * @param guid
     */
    public void setGuid(java.lang.String guid) {
        this.guid = guid;
    }


    /**
     * Gets the appCode value for this Message.
     * 
     * @return appCode
     */
    public java.lang.String getAppCode() {
        return appCode;
    }


    /**
     * Sets the appCode value for this Message.
     * 
     * @param appCode
     */
    public void setAppCode(java.lang.String appCode) {
        this.appCode = appCode;
    }


    /**
     * Gets the appName value for this Message.
     * 
     * @return appName
     */
    public java.lang.String getAppName() {
        return appName;
    }


    /**
     * Sets the appName value for this Message.
     * 
     * @param appName
     */
    public void setAppName(java.lang.String appName) {
        this.appName = appName;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof Message)) return false;
        Message other = (Message) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            this.id == other.getId() &&
            ((this.senderId==null && other.getSenderId()==null) || 
             (this.senderId!=null &&
              this.senderId.equals(other.getSenderId()))) &&
            ((this.senderName==null && other.getSenderName()==null) || 
             (this.senderName!=null &&
              this.senderName.equals(other.getSenderName()))) &&
            ((this.senderTel==null && other.getSenderTel()==null) || 
             (this.senderTel!=null &&
              this.senderTel.equals(other.getSenderTel()))) &&
            ((this.senderTelSuffix==null && other.getSenderTelSuffix()==null) || 
             (this.senderTelSuffix!=null &&
              this.senderTelSuffix.equals(other.getSenderTelSuffix()))) &&
            ((this.addresseeId==null && other.getAddresseeId()==null) || 
             (this.addresseeId!=null &&
              this.addresseeId.equals(other.getAddresseeId()))) &&
            ((this.addresseeName==null && other.getAddresseeName()==null) || 
             (this.addresseeName!=null &&
              this.addresseeName.equals(other.getAddresseeName()))) &&
            ((this.addresseeTel==null && other.getAddresseeTel()==null) || 
             (this.addresseeTel!=null &&
              this.addresseeTel.equals(other.getAddresseeTel()))) &&
            ((this.addresseeTelSuffix==null && other.getAddresseeTelSuffix()==null) || 
             (this.addresseeTelSuffix!=null &&
              this.addresseeTelSuffix.equals(other.getAddresseeTelSuffix()))) &&
            ((this.content==null && other.getContent()==null) || 
             (this.content!=null &&
              this.content.equals(other.getContent()))) &&
            ((this.createTime==null && other.getCreateTime()==null) || 
             (this.createTime!=null &&
              this.createTime.equals(other.getCreateTime()))) &&
            ((this.sendTime==null && other.getSendTime()==null) || 
             (this.sendTime!=null &&
              this.sendTime.equals(other.getSendTime()))) &&
            ((this.type==null && other.getType()==null) || 
             (this.type!=null &&
              this.type.equals(other.getType()))) &&
            ((this.status==null && other.getStatus()==null) || 
             (this.status!=null &&
              this.status.equals(other.getStatus()))) &&
            ((this.guid==null && other.getGuid()==null) || 
             (this.guid!=null &&
              this.guid.equals(other.getGuid()))) &&
            ((this.appCode==null && other.getAppCode()==null) || 
             (this.appCode!=null &&
              this.appCode.equals(other.getAppCode()))) &&
            ((this.appName==null && other.getAppName()==null) || 
             (this.appName!=null &&
              this.appName.equals(other.getAppName())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = 1;
        _hashCode += getId();
        if (getSenderId() != null) {
            _hashCode += getSenderId().hashCode();
        }
        if (getSenderName() != null) {
            _hashCode += getSenderName().hashCode();
        }
        if (getSenderTel() != null) {
            _hashCode += getSenderTel().hashCode();
        }
        if (getSenderTelSuffix() != null) {
            _hashCode += getSenderTelSuffix().hashCode();
        }
        if (getAddresseeId() != null) {
            _hashCode += getAddresseeId().hashCode();
        }
        if (getAddresseeName() != null) {
            _hashCode += getAddresseeName().hashCode();
        }
        if (getAddresseeTel() != null) {
            _hashCode += getAddresseeTel().hashCode();
        }
        if (getAddresseeTelSuffix() != null) {
            _hashCode += getAddresseeTelSuffix().hashCode();
        }
        if (getContent() != null) {
            _hashCode += getContent().hashCode();
        }
        if (getCreateTime() != null) {
            _hashCode += getCreateTime().hashCode();
        }
        if (getSendTime() != null) {
            _hashCode += getSendTime().hashCode();
        }
        if (getType() != null) {
            _hashCode += getType().hashCode();
        }
        if (getStatus() != null) {
            _hashCode += getStatus().hashCode();
        }
        if (getGuid() != null) {
            _hashCode += getGuid().hashCode();
        }
        if (getAppCode() != null) {
            _hashCode += getAppCode().hashCode();
        }
        if (getAppName() != null) {
            _hashCode += getAppName().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(Message.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://beyondbit.com/smp", "Message"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("id");
        elemField.setXmlName(new javax.xml.namespace.QName("http://beyondbit.com/smp", "Id"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("senderId");
        elemField.setXmlName(new javax.xml.namespace.QName("http://beyondbit.com/smp", "SenderId"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("senderName");
        elemField.setXmlName(new javax.xml.namespace.QName("http://beyondbit.com/smp", "SenderName"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("senderTel");
        elemField.setXmlName(new javax.xml.namespace.QName("http://beyondbit.com/smp", "SenderTel"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("senderTelSuffix");
        elemField.setXmlName(new javax.xml.namespace.QName("http://beyondbit.com/smp", "SenderTelSuffix"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("addresseeId");
        elemField.setXmlName(new javax.xml.namespace.QName("http://beyondbit.com/smp", "AddresseeId"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("addresseeName");
        elemField.setXmlName(new javax.xml.namespace.QName("http://beyondbit.com/smp", "AddresseeName"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("addresseeTel");
        elemField.setXmlName(new javax.xml.namespace.QName("http://beyondbit.com/smp", "AddresseeTel"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("addresseeTelSuffix");
        elemField.setXmlName(new javax.xml.namespace.QName("http://beyondbit.com/smp", "AddresseeTelSuffix"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("content");
        elemField.setXmlName(new javax.xml.namespace.QName("http://beyondbit.com/smp", "Content"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("createTime");
        elemField.setXmlName(new javax.xml.namespace.QName("http://beyondbit.com/smp", "CreateTime"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "dateTime"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("sendTime");
        elemField.setXmlName(new javax.xml.namespace.QName("http://beyondbit.com/smp", "SendTime"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "dateTime"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("type");
        elemField.setXmlName(new javax.xml.namespace.QName("http://beyondbit.com/smp", "Type"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://beyondbit.com/smp", "MessageType"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("status");
        elemField.setXmlName(new javax.xml.namespace.QName("http://beyondbit.com/smp", "Status"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://beyondbit.com/smp", "MessageStatus"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("guid");
        elemField.setXmlName(new javax.xml.namespace.QName("http://beyondbit.com/smp", "Guid"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("appCode");
        elemField.setXmlName(new javax.xml.namespace.QName("http://beyondbit.com/smp", "AppCode"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("appName");
        elemField.setXmlName(new javax.xml.namespace.QName("http://beyondbit.com/smp", "AppName"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
    }

    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static org.apache.axis.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanSerializer(
            _javaType, _xmlType, typeDesc);
    }

    /**
     * Get Custom Deserializer
     */
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanDeserializer(
            _javaType, _xmlType, typeDesc);
    }

}
