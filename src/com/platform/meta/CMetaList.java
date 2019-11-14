
package com.platform.meta;

import com.component.treeview.*;
import com.component.database.*;

public class CMetaList extends CTreeList
{
   class structure extends CMetaStructure
   {
     public structure(){
       setStructureInfo(CMetaList.this);
     }
   };

   public CMetaList()
   {
     this(null);
   }

   /**
   @roseuid 3C09B21D03C5
   */
   public CMetaList(CDataCn dCn)
   {
     super(dCn);
     new structure();
   }

   public static void main(String[] argc)
   {
     CMetaList o = new CMetaList();
     System.out.println(o.getListByCode(o.LISTID,"special","0","xxx" ));
   }
}
