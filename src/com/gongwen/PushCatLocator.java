/**
 * PushCatLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.gongwen;

public class PushCatLocator extends org.apache.axis.client.Service implements com.gongwen.PushCat {

    public PushCatLocator() {
    }


    public PushCatLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public PushCatLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for PushCatHttpPort
    private java.lang.String PushCatHttpPort_address = "http://10.110.41.8:8080/gwbawsdl/services/PushCat";

    public java.lang.String getPushCatHttpPortAddress() {
        return PushCatHttpPort_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String PushCatHttpPortWSDDServiceName = "PushCatHttpPort";

    public java.lang.String getPushCatHttpPortWSDDServiceName() {
        return PushCatHttpPortWSDDServiceName;
    }

    public void setPushCatHttpPortWSDDServiceName(java.lang.String name) {
        PushCatHttpPortWSDDServiceName = name;
    }

    public com.gongwen.PushCatPortType getPushCatHttpPort() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(PushCatHttpPort_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getPushCatHttpPort(endpoint);
    }

    public com.gongwen.PushCatPortType getPushCatHttpPort(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.gongwen.PushCatHttpBindingStub _stub = new com.gongwen.PushCatHttpBindingStub(portAddress, this);
            _stub.setPortName(getPushCatHttpPortWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setPushCatHttpPortEndpointAddress(java.lang.String address) {
        PushCatHttpPort_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.gongwen.PushCatPortType.class.isAssignableFrom(serviceEndpointInterface)) {
                com.gongwen.PushCatHttpBindingStub _stub = new com.gongwen.PushCatHttpBindingStub(new java.net.URL(PushCatHttpPort_address), this);
                _stub.setPortName(getPushCatHttpPortWSDDServiceName());
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
        if ("PushCatHttpPort".equals(inputPortName)) {
            return getPushCatHttpPort();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://gwba.baosight.com", "PushCat");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://gwba.baosight.com", "PushCatHttpPort"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("PushCatHttpPort".equals(portName)) {
            setPushCatHttpPortEndpointAddress(address);
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
