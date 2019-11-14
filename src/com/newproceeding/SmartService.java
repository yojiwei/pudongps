/**
 * SmartService.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.newproceeding;

public interface SmartService extends javax.xml.rpc.Service {
    public java.lang.String getSmartServiceSoapAddress();

    public com.newproceeding.SmartServiceSoap_PortType getSmartServiceSoap() throws javax.xml.rpc.ServiceException;

    public com.newproceeding.SmartServiceSoap_PortType getSmartServiceSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
    public java.lang.String getSmartServiceSoap12Address();

    public com.newproceeding.SmartServiceSoap_PortType getSmartServiceSoap12() throws javax.xml.rpc.ServiceException;

    public com.newproceeding.SmartServiceSoap_PortType getSmartServiceSoap12(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
}
