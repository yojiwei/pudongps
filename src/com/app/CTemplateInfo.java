package com.app;
import com.component.database.*;
import javax.servlet.http.*;
import java.sql.SQLException;
/**
 * <p>Title: oa</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: popteach</p>
 * @author unascribed
 * @version 1.0
 */

public class CTemplateInfo extends CDataImpl
{

  private static final String TABLENAME = "tb_template";
  private static final String PRIMARYFIELDNAME = "tp_id";

  public CTemplateInfo()
  {
    this(null);
  }

  public CTemplateInfo(CDataCn dCn)
  {
    super(dCn);
    setTableName(this.TABLENAME);
    setPrimaryFieldName(this.PRIMARYFIELDNAME );
  }

  public boolean setSequence(HttpServletRequest request)
  {
    return setSequence("template","tp_sequence",request);
  }
}