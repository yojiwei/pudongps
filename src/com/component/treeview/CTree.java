package com.component.treeview;

import com.component.database.*;
import java.sql.*;
import org.jdom.*;
import org.jdom.CDATA.*;
import org.jdom.Element.*;
import java.io.*;
import java.io.File.*;
import java.util.*;
import org.jdom.output.*;

public class CTree extends CDataControl
{
   public static final int DEFAULT = 0;
   public static final int FORROLE = 1;
   public static final int LISTNAME = 2;
   public static final int LISTID = 3;

   //输出多选框的类型
   public static final int SELECT = 0;
   public static final int CHECKBOX = 1;

   public CTableInfo tableInfo;
   public CFieldInfo fieldInfo;
   public CFileFieldInfo fileFieldInfo;
   public CAccessFieldInfo accessFieldInfo;
   public CAccess access;
   private ResultSet rs = null;
   private ResultSet fileRs = null;
   private Document treeDoc = null;
   private Element root = null;


   private String _fieldName; //指定当前或上级字段的名称
   private String _sql;
   private StringBuffer _strBuf;
   private long _selectedId;
   private String _selectedIds; //选中的id列表
   private String _selectedName;
   private String _selectedNames; //选中的name列表
   private String _tagName;
   private int _type; //显示方式
   private String _selected;
   private String _structureClassName = "";
   private boolean _isSupportFile = false;
   private Hashtable _fileType = null;
   private ArrayList _outDirFieldName = null;
   private ArrayList _outFileFieldName = null;

   protected boolean _onchange = true; //输出是否select框的时候，加入onchange事件
   protected boolean _outputSelect = true; //是否返回select选项
   protected String _filterSql = ""; //通用的sql过滤器

   /**
    * Method:CTree()
    * Description: 构造函数,初始化treeDoc,root对象，数据库连接对象
    * @deprecated
   @roseuid 3BFB8878008D
   */
   public CTree()
   {
     this(null);
   }

   public void setFilterSql(String sql)
   {
     _filterSql=sql;
   }

   /**
    * Method:CTree(CDataCn dCn)
    * Description: 构造函数,初始化treeDoc,root对象，数据库连接对象
   @roseuid 3BFB8892009E
   */
   public CTree(CDataCn dCn)
   {
     super(dCn);
     tableInfo = new CTableInfo();
     fieldInfo = new CFieldInfo();
     access    = new CAccess();
     fileFieldInfo =  new CFileFieldInfo();
     accessFieldInfo = new CAccessFieldInfo();

     root      = new Element("root");
     treeDoc   = new Document(root);
   }

   /**
    * Method:initTree(int type,long curId,long parentId,long userId)
    * Description: 初始化Tree，实例化treeDoc,root对象
    * @param type 类型
    * @param curId 当前目录ID
    * @param parentId 上级目录ID
    * @param userId 用户ID
    * return void
   @roseuid 3BFB858F0244
   */
   protected String getTreeXML(int type, long curId, long parentId)
   {
     long id = 0;
     boolean isParent = true;
     if (curId < 0 && parentId < 0) return "";

     if (curId >= 0){
       isParent = false;
       id = curId;
     }else{
       id = parentId;
     }


     listDirForXML(id,1,root,isParent);
     return xmlToString();
   }

   /**
    * Method:initTree(int type,long curId,long parentId,long userId)
    * Description: 初始化Tree，实例化treeDoc,root对象
    * @param type 类型
    * @param info 中文信息，程序自动取得相应的ID
    * return void
   @roseuid 3BFC5A150087
   */
   protected String getTreeXML(int type, String info)
   {
     return "oo";
   }

   public long getIdByCode(String code)
   {
     long id; //返回的ID
     ResultSet rs = null;
     Statement stmt = null;

     if(code == null || code.equals("")) //判断代码是否为空
       return -1;
     _sql = "select " + fieldInfo.idName + " from " + tableInfo.dirName + " where " + fieldInfo.codeName + " = '" + code + "'";

     try{
       stmt = cn.createStatement();
       rs = stmt.executeQuery(_sql);
       if(rs.next())
       {
         id = rs.getLong(fieldInfo.idName);
       }
       else
         id = -1;
     }
     catch(Exception ex)
     {
       return -1;
     }
     return id;
   }

