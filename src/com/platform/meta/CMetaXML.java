package com.platform.meta;

import com.component.treeview.*;
import com.component.database.*;

public class CMetaXML extends CTreeXML
{
  class structure extends CMetaStructure
  {
    public structure(){
      setStructureInfo(CMetaXML.this);
    }
   };

   public CMetaXML()
   {
     this(null);
   }

   /**
   @roseuid 3C01FC25001C
   */
   public CMetaXML(CDataCn dCn)
   {
     super(dCn);
     new structure();
   }
   public static void main(String[] args) {
     CMetaXML m = new CMetaXML();
     System.out.print(m.getXMLByCurID(0));
     m.dataCn.closeCn();
   }
}

