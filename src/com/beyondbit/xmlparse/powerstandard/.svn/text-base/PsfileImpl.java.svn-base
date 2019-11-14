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

public class PsfileImpl extends DefaultHandler implements Cloneable, Unmarshallable, LexicalHandler, Psfile {

    private Sfid sfid;
    private Fileid fileid;
    private Filecode filecode;
    private Filename filename;
    private Isopen isopen;
    private Ismust ismust;
    private Isinput isinput;
    private Isoutput isoutput;
    private Edocname edocname;
    private Edoctype edoctype;
    private Edocdata edocdata;
    private Des des;
    private Diagrampicname diagrampicname;
    private Diagrampictype diagrampictype;
    private Diagrampicdata diagrampicdata;

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

    private static PsfileImpl prototype = null;

    public static void setPrototype(PsfileImpl prototype) {
        PsfileImpl.prototype = prototype;
    }
    public static PsfileImpl newInstance() {
        try {
            return (prototype!=null)?(PsfileImpl)prototype.clone(): new PsfileImpl();
        } catch (CloneNotSupportedException e) {
            return null; // never
        }
    }
    public PsfileImpl() {
        docTypeString = "";
        hasDTD = false;
        validate = false;
        namespaceMappings = new HashMap();
    }

    public Sfid getSfid() {
        return sfid;
    }

    public void setSfid(Sfid sfid) {
        this.sfid = sfid;
    }

    public Fileid getFileid() {
        return fileid;
    }

    public void setFileid(Fileid fileid) {
        this.fileid = fileid;
    }

    public Filecode getFilecode() {
        return filecode;
    }

    public void setFilecode(Filecode filecode) {
        this.filecode = filecode;
    }

    public Filename getFilename() {
        return filename;
    }

    public void setFilename(Filename filename) {
        this.filename = filename;
    }

    public Isopen getIsopen() {
        return isopen;
    }

    public void setIsopen(Isopen isopen) {
        this.isopen = isopen;
    }

    public Ismust getIsmust() {
        return ismust;
    }

    public void setIsmust(Ismust ismust) {
        this.ismust = ismust;
    }

    public Isinput getIsinput() {
        return isinput;
    }

    public void setIsinput(Isinput isinput) {
        this.isinput = isinput;
    }

    public Isoutput getIsoutput() {
        return isoutput;
    }

    public void setIsoutput(Isoutput isoutput) {
        this.isoutput = isoutput;
    }

    public Edocname getEdocname() {
        return edocname;
    }

    public void setEdocname(Edocname edocname) {
        this.edocname = edocname;
    }

    public Edoctype getEdoctype() {
        return edoctype;
    }

    public void setEdoctype(Edoctype edoctype) {
        this.edoctype = edoctype;
    }

    public Edocdata getEdocdata() {
        return edocdata;
    }

    public void setEdocdata(Edocdata edocdata) {
        this.edocdata = edocdata;
    }

    public Des getDes() {
        return des;
    }

    public void setDes(Des des) {
        this.des = des;
    }

    public Diagrampicname getDiagrampicname() {
        return diagrampicname;
    }

    public void setDiagrampicname(Diagrampicname diagrampicname) {
        this.diagrampicname = diagrampicname;
    }

    public Diagrampictype getDiagrampictype() {
        return diagrampictype;
    }

    public void setDiagrampictype(Diagrampictype diagrampictype) {
        this.diagrampictype = diagrampictype;
    }

    public Diagrampicdata getDiagrampicdata() {
        return diagrampicdata;
    }

