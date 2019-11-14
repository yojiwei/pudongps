package com.beyondbit.struts.form;

import org.apache.struts.action.ActionForm;
import com.beyondbit.hibernate.TbQlgkPsfile;
import org.apache.struts.upload.FormFile;

public class FileForm extends ActionForm{
    private com.beyondbit.hibernate.TbQlgkPsfile file = new TbQlgkPsfile();
    //文件
    private FormFile edocdata;
    //示意图
    private FormFile diagrampicdata;

    public FileForm() {
    }

    public com.beyondbit.hibernate.TbQlgkPsfile getFile() {
        return file;
    }



    public void setFile(com.beyondbit.hibernate.TbQlgkPsfile file) {
        this.file = file;
    }

    public FormFile getDiagrampicdata() {
        return diagrampicdata;
    }
    public FormFile getEdocdata() {
        return edocdata;
    }
    public void setDiagrampicdata(FormFile diagrampicdata) {
        this.diagrampicdata = diagrampicdata;
    }
    public void setEdocdata(FormFile edocdata) {
        this.edocdata = edocdata;
    }


}
