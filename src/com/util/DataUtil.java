package com.util;

import java.util.Calendar;  

import java.util.Date;  

    /** 

     *  日期大小写转换操作工具类 

     *  update by yo

     */  

    public class DataUtil {  

        public static void main(String[] args) {  

        System.out.println(new Date());

            System.out.println(DataUtil.dataToUpper(new Date()));  
            
            System.out.println(DataUtil.strToLower("二〇一四年十一月一日"));

        }  

      

        // 日期转化为大写  

        public static String dataToUpper(Date date) {  

            Calendar ca = Calendar.getInstance();    

            ca.setTime(date);    

            int year = ca.get(Calendar.YEAR);    

            int month = ca.get(Calendar.MONTH) + 1;    

            int day = ca.get(Calendar.DAY_OF_MONTH);  

            return numToUpper(year) + "年" + monthToUppder(month) + "月" + dayToUppder(day) + "日";  

        }


        // 将数字转化为大写  

        public static String numToUpper(int num) {  

            //String u[] = {"零","壹","贰","叁","肆","伍","陆","柒","捌","玖"};  

            String u[] = {"〇","一","二","三","四","五","六","七","八","九"}; 

            char[] str = String.valueOf(num).toCharArray();  

            String rstr = "";  

            for (int i = 0; i < str.length; i++) {  

                    rstr = rstr + u[Integer.parseInt(str[i] + "")];  

             }  

            return rstr;  

        }

        

     // 将大写转化为数字  
     //@strs 二零一四年十月十一日
        public static String strToLower(String strs) {  

            String u[] = {"0","1","2","3","4","5","6","7","8","9","10"}; 
            String v[] = {"〇","一","二","三","四","五","六","七","八","九","十"}; 
            String z[] = {"年","月"};
            char[] str = strs.toCharArray();
            String rstr = ""; 
    //得到字符串中最后一个字符 
    //注意最好在接受的时候用char类型的包装类Character
   
    for (int i = 0; i < str.length; i++) {
    Character lastChar = str[i];
    for (int j = 0; j < v.length; j++) {
    if (lastChar.toString().equals(v[j])) {
    rstr = rstr + u[j]; 
    }
    }
    for (int y = 0; y < z.length; y++) {
if (lastChar.toString().equals(z[y])) {
    rstr = rstr + "-"; 
    }
}
    }
    //yyyy-MM-dd
    String dataStr[] = rstr.split("-");
    //年
    String year = dataStr[0];
    //月
    String monthStrs[] = dataStr[1].replace("10", ",10,").split(",");
    int mon = 0;
    String month="";
    for(int i=0;i<monthStrs.length;i++){
    if(!"".equals(monthStrs[i])){
    mon += Integer.parseInt(monthStrs[i]);
    }
    }
    if(mon<10){
    month = "0"+mon;
    }else{
    month = ""+mon;
    }
   
    //日
    String dataStrs[] = dataStr[2].replace("10", ",10,").split(",");
    int da = 0;
    String day = "";
   
    if(dataStrs.length==1){
    da = Integer.parseInt(dataStrs[0]);
    }
    if(dataStrs.length==2){
    if("".equals(dataStrs[0])){
    da = 1*Integer.parseInt(dataStrs[1]);
    }else{
    da = Integer.parseInt(dataStrs[0])*Integer.parseInt(dataStrs[1]);
    }
    }
    if(dataStrs.length==3){
    if("".equals(dataStrs[0])){
    da = 1*Integer.parseInt(dataStrs[1])+Integer.parseInt(dataStrs[2]);
    }else{
    da = Integer.parseInt(dataStrs[0])*Integer.parseInt(dataStrs[1])+Integer.parseInt(dataStrs[2]);
    }
    }


    if(da<10){
    day = "0"+da;
    }else{
    day = ""+da;
    }
   
   
    rstr = year+"-"+month+"-"+day;
    return rstr;

        } 

       

        // 月转化为大写  

        public static String monthToUppder(int month) {  

              if(month < 10) {  

                      return numToUpper(month);         

              } else if(month == 10){  

                      return "十";  

              } else {  

                      return "十" + numToUpper(month - 10);  

              }  

        }  

       

        // 日转化为大写  

        public static String dayToUppder(int day) {  

              if(day < 20) {  

                       return monthToUppder(day);  

              } else {  

                       char[] str = String.valueOf(day).toCharArray();  

                       if(str[1] == '0') {  

                                return numToUpper(Integer.parseInt(str[0] + "")) + "十";  

                       }else {  

                                return numToUpper(Integer.parseInt(str[0] + "")) + "十" + numToUpper(Integer.parseInt(str[1] + ""));  

                       }  

            }  

        }  

    }  