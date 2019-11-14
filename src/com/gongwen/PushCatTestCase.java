/**
 * PushCatTestCase.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.gongwen;

public class PushCatTestCase extends junit.framework.TestCase {
    public PushCatTestCase(java.lang.String name) {
        super(name);
    }

    public void testPushCatHttpPortWSDL() throws Exception {
        javax.xml.rpc.ServiceFactory serviceFactory = javax.xml.rpc.ServiceFactory.newInstance();
        java.net.URL url = new java.net.URL(new com.gongwen.PushCatLocator().getPushCatHttpPortAddress() + "?WSDL");
        javax.xml.rpc.Service service = serviceFactory.createService(url, new com.gongwen.PushCatLocator().getServiceName());
        assertTrue(service != null);
    }

    public void test1PushCatHttpPortPushCat() throws Exception {
        com.gongwen.PushCatHttpBindingStub binding;
        try {
            binding = (com.gongwen.PushCatHttpBindingStub)
                          new com.gongwen.PushCatLocator().getPushCatHttpPort();
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
        value = binding.pushCat(new java.lang.String());
        // TBD - validate results
    }

}
