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

public class BasisImpl extends DefaultHandler implements Cloneable, Unmarshallable, LexicalHandler, Basis {

    private Name name;
    private Type type;
    private Effectdate effectdate;
    private Unitname unitname;
    private Content content;

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

    private static BasisImpl prototype = null;

    public static void setPrototype(BasisImpl prototype) {
        BasisImpl.prototype = prototype;
    }
    public static BasisImpl newInstance() {
        try {
            return (prototype!=null)?(BasisImpl)prototype.clone(): new BasisImpl();
        } catch (CloneNotSupportedException e) {
            return null; // never
        }
    }
    public BasisImpl() {
        docTypeString = "";
        hasDTD = false;
        validate = false;
        namespaceMappings = new HashMap();
    }

    public Name getName() {
        return name;
    }

    public void setName(Name name) {
        this.name = name;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public Effectdate getEffectdate() {
        return effectdate;
    }

    public void setEffectdate(Effectdate effectdate) {
        this.effectdate = effectdate;
    }

    public Unitname getUnitname() {
        return unitname;
    }

    public void setUnitname(Unitname unitname) {
        this.unitname = unitname;
    }

    public Content getContent() {
        return content;
    }

    public void setContent(Content content) {
        this.content = content;
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
        writer.write("<basis");

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
        if (name != null) {
            ((NameImpl)name).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (type != null) {
            ((TypeImpl)type).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (effectdate != null) {
            ((EffectdateImpl)effectdate).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (unitname != null) {
            ((UnitnameImpl)unitname).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (content != null) {
            ((ContentImpl)content).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        writer.write(indent);
        writer.write("</basis>\n");
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

    public static Basis unmarshal(File file) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new FileReader(file));
    }

    public static Basis unmarshal(File file, boolean validate) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new FileReader(file), validate);
    }

    public static Basis unmarshal(InputStream inputStream) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new InputStreamReader(inputStream));
    }

    public static Basis unmarshal(InputStream inputStream, boolean validate) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new InputStreamReader(inputStream), validate);
    }

    public static Basis unmarshal(Reader reader) throws IOException {
        // Delegate with default validation value
        return unmarshal(reader, false);
    }

    public static Basis unmarshal(Reader reader, boolean validate) throws IOException {
        BasisImpl basis = BasisImpl.newInstance();
        basis.setValidating(validate);
        basis.setCurrentUNode(basis);
        basis.setParentUNode(null);
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
            parser.setErrorHandler(basis);

            // Register lexical handler
            parser.setProperty("http://xml.org/sax/properties/lexical-handler", basis);

            // Register content handler
            parser.setContentHandler(basis);
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
        return basis;
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
        if ((localName.equalsIgnoreCase("basis")) && (!zeus_thisNodeHandled)) {
            // Handle ourselves
            for (int i=0, len=atts.getLength(); i<len; i++) {
                String attName= atts.getLocalName(i);
                String attValue = atts.getValue(i);
            }
            zeus_thisNodeHandled = true;
            return;
        } else {
            // Delegate handling
            if (localName.equalsIgnoreCase("name") && (name==null)) {
                NameImpl name = NameImpl.newInstance();
                current = getCurrentUNode();
                name.setParentUNode(current);
                name.setCurrentUNode(name);
                this.setCurrentUNode(name);
                name.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.name = name;
                return;
            }
            if (localName.equalsIgnoreCase("type") && (type==null)) {
                TypeImpl type = TypeImpl.newInstance();
                current = getCurrentUNode();
                type.setParentUNode(current);
                type.setCurrentUNode(type);
                this.setCurrentUNode(type);
                type.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.type = type;
                return;
            }
            if (localName.equalsIgnoreCase("effectdate") && (effectdate==null)) {
                EffectdateImpl effectdate = EffectdateImpl.newInstance();
                current = getCurrentUNode();
                effectdate.setParentUNode(current);
                effectdate.setCurrentUNode(effectdate);
                this.setCurrentUNode(effectdate);
                effectdate.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.effectdate = effectdate;
                return;
            }
            if (localName.equalsIgnoreCase("unitname") && (unitname==null)) {
                UnitnameImpl unitname = UnitnameImpl.newInstance();
                current = getCurrentUNode();
                unitname.setParentUNode(current);
                unitname.setCurrentUNode(unitname);
                this.setCurrentUNode(unitname);
                unitname.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.unitname = unitname;
                return;
            }
            if (localName.equalsIgnoreCase("content") && (content==null)) {
                ContentImpl content = ContentImpl.newInstance();
                current = getCurrentUNode();
                content.setParentUNode(current);
                content.setCurrentUNode(content);
                this.setCurrentUNode(content);
                content.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.content = content;
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
