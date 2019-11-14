/**
 * ReportWSLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.proceedingservices;

public class ReportWSLocator extends org.apache.axis.client.Service implements com.proceedingservices.ReportWS {

    public ReportWSLocator() {
    }


    public ReportWSLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public ReportWSLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for ReportWSSoap12
    private java.lang.String ReportWSSoap12_address = "http://31.6.130.53:8088/EasyReportForWS/ReportWS.asmx";

    public java.lang.String getReportWSSoap12Address() {
        return ReportWSSoap12_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String ReportWSSoap12WSDDServiceName = "ReportWSSoap12";

    public java.lang.String getReportWSSoap12WSDDServiceName() {
        return ReportWSSoap12WSDDServiceName;
    }

    public void setReportWSSoap12WSDDServiceName(java.lang.String name) {
        ReportWSSoap12WSDDServiceName = name;
    }

    public com.proceedingservices.ReportWSSoap_PortType getReportWSSoap12() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(ReportWSSoap12_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getReportWSSoap12(endpoint);
    }

    public com.proceedingservices.ReportWSSoap_PortType getReportWSSoap12(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.proceedingservices.ReportWSSoap12Stub _stub = new com.proceedingservices.ReportWSSoap12Stub(portAddress, this);
            _stub.setPortName(getReportWSSoap12WSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setReportWSSoap12EndpointAddress(java.lang.String address) {
        ReportWSSoap12_address = address;
    }


    // Use to get a proxy class for ReportWSSoap
    private java.lang.String ReportWSSoap_address = "http://31.6.130.53:8088/EasyReportForWS/ReportWS.asmx";

    public java.lang.String getReportWSSoapAddress() {
        return ReportWSSoap_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String ReportWSSoapWSDDServiceName = "ReportWSSoap";

    public java.lang.String getReportWSSoapWSDDServiceName() {
        return ReportWSSoapWSDDServiceName;
    }

    public void setReportWSSoapWSDDServiceName(java.lang.String name) {
        ReportWSSoapWSDDServiceName = name;
    }

    public com.proceedingservices.ReportWSSoap_PortType getReportWSSoap() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(ReportWSSoap_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getReportWSSoap(endpoint);
    }

    public com.proceedingservices.ReportWSSoap_PortType getReportWSSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.proceedingservices.ReportWSSoap_BindingStub _stub = new com.proceedingservices.ReportWSSoap_BindingStub(portAddress, this);
            _stub.setPortName(getReportWSSoapWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setReportWSSoapEndpointAddress(java.lang.String address) {
        ReportWSSoap_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     * This service has multiple ports for a given interface;
     * the proxy implementation returned may be indeterminate.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.proceedingservices.ReportWSSoap_PortType.class.isAssignableFrom(serviceEndpointInterface)) {
                com.proceedingservices.ReportWSSoap12Stub _stub = new com.proceedingservices.ReportWSSoap12Stub(new java.net.URL(ReportWSSoap12_address), this);
                _stub.setPortName(getReportWSSoap12WSDDServiceName());
                return _stub;
            }
            if (com.proceedingservices.ReportWSSoap_PortType.class.isAssignableFrom(serviceEndpointInterface)) {
                com.proceedingservices.ReportWSSoap_BindingStub _stub = new com.proceedingservices.ReportWSSoap_BindingStub(new java.net.URL(ReportWSSoap_address), this);
                _stub.setPortName(getReportWSSoapWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("ReportWSSoap12".equals(inputPortName)) {
            return getReportWSSoap12();
        }
        else if ("ReportWSSoap".equals(inputPortName)) {
            return getReportWSSoap();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://tempuri.org/", "ReportWS");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://tempuri.org/", "ReportWSSoap12"));
            ports.add(new javax.xml.namespace.QName("http://tempuri.org/", "ReportWSSoap"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("ReportWSSoap12".equals(portName)) {
            setReportWSSoap12EndpointAddress(address);
        }
        else 
if ("ReportWSSoap".equals(portName)) {
            setReportWSSoapEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
