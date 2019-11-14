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

// Global Implementation Import Statements
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.Writer;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import org.xml.sax.EntityResolver;
import org.xml.sax.ErrorHandler;
import org.xml.sax.InputSource;
import org.xml.sax.Locator;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;
import org.xml.sax.XMLReader;
import org.xml.sax.ext.LexicalHandler;
import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.helpers.XMLReaderFactory;

public class PowerstdImpl extends DefaultHandler implements Cloneable, Unmarshallable, LexicalHandler, Powerstd {

    private Psid psid;
    private Cateid cateid;
    private Catename catename;
    private Pscode pscode;
    private Psname psname;
    private State state;
    private Validdate validdate;
    private Invaliddate invaliddate;
    private Createunitid createunitid;
    private Createunitcode createunitcode;
    private Createunitname createunitname;
    private Checkunitid checkunitid;
    private Checkunitcode checkunitcode;
    private Checkunitname checkunitname;
    private Aunitid aunitid;
    private Aunitcode aunitcode;
    private Aunitname aunitname;
    private Auserid auserid;
    private Ausername ausername;
    private Ajob ajob;
    private Bunitid bunitid;
    private Bunitcode bunitcode;
    private Bunitname bunitname;
    private Buserid buserid;
    private Busername busername;
    private Bjob bjob;
    private Attr1id attr1id;
    private Attr1name attr1name;
    private Attr2id attr2id;
    private Attr2name attr2name;
    private Attr3id attr3id;
    private Attr3name attr3name;
    private Attr4id attr4id;
    private Attr4name attr4name;
    private Attr5id attr5id;
    private Attr5name attr5name;
    private Ispc ispc;
    private Diagrampiclname diagrampiclname;
    private Diagrampicltype diagrampicltype;
    private Diagrampicldata diagrampicldata;
    private Diagrampicsname diagrampicsname;
    private Diagrampicstype diagrampicstype;
    private Diagrampicsdata diagrampicsdata;
    private Lawbasisname lawbasisname;
    private Lawbasis lawbasis;
    private Basises basises;
    private Duetimelimit duetimelimit;
    private Pslimit pslimit;
    private Pslimitunit pslimitunit;
    private Openscope openscope;
    private Des des;
    private Createdate createdate;
    private Createuserid createuserid;
    private Createusername createusername;
    private Checkdate checkdate;
    private Checkuserid checkuserid;
    private Checkusername checkusername;
    private Prevstep prevstep;
    private Nextstep nextstep;
    private Subpowerstds subpowerstds;

    /** Any DOCTYPE reference/statements. */
    private String docTypeString;

    /** The encoding for the output document */
    private String outputEncoding;

    /** The current node in unmarshalling */
    private Unmarshallable zeus_currentUNode;

    /** The parent node in unmarshalling */
    private Unmarshallable zeus_parentUNode;

    /** Whether this node has been handled */
    private boolean zeus_thisNodeHandled = false;

    /** Whether a DTD exists for an unmarshal call */
    private boolean hasDTD;

    /** Whether validation is occurring */
    private boolean validate;

    /** The namespace mappings on this element */
    private Map namespaceMappings;

    /** The EntityResolver for SAX parsing to use */
    private static EntityResolver entityResolver;

    /** The ErrorHandler for SAX parsing to use */
    private static ErrorHandler errorHandler;

    private static PowerstdImpl prototype = null;

    public static void setPrototype(PowerstdImpl prototype) {
        PowerstdImpl.prototype = prototype;
    }
    public static PowerstdImpl newInstance() {
        try {
            return (prototype!=null)?(PowerstdImpl)prototype.clone(): new PowerstdImpl();
        } catch (CloneNotSupportedException e) {
            return null; // never
        }
    }
    public PowerstdImpl() {
        docTypeString = "";
        hasDTD = false;
        validate = false;
        namespaceMappings = new HashMap();
    }

    public Psid getPsid() {
        return psid;
    }

    public void setPsid(Psid psid) {
        this.psid = psid;
    }

    public Cateid getCateid() {
        return cateid;
    }

    public void setCateid(Cateid cateid) {
        this.cateid = cateid;
    }

    public Catename getCatename() {
        return catename;
    }

    public void setCatename(Catename catename) {
        this.catename = catename;
    }

    public Pscode getPscode() {
        return pscode;
    }

    public void setPscode(Pscode pscode) {
        this.pscode = pscode;
    }

    public Psname getPsname() {
        return psname;
    }

    public void setPsname(Psname psname) {
        this.psname = psname;
    }

    public State getState() {
        return state;
    }

    public void setState(State state) {
        this.state = state;
    }

    public Validdate getValiddate() {
        return validdate;
    }

    public void setValiddate(Validdate validdate) {
        this.validdate = validdate;
    }

    public Invaliddate getInvaliddate() {
        return invaliddate;
    }

    public void setInvaliddate(Invaliddate invaliddate) {
        this.invaliddate = invaliddate;
    }

    public Createunitid getCreateunitid() {
        return createunitid;
    }

    public void setCreateunitid(Createunitid createunitid) {
        this.createunitid = createunitid;
    }

    public Createunitcode getCreateunitcode() {
        return createunitcode;
    }

    public void setCreateunitcode(Createunitcode createunitcode) {
        this.createunitcode = createunitcode;
    }

    public Createunitname getCreateunitname() {
        return createunitname;
    }

    public void setCreateunitname(Createunitname createunitname) {
        this.createunitname = createunitname;
    }

    public Checkunitid getCheckunitid() {
        return checkunitid;
    }

    public void setCheckunitid(Checkunitid checkunitid) {
        this.checkunitid = checkunitid;
    }

    public Checkunitcode getCheckunitcode() {
        return checkunitcode;
    }

    public void setCheckunitcode(Checkunitcode checkunitcode) {
        this.checkunitcode = checkunitcode;
    }

    public Checkunitname getCheckunitname() {
        return checkunitname;
    }

    public void setCheckunitname(Checkunitname checkunitname) {
        this.checkunitname = checkunitname;
    }

    public Aunitid getAunitid() {
        return aunitid;
    }

    public void setAunitid(Aunitid aunitid) {
        this.aunitid = aunitid;
    }

    public Aunitcode getAunitcode() {
        return aunitcode;
    }

    public void setAunitcode(Aunitcode aunitcode) {
        this.aunitcode = aunitcode;
    }

    public Aunitname getAunitname() {
        return aunitname;
    }

    public void setAunitname(Aunitname aunitname) {
        this.aunitname = aunitname;
    }

