/**
 * PushCat.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.gongwen;

public interface PushCat extends javax.xml.rpc.Service {
    public java.lang.String getPushCatHttpPortAddress();

    public com.gongwen.PushCatPortType getPushCatHttpPort() throws javax.xml.rpc.ServiceException;

    public com.gongwen.PushCatPortType getPushCatHttpPort(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
}
