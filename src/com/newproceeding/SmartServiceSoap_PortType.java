/**
 * SmartServiceSoap_PortType.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.newproceeding;

public interface SmartServiceSoap_PortType extends java.rmi.Remote {

    /**
     * 信息类数据接口
     */
    public java.lang.String interface_Info(java.lang.String userName, java.lang.String pwd, java.lang.String xml) throws java.rmi.RemoteException;

    /**
     * 办事类数据接口
     */
    public java.lang.String interface_Proceeding(java.lang.String userName, java.lang.String pwd, java.lang.String xml) throws java.rmi.RemoteException;

    /**
     * 互动类数据接口
     */
    public java.lang.String interface_Interact(java.lang.String userName, java.lang.String pwd, java.lang.String xml) throws java.rmi.RemoteException;
}