   /**
    * Method:getDirIds(String ids,isParent)
    * Description: 取得上级或下级所有目录IDS
    * @param ids 目录ID集 例：7,5,2
    * @param isParent
    * return void
   @roseuid 3BFC93BE034A
   */
   protected String getDirIds(String ids,String code, boolean isParent)
   {
     long id;
     String _ids = "";

     if (ids == null && code == null) return "";
     _strBuf = new StringBuffer("");

     if (ids != null)
     {
       if (ids.equals(""))
       {
         return "";
       }else{
         String[] _aids = com.util.CTools.split(ids,",");
         //_ids = removeRepeal(_ids);
         for (int i=0;i<_aids.length ;i++)
         {
           //先判断当前是否已被包含在已得到的IDS中，若是，则不进行取值
           if (_strBuf.length() == 0 || (","+_strBuf.toString() + ",").indexOf(","+_aids[i]+",") == -1)
           {
             id = java.lang.Long.parseLong(_aids[i]);
             listDirForIds(id,1,false);
           }
         }
       }
     }

     if (code != null)
     {
       if (code.equals(""))
       {
         return "";
       }else{
         _sql = "SELECT " + fieldInfo.idName + " FROM " + tableInfo.dirName + " WHERE " + fieldInfo.codeName + " = '" + code + "'";
         //System.out.print(sql);
         try
         {
          rs = executeQuery(_sql);
          if(rs.next())
          {
            id = rs.getLong(fieldInfo.idName);
            listDirForIds(id,1,false);
          }
         }catch(Exception ex){
           raise(ex,"在取得IDS时出错！","CTree.getDirIds");
         }

       }
     }
     _ids = _strBuf.toString() ;
     if (!_ids.equals(""))
     {
       int l = _ids.length() ;
       char c = ',';
       if (_ids.charAt(l-1) == c)
       {
         _ids = _ids.substring(0,l-1);
       }
       return _ids;
     }else{
       return "";
     }
   }


   /**
    * Method:getTreeList(int type,long curId,long parentId,String selectedValue,String tagName)
    * Description: 初始化Tree,以下拉列表方式表现，采用BufferString
    * @param type　列表显示方式,LISTID:value值为ID,LISTNAME:value值为name
    * @param curId 当前目录ID
    * @param parentId 上级目录ID
    * @param selectedValue 选择的值
    * @param tagName 列表框name的值
    * return void
   @roseuid 3C098A9B00B4
   */
   protected String getTreeList(int type, long curId, long parentId, String selectedValue, String tagName)
   {
     if (curId < 0  && parentId < 0) return "";
     if (type < 0 ) _type = this.LISTID ;
     else _type = type;

     if (type == this.LISTID) _selectedId = java.lang.Long.parseLong(selectedValue);
     if (type == this.LISTNAME) _selectedName = selectedValue;

     _type = type;
     _tagName = fieldInfo.idName;
     if (tagName != null ){
       if (!tagName.equals("")){
         _tagName = tagName;
       }
     }

     if(_outputSelect) //如果需要输出选择框
     {
       _strBuf = new StringBuffer("<select class=select-a name='" + _tagName + "' size='1'");
       if(_onchange)
       {
         _strBuf.append(" onchange=javascript:onChange()");
       }
       _strBuf.append(">");
     }
     else
     {
       _strBuf = new StringBuffer("");
     }

     if (curId > 0 ){
       listDirForList(curId,1,false);
     }else{
       listDirForList(parentId,1,true);
     }

     if(_outputSelect) //如果需要输出选择框
     {
       _strBuf.append("</select>");
     }

     return _strBuf.toString() ;
   }