    public Auserid getAuserid() {
        return auserid;
    }

    public void setAuserid(Auserid auserid) {
        this.auserid = auserid;
    }

    public Ausername getAusername() {
        return ausername;
    }

    public void setAusername(Ausername ausername) {
        this.ausername = ausername;
    }

    public Ajob getAjob() {
        return ajob;
    }

    public void setAjob(Ajob ajob) {
        this.ajob = ajob;
    }

    public Bunitid getBunitid() {
        return bunitid;
    }

    public void setBunitid(Bunitid bunitid) {
        this.bunitid = bunitid;
    }

    public Bunitcode getBunitcode() {
        return bunitcode;
    }

    public void setBunitcode(Bunitcode bunitcode) {
        this.bunitcode = bunitcode;
    }

    public Bunitname getBunitname() {
        return bunitname;
    }

    public void setBunitname(Bunitname bunitname) {
        this.bunitname = bunitname;
    }

    public Buserid getBuserid() {
        return buserid;
    }

    public void setBuserid(Buserid buserid) {
        this.buserid = buserid;
    }

    public Busername getBusername() {
        return busername;
    }

    public void setBusername(Busername busername) {
        this.busername = busername;
    }

    public Bjob getBjob() {
        return bjob;
    }

    public void setBjob(Bjob bjob) {
        this.bjob = bjob;
    }

    public Attr1id getAttr1id() {
        return attr1id;
    }

    public void setAttr1id(Attr1id attr1id) {
        this.attr1id = attr1id;
    }

    public Attr1name getAttr1name() {
        return attr1name;
    }

    public void setAttr1name(Attr1name attr1name) {
        this.attr1name = attr1name;
    }

    public Attr2id getAttr2id() {
        return attr2id;
    }

    public void setAttr2id(Attr2id attr2id) {
        this.attr2id = attr2id;
    }

    public Attr2name getAttr2name() {
        return attr2name;
    }

    public void setAttr2name(Attr2name attr2name) {
        this.attr2name = attr2name;
    }

    public Attr3id getAttr3id() {
        return attr3id;
    }

    public void setAttr3id(Attr3id attr3id) {
        this.attr3id = attr3id;
    }

    public Attr3name getAttr3name() {
        return attr3name;
    }

    public void setAttr3name(Attr3name attr3name) {
        this.attr3name = attr3name;
    }

    public Attr4id getAttr4id() {
        return attr4id;
    }

    public void setAttr4id(Attr4id attr4id) {
        this.attr4id = attr4id;
    }

    public Attr4name getAttr4name() {
        return attr4name;
    }

    public void setAttr4name(Attr4name attr4name) {
        this.attr4name = attr4name;
    }

    public Attr5id getAttr5id() {
        return attr5id;
    }

    public void setAttr5id(Attr5id attr5id) {
        this.attr5id = attr5id;
    }

    public Attr5name getAttr5name() {
        return attr5name;
    }

    public void setAttr5name(Attr5name attr5name) {
        this.attr5name = attr5name;
    }

    public Ispc getIspc() {
        return ispc;
    }

    public void setIspc(Ispc ispc) {
        this.ispc = ispc;
    }

    public Diagrampiclname getDiagrampiclname() {
        return diagrampiclname;
    }

    public void setDiagrampiclname(Diagrampiclname diagrampiclname) {
        this.diagrampiclname = diagrampiclname;
    }

    public Diagrampicltype getDiagrampicltype() {
        return diagrampicltype;
    }

    public void setDiagrampicltype(Diagrampicltype diagrampicltype) {
        this.diagrampicltype = diagrampicltype;
    }

    public Diagrampicldata getDiagrampicldata() {
        return diagrampicldata;
    }

    public void setDiagrampicldata(Diagrampicldata diagrampicldata) {
        this.diagrampicldata = diagrampicldata;
    }

    public Diagrampicsname getDiagrampicsname() {
        return diagrampicsname;
    }

    public void setDiagrampicsname(Diagrampicsname diagrampicsname) {
        this.diagrampicsname = diagrampicsname;
    }

    public Diagrampicstype getDiagrampicstype() {
        return diagrampicstype;
    }

    public void setDiagrampicstype(Diagrampicstype diagrampicstype) {
        this.diagrampicstype = diagrampicstype;
    }

    public Diagrampicsdata getDiagrampicsdata() {
        return diagrampicsdata;
    }

    public void setDiagrampicsdata(Diagrampicsdata diagrampicsdata) {
        this.diagrampicsdata = diagrampicsdata;
    }

    public Lawbasisname getLawbasisname() {
        return lawbasisname;
    }

    public void setLawbasisname(Lawbasisname lawbasisname) {
        this.lawbasisname = lawbasisname;
    }

    public Lawbasis getLawbasis() {
        return lawbasis;
    }

    public void setLawbasis(Lawbasis lawbasis) {
        this.lawbasis = lawbasis;
    }

    public Basises getBasises() {
        return basises;
    }

    public void setBasises(Basises basises) {
        this.basises = basises;
    }

    public Duetimelimit getDuetimelimit() {
        return duetimelimit;
    }

    public void setDuetimelimit(Duetimelimit duetimelimit) {
        this.duetimelimit = duetimelimit;
    }

    public Pslimit getPslimit() {
        return pslimit;
    }

    public void setPslimit(Pslimit pslimit) {
        this.pslimit = pslimit;
    }

    public Pslimitunit getPslimitunit() {
        return pslimitunit;
    }

    public void setPslimitunit(Pslimitunit pslimitunit) {
        this.pslimitunit = pslimitunit;
    }

    public Openscope getOpenscope() {
        return openscope;
    }

    public void setOpenscope(Openscope openscope) {
        this.openscope = openscope;
    }

    public Des getDes() {
        return des;
    }

    public void setDes(Des des) {
        this.des = des;
    }

    public Createdate getCreatedate() {
        return createdate;
    }

    public void setCreatedate(Createdate createdate) {
        this.createdate = createdate;
    }

    public Createuserid getCreateuserid() {
        return createuserid;
    }

    public void setCreateuserid(Createuserid createuserid) {
        this.createuserid = createuserid;
    }

    public Createusername getCreateusername() {
        return createusername;
    }

    public void setCreateusername(Createusername createusername) {
        this.createusername = createusername;
    }

    public Checkdate getCheckdate() {
        return checkdate;
    }

    public void setCheckdate(Checkdate checkdate) {
        this.checkdate = checkdate;
    }

