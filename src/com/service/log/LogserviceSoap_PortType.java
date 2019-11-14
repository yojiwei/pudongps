/**
 * LogserviceSoap_PortType.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.service.log;

public interface LogserviceSoap_PortType extends java.rmi.Remote {

    /**
     * levn:事件名称;description:事件描述;isSucceed:是否成功;operate:操作人ID
     */
    public void writeLog(java.lang.String levn, java.lang.String description, java.lang.String isSucceed, java.lang.String operate) throws java.rmi.RemoteException;
}