    public void setDiagrampicdata(Diagrampicdata diagrampicdata) {
        this.diagrampicdata = diagrampicdata;
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
        writer.write("<psfile");

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
        if (sfid != null) {
            ((SfidImpl)sfid).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (fileid != null) {
            ((FileidImpl)fileid).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (filecode != null) {
            ((FilecodeImpl)filecode).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (filename != null) {
            ((FilenameImpl)filename).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (isopen != null) {
            ((IsopenImpl)isopen).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (ismust != null) {
            ((IsmustImpl)ismust).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (isinput != null) {
            ((IsinputImpl)isinput).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (isoutput != null) {
            ((IsoutputImpl)isoutput).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (edocname != null) {
            ((EdocnameImpl)edocname).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (edoctype != null) {
            ((EdoctypeImpl)edoctype).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (edocdata != null) {
            ((EdocdataImpl)edocdata).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (des != null) {
            ((DesImpl)des).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (diagrampicname != null) {
            ((DiagrampicnameImpl)diagrampicname).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (diagrampictype != null) {
            ((DiagrampictypeImpl)diagrampictype).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (diagrampicdata != null) {
            ((DiagrampicdataImpl)diagrampicdata).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        writer.write(indent);
        writer.write("</psfile>\n");
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

    public static Psfile unmarshal(File file) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new FileReader(file));
    }

    public static Psfile unmarshal(File file, boolean validate) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new FileReader(file), validate);
    }

    public static Psfile unmarshal(InputStream inputStream) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new InputStreamReader(inputStream));
    }

    public static Psfile unmarshal(InputStream inputStream, boolean validate) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new InputStreamReader(inputStream), validate);
    }

    public static Psfile unmarshal(Reader reader) throws IOException {
        // Delegate with default validation value
        return unmarshal(reader, false);
    }

    public static Psfile unmarshal(Reader reader, boolean validate) throws IOException {
        PsfileImpl psfile = PsfileImpl.newInstance();
        psfile.setValidating(validate);
        psfile.setCurrentUNode(psfile);
        psfile.setParentUNode(null);
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
            parser.setErrorHandler(psfile);

            // Register lexical handler
            parser.setProperty("http://xml.org/sax/properties/lexical-handler", psfile);

            // Register content handler
            parser.setContentHandler(psfile);
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
        return psfile;
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
        if ((localName.equalsIgnoreCase("psfile")) && (!zeus_thisNodeHandled)) {
            // Handle ourselves
            for (int i=0, len=atts.getLength(); i<len; i++) {
                String attName= atts.getLocalName(i);
                String attValue = atts.getValue(i);
            }
            zeus_thisNodeHandled = true;
            return;
        } else {
            // Delegate handling
            if (localName.equalsIgnoreCase("sfid") && (sfid==null)) {
                SfidImpl sfid = SfidImpl.newInstance();
                current = getCurrentUNode();
                sfid.setParentUNode(current);
                sfid.setCurrentUNode(sfid);
                this.setCurrentUNode(sfid);
                sfid.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.sfid = sfid;
                return;
            }
            if (localName.equalsIgnoreCase("fileid") && (fileid==null)) {
                FileidImpl fileid = FileidImpl.newInstance();
                current = getCurrentUNode();
                fileid.setParentUNode(current);
                fileid.setCurrentUNode(fileid);
                this.setCurrentUNode(fileid);
                fileid.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.fileid = fileid;
                return;
            }
            if (localName.equalsIgnoreCase("filecode") && (filecode==null)) {
                FilecodeImpl filecode = FilecodeImpl.newInstance();
                current = getCurrentUNode();
                filecode.setParentUNode(current);
                filecode.setCurrentUNode(filecode);
                this.setCurrentUNode(filecode);
                filecode.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.filecode = filecode;
                return;
            }
            if (localName.equalsIgnoreCase("filename") && (filename==null)) {
                FilenameImpl filename = FilenameImpl.newInstance();
                current = getCurrentUNode();
                filename.setParentUNode(current);
                filename.setCurrentUNode(filename);
                this.setCurrentUNode(filename);
                filename.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.filename = filename;
                return;
            }
            if (localName.equalsIgnoreCase("isopen") && (isopen==null)) {
                IsopenImpl isopen = IsopenImpl.newInstance();
                current = getCurrentUNode();
                isopen.setParentUNode(current);
                isopen.setCurrentUNode(isopen);
                this.setCurrentUNode(isopen);
                isopen.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.isopen = isopen;
                return;
            }
            if (localName.equalsIgnoreCase("ismust") && (ismust==null)) {
                IsmustImpl ismust = IsmustImpl.newInstance();
                current = getCurrentUNode();
                ismust.setParentUNode(current);
                ismust.setCurrentUNode(ismust);
                this.setCurrentUNode(ismust);
                ismust.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.ismust = ismust;
                return;
            }
            if (localName.equalsIgnoreCase("isinput") && (isinput==null)) {
                IsinputImpl isinput = IsinputImpl.newInstance();
                current = getCurrentUNode();
                isinput.setParentUNode(current);
                isinput.setCurrentUNode(isinput);
                this.setCurrentUNode(isinput);
                isinput.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.isinput = isinput;
                return;
            }
            if (localName.equalsIgnoreCase("isoutput") && (isoutput==null)) {
                IsoutputImpl isoutput = IsoutputImpl.newInstance();
                current = getCurrentUNode();
                isoutput.setParentUNode(current);
                isoutput.setCurrentUNode(isoutput);
                this.setCurrentUNode(isoutput);
                isoutput.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.isoutput = isoutput;
                return;
            }
            if (localName.equalsIgnoreCase("edocname") && (edocname==null)) {
                EdocnameImpl edocname = EdocnameImpl.newInstance();
                current = getCurrentUNode();
                edocname.setParentUNode(current);
                edocname.setCurrentUNode(edocname);
                this.setCurrentUNode(edocname);
                edocname.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.edocname = edocname;
                return;
            }
            if (localName.equalsIgnoreCase("edoctype") && (edoctype==null)) {
                EdoctypeImpl edoctype = EdoctypeImpl.newInstance();
                current = getCurrentUNode();
                edoctype.setParentUNode(current);
                edoctype.setCurrentUNode(edoctype);
                this.setCurrentUNode(edoctype);
                edoctype.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.edoctype = edoctype;
                return;
            }
            if (localName.equalsIgnoreCase("edocdata") && (edocdata==null)) {
                EdocdataImpl edocdata = EdocdataImpl.newInstance();
                current = getCurrentUNode();
                edocdata.setParentUNode(current);
                edocdata.setCurrentUNode(edocdata);
                this.setCurrentUNode(edocdata);
                edocdata.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.edocdata = edocdata;
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
            if (localName.equalsIgnoreCase("diagrampicname") && (diagrampicname==null)) {
                DiagrampicnameImpl diagrampicname = DiagrampicnameImpl.newInstance();
                current = getCurrentUNode();
                diagrampicname.setParentUNode(current);
                diagrampicname.setCurrentUNode(diagrampicname);
                this.setCurrentUNode(diagrampicname);
                diagrampicname.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.diagrampicname = diagrampicname;
                return;
            }
            if (localName.equalsIgnoreCase("diagrampictype") && (diagrampictype==null)) {
                DiagrampictypeImpl diagrampictype = DiagrampictypeImpl.newInstance();
                current = getCurrentUNode();
                diagrampictype.setParentUNode(current);
                diagrampictype.setCurrentUNode(diagrampictype);
                this.setCurrentUNode(diagrampictype);
                diagrampictype.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.diagrampictype = diagrampictype;
                return;
            }
            if (localName.equalsIgnoreCase("diagrampicdata") && (diagrampicdata==null)) {
                DiagrampicdataImpl diagrampicdata = DiagrampicdataImpl.newInstance();
                current = getCurrentUNode();
                diagrampicdata.setParentUNode(current);
                diagrampicdata.setCurrentUNode(diagrampicdata);
                this.setCurrentUNode(diagrampicdata);
                diagrampicdata.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.diagrampicdata = diagrampicdata;
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
