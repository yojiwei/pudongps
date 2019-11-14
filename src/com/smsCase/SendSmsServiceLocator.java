/**
 * SendSmsServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.smsCase;

public class SendSmsServiceLocator extends org.apache.axis.client.Service implements com.smsCase.SendSmsService {

    public SendSmsServiceLocator() {
    }


    public SendSmsServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public SendSmsServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for SendSmsServiceSoap12
    private java.lang.String SendSmsServiceSoap12_address = "http://sms.pudong.sh/SmsWebservice/SendSmsService.asmx";

    public java.lang.String getSendSmsServiceSoap12Address() {
        return SendSmsServiceSoap12_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String SendSmsServiceSoap12WSDDServiceName = "SendSmsServiceSoap12";

    public java.lang.String getSendSmsServiceSoap12WSDDServiceName() {
        return SendSmsServiceSoap12WSDDServiceName;
    }

    public void setSendSmsServiceSoap12WSDDServiceName(java.lang.String name) {
        SendSmsServiceSoap12WSDDServiceName = name;
    }

    public com.smsCase.SendSmsServiceSoap_PortType getSendSmsServiceSoap12() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(SendSmsServiceSoap12_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getSendSmsServiceSoap12(endpoint);
    }

    public com.smsCase.SendSmsServiceSoap_PortType getSendSmsServiceSoap12(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.smsCase.SendSmsServiceSoap12Stub _stub = new com.smsCase.SendSmsServiceSoap12Stub(portAddress, this);
            _stub.setPortName(getSendSmsServiceSoap12WSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setSendSmsServiceSoap12EndpointAddress(java.lang.String address) {
        SendSmsServiceSoap12_address = address;
    }


    // Use to get a proxy class for SendSmsServiceSoap
    private java.lang.String SendSmsServiceSoap_address = "http://sms.pudong.sh/SmsWebservice/SendSmsService.asmx";

    public java.lang.String getSendSmsServiceSoapAddress() {
        return SendSmsServiceSoap_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String SendSmsServiceSoapWSDDServiceName = "SendSmsServiceSoap";

    public java.lang.String getSendSmsServiceSoapWSDDServiceName() {
        return SendSmsServiceSoapWSDDServiceName;
    }

    public void setSendSmsServiceSoapWSDDServiceName(java.lang.String name) {
        SendSmsServiceSoapWSDDServiceName = name;
    }

    public com.smsCase.SendSmsServiceSoap_PortType getSendSmsServiceSoap() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(SendSmsServiceSoap_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getSendSmsServiceSoap(endpoint);
    }

    public com.smsCase.SendSmsServiceSoap_PortType getSendSmsServiceSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.smsCase.SendSmsServiceSoap_BindingStub _stub = new com.smsCase.SendSmsServiceSoap_BindingStub(portAddress, this);
            _stub.setPortName(getSendSmsServiceSoapWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setSendSmsServiceSoapEndpointAddress(java.lang.String address) {
        SendSmsServiceSoap_address = address;
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
            if (com.smsCase.SendSmsServiceSoap_PortType.class.isAssignableFrom(serviceEndpointInterface)) {
                com.smsCase.SendSmsServiceSoap12Stub _stub = new com.smsCase.SendSmsServiceSoap12Stub(new java.net.URL(SendSmsServiceSoap12_address), this);
                _stub.setPortName(getSendSmsServiceSoap12WSDDServiceName());
                return _stub;
            }
            if (com.smsCase.SendSmsServiceSoap_PortType.class.isAssignableFrom(serviceEndpointInterface)) {
                com.smsCase.SendSmsServiceSoap_BindingStub _stub = new com.smsCase.SendSmsServiceSoap_BindingStub(new java.net.URL(SendSmsServiceSoap_address), this);
                _stub.setPortName(getSendSmsServiceSoapWSDDServiceName());
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
        if ("SendSmsServiceSoap12".equals(inputPortName)) {
            return getSendSmsServiceSoap12();
        }
        else if ("SendSmsServiceSoap".equals(inputPortName)) {
            return getSendSmsServiceSoap();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://tempuri.org/", "SendSmsService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://tempuri.org/", "SendSmsServiceSoap12"));
            ports.add(new javax.xml.namespace.QName("http://tempuri.org/", "SendSmsServiceSoap"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("SendSmsServiceSoap12".equals(portName)) {
            setSendSmsServiceSoap12EndpointAddress(address);
        }
        else 
if ("SendSmsServiceSoap".equals(portName)) {
            setSendSmsServiceSoapEndpointAddress(address);
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
