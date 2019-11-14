package com.beyondbit.log;

import com.component.newdatabase.CDataImpl;
import java.util.Date;
import java.text.SimpleDateFormat;

/**
 *
 * <p>Title: 日志操作类</p>
 * <p>Description: 记录导入导出的情况</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */
public class DataLog {
    public DataLog() {
    }

    /**
     *
     * @param id String 被记录的id
     * @param source String 数据源 : 权力运行 权利标准(分标准)
     * @param operateType String 操作类型 ( 发布 更新 删除 )
     */
    public static void logDataOperate(CDataImpl dImpl,String id,String source,String operateType){
//        System.out.println(source+":::" + id + "::" + operateType);
//        String oldTableName = dImpl.getTableName();
//        String oldPrimaryFieldName = dImpl.getPrimaryFieldName();
        dImpl = new CDataImpl(dImpl.dataCn);
        dImpl.setTableName("tb_qlgk_powerstdlog");
        dImpl.setPrimaryFieldName("id");
//        dImpl.setPrimaryKeyType(CDataImpl.LONG);

        dImpl.addNew();

        String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.0").format(new Date());
        //主键ID
        //dImpl.setValue("id", result.get("ppid"), CDataImpl.LONG);
        dImpl.setValue("UPDATETIME", time, CDataImpl.DATE);
        if("powerstd".equals(source)){
            dImpl.setValue("POWERSTD_ID", id, CDataImpl.LONG);
        }else if("subpowerstd".equals(source)){
            dImpl.setValue("SUBPOWERSTD_ID", id, CDataImpl.LONG);
        }else if("powerprocess".equals(source)){
            dImpl.setValue("POWERPROCESS_ID", id,
                           CDataImpl.LONG);
        }
        dImpl.setValue("UPDATETYPE", operateType, CDataImpl.STRING);

        dImpl.update();
        dImpl.closeStmt();
//        dImpl.setTableName(oldTableName);
//        dImpl.setPrimaryFieldName(oldPrimaryFieldName);

    }

    public static void main(String args[]){
        System.out.println(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.0").format(new Date()));
    }


}
