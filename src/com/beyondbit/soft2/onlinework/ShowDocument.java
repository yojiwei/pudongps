/*
 * Created on 2004-12-10
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.beyondbit.soft2.onlinework;

/**
 * @author along
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.File;
import org.w3c.dom.Document;
import org.w3c.dom.DOMImplementation;
import org.w3c.dom.Node;
import org.w3c.dom.traversal.DocumentTraversal;
import org.w3c.dom.traversal.TreeWalker;
import org.w3c.dom.traversal.NodeIterator;
import org.w3c.dom.traversal.NodeFilter;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Element;

public class ShowDocument {

    public static void main (String args[]) {
       File docFile = new File("c:/test.xml");
                
       Document doc = null;
       try {
          DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
          DocumentBuilder db = dbf.newDocumentBuilder();
        
          doc = db.parse(docFile);
       } catch (Exception e) {
           System.out.print("Problem parsing the file.");
       }
       if(doc == null)System.out.println("null");
       DOMImplementation domimpl = doc.getImplementation();
       if (domimpl.hasFeature("Traversal", "2.0")) {

           Node root = doc.getDocumentElement();
           int whattoshow = NodeFilter.SHOW_ALL;
          NodeFilter nodefilter = null; 
           boolean expandreferences = false;

           DocumentTraversal traversal = (DocumentTraversal)doc;
  
           TreeWalker walker = traversal.createTreeWalker(root, 
                                                          whattoshow, 
                                                          nodefilter, 
                                                          expandreferences);
           Node thisNode = null;
           thisNode = walker.nextNode();
           while (thisNode != null) {
              if (thisNode.getNodeType() == Node.ELEMENT_NODE) {
                 System.out.print(thisNode.getNodeName() + " ");
                 Element thisElement = (Element)thisNode;
                 NamedNodeMap attributes = thisElement.getAttributes();
                 System.out.print("(");
                 for (int i = 0; i < attributes.getLength(); i++) {
                    System.out.print(attributes.item(i).getNodeName() + "=\"" +
                                     attributes.item(i).getNodeValue() + "\" ");
                 }
                 System.out.print(") : ");
              } else if (thisNode.getNodeType() == Node.TEXT_NODE) {
              	//thisNode.setNodeValue("changed");
                 System.out.println(thisNode.getNodeValue());
                 String parentNodeName = thisNode.getParentNode().getNodeName();
              }
              thisNode = walker.nextNode();
          }

        } else {
           System.out.println("The Traversal module isn't supported.");
        }
   }
}