
package com.component.treeview;


public interface ITreeIds
{

   /**
    * Method:getSubDirIdsByID(long id)
    * Description: 取得某目录下的所有目录IDS
    * @param id 当前目录ID
    * return String
   @roseuid 3C0EDC9B01BA
   */
   public String getSubDirIdsByID(long id);

   /**
    * Method:getSubDirIdsByIDS(String ids)
    * Description: 取得ids指的目录集下的所有目录IDS
    * @param ids 目录IDs
    * return String
   @roseuid 3C0EDCBD01CD
   */
   public String getSubDirIdsByIDS(String ids);

   /**
    * Method:getSubDirIdsByIDS(String code)
    * Description: 取得ids指的目录集下的所有目录IDS
    * @param code 目录代码
    * return String
   @roseuid 3C0EE0F0030A
   */
   public String getSubDirIdsByCode(String code);

   /**
    * Method:getSubFileIdsByID(long id)
    * Description: 取得某目录下的所有目录的所有文件IDS,该函数在内部调用getSubDirIds(long id)
    * @param id 当前目录ID
    * return String
   @roseuid 3C0EDDC20151
   */
   public String getSubFileIdsByID(long id);

   /**
    * Method:getSubFileIdsByIDS(String ids)
    * Description: 取得ids指的目录集下的所有目录的文件IDS,该函数在内部调用getSubDirIds(String ids)
    * @param ids 目录IDs
    * return String
   @roseuid 3C0EDDE0004F
   */
   public String getSubFileIdsByIDS(String ids);

   /**
    * Method:getSubFileIdsByCode(String code)
    * Description: 取得某目录下的所有目录的所有文件IDS,该函数在内部调用getSubDirIds(long id)
    * @param code 目录代码
    * return String
   @roseuid 3C0EE2450151
   */
   public String getSubFileIdsByCode(String code);

   /**
    * Method:getParentIdsByID(long id,boolean isFile)
    * Description: 取得某目录的所有上级目录IDS
    * @param id 当前目录或文件ID
    * @param isFile
    * return String
   @roseuid 3C0EDD1C038D
   */
   public String getParentIdsByID(long id, boolean isFile);

   /**
    * Method:getParentIdsByIDS(String ids,boolean isFile)
    * Description: 取得ids指的目录集上的所有目录IDS
    * @param ids 目录或文件IDs
    * @param isFile
    * return String
   @roseuid 3C0EDD41026D
   */
   public String getParentIdsByIDS(String ids, boolean isFile);
}
