package com.platform.subject;

import com.component.database.*;
import com.component.treeview.*;

public class CSubjectIds extends CTreeIds{

  class structure extends CSubjectStructure
  {
    public structure(){
      setStructureInfo(CSubjectIds.this);
    }
  };

   public CSubjectIds() {
     this(null);
   }

   public CSubjectIds(CDataCn dCn)
   {
     super(dCn);
     new structure();
   }


   public static void main(String[] args) {
     CDataCn dCn = new CDataCn();
     CSubjectIds  xx = new CSubjectIds(dCn);
     System.out.println(xx.getSubDirIdsByIDS("0"));
   }
}