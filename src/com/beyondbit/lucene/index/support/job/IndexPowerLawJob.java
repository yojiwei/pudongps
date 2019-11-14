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
public class IndexPowerLawJob implements IJob {
    private static Logger logger = Logger.getLogger(IndexPowerLawJob.class);
    private int redotimes = 10;
    private List source = null;
    private boolean newCreate = false;


    public IndexPowerLawJob(List list) {
        this.source = list;
    }

    public IndexPowerLawJob(List list, boolean newCreate) {
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
                    if(!(std.get("basises") instanceof List)){
                        continue;
                    }
                    List basises = (List) std.get("basises");
                    Iterator substd = basises.iterator();
                    while(substd.hasNext()){
                        Document doc = new Document();
                        //子标准内�\uFFFD
                        Map result = (Map) substd.next();
                        //�\uFFFD要判断是否是更新或�\uFFFD�是新建或�\uFFFD�删�\uFFFD
                        if("99".equals(std.get("state"))){
                            //uuid改成子标准id
                            try {
                                writer.deleteDocuments(new Term("uuid",
                                    (String) result.get("id")));
                            }
                            catch (Exception ex2) {
                            }

                        }else{
                            this.makeDocument(doc, result);
//                            if(std.get("psname").toString().indexOf("可行性研究报告审�\uFFFD") >= 0 ){
//                                System.out.println("id is " + substdcontent.get("id"));
//                            }
                             if(!this.newCreate){
                                try {
                                    writer.deleteDocuments(new Term("uuid",
                                        (String) result.get("id")));
                                }
                                catch (Exception ex1) {
                                }

                             }
                            writer.addDocument(doc);
                        }
                    }

                }
//                writer.optimize();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            logger.error(ex);
            return false;
        } finally {
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

    private Document makeDocument(Document doc ,Map result){
        doc.add(new Field("uuid", CTools.dealNull(result.get("id")),
                          Field.Store.YES,
                          Field.Index.UN_TOKENIZED));
        doc.add(new Field("lawname", CTools.dealNull(result.get("name")),
                          Field.Store.YES,
                          Field.Index.TOKENIZED,
                          Field.TermVector.WITH_POSITIONS_OFFSETS));
        doc.add(new Field("describe", CTools.dealNull(result.get("content")),
                          Field.Store.YES,
                          Field.Index.TOKENIZED,
                          Field.TermVector.WITH_POSITIONS_OFFSETS));
//        doc.add(new Field("authorityby",
//                          CTools.dealNull(result.get("name")),
//                          Field.Store.YES,
//                          Field.Index.TOKENIZED));
        doc.add(new Field("bykind", CTools.dealNull(result.get("type")),
                          Field.Store.YES,
                          Field.Index.TOKENIZED));
        doc.add(new Field("consteorgan",
                          CTools.dealNull(result.get("unitname")),
                          Field.Store.YES,
                          Field.Index.TOKENIZED));

        return doc;
    }

    public boolean isNewCreate() {
        return newCreate;
    }

}
