package com.platform.user;

import com.component.treeview.*;
import com.component.database.*;

public class CDeptIds extends CTreeIds
{
  class structure extends CDeptStructure
  {
    public structure(){
      setStructureInfo(CDeptIds.this);
    }
   };

   public CDeptIds()
   {
     this(null);
   }

   /**
   @roseuid 3C04CE58006C
   */
   public CDeptIds(CDataCn dCn)
   {
     super(dCn);
     new structure();
   }

   public static void main(String[] argc)
   {
     CDeptIds o = new CDeptIds();
    // System.out.println(o.getListByParentID(o.LISTID,0,"0","dd"));
     System.out.println(o.getSubDirIdsByID(0) );
   }
}
