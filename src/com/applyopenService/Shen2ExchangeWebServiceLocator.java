/**
 * Shen2ExchangeWebServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.applyopenService;

public class Shen2ExchangeWebServiceLocator extends org.apache.axis.client.Service implements com.applyopenService.Shen2ExchangeWebService {

    public Shen2ExchangeWebServiceLocator() {
    }


    public Shen2ExchangeWebServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public Shen2ExchangeWebServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for Shen2ExchangeWebServicePort
    private java.lang.String Shen2ExchangeWebServicePort_address = "http://10.200.254.21:8080//spnet/Shen2ExchangeWebService";

    public java.lang.String getShen2ExchangeWebServicePortAddress() {
        return Shen2ExchangeWebServicePort_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String Shen2ExchangeWebServicePortWSDDServiceName = "Shen2ExchangeWebServicePort";

    public java.lang.String getShen2ExchangeWebServicePortWSDDServiceName() {
        return Shen2ExchangeWebServicePortWSDDServiceName;
    }

    public void setShen2ExchangeWebServicePortWSDDServiceName(java.lang.String name) {
        Shen2ExchangeWebServicePortWSDDServiceName = name;
    }

    public com.applyopenService.Shen2ExchangeWebServicePort_PortType getShen2ExchangeWebServicePort() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(Shen2ExchangeWebServicePort_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getShen2ExchangeWebServicePort(endpoint);
    }

    public com.applyopenService.Shen2ExchangeWebServicePort_PortType getShen2ExchangeWebServicePort(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.applyopenService.Shen2ExchangeWebServicePortStub _stub = new com.applyopenService.Shen2ExchangeWebServicePortStub(portAddress, this);
            _stub.setPortName(getShen2ExchangeWebServicePortWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setShen2ExchangeWebServicePortEndpointAddress(java.lang.String address) {
        Shen2ExchangeWebServicePort_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.applyopenService.Shen2ExchangeWebServicePort_PortType.class.isAssignableFrom(serviceEndpointInterface)) {
                com.applyopenService.Shen2ExchangeWebServicePortStub _stub = new com.applyopenService.Shen2ExchangeWebServicePortStub(new java.net.URL(Shen2ExchangeWebServicePort_address), this);
                _stub.setPortName(getShen2ExchangeWebServicePortWSDDServiceName());
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
        if ("Shen2ExchangeWebServicePort".equals(inputPortName)) {
            return getShen2ExchangeWebServicePort();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("shen2_spnet", "Shen2ExchangeWebService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("shen2_spnet", "Shen2ExchangeWebServicePort"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("Shen2ExchangeWebServicePort".equals(portName)) {
            setShen2ExchangeWebServicePortEndpointAddress(address);
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
