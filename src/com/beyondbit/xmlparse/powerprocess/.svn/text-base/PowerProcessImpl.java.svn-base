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

public class PowerProcessImpl extends DefaultHandler implements Cloneable, Unmarshallable, LexicalHandler, PowerProcess {

    private PPID pPID;
    private ID iD;
    private Code code;
    private UnitID unitID;
    private UnitCode unitCode;
    private UnitName unitName;
    private PSCode pSCode;
    private BeginDate beginDate;
    private EndDate endDate;
    private CreateUserID createUserID;
    private CreateUserName createUserName;
    private UploadDate uploadDate;
    private State state;
    private IsFinished isFinished;
    private DueTime dueTime;
    private DES dES;
    private ResidentName residentName;
    private CompanyName companyName;
    private Memo memo;
    private IsOutOfDueTimeLimit isOutOfDueTimeLimit;
    private IsOutOfPSLimit isOutOfPSLimit;
    private IsOpen isOpen;
    private SuperviseDES superviseDES;
    private PowerProcessSteps powerProcessSteps;
    private DueTime dueTime2;
    private IsFinished isFinished2;
    private DES dES2;
    private ResidentName residentName2;
    private CompanyName companyName2;
    private Memo memo2;
    private IsOutOfDueTimeLimit isOutOfDueTimeLimit2;
    private IsOutOfPSLimit isOutOfPSLimit2;
    private IsOpen isOpen2;
    private SuperviseDES superviseDES2;
    private PowerProcessSteps powerProcessSteps2;

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

    private static PowerProcessImpl prototype = null;

    public static void setPrototype(PowerProcessImpl prototype) {
        PowerProcessImpl.prototype = prototype;
    }
    public static PowerProcessImpl newInstance() {
        try {
            return (prototype!=null)?(PowerProcessImpl)prototype.clone(): new PowerProcessImpl();
        } catch (CloneNotSupportedException e) {
            return null; // never
        }
    }
    public PowerProcessImpl() {
        docTypeString = "";
        hasDTD = false;
        validate = false;
        namespaceMappings = new HashMap();
    }

    public PPID getPPID() {
        return pPID;
    }

    public void setPPID(PPID pPID) {
        this.pPID = pPID;
    }

    public ID getID() {
        return iD;
    }

    public void setID(ID iD) {
        this.iD = iD;
    }

    public Code getCode() {
        return code;
    }

    public void setCode(Code code) {
        this.code = code;
    }

    public UnitID getUnitID() {
        return unitID;
    }

    public void setUnitID(UnitID unitID) {
        this.unitID = unitID;
    }

    public UnitCode getUnitCode() {
        return unitCode;
    }

    public void setUnitCode(UnitCode unitCode) {
        this.unitCode = unitCode;
    }

    public UnitName getUnitName() {
        return unitName;
    }

    public void setUnitName(UnitName unitName) {
        this.unitName = unitName;
    }

    public PSCode getPSCode() {
        return pSCode;
    }

