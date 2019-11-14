package com.component.treeview;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.http.*;
import javax.servlet.*;
import com.component.treeview.*;
import com.component.database.*;


public class CTreeXML extends CTree implements ITreeXML
{

   private CDataImpl cdi = null;

   /**
   @roseuid 3BFC9BC50114
   */
   public CTreeXML()
   {
     this(null);
   }

   /**
    * Method:CTree(CDataCn dCn,String dataType)
    * @param dCn 数据连接
    * @param dataType 数据类型 例： dept,meta,module,subject 程序会实例化相应的类
    * Description: 构造函数
   @roseuid 3E13CA200297
   */
   public CTreeXML(CDataCn dCn, String dataType)
   {
     super(dCn);
     setStructureClassName(dataType);
   }
   /**
   @roseuid 3BFC9BE703DA
   */
   public CTreeXML(CDataCn dCn)
   {
     cdi = new CDataImpl(dCn);
   }

   /**
   @roseuid 3C01F7E00010
   */
   public String getXMLByCurID(long id)
   {
     return getTreeXML(super.DEFAULT,id,-1);
   }

   /**
   @roseuid 3C01F7E00197
   */
   public String getXMLByParentID(long id)
   {
      return getTreeXML(super.DEFAULT,-1,id);
   }

   /**
   @roseuid 3C01F7E0031D
   */
   public String getXMLByInfo(long id)
   {
      return getXMLByInfo(id);
   }

   public static void main(String[] args)
   {
     CDataCn dCn = new CDataCn();
     CTreeXML tree = new CTreeXML(dCn,"Dept");
     //CTreeList tree = new CTreeList(dCn,"Subject");
     tree.setSupportFile();
     String xml = tree.getXMLByParentID(0) ;
     System.out.print(xml);
     dCn.closeCn();
   }
}