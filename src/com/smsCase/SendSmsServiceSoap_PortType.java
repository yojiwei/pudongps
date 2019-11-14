/**
 * SendSmsServiceSoap_PortType.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.smsCase;

public interface SendSmsServiceSoap_PortType extends java.rmi.Remote {
    public java.lang.String sendSms(java.lang.String phoneNumberList, java.lang.String contentStr, java.lang.String passWord) throws java.rmi.RemoteException;
    public java.lang.String sendSmsDelay(java.lang.String phoneNumberList, java.lang.String contentStr, java.lang.String passWord, java.util.Calendar delayTime) throws java.rmi.RemoteException;
    public java.lang.String cancelDelaySms(java.lang.String txseq, java.lang.String passWord) throws java.rmi.RemoteException;
}
