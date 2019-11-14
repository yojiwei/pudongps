//Source file: c:\test\com\platform\meta\CMetaDirInfo.java

package com.platform.meta;

import com.component.database.CDataImpl;
import com.component.database.CDataCn;
import javax.servlet.http.*;

public class CMetaDirInfo extends CDataImpl
{
   private static final String TABLENAME = "tb_datatdictionary";

   private static final String PRIMARYFIELDNAME = "dd_id";

   public CMetaDirInfo()
   {
     this(null);
   }

   /**
   @roseuid 3C0C7FA503E6
   */
   public CMetaDirInfo(CDataCn dCn)
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
   @roseuid 3C0C89880197
   */
   public boolean setSequence(HttpServletRequest request)
   {
     return setSequence("metaDir","dd_sequence",request);
   }

   /**
   @roseuid 3C0CBF720003
   */
   public boolean hasSameCode(String code, long id)
   {
     return hasSameCode(code,"dd_code",id);
   }

   /**
   @roseuid 3C0CBFA000B3
   */
   public boolean hasSubMeta(long id)
   {
     return hasSubObject("dd_parentid",id);
   }
}
