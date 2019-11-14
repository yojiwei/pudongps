package com.beyondbit.lucene.index;

import java.util.List;
import java.util.Vector;
import com.beyondbit.lucene.index.support.job.IndexPowerProcessJob;
import com.beyondbit.lucene.index.support.job.IndexPowerStdJob;
import com.beyondbit.lucene.index.support.IJob;
import com.beyondbit.lucene.index.support.IEnv;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import com.beyondbit.lucene.index.support.EnvFactory;
import java.util.Iterator;
import com.beyondbit.lucene.index.support.env.PowerStdIndexEnv;
import org.apache.log4j.Logger;
import com.beyondbit.lucene.index.support.env.PowerProcessIndexEnv;
import java.sql.Connection;
import com.beyondbit.db.ConnectionProvider;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import com.beyondbit.lucene.index.support.job.IndexPowerLawJob;
import com.beyondbit.lucene.index.support.env.PowerLawIndexEnv;
import com.util.CTools;

/**
 *
 * <p>Title: </p>
 * <p>Description: 本类主要实现以下功能：</p>
 * <li> 在数据导入时候，并不每条记录去写一次文件建立索引，而是在有新记录10秒后执行一次性创建索引
 * <li> 支持全局查询并不需要每次去init,而是在建立索引后重新init search
 * <li> 支持重新索引整个数据库
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */
public class LuceneControl {
    private static Logger logger = Logger.getLogger(LuceneControl.class);
    private static List jobList = new Vector();
    private static Object lock = new Object();
    static {
        //注册任务环境
        EnvFactory.registerEnv(IndexPowerLawJob.class,PowerLawIndexEnv.class);
        EnvFactory.registerEnv(IndexPowerStdJob.class,PowerStdIndexEnv.class);
        EnvFactory.registerEnv(IndexPowerProcessJob.class,PowerProcessIndexEnv.class);
        new Thread(new Runnable(){
            /**
             * run
             */
            public void run() {
                while(true){
                    synchronized(lock){
                        try {
                            lock.wait();
                        }
                        catch (InterruptedException ex) {
                        }
                    }
                    try {
                        //10秒后处理
                        Thread.sleep(10000);
                    }
                    catch (InterruptedException ex1) {
                    }
                    //处理
                    try {
                        runJob();
                    }
                    catch (Exception ex2) {
                        ex2.printStackTrace();
                        logger.error(ex2);
                    }
                }
            }
        }).start();
    }
    public LuceneControl() {
    }
    /**
     * 运行时job公用一个环境
     */
    public synchronized static void runJob()  throws Exception{
        Map envList = new HashMap();
        IEnv env = null;
        try {
            while (jobList.size() > 0) {
                IJob job = ( (IJob) jobList.get(0));
                env = (IEnv) envList.get(job.getClass());
                if (env == null) {
                    env = EnvFactory.createEnv(job);
                    envList.put(job.getClass(), env);
                    env.initEnv();
                }
                job.run(env);
                //
                jobList.remove(job);
            }
        }
        catch (Exception ex) {
            throw ex;
        }finally{
            Iterator it = envList.values().iterator();
            while (it.hasNext()) {
                ( (IEnv) it.next()).release();
            }
        }
    }
    /**
     * 增加job
     * @param job IJob
     */
    public static void addJob(IJob job) {
        jobList.add(job);
        synchronized (lock) {
            lock.notifyAll();
        }
    }

    public static void reindexPowerProcess() throws SQLException {
        Connection conn = ConnectionProvider.getConnection();
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("select t.* " +
                                       "from tb_qlgk_powerprocess t,tb_qlgk_powerstd t2 " +
                                       "where t.pscode=t2.pscode and " +
                                       " t2.openscope >= 2");
        while (rs.next()) {
            List list = new ArrayList();
            //存放主表的内容
            Map map = new HashMap();
            map.put("ppid", rs.getString("ppid"));
            map.put("code", rs.getString("code"));
            map.put("unitid", rs.getString("unitid"));
            map.put("unitname", rs.getString("unitname"));
            map.put("createuserid", rs.getString("createuserid"));
            map.put("createusername", rs.getString("createusername"));
            map.put("des", rs.getString("des"));
            map.put("supervisedes", rs.getString("supervisedes"));

            list.add(map);

            addJob(new IndexPowerProcessJob(list, true));
        }
//        System.out.println("add over");
        rs.close();
        st.close();
        conn.close();
    }


    public static void reindexPowerStd() throws SQLException {
        Connection conn = ConnectionProvider.getConnection();
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("select t.psid,"+
       "t2.id,"+
       "t.cateid,"+
       "t.psname,"+
       "t.pscode,"+
       "t2.aunitcode,"+
       "t2.aunitname,"+
       "t2.attr1name,"+
       "t2.createunitname,"+
       "t.des "+
   "from tb_qlgk_powerstd t, tb_qlgk_subpowerstd t2 "+
  "where t2.powerstd_id = t.psid "+
    "and t.openscope >= 2");
        while (rs.next()) {
            List list = new ArrayList();
            //存放主表的内容
            Map map = new HashMap();
            map.put("psid",rs.getString("psid"));
            map.put("cateid",rs.getString("cateid"));
            map.put("psname",rs.getString("psname"));
            map.put("pscode",rs.getString("pscode"));
            map.put("des",rs.getString("des"));
            list.add(map);
            //存放子表的内容
            List sublist = new ArrayList();
            Map submap = new  HashMap();
            sublist.add(submap);
            submap.put("id", rs.getString("id"));
            submap.put("aunitcode", rs.getString("aunitcode"));
            submap.put("aunitname", rs.getString("aunitname"));
            submap.put("createunitname", rs.getString("createunitname"));
            submap.put("attr1name", rs.getString("attr1name"));
            map.put("subpowerstds", sublist);
            addJob(new IndexPowerStdJob(list,true));
        }
//        System.out.println("add over");
        rs.close();
        st.close();
        conn.close();
    }


    public static void reindexPowerLaw() throws SQLException {
       Connection conn = ConnectionProvider.getConnection();
       Statement st = conn.createStatement();
       ResultSet rs = st.executeQuery("select lawname,bykind,t.consteorgan,t.describe,t.id from tb_qlgk_law t");
       while (rs.next()) {
           List list = new ArrayList();


           Map stdmap = new  HashMap();
           list.add(stdmap);

           //存放子表的内容
           List sublist = new ArrayList();
           //存放主表的内容
           Map map = new HashMap();
           map.put("id",rs.getString("id"));
           map.put("name",rs.getString("lawname"));
           map.put("content",CTools.ClobToString( rs.getClob("describe")));
           map.put("type",rs.getString("bykind"));
           map.put("unitname",rs.getString("consteorgan"));
           stdmap.put("basises", sublist);
           sublist.add(map);
           //存放子表的内容
           addJob(new IndexPowerLawJob(list,true));
       }
       rs.close();
       st.close();
       conn.close();
   }


    public static void main(String args[]){
        try {
            reindexPowerLaw();
        }
        catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

//    /**
//     * 将解析内容增加到待处理任务中
//     * @param result List
//     */
//    public static void addDoc(List result) {
//        if (result.get(1) != null) {
//            addJob(new IndexPowerProcessJob());
//        }
//        else if (result.get(2) != null) {
//            addJob(new IndexPowerStdJob());
//        }
//        else {
//
//        }
//
//        synchronized (lock) {
//            lock.notifyAll();
//        }
//    }

}
