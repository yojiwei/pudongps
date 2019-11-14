///////////////////////////////////////////////////////////
// DeJaved by mDeJava v1.0. Copyright 1999 MoleSoftware. //
//       To download last version of this software:      //
//            http://molesoftware.hypermatr.net          //
//               e-mail:molesoftware@mail.ru             //
///////////////////////////////////////////////////////////

package oraclebbs;

import java.io.PrintStream;
import java.sql.*;

import com.util.ReadProperty;

public class DBConnection
{

    public String db_ip = null;
    public String db_port = null;
    public String db_uid = null;
    public String user = null;
    public String password = null;
    public String db_driver = null;
    public String db_url = null;
    public String db_type = null;
    public String Sqlstring = null;
    public Connection db_conn = null;
    public Statement db_stmt = null;
    public ResultSet db_rset = null;
    public int record_count = 0;
    public int field_count = 0;
    private ReadProperty pro = null;

    public DBConnection()
    {
        db_type = "oracle";
//        user = "pudongweb";
//        password = "aimer19810216~";
//        db_ip = "192.168.152.200";
//        db_port = "1521";
//        db_uid = "beyond";
        try
        {
        	pro = new ReadProperty();
  		    user = pro.getPropertyValue("dbusername");
  		    password = pro.getPropertyValue("dbpassword");
  		    db_ip = pro.getPropertyValue("dbip");
  		    db_port = pro.getPropertyValue("dbport");
  		    db_uid = pro.getPropertyValue("dbsid");
  		    
            Class.forName("oracle.jdbc.driver.OracleDriver");
        }
        catch(ClassNotFoundException classnotfoundexception)
        {
            System.out.println("Could not load the driver.");
            classnotfoundexception.printStackTrace();
        }
        String s1 = user + "/" + password + "@" + db_ip + ":" + db_port + ":" + db_uid;
        try
        {
            db_conn = DriverManager.getConnection("jdbc:oracle:thin:" + s1);
        }
        catch(SQLException sqlexception)
        {
            System.out.println("Creat connection error.");
            sqlexception.printStackTrace();
        }
    }

    public void setuser(String s)
    {
        user = s;
    }

    public void setpassword(String s)
    {
        password = s;
    }

    public String getuser()
    {
        return user;
    }

    public String getpassword()
    {
        return password;
    }

    public String getdbtype()
    {
        return db_type;
    }

    public int getrecordcount()
    {
        return record_count;
    }

    public int getfieldcount()
    {
        return field_count;
    }

    public ResultSet executeQuery(String s)
        throws SQLException
    {
        db_stmt = db_conn.createStatement();
        int i = s.indexOf("from");
        if(i < 0)
            i = s.indexOf("FROM");
        String s1 = s.substring(i);
        s1 = "select count(*) " + s1;
        db_rset = db_stmt.executeQuery(s1);
        if(db_rset.next())
            record_count = db_rset.getInt(1);
        db_rset = db_stmt.executeQuery(s);
        ResultSetMetaData resultsetmetadata = db_rset.getMetaData();
        field_count = resultsetmetadata.getColumnCount();
        return db_rset;
    }

    public int executeUpdate(String s)
        throws SQLException
    {
        db_stmt = db_conn.createStatement();
        return db_stmt.executeUpdate(s);
    }

    public String getColumnName(int i)
        throws SQLException
    {
        ResultSetMetaData resultsetmetadata = db_rset.getMetaData();
        return resultsetmetadata.getColumnName(i);
    }

    public String getData(int i)
        throws SQLException
    {
        return db_rset.getString(i).trim();
    }

    public String getData(String s)
        throws SQLException
    {
        return db_rset.getString(s).trim();
    }

    public boolean next()
        throws SQLException
    {
        return db_rset.next();
    }

    public void close()
        throws SQLException
    {
        if(db_conn != null)
            db_conn.close();
        if(db_stmt != null)
            db_stmt.close();
        if(db_rset != null)
            db_rset.close();
    }

    public Connection getConnection()
    {
        return db_conn;        
    }

    public CallableStatement spCall(String s)
        throws Exception
    {
        return db_conn.prepareCall(s);
    }
}