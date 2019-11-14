// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   Permunte.java

package com.PermuteData;


// Referenced classes of package com.PermuteData:
//            PostInfo, PostCG, GetUserEdit

public class Permunte
{

    public Permunte()
    {
    }

    public String getJHid()
    {
        PostInfo psio = new PostInfo();
        String trues = psio.getJHID();
        psio.Pt("申办单位信息管理模块_交换数据ID数组", trues);
        return trues;
    }

    public String getJHValue(String jhid)
    {
        PostInfo psio = new PostInfo();
        String trues = psio.getInfo(jhid);
        psio.Pt("申办单位信息管理模块_获得交换信息数据", jhid);
        return trues;
    }

    public void retJHID(String jhid, String value)
    {
        PostInfo psio = new PostInfo();
        psio.retJHID(jhid, value);
        psio.Pt("申办单位信息管理模块_返回成功信息ID", jhid);
    }

    public void setPost(String us_id, String el_type, String huifu)
    {
        PostInfo psio = new PostInfo();
        psio.setPost(us_id, el_type, huifu);
        psio.Pt("申办单位信息管理模块_审批完成信息", "");
    }

    public String getCGID()
    {
        PostCG pcg = new PostCG();
        String trues = pcg.GetXMlSize();
        pcg.Pt("因公出国_交换数据ID数组", trues);
        return trues;
    }

    public String getCGXML(String cgid)
    {
        PostCG pcg = new PostCG();
        pcg.Pt("因公出国_交换信息", cgid);
        return pcg.GetXMl(cgid);
    }

    public void setCGStID(String cgid, String stuats)
    {
        PostCG pcg = new PostCG();
        pcg.Pt("因公出国_交换反馈", cgid);
        pcg.SetSTATUS(cgid, stuats);
    }

    public void setStatus(String wo_id, String huifu, String status)
    {
        PostCG pcg = new PostCG();
        pcg.Pt("因公出国_回复信息", wo_id);
        pcg.UpStatus(wo_id, huifu, status);
    }
    //环保局修改
    public void setHbjStatus(String wo_id,String wo_name, String huifu, String status,String us_uid)
    {
        PostCG pcg = new PostCG();
        pcg.Pt("环保局办事_回复信息", wo_id);
        pcg.UpHbjStatus(wo_id,wo_name, huifu, status ,us_uid);
    }

    public void UserPass(String name, String pass)
    {
        GetUserEdit gue = new GetUserEdit();
        gue.Pt("用户密码修改", name);
        gue.UserPass(name, pass);
    }

    public void UserPope(String name, String value)
    {
        GetUserEdit gue = new GetUserEdit();
        gue.Pt("用户申请权限修改", name);
        gue.EditUsetPope(name, value);
    }
    public static void main(String args[]){
    	Permunte pp = new Permunte();
    	pp.UserPass("shpdfao1", "123456");
    }
}