   /**
    * Method:getTreeList(int type,String info,String code,String selectedValue,String tagName)
    * Description: 初始化Tree
    * @param type　列表显示方式,LISTID:value值为ID,LISTNAME:value值为name
    * @param info 目录名称
　　* @param code 目录代码名称
    * @param selectedValue 选择的值
    * @param tagName 列表框name的值
    * return String
   @roseuid 3C098D1500B6
   */
   public String getTreeList(int type, String info, String code,String selectedValue, String tagName)
   {
     long id ;
     String str = "";

     if (type < 0 || (info == null && code == null)) return "";
     if (info != null){
       if (!info.equals("")){
         _fieldName = fieldInfo.titleName;
         str = info;
       }
     }
     if(code != null){
       if (!code.equals("")){ //指定了code
         _fieldName = fieldInfo.codeName ;
         str = code;
       }else{ //两个都未指定
         return "";
       }
     }

     if (type == this.LISTID) _selectedId = java.lang.Long.parseLong(selectedValue);
     if (type == this.LISTNAME) _selectedName = selectedValue;

     _type = type;
     _tagName = fieldInfo.idName;
     if (tagName != null ){
       if (!tagName.equals("")){
         _tagName = tagName;
       }
     }

     if(_outputSelect) //如果需要输出选择框
     {
       _strBuf = new StringBuffer("<select class=select-a name='" + _tagName + "' size='1'");
       if(_onchange)
       {
         _strBuf.append(" onchange=javascript:onChange()");
       }
       _strBuf.append(">");
     }
     else
     {
       _strBuf = new StringBuffer("");
     }

     try{
       id = 0;
       _sql = "SELECT " + fieldInfo.idName + " FROM " + tableInfo.dirName + " WHERE " + _fieldName + " = '" + str + "'";
       rs = executeQuery(_sql);
       if (rs.next()){
         id = rs.getLong(fieldInfo.idName);
         listDirForList(id,1,false);
       }
     }catch(Exception ex){
       raise(ex,"在转换info/code为目录ＩＤ时出错！","getTreeList");
     }
     if(_outputSelect) //如果需要输出选择框
     {
       _strBuf.append("</select>");
     }
     return _strBuf.toString() ;
   }


   /**
    * Method:getMultiTreeList(int type,long curId,long parentId,String selectedValue,String tagName)<br>
    * Description: 初始化Tree,输出多选列表，采用BufferString<br>
    * @param type　列表显示方式,LISTID:value值为ID,LISTNAME:value值为name
    * @param curId 当前目录ID
    * @param parentId 上级目录ID
    * @param selectedValue 选择的值的集合，以逗号切分
    * @param tagName 列表框name的值
    */
   protected String getMultiTreeList(int type, long curId, long parentId, String selectedValues, String tagName)
   {
     return getMultiTreeList(type,curId,parentId,selectedValues,tagName,CTree.SELECT);
   }

