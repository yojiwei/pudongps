
package com.website;

import java.io.File;
import java.io.FileWriter;
import java.io.StringReader;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Vector;

import org.dom4j.Document;

import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

import com.util.CDate;

public class XmlImpl {

     /**
      *   
      */

     public static void main(String[] args) {

          XmlImpl xml = new XmlImpl();
          /** ======================================演示解析=============================================* */
          //				
          
          
//          String s="<?xml version=\"1.0\" encoding=\"GB2312\"?><beyondbit><tb_infoexchange><us_id>用户数据表ID</us_id><ie_subject>申请主题</ie_subject>		<i_status>处理状态</i_status>		<ie_exid>数据交换唯一ID</ie_exid>		<ie_url>初始化URL格式</ie_url>		<ie_applytime>事项申请时间</ie_applytime>	</tb_infoexchange></beyondbit>";
//          						xml.setXmlString(s);
          /*********************************************************************
           * 演示 当只有一个父节点的时候 * 传出值 Hashtable
           */
          //
//          						xml.setXMLTable("tb_infoexchange");
//          						xml.setXMLTabSeed("us_id" );
//          						xml.setXMLTabSeed("ie_subject" );
//          						xml.RunXML();
//          						xml.p(xml.getXmlHashtable().toString(), "当有一个父接点");
          /*********************************************************************
           * 演示 当有多个父节点的时候（子节点标签相同，父节点标签相同） 传出值 Vector ---- Hashtable PS:
           * 占不支持多个父节点标签相同且子接点标签不相同
           */
          //						xml.setXMLTable("tb_infoexchange");
          //						xml.setXMLTabSeed("us_id" );
          //						xml.setXMLTabSeed("ie_subject" );
          //						xml.RunXML();
          //						xml.p(xml.getvXmlVeotor().toString(), "当有多个父接点标签相同，子标签相同");
          /*********************************************************************
           * 演示 当有多个父节点的时候（子节点标签不相同（相同），父节点标签不相同） 传出值 Hashtbale ---- Vector ----
           * Hashtable
           *  
           */
          //						xml.setXMLTabSeed("us_id", "tb_infoexchange");
          //						xml.setXMLTabSeed("ie_subject", "tb_infoexchange");
          //						xml.setXMLTabSeed("i_status", "tb_infoexchange");
          //						xml.setXMLTabSeed("us_id1", "tb_infoexchangepp");
          //						xml.setXMLTabSeed("ie_subject1", "tb_infoexchangepp");
          //						xml.setXMLTabSeed("i_status1", "tb_infoexchangepp");
          //						xml.RunXML();
          //						xml.p(xml.getXmlRoottable().toString(), "当有多个父接点标签不相同，子标签不相同相同");
          /** ===================================演示解析完成================================================* */
          /**
           * 演示 新增加一个XML
           * 
           * xml.setFilePath        新增所在的地址，相对路径。 当为空时只转换成String对象
           * xml.setXmlRoot			定义根目录
           * xml.addComment			对xml的注释；
           * xml.addAttrebute		对根目录的扩展定义
           * xml.setXmlTableSeed	(三级标签，三级标签值，对应的二级标签) 
           * 
           */
//			          				xml.setFilePath("/asd.xml");
//			          				xml.setXmlRoot("gsci");
//			          				xml.addComment("各委办局网站主体信息内容");
//			          				xml.addAttribute("version","0.9");
//			          				xml.setXMLTabSeed("title","网站名称","subsite");
//			          				xml.setXMLTabSeed("link","网站地址","subsite");
//			          				xml.setXMLTabSeed("copyright","网站版权","subsite");
//			          				xml.setXMLTabSeed("subsite","网站所在委办局名称","subsite");
//			          				xml.setXMLTabSeed("item","","substie");	
//			          				xml.setXMLTabSeed("item2","","substie");
//			          				Vector v = new Vector();			          							
//			          				Vector v2 = new Vector();
//			          				
//			          				v2.add("12345678");	
//			          				v2.add("12345678");	
//			          				v2.add("12345678");	
//			          				v2.add("12345678");	
//			          				v2.add("12345678");	
//			          				v2.add("12345678");	
//			          				v2.add("12345678");	
//			          				v2.add("12345678");	
//			          				v2.add("12345678");	
//			          				v2.add("12345678");	
//			          				v2.add("12345678");	
//			          				v2.add("12345678");	
//			          				v2.add("12345678");	
//			          				v2.add("12345678");	
//			          				v2.add("12345678");	
//			          				
//			          				
//			          				v.add("fdsafdae");	
//			          				v.add("fdsafdae");	
//			          				v.add("fdsafdae");	
//			          				v.add("fdsafdae");	
//			          				v.add("fdsafdae");	
//			          				v.add("fdsafdae");	
//			          				v.add("fdsafdae");	
//			          				v.add("fdsafdae");	
//			          				v.add("fdsafdae");	
//			          				v.add("fdsafdae");	
//			          				v.add("fdsafdae");	
//			          				v.add("fdsafdae");	
//			          				v.add("fdsafdae");	
//			          				v.add("fdsafdae");	
//			          				v.add("fdsafdae");	
//			          				
//			          				xml.setXMLTableTree("title",v,"item");
//			          				xml.setXMLTableTree("title2",v2,"item");		          				
//			          				xml.XmlAddNew();
//			          				System.out.println(xml.stXMLValue);

          
          
          
          
          
          
          
          
          
     }
     public String XmlString  ="";

