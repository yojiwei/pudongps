package com.Servlet;

import java.io.IOException;   
import java.io.PrintWriter;   
import java.util.Random;     
import javax.servlet.ServletException;   
import javax.servlet.http.HttpServlet;   
import javax.servlet.http.HttpServletRequest;   
import javax.servlet.http.HttpServletResponse;   
import javax.servlet.http.HttpSession;   
 
public class YzmServlet extends HttpServlet {   
 
   public void doGet(HttpServletRequest request, HttpServletResponse response)   
           throws ServletException, IOException {   
       this.doPost(request, response);   
   }   
 
   public void doPost(HttpServletRequest request, HttpServletResponse response)   
           throws ServletException, IOException {   
 
       Random random = new Random();   
 
       // 定义数组存放加减乘除四个运算符   
       char[] arr = { '+','-','*', '/' };   
 
       // 生成10以内的随机整数num1   
       int num1 = random.nextInt(10);   
 
       // 生成一个0-4之间的随机整数operate   
       int operate = random.nextInt(4);   
 
       // 生成10以内的随机整数num1   
       int num2 = random.nextInt(10);   
 
       // 避免出现除数为0的情况   
       if (operate == 3) {   
           // 如果是除法,那除数必须不能为0，如果为0，再次生成num2   
           while (num2 == 0) {   
               num2 = random.nextInt(10);   
           }   
       }   
 
       // 运算结果   
       int result = 0;   
 
       // 假定position值0/1/2/3分别代表”+”,”-”,”*”,”/”，计算前面操作数的运算结果   
       switch (operate) {   
       case 0:   
           result = num1 + num2;   
           break;   
       case 1:   
           result = num1 - num2;   
           break;   
       case 2:   
           result = num1 * num2;   
           break;   
       case 3:   
           result = num1 / num2;   
           break;   
       }   
 
       // 将生成的验证码值(即运算结果的值)放到session中，以便于后台做验证。   
       HttpSession session = request.getSession();   
       session.setAttribute("result", result);   
          
       PrintWriter out = response.getWriter();   
       out.println(num1+" "+ arr[operate]+" "+num2+" = ");   
   }   
}   