   protected String getMultiTreeList(int type, long curId, long parentId, String selectedValues, String tagName,int outputType)
   {
     ResultSet rs = null;
     Statement stmt = null;

     if (curId < 0  && parentId < 0) return "";
     if (type < 0 ) _type = this.LISTID ;
     else _type = type;

     if (type == this.LISTID) _selectedIds = selectedValues;
     if (type == this.LISTNAME) _selectedNames = selectedValues;

     _type = type;
     _tagName = fieldInfo.idName;
     if (tagName != null ){
       if (!tagName.equals("")){
         _tagName = tagName;
       }
     }

     if(outputType == CTree.SELECT)
     {
       if(_outputSelect) //如果需要输出选择框
       {
         _strBuf = new StringBuffer("<select class=select-a name='" + _tagName + "' size='4' MULTIPLE");
         if(_onchange)
         {
           _strBuf.append(" onchange=javascript:onChange()");
         }
         _strBuf.append(">");
       }
       else
       {
         _strBuf = new StringBuffer("");
       }

       if (curId > 0 ){
         _sql = "SELECT * FROM " + tableInfo.dirName + " WHERE " + fieldInfo.parentIdName + " = " + curId + " order by " + fieldInfo.sortName ;
       }else{
         _sql = "SELECT * FROM " + tableInfo.dirName + " WHERE " + fieldInfo.idName + " = " + parentId;
       }

       try
       {
         stmt = cn.createStatement();
         rs = stmt.executeQuery(_sql);
         while  (rs.next())
         {
           long outCurId = rs.getLong(fieldInfo.idName);
           String sId = "";
           String dirName = rs.getString(fieldInfo.titleName);
           sId   = sId.valueOf(outCurId);

           selectedValues = "," + selectedValues + ","; //组合字符
           if ((_type == this.LISTID && selectedValues.indexOf("," + sId + ",") >= 0) || (_type == this.LISTNAME && selectedValues.indexOf(dirName) >= 0)){
             _selected = " selected";
           }else{
             _selected = " ";
           }

           _strBuf.append("<option value='"+sId+"'"+_selected+">"+rs.getString(fieldInfo.titleName )+"</option>");

         }

         rs.close();
         stmt.close() ;
       } catch(Exception ex){

       }
       if(_outputSelect) //如果需要输出选择框
       {
         _strBuf.append("</select>");
       }
      return _strBuf.toString() ;
     }
     else if(outputType == CTree.CHECKBOX) //如果需要输出checkbox
     {
       _strBuf = new StringBuffer("");

       if (curId > 0 ){
         _sql = "SELECT * FROM " + tableInfo.dirName + " WHERE " + fieldInfo.parentIdName + " = " + curId + " order by " + fieldInfo.sortName ;
       }else{
         _sql = "SELECT * FROM " + tableInfo.dirName + " WHERE " + fieldInfo.idName + " = " + parentId;
       }

       try
       {
         stmt = cn.createStatement();
         rs = stmt.executeQuery(_sql);
         while  (rs.next())
         {
           long outCurId = rs.getLong(fieldInfo.idName);
           String sId = "";
           String dirName = rs.getString(fieldInfo.titleName);
           sId   = sId.valueOf(outCurId);

           selectedValues = "," + selectedValues + ","; //组合字符
           if ((_type == this.LISTID && selectedValues.indexOf("," + sId + ",") >= 0) || (_type == this.LISTNAME && selectedValues.indexOf(dirName) >= 0)){
             _selected = " checked";
           }else{
             _selected = " ";
           }

           _strBuf.append("<input type=\"checkbox\" name=\"" + _tagName + "\" value='"+sId+"'"+_selected+"> "+rs.getString(fieldInfo.titleName) + " ");

         }

         rs.close();
         stmt.close() ;
       } catch(Exception ex){

       }
       return _strBuf.toString();
     }
     return "";
   }



   protected String getMultiTreeList(int type, String code, String selectedValues, String tagName)
   {
     return getMultiTreeList(type,code,selectedValues,tagName,CTree.SELECT);
   }

   protected String getMultiTreeList(int type, String code, String selectedValues, String tagName,int outputType)
   {
     ResultSet rs = null;
     Statement stmt = null;

     if(code == null || code.equals(""))
       return "";
     _sql = "select " + fieldInfo.idName + " from " + tableInfo.dirName + " where " + fieldInfo.codeName + " = '" + code + "'";

     try{
       stmt = cn.createStatement();
       rs = stmt.executeQuery(_sql);
       if(rs.next())
       {
         return getMultiTreeList(type,rs.getLong(fieldInfo.idName),-1,selectedValues,tagName,outputType);
       }
       else
         return "";
     }
     catch(Exception ex)
     {
       return "";
     }
   }


   /**
    * Method:setStructureClassName(String className)
    * Description: 设置数据结构类名称
    * @param className 例：com.component.treeview.CMetaStructure
    * return boolean
   @roseuid 3E13CB290343
   */
   public boolean setStructureClassName(String className)
   {
     if (className != null)
     {
       if (!className.equals(""))
       {
         if (className.indexOf(".") > 0)
         {
           _structureClassName = className;
         }else{
           _structureClassName = "com.component.treeview.C"+className+"Structure";
         }
         try{
           CStructure _struct = (CStructure) Class.forName(_structureClassName).newInstance();
           _struct.setStructureInfo(this);
          return true;
         }catch(Exception ex){
           raise(ex,"在初始化结构类时出错！","setStructureInfo");
           return false;
         }
       }
     }
     return false;
   }

   /**
    * Method:setUserId(long useId)
    * Description: 设置需要判断权限的用户ID
    * @param userId 用户ID
    * return void
   @roseuid 3BFC6943031A
   */
   protected void setUserId(long userId)
   {
   }

   /**
    * Method:setFilterDirIds(String ids)
    * Description: 设置需要过滤的目录ID集
    * @param ids 目录ID集 例：7,5,2
    * return void
   @roseuid 3BFC6C32034C
   */
   protected void setFilterDirIds(String ids)
   {
   }