     public CDate date = new CDate();

     public String fileName = System.getProperty("user.dir");

     public String filePath = "";

     public Hashtable hTableName = new Hashtable();//父参数 + 值

     public Hashtable hTableValue; //字参数 + 字值

     public Hashtable hXMLRootVlaue = new Hashtable();//多父标签

     public Hashtable hXMLRootVlaueSeed = new Hashtable(); //多父接点 子标签

     public Hashtable hXMLTabValue;//多节点父标签

     public String stXmlRoot = "";//XML根标签

     public String stXMLTableValue;//单节点父标签

     public Vector vecXmlTable = new Vector();//解析标签的父标签

     public Vector vXMLTableValue;//多节点Value

     public Vector vXMLTabSeed = new Vector();//子标签Vector

     public String stXMLValue = "";

     public Hashtable hXMLTableTree = new Hashtable();

     public Hashtable hXMLTableTreeValue = new Hashtable();

     public String CommentText = "";

     public String stShuXing = "";

     public String stShuXingValue = "";

     public XmlImpl() {

     }

     public void addAttribute(String sx, String sxv) {

          this.stShuXing = sx;
          this.stShuXingValue = sxv;
     }

     public void setXmlString(String xmlstring){
    	 this.XmlString = xmlstring;
    	 
     }
     
     public void addComment(String commenttext) {

          this.CommentText = commenttext;
     }

     public String getFilePath() {

          if (!getserVlaue(filePath)) {
               p("没有定义任何文件!", "getFilePath");
               return "";
          } else {
               return filePath;
          }
     }

     public boolean getserVlaue(String stValue) {

          stValue = getString(stValue);

          if (!stValue.equals("")) {

               return true;
          } else {
               return false;
          }
     }

     public String getString(String stValue) {

          if (stValue == null) {
               stValue = "";
          }
          return stValue;
     }

     public Vector getvXmlVeotor() {

          return this.vXMLTableValue;
     }

     public Hashtable getXmlHashtable() {

          return this.hXMLTabValue;
     }

     public String getXmlRoot() {

          return this.stXmlRoot;
     }

     public Hashtable getXmlRoottable() {

          return this.hXMLRootVlaue;
     }

     public Vector getXMlTable() {

          if (vecXmlTable == null) {
               p("没有指定父标签名称!", "getXMlTable");
               return null;
          } else {
               return vecXmlTable;
          }
     }

     public Vector getXMLTablSeed() {

          if (vXMLTabSeed != null) {
               return vXMLTabSeed;
          } else {
               p("没有定义子标签名称!", "getXMLTablSeed");
               return null;
          }
     }

     public void p(Exception out, String fangfa) {

          System.out.println(fangfa + ":   " + out + "  " + date.getNowTime());
     }

