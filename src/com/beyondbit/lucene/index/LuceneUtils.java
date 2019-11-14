/**
 * 版本号：1.0
 * 更改时间 ：2007-11-12
 * 更改内容：1.运用IKAnalyzer中文分词器

 *         2.增加支持多文件夹搜索
 */
package com.beyondbit.lucene.index;

import java.io.File;
import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import org.apache.log4j.Logger;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.Token;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.Term;
import org.apache.lucene.queryParser.MultiFieldQueryParser;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.Hits;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.BooleanClause.Occur;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.store.LockObtainFailedException;
import org.mira.lucene.analysis.IK_CAnalyzer;

import com.beyondbit.lucene.consts.LuceneConst;
import com.beyondbit.lucene.index.handler.CreateObjectAfterSearchIndex;
import com.beyondbit.lucene.index.handler.IndexCreateDocCallBack;
import com.beyondbit.lucene.index.handler.imp.PowerLawCreateDocCallBackImpl;
import com.beyondbit.lucene.index.handler.imp.PowerProcessCallBackImpl;
import com.beyondbit.lucene.index.handler.imp.PowerStdCreateDocCallBackImpl;
import com.beyondbit.lucene.index.page.IndexPageConfig;
import com.component.newdatabase.CDataCn;
import com.component.newdatabase.CDataImpl;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.TermQuery;
import org.apache.lucene.document.Field;
import java.util.HashMap;

/**
 * @author liuyang <br>
 * @date 2007-9-19 <br>
 * @description:lucene的工具类 包含一系列的方法 注意情况 ：用户在使用Hashtable多域或者多内容查找时
 *                         必须在域名前（就是key前面） 加上"+"（代表必须在域中存在用户想要查找的信息），
 *                         "-"（代表在域中必须不存在用户想要查找的信息）符号 而且Hashtable中的键名的格式必须是:
 *                         (+|-)域名
 */
public class LuceneUtils {
    private static Logger logger = Logger.getLogger(LuceneUtils.class);

// 索引创建对象 能够创建索引和索引空间


    /*
     * 此处使用ThreadLocal对象建立线程内统一的临时变量
     * 保证在对相应对象进行操作时，可以分步执行但所得的变量能得到统一
     */

    //用于线程内存放IndexWriter
    private static ThreadLocal tliw = new ThreadLocal();

    //用于线程内存放Directory
    private static ThreadLocal tlfd = new ThreadLocal();

    //用于线程内存放IndexSearcher
    private static ThreadLocal tlis = new ThreadLocal();

    //用于线程内存放IndexReader
    static ThreadLocal tlir = new ThreadLocal();

    // 中文分词分析器 版本1.0
    private static Analyzer analyzer = new IK_CAnalyzer();

    //存放searcher list
    static private HashMap map = new HashMap();//

    public static Analyzer getAnalyzer() {
        return analyzer;
    }

    /**
     * Indexer初始化方法 建立IndexWriterlucene中的创建索引的核心对象

     * @param filePath 创建索引位置
     * @param isNewCreate 是否是新建

     * @throws Exception
     */
    public static synchronized void IndexerInit(String filePath,
                                                boolean isNewCreate) throws
        Exception {
        IndexWriter writer = null;
        if (filePath == null || filePath.equals(""))
            writer = new IndexWriter(LuceneConst.INDEX_INDEXDIR,
                                     analyzer, isNewCreate);
        else
            writer = new IndexWriter(filePath, analyzer, isNewCreate);
        writer.setMergeFactor(1000);
        writer.setUseCompoundFile(false);
        tliw.set(writer);
    }

    /**
     * 更新索引后需要重载查询索引
     * @param filePath String
     * @throws Exception
     */
    public static synchronized void SearcherReload(String filePath) throws Exception{
        synchronized(map){
            IndexSearcher searcher = (IndexSearcher) map.get(filePath);
            if (searcher != null) {
                synchronized (searcher) {
                    searcher.close();
                    map.remove(filePath);
                }
            }
        }
    }