   /**
    * Method:setFilterDirIds(String ids)
    * Description: 设置需要过滤的文件ID集
    * @param ids 文件ID集 例：7,5,2
    * return void
   @roseuid 3BFC6CA8007B
   */
   protected void setFilterFileIds(String ids)
   {
   }

   /**
    * Method:setSupportFile(boolean isFile)
    * Description: 设置是否支持文件
    * return void
   @roseuid 3C098A670060
   */
   public void setSupportFile()
   {
        _isSupportFile = true;
   }

   /**
    * Method:setFileType(Hashtable fileType)  <br>
    * Description: 设置文件类型对应表
    * @param fileType 例： fileType["男"] = 0; fileType["女"]　= 1
    * return void
   @roseuid 3DFDB3870321
   */
   public void setFileType(Hashtable fileType)
   {
     _fileType = fileType;
   }

   /**
    * Method:setOutDirFieldName(ArrayList fieldName)  <br>
    * Description: 设置输出目录字段，扩展而用
    * @param fileName
    * return void
   @roseuid 3DFDB43101D1
   */
   public void setOutDirFieldName(ArrayList fieldName)
   {
   }

   /**
    * Method:setOutFileFieldName(ArrayList fieldName)  <br>
    * Description: 设置输出文件字段，扩展而用
    * @param fileName
    * return void
   @roseuid 3DFDB4E40033
   */
   public void setOutFileFieldName(ArrayList fieldName)
   {
   }
   /**
    * Method:listDirForXML(int parentId,int level,Element eTemp)
    * Description: 递归目录与XML对象中
    * @param parentId 上级目录的ID
    * @param level 目前已递归到第几层
    * @param eTemp 产生当前记录的Element对象
    * return void
   @roseuid 3BFC61E601B1
   */
   private void listDirForXML(long id, int level, Element eTemp,boolean isParent)
   {
     try
     {
       ResultSet rs = null;
       Statement stmt = null;
       stmt = cn.createStatement();
       if (isParent){
         _sql = "SELECT * FROM " + tableInfo.dirName + " WHERE " + fieldInfo.parentIdName + " = " + id + _filterSql + " order by " + fieldInfo.sortName ;
       }else{
         _sql = "SELECT * FROM " + tableInfo.dirName + " WHERE " + fieldInfo.idName + " = " + id;
       }
       //System.out.println("pudong__sql = " + _sql);
       rs = stmt.executeQuery(_sql);
       while  (rs.next())
       {
           long curId = rs.getLong(fieldInfo.idName);
           String sId = "";
           String sItem = "";
           String sItemFile = "";
           String dirName = rs.getString(fieldInfo.titleName);
           sId   = sId.valueOf(curId);
           sItem = "item"+sItem.valueOf(level);

           Element item = new Element(sItem);
           listDirForXML(curId , level+1,item,true);

           item.addAttribute("value",dirName);
           item.addAttribute("id",sId);
           item.addAttribute("isFile","0");  //修正的地方

           if(_isSupportFile) //添加文件
           {
             sItemFile = "item" + sItemFile.valueOf(level+1);
             Element itemFile = null;
             _sql = "SELECT * FROM " + tableInfo.fileName + " WHERE " + fileFieldInfo.dirIdName + " = " + sId + " ORDER BY " + fileFieldInfo.sortName ;
             fileRs = this.executeQuery(_sql);
             while(fileRs.next())
             {
               long fileId = fileRs.getLong(fileFieldInfo.idName);
               String fileName = fileRs.getString(fileFieldInfo.titleName);
               String sFileId = new String().valueOf(fileId);
               itemFile = new Element(sItemFile);
               itemFile.addAttribute("id",sFileId);
               itemFile.addAttribute("value",fileName);
               itemFile.addAttribute("isFile","1");
               if (_fileType != null)
               {
                 int iValue;
                 String sValue = "0";
                 String sFileType = fileRs.getString(fileFieldInfo.typeName);
                 try
                 {
                   iValue = java.lang.Integer.parseInt(_fileType.get(sFileType).toString());
                 }catch(Exception ex){
                   //raise(ex,"在生成XML取文件类型进行转换为整型时出错！","CTree.listDirForXML");
                   iValue = 0;
                 }
                 sValue = new String().valueOf(iValue);
                 itemFile.addAttribute("fileType",sValue);
                 item.addContent(itemFile);
               }
             }
             fileRs.close();
           }
           eTemp.addContent(item);
       }
       rs.close();
       stmt.close() ;
     }
     catch   (Exception ex)
     {
         raise(ex,"在为XML递归时出错！","listDirForXML");
     }
   }