     public void p(String out, String fangfa) {

          System.out.println(fangfa + ":   " + out + "  " + date.getNowTime());
     }

     /**
      * 启动运行XML解析
      */
     public void RunXML() {
    	   //System.out.println(new StringReader(this.XmlString));
          String strFile = this.filePath;
          Vector vecXmlseed = this.vXMLTabSeed;
          StringReader ioStrrad =null;
          File fFile = null;
          if(!strFile.equals("")){
          fFile=new File(strFile);
          }else if(!this.XmlString.equals("")){
        	  ioStrrad = new StringReader(this.XmlString);        	  
          }
          
          SAXReader sexReader = new SAXReader();
          try {
               Document doc = null;
               if(fFile!=null){
               doc = sexReader.read(fFile);
               }
               else if (!this.XmlString.equals("")){
            	
            	   doc =sexReader.read(ioStrrad);
            	   
               }
               
               
            
              
               Element root = doc.getRootElement();
               Element foo = null;
               for ( int inXMLTable = 0 ; inXMLTable < vecXmlTable.size() ; inXMLTable++ ) {
                    String strTable = (String) vecXmlTable.get(inXMLTable);
                    vXMLTableValue = new Vector();
                    vecXmlseed = new Vector();
                    vecXmlseed = (Vector) hXMLRootVlaueSeed.get(strTable);
                    for ( Iterator i = root.elementIterator(strTable) ; i
                              .hasNext() ; ) {
                         foo = (Element) i.next();
                         hXMLTabValue = new Hashtable();
                         for ( int in = 0 ; in < vecXmlseed.size() ; in++ ) {
                              String strXmlseed = (String) vecXmlseed.get(in);

                              hXMLTabValue.put(strXmlseed, foo.elementText(
                                        strXmlseed).toString());

                         }
                         vXMLTableValue.add(hXMLTabValue);
                    }
                    hXMLRootVlaue.put(strTable, vXMLTableValue);
               }
          } catch (DocumentException e) {

               p(e, "RunXML");
          }
     }

     /*
      * 放置xml文件路径 例setFilePath("/xml.xml") filePath=$发布目录下$ /xml.xml 文件
      */

     public void setFilePath(String StfilePath) {

          if (getserVlaue(StfilePath)) {
               this.filePath = this.fileName + StfilePath;

          } else {
               p("没有指定文件名!", "setFilePath");
          }
     }

     /*
      * 放置xml文件路径 例setTerFilePath("c:/xml.xml") filePath=c:/xml.xml
      */
     public void setTerFilePath(String StfilePath) {

          if (getserVlaue(StfilePath)) {
               this.filePath = StfilePath;
          } else {
               p("没有指定文件名!", "setTerFilePath");
          }
     }

     public void setXmlRoot(String strRoot) {

          if (getserVlaue(strRoot)) {
               this.stXmlRoot = strRoot;
          } else {
               p("没有定义根接点！", "setXmlRoot");
          }
     }

     public void setXMLTable(String xmltable) {

          if (getserVlaue(xmltable)) {
               this.stXMLTableValue = xmltable;
               this.vecXmlTable.add(xmltable);
          } else {
               p("没有指定父标签名称!", "setXMLTable");
          }
     }

     public void setXMLTabSeed(String setTabSeed) {

          if (getserVlaue(setTabSeed)) {
               vXMLTabSeed.add(setTabSeed);
               if (getserVlaue(this.stXMLTableValue)) {
                    hXMLRootVlaueSeed.put(this.stXMLTableValue, vXMLTabSeed);
               } else {
                    p("父标签没有定义，不能插入父标签", "setXMLTabSeed");
               }
          } else {
               p("没有定义子标签名称", "setXMLTabSeed");
          }

     }

