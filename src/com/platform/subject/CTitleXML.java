package com.platform.subject;

import com.component.treeview.*;
import com.component.database.*;


/**
 * <p>Title: oa</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: popteach</p>
 * @author not attributable
 * @version 1.0
 */

public class CTitleXML  extends CTreeXML{
    private String _sql = "";

    class structure extends CTitleStructure
  {
    public structure(){
      setStructureInfo(CTitleXML.this);
    }
   };


    public CTitleXML() {
         this(null);
    }

  /**
  @roseuid 3C031A7F0161
  */
  public CTitleXML(CDataCn dCn)
  {
    super(dCn);
    new structure();
  }



  public static void main(String[] args) {
    CTitleXML m = new CTitleXML();
    //System.out.print(m.getXMLByParentID(m.getIdByCode("ggzjsyhjdfm")));
    //System.out.print(m.getIdByCode("ggzjsyhjdfm")); //通过代码获得id
    //System.out.println(m.getCodeById(688)); //通过id获得代码
    m.dataCn.closeCn();
  }

}
