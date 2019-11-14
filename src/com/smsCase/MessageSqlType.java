/**
 * MessageSqlType.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.smsCase;

public class MessageSqlType implements java.io.Serializable {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected MessageSqlType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    }

    public static final java.lang.String _None = "None";
    public static final java.lang.String _SendBox = "SendBox";
    public static final java.lang.String _ReceiveBox = "ReceiveBox";
    public static final java.lang.String _Fail = "Fail";
    public static final java.lang.String _Sending = "Sending";
    public static final MessageSqlType None = new MessageSqlType(_None);
    public static final MessageSqlType SendBox = new MessageSqlType(_SendBox);
    public static final MessageSqlType ReceiveBox = new MessageSqlType(_ReceiveBox);
    public static final MessageSqlType Fail = new MessageSqlType(_Fail);
    public static final MessageSqlType Sending = new MessageSqlType(_Sending);
    public java.lang.String getValue() { return _value_;}
    public static MessageSqlType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        MessageSqlType enumeration = (MessageSqlType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static MessageSqlType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}
    public java.lang.Object readResolve() throws java.io.ObjectStreamException { return fromValue(_value_);}
    public static org.apache.axis.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new org.apache.axis.encoding.ser.EnumSerializer(
            _javaType, _xmlType);
    }
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new org.apache.axis.encoding.ser.EnumDeserializer(
            _javaType, _xmlType);
    }
    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(MessageSqlType.class);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://beyondbit.com/smp", "MessageSqlType"));
    }
    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

}
