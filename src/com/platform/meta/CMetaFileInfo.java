//Source file: c:\test\com\platform\meta\CMetaFileInfo.java

package com.platform.meta;

import com.component.database.CDataImpl;
import com.component.database.CDataCn;
import javax.servlet.http.*;

public class CMetaFileInfo extends CDataImpl
{
   private static final String TABLENAME = "tb_datavalue";
   private static final String PRIMARYFIELDNAME = "dv_id";

   public CMetaFileInfo()
   {
     this(null);
   }

   /**
   @roseuid 3C0C7FC00345
   */
   public CMetaFileInfo(CDataCn dCn)
   {
     super(dCn);
     setTableName(this.TABLENAME);
     setPrimaryFieldName(this.PRIMARYFIELDNAME );
   }

   /**
   * Method:setSequence(HttpServletRequest request)
   * Description: ±£¥Ê≈≈–Ú
   * @param request
   * @return boolean
   @roseuid 3C0C8E4E0130
   */
   public boolean setSequence(HttpServletRequest request)
   {
     return setSequence("metaFile","dv_sequence",request);
   }
}
