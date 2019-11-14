/**
 * LogserviceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.service.log;

public class LogserviceLocator extends org.apache.axis.client.Service implements com.service.log.Logservice {

    public LogserviceLocator() {
    }


    public LogserviceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public LogserviceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for logserviceSoap
    private java.lang.String logserviceSoap_address = "http://system.pudong.gov.cn/WebAdmin/webinterface/logservice.asmx";

    public java.lang.String getlogserviceSoapAddress() {
        return logserviceSoap_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String logserviceSoapWSDDServiceName = "logserviceSoap";

    public java.lang.String getlogserviceSoapWSDDServiceName() {
        return logserviceSoapWSDDServiceName;
    }

    public void setlogserviceSoapWSDDServiceName(java.lang.String name) {
        logserviceSoapWSDDServiceName = name;
    }

    public com.service.log.LogserviceSoap_PortType getlogserviceSoap() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(logserviceSoap_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getlogserviceSoap(endpoint);
    }

    public com.service.log.LogserviceSoap_PortType getlogserviceSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.service.log.LogserviceSoap_BindingStub _stub = new com.service.log.LogserviceSoap_BindingStub(portAddress, this);
            _stub.setPortName(getlogserviceSoapWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setlogserviceSoapEndpointAddress(java.lang.String address) {
        logserviceSoap_address = address;
    }


    // Use to get a proxy class for logserviceSoap12
    private java.lang.String logserviceSoap12_address = "http://system.pudong.gov.cn/WebAdmin/webinterface/logservice.asmx";

    public java.lang.String getlogserviceSoap12Address() {
        return logserviceSoap12_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String logserviceSoap12WSDDServiceName = "logserviceSoap12";

    public java.lang.String getlogserviceSoap12WSDDServiceName() {
        return logserviceSoap12WSDDServiceName;
    }

    public void setlogserviceSoap12WSDDServiceName(java.lang.String name) {
        logserviceSoap12WSDDServiceName = name;
    }

    public com.service.log.LogserviceSoap_PortType getlogserviceSoap12() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(logserviceSoap12_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getlogserviceSoap12(endpoint);
    }

    public com.service.log.LogserviceSoap_PortType getlogserviceSoap12(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.service.log.LogserviceSoap12Stub _stub = new com.service.log.LogserviceSoap12Stub(portAddress, this);
            _stub.setPortName(getlogserviceSoap12WSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setlogserviceSoap12EndpointAddress(java.lang.String address) {
        logserviceSoap12_address = address;
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
            if (com.service.log.LogserviceSoap_PortType.class.isAssignableFrom(serviceEndpointInterface)) {
                com.service.log.LogserviceSoap_BindingStub _stub = new com.service.log.LogserviceSoap_BindingStub(new java.net.URL(logserviceSoap_address), this);
                _stub.setPortName(getlogserviceSoapWSDDServiceName());
                return _stub;
            }
            if (com.service.log.LogserviceSoap_PortType.class.isAssignableFrom(serviceEndpointInterface)) {
                com.service.log.LogserviceSoap12Stub _stub = new com.service.log.LogserviceSoap12Stub(new java.net.URL(logserviceSoap12_address), this);
                _stub.setPortName(getlogserviceSoap12WSDDServiceName());
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
        if ("logserviceSoap".equals(inputPortName)) {
            return getlogserviceSoap();
        }
        else if ("logserviceSoap12".equals(inputPortName)) {
            return getlogserviceSoap12();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://tempuri.org/", "logservice");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://tempuri.org/", "logserviceSoap"));
            ports.add(new javax.xml.namespace.QName("http://tempuri.org/", "logserviceSoap12"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("logserviceSoap".equals(portName)) {
            setlogserviceSoapEndpointAddress(address);
        }
        else 
if ("logserviceSoap12".equals(portName)) {
            setlogserviceSoap12EndpointAddress(address);
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
