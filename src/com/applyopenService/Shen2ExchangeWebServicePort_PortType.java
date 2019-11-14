/**
 * Shen2ExchangeWebServicePort_PortType.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.applyopenService;

public interface Shen2ExchangeWebServicePort_PortType extends java.rmi.Remote {
    public java.lang.String getInfo(java.lang.String orgId, java.lang.String userId, java.lang.String password) throws java.rmi.RemoteException;
    public java.lang.String reply(java.lang.String orgId, java.lang.String userId, java.lang.String password, java.lang.String reply) throws java.rmi.RemoteException;
    public java.lang.String addInfo(java.lang.String orgId, java.lang.String userId, java.lang.String password, java.lang.String info) throws java.rmi.RemoteException;
    public java.lang.String getInfoFromWS(java.lang.String orgId, java.lang.String clientCert, java.lang.String inputTXT, java.lang.String signedHashDigest) throws java.rmi.RemoteException;
    public java.lang.String replyFromWS(java.lang.String orgId, java.lang.String clientCert, java.lang.String reply, java.lang.String signedHashDigest) throws java.rmi.RemoteException;
    public java.lang.String addInfoFromWS(java.lang.String orgId, java.lang.String clientCert, java.lang.String info, java.lang.String signedHashDigest) throws java.rmi.RemoteException;
    public java.lang.String stat(java.lang.String orgId, java.lang.String clientCert, java.lang.String statContent, java.lang.String signedDigest) throws java.rmi.RemoteException;
}
