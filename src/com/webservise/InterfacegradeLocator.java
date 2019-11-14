/**
 * InterfacegradeLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.webservise;

public class InterfacegradeLocator extends org.apache.axis.client.Service implements com.webservise.Interfacegrade {

    public InterfacegradeLocator() {
    }


    public InterfacegradeLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public InterfacegradeLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for interfacegradeSoap12
    //private java.lang.String interfacegradeSoap12_address = "http://31.6.130.53/CriterionFile/interfacegrade.asmx";
    
    private java.lang.String interfacegradeSoap12_address = "http://system.pudong.gov.cn/CriterionFile/interfacegrade.asmx";

    public java.lang.String getinterfacegradeSoap12Address() {
        return interfacegradeSoap12_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String interfacegradeSoap12WSDDServiceName = "interfacegradeSoap12";

    public java.lang.String getinterfacegradeSoap12WSDDServiceName() {
        return interfacegradeSoap12WSDDServiceName;
    }

    public void setinterfacegradeSoap12WSDDServiceName(java.lang.String name) {
        interfacegradeSoap12WSDDServiceName = name;
    }

    public com.webservise.InterfacegradeSoap_PortType getinterfacegradeSoap12() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(interfacegradeSoap12_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getinterfacegradeSoap12(endpoint);
    }

    public com.webservise.InterfacegradeSoap_PortType getinterfacegradeSoap12(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.webservise.InterfacegradeSoap12Stub _stub = new com.webservise.InterfacegradeSoap12Stub(portAddress, this);
            _stub.setPortName(getinterfacegradeSoap12WSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setinterfacegradeSoap12EndpointAddress(java.lang.String address) {
        interfacegradeSoap12_address = address;
    }


    // Use to get a proxy class for interfacegradeSoap
    private java.lang.String interfacegradeSoap_address = "http://system.pudong.gov.cn/CriterionFile/interfacegrade.asmx";

    public java.lang.String getinterfacegradeSoapAddress() {
        return interfacegradeSoap_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String interfacegradeSoapWSDDServiceName = "interfacegradeSoap";

    public java.lang.String getinterfacegradeSoapWSDDServiceName() {
        return interfacegradeSoapWSDDServiceName;
    }

    public void setinterfacegradeSoapWSDDServiceName(java.lang.String name) {
        interfacegradeSoapWSDDServiceName = name;
    }

    public com.webservise.InterfacegradeSoap_PortType getinterfacegradeSoap() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(interfacegradeSoap_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getinterfacegradeSoap(endpoint);
    }

    public com.webservise.InterfacegradeSoap_PortType getinterfacegradeSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.webservise.InterfacegradeSoap_BindingStub _stub = new com.webservise.InterfacegradeSoap_BindingStub(portAddress, this);
            _stub.setPortName(getinterfacegradeSoapWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setinterfacegradeSoapEndpointAddress(java.lang.String address) {
        interfacegradeSoap_address = address;
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
            if (com.webservise.InterfacegradeSoap_PortType.class.isAssignableFrom(serviceEndpointInterface)) {
                com.webservise.InterfacegradeSoap12Stub _stub = new com.webservise.InterfacegradeSoap12Stub(new java.net.URL(interfacegradeSoap12_address), this);
                _stub.setPortName(getinterfacegradeSoap12WSDDServiceName());
                return _stub;
            }
            if (com.webservise.InterfacegradeSoap_PortType.class.isAssignableFrom(serviceEndpointInterface)) {
                com.webservise.InterfacegradeSoap_BindingStub _stub = new com.webservise.InterfacegradeSoap_BindingStub(new java.net.URL(interfacegradeSoap_address), this);
                _stub.setPortName(getinterfacegradeSoapWSDDServiceName());
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
        if ("interfacegradeSoap12".equals(inputPortName)) {
            return getinterfacegradeSoap12();
        }
        else if ("interfacegradeSoap".equals(inputPortName)) {
            return getinterfacegradeSoap();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://tempuri.org/", "interfacegrade");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://tempuri.org/", "interfacegradeSoap12"));
            ports.add(new javax.xml.namespace.QName("http://tempuri.org/", "interfacegradeSoap"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("interfacegradeSoap12".equals(portName)) {
            setinterfacegradeSoap12EndpointAddress(address);
        }
        else 
if ("interfacegradeSoap".equals(portName)) {
            setinterfacegradeSoapEndpointAddress(address);
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
