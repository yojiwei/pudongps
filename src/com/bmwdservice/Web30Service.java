/**
 * Web30Service.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.bmwdservice;

public interface Web30Service extends javax.xml.rpc.Service {
    public java.lang.String getWeb30ServiceSoapAddress();

    public com.bmwdservice.Web30ServiceSoap_PortType getWeb30ServiceSoap() throws javax.xml.rpc.ServiceException;

    public com.bmwdservice.Web30ServiceSoap_PortType getWeb30ServiceSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
    public java.lang.String getWeb30ServiceSoap12Address();

    public com.bmwdservice.Web30ServiceSoap_PortType getWeb30ServiceSoap12() throws javax.xml.rpc.ServiceException;

    public com.bmwdservice.Web30ServiceSoap_PortType getWeb30ServiceSoap12(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
}
