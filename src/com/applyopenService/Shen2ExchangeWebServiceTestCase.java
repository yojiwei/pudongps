/**
 * Shen2ExchangeWebServiceTestCase.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.applyopenService;

public class Shen2ExchangeWebServiceTestCase extends junit.framework.TestCase {
    public Shen2ExchangeWebServiceTestCase(java.lang.String name) {
        super(name);
    }

    public void testShen2ExchangeWebServicePortWSDL() throws Exception {
        javax.xml.rpc.ServiceFactory serviceFactory = javax.xml.rpc.ServiceFactory.newInstance();
        java.net.URL url = new java.net.URL(new com.applyopenService.Shen2ExchangeWebServiceLocator().getShen2ExchangeWebServicePortAddress() + "?WSDL");
        javax.xml.rpc.Service service = serviceFactory.createService(url, new com.applyopenService.Shen2ExchangeWebServiceLocator().getServiceName());
        assertTrue(service != null);
    }

    public void test1Shen2ExchangeWebServicePortGetInfo() throws Exception {
        com.applyopenService.Shen2ExchangeWebServicePortStub binding;
        try {
            binding = (com.applyopenService.Shen2ExchangeWebServicePortStub)
                          new com.applyopenService.Shen2ExchangeWebServiceLocator().getShen2ExchangeWebServicePort();
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
        value = binding.getInfo(new java.lang.String(), new java.lang.String(), new java.lang.String());
        // TBD - validate results
    }

    public void test2Shen2ExchangeWebServicePortReply() throws Exception {
        com.applyopenService.Shen2ExchangeWebServicePortStub binding;
        try {
            binding = (com.applyopenService.Shen2ExchangeWebServicePortStub)
                          new com.applyopenService.Shen2ExchangeWebServiceLocator().getShen2ExchangeWebServicePort();
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
        value = binding.reply(new java.lang.String(), new java.lang.String(), new java.lang.String(), new java.lang.String());
        // TBD - validate results
    }

    public void test3Shen2ExchangeWebServicePortAddInfo() throws Exception {
        com.applyopenService.Shen2ExchangeWebServicePortStub binding;
        try {
            binding = (com.applyopenService.Shen2ExchangeWebServicePortStub)
                          new com.applyopenService.Shen2ExchangeWebServiceLocator().getShen2ExchangeWebServicePort();
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
        value = binding.addInfo(new java.lang.String(), new java.lang.String(), new java.lang.String(), new java.lang.String());
        // TBD - validate results
    }

    public void test4Shen2ExchangeWebServicePortGetInfoFromWS() throws Exception {
        com.applyopenService.Shen2ExchangeWebServicePortStub binding;
        try {
            binding = (com.applyopenService.Shen2ExchangeWebServicePortStub)
                          new com.applyopenService.Shen2ExchangeWebServiceLocator().getShen2ExchangeWebServicePort();
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
        value = binding.getInfoFromWS(new java.lang.String(), new java.lang.String(), new java.lang.String(), new java.lang.String());
        // TBD - validate results
    }

    public void test5Shen2ExchangeWebServicePortReplyFromWS() throws Exception {
        com.applyopenService.Shen2ExchangeWebServicePortStub binding;
        try {
            binding = (com.applyopenService.Shen2ExchangeWebServicePortStub)
                          new com.applyopenService.Shen2ExchangeWebServiceLocator().getShen2ExchangeWebServicePort();
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
        value = binding.replyFromWS(new java.lang.String(), new java.lang.String(), new java.lang.String(), new java.lang.String());
        // TBD - validate results
    }

    public void test6Shen2ExchangeWebServicePortAddInfoFromWS() throws Exception {
        com.applyopenService.Shen2ExchangeWebServicePortStub binding;
        try {
            binding = (com.applyopenService.Shen2ExchangeWebServicePortStub)
                          new com.applyopenService.Shen2ExchangeWebServiceLocator().getShen2ExchangeWebServicePort();
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
        value = binding.addInfoFromWS(new java.lang.String(), new java.lang.String(), new java.lang.String(), new java.lang.String());
        // TBD - validate results
    }

    public void test7Shen2ExchangeWebServicePortStat() throws Exception {
        com.applyopenService.Shen2ExchangeWebServicePortStub binding;
        try {
            binding = (com.applyopenService.Shen2ExchangeWebServicePortStub)
                          new com.applyopenService.Shen2ExchangeWebServiceLocator().getShen2ExchangeWebServicePort();
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
        value = binding.stat(new java.lang.String(), new java.lang.String(), new java.lang.String(), new java.lang.String());
        // TBD - validate results
    }

}