    public Checkuserid getCheckuserid() {
        return checkuserid;
    }

    public void setCheckuserid(Checkuserid checkuserid) {
        this.checkuserid = checkuserid;
    }

    public Checkusername getCheckusername() {
        return checkusername;
    }

    public void setCheckusername(Checkusername checkusername) {
        this.checkusername = checkusername;
    }

    public Prevstep getPrevstep() {
        return prevstep;
    }

    public void setPrevstep(Prevstep prevstep) {
        this.prevstep = prevstep;
    }

    public Nextstep getNextstep() {
        return nextstep;
    }

    public void setNextstep(Nextstep nextstep) {
        this.nextstep = nextstep;
    }

    public Subpowerstds getSubpowerstds() {
        return subpowerstds;
    }

    public void setSubpowerstds(Subpowerstds subpowerstds) {
        this.subpowerstds = subpowerstds;
    }

    public void setDocType(String name, String publicID, String systemID) {
        try {
            startDTD(name, publicID, systemID);
        } catch (SAXException neverHappens) { }
    }

    public void setOutputEncoding(String outputEncoding) {
        this.outputEncoding = outputEncoding;
    }

    public void marshal(File file) throws IOException {
        // Delegate to the marshal(Writer) method
        marshal(new FileWriter(file));
    }

    public void marshal(OutputStream outputStream) throws IOException {
        // Delegate to the marshal(Writer) method
        marshal(new OutputStreamWriter(outputStream));
    }

    public void marshal(Writer writer) throws IOException {
        // Write out the XML declaration
        writer.write("<?xml version=\"1.0\" ");
        if (outputEncoding != null) {
            writer.write("encoding=\"");
            writer.write(outputEncoding);
            writer.write("\"?>\n\n");

        } else {
            writer.write("encoding=\"UTF-8\"?>\n\n");

        }
        // Handle DOCTYPE declaration
        writer.write(docTypeString);
        writer.write("\n");
        // Now start the recursive writing
        writeXMLRepresentation(writer, "");

        // Close up
        writer.flush();
        writer.close();
    }

