package com.smsCase;

public class SmpService {

	public static String PassWord = "PudongSendSms";
	
	/**
	 * 短信发送方法
	 * 接口地址http://sms.pudong.sh/SmsWebservice/SendSmsService.asmx
	 * @param phoneNumberList 接收短信手机号码，多个手机号码使用半角“,”隔开,最多同时100个手机号码。
	 * @param contentStr 短信内容
	 * @param PassWord 调用接口密码，默认：PudongSendSms，注意大小写
	 * @throws Exception
	 */
	public String sendSms(String phoneNumberList, String contentStr, String PassWord) throws Exception {
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
        binding.setTimeout(60000);

        java.lang.String value = null;
        value = binding.sendSms(phoneNumberList, contentStr, PassWord);
        return value;
    }
	/**
	 * main方法
	 * @param args
	 */
	public static void main(String[] args) {
		SmpService smp = new SmpService();
		String resultValue = "";
		try {
			resultValue = smp.sendSms("15000661517", "测试新短信接口地址推送1，谢谢。",PassWord);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("dxpd====" + resultValue);
	}

}