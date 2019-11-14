/**
 * PushStatLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.openList;

public class PushStatLocator extends org.apache.axis.client.Service implements com.openList.PushStat {

    public PushStatLocator() {
    }


    public PushStatLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public PushStatLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for PushStatHttpPort
    private java.lang.String PushStatHttpPort_address = "http://10.110.41.8:8080/gwbawsdl/services/PushStat";

    public java.lang.String getPushStatHttpPortAddress() {
        return PushStatHttpPort_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String PushStatHttpPortWSDDServiceName = "PushStatHttpPort";

    public java.lang.String getPushStatHttpPortWSDDServiceName() {
        return PushStatHttpPortWSDDServiceName;
    }

    public void setPushStatHttpPortWSDDServiceName(java.lang.String name) {
        PushStatHttpPortWSDDServiceName = name;
    }

    public com.openList.PushStatPortType getPushStatHttpPort() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(PushStatHttpPort_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getPushStatHttpPort(endpoint);
    }

    public com.openList.PushStatPortType getPushStatHttpPort(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.openList.PushStatHttpBindingStub _stub = new com.openList.PushStatHttpBindingStub(portAddress, this);
            _stub.setPortName(getPushStatHttpPortWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setPushStatHttpPortEndpointAddress(java.lang.String address) {
        PushStatHttpPort_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.openList.PushStatPortType.class.isAssignableFrom(serviceEndpointInterface)) {
                com.openList.PushStatHttpBindingStub _stub = new com.openList.PushStatHttpBindingStub(new java.net.URL(PushStatHttpPort_address), this);
                _stub.setPortName(getPushStatHttpPortWSDDServiceName());
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
        if ("PushStatHttpPort".equals(inputPortName)) {
            return getPushStatHttpPort();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://gwba.baosight.com", "PushStat");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://gwba.baosight.com", "PushStatHttpPort"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("PushStatHttpPort".equals(portName)) {
            setPushStatHttpPortEndpointAddress(address);
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
