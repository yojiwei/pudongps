/**
 * SmartServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.newproceeding;

public class SmartServiceLocator extends org.apache.axis.client.Service implements com.newproceeding.SmartService {

    public SmartServiceLocator() {
    }


    public SmartServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public SmartServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for SmartServiceSoap
    private java.lang.String SmartServiceSoap_address = "http://192.168.152.221/WebService/SmartService.asmx";

    public java.lang.String getSmartServiceSoapAddress() {
        return SmartServiceSoap_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String SmartServiceSoapWSDDServiceName = "SmartServiceSoap";

    public java.lang.String getSmartServiceSoapWSDDServiceName() {
        return SmartServiceSoapWSDDServiceName;
    }

    public void setSmartServiceSoapWSDDServiceName(java.lang.String name) {
        SmartServiceSoapWSDDServiceName = name;
    }

    public com.newproceeding.SmartServiceSoap_PortType getSmartServiceSoap() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(SmartServiceSoap_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getSmartServiceSoap(endpoint);
    }

    public com.newproceeding.SmartServiceSoap_PortType getSmartServiceSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.newproceeding.SmartServiceSoap_BindingStub _stub = new com.newproceeding.SmartServiceSoap_BindingStub(portAddress, this);
            _stub.setPortName(getSmartServiceSoapWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setSmartServiceSoapEndpointAddress(java.lang.String address) {
        SmartServiceSoap_address = address;
    }


    // Use to get a proxy class for SmartServiceSoap12
    private java.lang.String SmartServiceSoap12_address = "http://192.168.152.221/WebService/SmartService.asmx";

    public java.lang.String getSmartServiceSoap12Address() {
        return SmartServiceSoap12_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String SmartServiceSoap12WSDDServiceName = "SmartServiceSoap12";

    public java.lang.String getSmartServiceSoap12WSDDServiceName() {
        return SmartServiceSoap12WSDDServiceName;
    }

    public void setSmartServiceSoap12WSDDServiceName(java.lang.String name) {
        SmartServiceSoap12WSDDServiceName = name;
    }

    public com.newproceeding.SmartServiceSoap_PortType getSmartServiceSoap12() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(SmartServiceSoap12_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getSmartServiceSoap12(endpoint);
    }

    public com.newproceeding.SmartServiceSoap_PortType getSmartServiceSoap12(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.newproceeding.SmartServiceSoap12Stub _stub = new com.newproceeding.SmartServiceSoap12Stub(portAddress, this);
            _stub.setPortName(getSmartServiceSoap12WSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setSmartServiceSoap12EndpointAddress(java.lang.String address) {
        SmartServiceSoap12_address = address;
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
            if (com.newproceeding.SmartServiceSoap_PortType.class.isAssignableFrom(serviceEndpointInterface)) {
                com.newproceeding.SmartServiceSoap_BindingStub _stub = new com.newproceeding.SmartServiceSoap_BindingStub(new java.net.URL(SmartServiceSoap_address), this);
                _stub.setPortName(getSmartServiceSoapWSDDServiceName());
                return _stub;
            }
            if (com.newproceeding.SmartServiceSoap_PortType.class.isAssignableFrom(serviceEndpointInterface)) {
                com.newproceeding.SmartServiceSoap12Stub _stub = new com.newproceeding.SmartServiceSoap12Stub(new java.net.URL(SmartServiceSoap12_address), this);
                _stub.setPortName(getSmartServiceSoap12WSDDServiceName());
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
        if ("SmartServiceSoap".equals(inputPortName)) {
            return getSmartServiceSoap();
        }
        else if ("SmartServiceSoap12".equals(inputPortName)) {
            return getSmartServiceSoap12();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://tempuri.org/", "SmartService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://tempuri.org/", "SmartServiceSoap"));
            ports.add(new javax.xml.namespace.QName("http://tempuri.org/", "SmartServiceSoap12"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("SmartServiceSoap".equals(portName)) {
            setSmartServiceSoapEndpointAddress(address);
        }
        else 
if ("SmartServiceSoap12".equals(portName)) {
            setSmartServiceSoap12EndpointAddress(address);
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