    public static boolean hasKey(String path,String key) {
        try {
            SearcherInit(path);
            IndexSearcher searcher = (IndexSearcher) tlis.get();
            Hits hit = searcher.search(new TermQuery(new Term("uuid", key)));
            if (hit.length() < 1) {
                return false;
            }else {
                return true;
            }
        }
        catch (Exception ex) {
        }
        finally {
            try {
                searchClose();
            }
            catch (Exception ex1) {
            }
        }
        return false;
    }

    /**
     * Searcher初始化方法 建立IndexSearcher,Directory等lucene中的核心搜索对象
     *
     * @throws IOException
     * @throws LockObtainFailedException
     * @throws Exception
     *
     */
    public static synchronized void SearcherInit(String filePath) throws
        Exception {
//        IndexSearcher searcher = null;
        IndexSearcher searcher = (IndexSearcher) map.get(filePath);
        if(searcher == null){
//        IndexReader reader = null;
            Directory fsDir = null;
            if (filePath == null || filePath.equals(""))
                fsDir = FSDirectory.getDirectory(LuceneConst.INDEX_INDEXDIR);
            else
                fsDir = FSDirectory.getDirectory(filePath);
            searcher = new IndexSearcher(fsDir);
            synchronized(map){
                map.put(filePath, searcher);
            }
//        reader = IndexReader.open(fsDir);
//        tlir.set(reader);
//            tlfd.set(fsDir);
            tlis.set(searcher);
        }else{
            tlis.set(searcher);
        }
    }

    /**
     * 版本1.0 支持多文件夹索引 待实现

     * @param filePath
     * @throws Exception
     */
    /*public static synchronized void SearcherInit(String [] filePath) throws Exception {
      }*/
    public static synchronized void ReaderInit(String filePath) throws
        Exception {
        IndexReader reader = null;
        Directory fsDir = null;
        if (filePath == null || filePath.equals("")) {
            fsDir = FSDirectory.getDirectory(filePath);
        }
        else {
            fsDir = FSDirectory.getDirectory(filePath);
        }
        reader = IndexReader.open(fsDir);
        tlfd.set(fsDir);
        tlir.set(reader);
    }

    /**
     * 关闭indexWriter和

     *
     * @throws Exception
     */
    public static synchronized void writerClose() throws Exception {
        IndexWriter writer = (IndexWriter) tliw.get();
        if (writer != null) {
            writer.close();
        }
        tliw.set(null);
    }

    public static synchronized void searchClose() throws Exception {
//        Directory fsDir = (Directory) tlfd.get();
//        IndexSearcher searcher = (IndexSearcher) tlis.get();
//        IndexReader reader = (IndexReader) tlir.get();
//        if (fsDir != null)
//            fsDir.close();
//        if (searcher != null)
//            searcher.close();
//        if(reader != null)
//            reader.close();
        tlfd.set(null);
        tlis.set(null);
//        tlir.set(null);
    }

    public static synchronized void readerClose() throws Exception {
        Directory fsDir = (Directory) tlfd.get();
        IndexReader reader = (IndexReader) tlir.get();
        if (fsDir != null)
            fsDir.close();
        if (reader != null)
            reader.close();
        tlfd.set(null);
        tlir.set(null);
    }

    /**
     * 建立索引对象
     *
     * @param object
     *            需要建立索引的对象
     * @param back
     *            把用户对象转换成lucene中的doc对象的业务接口

     * @throws Exception
     */
    public static void createIndex(Object object, IndexCreateDocCallBack back) throws
        Exception {
        List list = new ArrayList();
        list.add(object);
        createIndex(list, back);
    }

    // 版本 1.0 增加为中文搜索字进行分词 2007-11-13
    /**
     * 解析用户输入的关键字 进行中文分词
     * @param searchValue 用户搜索值

     * @return 解析后的字符串

     * @throws Exception
     */
    public static String analyzerSearchValue(String searchValue) throws
        Exception {
        TokenStream ts = LuceneUtils.getAnalyzer().tokenStream("",
            new StringReader(searchValue));
        Token t = null;
        searchValue = "";
        while ( (t = ts.next()) != null) {
            if (t.termText() == null || t.termText().length() < 2) {
                continue;
            }
            if (!"".equals(searchValue)) {
                searchValue += " " + t.termText();
            }
            else {
                searchValue = t.termText();
            }
        }
        return searchValue;
    }