   /**
    * Method:listDirForList(int parentId,int level,boolean isParent)
    * Description: 递归目录与BufferString中
    * @param parentId 上级目录的ID
    * @param level 目前已递归到第几层
    * @param isParent　指定的是上级目录的ＩＤ
    * return void
   @roseuid 3C09911B0067
   */
   public void listDirForList(long id, int level, boolean isParent)
   {
     try
     {
       ResultSet rs = null;
       Statement stmt = null;
       stmt = cn.createStatement();
       if (isParent){
         _sql = "SELECT * FROM " + tableInfo.dirName + " WHERE " + fieldInfo.parentIdName + " = " + id + " order by " + fieldInfo.sortName ;
       }else{
         _sql = "SELECT * FROM " + tableInfo.dirName + " WHERE " + fieldInfo.idName + " = " + id;
       }

       rs = stmt.executeQuery(_sql);
       while  (rs.next())
       {
           long curId = rs.getLong(fieldInfo.idName);
           String sId = "";
           StringBuffer space = new StringBuffer("");
           String dirName = rs.getString(fieldInfo.titleName);
           sId   = sId.valueOf(curId);
           for (int i=1;i<level;i++){
             space.append("&nbsp;&nbsp;&nbsp;&nbsp;");
           }

           if ((_type == this.LISTID && curId == _selectedId) || (_type == this.LISTNAME && dirName.equals(_selectedName))){
               _selected = " selected";
           }else{
               _selected = " ";
           }

           _strBuf.append("<option value='"+sId+"'"+_selected+">"+space.toString()+rs.getString(fieldInfo.titleName )+"</option>");

           space = null;

           listDirForList(curId , level+1,true);

       }
       rs.close();
       stmt.close() ;
     }
     catch   (Exception ex)
     {
         raise(ex,"在为TreeList递归时出错！","listDirForXML");
     }
   }

   /**
    * Method:listDirForIds(long id)
    * Description: 递归目录生成IDs字符串
    * @param id 目录的ID
    * @param level 目前已递归到第几层
    * @param isParent　指定的是上级目录的ＩＤ
    * return void
   @roseuid 3BFC803A00E3
   */
   private void listDirForIds(long id,int level, boolean isParent)
   {
     try
     {
       ResultSet rs = null;
       Statement stmt = null;
       stmt = cn.createStatement();
       if (isParent){
         _sql = "SELECT * FROM " + tableInfo.dirName + " WHERE " + fieldInfo.parentIdName + " = " + id + " order by " + fieldInfo.sortName ;
       }else{
         _sql = "SELECT * FROM " + tableInfo.dirName + " WHERE " + fieldInfo.idName + " = " + id;
       }

       rs = stmt.executeQuery(_sql);
       while  (rs.next())
       {
           long curId = rs.getLong(fieldInfo.idName);
           String sId = "";

           sId   = sId.valueOf(curId);

           _strBuf.append(sId+",");

           listDirForIds(curId , level+1,true);

       }
       rs.close();
       stmt.close() ;
     }
     catch   (Exception ex)
     {
         raise(ex,"在为listDirForIds递归时出错！","listDirForXML");
     }
   }

   /**
    * Method:xmlToString()
    * Description: 返回XML对象序列化为字符串
    * return String
   @roseuid 3BFC65C60226
   */
   private String xmlToString()
   {
     try{
       XMLOutputter outputter = new XMLOutputter("  ",true,"gb2312");
       String temp = outputter.outputString(treeDoc);
       String s = "?>";
       int p = temp.indexOf(s);
       temp = temp.substring(p+2,temp.length()).trim();
       return temp;
     }catch(Exception e){
        System.out.println(e.getMessage());
        return "";
     }
   }

   public static void main(String[] args) {
        CTree tree = new CTree();
    }
}