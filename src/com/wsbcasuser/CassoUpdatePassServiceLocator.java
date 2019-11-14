/**
 * CassoUpdatePassServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.wsbcasuser;

public class CassoUpdatePassServiceLocator extends org.apache.axis.client.Service implements com.wsbcasuser.CassoUpdatePassService {

    public CassoUpdatePassServiceLocator() {
    }


    public CassoUpdatePassServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public CassoUpdatePassServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for pdwsbupassservice
    private java.lang.String pdwsbupassservice_address = "http://localhost/axis/services/pdwsbupassservice";

    public java.lang.String getpdwsbupassserviceAddress() {
        return pdwsbupassservice_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String pdwsbupassserviceWSDDServiceName = "pdwsbupassservice";

    public java.lang.String getpdwsbupassserviceWSDDServiceName() {
        return pdwsbupassserviceWSDDServiceName;
    }

    public void setpdwsbupassserviceWSDDServiceName(java.lang.String name) {
        pdwsbupassserviceWSDDServiceName = name;
    }

    public com.wsbcasuser.CassoUpdatePass getpdwsbupassservice() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(pdwsbupassservice_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getpdwsbupassservice(endpoint);
    }

    public com.wsbcasuser.CassoUpdatePass getpdwsbupassservice(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.wsbcasuser.PdwsbupassserviceSoapBindingStub _stub = new com.wsbcasuser.PdwsbupassserviceSoapBindingStub(portAddress, this);
            _stub.setPortName(getpdwsbupassserviceWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setpdwsbupassserviceEndpointAddress(java.lang.String address) {
        pdwsbupassservice_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.wsbcasuser.CassoUpdatePass.class.isAssignableFrom(serviceEndpointInterface)) {
                com.wsbcasuser.PdwsbupassserviceSoapBindingStub _stub = new com.wsbcasuser.PdwsbupassserviceSoapBindingStub(new java.net.URL(pdwsbupassservice_address), this);
                _stub.setPortName(getpdwsbupassserviceWSDDServiceName());
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
        if ("pdwsbupassservice".equals(inputPortName)) {
            return getpdwsbupassservice();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://localhost/axis/services/pdwsbupassservice", "CassoUpdatePassService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://localhost/axis/services/pdwsbupassservice", "pdwsbupassservice"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("pdwsbupassservice".equals(portName)) {
            setpdwsbupassserviceEndpointAddress(address);
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
