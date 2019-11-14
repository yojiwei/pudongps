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

public class PowerstdstepImpl extends DefaultHandler implements Cloneable, Unmarshallable, LexicalHandler, Powerstdstep {

    private Stepid stepid;
    private Stepname stepname;
    private Rolename rolename;
    private Prevstepid prevstepid;
    private Nextstepid nextstepid;
    private Iskey iskey;
    private Isinner isinner;
    private Maxduetimelimit maxduetimelimit;
    private Maxpslimit maxpslimit;
    private Groupname groupname;
    private Audiodesname audiodesname;
    private Audiodestype audiodestype;
    private Audiodesdata audiodesdata;
    private Des des;
    private Stepfiles stepfiles;

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

    private static PowerstdstepImpl prototype = null;

    public static void setPrototype(PowerstdstepImpl prototype) {
        PowerstdstepImpl.prototype = prototype;
    }
    public static PowerstdstepImpl newInstance() {
        try {
            return (prototype!=null)?(PowerstdstepImpl)prototype.clone(): new PowerstdstepImpl();
        } catch (CloneNotSupportedException e) {
            return null; // never
        }
    }
    public PowerstdstepImpl() {
        docTypeString = "";
        hasDTD = false;
        validate = false;
        namespaceMappings = new HashMap();
    }

    public Stepid getStepid() {
        return stepid;
    }

    public void setStepid(Stepid stepid) {
        this.stepid = stepid;
    }

    public Stepname getStepname() {
        return stepname;
    }

    public void setStepname(Stepname stepname) {
        this.stepname = stepname;
    }

    public Rolename getRolename() {
        return rolename;
    }

    public void setRolename(Rolename rolename) {
        this.rolename = rolename;
    }

    public Prevstepid getPrevstepid() {
        return prevstepid;
    }

    public void setPrevstepid(Prevstepid prevstepid) {
        this.prevstepid = prevstepid;
    }

    public Nextstepid getNextstepid() {
        return nextstepid;
    }

    public void setNextstepid(Nextstepid nextstepid) {
        this.nextstepid = nextstepid;
    }

    public Iskey getIskey() {
        return iskey;
    }

    public void setIskey(Iskey iskey) {
        this.iskey = iskey;
    }

    public Isinner getIsinner() {
        return isinner;
    }

    public void setIsinner(Isinner isinner) {
        this.isinner = isinner;
    }

    public Maxduetimelimit getMaxduetimelimit() {
        return maxduetimelimit;
    }

    public void setMaxduetimelimit(Maxduetimelimit maxduetimelimit) {
        this.maxduetimelimit = maxduetimelimit;
    }

    public Maxpslimit getMaxpslimit() {
        return maxpslimit;
    }

    public void setMaxpslimit(Maxpslimit maxpslimit) {
        this.maxpslimit = maxpslimit;
    }

    public Groupname getGroupname() {
        return groupname;
    }

    public void setGroupname(Groupname groupname) {
        this.groupname = groupname;
    }

    public Audiodesname getAudiodesname() {
        return audiodesname;
    }

    public void setAudiodesname(Audiodesname audiodesname) {
        this.audiodesname = audiodesname;
    }

    public Audiodestype getAudiodestype() {
        return audiodestype;
    }

    public void setAudiodestype(Audiodestype audiodestype) {
        this.audiodestype = audiodestype;
    }

    public Audiodesdata getAudiodesdata() {
        return audiodesdata;
    }

    public void setAudiodesdata(Audiodesdata audiodesdata) {
        this.audiodesdata = audiodesdata;
    }

    public Des getDes() {
        return des;
    }

    public void setDes(Des des) {
        this.des = des;
    }

    public Stepfiles getStepfiles() {
        return stepfiles;
    }

