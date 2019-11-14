/**
 * ReportWSTestCase.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.proceedingservices;

public class ReportWSTestCase extends junit.framework.TestCase {
    public ReportWSTestCase(java.lang.String name) {
        super(name);
    }

    public void testReportWSSoap12WSDL() throws Exception {
        javax.xml.rpc.ServiceFactory serviceFactory = javax.xml.rpc.ServiceFactory.newInstance();
        java.net.URL url = new java.net.URL(new com.proceedingservices.ReportWSLocator().getReportWSSoap12Address() + "?WSDL");
        javax.xml.rpc.Service service = serviceFactory.createService(url, new com.proceedingservices.ReportWSLocator().getServiceName());
        assertTrue(service != null);
    }

    public void test1ReportWSSoap12GetAllReportList() throws Exception {
        com.proceedingservices.ReportWSSoap12Stub binding;
        try {
            binding = (com.proceedingservices.ReportWSSoap12Stub)
                          new com.proceedingservices.ReportWSLocator().getReportWSSoap12();
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
        value = binding.getAllReportList();
        // TBD - validate results
    }

    public void testReportWSSoapWSDL() throws Exception {
        javax.xml.rpc.ServiceFactory serviceFactory = javax.xml.rpc.ServiceFactory.newInstance();
        java.net.URL url = new java.net.URL(new com.proceedingservices.ReportWSLocator().getReportWSSoapAddress() + "?WSDL");
        javax.xml.rpc.Service service = serviceFactory.createService(url, new com.proceedingservices.ReportWSLocator().getServiceName());
        assertTrue(service != null);
    }

    public void test2ReportWSSoapGetAllReportList() throws Exception {
        com.proceedingservices.ReportWSSoap_BindingStub binding;
        try {
            binding = (com.proceedingservices.ReportWSSoap_BindingStub)
                          new com.proceedingservices.ReportWSLocator().getReportWSSoap();
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
        value = binding.getAllReportList();
        // TBD - validate results
    }

}