    /**
     * 建立索引对象
     *
     * @param objects
     *            需要创建索引的对象数组
     * @param back
     *            创建doc的对象

     * @throws Exception
     */
    public static synchronized void createIndex(List objects,
                                                IndexCreateDocCallBack back) throws
        Exception {
        IndexWriter writer = (IndexWriter) tliw.get();
        if (objects != null && (objects.size() > 0)) {
            Iterator iter = objects.iterator();
            int i = 1;
            while (iter.hasNext()) {
                Document doc = new Document();
                Object object = iter.next();
                back.createIndexDoc(doc, object);
                writer.addDocument(doc);
                i++;
            }
            writer.optimize();
        }
    }

    public static synchronized void delIndex(String fieldName, String q) throws
        Exception {
        IndexReader reader = (IndexReader) tlir.get();
        Term t = new Term(fieldName, q);
        reader.deleteDocuments(t);
    }

    /**
     * 根据用户传入的索引字段名称和值搜索对象

     *
     * @param fieldName
     *            需要搜索的索引字段名称
     * @param q
     *            搜索值

     * @param coa
     *            把doc对象转换为自己所需要的对象接口
     * @return Object 返回查询出来的对象

     * @throws Exception
     */
    public static synchronized List search(String fieldName, String q,
                                           CreateObjectAfterSearchIndex coa) throws
        Exception {
        // 组装查询域对象

        Hashtable conditions = new Hashtable();
        conditions.put(fieldName, q);
        return search(conditions, coa);
    }

    /**
     *
     * @param coa
     *            把doc对象转换为自己所需要的对象接口
     * @param hits
     *            查询出来的hits
     * @return 返回用户自己通过组装接口组装的用户对象的集合
     * @throws Exception
     */
    private static List createHitToList(CreateObjectAfterSearchIndex coa,
                                        Hits hits) throws Exception {
        List results = new ArrayList();
        if (hits != null) {

            for (int i = 0; i < hits.length(); i++) {
                Document doc = hits.doc(i);
//                  doc.add(new Field("hitid", String.valueOf(hits.id(i)), Field.Store.NO,
//					Field.Index.UN_TOKENIZED));
                if (coa == null)
                    results.add(doc);
                else
                    results.add(coa.createObject(doc));
            }
        }
        return results;
    }

    /**
     * 根据用户的要求进行分页查询

     *
     * @param fieldName
     *            默认域的名称
     * @param q
     *            搜索表达式

     * @param coa
     *            根据查询出来的document对象创建客户对象的接口

     * @param pageSize
     *            页面大小
     * @param page
     *            第几页

     * @return 返回索引页面对象
     * @throws Exception
     */
    public static IndexPageConfig searchByPage(String fieldName, String q,
                                               CreateObjectAfterSearchIndex coa,
                                               int pageSize, int page) throws
        Exception {
        long start = new Date().getTime();
        List results = (List) search(fieldName, q, coa);
        long end = new Date().getTime();
        IndexPageConfig ipc = null;
        if (results != null && results.size() > 0) {
            ipc = new IndexPageConfig();
            ipc.setCurrentPage(page);
            ipc.setPageSize(pageSize);
            ipc.setDepleteTime("" + (end - start));
            ipc.setResultCount(results.size());
            if (pageSize * page < results.size()
                && (page - 1) * pageSize < results.size())
                ipc.setResults(results.subList( (page - 1) * pageSize, page
                                               * pageSize));
            else if (pageSize * page >= results.size()) {
                ipc.setResults(results.subList( (page - 1) * pageSize, results
                                               .size()));
            }
        }
        return ipc;
    }