     public void setXMLTabSeed(String setTabSeed, String setTab) {

          if (getserVlaue(setTabSeed)) {
               if (hXMLRootVlaueSeed.containsKey(setTab)) {
                    vXMLTabSeed = new Vector();
                    vXMLTabSeed = (Vector) hXMLRootVlaueSeed.get(setTab);
                    //			System.out.println(vXMLTabSeed.toString());
                    vXMLTabSeed.add(setTabSeed);
                    hXMLRootVlaueSeed.put(setTab, vXMLTabSeed);

               } else {
                    vXMLTabSeed = new Vector();
                    vXMLTabSeed.add(setTabSeed);
                    hXMLRootVlaueSeed.put(setTab, vXMLTabSeed);
                    this.vecXmlTable.add(setTab);
               }
          } else {
               p("没有定义子标签名称", "setXMLTabSeed");
          }
     }

     public void setXMLTabSeed(String setTabSeed, String setValue, String setTab) {

          if (getserVlaue(setTabSeed)) {
               if (hXMLRootVlaueSeed.containsKey(setTab)) {
                    vXMLTabSeed = new Vector();
                    hTableValue = new Hashtable();
                    vXMLTabSeed = (Vector) hXMLRootVlaueSeed.get(setTab);
                    hTableValue = (Hashtable) hTableName.get(setTab);
                    hTableValue.put(setTabSeed, setValue);
                    hTableName.put(setTab, hTableValue);
                    vXMLTabSeed.add(setTabSeed);
                    hXMLRootVlaueSeed.put(setTab, vXMLTabSeed);

               } else {
                    vXMLTabSeed = new Vector();
                    hTableValue = new Hashtable();
                    hTableValue.put(setTabSeed, setValue);
                    hTableName.put(setTab, hTableValue);
                    vXMLTabSeed.add(setTabSeed);
                    hXMLRootVlaueSeed.put(setTab, vXMLTabSeed);
                    this.vecXmlTable.add(setTab);
               }
          } else {
               p("没有定义子标签名称", "setXMLTabSeed");
          }
     }

     public void setXMLTableTree(String TreeName, Vector TreeValue,
               String setTabSeed) {

          if (getserVlaue(TreeName)) {
               
               if (hXMLTableTree.containsKey(setTabSeed)) {                                   
                    Vector vSetTabSeed = (Vector) hXMLTableTree.get(setTabSeed);
                    vSetTabSeed.add(TreeName);
                    
                    
                    Hashtable hSetTabSeedValue = (Hashtable) hXMLTableTreeValue
                              .get(setTabSeed);                    
                    hSetTabSeedValue.put(TreeName,TreeValue);         
                   

               } else {
                    Vector vSetTabSeed = new Vector();
                    Hashtable hSetTabSeedValue = new Hashtable();
                    vSetTabSeed.add(TreeName);
                    hSetTabSeedValue.put(TreeName,TreeValue);
                    this.hXMLTableTree.put(setTabSeed, vSetTabSeed);
                    this.hXMLTableTreeValue.put(setTabSeed, hSetTabSeedValue);

               }           	  
               
          } else {
               p("没有定义子标签名称", "setXMLTableTree");
          }
     }
     
     
     
     
     
