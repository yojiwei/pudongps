//定义本类所在的包
package com.website;
//定义本类引入的类
import java.io.*;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;

/**
 * 这个类同步击中次数文件的访问
 */

public class Count {
  //获取次数
  synchronized static public int getCount(File filestore) {
  	//文件不存在，返回
    if (!filestore.exists()) {
      return 0;
    }
    //对象输入流
    ObjectInputStream os = null;
    try {
      os = new ObjectInputStream(new FileInputStream(filestore));
      //读取次数
      int count =  os.readInt();
      return count;
    } catch(IOException e) {
      System.out.println("Unable to read from counter file: "+filestore);
      return 0;
    } finally {
      try {
        os.close();
      } catch(Exception e) {
        System.out.println("Unable to close counter file: "+filestore);
        e.printStackTrace();
      }
    }
  }
  //计数
  synchronized static public void incCount(File filestore) {
    int count = 0;
    //文件存在
    if (filestore.exists()) {
      // 读取当前的次数
      ObjectInputStream is = null;
      try {
        is = new ObjectInputStream(new FileInputStream(filestore));
        count = is.readInt();
      } catch(Exception e) {
        System.out.println("Unable to read from counter file: "+filestore);
        e.printStackTrace();
      } finally {
        try {
          is.close();
        } catch(Exception e) {
          System.out.println("Unable to close counter file: "+filestore);
          e.printStackTrace();
        }
      }
    }


    // 增加计数
    count++;
    // 写回增量计数
    ObjectOutputStream os = null;
    try {
      os = new ObjectOutputStream(new FileOutputStream(filestore));
      os.writeInt(count);
    }catch(Exception e) {
      System.out.println("Unable to write to counter file: "+filestore);
      e.printStackTrace();
    } finally {
      try {
        os.close();
      } catch(Exception e) {
        System.out.println("Unable to close output stream to counter file: "+filestore);
        e.printStackTrace();
      }
    }
  }

  synchronized static public void setCount(File filestore,int number) {
    // 写回增量计数
    ObjectOutputStream os = null;
    try {
      os = new ObjectOutputStream(new FileOutputStream(filestore));
      os.writeInt(number);
    }catch(Exception e) {
      System.out.println("Unable to write to counter file: "+filestore);
      e.printStackTrace();
    } finally {
      try {
        os.close();
      } catch(Exception e) {
        System.out.println("Unable to close output stream to counter file: "+filestore);
        e.printStackTrace();
      }
    }
  }
}