    /**
     *
     * @param conditions
     *            用户查询条件数组
     * @param coa
     *            创建用户对象接口
     * @param pageSize
     *            页面大小
     * @param page
     *            第几页

     * @return 返回索引页面对象
     * @throws Exception
     */
    public static IndexPageConfig searchByPage(Hashtable conditions,
                                               CreateObjectAfterSearchIndex coa,
                                               int pageSize, int page) throws
        Exception {
        long start = new Date().getTime();
        List results = search(conditions, coa);
        long end = new Date().getTime();
        IndexPageConfig ipc = null;
        if (results != null && results.size() > 0) {
            // 设置indexPageConfig对象
            ipc = new IndexPageConfig();
            ipc.setCurrentPage(page);
            ipc.setPageSize(pageSize);
            ipc.setDepleteTime("" + (end - start));
            ipc.setResultCount(results.size());
            if (pageSize * page < results.size()
                && (page - 1) * pageSize < results.size())
                ipc.setResults(results.subList( (page - 1) * pageSize, page
                                               * pageSize));
            else if (pageSize * page >= results.size()) {
                ipc.setResults(results.subList( (page - 1) * pageSize, results
                                               .size()));
            }
        }
        return ipc;
    }

    //版本 1.0 修改时间 2007-11-12 修改内容 :多个域需要合并查询同一个内容而他们之间又存在着或者关系 可以组合成一个字符串 用','分开
    /**
     * 通过多个域来查询索引
     *
     * @param conditions
     *            查询条件 key为域名称 value为搜索值

     * @param coa
     *            把doc对象转换为自己所需要的对象接口
     * @return 返回用户自己通过组装接口组装的用户对象的集合
     * @throws Exception
     */
    public static synchronized List search(Hashtable conditions,
                                           CreateObjectAfterSearchIndex coa) throws
        Exception {
        IndexSearcher searcher = (IndexSearcher) tlis.get();
        if (conditions == null) {
            throw new Exception("search condition is not allow null");
        }
        // 获得用户想要查询的域
        Iterator fieldNames = conditions.keySet().iterator();
        BooleanQuery b_query = new BooleanQuery();
        int i = 0;
        // 每个域的域名称

        String fieldName = "";
        // 每个域对应的搜索值

        String searchValue = "";
        //搜索关键字

        String keyword = "";
        // 组装多个查询域对象
        /**参考
         String fields[] = { "ID", "HostID" ,"Title","Content","Date"};
         String[] searchWords = {"22", "2","他们 别人","一块","2006-07-17"};
         MultiFieldQueryParser queryParser = new MultiFieldQueryParser(fields,language);
         queryParser.setDefaultOperator（QueryParser.Operator.AND);
         BooleanClause.Occur[] flags = {BooleanClause.Occur.SHOULD,BooleanClause.Occur.MUST,BooleanClause.Occur.SHOULD,BooleanClause.Occur.SHOULD,BooleanClause.Occur.MUST};
         怎么后面那个设置 为 AND 不起作用呢?  就是对具体里面的具体某个域不起作用了 比如说里面有个 “他们 别人” ，结果却会把这个域包含“他们”和包含“别人”的都显示出来
         但不进行多域检索用QueryParser时却又能对这个域起作用？
         如下:
         String fields = "Title";
         String searchWords = "他们 别人";
         Analyzer language = new StandardAnalyzer()；
         Query query;
         long startTime = new Date().getTime();
         QueryParser queryParser = new QueryParser(fields,language);
         queryParser.setDefaultOperator(QueryParser.Operator.AND);
         这时它又看作是 "他们" and  "别人"
         请问 难道在多域查询时不能通过setDefaultOperator方法来设置吗？
         不过我试过做成“+他们 +别人”这样是可行。



          QueryParser parser = new QueryParser("contents", new Analyzer());
                      parser.setDefaultOperator(QueryParser.AND_OPERATOR);
                      query = parser.parse(queryString);
         QueryParser parser2 = new QueryParser("adISELL", new Analyzer());
                      query2 = parser2.parse("\"2\"");
                      typeNegativeSearch.add(query,Occur.MUST);
                      typeNegativeSearch.add(query2,Occur.MUST);
          hits = searcher.search(typeNegativeSearch);
         */
        /**
         *
         * 之前的代码
         while (fieldNames.hasNext()) {

         fieldName = fieldNames.next().toString();
         searchValue = conditions.get(fieldName).toString();
         String [] fileNames = subfieldName(fieldName);
         String []values = new String[fileNames.length];
         //填充搜索数组
         Arrays.fill(values, analyzerSearchValue(searchValue));
         BooleanClause.Occur[] flags = new BooleanClause.Occur[values.length];
         Arrays.fill(flags,BooleanClause.Occur.SHOULD);
         //{BooleanClause.Occur.SHOULD,
         //		BooleanClause.Occur.MUST,//在这个Field里必须出现的
         //		BooleanClause.Occur.MUST_NOT};//在这个Field里不能出现

         Query query = MultiFieldQueryParser.parse(values, fileNames, flags,analyzer);
         b_query.add(query, judeSearchType(fieldName));
         keyword += " " + fieldName + ":(" + analyzerSearchValue(searchValue) + ")";
         i++;
           }
         **/

        //正确的组合条件应该是 先分词，然后 每个字段的关系是must,最后 分词之间的关系是and
        String[] queryStrings = new String[0]; //分词过的词组
        String[] fields = new String[conditions.size()]; //搜索字段
        int ll = 0;
        String qvalue = "";
        while (fieldNames.hasNext()) {
            String fieldNametemp = (String) fieldNames.next();
            qvalue = (String) conditions.get(fieldNametemp);
            if (qvalue != null)
                queryStrings = analyzerSearchValue(qvalue).split(" ");
            fields[ll] = fieldNametemp;
            ll++;
        }
        BooleanClause.Occur[] flags = new BooleanClause.Occur[fields.length];
        Arrays.fill(flags, BooleanClause.Occur.SHOULD);
        String singleWord = "";

        for (int k = 0; k < queryStrings.length; k++) {
            singleWord = queryStrings[k];
             BooleanQuery fieldQuery = new BooleanQuery();
             for (int l = 0; l < fields.length; l++) {
                 TermQuery termQuery = new TermQuery(new Term(fields[l],
                     singleWord));
                 fieldQuery.add(termQuery, Occur.SHOULD);
             }
            b_query.add(fieldQuery,Occur.MUST);
        }

//		for(int k =0; k < queryStrings.length;k ++){
//			singleWord = queryStrings[k];
        //Query query = MultiFieldQueryParser.parse(singleWord,fields,flags,analyzer);
//                        Query query = MultiFieldQueryParser.parse(singleWord,fields,flags,analyzer);
//			b_query.add(query, Occur.MUST);
//
//		}
//		 Query query = MultiFieldQueryParser.parse(qvalue,fields,flags,analyzer);
//                        for(int j=0;j<fields.length;j ++){
//                          QueryParser qp = new QueryParser(fields[j], analyzer);
//                          b_query.add(qp.parse(qvalue), Occur.SHOULD);
//                        }
        //Query query = MultiFieldQueryParser.parse( new String[]{okvalue},fileNames,flags,analyzer);
        //Query query = MultiFieldQueryParser.parse(fieldNames, fieldNames, flags,analyzer);



        // 查询结果
        Hits hits = searcher.search(b_query);
        return createHitToList(coa, hits);
    }

