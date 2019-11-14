package com.beyondbit.soft2.utils;

import java.io.*;
import java.awt.Toolkit;
import java.awt.Image;
import javax.swing.ImageIcon;

import org.apache.xerces.parsers.DOMParser;
import org.xml.sax.*;
import org.w3c.dom.Node;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Text;
import org.w3c.dom.NodeList;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Attr;
import org.apache.xml.serialize.OutputFormat;
import org.apache.xml.serialize.XMLSerializer;
import org.apache.xml.serialize.LineSeparator;

import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.dom.DOMResult;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.FactoryConfigurationError;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.xpath.XPathEvaluator;
import org.w3c.dom.xpath.XPathNSResolver;
import org.w3c.dom.xpath.XPathResult;

import org.apache.xpath.domapi.XPathEvaluatorImpl;
import org.apache.log4j.Logger;

public class XMLUtil {
    private static String fileName = "d:\\xml.xml";
    private static Logger logger = Logger.getLogger(XMLUtil.class);

    public XMLUtil() {
    }

    public static void main(String[] args) {
        //XMLUtil XMLUtil1 = new XMLUtil();
        newDocument();
    }

    public static Document getDocument(String filename) {
        fileName = filename;

        DOMParser parser = new DOMParser();
        try {
            parser.setFeature(
                "http://apache.org/xml/features/dom/defer-node-expansion", true);
            parser.setFeature(
                "http://apache.org/xml/features/continue-after-fatal-error", true);
            parser.parse(filename);

            Document document = parser.getDocument();
            return document;
        }
        catch (SAXNotSupportedException ex) {
            ex.printStackTrace();
        }
        catch (SAXNotRecognizedException ex) {
            ex.printStackTrace();
        }
        catch (IOException ex1) {
            ex1.printStackTrace();
        }
        catch (SAXException ex1) {
            ex1.printStackTrace();
        }
        return null;
    }

    public static XPathResult parseConfig(Document ctxNode, String xpath) {

        XPathResult result = null;
        XPathResult result1 = null;

        try {

            // Set up an identity transformer to use as serializer.
            Transformer serializer = TransformerFactory.newInstance().
                newTransformer();
            serializer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");

            // Use the DOM L3 XPath API to apply the xpath expression to the doc.
            //System.out.println("Querying DOM using " + xpath);
            logger.info("Querying DOM using " + xpath);

            // Create an XPath evaluator and pass in the document.
            XPathEvaluator evaluator = new XPathEvaluatorImpl(ctxNode);
            XPathNSResolver resolver = evaluator.createNSResolver(ctxNode);

            // Evaluate the xpath expression
            result = (XPathResult) evaluator.evaluate(xpath, ctxNode, resolver,
                XPathResult.UNORDERED_NODE_ITERATOR_TYPE, null);
            //result1 = (XPathResult)evaluator.evaluate(xpath, ctxNode, resolver, XPathResult.UNORDERED_NODE_ITERATOR_TYPE, null);
            // Serialize the found nodes to System.out.
            //System.out.println("<output>");

            /*
                   Node n;
                   while ((n = result.iterateNext())!= null)
                   {
              if (isTextNode(n)) {
                  // DOM may have more than one node corresponding to a
                  // single XPath text node.  Coalesce all contiguous text nodes
                  // at this level
                  StringBuffer sb = new StringBuffer(n.getNodeValue());
                  for (
                    Node nn = n.getNextSibling();
                    isTextNode(nn);
                    nn = nn.getNextSibling()
                  ) {
                    sb.append(nn.getNodeValue());
                  }
                  //System.out.print(sb);
              }
              else {
               serializer.transform(new DOMSource(n), new StreamResult(new OutputStreamWriter(System.out)));
               //serializer.transform(new DOMSource(n), new DOMResult(n));
              }
              //System.out.println();

                   }
                   //System.out.println("</output>");
             */

        }
        catch (TransformerConfigurationException ex) {
            ex.printStackTrace();
        }
        catch (TransformerException ex) {
            ex.printStackTrace();
        }

        return result;
    }

