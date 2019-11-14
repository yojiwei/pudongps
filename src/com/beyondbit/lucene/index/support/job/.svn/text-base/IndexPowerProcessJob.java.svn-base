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
import com.beyondbit.lucene.index.LuceneUtils;
import org.apache.lucene.index.*;
import java.io.*;

public class IndexPowerProcessJob implements IJob {
    private static Logger logger = Logger.getLogger(IndexPowerProcessJob.class);
    private int redotimes = 10;
    private List source = null;
    private boolean newCreate = false;


    public IndexPowerProcessJob(List list) {
        this.source = list;
    }

    public IndexPowerProcessJob(List list, boolean newCreate) {
        this.source = list;
        this.newCreate = newCreate;
    }

    public static void main(String args[]){

    }


    /**
     * getFailureRedoTime
     *
     * @return long
     */
    public long getFailureRedoTime() {
        return 0L;
    }



    /**
     * run
     *
     * @param env IEnv
     * @return boolean
     */
    public boolean run(IEnv env) {
        IndexWriter writer = (IndexWriter) env.get("writer");
        try {

          if (this.source != null && (this.source.size() > 0)) {
              Iterator iter = this.source.iterator();
              while (iter.hasNext()) {
                  Document doc = new Document();
                  Map powerprocess = (Map) iter.next();

                  //�\uFFFD要判断是否是更新或�\uFFFD�是新建或�\uFFFD�删�\uFFFD
                  if ("99".equals(powerprocess.get("state"))) {
                      //uuid改成子标准id
                    try {
                        writer.deleteDocuments(new Term("uuid",
                            (String) powerprocess.get("ppid")));
                    }
                    catch (Exception ex2) {
                    }

                  }else{
                      //判断是新建或更新//不存在则新建//存在则更�\uFFFD
                    try {
                        if(!this.newCreate)
                        writer.deleteDocuments(new Term("uuid",
                            (String) powerprocess.get("ppid")));
                    }
                    catch (Exception ex1) {
                    }

                      this.makeDocument(doc, powerprocess);
                      writer.addDocument(doc);
                  }
              }
//              writer.optimize();
          }
      } catch (Exception ex) {
          ex.printStackTrace();
          logger.error(ex);
          return false;
      }
      finally {
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
    public boolean isNewCreate() {
        return newCreate;
    }

    private Document makeDocument(Document doc, Map powerprocess) {
        doc.add(new Field("uuid", CTools.dealNull(powerprocess.get("ppid")),
                          Field.Store.NO,
                          Field.Index.UN_TOKENIZED));
        doc.add(new Field("ppid", CTools.dealNull(powerprocess.get("ppid")),
                          Field.Store.YES,
                          Field.Index.UN_TOKENIZED));
        doc.add(new Field("code", CTools.dealNull(powerprocess.get("code")),
                          Field.Store.YES,
                          Field.Index.UN_TOKENIZED));
        doc.add(new Field("unitid", CTools.dealNull(powerprocess.get("unitid")),
                          Field.Store.YES,
                          Field.Index.UN_TOKENIZED));
        doc.add(new Field("unitname",
                          CTools.dealNull(powerprocess.get("unitname")).trim(),
                          Field.Store.YES,
                          Field.Index.TOKENIZED,Field.TermVector.WITH_POSITIONS_OFFSETS));
        doc.add(new Field("createuserid",
                          CTools.dealNull(powerprocess.get("createuserid")).
                          trim().toLowerCase(), Field.Store.YES,
                          Field.Index.UN_TOKENIZED));
        doc.add(new Field("createusername",
                          CTools.dealNull(powerprocess.get("createusername")).
                          trim(), Field.Store.YES,
                          Field.Index.UN_TOKENIZED));
        doc.add(new Field("des", CTools.dealNull(powerprocess.get("des")),
                          Field.Store.YES,
                          Field.Index.TOKENIZED,
                          Field.TermVector.WITH_POSITIONS_OFFSETS));
        doc.add(new Field("supervisedes",
                          CTools.dealNull(powerprocess.get("supervisedes")),
                          Field.Store.YES,
                          Field.Index.TOKENIZED,
                          Field.TermVector.WITH_POSITIONS_OFFSETS));

        return doc;
    }

}
