/**
 * Logservice.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.service.log;

public interface Logservice extends javax.xml.rpc.Service {
    public java.lang.String getlogserviceSoapAddress();

    public com.service.log.LogserviceSoap_PortType getlogserviceSoap() throws javax.xml.rpc.ServiceException;

    public com.service.log.LogserviceSoap_PortType getlogserviceSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
    public java.lang.String getlogserviceSoap12Address();

    public com.service.log.LogserviceSoap_PortType getlogserviceSoap12() throws javax.xml.rpc.ServiceException;

    public com.service.log.LogserviceSoap_PortType getlogserviceSoap12(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
}
