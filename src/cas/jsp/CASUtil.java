package cas.jsp;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.util.CTools;
/**
 * 配置于服务器端单点登录有关类
 * @author yaojiwei
 * 20081107
 */
public class CASUtil {

	public static String getUserColumn(String userXml,String column){
		String regBegin="<"+column+">";
		String regEnd="</"+column+">";
		String regC=regBegin+"([\\w\\W]*?)"+regEnd;
		String returnStr="";
		Pattern p = null;
		Matcher m = null;
		p = Pattern.compile(regC);// 找出行如<id>id</id>
		m = p.matcher(userXml);
		while (m.find()) {
			returnStr = m.group();
			returnStr=returnStr.replace(regBegin,"");
			returnStr=returnStr.replace(regEnd, "");
			try{
				returnStr=URLDecoder.decode(returnStr,"utf-8");
			}catch(UnsupportedEncodingException e){
				System.out.println("CASUtil:"+e.getMessage());
			}
			return returnStr;
		}
		return	returnStr;
	}
	
	public static void main(String[] args) {
		String userXml="<id>520</id><name>Iloveyou</name><uid>yojiwei</uid>";
		System.out.println(getUserColumn(userXml, "uid"));
	}
}