    /** Decide if the node is text, and so must be handled specially */
    private static boolean isTextNode(Node n) {
        if (n == null)
            return false;
        short nodeType = n.getNodeType();
        return nodeType == Node.CDATA_SECTION_NODE ||
            nodeType == Node.TEXT_NODE;
    }

    public static Document newDocument() {
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            //factory.setAttribute("encoding", "gb2312");

            Document document = factory.newDocumentBuilder().newDocument();
            /*
                Element root = document.createElement("root");
                document.appendChild(root);

                Element child1 = document.createElement("child1");
                root.appendChild(child1);

                System.out.println(doc2String(document));
             */
            return document;
        }
        catch (FactoryConfigurationError ex) {
        }
        catch (ParserConfigurationException ex) {
        }
        return null;

    }

    public static String dealString(Object obj) {
        if (obj == null) {
            return "";
        }
        else {
            return obj.toString();
        }
    }

    public static void doc2File(Document document) {
        OutputFormat format = new OutputFormat(document);
        format.setLineSeparator(LineSeparator.Windows);
        format.setIndenting(true);
        format.setLineWidth(0);
        format.setPreserveSpace(true);
        format.setEncoding("utf-16");

        XMLSerializer serializer = null;
        try {
            FileOutputStream fos = new FileOutputStream(fileName);
            OutputStreamWriter fw = new OutputStreamWriter(fos, "unicode");
            //FileWriter fw = new FileWriter(fileName);

            serializer = new XMLSerializer(fw, format);

            serializer.asDOMSerializer();

            serializer.serialize(document);
        }
        catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    public static String doc2String(Document document) {
        OutputFormat format = new OutputFormat(document);
        format.setLineSeparator(LineSeparator.Windows);
        format.setIndenting(true);
        format.setLineWidth(0);
        format.setPreserveSpace(true);
        //format.setEncoding("gb2312");
        StringWriter sw = new StringWriter();

        XMLSerializer serializer = null;
        try {
            serializer = new XMLSerializer(sw, format);

            serializer.asDOMSerializer();

            serializer.serialize(document);

            return sw.getBuffer().toString();
        }
        catch (IOException ex) {
            ex.printStackTrace();
        }

        return null;
    }

    public static Document string2Doc(String str) {
        DOMParser parser = new DOMParser();
        try {
            parser.setFeature(
                "http://apache.org/xml/features/dom/defer-node-expansion", true);
            parser.setFeature(
                "http://apache.org/xml/features/continue-after-fatal-error", true);
            parser.parse(new InputSource(new StringReader(str)));

            Document document = parser.getDocument();

            return document;
        }
        catch (SAXNotSupportedException ex) {
            ex.printStackTrace();
        }
        catch (SAXNotRecognizedException ex) {
            ex.printStackTrace();
        }
        catch (IOException ex1) {
            ex1.printStackTrace();
        }
        catch (SAXException ex1) {
            ex1.printStackTrace();
        }
        return null;

    }

    public static Document inputStream2Doc(InputStream is) {
        DOMParser parser = new DOMParser();
        try {
            parser.setFeature(
                "http://apache.org/xml/features/dom/defer-node-expansion", true);
            parser.setFeature(
                "http://apache.org/xml/features/continue-after-fatal-error", true);
            parser.parse(new InputSource(is));

            Document document = parser.getDocument();
            //String str = "\n";

            return document;
        }
        catch (SAXNotSupportedException ex) {
            ex.printStackTrace();
        }
        catch (SAXNotRecognizedException ex) {
            ex.printStackTrace();
        }
        catch (IOException ex1) {
            ex1.printStackTrace();
        }
        catch (SAXException ex1) {
            ex1.printStackTrace();
        }
        return null;

    }

    public static Image setImageIcon() {
        ImageIcon icon = new ImageIcon("D:\\dddd\\DataExchangeService\\2.jpg");
        return icon.getImage();
    }

    public static int getX(int width) {
        return (Toolkit.getDefaultToolkit().getScreenSize().width - width) / 2;
    }

    public static int getY(int height) {
        return (Toolkit.getDefaultToolkit().getScreenSize().height - height) /
            2;
    }

}
