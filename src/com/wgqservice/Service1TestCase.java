/**
 * Service1TestCase.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.wgqservice;

public class Service1TestCase extends junit.framework.TestCase {
    public Service1TestCase(java.lang.String name) {
        super(name);
    }

    public void testService1Soap12WSDL() throws Exception {
        javax.xml.rpc.ServiceFactory serviceFactory = javax.xml.rpc.ServiceFactory.newInstance();
        java.net.URL url = new java.net.URL(new com.wgqservice.Service1Locator().getService1Soap12Address() + "?WSDL");
        javax.xml.rpc.Service service = serviceFactory.createService(url, new com.wgqservice.Service1Locator().getServiceName());
        assertTrue(service != null);
    }

    public void test1Service1Soap12Intergrade() throws Exception {
        com.wgqservice.Service1Soap12Stub binding;
        try {
            binding = (com.wgqservice.Service1Soap12Stub)
                          new com.wgqservice.Service1Locator().getService1Soap12();
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
        java.lang.String value = null;
        value = binding.intergrade(new java.lang.String(), new java.lang.String(), new java.lang.String(), new java.lang.String());
        // TBD - validate results
    }

    public void testService1SoapWSDL() throws Exception {
        javax.xml.rpc.ServiceFactory serviceFactory = javax.xml.rpc.ServiceFactory.newInstance();
        java.net.URL url = new java.net.URL(new com.wgqservice.Service1Locator().getService1SoapAddress() + "?WSDL");
        javax.xml.rpc.Service service = serviceFactory.createService(url, new com.wgqservice.Service1Locator().getServiceName());
        assertTrue(service != null);
    }

    public void test2Service1SoapIntergrade() throws Exception {
        com.wgqservice.Service1Soap_BindingStub binding;
        try {
            binding = (com.wgqservice.Service1Soap_BindingStub)
                          new com.wgqservice.Service1Locator().getService1Soap();
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
        java.lang.String value = null;
        value = binding.intergrade(new java.lang.String(), new java.lang.String(), new java.lang.String(), new java.lang.String());
        // TBD - validate results
    }

}