     public void setXMLTableTree(String TreeName, String TreeValue,
             String setTabSeed) {

        if (getserVlaue(TreeName)) {
             if (hXMLTableTree.containsKey(setTabSeed)) {         
                  Vector vSetTabSeed = (Vector)hXMLTableTree.get(setTabSeed);
                  vSetTabSeed.add(TreeName);
                  this.hXMLTableTree.put(setTabSeed, vSetTabSeed);
                  
                  Hashtable hSetTabSeedValue = (Hashtable) hXMLTableTreeValue
                  .get(setTabSeed); 
                  Vector vSetTabSeedValue = (Vector)hSetTabSeedValue.get(setTabSeed);
                  vSetTabSeedValue.add(TreeValue);
			      hSetTabSeedValue.put(TreeName,vSetTabSeedValue);         
			      this.hXMLTableTreeValue.put(setTabSeed, hSetTabSeedValue);
                  
                  
             }else{
                  Vector vSetTabSeed = new Vector();
                  vSetTabSeed.add(TreeName);
                  this.hXMLTableTree.put(setTabSeed, vSetTabSeed);
                  Hashtable hSetTabSeedValue = new Hashtable();
                  Vector vSetTabSeedValue = new Vector();
                  vSetTabSeedValue.add(TreeValue);
                  hSetTabSeedValue.put(TreeName,vSetTabSeedValue);
                  this.hXMLTableTreeValue.put(setTabSeed,hSetTabSeedValue);   
             }

        } else {
             p("没有定义子标签名称", "setXMLTableTree");
        }
   }

     
     
     
     /**
      * 启动运行XML增加
      */
     public void XmlAddNew() {

          Document document = DocumentHelper.createDocument();          
          Element booksElement = document.addElement(this.stXmlRoot);
          if (!this.stShuXing.equals("")) {
               booksElement.addAttribute(this.stShuXing, this.stShuXingValue);
          }
          if (!CommentText.equals("")) {
               booksElement.addComment(CommentText);
          }
          for ( int i = 0 ; i < this.vecXmlTable.size() ; i++ ) {
               String strTableName = (String) this.vecXmlTable.get(i);
               Vector vxmlseed = (Vector) hXMLRootVlaueSeed.get(strTableName);
               Hashtable vxmlvlue = (Hashtable) hTableName.get(strTableName);
               Element bookElement = booksElement.addElement(strTableName);
               for ( int in = 0 ; in < vxmlseed.size() ; in++ ) {
                    String titleName = (String) vxmlseed.get(in);
                    String titleValue = (String) vxmlvlue.get(titleName);	
                    
                    
                    
                    
                    
                    
                    if (hXMLTableTree.containsKey(titleName)) {
                         
                         Vector vSetTabSeed = (Vector) hXMLTableTree
                                   .get(titleName);
                         
                         Hashtable hSetTabSeedValue = (Hashtable) hXMLTableTreeValue
                                   .get(titleName);

                         
                         int bigValueSize =HsthtableBigSize(hSetTabSeedValue);
                        // System.out.println("bigValueSize"+bigValueSize);
                         
                         for ( int q = 0 ; q < bigValueSize ; q++ ) {
                        	 Element titleElement = bookElement.addElement(titleName);
                        	 for(int w= 0 ; w <vSetTabSeed.size();w++){
                        	     String sSetTabSeed = vSetTabSeed.get(w).toString();                   	      
                        		 Vector vTreeValue = (Vector)hSetTabSeedValue.get(sSetTabSeed);
                        		 if(vTreeValue.size()>q){ 
                        		      
                        			 Element titleElementTree = titleElement
                                     .addElement(sSetTabSeed);
                        			 
                        			 if(sSetTabSeed.equals("title")){
                        				 titleElementTree.addCDATA(vTreeValue.get(q)
                                                 .toString());	 	
                        				 
                        			 }else{
                            		 titleElementTree.setText(vTreeValue.get(q)
                                             .toString());
                        			 } 
                        		 }
                        	 }       	      
                         }

                    } else {
                    	 Element titleElement = bookElement.addElement(titleName);
                         titleElement.setText(titleValue);
                    }
                    
                    
                    
                    
                    
                    
               }

          }
          OutputFormat format = OutputFormat.createPrettyPrint();
          format.setEncoding("GB2312");
          
          this.stXMLValue = document.asXML();
          
          if(!this.filePath.equals("")){
               System.out.println(this.filePath);
          try {   
               XMLWriter writer = new XMLWriter(new FileWriter(new File(
                         this.filePath)), format);
               writer.write(document);
               writer.close();
          } catch (Exception ex) {
               p(ex, "XmlAddNew");
          }
          
          }

     }
     
     public int HsthtableBigSize(Hashtable hashtable){
     	 int  p  = 0;
     	// System.out.println(hashtable.toString());
     	 Enumeration ek=hashtable.keys();
     	 while(ek.hasMoreElements()){
     	      String er = ek.nextElement().toString();
     	     Vector vHashtablValue = (Vector)hashtable.get(er);
     	     //System.out.println(vHashtablValue.toString()+"-----------------------"+vHashtablValue.size());
     	     if(vHashtablValue.size()>p){
     	    	 p=vHashtablValue.size();    	    	 
     	     } 		 
     	   } 
     	return p; 
      }
     
     public void AddRunXml() {

     }

     public String getAsXml() {

          return this.stXMLValue;
     }
}