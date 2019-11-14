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
package com.beyondbit.xmlparse.powerprocess;

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

public class PowerProcessStepImpl extends DefaultHandler implements Cloneable, Unmarshallable, LexicalHandler, PowerProcessStep {

    private PPSID pPSID;
    private ID iD;
    private Name name;
    private PSStepID pSStepID;
    private BeginDate beginDate;
    private EndDate endDate;
    private Sequence sequence;
    private DueTime dueTime;
    private PSLimit pSLimit;
    private DES dES;
    private RoleNames roleNames;
    private UserID userID;
    private UserName userName;
    private MaxDueTimeLimit maxDueTimeLimit;
    private MaxPSLimit maxPSLimit;
    private IsOutOfDueTimeLimit isOutOfDueTimeLimit;
    private IsOutOfPSLimit isOutOfPSLimit;
    private IsOverstep isOverstep;
    private Memo memo;

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

    private static PowerProcessStepImpl prototype = null;

    public static void setPrototype(PowerProcessStepImpl prototype) {
        PowerProcessStepImpl.prototype = prototype;
    }
    public static PowerProcessStepImpl newInstance() {
        try {
            return (prototype!=null)?(PowerProcessStepImpl)prototype.clone(): new PowerProcessStepImpl();
        } catch (CloneNotSupportedException e) {
            return null; // never
        }
    }
    public PowerProcessStepImpl() {
        docTypeString = "";
        hasDTD = false;
        validate = false;
        namespaceMappings = new HashMap();
    }

    public PPSID getPPSID() {
        return pPSID;
    }

    public void setPPSID(PPSID pPSID) {
        this.pPSID = pPSID;
    }

    public ID getID() {
        return iD;
    }

    public void setID(ID iD) {
        this.iD = iD;
    }

    public Name getName() {
        return name;
    }

    public void setName(Name name) {
        this.name = name;
    }

    public PSStepID getPSStepID() {
        return pSStepID;
    }

    public void setPSStepID(PSStepID pSStepID) {
        this.pSStepID = pSStepID;
    }

    public BeginDate getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(BeginDate beginDate) {
        this.beginDate = beginDate;
    }

    public EndDate getEndDate() {
        return endDate;
    }

    public void setEndDate(EndDate endDate) {
        this.endDate = endDate;
    }

    public Sequence getSequence() {
        return sequence;
    }

    public void setSequence(Sequence sequence) {
        this.sequence = sequence;
    }

    public DueTime getDueTime() {
        return dueTime;
    }

    public void setDueTime(DueTime dueTime) {
        this.dueTime = dueTime;
    }

    public PSLimit getPSLimit() {
        return pSLimit;
    }

    public void setPSLimit(PSLimit pSLimit) {
        this.pSLimit = pSLimit;
    }

    public DES getDES() {
        return dES;
    }

    public void setDES(DES dES) {
        this.dES = dES;
    }

    public RoleNames getRoleNames() {
        return roleNames;
    }

    public void setRoleNames(RoleNames roleNames) {
        this.roleNames = roleNames;
    }

    public UserID getUserID() {
        return userID;
    }

    public void setUserID(UserID userID) {
        this.userID = userID;
    }

    public UserName getUserName() {
        return userName;
    }

    public void setUserName(UserName userName) {
        this.userName = userName;
    }

    public MaxDueTimeLimit getMaxDueTimeLimit() {
        return maxDueTimeLimit;
    }

    public void setMaxDueTimeLimit(MaxDueTimeLimit maxDueTimeLimit) {
        this.maxDueTimeLimit = maxDueTimeLimit;
    }

    public MaxPSLimit getMaxPSLimit() {
        return maxPSLimit;
    }

    public void setMaxPSLimit(MaxPSLimit maxPSLimit) {
        this.maxPSLimit = maxPSLimit;
    }

    public IsOutOfDueTimeLimit getIsOutOfDueTimeLimit() {
        return isOutOfDueTimeLimit;
    }

    public void setIsOutOfDueTimeLimit(IsOutOfDueTimeLimit isOutOfDueTimeLimit) {
        this.isOutOfDueTimeLimit = isOutOfDueTimeLimit;
    }

    public IsOutOfPSLimit getIsOutOfPSLimit() {
        return isOutOfPSLimit;
    }

    public void setIsOutOfPSLimit(IsOutOfPSLimit isOutOfPSLimit) {
        this.isOutOfPSLimit = isOutOfPSLimit;
    }

    public IsOverstep getIsOverstep() {
        return isOverstep;
    }

    public void setIsOverstep(IsOverstep isOverstep) {
        this.isOverstep = isOverstep;
    }

    public Memo getMemo() {
        return memo;
    }