    public void setPSCode(PSCode pSCode) {
        this.pSCode = pSCode;
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

    public CreateUserID getCreateUserID() {
        return createUserID;
    }

    public void setCreateUserID(CreateUserID createUserID) {
        this.createUserID = createUserID;
    }

    public CreateUserName getCreateUserName() {
        return createUserName;
    }

    public void setCreateUserName(CreateUserName createUserName) {
        this.createUserName = createUserName;
    }

    public UploadDate getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(UploadDate uploadDate) {
        this.uploadDate = uploadDate;
    }

    public State getState() {
        return state;
    }

    public void setState(State state) {
        this.state = state;
    }

    public IsFinished getIsFinished() {
        return isFinished;
    }

    public void setIsFinished(IsFinished isFinished) {
        this.isFinished = isFinished;
    }

    public DueTime getDueTime() {
        return dueTime;
    }

    public void setDueTime(DueTime dueTime) {
        this.dueTime = dueTime;
    }

    public DES getDES() {
        return dES;
    }

    public void setDES(DES dES) {
        this.dES = dES;
    }

    public ResidentName getResidentName() {
        return residentName;
    }

    public void setResidentName(ResidentName residentName) {
        this.residentName = residentName;
    }

    public CompanyName getCompanyName() {
        return companyName;
    }

    public void setCompanyName(CompanyName companyName) {
        this.companyName = companyName;
    }

    public Memo getMemo() {
        return memo;
    }

    public void setMemo(Memo memo) {
        this.memo = memo;
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

    public IsOpen getIsOpen() {
        return isOpen;
    }

    public void setIsOpen(IsOpen isOpen) {
        this.isOpen = isOpen;
    }

    public SuperviseDES getSuperviseDES() {
        return superviseDES;
    }

    public void setSuperviseDES(SuperviseDES superviseDES) {
        this.superviseDES = superviseDES;
    }

    public PowerProcessSteps getPowerProcessSteps() {
        return powerProcessSteps;
    }

    public void setPowerProcessSteps(PowerProcessSteps powerProcessSteps) {
        this.powerProcessSteps = powerProcessSteps;
    }

    public DueTime getDueTime2() {
        return dueTime2;
    }

    public void setDueTime2(DueTime dueTime2) {
        this.dueTime2 = dueTime2;
    }

    public IsFinished getIsFinished2() {
        return isFinished2;
    }

    public void setIsFinished2(IsFinished isFinished2) {
        this.isFinished2 = isFinished2;
    }

    public DES getDES2() {
        return dES2;
    }

    public void setDES2(DES dES2) {
        this.dES2 = dES2;
    }

    public ResidentName getResidentName2() {
        return residentName2;
    }

    public void setResidentName2(ResidentName residentName2) {
        this.residentName2 = residentName2;
    }

    public CompanyName getCompanyName2() {
        return companyName2;
    }

    public void setCompanyName2(CompanyName companyName2) {
        this.companyName2 = companyName2;
    }

    public Memo getMemo2() {
        return memo2;
    }

    public void setMemo2(Memo memo2) {
        this.memo2 = memo2;
    }

    public IsOutOfDueTimeLimit getIsOutOfDueTimeLimit2() {
        return isOutOfDueTimeLimit2;
    }

    public void setIsOutOfDueTimeLimit2(IsOutOfDueTimeLimit isOutOfDueTimeLimit2) {
        this.isOutOfDueTimeLimit2 = isOutOfDueTimeLimit2;
    }

    public IsOutOfPSLimit getIsOutOfPSLimit2() {
        return isOutOfPSLimit2;
    }

    public void setIsOutOfPSLimit2(IsOutOfPSLimit isOutOfPSLimit2) {
        this.isOutOfPSLimit2 = isOutOfPSLimit2;
    }

    public IsOpen getIsOpen2() {
        return isOpen2;
    }

    public void setIsOpen2(IsOpen isOpen2) {
        this.isOpen2 = isOpen2;
    }

    public SuperviseDES getSuperviseDES2() {
        return superviseDES2;
    }

    public void setSuperviseDES2(SuperviseDES superviseDES2) {
        this.superviseDES2 = superviseDES2;
    }

    public PowerProcessSteps getPowerProcessSteps2() {
        return powerProcessSteps2;
    }

    public void setPowerProcessSteps2(PowerProcessSteps powerProcessSteps2) {
        this.powerProcessSteps2 = powerProcessSteps2;
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
        writer.write("<PowerProcess");

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
        if (pPID != null) {
            ((PPIDImpl)pPID).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (iD != null) {
            ((IDImpl)iD).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (code != null) {
            ((CodeImpl)code).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (unitID != null) {
            ((UnitIDImpl)unitID).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (unitCode != null) {
            ((UnitCodeImpl)unitCode).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (unitName != null) {
            ((UnitNameImpl)unitName).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (pSCode != null) {
            ((PSCodeImpl)pSCode).writeXMLRepresentation(writer,
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

        if (createUserID != null) {
            ((CreateUserIDImpl)createUserID).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (createUserName != null) {
            ((CreateUserNameImpl)createUserName).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (uploadDate != null) {
            ((UploadDateImpl)uploadDate).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (state != null) {
            ((StateImpl)state).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (isFinished != null) {
            ((IsFinishedImpl)isFinished).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (dueTime != null) {
            ((DueTimeImpl)dueTime).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (dES != null) {
            ((DESImpl)dES).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (residentName != null) {
            ((ResidentNameImpl)residentName).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (companyName != null) {
            ((CompanyNameImpl)companyName).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (memo != null) {
            ((MemoImpl)memo).writeXMLRepresentation(writer,
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

        if (isOpen != null) {
            ((IsOpenImpl)isOpen).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (superviseDES != null) {
            ((SuperviseDESImpl)superviseDES).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (powerProcessSteps != null) {
            ((PowerProcessStepsImpl)powerProcessSteps).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (dueTime2 != null) {
            ((DueTimeImpl)dueTime2).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (isFinished2 != null) {
            ((IsFinishedImpl)isFinished2).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (dES2 != null) {
            ((DESImpl)dES2).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (residentName2 != null) {
            ((ResidentNameImpl)residentName2).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (companyName2 != null) {
            ((CompanyNameImpl)companyName2).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (memo2 != null) {
            ((MemoImpl)memo2).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (isOutOfDueTimeLimit2 != null) {
            ((IsOutOfDueTimeLimitImpl)isOutOfDueTimeLimit2).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (isOutOfPSLimit2 != null) {
            ((IsOutOfPSLimitImpl)isOutOfPSLimit2).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (isOpen2 != null) {
            ((IsOpenImpl)isOpen2).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (superviseDES2 != null) {
            ((SuperviseDESImpl)superviseDES2).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        if (powerProcessSteps2 != null) {
            ((PowerProcessStepsImpl)powerProcessSteps2).writeXMLRepresentation(writer,
                new StringBuffer(indent).append("  ").toString());
        }

        writer.write(indent);
        writer.write("</PowerProcess>\n");
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

    public static PowerProcess unmarshal(File file) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new FileReader(file));
    }

    public static PowerProcess unmarshal(File file, boolean validate) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new FileReader(file), validate);
    }

    public static PowerProcess unmarshal(InputStream inputStream) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new InputStreamReader(inputStream));
    }

    public static PowerProcess unmarshal(InputStream inputStream, boolean validate) throws IOException {
        // Delegate to the unmarshal(Reader) method
        return unmarshal(new InputStreamReader(inputStream), validate);
    }

    public static PowerProcess unmarshal(Reader reader) throws IOException {
        // Delegate with default validation value
        return unmarshal(reader, false);
    }

    public static PowerProcess unmarshal(Reader reader, boolean validate) throws IOException {
        PowerProcessImpl powerProcess = PowerProcessImpl.newInstance();
        powerProcess.setValidating(validate);
        powerProcess.setCurrentUNode(powerProcess);
        powerProcess.setParentUNode(null);
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
            parser.setErrorHandler(powerProcess);

            // Register lexical handler
            parser.setProperty("http://xml.org/sax/properties/lexical-handler", powerProcess);

            // Register content handler
            parser.setContentHandler(powerProcess);
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
        return powerProcess;
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
        if ((localName.equals("PowerProcess")) && (!zeus_thisNodeHandled)) {
            // Handle ourselves
            for (int i=0, len=atts.getLength(); i<len; i++) {
                String attName= atts.getLocalName(i);
                String attValue = atts.getValue(i);
            }
            zeus_thisNodeHandled = true;
            return;
        } else {
            // Delegate handling
            if (localName.equals("PPID") && (pPID==null)) {
                PPIDImpl pPID = PPIDImpl.newInstance();
                current = getCurrentUNode();
                pPID.setParentUNode(current);
                pPID.setCurrentUNode(pPID);
                this.setCurrentUNode(pPID);
                pPID.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.pPID = pPID;
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
            if (localName.equals("Code") && (code==null)) {
                CodeImpl code = CodeImpl.newInstance();
                current = getCurrentUNode();
                code.setParentUNode(current);
                code.setCurrentUNode(code);
                this.setCurrentUNode(code);
                code.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.code = code;
                return;
            }
            if (localName.equals("UnitID") && (unitID==null)) {
                UnitIDImpl unitID = UnitIDImpl.newInstance();
                current = getCurrentUNode();
                unitID.setParentUNode(current);
                unitID.setCurrentUNode(unitID);
                this.setCurrentUNode(unitID);
                unitID.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.unitID = unitID;
                return;
            }
            if (localName.equals("UnitCode") && (unitCode==null)) {
                UnitCodeImpl unitCode = UnitCodeImpl.newInstance();
                current = getCurrentUNode();
                unitCode.setParentUNode(current);
                unitCode.setCurrentUNode(unitCode);
                this.setCurrentUNode(unitCode);
                unitCode.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.unitCode = unitCode;
                return;
            }
            if (localName.equals("UnitName") && (unitName==null)) {
                UnitNameImpl unitName = UnitNameImpl.newInstance();
                current = getCurrentUNode();
                unitName.setParentUNode(current);
                unitName.setCurrentUNode(unitName);
                this.setCurrentUNode(unitName);
                unitName.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.unitName = unitName;
                return;
            }
            if (localName.equals("PSCode") && (pSCode==null)) {
                PSCodeImpl pSCode = PSCodeImpl.newInstance();
                current = getCurrentUNode();
                pSCode.setParentUNode(current);
                pSCode.setCurrentUNode(pSCode);
                this.setCurrentUNode(pSCode);
                pSCode.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.pSCode = pSCode;
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
            if (localName.equals("CreateUserID") && (createUserID==null)) {
                CreateUserIDImpl createUserID = CreateUserIDImpl.newInstance();
                current = getCurrentUNode();
                createUserID.setParentUNode(current);
                createUserID.setCurrentUNode(createUserID);
                this.setCurrentUNode(createUserID);
                createUserID.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.createUserID = createUserID;
                return;
            }
            if (localName.equals("CreateUserName") && (createUserName==null)) {
                CreateUserNameImpl createUserName = CreateUserNameImpl.newInstance();
                current = getCurrentUNode();
                createUserName.setParentUNode(current);
                createUserName.setCurrentUNode(createUserName);
                this.setCurrentUNode(createUserName);
                createUserName.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.createUserName = createUserName;
                return;
            }
            if (localName.equals("UploadDate") && (uploadDate==null)) {
                UploadDateImpl uploadDate = UploadDateImpl.newInstance();
                current = getCurrentUNode();
                uploadDate.setParentUNode(current);
                uploadDate.setCurrentUNode(uploadDate);
                this.setCurrentUNode(uploadDate);
                uploadDate.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.uploadDate = uploadDate;
                return;
            }
            if (localName.equals("State") && (state==null)) {
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
            if (localName.equals("IsFinished") && (isFinished==null)) {
                IsFinishedImpl isFinished = IsFinishedImpl.newInstance();
                current = getCurrentUNode();
                isFinished.setParentUNode(current);
                isFinished.setCurrentUNode(isFinished);
                this.setCurrentUNode(isFinished);
                isFinished.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.isFinished = isFinished;
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
            if (localName.equals("ResidentName") && (residentName==null)) {
                ResidentNameImpl residentName = ResidentNameImpl.newInstance();
                current = getCurrentUNode();
                residentName.setParentUNode(current);
                residentName.setCurrentUNode(residentName);
                this.setCurrentUNode(residentName);
                residentName.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.residentName = residentName;
                return;
            }
            if (localName.equals("CompanyName") && (companyName==null)) {
                CompanyNameImpl companyName = CompanyNameImpl.newInstance();
                current = getCurrentUNode();
                companyName.setParentUNode(current);
                companyName.setCurrentUNode(companyName);
                this.setCurrentUNode(companyName);
                companyName.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.companyName = companyName;
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
            if (localName.equals("IsOpen") && (isOpen==null)) {
                IsOpenImpl isOpen = IsOpenImpl.newInstance();
                current = getCurrentUNode();
                isOpen.setParentUNode(current);
                isOpen.setCurrentUNode(isOpen);
                this.setCurrentUNode(isOpen);
                isOpen.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.isOpen = isOpen;
                return;
            }
            if (localName.equals("SuperviseDES") && (superviseDES==null)) {
                SuperviseDESImpl superviseDES = SuperviseDESImpl.newInstance();
                current = getCurrentUNode();
                superviseDES.setParentUNode(current);
                superviseDES.setCurrentUNode(superviseDES);
                this.setCurrentUNode(superviseDES);
                superviseDES.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.superviseDES = superviseDES;
                return;
            }
            if (localName.equals("PowerProcessSteps") && (powerProcessSteps==null)) {
                PowerProcessStepsImpl powerProcessSteps = PowerProcessStepsImpl.newInstance();
                current = getCurrentUNode();
                powerProcessSteps.setParentUNode(current);
                powerProcessSteps.setCurrentUNode(powerProcessSteps);
                this.setCurrentUNode(powerProcessSteps);
                powerProcessSteps.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.powerProcessSteps = powerProcessSteps;
                return;
            }
            if (localName.equals("DueTime") && (dueTime2==null)) {
                DueTimeImpl dueTime2 = DueTimeImpl.newInstance();
                current = getCurrentUNode();
                dueTime2.setParentUNode(current);
                dueTime2.setCurrentUNode(dueTime2);
                this.setCurrentUNode(dueTime2);
                dueTime2.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.dueTime2 = dueTime2;
                return;
            }
            if (localName.equals("IsFinished") && (isFinished2==null)) {
                IsFinishedImpl isFinished2 = IsFinishedImpl.newInstance();
                current = getCurrentUNode();
                isFinished2.setParentUNode(current);
                isFinished2.setCurrentUNode(isFinished2);
                this.setCurrentUNode(isFinished2);
                isFinished2.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.isFinished2 = isFinished2;
                return;
            }
            if (localName.equals("DES") && (dES2==null)) {
                DESImpl dES2 = DESImpl.newInstance();
                current = getCurrentUNode();
                dES2.setParentUNode(current);
                dES2.setCurrentUNode(dES2);
                this.setCurrentUNode(dES2);
                dES2.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.dES2 = dES2;
                return;
            }
            if (localName.equals("ResidentName") && (residentName2==null)) {
                ResidentNameImpl residentName2 = ResidentNameImpl.newInstance();
                current = getCurrentUNode();
                residentName2.setParentUNode(current);
                residentName2.setCurrentUNode(residentName2);
                this.setCurrentUNode(residentName2);
                residentName2.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.residentName2 = residentName2;
                return;
            }
            if (localName.equals("CompanyName") && (companyName2==null)) {
                CompanyNameImpl companyName2 = CompanyNameImpl.newInstance();
                current = getCurrentUNode();
                companyName2.setParentUNode(current);
                companyName2.setCurrentUNode(companyName2);
                this.setCurrentUNode(companyName2);
                companyName2.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.companyName2 = companyName2;
                return;
            }
            if (localName.equals("Memo") && (memo2==null)) {
                MemoImpl memo2 = MemoImpl.newInstance();
                current = getCurrentUNode();
                memo2.setParentUNode(current);
                memo2.setCurrentUNode(memo2);
                this.setCurrentUNode(memo2);
                memo2.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.memo2 = memo2;
                return;
            }
            if (localName.equals("IsOutOfDueTimeLimit") && (isOutOfDueTimeLimit2==null)) {
                IsOutOfDueTimeLimitImpl isOutOfDueTimeLimit2 = IsOutOfDueTimeLimitImpl.newInstance();
                current = getCurrentUNode();
                isOutOfDueTimeLimit2.setParentUNode(current);
                isOutOfDueTimeLimit2.setCurrentUNode(isOutOfDueTimeLimit2);
                this.setCurrentUNode(isOutOfDueTimeLimit2);
                isOutOfDueTimeLimit2.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.isOutOfDueTimeLimit2 = isOutOfDueTimeLimit2;
                return;
            }
            if (localName.equals("IsOutOfPSLimit") && (isOutOfPSLimit2==null)) {
                IsOutOfPSLimitImpl isOutOfPSLimit2 = IsOutOfPSLimitImpl.newInstance();
                current = getCurrentUNode();
                isOutOfPSLimit2.setParentUNode(current);
                isOutOfPSLimit2.setCurrentUNode(isOutOfPSLimit2);
                this.setCurrentUNode(isOutOfPSLimit2);
                isOutOfPSLimit2.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.isOutOfPSLimit2 = isOutOfPSLimit2;
                return;
            }
            if (localName.equals("IsOpen") && (isOpen2==null)) {
                IsOpenImpl isOpen2 = IsOpenImpl.newInstance();
                current = getCurrentUNode();
                isOpen2.setParentUNode(current);
                isOpen2.setCurrentUNode(isOpen2);
                this.setCurrentUNode(isOpen2);
                isOpen2.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.isOpen2 = isOpen2;
                return;
            }
            if (localName.equals("SuperviseDES") && (superviseDES2==null)) {
                SuperviseDESImpl superviseDES2 = SuperviseDESImpl.newInstance();
                current = getCurrentUNode();
                superviseDES2.setParentUNode(current);
                superviseDES2.setCurrentUNode(superviseDES2);
                this.setCurrentUNode(superviseDES2);
                superviseDES2.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.superviseDES2 = superviseDES2;
                return;
            }
            if (localName.equals("PowerProcessSteps") && (powerProcessSteps2==null)) {
                PowerProcessStepsImpl powerProcessSteps2 = PowerProcessStepsImpl.newInstance();
                current = getCurrentUNode();
                powerProcessSteps2.setParentUNode(current);
                powerProcessSteps2.setCurrentUNode(powerProcessSteps2);
                this.setCurrentUNode(powerProcessSteps2);
                powerProcessSteps2.startElement(namespaceURI, localName, qName, atts);
                // Add this value in
                this.powerProcessSteps2 = powerProcessSteps2;
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
