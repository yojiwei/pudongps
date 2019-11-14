package com.service.log;

import java.rmi.RemoteException;
/**
 * by yo 20090616
 * @author Administrator
 * JAVA互动调用.net写日志接口
 */
public class LogservicePd {
	/**
	 * 
	 */
	public LogservicePd(){}
	/**
	 * levn日志类型、description描述、isSucceed成功与否、operate操作人的ID
	 */
	public void writeLog(java.lang.String levn,
			java.lang.String description,java.lang.String isSucceed,java.lang.String operate){
		LogserviceSoap12Stub binding = null;
        try {
            binding = (com.service.log.LogserviceSoap12Stub)
                          new com.service.log.LogserviceLocator().getlogserviceSoap12();
            //写日志
			binding.writeLog(levn, description, isSucceed, operate);
			//System.out.println("It's over!");
        }
        catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
	}
	/**
	 * main
	 * @param args
	 */
	public static void main(String args[]){
		LogservicePd logser = new LogservicePd();
		String levn = "互动日志";
		String description = "某某用户在2009-06-16操作信访信箱列表页面";
		String isSucceed = "成功";
		String operate = "administrator";
		//logser.writeLog(levn, description, isSucceed, operate);
		
		String log_levn = ""; //日志类型
		String log_descript="";//日志内容描述
		String log_success = "";//是否成功
		  
		log_levn = "信访提交";
		log_success = "失败";
		log_descript = "街镇领导信箱信件提交页面AppealResult.jsp报错="+"null";
		logser.writeLog(log_levn,log_descript,log_success,"administrator");
		
	}
}