    public void setStepfiles(Stepfiles stepfiles) {
        this.stepfiles = stepfiles;
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
        writer.write("<powerstdstep");

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
        if (stepid != null) {
            ((StepidImpl)stepid).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (stepname != null) {
            ((StepnameImpl)stepname).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (rolename != null) {
            ((RolenameImpl)rolename).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (prevstepid != null) {
            ((PrevstepidImpl)prevstepid).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (nextstepid != null) {
            ((NextstepidImpl)nextstepid).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (iskey != null) {
            ((IskeyImpl)iskey).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (isinner != null) {
            ((IsinnerImpl)isinner).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (maxduetimelimit != null) {
            ((MaxduetimelimitImpl)maxduetimelimit).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (maxpslimit != null) {
            ((MaxpslimitImpl)maxpslimit).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (groupname != null) {
            ((GroupnameImpl)groupname).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (audiodesname != null) {
            ((AudiodesnameImpl)audiodesname).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (audiodestype != null) {
            ((AudiodestypeImpl)audiodestype).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (audiodesdata != null) {
            ((AudiodesdataImpl)audiodesdata).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (des != null) {
            ((DesImpl)des).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (stepfiles != null) {
            ((StepfilesImpl)stepfiles).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        writer.write(indent);
        writer.write("</powerstdstep>\n");
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

    public static Powerstdstep unmarshal(File file) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new FileReader(file));
    }

    public static Powerstdstep unmarshal(File file, boolean validate) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new FileReader(file), validate);
    }

    public static Powerstdstep unmarshal(InputStream inputStream) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new InputStreamReader(inputStream));
    }

    public static Powerstdstep unmarshal(InputStream inputStream, boolean validate) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new InputStreamReader(inputStream), validate);
    }

    public static Powerstdstep unmarshal(Reader reader) throws IOException {
        // Delegate with default validation value
        return unmarshal(reader, false);
    }

    public static Powerstdstep unmarshal(Reader reader, boolean validate) throws IOException {
        PowerstdstepImpl powerstdstep = PowerstdstepImpl.newInstance();
        powerstdstep.setValidating(validate);
        powerstdstep.setCurrentUNode(powerstdstep);
        powerstdstep.setParentUNode(null);
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
            parser.setErrorHandler(powerstdstep);

            // Register lexical handler
            parser.setProperty("http://xml.org/sax/properties/lexical-handler", powerstdstep);

            // Register content handler
            parser.setContentHandler(powerstdstep);
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
        return powerstdstep;
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
        if ((localName.equalsIgnoreCase("powerstdstep")) && (!zeus_thisNodeHandled)) {
            // Handle ourselves
            for (int i=0, len=atts.getLength(); i<len; i++) {
                String attName= atts.getLocalName(i);
                String attValue = atts.getValue(i);
            }
            zeus_thisNodeHandled = true;
            return;
        } else {
            // Delegate handling
            if (localName.equalsIgnoreCase("stepid") && (stepid==null)) {
                StepidImpl stepid = StepidImpl.newInstance();
                current = getCurrentUNode();
                stepid.setParentUNode(current);
                stepid.setCurrentUNode(stepid);
                this.setCurrentUNode(stepid);
                stepid.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.stepid = stepid;
                return;
            }
            if (localName.equalsIgnoreCase("stepname") && (stepname==null)) {
                StepnameImpl stepname = StepnameImpl.newInstance();
                current = getCurrentUNode();
                stepname.setParentUNode(current);
                stepname.setCurrentUNode(stepname);
                this.setCurrentUNode(stepname);
                stepname.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.stepname = stepname;
                return;
            }
            if (localName.equalsIgnoreCase("rolename") && (rolename==null)) {
                RolenameImpl rolename = RolenameImpl.newInstance();
                current = getCurrentUNode();
                rolename.setParentUNode(current);
                rolename.setCurrentUNode(rolename);
                this.setCurrentUNode(rolename);
                rolename.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.rolename = rolename;
                return;
            }
            if (localName.equalsIgnoreCase("prevstepid") && (prevstepid==null)) {
                PrevstepidImpl prevstepid = PrevstepidImpl.newInstance();
                current = getCurrentUNode();
                prevstepid.setParentUNode(current);
                prevstepid.setCurrentUNode(prevstepid);
                this.setCurrentUNode(prevstepid);
                prevstepid.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.prevstepid = prevstepid;
                return;
            }
            if (localName.equalsIgnoreCase("nextstepid") && (nextstepid==null)) {
                NextstepidImpl nextstepid = NextstepidImpl.newInstance();
                current = getCurrentUNode();
                nextstepid.setParentUNode(current);
                nextstepid.setCurrentUNode(nextstepid);
                this.setCurrentUNode(nextstepid);
                nextstepid.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.nextstepid = nextstepid;
                return;
            }
            if (localName.equalsIgnoreCase("iskey") && (iskey==null)) {
                IskeyImpl iskey = IskeyImpl.newInstance();
                current = getCurrentUNode();
                iskey.setParentUNode(current);
                iskey.setCurrentUNode(iskey);
                this.setCurrentUNode(iskey);
                iskey.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.iskey = iskey;
                return;
            }
            if (localName.equalsIgnoreCase("isinner") && (isinner==null)) {
                IsinnerImpl isinner = IsinnerImpl.newInstance();
                current = getCurrentUNode();
                isinner.setParentUNode(current);
                isinner.setCurrentUNode(isinner);
                this.setCurrentUNode(isinner);
                isinner.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.isinner = isinner;
                return;
            }
            if (localName.equalsIgnoreCase("maxduetimelimit") && (maxduetimelimit==null)) {
                MaxduetimelimitImpl maxduetimelimit = MaxduetimelimitImpl.newInstance();
                current = getCurrentUNode();
                maxduetimelimit.setParentUNode(current);
                maxduetimelimit.setCurrentUNode(maxduetimelimit);
                this.setCurrentUNode(maxduetimelimit);
                maxduetimelimit.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.maxduetimelimit = maxduetimelimit;
                return;
            }
            if (localName.equalsIgnoreCase("maxpslimit") && (maxpslimit==null)) {
                MaxpslimitImpl maxpslimit = MaxpslimitImpl.newInstance();
                current = getCurrentUNode();
                maxpslimit.setParentUNode(current);
                maxpslimit.setCurrentUNode(maxpslimit);
                this.setCurrentUNode(maxpslimit);
                maxpslimit.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.maxpslimit = maxpslimit;
                return;
            }
            if (localName.equalsIgnoreCase("groupname") && (groupname==null)) {
                GroupnameImpl groupname = GroupnameImpl.newInstance();
                current = getCurrentUNode();
                groupname.setParentUNode(current);
                groupname.setCurrentUNode(groupname);
                this.setCurrentUNode(groupname);
                groupname.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.groupname = groupname;
                return;
            }
            if (localName.equalsIgnoreCase("audiodesname") && (audiodesname==null)) {
                AudiodesnameImpl audiodesname = AudiodesnameImpl.newInstance();
                current = getCurrentUNode();
                audiodesname.setParentUNode(current);
                audiodesname.setCurrentUNode(audiodesname);
                this.setCurrentUNode(audiodesname);
                audiodesname.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.audiodesname = audiodesname;
                return;
            }
            if (localName.equalsIgnoreCase("audiodestype") && (audiodestype==null)) {
                AudiodestypeImpl audiodestype = AudiodestypeImpl.newInstance();
                current = getCurrentUNode();
                audiodestype.setParentUNode(current);
                audiodestype.setCurrentUNode(audiodestype);
                this.setCurrentUNode(audiodestype);
                audiodestype.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.audiodestype = audiodestype;
                return;
            }
            if (localName.equalsIgnoreCase("audiodesdata") && (audiodesdata==null)) {
                AudiodesdataImpl audiodesdata = AudiodesdataImpl.newInstance();
                current = getCurrentUNode();
                audiodesdata.setParentUNode(current);
                audiodesdata.setCurrentUNode(audiodesdata);
                this.setCurrentUNode(audiodesdata);
                audiodesdata.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.audiodesdata = audiodesdata;
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
            if (localName.equalsIgnoreCase("stepfiles") && (stepfiles==null)) {
                StepfilesImpl stepfiles = StepfilesImpl.newInstance();
                current = getCurrentUNode();
                stepfiles.setParentUNode(current);
                stepfiles.setCurrentUNode(stepfiles);
                this.setCurrentUNode(stepfiles);
                stepfiles.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.stepfiles = stepfiles;
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
