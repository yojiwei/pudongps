/**
 * Web30ServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.bmwdservice;

public class Web30ServiceLocator extends org.apache.axis.client.Service implements com.bmwdservice.Web30Service {

    public Web30ServiceLocator() {
    }


    public Web30ServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public Web30ServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for Web30ServiceSoap
    private java.lang.String Web30ServiceSoap_address = "http://system.pudong.gov.cn/NewPubilshInfo/Web30Service.asmx";

    public java.lang.String getWeb30ServiceSoapAddress() {
        return Web30ServiceSoap_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String Web30ServiceSoapWSDDServiceName = "Web30ServiceSoap";

    public java.lang.String getWeb30ServiceSoapWSDDServiceName() {
        return Web30ServiceSoapWSDDServiceName;
    }

    public void setWeb30ServiceSoapWSDDServiceName(java.lang.String name) {
        Web30ServiceSoapWSDDServiceName = name;
    }

    public com.bmwdservice.Web30ServiceSoap_PortType getWeb30ServiceSoap() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(Web30ServiceSoap_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getWeb30ServiceSoap(endpoint);
    }

    public com.bmwdservice.Web30ServiceSoap_PortType getWeb30ServiceSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.bmwdservice.Web30ServiceSoap_BindingStub _stub = new com.bmwdservice.Web30ServiceSoap_BindingStub(portAddress, this);
            _stub.setPortName(getWeb30ServiceSoapWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setWeb30ServiceSoapEndpointAddress(java.lang.String address) {
        Web30ServiceSoap_address = address;
    }


    // Use to get a proxy class for Web30ServiceSoap12
    private java.lang.String Web30ServiceSoap12_address = "http://system.pudong.gov.cn/NewPubilshInfo/Web30Service.asmx";

    public java.lang.String getWeb30ServiceSoap12Address() {
        return Web30ServiceSoap12_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String Web30ServiceSoap12WSDDServiceName = "Web30ServiceSoap12";

    public java.lang.String getWeb30ServiceSoap12WSDDServiceName() {
        return Web30ServiceSoap12WSDDServiceName;
    }

    public void setWeb30ServiceSoap12WSDDServiceName(java.lang.String name) {
        Web30ServiceSoap12WSDDServiceName = name;
    }

    public com.bmwdservice.Web30ServiceSoap_PortType getWeb30ServiceSoap12() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(Web30ServiceSoap12_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getWeb30ServiceSoap12(endpoint);
    }

    public com.bmwdservice.Web30ServiceSoap_PortType getWeb30ServiceSoap12(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.bmwdservice.Web30ServiceSoap12Stub _stub = new com.bmwdservice.Web30ServiceSoap12Stub(portAddress, this);
            _stub.setPortName(getWeb30ServiceSoap12WSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setWeb30ServiceSoap12EndpointAddress(java.lang.String address) {
        Web30ServiceSoap12_address = address;
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
            if (com.bmwdservice.Web30ServiceSoap_PortType.class.isAssignableFrom(serviceEndpointInterface)) {
                com.bmwdservice.Web30ServiceSoap_BindingStub _stub = new com.bmwdservice.Web30ServiceSoap_BindingStub(new java.net.URL(Web30ServiceSoap_address), this);
                _stub.setPortName(getWeb30ServiceSoapWSDDServiceName());
                return _stub;
            }
            if (com.bmwdservice.Web30ServiceSoap_PortType.class.isAssignableFrom(serviceEndpointInterface)) {
                com.bmwdservice.Web30ServiceSoap12Stub _stub = new com.bmwdservice.Web30ServiceSoap12Stub(new java.net.URL(Web30ServiceSoap12_address), this);
                _stub.setPortName(getWeb30ServiceSoap12WSDDServiceName());
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
        if ("Web30ServiceSoap".equals(inputPortName)) {
            return getWeb30ServiceSoap();
        }
        else if ("Web30ServiceSoap12".equals(inputPortName)) {
            return getWeb30ServiceSoap12();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://tempuri.org/", "Web30Service");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://tempuri.org/", "Web30ServiceSoap"));
            ports.add(new javax.xml.namespace.QName("http://tempuri.org/", "Web30ServiceSoap12"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("Web30ServiceSoap".equals(portName)) {
            setWeb30ServiceSoapEndpointAddress(address);
        }
        else 
if ("Web30ServiceSoap12".equals(portName)) {
            setWeb30ServiceSoap12EndpointAddress(address);
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