    /**
     * 根据用户域名称返回类型

     *
     * @param fieldName 字段名称
     * @return Occur 搜索字段的状态

     */
    private static Occur judeSearchType(String fieldName) {
        // 如果以 - 开头 代表必须不存在关系

        if (fieldName.charAt(0) == '-') {
            return Occur.MUST_NOT;
        }
        // 如果以 + 开头 代表并且
        if (fieldName.charAt(0) == '+') {
            return Occur.MUST;
        }
        // 代表或者
//		return Occur.MUST;
        return Occur.SHOULD;
    }

    /**
     * 获得用户想要查询的域名

     * @param fieldName 域名
     * @return
     */
    private static String[] subfieldName(String fieldName) {
        if (fieldName.charAt(0) == '-' || fieldName.charAt(0) == '+') {
            return fieldName.substring(1).split(",");
        }
        return fieldName.split(",");
    }

    /**
     * 以事务安全的形式建立索引
     * @param filePath 索引文件存放目录路径
     * @param isNewCreate 是否新建索引
     * @param objects 需要建立索引的对象列表
     * @param back IndexCreateDocCallBack的具体实现类
     * @return 是否成功
     */
    public static synchronized boolean syncCreateIndex(String filePath,
        boolean isNewCreate, List objects,
        IndexCreateDocCallBack back) {
        boolean createresult = false;

        IndexWriter writer = null;
        try {
            if (filePath == null || filePath.equals(""))
                writer = new IndexWriter(LuceneConst.INDEX_INDEXDIR, analyzer,
                                         isNewCreate);
            else
                writer = new IndexWriter(filePath, analyzer, isNewCreate);
            writer.setUseCompoundFile(false);
            if (objects != null && (objects.size() > 0)) {
                Iterator iter = objects.iterator();
                Document doc = null;
                if (isNewCreate) {
                    while (iter.hasNext()) {
                        Object object = iter.next();
                        if (object instanceof Hashtable) { //里面的情况就是这样，必须是Hashtable对象
                            //判断前面设置的标志，如果设置了，则不需要建立索引，因为这条是加密的数据
                            if ( ( (Hashtable) object).get("_NEEDINDEX") == null) {
                                doc = new Document();
                                back.createIndexDoc(doc, object);
                                writer.addDocument(doc);
                                doc = null;
                            }
                            else {
                                //不需要创建
                            }
                        }
                    }
                }
                else {
                    while (iter.hasNext()) {
                        Object object = iter.next();
                        if (object instanceof Hashtable) { //里面的情况就是这样，必须是Hashtable对象
                            //判断前面设置的标志，如果设置了，则不需要建立索引，因为这条是加密的数据
                            if ( ( (Hashtable) object).get("_NEEDINDEX") == null) {
                                doc = new Document();
                                back.createIndexDoc(doc, object);
                                Term term = new Term("uuid", doc.get("uuid"));
                                writer.updateDocument(term, doc);
                                doc = null;
                            }
                            else {
                                //删除,暂时不实现

                            }
                        }
                    }
                }
                writer.optimize();
                createresult = true;
            }

            //重新加载缓存的搜索器
            synchronized(map){
                IndexSearcher searcher = (IndexSearcher) map.get(filePath);
                if (searcher != null) {
                    try{
                        searcher.close();
                    }catch(Exception closeExp){

                    }
                    map.remove(filePath);
                }
            }
        }
        catch (Exception e) {
            logger.error("以事务安全的形式建立索引出错", e);
        }
        finally {
            if (writer != null) {
                try {
                    writer.close();
                }
                catch (Exception e) {
                    logger.error("以事务安全的形式建立索引出错", e);
                }
            }
        }
        return createresult;
    }

