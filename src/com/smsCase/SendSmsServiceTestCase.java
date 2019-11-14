/**
 * SendSmsServiceTestCase.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.smsCase;

public class SendSmsServiceTestCase extends junit.framework.TestCase {
    public SendSmsServiceTestCase(java.lang.String name) {
        super(name);
    }

    public void testSendSmsServiceSoap12WSDL() throws Exception {
        javax.xml.rpc.ServiceFactory serviceFactory = javax.xml.rpc.ServiceFactory.newInstance();
        java.net.URL url = new java.net.URL(new com.smsCase.SendSmsServiceLocator().getSendSmsServiceSoap12Address() + "?WSDL");
        javax.xml.rpc.Service service = serviceFactory.createService(url, new com.smsCase.SendSmsServiceLocator().getServiceName());
        assertTrue(service != null);
    }

    public void test1SendSmsServiceSoap12SendSms() throws Exception {
        com.smsCase.SendSmsServiceSoap12Stub binding;
        try {
            binding = (com.smsCase.SendSmsServiceSoap12Stub)
                          new com.smsCase.SendSmsServiceLocator().getSendSmsServiceSoap12();
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
        value = binding.sendSms(new java.lang.String(), new java.lang.String(), new java.lang.String());
        // TBD - validate results
    }

    public void test2SendSmsServiceSoap12SendSmsDelay() throws Exception {
        com.smsCase.SendSmsServiceSoap12Stub binding;
        try {
            binding = (com.smsCase.SendSmsServiceSoap12Stub)
                          new com.smsCase.SendSmsServiceLocator().getSendSmsServiceSoap12();
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
        value = binding.sendSmsDelay(new java.lang.String(), new java.lang.String(), new java.lang.String(), java.util.Calendar.getInstance());
        // TBD - validate results
    }

    public void test3SendSmsServiceSoap12CancelDelaySms() throws Exception {
        com.smsCase.SendSmsServiceSoap12Stub binding;
        try {
            binding = (com.smsCase.SendSmsServiceSoap12Stub)
                          new com.smsCase.SendSmsServiceLocator().getSendSmsServiceSoap12();
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
        value = binding.cancelDelaySms(new java.lang.String(), new java.lang.String());
        // TBD - validate results
    }

    public void testSendSmsServiceSoapWSDL() throws Exception {
        javax.xml.rpc.ServiceFactory serviceFactory = javax.xml.rpc.ServiceFactory.newInstance();
        java.net.URL url = new java.net.URL(new com.smsCase.SendSmsServiceLocator().getSendSmsServiceSoapAddress() + "?WSDL");
        javax.xml.rpc.Service service = serviceFactory.createService(url, new com.smsCase.SendSmsServiceLocator().getServiceName());
        assertTrue(service != null);
    }

    public void test4SendSmsServiceSoapSendSms() throws Exception {
        com.smsCase.SendSmsServiceSoap_BindingStub binding;
        try {
            binding = (com.smsCase.SendSmsServiceSoap_BindingStub)
                          new com.smsCase.SendSmsServiceLocator().getSendSmsServiceSoap();
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
        value = binding.sendSms(new java.lang.String(), new java.lang.String(), new java.lang.String());
        // TBD - validate results
    }

    public void test5SendSmsServiceSoapSendSmsDelay() throws Exception {
        com.smsCase.SendSmsServiceSoap_BindingStub binding;
        try {
            binding = (com.smsCase.SendSmsServiceSoap_BindingStub)
                          new com.smsCase.SendSmsServiceLocator().getSendSmsServiceSoap();
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
        value = binding.sendSmsDelay(new java.lang.String(), new java.lang.String(), new java.lang.String(), java.util.Calendar.getInstance());
        // TBD - validate results
    }

    public void test6SendSmsServiceSoapCancelDelaySms() throws Exception {
        com.smsCase.SendSmsServiceSoap_BindingStub binding;
        try {
            binding = (com.smsCase.SendSmsServiceSoap_BindingStub)
                          new com.smsCase.SendSmsServiceLocator().getSendSmsServiceSoap();
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
        value = binding.cancelDelaySms(new java.lang.String(), new java.lang.String());
        // TBD - validate results
    }

}
