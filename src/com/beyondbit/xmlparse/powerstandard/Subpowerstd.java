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

// Global Interface Import Statements
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.Writer;

// Local Interface Import Statements
import java.io.Serializable;

public interface Subpowerstd extends Serializable {

    public static final String ZEUS_XML_NAME = "subpowerstd";
    public static final String[] ZEUS_ATTRIBUTES = {};
    public static final String[] ZEUS_ELEMENTS = {"id", "powerstd_id", "createtime", "createunitid", "createuserid", "createusername", "createunitname", "state", "powerstdsteps"};

    public Id getId();

    public void setId(Id id);

    public Powerstd_id getPowerstd_id();

    public void setPowerstd_id(Powerstd_id powerstd_id);

    public Createtime getCreatetime();

    public void setCreatetime(Createtime createtime);

    public Createunitid getCreateunitid();

    public void setCreateunitid(Createunitid createunitid);

    public Createuserid getCreateuserid();

    public void setCreateuserid(Createuserid createuserid);

    public Createusername getCreateusername();

    public void setCreateusername(Createusername createusername);

    public Createunitname getCreateunitname();

    public void setCreateunitname(Createunitname createunitname);

    public State getState();

    public void setState(State state);

    public Powerstdsteps getPowerstdsteps();

    public void setPowerstdsteps(Powerstdsteps powerstdsteps);

    public void marshal(File file) throws IOException;

    public void marshal(OutputStream outputStream) throws IOException;

    public void marshal(Writer writer) throws IOException;

    public void setDocType(String name, String publicID, String systemID);

    public void setOutputEncoding(String outputEncoding);

}
