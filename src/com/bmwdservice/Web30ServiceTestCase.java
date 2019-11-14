/**
 * Web30ServiceTestCase.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.bmwdservice;

public class Web30ServiceTestCase extends junit.framework.TestCase {
	
    public Web30ServiceTestCase(java.lang.String name) {
        super(name);
    }

    public void testWeb30ServiceSoapWSDL() throws Exception {
        javax.xml.rpc.ServiceFactory serviceFactory = javax.xml.rpc.ServiceFactory.newInstance();
        java.net.URL url = new java.net.URL(new com.bmwdservice.Web30ServiceLocator().getWeb30ServiceSoapAddress() + "?WSDL");
        javax.xml.rpc.Service service = serviceFactory.createService(url, new com.bmwdservice.Web30ServiceLocator().getServiceName());
        assertTrue(service != null);
    }

    public void test1Web30ServiceSoapGetInfoData() throws Exception {
        com.bmwdservice.Web30ServiceSoap_BindingStub binding;
        try {
            binding = (com.bmwdservice.Web30ServiceSoap_BindingStub)
                          new com.bmwdservice.Web30ServiceLocator().getWeb30ServiceSoap();
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
        boolean value = false;
        value = binding.getInfoData(new java.lang.String(), new java.lang.String(), new java.lang.String());
        // TBD - validate results
    }

    public void testWeb30ServiceSoap12WSDL() throws Exception {
        javax.xml.rpc.ServiceFactory serviceFactory = javax.xml.rpc.ServiceFactory.newInstance();
        java.net.URL url = new java.net.URL(new com.bmwdservice.Web30ServiceLocator().getWeb30ServiceSoap12Address() + "?WSDL");
        javax.xml.rpc.Service service = serviceFactory.createService(url, new com.bmwdservice.Web30ServiceLocator().getServiceName());
        assertTrue(service != null);
    }

    public void test2Web30ServiceSoap12GetInfoData() throws Exception {
        com.bmwdservice.Web30ServiceSoap12Stub binding;
        try {
            binding = (com.bmwdservice.Web30ServiceSoap12Stub)
                          new com.bmwdservice.Web30ServiceLocator().getWeb30ServiceSoap12();
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
        boolean value = false;
        value = binding.getInfoData(new java.lang.String(), new java.lang.String(), new java.lang.String());
        // TBD - validate results
    }
    
    /**
     * 调用浦东门户网站信息发布接口http://system.pudong.gov.cn/NewPubilshInfo/Web30Service.asmx?wsdl
     * @param messagexmls传入的XMLS
     */
    public boolean GetInfoData(String messagexmls) throws Exception {
        com.bmwdservice.Web30ServiceSoap12Stub binding;
        try {
            binding = (com.bmwdservice.Web30ServiceSoap12Stub)
                          new com.bmwdservice.Web30ServiceLocator().getWeb30ServiceSoap12();
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
        boolean value = false;
       // value = binding.getInfoData("1", "1", messagexmls);
        return value;
        // TBD - validate results
    }

}
