package com.util;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2003</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */

import java.sql.*;
import javax.naming.*;
import javax.sql.*;
import java.util.Vector;
import java.util.Hashtable;
import oracle.jdbc.OracleDatabaseMetaData;
import oracle.jdbc.driver.OracleDriver;
import java.io.FileWriter;
import javax.xml.parsers.*;

import com.component.database.*;

import org.apache.xerces.parsers.DOMParser;
import org.xml.sax.*;
import org.w3c.dom.Node;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Attr;
import org.apache.xml.serialize.OutputFormat;
import org.apache.xml.serialize.XMLSerializer;
import org.apache.xml.serialize.LineSeparator;
import java.io.*;

public class Table2XML {
    Connection conn = null;
    String result = null;
    CDataCn dCn;
    CDataImpl dImpl;
    OracleDatabaseMetaData dbmd;

    /*
      public DBConn() {
        try {
          InitialContext ctx = new InitialContext();
          DataSource ds = (DataSource)ctx.lookup("jdbc/cp/OraDataSource");
          conn = ds.getConnection();
        }
        catch (NamingException ex) {
          ex.printStackTrace();
        }
        catch (SQLException ex) {
          ex.printStackTrace();
        }
      }
     */
    public Table2XML() {
        try {
            String strUrl = "jdbc:oracle:thin:@localhost:1521:pudong";
            String strDBDriver = "oracle.jdbc.driver.OracleDriver";
            String strWebname = "pudong";
            String strWebpass = "123456";
            Class.forName(strDBDriver);
            conn = DriverManager.getConnection(strUrl, strWebname, strWebpass);
            //OracleDriver driver = (OracleDriver)Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
            //Connection conn = driver.g

        }
        catch (Exception ex) {
            System.out.println(ex);
        }
        //dCn = new CDataCn();
        //dImpl = new CDataImpl(dCn);
    }

    public String exeQuery(String sql) {
        if (conn == null) {
            return result;
        }
        else {
            try {
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql);
                while (rs.next()) {
                    result = rs.getString(2) + "  " + rs.getString(3);
                }

            }
            catch (SQLException ex) {
            }
            return result;
        }

    }

    public Vector getTableNames() {
        Vector tbv = new Vector(100);

        String sql = "select table_name from all_catalog where all_catalog.OWNER='PUDONG' and table_type='TABLE'";

        if (conn == null) {
            return null;
        }
        else {
            try {

                OracleDatabaseMetaData dbmd = (OracleDatabaseMetaData) conn.
                    getMetaData();
                /*
                         ResultSet rs = dbmd.getSchemas();
                         while(rs.next()){
                  System.out.println("Schema: " + rs.getString(1));
                         }
                         rs = dbmd.getCatalogs();
                         while(rs.next()){
                  System.out.println("Catalog: " + rs.getString(1));
                         }
                     rs = dbmd.getTables("david", "PUDONG", "%", null); //new String[]{"TABLE"});
                         ResultSetMetaData rsmd = rs.getMetaData();
                         int count  = rsmd.getColumnCount();
                         for(int i = 1; i <= count; i++){
                  System.out.print(rsmd.getColumnName(i) + "      ");
                         }
                         System.out.print("\n");
                 */
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    String tableName = rs.getString(1);
                    if (tableName.indexOf("TB_") != -1) {
                        tbv.add(tableName);
                    }
                }
            }
            catch (SQLException ex) {
                ex.printStackTrace();
            }

        }
        /*
             Vector vectorPage = dImpl.splitPage(sql, 1000, 0);
             if(tbv != null){
          for(int i = 0; i < vectorPage.size(); i++){
            Hashtable content = (Hashtable) vectorPage.get(0);
            tbv.add((String)content.get("table_name"));
          }
             }
         */
        return tbv;
    }

    public void table2XML() {
        Vector tbv = getTableNames();
        try {

            for (int i = 0; i < tbv.size(); i++) {
                DocumentBuilder builder = DocumentBuilderFactory.newInstance().
                    newDocumentBuilder();
                Document document = builder.newDocument();
                Element root = document.createElement("Table");
                document.appendChild(root);

                Statement stmt = conn.createStatement();

                String tableName = (String) tbv.elementAt(i);

                root.setAttribute("name", tableName);

                Element item = document.createElement("PrimaryKeys");
                root.appendChild(item);

                ResultSet rs = stmt.executeQuery("select c.column_name from all_cons_columns c, all_constraints k WHERE k.constraint_type='P' AND k.table_name ='" +
                                                 tableName + "' AND k.constraint_name = c.constraint_name AND k.table_name = c.table_name AND k.owner = c.owner AND k.owner='PUDONG'");
                while (rs.next()) {
                    Element pKey = document.createElement("PrimaryKey");
                    pKey.setAttribute("name", rs.getString(1));
                    item.appendChild(pKey);
                }

                item = document.createElement("Columns");
                root.appendChild(item);

                rs = stmt.executeQuery("select * from " + tableName);
                ResultSetMetaData rsmd = rs.getMetaData();

                int count = rsmd.getColumnCount();
                System.out.println(tableName + ":");

                Element item1 = item;
                for (int j = 1; j <= count; j++) {
                    item = document.createElement("Column");
                    item.setAttribute("name", rsmd.getColumnName(j));
                    item.setAttribute("type", rsmd.getColumnTypeName(j));
                    item1.appendChild(item);
                }
                root.appendChild(item1);
                writeXML(document, tableName);
            }

        }
        catch (FactoryConfigurationError ex1) {
            ex1.printStackTrace();
        }
        catch (ParserConfigurationException ex1) {
            ex1.printStackTrace();
        }
        catch (SQLException ex) {
            ex.printStackTrace();
        }

    }

    private void writeXML(Document document, String filename) {

        OutputFormat format = new OutputFormat(document);
        format.setLineSeparator(LineSeparator.Windows);
        format.setIndenting(true);
        format.setLineWidth(0);
        format.setPreserveSpace(true);

        XMLSerializer serializer = null;
        try {
            serializer = new XMLSerializer(new FileWriter("g:\\InToOut\\" +
                filename + ".xml"), format);

            serializer.asDOMSerializer();
            serializer.serialize(document);

        }
        catch (IOException ex) {
            ex.printStackTrace();
        }

    }

    public static void main(String[] args) {
        Table2XML DBConn1 = new Table2XML();
        DBConn1.table2XML();
    }

}