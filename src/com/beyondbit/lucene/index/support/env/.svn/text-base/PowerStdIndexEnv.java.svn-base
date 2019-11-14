package com.beyondbit.lucene.index.support.env;

import com.beyondbit.lucene.index.support.IEnv;
import java.util.Collection;
import java.util.Map;
import java.util.Set;
import com.beyondbit.lucene.index.support.IJob;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.analysis.Analyzer;
import org.mira.lucene.analysis.IK_CAnalyzer;
import org.apache.lucene.store.LockObtainFailedException;
import org.apache.lucene.index.CorruptIndexException;
import java.io.IOException;
import com.beyondbit.lucene.index.handler.imp.PowerStdCreateDocCallBackImpl;
import com.beyondbit.lucene.index.LuceneUtils;
import com.beyondbit.lucene.index.support.job.IndexPowerStdJob;

public class PowerStdIndexEnv extends java.util.HashMap implements IEnv {
    //索引�\uFFFD
    IndexWriter writer = null;
    // 中文分词分析�\uFFFD 版本1.0
    private static Analyzer analyzer = new IK_CAnalyzer();
    String path =  null;
    private boolean create = false;
    public PowerStdIndexEnv() {
         path  = getClass().getClassLoader().getResource("").
                getFile() + "../lucene_index/ps";
    }

    public PowerStdIndexEnv(IJob job) {
        this.create =((IndexPowerStdJob) job).isNewCreate();
        path = getClass().getClassLoader().getResource("").
            getFile() + "../lucene_index/ps";
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
            writer.optimize();
        }
        catch (CorruptIndexException ex2) {
        }
        catch (IOException ex2) {
        }

        try {

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
