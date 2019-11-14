
package com.component.treeview;

import com.component.database.*;

public class CTreeIds extends CTree implements ITreeIds
{

   /**
   @roseuid 3BFC9B890168
   */
   public CTreeIds()
   {
   }

   /**
   @roseuid 3BFC9BA700AC
   */
   public CTreeIds(CDataCn dCn)
   {
     super(dCn);
   }

   /**
    * Method:CTree(CDataCn dCn,String dataType)
    * @param dCn 数据连接
    * @param dataType 数据类型 例： dept,meta,module,subject 程序会实例化相应的类
    * Description: 构造函数
   @roseuid 3E13C89D004C
   */
   public CTreeIds(CDataCn dCn, String dataType)
   {
     super(dCn);
     setStructureClassName(dataType);
   }

   /**
   @roseuid 3C0EF8BB03E4
   */
   public String getSubDirIdsByID(long id)
   {
     String sId = "";
     sId = sId.valueOf(id);
     return getSubDirIdsByIDS(sId);
   }

   /**
   @roseuid 3C0EF8BC00F7
   */
   public String getSubDirIdsByIDS(String ids)
   {
     return getDirIds(ids,null,false);
   }

   /**
   @roseuid 3C0EF8BC01F1
   */
   public String getSubDirIdsByCode(String code)
   {
     return getDirIds(null,code,false);
   }

   /**
   @roseuid 3C0EF8BC02FF
   */
   public String getSubFileIdsByID(long id)
   {
     String _ids = getSubDirIdsByID(id);
     //get file ids
     return _ids;
   }

   /**
   @roseuid 3C0EF8BD0008
   */
   public String getSubFileIdsByIDS(String ids)
   {
     String _ids = getSubDirIdsByIDS(ids);
     //get file ids
     return _ids;
   }

   /**
   @roseuid 3C0EF8BD00F8
   */
   public String getSubFileIdsByCode(String code)
   {
     return "";
   }

   /**
   @roseuid 3C0EF8BD01F3
   */
   public String getParentIdsByID(long id, boolean isFile)
   {
     return "";
   }

   /**
   @roseuid 3C0EF8BD0397
   */
   public String getParentIdsByIDS(String ids, boolean isFile)
   {
     return "";
   }

   public static void main(String[] args)
   {
     CDataCn dCn = new CDataCn();
     CTreeIds tree = new CTreeIds(dCn,"Dept");
     String ids = tree.getSubDirIdsByIDS("1,3,100");
//     CTreeIds tree = new CTreeIds(dCn,"Subject");
  //   String ids = tree.getSubDirIdsByCode("news");
     System.out.print(ids);
     dCn.closeCn();
   }
}
