/**
 * This class was generated from a set of XML constraints
 *   by the Enhydra Zeus XML Data Binding Framework. All
 *   source code in this file is constructed specifically
 *   to work with other Zeus-generated classes. If you
 *   modify this file by hand, you run the risk of breaking
 *   this interoperation, as well as introducing errors in
 *   source code compilation.
 *
 * * * * * MODIFY THIS FILE AT YOUR OWN RISK * * * * *
 *
 * To find out more about the Enhydra Zeus framework, you
 *   can point your browser at <http://zeus.enhydra.org>
 *   where you can download releases, join and discuss Zeus
 *   on user and developer mailing lists, and access source
 *   code. Please report any bugs through that website.
 */
package com.beyondbit.xmlparse.powerstandard;

// Global Interface Import Statements
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.Writer;

// Local Interface Import Statements
import java.io.Serializable;

public interface Powerstd extends Serializable {

    public static final String ZEUS_XML_NAME = "powerstd";
    public static final String[] ZEUS_ATTRIBUTES = {};
    public static final String[] ZEUS_ELEMENTS = {"psid", "cateid", "catename", "pscode", "psname", "state", "validdate", "invaliddate", "createunitid", "createunitcode", "createunitname", "checkunitid", "checkunitcode", "checkunitname", "aunitid", "aunitcode", "aunitname", "auserid", "ausername", "ajob", "bunitid", "bunitcode", "bunitname", "buserid", "busername", "bjob", "attr1id", "attr1name", "attr2id", "attr2name", "attr3id", "attr3name", "attr4id", "attr4name", "attr5id", "attr5name", "ispc", "diagrampiclname", "diagrampicltype", "diagrampicldata", "diagrampicsname", "diagrampicstype", "diagrampicsdata", "lawbasisname", "lawbasis", "basises", "duetimelimit", "pslimit", "pslimitunit", "openscope", "des", "createdate", "createuserid", "createusername", "checkdate", "checkuserid", "checkusername", "prevstep", "nextstep", "subpowerstds"};

    public Psid getPsid();

    public void setPsid(Psid psid);

    public Cateid getCateid();

    public void setCateid(Cateid cateid);

    public Catename getCatename();

    public void setCatename(Catename catename);

    public Pscode getPscode();

    public void setPscode(Pscode pscode);

    public Psname getPsname();

    public void setPsname(Psname psname);

    public State getState();

    public void setState(State state);

    public Validdate getValiddate();

    public void setValiddate(Validdate validdate);

    public Invaliddate getInvaliddate();

    public void setInvaliddate(Invaliddate invaliddate);

    public Createunitid getCreateunitid();

    public void setCreateunitid(Createunitid createunitid);

    public Createunitcode getCreateunitcode();

    public void setCreateunitcode(Createunitcode createunitcode);

    public Createunitname getCreateunitname();

    public void setCreateunitname(Createunitname createunitname);

    public Checkunitid getCheckunitid();

    public void setCheckunitid(Checkunitid checkunitid);

    public Checkunitcode getCheckunitcode();

    public void setCheckunitcode(Checkunitcode checkunitcode);

    public Checkunitname getCheckunitname();

    public void setCheckunitname(Checkunitname checkunitname);

    public Aunitid getAunitid();

    public void setAunitid(Aunitid aunitid);

    public Aunitcode getAunitcode();

    public void setAunitcode(Aunitcode aunitcode);

    public Aunitname getAunitname();

    public void setAunitname(Aunitname aunitname);

    public Auserid getAuserid();

    public void setAuserid(Auserid auserid);

    public Ausername getAusername();

    public void setAusername(Ausername ausername);

    public Ajob getAjob();

    public void setAjob(Ajob ajob);

    public Bunitid getBunitid();

    public void setBunitid(Bunitid bunitid);

    public Bunitcode getBunitcode();

    public void setBunitcode(Bunitcode bunitcode);