    public void setMemo(Memo memo) {
        this.memo = memo;
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
        writer.write("<PowerProcessStep");

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
        if (pPSID != null) {
            ((PPSIDImpl)pPSID).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (iD != null) {
            ((IDImpl)iD).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (name != null) {
            ((NameImpl)name).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (pSStepID != null) {
            ((PSStepIDImpl)pSStepID).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (beginDate != null) {
            ((BeginDateImpl)beginDate).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (endDate != null) {
            ((EndDateImpl)endDate).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (sequence != null) {
            ((SequenceImpl)sequence).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (dueTime != null) {
            ((DueTimeImpl)dueTime).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (pSLimit != null) {
            ((PSLimitImpl)pSLimit).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (dES != null) {
            ((DESImpl)dES).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (roleNames != null) {
            ((RoleNamesImpl)roleNames).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (userID != null) {
            ((UserIDImpl)userID).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (userName != null) {
            ((UserNameImpl)userName).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (maxDueTimeLimit != null) {
            ((MaxDueTimeLimitImpl)maxDueTimeLimit).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (maxPSLimit != null) {
            ((MaxPSLimitImpl)maxPSLimit).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (isOutOfDueTimeLimit != null) {
            ((IsOutOfDueTimeLimitImpl)isOutOfDueTimeLimit).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (isOutOfPSLimit != null) {
            ((IsOutOfPSLimitImpl)isOutOfPSLimit).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (isOverstep != null) {
            ((IsOverstepImpl)isOverstep).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (memo != null) {
            ((MemoImpl)memo).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        writer.write(indent);
        writer.write("</PowerProcessStep>\n");
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

    public static PowerProcessStep unmarshal(File file) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new FileReader(file));
    }

    public static PowerProcessStep unmarshal(File file, boolean validate) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new FileReader(file), validate);
    }

    public static PowerProcessStep unmarshal(InputStream inputStream) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new InputStreamReader(inputStream));
    }

    public static PowerProcessStep unmarshal(InputStream inputStream, boolean validate) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new InputStreamReader(inputStream), validate);
    }

    public static PowerProcessStep unmarshal(Reader reader) throws IOException {
        // Delegate with default validation value
        return unmarshal(reader, false);
    }

    public static PowerProcessStep unmarshal(Reader reader, boolean validate) throws IOException {
        PowerProcessStepImpl powerProcessStep = PowerProcessStepImpl.newInstance();
        powerProcessStep.setValidating(validate);
        powerProcessStep.setCurrentUNode(powerProcessStep);
        powerProcessStep.setParentUNode(null);
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
            parser.setErrorHandler(powerProcessStep);

            // Register lexical handler
            parser.setProperty("http://xml.org/sax/properties/lexical-handler", powerProcessStep);

            // Register content handler
            parser.setContentHandler(powerProcessStep);
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
        return powerProcessStep;
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
        if ((localName.equals("PowerProcessStep")) && (!zeus_thisNodeHandled)) {
            // Handle ourselves
            for (int i=0, len=atts.getLength(); i<len; i++) {
                String attName= atts.getLocalName(i);
                String attValue = atts.getValue(i);
            }
            zeus_thisNodeHandled = true;
            return;
        } else {
            // Delegate handling
            if (localName.equals("PPSID") && (pPSID==null)) {
                PPSIDImpl pPSID = PPSIDImpl.newInstance();
                current = getCurrentUNode();
                pPSID.setParentUNode(current);
                pPSID.setCurrentUNode(pPSID);
                this.setCurrentUNode(pPSID);
                pPSID.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.pPSID = pPSID;
                return;
            }
            if (localName.equals("ID") && (iD==null)) {
                IDImpl iD = IDImpl.newInstance();
                current = getCurrentUNode();
                iD.setParentUNode(current);
                iD.setCurrentUNode(iD);
                this.setCurrentUNode(iD);
                iD.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.iD = iD;
                return;
            }
            if (localName.equals("Name") && (name==null)) {
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
            if (localName.equals("PSStepID") && (pSStepID==null)) {
                PSStepIDImpl pSStepID = PSStepIDImpl.newInstance();
                current = getCurrentUNode();
                pSStepID.setParentUNode(current);
                pSStepID.setCurrentUNode(pSStepID);
                this.setCurrentUNode(pSStepID);
                pSStepID.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.pSStepID = pSStepID;
                return;
            }
            if (localName.equals("BeginDate") && (beginDate==null)) {
                BeginDateImpl beginDate = BeginDateImpl.newInstance();
                current = getCurrentUNode();
                beginDate.setParentUNode(current);
                beginDate.setCurrentUNode(beginDate);
                this.setCurrentUNode(beginDate);
                beginDate.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.beginDate = beginDate;
                return;
            }
            if (localName.equals("EndDate") && (endDate==null)) {
                EndDateImpl endDate = EndDateImpl.newInstance();
                current = getCurrentUNode();
                endDate.setParentUNode(current);
                endDate.setCurrentUNode(endDate);
                this.setCurrentUNode(endDate);
                endDate.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.endDate = endDate;
                return;
            }
            if (localName.equals("Sequence") && (sequence==null)) {
                SequenceImpl sequence = SequenceImpl.newInstance();
                current = getCurrentUNode();
                sequence.setParentUNode(current);
                sequence.setCurrentUNode(sequence);
                this.setCurrentUNode(sequence);
                sequence.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.sequence = sequence;
                return;
            }
            if (localName.equals("DueTime") && (dueTime==null)) {
                DueTimeImpl dueTime = DueTimeImpl.newInstance();
                current = getCurrentUNode();
                dueTime.setParentUNode(current);
                dueTime.setCurrentUNode(dueTime);
                this.setCurrentUNode(dueTime);
                dueTime.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.dueTime = dueTime;
                return;
            }
            if (localName.equals("PSLimit") && (pSLimit==null)) {
                PSLimitImpl pSLimit = PSLimitImpl.newInstance();
                current = getCurrentUNode();
                pSLimit.setParentUNode(current);
                pSLimit.setCurrentUNode(pSLimit);
                this.setCurrentUNode(pSLimit);
                pSLimit.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.pSLimit = pSLimit;
                return;
            }
            if (localName.equals("DES") && (dES==null)) {
                DESImpl dES = DESImpl.newInstance();
                current = getCurrentUNode();
                dES.setParentUNode(current);
                dES.setCurrentUNode(dES);
                this.setCurrentUNode(dES);
                dES.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.dES = dES;
                return;
            }
            if (localName.equals("RoleNames") && (roleNames==null)) {
                RoleNamesImpl roleNames = RoleNamesImpl.newInstance();
                current = getCurrentUNode();
                roleNames.setParentUNode(current);
                roleNames.setCurrentUNode(roleNames);
                this.setCurrentUNode(roleNames);
                roleNames.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.roleNames = roleNames;
                return;
            }
            if (localName.equals("UserID") && (userID==null)) {
                UserIDImpl userID = UserIDImpl.newInstance();
                current = getCurrentUNode();
                userID.setParentUNode(current);
                userID.setCurrentUNode(userID);
                this.setCurrentUNode(userID);
                userID.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.userID = userID;
                return;
            }
            if (localName.equals("UserName") && (userName==null)) {
                UserNameImpl userName = UserNameImpl.newInstance();
                current = getCurrentUNode();
                userName.setParentUNode(current);
                userName.setCurrentUNode(userName);
                this.setCurrentUNode(userName);
                userName.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.userName = userName;
                return;
            }
            if (localName.equals("MaxDueTimeLimit") && (maxDueTimeLimit==null)) {
                MaxDueTimeLimitImpl maxDueTimeLimit = MaxDueTimeLimitImpl.newInstance();
                current = getCurrentUNode();
                maxDueTimeLimit.setParentUNode(current);
                maxDueTimeLimit.setCurrentUNode(maxDueTimeLimit);
                this.setCurrentUNode(maxDueTimeLimit);
                maxDueTimeLimit.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.maxDueTimeLimit = maxDueTimeLimit;
                return;
            }
            if (localName.equals("MaxPSLimit") && (maxPSLimit==null)) {
                MaxPSLimitImpl maxPSLimit = MaxPSLimitImpl.newInstance();
                current = getCurrentUNode();
                maxPSLimit.setParentUNode(current);
                maxPSLimit.setCurrentUNode(maxPSLimit);
                this.setCurrentUNode(maxPSLimit);
                maxPSLimit.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.maxPSLimit = maxPSLimit;
                return;
            }
            if (localName.equals("IsOutOfDueTimeLimit") && (isOutOfDueTimeLimit==null)) {
                IsOutOfDueTimeLimitImpl isOutOfDueTimeLimit = IsOutOfDueTimeLimitImpl.newInstance();
                current = getCurrentUNode();
                isOutOfDueTimeLimit.setParentUNode(current);
                isOutOfDueTimeLimit.setCurrentUNode(isOutOfDueTimeLimit);
                this.setCurrentUNode(isOutOfDueTimeLimit);
                isOutOfDueTimeLimit.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.isOutOfDueTimeLimit = isOutOfDueTimeLimit;
                return;
            }
            if (localName.equals("IsOutOfPSLimit") && (isOutOfPSLimit==null)) {
                IsOutOfPSLimitImpl isOutOfPSLimit = IsOutOfPSLimitImpl.newInstance();
                current = getCurrentUNode();
                isOutOfPSLimit.setParentUNode(current);
                isOutOfPSLimit.setCurrentUNode(isOutOfPSLimit);
                this.setCurrentUNode(isOutOfPSLimit);
                isOutOfPSLimit.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.isOutOfPSLimit = isOutOfPSLimit;
                return;
            }
            if (localName.equals("IsOverstep") && (isOverstep==null)) {
                IsOverstepImpl isOverstep = IsOverstepImpl.newInstance();
                current = getCurrentUNode();
                isOverstep.setParentUNode(current);
                isOverstep.setCurrentUNode(isOverstep);
                this.setCurrentUNode(isOverstep);
                isOverstep.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.isOverstep = isOverstep;
                return;
            }
            if (localName.equals("Memo") && (memo==null)) {
                MemoImpl memo = MemoImpl.newInstance();
                current = getCurrentUNode();
                memo.setParentUNode(current);
                memo.setCurrentUNode(memo);
                this.setCurrentUNode(memo);
                memo.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.memo = memo;
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
