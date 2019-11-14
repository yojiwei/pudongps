package com.beyondbit.lucene.index.support.job;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.Term;
import com.beyondbit.lucene.index.support.IEnv;
import com.beyondbit.lucene.index.support.IJob;
import com.util.CTools;
import org.apache.lucene.index.*;
import java.io.*;
/**
 *
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */
public class IndexPowerStdJob implements IJob {
    private static Logger logger = Logger.getLogger(IndexPowerStdJob.class);
    private int redotimes = 10;
    private List source = null;
    private boolean newCreate = false;


    public IndexPowerStdJob(List list) {
        this.source = list;
    }

    public IndexPowerStdJob(List list, boolean newCreate) {
        this.source = list;
        this.newCreate = newCreate;
    }

    public static void main(String args[]){

    }


    /**
     * run
     *
     * @param env Object
     * @return boolean
     */
    public boolean run(IEnv env) {
        IndexWriter writer = (IndexWriter) env.get("writer");
        try {

            if (this.source != null && (this.source.size() > 0)) {
                Iterator iter = this.source.iterator();
                while (iter.hasNext()) {

                    Map std = (Map) iter.next();
                    //先取出权力标准的值，再循环取权力分标准的�\uFFFD
                    List substds = (List) std.get("subpowerstds");
                    Iterator substd = substds.iterator();
                    while(substd.hasNext()){
                        Document doc = new Document();
                        //子标准内�\uFFFD
                        Map substdcontent = (Map) substd.next();
                        //�\uFFFD要判断是否是更新或�\uFFFD�是新建或�\uFFFD�删�\uFFFD
                        if("99".equals(substdcontent.get("state"))){
                            //uuid改成子标准id
                            try {
                                writer.deleteDocuments(new Term("uuid",
                                    (String) substdcontent.get("id")));
                            }
                            catch (Exception ex2) {
                            }

                        }else{
                            this.makeDocument(doc, std, substdcontent);
//                            if(std.get("psname").toString().indexOf("可行性研究报告审�\uFFFD") >= 0 ){
//                                System.out.println("id is " + substdcontent.get("id"));
//                            }
                             if(!this.newCreate){
                                try {
                                    writer.deleteDocuments(new Term("uuid",
                                        (String) substdcontent.get("id")));
                                }
                                catch (Exception ex1) {
                                }

                             }
                            writer.addDocument(doc);
                        }
                    }

                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            logger.error(ex);
            return false;
        }finally{
            try {
                writer.optimize();
            }
            catch (Exception ex3) {
                ex3.printStackTrace();
                logger.error(ex3);
            }

        }
        return true;
    }

    /**
     * getFailureRedoTime
     *
     * @return long
     */
    public long getFailureRedoTime() {
        return redotimes--;
    }

    private Document makeDocument(Document doc ,Map std,Map substd){
        doc.add(new Field("uuid", CTools.dealNull(substd.get("id")),
                          Field.Store.NO,
                          Field.Index.UN_TOKENIZED));
        doc.add(new Field("psid", CTools.dealNull(std.get("psid")),
                          Field.Store.NO,
                          Field.Index.UN_TOKENIZED));
        doc.add(new Field("cateid", CTools.dealNull(std.get("cateid")),
                          Field.Store.YES,
                          Field.Index.UN_TOKENIZED));
        doc.add(new Field("psname", CTools.dealNull(std.get("psname")),
                  Field.Store.YES,
                  Field.Index.TOKENIZED,
                  Field.TermVector.WITH_POSITIONS_OFFSETS));

        doc.add(new Field("pscode", CTools.dealNull(std.get("pscode")),
                          Field.Store.YES,
                          Field.Index.UN_TOKENIZED));

        doc.add(new Field("createunitname",
                         CTools.dealNull(substd.get("createunitname")).trim().
                         toLowerCase(), Field.Store.YES,
                         Field.Index.TOKENIZED,Field.TermVector.WITH_POSITIONS_OFFSETS));

        doc.add(new Field("aunitcode",
                          CTools.dealNull(substd.get("aunitcode")).trim().
                          toLowerCase(), Field.Store.YES,
                          Field.Index.UN_TOKENIZED));
        doc.add(new Field("aunitname",
                          CTools.dealNull(substd.get("aunitname")).trim().
                          toLowerCase(), Field.Store.YES,
                          Field.Index.TOKENIZED,Field.TermVector.WITH_POSITIONS_OFFSETS));
        doc.add(new Field("attr1name",
                          CTools.dealNull(substd.get("attr1name")).trim(),
                          Field.Store.YES,
                          Field.Index.UN_TOKENIZED));

        doc.add(new Field("des", CTools.dealNull(std.get("des")),
                          Field.Store.YES,
                          Field.Index.TOKENIZED,
                          Field.TermVector.WITH_POSITIONS_OFFSETS));
        return doc;
    }
    public boolean isNewCreate() {
        return newCreate;
    }

}
