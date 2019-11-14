/**
 * PushStat.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.openList;

public interface PushStat extends javax.xml.rpc.Service {
    public java.lang.String getPushStatHttpPortAddress();

    public com.openList.PushStatPortType getPushStatHttpPort() throws javax.xml.rpc.ServiceException;

    public com.openList.PushStatPortType getPushStatHttpPort(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
}
