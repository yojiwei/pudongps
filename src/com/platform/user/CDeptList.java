
package com.platform.user;

import com.component.treeview.*;
import com.component.database.*;

public class CDeptList extends CTreeList
{
  class structure extends CDeptStructure
  {
    public structure(){
      setStructureInfo(CDeptList.this);
    }
   };

   public CDeptList()
   {
     this(null);
   }

   /**
   @roseuid 3C0DD24E0232
   */
   public CDeptList(CDataCn dCn)
   {
     super(dCn);
     new structure();
   }

   public static void main(String[] argc)
   {
     CDeptList o = new CDeptList();
    // System.out.println(o.getListByParentID(o.LISTID,0,"0","dd"));
     //o.setOutputSelect(false);
     o.setOnchange(false);
     System.out.println(o.getListByParentID(0,"0"));
   }
}
