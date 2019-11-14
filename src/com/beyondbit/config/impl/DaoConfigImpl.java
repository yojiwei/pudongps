package com.beyondbit.config.impl;


import java.io.File;
import java.util.Properties;
import java.io.InputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import com.beyondbit.config.DaoConfig;

public class DaoConfigImpl extends DaoConfig{
    private String driver = "oracle.jdbc.driver.OracleDriver";
    private String connectionURL;
    private boolean defaultAutoCommit;
    private boolean defaultReadOnly;
    private int maxActive = 5;
    private int maxWait = 3;
    private String username;
    private String password;
    private String version;
    
    public DaoConfigImpl() throws Exception {
        this(null);
    }

    public DaoConfigImpl(String configFile) throws Exception {
        InputStream in = null;
        if(configFile == null){
            in = this.getClass().getClassLoader().getResourceAsStream("db.properties");
        }else{
            in = new FileInputStream(configFile);
        }
        Properties p = new Properties();
        p.load(in);
        Field[] f = this.getClass().getDeclaredFields();
        Method m = null;
        for(int i=0;i<f.length; i ++){
            String vname = f[i].getName ();
            vname = Character.toUpperCase (vname.charAt (0)) +
                vname.substring (1);
            Class[] c= new Class[1];
            c[0] = f[i].getType ();
            m = this.getClass ().getMethod ("set" + vname, c);
            Object[] o = new Object[1];
            if(c[0].equals(Boolean.TYPE)){
                if("true".equals(p.getProperty (f[i].getName ()))){
                    o[0] = new Boolean(true);
                }else{
                    o[0] = new Boolean(false);
                }
            }else if(c[0].equals(Integer.TYPE)){
                if (p.getProperty (f[i].getName ()) != null) {
                    o[0] = new Integer (p.getProperty (f[i].getName ()));
                }
            }else{
                o[0] = p.getProperty(f[i].getName());
            }
            if(o[0] != null){
                m.invoke(this,o);
            }
        }

    }

    /**
     * getDriver
     *
     * @return String
     */
    public String getDriver() {
        return this.driver;
    }

    /**
     * getConnectionURL
     *
     * @return String
     */
    public String getConnectionURL() {
        return this.connectionURL;
    }
    
    
    public String getVersion(){
    	return this.version;
    }

    /**
     * getMaxActive
     *
     * @return int
     */
    public int getMaxActive() {
        return this.maxActive;
    }

    /**
     * getMaxWait
     *
     * @return int
     */
    public int getMaxWait() {
        return this.maxWait;
    }

    /**
     * getDefaultAutoCommit
     *
     * @return boolean
     */
    public boolean getDefaultAutoCommit() {
        return this.defaultAutoCommit;
    }

    /**
     * getDefaultReadOnly
     *
     * @return boolean
     */
    public boolean getDefaultReadOnly() {
        return this.defaultReadOnly;
    }

    /**
     * getUsername
     *
     * @return String
     */
    public String getUsername() {
        return this.username;
    }

    /**
     * getPassword
     *
     * @return String
     */
    public String getPassword() {
        return this.password;
    }

    /**
     * getProperty
     *
     * @param key String
     * @param defaultValue String
     * @return String
     */
    public String getProperty(String key, String defaultValue) {
        return "";
    }
  public void setConnectionURL(String connectionURL) {
    this.connectionURL = connectionURL;
  }
  public void setDefaultAutoCommit(boolean defaultAutoCommit) {
    this.defaultAutoCommit = defaultAutoCommit;
  }

  public void setDefaultReadOnly(boolean defaultReadonly) {
    this.defaultReadOnly = defaultReadonly;
  }

  public void setDriver(String driver) {
    this.driver = driver;
  }
  public void setMaxActive(int maxActive) {
    this.maxActive = maxActive;
  }
  public void setMaxWait(int maxWait) {
    this.maxWait = maxWait;
  }
  public void setPassword(String password) {
    this.password = password;
  }
  public void setUsername(String username) {
    this.username = username;
  }
  
  public void setVersion(String version) {
	this.version = version;
  }
}
