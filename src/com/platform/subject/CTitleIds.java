package com.platform.subject;

import com.component.database.*;
import com.component.treeview.*;

public class CTitleIds extends CTreeIds{

  class structure extends CTitleStructure
  {
    public structure(){
      setStructureInfo(CTitleIds.this);
    }
  };

   public CTitleIds() {
     this(null);
   }

   public CTitleIds(CDataCn dCn)
   {
     super(dCn);
     new structure();
   }


   public static void main(String[] args) {
     CDataCn dCn = new CDataCn();
     CTitleIds  xx = new CTitleIds(dCn);
     System.out.println(xx.getSubDirIdsByIDS("0"));
   }
}