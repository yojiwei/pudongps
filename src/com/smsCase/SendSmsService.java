/**
 * SendSmsService.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.smsCase;

public interface SendSmsService extends javax.xml.rpc.Service {
    public java.lang.String getSendSmsServiceSoap12Address();

    public com.smsCase.SendSmsServiceSoap_PortType getSendSmsServiceSoap12() throws javax.xml.rpc.ServiceException;

    public com.smsCase.SendSmsServiceSoap_PortType getSendSmsServiceSoap12(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
    public java.lang.String getSendSmsServiceSoapAddress();

    public com.smsCase.SendSmsServiceSoap_PortType getSendSmsServiceSoap() throws javax.xml.rpc.ServiceException;

    public com.smsCase.SendSmsServiceSoap_PortType getSendSmsServiceSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
}
