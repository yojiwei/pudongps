/**
 * CassoUpdatePass.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.wsbcasuser;

public interface CassoUpdatePass extends java.rmi.Remote {
    public void main(java.lang.String[] args) throws java.rmi.RemoteException;
    public java.lang.String updatePass(java.lang.String userUid, java.lang.String pwd, java.lang.String wsbuser, java.lang.String wsbpass) throws java.rmi.RemoteException;
}
