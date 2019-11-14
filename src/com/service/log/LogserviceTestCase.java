/**
 * LogserviceTestCase.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.service.log;

public class LogserviceTestCase extends junit.framework.TestCase {
    public LogserviceTestCase(java.lang.String name) {
        super(name);
    }

    public void testlogserviceSoapWSDL() throws Exception {
        javax.xml.rpc.ServiceFactory serviceFactory = javax.xml.rpc.ServiceFactory.newInstance();
        java.net.URL url = new java.net.URL(new com.service.log.LogserviceLocator().getlogserviceSoapAddress() + "?WSDL");
        javax.xml.rpc.Service service = serviceFactory.createService(url, new com.service.log.LogserviceLocator().getServiceName());
        assertTrue(service != null);
    }

    public void test1logserviceSoapWriteLog() throws Exception {
        com.service.log.LogserviceSoap_BindingStub binding;
        try {
            binding = (com.service.log.LogserviceSoap_BindingStub)
                          new com.service.log.LogserviceLocator().getlogserviceSoap();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        binding.writeLog(new java.lang.String(), new java.lang.String(), new java.lang.String(), new java.lang.String());
        // TBD - validate results
    }

    public void testlogserviceSoap12WSDL() throws Exception {
        javax.xml.rpc.ServiceFactory serviceFactory = javax.xml.rpc.ServiceFactory.newInstance();
        java.net.URL url = new java.net.URL(new com.service.log.LogserviceLocator().getlogserviceSoap12Address() + "?WSDL");
        javax.xml.rpc.Service service = serviceFactory.createService(url, new com.service.log.LogserviceLocator().getServiceName());
        assertTrue(service != null);
    }

    public void test2logserviceSoap12WriteLog() throws Exception {
        com.service.log.LogserviceSoap12Stub binding;
        try {
            binding = (com.service.log.LogserviceSoap12Stub)
                          new com.service.log.LogserviceLocator().getlogserviceSoap12();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        binding.writeLog(new java.lang.String(), new java.lang.String(), new java.lang.String(), new java.lang.String());
        // TBD - validate results
    }

}