    protected void writeXMLRepresentation(Writer writer,
                                          String indent)
        throws IOException {

        writer.write(indent);
        writer.write("<powerstd");

        // Handle namespace mappings (if needed)
        for (Iterator i = namespaceMappings.keySet().iterator(); i.hasNext(); ) {
            String prefix = (String)i.next();
            String uri = (String)namespaceMappings.get(prefix);
            writer.write(" xmlns");
            if (!prefix.trim().equals("")) {
                writer.write(":");
                writer.write(prefix);
            }
            writer.write("=\"");
            writer.write(uri);
            writer.write("\"\n        ");
        }

        // Handle attributes (if needed)
        writer.write(">");
        writer.write("\n");

        // Handle child elements
        if (psid != null) {
            ((PsidImpl)psid).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (cateid != null) {
            ((CateidImpl)cateid).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (catename != null) {
            ((CatenameImpl)catename).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (pscode != null) {
            ((PscodeImpl)pscode).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (psname != null) {
            ((PsnameImpl)psname).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (state != null) {
            ((StateImpl)state).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (validdate != null) {
            ((ValiddateImpl)validdate).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (invaliddate != null) {
            ((InvaliddateImpl)invaliddate).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (createunitid != null) {
            ((CreateunitidImpl)createunitid).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (createunitcode != null) {
            ((CreateunitcodeImpl)createunitcode).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (createunitname != null) {
            ((CreateunitnameImpl)createunitname).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (checkunitid != null) {
            ((CheckunitidImpl)checkunitid).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (checkunitcode != null) {
            ((CheckunitcodeImpl)checkunitcode).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (checkunitname != null) {
            ((CheckunitnameImpl)checkunitname).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (aunitid != null) {
            ((AunitidImpl)aunitid).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (aunitcode != null) {
            ((AunitcodeImpl)aunitcode).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (aunitname != null) {
            ((AunitnameImpl)aunitname).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (auserid != null) {
            ((AuseridImpl)auserid).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (ausername != null) {
            ((AusernameImpl)ausername).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (ajob != null) {
            ((AjobImpl)ajob).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (bunitid != null) {
            ((BunitidImpl)bunitid).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (bunitcode != null) {
            ((BunitcodeImpl)bunitcode).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (bunitname != null) {
            ((BunitnameImpl)bunitname).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (buserid != null) {
            ((BuseridImpl)buserid).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (busername != null) {
            ((BusernameImpl)busername).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (bjob != null) {
            ((BjobImpl)bjob).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (attr1id != null) {
            ((Attr1idImpl)attr1id).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (attr1name != null) {
            ((Attr1nameImpl)attr1name).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (attr2id != null) {
            ((Attr2idImpl)attr2id).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (attr2name != null) {
            ((Attr2nameImpl)attr2name).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (attr3id != null) {
            ((Attr3idImpl)attr3id).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (attr3name != null) {
            ((Attr3nameImpl)attr3name).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (attr4id != null) {
            ((Attr4idImpl)attr4id).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (attr4name != null) {
            ((Attr4nameImpl)attr4name).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (attr5id != null) {
            ((Attr5idImpl)attr5id).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (attr5name != null) {
            ((Attr5nameImpl)attr5name).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (ispc != null) {
            ((IspcImpl)ispc).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (diagrampiclname != null) {
            ((DiagrampiclnameImpl)diagrampiclname).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (diagrampicltype != null) {
            ((DiagrampicltypeImpl)diagrampicltype).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (diagrampicldata != null) {
            ((DiagrampicldataImpl)diagrampicldata).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (diagrampicsname != null) {
            ((DiagrampicsnameImpl)diagrampicsname).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (diagrampicstype != null) {
            ((DiagrampicstypeImpl)diagrampicstype).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (diagrampicsdata != null) {
            ((DiagrampicsdataImpl)diagrampicsdata).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (lawbasisname != null) {
            ((LawbasisnameImpl)lawbasisname).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (lawbasis != null) {
            ((LawbasisImpl)lawbasis).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (basises != null) {
            ((BasisesImpl)basises).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (duetimelimit != null) {
            ((DuetimelimitImpl)duetimelimit).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (pslimit != null) {
            ((PslimitImpl)pslimit).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (pslimitunit != null) {
            ((PslimitunitImpl)pslimitunit).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (openscope != null) {
            ((OpenscopeImpl)openscope).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (des != null) {
            ((DesImpl)des).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (createdate != null) {
            ((CreatedateImpl)createdate).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (createuserid != null) {
            ((CreateuseridImpl)createuserid).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (createusername != null) {
            ((CreateusernameImpl)createusername).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (checkdate != null) {
            ((CheckdateImpl)checkdate).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (checkuserid != null) {
            ((CheckuseridImpl)checkuserid).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (checkusername != null) {
            ((CheckusernameImpl)checkusername).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (prevstep != null) {
            ((PrevstepImpl)prevstep).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (nextstep != null) {
            ((NextstepImpl)nextstep).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (subpowerstds != null) {
            ((SubpowerstdsImpl)subpowerstds).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        writer.write(indent);
        writer.write("</powerstd>\n");
    }

    private String escapeAttributeValue(String attributeValue) {
        String returnValue = attributeValue;
        for (int i = 0; i < returnValue.length(); i++) {
            char ch = returnValue.charAt(i);
            if (ch == '"') {
                returnValue = new StringBuffer()
                    .append(returnValue.substring(0, i))
                    .append("&quot;")
                    .append(returnValue.substring(i+1))
                    .toString();
            }
        }
        return returnValue;
    }

    private String escapeTextValue(String textValue) {
        String returnValue = textValue;
        for (int i = 0; i < returnValue.length(); i++) {
            char ch = returnValue.charAt(i);
            if (ch == '<') {
                returnValue = new StringBuffer()
                    .append(returnValue.substring(0, i))
                    .append("&lt;")
                    .append(returnValue.substring(i+1))
                    .toString();
            } else if (ch == '>') {
                returnValue = new StringBuffer()
                    .append(returnValue.substring(0, i))
                    .append("&gt;")
                    .append(returnValue.substring(i+1))
                    .toString();
            }
        }
        return returnValue;
    }

    /**
     * <p>
     *  This sets a SAX <code>EntityResolver</code> for this unmarshalling process.
     * </p>
     *
     * @param resolver the entity resolver to use.
     */
    public static void setEntityResolver(EntityResolver resolver) {
        entityResolver = resolver;
    }

    /**
     * <p>
     *  This sets a SAX <code>ErrorHandler</code> for this unmarshalling process.
     * </p>
     *
     * @param handler the entity resolver to use.
     */
    public static void setErrorHandler(ErrorHandler handler) {
        errorHandler = handler;
    }

    public static Powerstd unmarshal(File file) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new FileReader(file));
    }

    public static Powerstd unmarshal(File file, boolean validate) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new FileReader(file), validate);
    }

    public static Powerstd unmarshal(InputStream inputStream) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new InputStreamReader(inputStream));
    }

    public static Powerstd unmarshal(InputStream inputStream, boolean validate) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new InputStreamReader(inputStream), validate);
    }

    public static Powerstd unmarshal(Reader reader) throws IOException {
        // Delegate with default validation value
        return unmarshal(reader, false);
    }

    public static Powerstd unmarshal(Reader reader, boolean validate) throws IOException {
        PowerstdImpl powerstd = PowerstdImpl.newInstance();
        powerstd.setValidating(validate);
        powerstd.setCurrentUNode(powerstd);
        powerstd.setParentUNode(null);
        // Load the XML parser
        XMLReader parser = null;
        String parserClass = System.getProperty("org.xml.sax.driver",
            "org.apache.xerces.parsers.SAXParser");
        try {
            parser = XMLReaderFactory.createXMLReader(parserClass);

            // Set entity resolver, if needed
            if (entityResolver != null) {
                parser.setEntityResolver(entityResolver);
            }

            // Set error handler
            parser.setErrorHandler(powerstd);

            // Register lexical handler
            parser.setProperty("http://xml.org/sax/properties/lexical-handler", powerstd);

            // Register content handler
            parser.setContentHandler(powerstd);
        } catch (SAXException e) {
            throw new IOException("Could not load XML parser: " +
                e.getMessage());
        }

        InputSource inputSource = new InputSource(reader);
        try {
            parser.setFeature("http://xml.org/sax/features/validation", new Boolean(validate).booleanValue());
            parser.setFeature("http://xml.org/sax/features/namespaces", true);
            parser.setFeature("http://xml.org/sax/features/namespace-prefixes", false);
            parser.parse(inputSource);
        } catch (SAXException e) {
            throw new IOException("Error parsing XML document: " +
                e.getMessage());
        }

        // Return the resultant object
        return powerstd;
    }

    public Unmarshallable getParentUNode() {
        return zeus_parentUNode;
    }

    public void setParentUNode(Unmarshallable parentUNode) {
        this.zeus_parentUNode = parentUNode;
    }

    public Unmarshallable getCurrentUNode() {
        return zeus_currentUNode;
    }

    public void setCurrentUNode(Unmarshallable currentUNode) {
        this.zeus_currentUNode = currentUNode;
    }

    public void setValidating(boolean validate) {
        this.validate = validate;
    }

    public void startDocument() throws SAXException {
        // no-op
    }

    public void setDocumentLocator(Locator locator) {
        // no-op
    }

    public void startPrefixMapping(String prefix, String uri)
        throws SAXException {
        namespaceMappings.put(prefix, uri);
    }

    public void startElement(String namespaceURI, String localName,
                             String qName, org.xml.sax.Attributes atts)
        throws SAXException {

        // Feed this to the correct ContentHandler
        Unmarshallable current = getCurrentUNode();
        if (current != this) {
            current.startElement(namespaceURI, localName, qName, atts);
            return;
        }

        // See if we handle, or we delegate
        if ((localName.equalsIgnoreCase("powerstd")) && (!zeus_thisNodeHandled)) {
            // Handle ourselves
            for (int i=0, len=atts.getLength(); i<len; i++) {
                String attName= atts.getLocalName(i);
                String attValue = atts.getValue(i);
            }
            zeus_thisNodeHandled = true;
            return;
        } else {
            // Delegate handling
            if (localName.equalsIgnoreCase("psid") && (psid==null)) {
                PsidImpl psid = PsidImpl.newInstance();
                current = getCurrentUNode();
                psid.setParentUNode(current);
                psid.setCurrentUNode(psid);
                this.setCurrentUNode(psid);
                psid.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.psid = psid;
                return;
            }
            if (localName.equalsIgnoreCase("cateid") && (cateid==null)) {
                CateidImpl cateid = CateidImpl.newInstance();
                current = getCurrentUNode();
                cateid.setParentUNode(current);
                cateid.setCurrentUNode(cateid);
                this.setCurrentUNode(cateid);
                cateid.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.cateid = cateid;
                return;
            }
            if (localName.equalsIgnoreCase("catename") && (catename==null)) {
                CatenameImpl catename = CatenameImpl.newInstance();
                current = getCurrentUNode();
                catename.setParentUNode(current);
                catename.setCurrentUNode(catename);
                this.setCurrentUNode(catename);
                catename.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.catename = catename;
                return;
            }
            if (localName.equalsIgnoreCase("pscode") && (pscode==null)) {
                PscodeImpl pscode = PscodeImpl.newInstance();
                current = getCurrentUNode();
                pscode.setParentUNode(current);
                pscode.setCurrentUNode(pscode);
                this.setCurrentUNode(pscode);
                pscode.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.pscode = pscode;
                return;
            }
            if (localName.equalsIgnoreCase("psname") && (psname==null)) {
                PsnameImpl psname = PsnameImpl.newInstance();
                current = getCurrentUNode();
                psname.setParentUNode(current);
                psname.setCurrentUNode(psname);
                this.setCurrentUNode(psname);
                psname.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.psname = psname;
                return;
            }
            if (localName.equalsIgnoreCase("state") && (state==null)) {
                StateImpl state = StateImpl.newInstance();
                current = getCurrentUNode();
                state.setParentUNode(current);
                state.setCurrentUNode(state);
                this.setCurrentUNode(state);
                state.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.state = state;
                return;
            }
            if (localName.equalsIgnoreCase("validdate") && (validdate==null)) {
                ValiddateImpl validdate = ValiddateImpl.newInstance();
                current = getCurrentUNode();
                validdate.setParentUNode(current);
                validdate.setCurrentUNode(validdate);
                this.setCurrentUNode(validdate);
                validdate.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.validdate = validdate;
                return;
            }
            if (localName.equalsIgnoreCase("invaliddate") && (invaliddate==null)) {
                InvaliddateImpl invaliddate = InvaliddateImpl.newInstance();
                current = getCurrentUNode();
                invaliddate.setParentUNode(current);
                invaliddate.setCurrentUNode(invaliddate);
                this.setCurrentUNode(invaliddate);
                invaliddate.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.invaliddate = invaliddate;
                return;
            }
            if (localName.equalsIgnoreCase("createunitid") && (createunitid==null)) {
                CreateunitidImpl createunitid = CreateunitidImpl.newInstance();
                current = getCurrentUNode();
                createunitid.setParentUNode(current);
                createunitid.setCurrentUNode(createunitid);
                this.setCurrentUNode(createunitid);
                createunitid.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.createunitid = createunitid;
                return;
            }
            if (localName.equalsIgnoreCase("createunitcode") && (createunitcode==null)) {
                CreateunitcodeImpl createunitcode = CreateunitcodeImpl.newInstance();
                current = getCurrentUNode();
                createunitcode.setParentUNode(current);
                createunitcode.setCurrentUNode(createunitcode);
                this.setCurrentUNode(createunitcode);
                createunitcode.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.createunitcode = createunitcode;
                return;
            }
            if (localName.equalsIgnoreCase("createunitname") && (createunitname==null)) {
                CreateunitnameImpl createunitname = CreateunitnameImpl.newInstance();
                current = getCurrentUNode();
                createunitname.setParentUNode(current);
                createunitname.setCurrentUNode(createunitname);
                this.setCurrentUNode(createunitname);
                createunitname.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.createunitname = createunitname;
                return;
            }
            if (localName.equalsIgnoreCase("checkunitid") && (checkunitid==null)) {
                CheckunitidImpl checkunitid = CheckunitidImpl.newInstance();
                current = getCurrentUNode();
                checkunitid.setParentUNode(current);
                checkunitid.setCurrentUNode(checkunitid);
                this.setCurrentUNode(checkunitid);
                checkunitid.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.checkunitid = checkunitid;
                return;
            }
            if (localName.equalsIgnoreCase("checkunitcode") && (checkunitcode==null)) {
                CheckunitcodeImpl checkunitcode = CheckunitcodeImpl.newInstance();
                current = getCurrentUNode();
                checkunitcode.setParentUNode(current);
                checkunitcode.setCurrentUNode(checkunitcode);
                this.setCurrentUNode(checkunitcode);
                checkunitcode.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.checkunitcode = checkunitcode;
                return;
            }
            if (localName.equalsIgnoreCase("checkunitname") && (checkunitname==null)) {
                CheckunitnameImpl checkunitname = CheckunitnameImpl.newInstance();
                current = getCurrentUNode();
                checkunitname.setParentUNode(current);
                checkunitname.setCurrentUNode(checkunitname);
                this.setCurrentUNode(checkunitname);
                checkunitname.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.checkunitname = checkunitname;
                return;
            }
            if (localName.equalsIgnoreCase("aunitid") && (aunitid==null)) {
                AunitidImpl aunitid = AunitidImpl.newInstance();
                current = getCurrentUNode();
                aunitid.setParentUNode(current);
                aunitid.setCurrentUNode(aunitid);
                this.setCurrentUNode(aunitid);
                aunitid.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.aunitid = aunitid;
                return;
            }
            if (localName.equalsIgnoreCase("aunitcode") && (aunitcode==null)) {
                AunitcodeImpl aunitcode = AunitcodeImpl.newInstance();
                current = getCurrentUNode();
                aunitcode.setParentUNode(current);
                aunitcode.setCurrentUNode(aunitcode);
                this.setCurrentUNode(aunitcode);
                aunitcode.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.aunitcode = aunitcode;
                return;
            }
            if (localName.equalsIgnoreCase("aunitname") && (aunitname==null)) {
                AunitnameImpl aunitname = AunitnameImpl.newInstance();
                current = getCurrentUNode();
                aunitname.setParentUNode(current);
                aunitname.setCurrentUNode(aunitname);
                this.setCurrentUNode(aunitname);
                aunitname.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.aunitname = aunitname;
                return;
            }
            if (localName.equalsIgnoreCase("auserid") && (auserid==null)) {
                AuseridImpl auserid = AuseridImpl.newInstance();
                current = getCurrentUNode();
                auserid.setParentUNode(current);
                auserid.setCurrentUNode(auserid);
                this.setCurrentUNode(auserid);
                auserid.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.auserid = auserid;
                return;
            }
            if (localName.equalsIgnoreCase("ausername") && (ausername==null)) {
                AusernameImpl ausername = AusernameImpl.newInstance();
                current = getCurrentUNode();
                ausername.setParentUNode(current);
                ausername.setCurrentUNode(ausername);
                this.setCurrentUNode(ausername);
                ausername.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.ausername = ausername;
                return;
            }
            if (localName.equalsIgnoreCase("ajob") && (ajob==null)) {
                AjobImpl ajob = AjobImpl.newInstance();
                current = getCurrentUNode();
                ajob.setParentUNode(current);
                ajob.setCurrentUNode(ajob);
                this.setCurrentUNode(ajob);
                ajob.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.ajob = ajob;
                return;
            }
            if (localName.equalsIgnoreCase("bunitid") && (bunitid==null)) {
                BunitidImpl bunitid = BunitidImpl.newInstance();
                current = getCurrentUNode();
                bunitid.setParentUNode(current);
                bunitid.setCurrentUNode(bunitid);
                this.setCurrentUNode(bunitid);
                bunitid.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.bunitid = bunitid;
                return;
            }
            if (localName.equalsIgnoreCase("bunitcode") && (bunitcode==null)) {
                BunitcodeImpl bunitcode = BunitcodeImpl.newInstance();
                current = getCurrentUNode();
                bunitcode.setParentUNode(current);
                bunitcode.setCurrentUNode(bunitcode);
                this.setCurrentUNode(bunitcode);
                bunitcode.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.bunitcode = bunitcode;
                return;
            }
            if (localName.equalsIgnoreCase("bunitname") && (bunitname==null)) {
                BunitnameImpl bunitname = BunitnameImpl.newInstance();
                current = getCurrentUNode();
                bunitname.setParentUNode(current);
                bunitname.setCurrentUNode(bunitname);
                this.setCurrentUNode(bunitname);
                bunitname.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.bunitname = bunitname;
                return;
            }
            if (localName.equalsIgnoreCase("buserid") && (buserid==null)) {
                BuseridImpl buserid = BuseridImpl.newInstance();
                current = getCurrentUNode();
                buserid.setParentUNode(current);
                buserid.setCurrentUNode(buserid);
                this.setCurrentUNode(buserid);
                buserid.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.buserid = buserid;
                return;
            }
            if (localName.equalsIgnoreCase("busername") && (busername==null)) {
                BusernameImpl busername = BusernameImpl.newInstance();
                current = getCurrentUNode();
                busername.setParentUNode(current);
                busername.setCurrentUNode(busername);
                this.setCurrentUNode(busername);
                busername.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.busername = busername;
                return;
            }
            if (localName.equalsIgnoreCase("bjob") && (bjob==null)) {
                BjobImpl bjob = BjobImpl.newInstance();
                current = getCurrentUNode();
                bjob.setParentUNode(current);
                bjob.setCurrentUNode(bjob);
                this.setCurrentUNode(bjob);
                bjob.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.bjob = bjob;
                return;
            }
            if (localName.equalsIgnoreCase("attr1id") && (attr1id==null)) {
                Attr1idImpl attr1id = Attr1idImpl.newInstance();
                current = getCurrentUNode();
                attr1id.setParentUNode(current);
                attr1id.setCurrentUNode(attr1id);
                this.setCurrentUNode(attr1id);
                attr1id.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.attr1id = attr1id;
                return;
            }
            if (localName.equalsIgnoreCase("attr1name") && (attr1name==null)) {
                Attr1nameImpl attr1name = Attr1nameImpl.newInstance();
                current = getCurrentUNode();
                attr1name.setParentUNode(current);
                attr1name.setCurrentUNode(attr1name);
                this.setCurrentUNode(attr1name);
                attr1name.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.attr1name = attr1name;
                return;
            }
            if (localName.equalsIgnoreCase("attr2id") && (attr2id==null)) {
                Attr2idImpl attr2id = Attr2idImpl.newInstance();
                current = getCurrentUNode();
                attr2id.setParentUNode(current);
                attr2id.setCurrentUNode(attr2id);
                this.setCurrentUNode(attr2id);
                attr2id.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.attr2id = attr2id;
                return;
            }
            if (localName.equalsIgnoreCase("attr2name") && (attr2name==null)) {
                Attr2nameImpl attr2name = Attr2nameImpl.newInstance();
                current = getCurrentUNode();
                attr2name.setParentUNode(current);
                attr2name.setCurrentUNode(attr2name);
                this.setCurrentUNode(attr2name);
                attr2name.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.attr2name = attr2name;
                return;
            }
            if (localName.equalsIgnoreCase("attr3id") && (attr3id==null)) {
                Attr3idImpl attr3id = Attr3idImpl.newInstance();
                current = getCurrentUNode();
                attr3id.setParentUNode(current);
                attr3id.setCurrentUNode(attr3id);
                this.setCurrentUNode(attr3id);
                attr3id.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.attr3id = attr3id;
                return;
            }
            if (localName.equalsIgnoreCase("attr3name") && (attr3name==null)) {
                Attr3nameImpl attr3name = Attr3nameImpl.newInstance();
                current = getCurrentUNode();
                attr3name.setParentUNode(current);
                attr3name.setCurrentUNode(attr3name);
                this.setCurrentUNode(attr3name);
                attr3name.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.attr3name = attr3name;
                return;
            }
            if (localName.equalsIgnoreCase("attr4id") && (attr4id==null)) {
                Attr4idImpl attr4id = Attr4idImpl.newInstance();
                current = getCurrentUNode();
                attr4id.setParentUNode(current);
                attr4id.setCurrentUNode(attr4id);
                this.setCurrentUNode(attr4id);
                attr4id.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.attr4id = attr4id;
                return;
            }
            if (localName.equalsIgnoreCase("attr4name") && (attr4name==null)) {
                Attr4nameImpl attr4name = Attr4nameImpl.newInstance();
                current = getCurrentUNode();
                attr4name.setParentUNode(current);
                attr4name.setCurrentUNode(attr4name);
                this.setCurrentUNode(attr4name);
                attr4name.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.attr4name = attr4name;
                return;
            }
            if (localName.equalsIgnoreCase("attr5id") && (attr5id==null)) {
                Attr5idImpl attr5id = Attr5idImpl.newInstance();
                current = getCurrentUNode();
                attr5id.setParentUNode(current);
                attr5id.setCurrentUNode(attr5id);
                this.setCurrentUNode(attr5id);
                attr5id.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.attr5id = attr5id;
                return;
            }
            if (localName.equalsIgnoreCase("attr5name") && (attr5name==null)) {
                Attr5nameImpl attr5name = Attr5nameImpl.newInstance();
                current = getCurrentUNode();
                attr5name.setParentUNode(current);
                attr5name.setCurrentUNode(attr5name);
                this.setCurrentUNode(attr5name);
                attr5name.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.attr5name = attr5name;
                return;
            }
            if (localName.equalsIgnoreCase("ispc") && (ispc==null)) {
                IspcImpl ispc = IspcImpl.newInstance();
                current = getCurrentUNode();
                ispc.setParentUNode(current);
                ispc.setCurrentUNode(ispc);
                this.setCurrentUNode(ispc);
                ispc.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.ispc = ispc;
                return;
            }
            if (localName.equalsIgnoreCase("diagrampiclname") && (diagrampiclname==null)) {
                DiagrampiclnameImpl diagrampiclname = DiagrampiclnameImpl.newInstance();
                current = getCurrentUNode();
                diagrampiclname.setParentUNode(current);
                diagrampiclname.setCurrentUNode(diagrampiclname);
                this.setCurrentUNode(diagrampiclname);
                diagrampiclname.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.diagrampiclname = diagrampiclname;
                return;
            }
            if (localName.equalsIgnoreCase("diagrampicltype") && (diagrampicltype==null)) {
                DiagrampicltypeImpl diagrampicltype = DiagrampicltypeImpl.newInstance();
                current = getCurrentUNode();
                diagrampicltype.setParentUNode(current);
                diagrampicltype.setCurrentUNode(diagrampicltype);
                this.setCurrentUNode(diagrampicltype);
                diagrampicltype.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.diagrampicltype = diagrampicltype;
                return;
            }
            if (localName.equalsIgnoreCase("diagrampicldata") && (diagrampicldata==null)) {
                DiagrampicldataImpl diagrampicldata = DiagrampicldataImpl.newInstance();
                current = getCurrentUNode();
                diagrampicldata.setParentUNode(current);
                diagrampicldata.setCurrentUNode(diagrampicldata);
                this.setCurrentUNode(diagrampicldata);
                diagrampicldata.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.diagrampicldata = diagrampicldata;
                return;
            }
            if (localName.equalsIgnoreCase("diagrampicsname") && (diagrampicsname==null)) {
                DiagrampicsnameImpl diagrampicsname = DiagrampicsnameImpl.newInstance();
                current = getCurrentUNode();
                diagrampicsname.setParentUNode(current);
                diagrampicsname.setCurrentUNode(diagrampicsname);
                this.setCurrentUNode(diagrampicsname);
                diagrampicsname.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.diagrampicsname = diagrampicsname;
                return;
            }
            if (localName.equalsIgnoreCase("diagrampicstype") && (diagrampicstype==null)) {
                DiagrampicstypeImpl diagrampicstype = DiagrampicstypeImpl.newInstance();
                current = getCurrentUNode();
                diagrampicstype.setParentUNode(current);
                diagrampicstype.setCurrentUNode(diagrampicstype);
                this.setCurrentUNode(diagrampicstype);
                diagrampicstype.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.diagrampicstype = diagrampicstype;
                return;
            }
            if (localName.equalsIgnoreCase("diagrampicsdata") && (diagrampicsdata==null)) {
                DiagrampicsdataImpl diagrampicsdata = DiagrampicsdataImpl.newInstance();
                current = getCurrentUNode();
                diagrampicsdata.setParentUNode(current);
                diagrampicsdata.setCurrentUNode(diagrampicsdata);
                this.setCurrentUNode(diagrampicsdata);
                diagrampicsdata.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.diagrampicsdata = diagrampicsdata;
                return;
            }
            if (localName.equalsIgnoreCase("lawbasisname") && (lawbasisname==null)) {
                LawbasisnameImpl lawbasisname = LawbasisnameImpl.newInstance();
                current = getCurrentUNode();
                lawbasisname.setParentUNode(current);
                lawbasisname.setCurrentUNode(lawbasisname);
                this.setCurrentUNode(lawbasisname);
                lawbasisname.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.lawbasisname = lawbasisname;
                return;
            }
            if (localName.equalsIgnoreCase("lawbasis") && (lawbasis==null)) {
                LawbasisImpl lawbasis = LawbasisImpl.newInstance();
                current = getCurrentUNode();
                lawbasis.setParentUNode(current);
                lawbasis.setCurrentUNode(lawbasis);
                this.setCurrentUNode(lawbasis);
                lawbasis.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.lawbasis = lawbasis;
                return;
            }
            if (localName.equalsIgnoreCase("basises") && (basises==null)) {
                BasisesImpl basises = BasisesImpl.newInstance();
                current = getCurrentUNode();
                basises.setParentUNode(current);
                basises.setCurrentUNode(basises);
                this.setCurrentUNode(basises);
                basises.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.basises = basises;
                return;
            }
            if (localName.equalsIgnoreCase("duetimelimit") && (duetimelimit==null)) {
                DuetimelimitImpl duetimelimit = DuetimelimitImpl.newInstance();
                current = getCurrentUNode();
                duetimelimit.setParentUNode(current);
                duetimelimit.setCurrentUNode(duetimelimit);
                this.setCurrentUNode(duetimelimit);
                duetimelimit.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.duetimelimit = duetimelimit;
                return;
            }
            if (localName.equalsIgnoreCase("pslimit") && (pslimit==null)) {
                PslimitImpl pslimit = PslimitImpl.newInstance();
                current = getCurrentUNode();
                pslimit.setParentUNode(current);
                pslimit.setCurrentUNode(pslimit);
                this.setCurrentUNode(pslimit);
                pslimit.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.pslimit = pslimit;
                return;
            }
            if (localName.equalsIgnoreCase("pslimitunit") && (pslimitunit==null)) {
                PslimitunitImpl pslimitunit = PslimitunitImpl.newInstance();
                current = getCurrentUNode();
                pslimitunit.setParentUNode(current);
                pslimitunit.setCurrentUNode(pslimitunit);
                this.setCurrentUNode(pslimitunit);
                pslimitunit.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.pslimitunit = pslimitunit;
                return;
            }
            if (localName.equalsIgnoreCase("openscope") && (openscope==null)) {
                OpenscopeImpl openscope = OpenscopeImpl.newInstance();
                current = getCurrentUNode();
                openscope.setParentUNode(current);
                openscope.setCurrentUNode(openscope);
                this.setCurrentUNode(openscope);
                openscope.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.openscope = openscope;
                return;
            }
            if (localName.equalsIgnoreCase("des") && (des==null)) {
                DesImpl des = DesImpl.newInstance();
                current = getCurrentUNode();
                des.setParentUNode(current);
                des.setCurrentUNode(des);
                this.setCurrentUNode(des);
                des.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.des = des;
                return;
            }
            if (localName.equalsIgnoreCase("createdate") && (createdate==null)) {
                CreatedateImpl createdate = CreatedateImpl.newInstance();
                current = getCurrentUNode();
                createdate.setParentUNode(current);
                createdate.setCurrentUNode(createdate);
                this.setCurrentUNode(createdate);
                createdate.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.createdate = createdate;
                return;
            }
            if (localName.equalsIgnoreCase("createuserid") && (createuserid==null)) {
                CreateuseridImpl createuserid = CreateuseridImpl.newInstance();
                current = getCurrentUNode();
                createuserid.setParentUNode(current);
                createuserid.setCurrentUNode(createuserid);
                this.setCurrentUNode(createuserid);
                createuserid.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.createuserid = createuserid;
                return;
            }
            if (localName.equalsIgnoreCase("createusername") && (createusername==null)) {
                CreateusernameImpl createusername = CreateusernameImpl.newInstance();
                current = getCurrentUNode();
                createusername.setParentUNode(current);
                createusername.setCurrentUNode(createusername);
                this.setCurrentUNode(createusername);
                createusername.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.createusername = createusername;
                return;
            }
            if (localName.equalsIgnoreCase("checkdate") && (checkdate==null)) {
                CheckdateImpl checkdate = CheckdateImpl.newInstance();
                current = getCurrentUNode();
                checkdate.setParentUNode(current);
                checkdate.setCurrentUNode(checkdate);
                this.setCurrentUNode(checkdate);
                checkdate.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.checkdate = checkdate;
                return;
            }
            if (localName.equalsIgnoreCase("checkuserid") && (checkuserid==null)) {
                CheckuseridImpl checkuserid = CheckuseridImpl.newInstance();
                current = getCurrentUNode();
                checkuserid.setParentUNode(current);
                checkuserid.setCurrentUNode(checkuserid);
                this.setCurrentUNode(checkuserid);
                checkuserid.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.checkuserid = checkuserid;
                return;
            }
            if (localName.equalsIgnoreCase("checkusername") && (checkusername==null)) {
                CheckusernameImpl checkusername = CheckusernameImpl.newInstance();
                current = getCurrentUNode();
                checkusername.setParentUNode(current);
                checkusername.setCurrentUNode(checkusername);
                this.setCurrentUNode(checkusername);
                checkusername.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.checkusername = checkusername;
                return;
            }
            if (localName.equalsIgnoreCase("prevstep") && (prevstep==null)) {
                PrevstepImpl prevstep = PrevstepImpl.newInstance();
                current = getCurrentUNode();
                prevstep.setParentUNode(current);
                prevstep.setCurrentUNode(prevstep);
                this.setCurrentUNode(prevstep);
                prevstep.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.prevstep = prevstep;
                return;
            }
            if (localName.equalsIgnoreCase("nextstep") && (nextstep==null)) {
                NextstepImpl nextstep = NextstepImpl.newInstance();
                current = getCurrentUNode();
                nextstep.setParentUNode(current);
                nextstep.setCurrentUNode(nextstep);
                this.setCurrentUNode(nextstep);
                nextstep.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.nextstep = nextstep;
                return;
            }
            if (localName.equalsIgnoreCase("subpowerstds") && (subpowerstds==null)) {
                SubpowerstdsImpl subpowerstds = SubpowerstdsImpl.newInstance();
                current = getCurrentUNode();
                subpowerstds.setParentUNode(current);
                subpowerstds.setCurrentUNode(subpowerstds);
                this.setCurrentUNode(subpowerstds);
                subpowerstds.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.subpowerstds = subpowerstds;
                return;
            }
        }
    }

    public void endElement(String namespaceURI, String localName,
                           String qName)
        throws SAXException {

        Unmarshallable current = getCurrentUNode();
        if (current != this) {
            current.endElement(namespaceURI, localName, qName);
            return;
        }

        Unmarshallable parent = getCurrentUNode().getParentUNode();
        if (parent != null) {
            parent.setCurrentUNode(parent);
        }
    }

    public void characters(char[] ch, int start, int len)
        throws SAXException {

        // Feed this to the correct ContentHandler
        Unmarshallable current = getCurrentUNode();
        if (current != this) {
            current.characters(ch, start, len);
            return;
        }

        String text = new String(ch, start, len);
        text = text.trim();
    }

    public void comment(char ch[], int start, int len) throws SAXException {
        // Currently no-op
    }

    public void warning(SAXParseException e) throws SAXException {
        if (errorHandler != null) {
            errorHandler.warning(e);
        }
    }

    public void error(SAXParseException e) throws SAXException {
        if ((validate) && (!hasDTD)) {
            throw new SAXException("Validation is turned on, but no DTD has been specified in the input XML document. Please supply a DTD through a DOCTYPE reference.");
        }
        if (errorHandler != null) {
            errorHandler.error(e);
        }
    }

    public void fatalError(SAXParseException e) throws SAXException {
        if ((validate) && (!hasDTD)) {
            throw new SAXException("Validation is turned on, but no DTD has been specified in the input XML document. Please supply a DTD through a DOCTYPE reference.");
        }
        if (errorHandler != null) {
            errorHandler.fatalError(e);
        }
    }

    public void startDTD(String name, String publicID, String systemID)
        throws SAXException {

        if ((name == null) || (name.equals(""))) {
            docTypeString = "";
            return;
        }

        hasDTD = true;
        StringBuffer docTypeSB = new StringBuffer();
        boolean hasPublic = false;

        docTypeSB.append("<!DOCTYPE ")
                 .append(name);

        if ((publicID != null) && (!publicID.equals(""))) {
            docTypeSB.append(" PUBLIC \"")
                     .append(publicID)
                     .append("\"");
            hasPublic = true;
        }

        if ((systemID != null) && (!systemID.equals(""))) {
            if (!hasPublic) {
                docTypeSB.append(" SYSTEM");
            }
            docTypeSB.append(" \"")
                     .append(systemID)
                     .append("\"");

        }

        docTypeSB.append(">");

        docTypeString = docTypeSB.toString();
    }

    public void endDTD() throws SAXException {
        // Currently no-op
    }

    public void startEntity(String name) throws SAXException {
        // Currently no-op
    }

    public void endEntity(String name) throws SAXException {
        // Currently no-op
    }

    public void startCDATA() throws SAXException {
        // Currently no-op
    }

    public void endCDATA() throws SAXException {
        // Currently no-op
    }

}
