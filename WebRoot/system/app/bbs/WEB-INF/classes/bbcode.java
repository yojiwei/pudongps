//作者:溢洋 QQ:14516449 EMAIL:xyworker@163.com

package yy;
import java.io.*;
import java.util.*;
public class  bbcode{
  public String HTMLEncode(String Str){
  	Str=YYReplace(Str,"<","&gt;");
  	Str=YYReplace(Str,">","&lt;");
  	Str=YYReplace(Str,"\n","<BR>");
  	return Str;
  	}
  public String YYReplace(String Str,String oldStr,String newStr){
       String ReturnStr="";
      int i,j,t,m,n;
      n=0;
      j=oldStr.length();
      if (Str.indexOf(oldStr)>-1)
      {
      while(Str.indexOf(oldStr,n)>-1)
      {
      i=Str.length();
      if (Str.indexOf(oldStr)==0)
         Str=newStr+Str.substring(j,i);
      else
      {
        t=Str.indexOf(oldStr);
        m=(t+j);
        Str=Str.substring(0,t)+newStr+Str.substring(m,i);
        n=t+newStr.length()-j+1;
      }
      }
      }
      ReturnStr=Str;
      return ReturnStr;

  }
  public String LCReplace(String Str,String BStr,String EStr,String ReStr){
  String ReturnStr="",Str1="",Str2="";
  int i,j,n;
  n=0;
  if ((Str.indexOf(BStr)>-1)&&((Str.indexOf(EStr)>-1)))
  {
  	while(Str.indexOf(BStr,n)>-1)
  	{
  		i=Str.indexOf(BStr);
  		j=Str.indexOf(EStr);
  		Str1=Str.substring((i+BStr.length()),j);
                Str2=YYReplace(ReStr,"$lichao$",Str1);
                Str1=BStr+Str1+EStr;
                Str=YYReplace(Str,Str1,Str2);
  	            n=i+Str2.length()-Str1.length();
          }
  	}
  	ReturnStr=Str;
  	return ReturnStr;
  }
public String yyBBCODE(String Str){
String BStr,EStr,ReStr;
 BStr="[b]";
 EStr="[/b]";
 ReStr="<b>$lichao$</b>";
 Str=LCReplace(Str,BStr,EStr,ReStr);
 
 BStr="[i]";
 EStr="[/i]";
 ReStr="<i>$lichao$</i>";
 Str=LCReplace(Str,BStr,EStr,ReStr);
 
 BStr="[u]";
 EStr="[/u]";
 ReStr="<u>$lichao$</u>";
 Str=LCReplace(Str,BStr,EStr,ReStr);
 
 BStr="[email]";
 EStr="[/email]";
 ReStr="<img align=absmiddle src=IMAGES/EMAIL1.GIF><A HREF='mailto:$lichao$' >$lichao$</A>";
 Str=LCReplace(Str,BStr,EStr,ReStr);
 
 BStr="[quote]";
 EStr="[/quote]";
 ReStr="<br>引用<hr noshade size=1 color=#C0C0C0>$lichao$<br><hr noshade size=1 color=#C0C0C0><br>";
 Str=LCReplace(Str,BStr,EStr,ReStr);
 
 BStr="[url]";
 EStr="[/url]";
 ReStr="<A HREF=http://$lichao$ TARGET=_blank>$lichao$</A>";
 Str=LCReplace(Str,BStr,EStr,ReStr);
 
 BStr="[img]";
 EStr="[/img]";
 ReStr="<a href='$lichao$' target=_blank><IMG SRC=$lichao$ border=0 alt=按此在新窗口浏览图片 onload='javascript:if(this.width>screen.width-333)this.width=screen.width-333'></a>";
 Str=LCReplace(Str,BStr,EStr,ReStr);
 
 BStr="[flash]";
 EStr="[/flash]";
 ReStr="<OBJECT codeBase=http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=4,0,2,0 classid=clsid:D27CDB6E-AE6D-11cf-96B8-444553540000 width=500 height=400><PARAM NAME=movie VALUE=''$lichao$''><PARAM NAME=quality VALUE=high><embed src=''$lichao$'' quality=high pluginspage='http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash' type='application/x-shockwave-flash' >$lichao$</embed></OBJECT>";
 Str=LCReplace(Str,BStr,EStr,ReStr);
 
 BStr=":)";
 EStr="<img src=IMAGES/SMILE.GIF border=0>";
 Str=YYReplace(Str,BStr,EStr);
 
 BStr=":(";
 EStr="<img src=IMAGES/SAD.GIF border=0>";
 Str=YYReplace(Str,BStr,EStr);
 
 BStr=":D";
 EStr="<img src=IMAGES/BIGSMILE.GIF border=0>";
 Str=YYReplace(Str,BStr,EStr);
 
 BStr=";)";
 EStr="<img src=IMAGES/WINK.GIF border=0>";
 Str=YYReplace(Str,BStr,EStr);
 
 BStr=":cool:";
 EStr="<img src=IMAGES/COOL.GIF border=0>";
 Str=YYReplace(Str,BStr,EStr);
 
 BStr=":mad:";
 EStr="<img src=IMAGES/MAD.GIF border=0>";
 Str=YYReplace(Str,BStr,EStr);
 
 BStr=":o";
 EStr="<img src=IMAGES/SHOCKED.GIF border=0>";
 Str=YYReplace(Str,BStr,EStr);

 BStr=":P";
 EStr="<img src=IMAGES/TONGUE.GIF border=0>";
 Str=YYReplace(Str,BStr,EStr);
return Str;
}
}
