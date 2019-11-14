package com.weixin;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Formatter;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;

import com.alibaba.fastjson.JSONObject;


public class WeChatController {

    //获取相关的参数,在application.properties文件中
    private String appId = "wx6d3eada10e36922e";// 应用ID
    private String appSecret = "f3e6766e818deea7a01fb22faff4b210";// (应用密钥)
    private String accessTokenUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET";
    private String apiTicketUrl = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=ACCESS_TOKEN&type=jsapi";

    //微信参数
    private String accessToken;
    private String jsApiTicket;
    //获取参数的时刻
    private Long getTiketTime = 0L;
    private Long getTokenTime = 0L;
    //参数的有效时间,单位是秒(s)
    private Long tokenExpireTime = 0L;
    private Long ticketExpireTime = 0L;

    /**
     * main
     * @param args
     */
    public static void main(String args[]){
    	WeChatController wc = new WeChatController();
    	System.out.println(wc.getWechatParam("http://www.baidu.com"));
    }
    
    //获取微信参数
    public Map<String, String> getWechatParam(String url){
        //当前时间
        long now = System.currentTimeMillis();
        String returnMsg = "";
        //判断accessToken是否已经存在或者token是否过期
        if(StringUtils.isBlank(accessToken)||(now - getTokenTime > tokenExpireTime*1000)){
            JSONObject tokenInfo = getAccessToken();
            //System.out.println("tokenInfo==========="+tokenInfo);
            if(tokenInfo != null){
                accessToken = tokenInfo.getString("access_token");
                tokenExpireTime = tokenInfo.getLongValue("expires_in");
                //获取token的时间
                getTokenTime = System.currentTimeMillis();
                //System.out.println("accessToken====>"+accessToken);
                //System.out.println("tokenExpireTime====>"+tokenExpireTime+"s");
                //System.out.println("getTokenTime====>"+getTokenTime+"ms");
            }else{
                //System.out.println("====>tokenInfo is null~");
                System.out.println("====>failure of getting tokenInfo,please do some check~");
            }

        }

        //判断jsApiTicket是否已经存在或者是否过期
        if(StringUtils.isBlank(jsApiTicket)||(now - getTiketTime > ticketExpireTime*1000)){
            JSONObject ticketInfo = getJsApiTicket();
            //System.out.println("ticketInfo==========="+ticketInfo);
            if(ticketInfo!=null){
                //System.out.println("ticketInfo====>"+ticketInfo.toJSONString());
                jsApiTicket = ticketInfo.getString("ticket");
                ticketExpireTime = ticketInfo.getLongValue("expires_in");
                getTiketTime = System.currentTimeMillis();
                //System.out.println("jsApiTicket====>"+jsApiTicket);
                //System.out.println("ticketExpireTime====>"+ticketExpireTime+"s");
                //System.out.println("getTiketTime====>"+getTiketTime+"ms");
            }else{
                //System.out.println("====>ticketInfo is null~");
                System.out.println("====>failure of getting tokenInfo,please do some check~");
            }
        }

        //生成微信权限验证的参数
        Map<String, String> wechatParam= makeWXTicket(jsApiTicket,url);
        
        return wechatParam;
    }

    //获取accessToken
    private JSONObject getAccessToken(){
        String requestUrl = accessTokenUrl.replace("APPID",appId).replace("APPSECRET",appSecret);
        //System.out.println("getAccessToken.requestUrl====>"+requestUrl);
        JSONObject result = HttpUtil.doGet(requestUrl);
        return result ;
    }

    //获取ticket
    private JSONObject getJsApiTicket(){
        String requestUrl = apiTicketUrl.replace("ACCESS_TOKEN", accessToken);
        //System.out.println("getJsApiTicket.requestUrl====>"+requestUrl);
        JSONObject result = HttpUtil.doGet(requestUrl);
        return result;
    }

    //生成微信权限验证的参数
    public Map<String, String> makeWXTicket(String jsApiTicket, String url) {
        Map<String, String> ret = new HashMap<String, String>();
        String nonceStr = createNonceStr();
        String timestamp = createTimestamp();
        String string1;
        String signature = "";

        //注意这里参数名必须全部小写，且必须有序
        string1 = "jsapi_ticket=" + jsApiTicket +
                "&noncestr=" + nonceStr +
                "&timestamp=" + timestamp +
                "&url=" + url;
        //System.out.println("String1=====>"+string1);
        try
        {
            MessageDigest crypt = MessageDigest.getInstance("SHA-1");
            crypt.reset();
            crypt.update(string1.getBytes("UTF-8"));
            signature = byteToHex(crypt.digest());
            //System.out.println("signature=====>"+signature);
        }
        catch (NoSuchAlgorithmException e)
        {
            //System.out.println("WeChatController.makeWXTicket=====Start");
            e.printStackTrace();
            //System.out.println("WeChatController.makeWXTicket=====End");
        }
        catch (UnsupportedEncodingException e)
        {
            //System.out.println("WeChatController.makeWXTicket=====Start");
            e.printStackTrace();
            //System.out.println("WeChatController.makeWXTicket=====End");
        }

        ret.put("url", url);
        ret.put("appid", appId);
        ret.put("jsapi_ticket", jsApiTicket);
        ret.put("nonceStr", nonceStr);
        ret.put("timestamp", timestamp);
        ret.put("signature", signature);

        return ret;
    }
    //字节数组转换为十六进制字符串
    private static String byteToHex(final byte[] hash) {
        Formatter formatter = new Formatter();
        for (byte b : hash)
        {
            formatter.format("%02x", b);
        }
        String result = formatter.toString();
        formatter.close();
        return result;
    }
    //生成随机字符串
    private static String createNonceStr() {
        return UUID.randomUUID().toString();
    }
    //生成时间戳
    private static String createTimestamp() {
        return Long.toString(System.currentTimeMillis() / 1000);
    }
    
    
    
    
    
    
}