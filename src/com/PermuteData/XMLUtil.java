// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   XMLUtil.java

package com.PermuteData;

import java.awt.*;
import java.io.*;
import javax.swing.ImageIcon;
import javax.xml.parsers.*;
import javax.xml.transform.*;
import org.apache.log4j.Logger;
import org.apache.xerces.parsers.DOMParser;
import org.apache.xml.serialize.OutputFormat;
import org.apache.xml.serialize.XMLSerializer;
import org.apache.xpath.domapi.XPathEvaluatorImpl;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.xpath.XPathEvaluator;
import org.w3c.dom.xpath.XPathResult;
import org.xml.sax.*;

public class XMLUtil
{

    private static String fileName = "c:\\ttttt.xml";
    private static Logger logger;

    public XMLUtil()
    {
    }

    public static void main(String args[])
    {
        newDocument();
    }

    public static Document getDocument(String filename)
    {
        fileName = filename;
        DOMParser parser = new DOMParser();
        try
        {
            parser.setFeature("http://apache.org/xml/features/dom/defer-node-expansion", true);
            parser.setFeature("http://apache.org/xml/features/continue-after-fatal-error", true);
            parser.parse(filename);
            Document document = parser.getDocument();
            return document;
        }
        catch(SAXNotSupportedException ex)
        {
            ex.printStackTrace();
        }
        catch(SAXNotRecognizedException ex)
        {
            ex.printStackTrace();
        }
        catch(IOException ex1)
        {
            ex1.printStackTrace();
        }
        catch(SAXException ex1)
        {
            ex1.printStackTrace();
        }
        return null;
    }

    public static XPathResult parseConfig(Document ctxNode, String xpath)
    {
        XPathResult result = null;
        XPathResult result1 = null;
        try
        {
            Transformer serializer = TransformerFactory.newInstance().newTransformer();
            serializer.setOutputProperty("omit-xml-declaration", "yes");
            logger.info("Querying DOM using " + xpath);
            XPathEvaluator evaluator = new XPathEvaluatorImpl(ctxNode);
            org.w3c.dom.xpath.XPathNSResolver resolver = evaluator.createNSResolver(ctxNode);
            result = (XPathResult)evaluator.evaluate(xpath, ctxNode, resolver, (short)4, null);
        }
        catch(TransformerConfigurationException ex)
        {
            ex.printStackTrace();
        }
        catch(TransformerException ex)
        {
            ex.printStackTrace();
        }
        return result;
    }

    private static boolean isTextNode(Node n)
    {
        if(n == null)
            return false;
        short nodeType = n.getNodeType();
        return nodeType == 4 || nodeType == 3;
    }

    public static Document newDocument()
    {
        try
        {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            Document document = factory.newDocumentBuilder().newDocument();
            return document;
        }
        catch(FactoryConfigurationError factoryconfigurationerror) { }
        catch(ParserConfigurationException parserconfigurationexception) { }
        return null;
    }

    public static String dealString(Object obj)
    {
        if(obj == null)
            return "";
        else
            return obj.toString();
    }

    public static void doc2File(Document document)
    {
        OutputFormat format = new OutputFormat(document);
        format.setLineSeparator("\r\n");
        format.setIndenting(true);
        format.setLineWidth(0);
        format.setPreserveSpace(true);
        format.setEncoding("utf-16");
        XMLSerializer serializer = null;
        try
        {
            FileOutputStream fos = new FileOutputStream(fileName);
            OutputStreamWriter fw = new OutputStreamWriter(fos, "unicode");
            serializer = new XMLSerializer(fw, format);
            serializer.asDOMSerializer();
            serializer.serialize(document);
        }
        catch(IOException ex)
        {
            ex.printStackTrace();
        }
    }

    public static String doc2String(Document document)
    {
        OutputFormat format = new OutputFormat(document);
        format.setLineSeparator("\r\n");
        format.setIndenting(true);
        format.setLineWidth(0);
        format.setPreserveSpace(true);
        StringWriter sw = new StringWriter();
        XMLSerializer serializer = null;
        try
        {
            serializer = new XMLSerializer(sw, format);
            serializer.asDOMSerializer();
            serializer.serialize(document);
            return sw.getBuffer().toString();
        }
        catch(IOException ex)
        {
            ex.printStackTrace();
        }
        return null;
    }

    public static Document string2Doc(String str)
    {
        DOMParser parser = new DOMParser();
        try
        {
            parser.setFeature("http://apache.org/xml/features/dom/defer-node-expansion", true);
            parser.setFeature("http://apache.org/xml/features/continue-after-fatal-error", true);
            parser.parse(new InputSource(new StringReader(str)));
            Document document = parser.getDocument();
            return document;
        }
        catch(SAXNotSupportedException ex)
        {
            ex.printStackTrace();
        }
        catch(SAXNotRecognizedException ex)
        {
            ex.printStackTrace();
        }
        catch(IOException ex1)
        {
            ex1.printStackTrace();
        }
        catch(SAXException ex1)
        {
            ex1.printStackTrace();
        }
        return null;
    }

    public static Document inputStream2Doc(InputStream is)
    {
        DOMParser parser = new DOMParser();
        try
        {
            parser.setFeature("http://apache.org/xml/features/dom/defer-node-expansion", true);
            parser.setFeature("http://apache.org/xml/features/continue-after-fatal-error", true);
            parser.parse(new InputSource(is));
            Document document = parser.getDocument();
            return document;
        }
        catch(SAXNotSupportedException ex)
        {
            ex.printStackTrace();
        }
        catch(SAXNotRecognizedException ex)
        {
            ex.printStackTrace();
        }
        catch(IOException ex1)
        {
            ex1.printStackTrace();
        }
        catch(SAXException ex1)
        {
            ex1.printStackTrace();
        }
        return null;
    }

    public static Image setImageIcon()
    {
        ImageIcon icon = new ImageIcon("D:\\dddd\\DataExchangeService\\2.jpg");
        return icon.getImage();
    }

    public static int getX(int width)
    {
        return (Toolkit.getDefaultToolkit().getScreenSize().width - width) / 2;
    }

    public static int getY(int height)
    {
        return (Toolkit.getDefaultToolkit().getScreenSize().height - height) / 2;
    }

    static 
    {
        logger = Logger.getLogger(com.PermuteData.XMLUtil.class);
    }
}
