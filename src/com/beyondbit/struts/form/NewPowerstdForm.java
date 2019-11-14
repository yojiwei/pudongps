package com.beyondbit.struts.form;

import org.apache.struts.action.*;
import com.beyondbit.hibernate.*;
import java.util.Set;
import java.util.List;
import org.apache.struts.upload.FormFile;
import java.util.HashSet;

public class NewPowerstdForm extends ActionForm{
    //权力标准
    private com.beyondbit.hibernate.TbQlgkPowerstd std=new com.beyondbit.hibernate.TbQlgkPowerstd();
    //分标准
    private TbQlgkSubpowerstd substd= new TbQlgkSubpowerstd();
    {
        substd.setTbQlgkPowerstdsteps(new HashSet());
    }
    //标准材料
    private List files;

    private String substdid;

    private String psid;

    private FormFile lpic;
    private FormFile spic;

    public NewPowerstdForm() {
    }
    public List getFiles() {
        return files;
    }
    public String getPsid() {
        return psid;
    }
    public com.beyondbit.hibernate.TbQlgkPowerstd getStd() {
        return std;
    }
    public TbQlgkSubpowerstd getSubstd() {
        return substd;
    }
    public String getSubstdid() {
        return substdid;
    }
    public void setSubstdid(String substdid) {
        this.substdid = substdid;
    }
    public void setSubstd(TbQlgkSubpowerstd substd) {
        this.substd = substd;
    }
    public void setStd(com.beyondbit.hibernate.TbQlgkPowerstd std) {
        this.std = std;
    }
    public void setPsid(String psid) {
        this.psid = psid;
    }
    public void setFiles(List files) {
        this.files = files;
    }
    public FormFile getSpic() {
        return spic;
    }
    public FormFile getLpic() {
        return lpic;
    }
    public void setLpic(FormFile lpic) {
        this.lpic = lpic;
    }
    public void setSpic(FormFile spic) {
        this.spic = spic;
    }
}
