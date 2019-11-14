/**
 * PushStatTestCase.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.openList;

public class PushStatTestCase extends junit.framework.TestCase {
    public PushStatTestCase(java.lang.String name) {
        super(name);
    }

    public void testPushStatHttpPortWSDL() throws Exception {
        javax.xml.rpc.ServiceFactory serviceFactory = javax.xml.rpc.ServiceFactory.newInstance();
        java.net.URL url = new java.net.URL(new com.openList.PushStatLocator().getPushStatHttpPortAddress() + "?WSDL");
        javax.xml.rpc.Service service = serviceFactory.createService(url, new com.openList.PushStatLocator().getServiceName());
        assertTrue(service != null);
    }

    public void test1PushStatHttpPortPushStat() throws Exception {
        com.openList.PushStatHttpBindingStub binding;
        try {
            binding = (com.openList.PushStatHttpBindingStub)
                          new com.openList.PushStatLocator().getPushStatHttpPort();
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
        value = binding.pushStat(new java.lang.String());
        // TBD - validate results
    }
    
}
