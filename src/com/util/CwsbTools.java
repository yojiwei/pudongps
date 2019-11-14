// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   CwsbTools.java

package com.util;

import java.util.Calendar;
import java.util.Hashtable;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;

public class CwsbTools
{

    public CwsbTools()
    {
    }

    public static String tranOwContent(String sourceStr)
    {
        Calendar calendar = Calendar.getInstance();
        String extLsh = "";
        extLsh = String.valueOf(calendar.get(14));
        String targetStr = "";
        int indexNum = 0;
        String tempStr1 = "";
        String tempStr2 = "";
        indexNum = sourceStr.indexOf("mctlts");
        if(indexNum > 0)
        {
            tempStr1 = sourceStr.substring(0, indexNum - 2);
            tempStr2 = sourceStr.substring(indexNum - 2);
            targetStr = tempStr1 + extLsh + tempStr2;
        } else
        {
            targetStr = sourceStr;
        }
        return targetStr;
    }

    public static void getContent(String ow_id){
    	CDataCn dCn = null;
    	CDataImpl dImpl = null;
    	String sql = "select ow_content from tb_onlinework where ow_id = '"+ ow_id +"'";
    	Hashtable table = null;
    	try{
    		//update by yao
    		//dCn = new CDataCn("wsb");
    		dCn = new CDataCn();
    		dImpl = new CDataImpl(dCn);
    		table = dImpl.getDataInfo(sql);
    		if(table != null){
    			System.out.println(CTools.dealNull(table.get("ow_content")));
    		}
    	}catch(Exception e){
    		System.out.println(e.getMessage());
    	}finally{
    		dImpl.closeStmt();
    		dCn.closeCn();
    	}
    }
    
    public static void main(String args[])
    {
//        String sourceStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><邀请外国人来沪申请表><基本信息 byzzryjk=\"我公司现有员工260余人，75%以上为本科专业人才，硕士以上人才8名。\" dbtmc=\"上海互联网软件有限公司CALVIN ZHONG TANG LI\" fwdd=\"上海\" gjlf=\"申请人自理\" gnfy=\"申请人自理\" lfmd=\"工作\" lsh=\"B200812445\" mctlts=\"365\" nrjrq=\"2008-5-10\" qzjg=\"洛杉矶\" qzjgyw=\"LOS ANGELES\" qzyxcs=\"\" qzzl=\"工作签证\" rs=\"1\" sbdw=\"上海互联网软件有限公司\" sbdwyw=\"Shanghai Internet Software Co.,Ltd.\" tbrq=\"2008-5-6 10:24:02\" yqdwbh=\"shbeyondbit\" yqly=\"我公司与微软公司合作项目，需要有外国生活背景的技术类人才担任项目内部的沟通以及组织。\"/><人员信息><人员 csrq=\"1983-1-13\" dw=\"上海互联网软件有限公司\" gj=\"美国\" gjyw=\"U.S.A\" hzdqrq=\"2012-6-23\" hzhm=\"206776771\" hzqfrq=\"2002-6-24\" xb=\"男\" xm=\"CALVIN ZHONG TANG LI\" zw=\"软件开发\"/></人员信息><被邀请人通信方式 cz=\"021-50766016\" dh=\"13167235862\" dz=\"上海市天钥桥路968弄2号楼1301室\" yb=\"200122\" yj=\"lizhongtang@beyondbit.com\"/><外籍工作人员情况 jyxkzh=\"沪外许2008-4465\" nrzw=\"项目经理\" prnx=\"1\" wjrydh=\"021-50706888\" zhdz=\"上海市天钥桥路968弄2号楼1301室\"/><申请单位 sqdwdh=\"021-50706888\" sqdwlxr=\"孙冰磊\" sqdwtxdz=\"上海市浦东居家桥路955弄2号1~3层\" sqdwyzbm=\"200136\" zqdwyj=\"sunbl@beyondbit.com\"/><备注></备注><处理方式 clfs1=\"\" clfs2=\"\"/><附件 contentsize=\"0\" contenttype=\"\" filename=\"\" name=\"\"></附件></邀请外国人来沪申请表>";
//        tranOwContent(sourceStr);
//    	getContent("72434");
    }
}
