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

// Global Interface Import Statements
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.Writer;

// Local Interface Import Statements
import java.io.Serializable;

public interface PowerProcessStep extends Serializable {

    public static final String ZEUS_XML_NAME = "PowerProcessStep";
    public static final String[] ZEUS_ATTRIBUTES = {};
    public static final String[] ZEUS_ELEMENTS = {"PPSID", "ID", "Name", "PSStepID", "BeginDate", "EndDate", "Sequence", "DueTime", "PSLimit", "DES", "RoleNames", "UserID", "UserName", "MaxDueTimeLimit", "MaxPSLimit", "IsOutOfDueTimeLimit", "IsOutOfPSLimit", "IsOverstep", "Memo"};

    public PPSID getPPSID();

    public void setPPSID(PPSID pPSID);

    public ID getID();

    public void setID(ID iD);

    public Name getName();

    public void setName(Name name);

    public PSStepID getPSStepID();

    public void setPSStepID(PSStepID pSStepID);

    public BeginDate getBeginDate();

    public void setBeginDate(BeginDate beginDate);

    public EndDate getEndDate();

    public void setEndDate(EndDate endDate);

    public Sequence getSequence();

    public void setSequence(Sequence sequence);

    public DueTime getDueTime();

    public void setDueTime(DueTime dueTime);

    public PSLimit getPSLimit();

    public void setPSLimit(PSLimit pSLimit);

    public DES getDES();

    public void setDES(DES dES);

    public RoleNames getRoleNames();

    public void setRoleNames(RoleNames roleNames);

    public UserID getUserID();

    public void setUserID(UserID userID);

    public UserName getUserName();

    public void setUserName(UserName userName);

    public MaxDueTimeLimit getMaxDueTimeLimit();

    public void setMaxDueTimeLimit(MaxDueTimeLimit maxDueTimeLimit);

    public MaxPSLimit getMaxPSLimit();

    public void setMaxPSLimit(MaxPSLimit maxPSLimit);

    public IsOutOfDueTimeLimit getIsOutOfDueTimeLimit();

    public void setIsOutOfDueTimeLimit(IsOutOfDueTimeLimit isOutOfDueTimeLimit);

    public IsOutOfPSLimit getIsOutOfPSLimit();

    public void setIsOutOfPSLimit(IsOutOfPSLimit isOutOfPSLimit);

    public IsOverstep getIsOverstep();

    public void setIsOverstep(IsOverstep isOverstep);

    public Memo getMemo();

    public void setMemo(Memo memo);

    public void marshal(File file) throws IOException;

    public void marshal(OutputStream outputStream) throws IOException;

    public void marshal(Writer writer) throws IOException;

    public void setDocType(String name, String publicID, String systemID);

    public void setOutputEncoding(String outputEncoding);

}
