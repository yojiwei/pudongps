
package com.platform.user;

import com.component.treeview.*;
import com.component.database.*;

public class CDeptXML extends CTreeXML
{
  class structure extends CDeptStructure
  {
    public structure(){
      setStructureInfo(CDeptXML.this);
    }
   };

   public CDeptXML()
   {
     this(null);
   }

   /**
   @roseuid 3C01FAD60147
   */
   public CDeptXML(CDataCn dCn)
   {
     super(dCn);
     new structure();
   }

}
