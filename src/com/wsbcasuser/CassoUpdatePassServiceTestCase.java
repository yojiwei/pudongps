/**
 * CassoUpdatePassServiceTestCase.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.wsbcasuser;

public class CassoUpdatePassServiceTestCase extends junit.framework.TestCase {
    public CassoUpdatePassServiceTestCase(java.lang.String name) {
        super(name);
    }

    public void testpdwsbupassserviceWSDL() throws Exception {
        javax.xml.rpc.ServiceFactory serviceFactory = javax.xml.rpc.ServiceFactory.newInstance();
        java.net.URL url = new java.net.URL(new com.wsbcasuser.CassoUpdatePassServiceLocator().getpdwsbupassserviceAddress() + "?WSDL");
        javax.xml.rpc.Service service = serviceFactory.createService(url, new com.wsbcasuser.CassoUpdatePassServiceLocator().getServiceName());
        assertTrue(service != null);
    }

    public void test1pdwsbupassserviceMain() throws Exception {
        com.wsbcasuser.PdwsbupassserviceSoapBindingStub binding;
        try {
            binding = (com.wsbcasuser.PdwsbupassserviceSoapBindingStub)
                          new com.wsbcasuser.CassoUpdatePassServiceLocator().getpdwsbupassservice();
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
        binding.main(new java.lang.String[0]);
        // TBD - validate results
    }

    public void test2pdwsbupassserviceUpdatePass() throws Exception {
        com.wsbcasuser.PdwsbupassserviceSoapBindingStub binding;
        try {
            binding = (com.wsbcasuser.PdwsbupassserviceSoapBindingStub)
                          new com.wsbcasuser.CassoUpdatePassServiceLocator().getpdwsbupassservice();
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
        value = binding.updatePass(new java.lang.String(), new java.lang.String(), new java.lang.String(), new java.lang.String());
        // TBD - validate results
    }
    /**
     * 调用浦东门户网站的单点登录用户修改密码功能
     * @param us_uid
     * @param us_pass
     * @param wsbuser
     * @param wsbpass
     * @throws Exception
     */
    public void updateWsbPass(String us_uid,String us_pass,String wsbuser,String wsbpass) throws Exception {
        com.wsbcasuser.PdwsbupassserviceSoapBindingStub binding;
        try {
            binding = (com.wsbcasuser.PdwsbupassserviceSoapBindingStub)
                          new com.wsbcasuser.CassoUpdatePassServiceLocator().getpdwsbupassservice();
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
        value = binding.updatePass(us_uid, us_pass, wsbuser, wsbpass);
        // TBD - validate results
    }

}
