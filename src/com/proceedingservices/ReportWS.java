/**
 * ReportWS.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.proceedingservices;

public interface ReportWS extends javax.xml.rpc.Service {
    public java.lang.String getReportWSSoap12Address();

    public com.proceedingservices.ReportWSSoap_PortType getReportWSSoap12() throws javax.xml.rpc.ServiceException;

    public com.proceedingservices.ReportWSSoap_PortType getReportWSSoap12(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
    public java.lang.String getReportWSSoapAddress();

    public com.proceedingservices.ReportWSSoap_PortType getReportWSSoap() throws javax.xml.rpc.ServiceException;

    public com.proceedingservices.ReportWSSoap_PortType getReportWSSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException;
}
