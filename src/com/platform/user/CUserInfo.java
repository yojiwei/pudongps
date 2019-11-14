package com.platform.user;

import com.component.database.*;
import javax.servlet.http.*;

public class CUserInfo extends CDataImpl
{
   private static final String TABLENAME = "tb_userinfo";
   private static final String PRIMARYFIELDNAME = "ui_id";

   public CUserInfo()
   {
     this(null);
   }

   /**
   @roseuid 3C04CE23016A
   */
   public CUserInfo(CDataCn dCn)
   {
     super(dCn);
     setTableName(this.TABLENAME);
     setPrimaryFieldName(this.PRIMARYFIELDNAME );
   }

   /**
   @roseuid 3C0DE9870118
   */
   public boolean setSequence(HttpServletRequest request)
   {
     return setSequence("user","ui_sequence",request);
   }

   /**
   @roseuid 3C0DE9BB0235
   */
   public boolean hasSameUID(String uid,long id)
   {
     return hasSameCode(uid,"ui_uid",id);
   }
}
