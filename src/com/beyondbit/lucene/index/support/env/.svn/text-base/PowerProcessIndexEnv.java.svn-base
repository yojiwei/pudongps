package com.beyondbit.lucene.index.support.env;

import com.beyondbit.lucene.index.support.IEnv;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.analysis.Analyzer;
import com.beyondbit.lucene.index.support.IJob;
import com.beyondbit.lucene.index.support.job.IndexPowerProcessJob;
import org.mira.lucene.analysis.IK_CAnalyzer;
import org.apache.lucene.index.CorruptIndexException;
import java.io.IOException;
import com.beyondbit.lucene.index.LuceneUtils;
import org.apache.lucene.store.*;

public class PowerProcessIndexEnv extends java.util.HashMap implements IEnv {
    //索引�\uFFFD
    IndexWriter writer = null;
    // 中文分词分析�\uFFFD 版本1.0
    private static Analyzer analyzer = new IK_CAnalyzer();
    String path =  null;
    private boolean create = false;
    public PowerProcessIndexEnv() {
         path  = getClass().getClassLoader().getResource("").
                getFile() + "../lucene_index/pp";

    }

    public PowerProcessIndexEnv(IJob job) {
        this.create =((IndexPowerProcessJob) job).isNewCreate();
        path = getClass().getClassLoader().getResource("").
            getFile() + "../lucene_index/pp";
    }

    /**
     * initEnv
     *
     * @return IEnv
     */
    public void initEnv() throws Exception {
        //初始化IndexWriter

        try {
            writer = new IndexWriter(path, analyzer, this.create);
        }
        catch (java.io.FileNotFoundException ex) {
            writer = new IndexWriter(path, analyzer, true);
        }
        writer.setMergeFactor(1000);
        writer.setUseCompoundFile(false);
        this.put("writer",writer);
//
    }

    /**
     * release
     */
    public void release() {
        try {
            try {
                writer.optimize();
            }
            catch (CorruptIndexException ex2) {
            }
            catch (IOException ex2) {
            }
            writer.close();
//            System.out.println("index over");
        }
        catch (CorruptIndexException ex) {
        }
        catch (IOException ex) {
        }
        try {
            LuceneUtils.SearcherReload(path);
        }
        catch (Exception ex1) {
        }
    }

}