    /**
     * 以事务安全的形式建立索引
     * @param filePath 索引文件存放目录路径
     * @param isNewCreate 是否新建索引
     * @param object 需要建立索引的对象
     * @param back IndexCreateDocCallBack的具体实现类
     * @return 是否成功
     */
    public static synchronized boolean syncCreateIndex(String filePath,
        boolean isNewCreate, Object object,
        IndexCreateDocCallBack back) {
        List list = new ArrayList();
        list.add(object);
        return LuceneUtils.syncCreateIndex(filePath, isNewCreate, list, back);
    }

    public static void main(String[] args) {
        //创建索引
        String sqlStr = "";
        CDataCn dCn = null;
        CDataImpl dImpl = null;
        Vector vec = null;
        try {
            dCn = new CDataCn();
            dImpl = new CDataImpl(dCn);
            //初始化全文检索使用类
            String fileurl = LuceneUtils.class.getClassLoader().getResource("").
                getFile() + "../lucene_index/indexFiles";
            File f = new File(fileurl);
            if (!f.exists()) {
                f.mkdirs();
            }
            LuceneUtils.IndexerInit(fileurl, true);
            //建立索引
            sqlStr = "select * from tb_qlgk_law";
            vec = dImpl.splitPage(sqlStr, 2000, 1);
            LuceneUtils.createIndex(vec, new PowerLawCreateDocCallBackImpl());

            sqlStr = "select * from TB_QLGK_POWERPROCESS";
            vec = dImpl.splitPage(sqlStr, 2000, 1);
            LuceneUtils.createIndex(vec, new PowerProcessCallBackImpl());
            //LuceneUtils.createIndex(vec, new IndexCreateDocCallBackImpl());

            sqlStr = "select * from TB_QLGK_POWERSTD";
            vec = dImpl.splitPage(sqlStr, 2000, 1);
            LuceneUtils.createIndex(vec, new PowerStdCreateDocCallBackImpl());
            LuceneUtils.writerClose();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        finally {
            if (dImpl != null) {
                try {
                    dImpl.closeStmt();
                }
                catch (Exception e) {}
            }
            if (dCn != null) {
                dCn.closeCn();
            }
        }
        /*TokenStream ts = LuceneUtils.getAnalyzer().tokenStream("",new StringReader("中华人民共和国 解放军大校"));
           String searchValue = "";
           Token t;
           try {
         while(true) {
          t = ts.next();
          if(t.termText().length() < 2) {
           continue;
          }
          searchValue += " " + t.termText();
         }
           } catch (Exception e) {
         //e.printStackTrace();
           }
           System.out.println("分词以后的文字:" + searchValue);*/

        //搜索索引
        /*try {
          String searchtype = "";
          String searchValue = "第三方";
          Hashtable conditions = new Hashtable();
          System.out.println(searchValue);
          //conditions.put("+cateid", "12 14 1");
          conditions.put("des", searchValue);
          //conditions.put("des,", keyword);
          //conditions.put("des", keyword);
         // conditions.put("+aunitname", "环保局");
          //conditions.put("-ct_title", "世界");
          //初始化搜索
          LuceneUtils.SearcherInit("");
          //获得搜索结果
          IndexPageConfig indexPageConfig =
          LuceneUtils.searchByPage( conditions, null, 10, 1);
          if(indexPageConfig != null) {
           HignLightUtils hl = new HignLightUtils("ct_title", searchValue, LuceneUtils.getAnalyzer());
           System.out.println("关键字为:" + searchValue + "搜索到: " + indexPageConfig.getResultCount() + "条记录 花费时间:" + indexPageConfig.getDepleteTime() + "<br>");
           List search_result_list = indexPageConfig.getResults();
           for (int i = 0; i < search_result_list.size(); i++) {
            org.apache.lucene.document.Document doc = (org.apache.lucene.document.Document) search_result_list.get(i);

            System.out.println("编号: " + doc.get("ppid"));
           // System.out.println("名称: " + hl.parseText("psname", doc.get("psname")) + "<br>");
         System.out.println("内容: " + hl.parseText("des", doc.get("des")) + "<br>");
            System.out.println("职权单位名称: " + doc.get("aunitname") + "<br>");
            System.out.println("职权单位标示码: " + doc.get("aunitcode") + "<br>" + CTools.dealNull(doc.get("aunitcode")).equals("pd_hbj"));
            System.out.println("规范类别: " + doc.get("cateid") + "<br>");
            System.out.println("属性名称: " + doc.get("attr1id") + "<br>");
            System.out.println();
            //System.out.println("cateid: " + (doc.get("cateid") + "<br>").replaceAll( "<.+>||&nbsp;","")); System.out.println("ispc: " + doc.get("ispc") + "<br>");
          }
         }

         } catch (Exception ex) {
          ex.printStackTrace();
         }finally{
          try {
          LuceneUtils.searchClose();
         } catch (Exception e) {
          e.printStackTrace();
         }
         }	*/
    }
}