    public Bunitname getBunitname();

    public void setBunitname(Bunitname bunitname);

    public Buserid getBuserid();

    public void setBuserid(Buserid buserid);

    public Busername getBusername();

    public void setBusername(Busername busername);

    public Bjob getBjob();

    public void setBjob(Bjob bjob);

    public Attr1id getAttr1id();

    public void setAttr1id(Attr1id attr1id);

    public Attr1name getAttr1name();

    public void setAttr1name(Attr1name attr1name);

    public Attr2id getAttr2id();

    public void setAttr2id(Attr2id attr2id);

    public Attr2name getAttr2name();

    public void setAttr2name(Attr2name attr2name);

    public Attr3id getAttr3id();

    public void setAttr3id(Attr3id attr3id);

    public Attr3name getAttr3name();

    public void setAttr3name(Attr3name attr3name);

    public Attr4id getAttr4id();

    public void setAttr4id(Attr4id attr4id);

    public Attr4name getAttr4name();

    public void setAttr4name(Attr4name attr4name);

    public Attr5id getAttr5id();

    public void setAttr5id(Attr5id attr5id);

    public Attr5name getAttr5name();

    public void setAttr5name(Attr5name attr5name);

    public Ispc getIspc();

    public void setIspc(Ispc ispc);

    public Diagrampiclname getDiagrampiclname();

    public void setDiagrampiclname(Diagrampiclname diagrampiclname);

    public Diagrampicltype getDiagrampicltype();

    public void setDiagrampicltype(Diagrampicltype diagrampicltype);

    public Diagrampicldata getDiagrampicldata();

    public void setDiagrampicldata(Diagrampicldata diagrampicldata);

    public Diagrampicsname getDiagrampicsname();

    public void setDiagrampicsname(Diagrampicsname diagrampicsname);

    public Diagrampicstype getDiagrampicstype();

    public void setDiagrampicstype(Diagrampicstype diagrampicstype);

    public Diagrampicsdata getDiagrampicsdata();

    public void setDiagrampicsdata(Diagrampicsdata diagrampicsdata);

    public Lawbasisname getLawbasisname();

    public void setLawbasisname(Lawbasisname lawbasisname);

    public Lawbasis getLawbasis();

    public void setLawbasis(Lawbasis lawbasis);

    public Basises getBasises();

    public void setBasises(Basises basises);

    public Duetimelimit getDuetimelimit();

    public void setDuetimelimit(Duetimelimit duetimelimit);

    public Pslimit getPslimit();

    public void setPslimit(Pslimit pslimit);

    public Pslimitunit getPslimitunit();

    public void setPslimitunit(Pslimitunit pslimitunit);

    public Openscope getOpenscope();

    public void setOpenscope(Openscope openscope);

    public Des getDes();

    public void setDes(Des des);

    public Createdate getCreatedate();

    public void setCreatedate(Createdate createdate);

    public Createuserid getCreateuserid();

    public void setCreateuserid(Createuserid createuserid);

    public Createusername getCreateusername();

    public void setCreateusername(Createusername createusername);

    public Checkdate getCheckdate();

    public void setCheckdate(Checkdate checkdate);

    public Checkuserid getCheckuserid();

    public void setCheckuserid(Checkuserid checkuserid);

    public Checkusername getCheckusername();

    public void setCheckusername(Checkusername checkusername);

    public Prevstep getPrevstep();

    public void setPrevstep(Prevstep prevstep);

    public Nextstep getNextstep();

    public void setNextstep(Nextstep nextstep);

    public Subpowerstds getSubpowerstds();

    public void setSubpowerstds(Subpowerstds subpowerstds);

    public void marshal(File file) throws IOException;

    public void marshal(OutputStream outputStream) throws IOException;

    public void marshal(Writer writer) throws IOException;

    public void setDocType(String name, String publicID, String systemID);

    public void setOutputEncoding(String outputEncoding);

}
