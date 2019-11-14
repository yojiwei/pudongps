// FrontEnd Plus GUI for JAD
// DeCompiled : Vote.class

package vote;

import com.component.database.CDataCn;
import com.component.database.CDataImpl;
import com.util.CTools;
import java.io.PrintStream;
import java.sql.*;
import java.util.Hashtable;
import java.util.Vector;
import java.util.regex.Pattern;

// Referenced classes of package vote:
//            VoteStruct

public class Vote
{

    private Vector vectorVoteTitle;
    private Vector vtDetailTitle;
    private Hashtable hashDetailTitle;
    private Hashtable hashrdNoSum;
    private String vt_desc;
    private String cSort;

    public Vote()
    {
        vtDetailTitle = null;
        hashDetailTitle = null;
        hashrdNoSum = null;
        vt_desc = null;
        cSort = null;
        vectorVoteTitle = new Vector();
        vtDetailTitle = new Vector();
        hashDetailTitle = new Hashtable();
        hashrdNoSum = new Hashtable();
    }

    public static void main(String args[])
        throws SQLException
    {
        String vt_id = "12508";
        String vt_sort = "hy";
        System.out.println("-------------start-------------");
        Vote vote = new Vote();
        vote.getVoteTitle(vt_id);
        System.out.print(vote.totalManTitle(vt_id, 14));
        System.out.println("=============== " + vote.hashDetailTitle);
        System.out.print(vote.reTotalDept_Date(vt_id, vt_sort));
        System.out.println("-------------end-------------");
    }

    public String getVoteTitle(String id)
    {
        vectorVoteTitle.clear();
        //ÅÐ¶ÏÊÇ·ñÎªÊý×Ö
        Pattern pattern = Pattern.compile("[0-9]*"); 
        if(!"".equals(id)&&pattern.matcher(id).matches()){       
        	getVoteTitleSub(Integer.parseInt(id), 0);
        }
        return null;
    }

    public String getVoteTitleSub(int id, int level)
    {
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        String sqlStr = "select * from tb_votediy where vt_upperid = " + id + " order by vt_sequence";
        Vector vPage = dImpl.splitPage(sqlStr, 1000, 1);
        if(vPage != null)
        {
            for(int i = 0; i < vPage.size(); i++)
            {
                Hashtable content = (Hashtable)vPage.get(i);
                VoteStruct votestruct = new VoteStruct();
                votestruct.setId(Integer.parseInt(content.get("vt_id").toString()));
                votestruct.setName(content.get("vt_name").toString());
                votestruct.setUpperid(Integer.parseInt(content.get("vt_upperid").toString()));
                votestruct.setType(content.get("vt_type").toString());
                votestruct.setSequence(Integer.parseInt(content.get("vt_sequence").toString()));
                votestruct.setDbname(content.get("vt_dbname").toString());
                votestruct.setFrontpagename(content.get("vt_frontpagename").toString());
                votestruct.setDesc(content.get("vt_desc").toString());
                votestruct.setParameter(content.get("vt_parameter").toString());
                votestruct.setLevel(level);
                vectorVoteTitle.add(votestruct);
                getVoteTitleSub(Integer.parseInt(content.get("vt_id").toString()), level + 1);
            }

        }
        dImpl.closeStmt();
        dCn.closeCn();
        return null;
    }

    public String ShowVoteFrontPage()
    {
        String strShowVoteFrontPage = "";
        if(vectorVoteTitle != null)
        {
            for(int i = 0; i < vectorVoteTitle.size(); i++)
            {
                VoteStruct votestruct = new VoteStruct();
                votestruct = (VoteStruct)vectorVoteTitle.get(i);
                strShowVoteFrontPage = strShowVoteFrontPage + "<tr><td>";
                for(int j = 0; j < votestruct.getLevel(); j++)
                    strShowVoteFrontPage = strShowVoteFrontPage + "&nbsp;";

                if(votestruct.getType().equals("title"))
                    strShowVoteFrontPage = strShowVoteFrontPage + votestruct.getName();
                if(votestruct.getType().equals("radio"))
                    strShowVoteFrontPage = strShowVoteFrontPage + "<input type='radio' name='" + votestruct.getFrontpagename() + "' value='" + votestruct.getDbname() + "'>" + votestruct.getName();
                if(votestruct.getType().equals("checkbox"))
                    strShowVoteFrontPage = strShowVoteFrontPage + "<input type='checkbox' name='" + votestruct.getFrontpagename() + "' value='" + votestruct.getDbname() + "'>" + votestruct.getName();
                if(votestruct.getType().equals("text") || votestruct.getType().equals("textarea"))
                {
                    String vt_parameter_1 = "";
                    String vt_parameter_2 = "";
                    String temp[] = votestruct.getParameter().split(",");
                    for(int n = 0; n < temp.length; n++)
                    {
                        if(n == 0)
                            vt_parameter_1 = temp[0];
                        if(n == 1)
                            vt_parameter_2 = temp[1];
                    }

                    if(votestruct.getType().equals("text"))
                        strShowVoteFrontPage = strShowVoteFrontPage + votestruct.getName() + "<input type='text' name='" + votestruct.getFrontpagename() + "' class='text-area' size='" + vt_parameter_1 + "' maxlength='" + vt_parameter_2 + "'>";
                    if(votestruct.getType().equals("textarea"))
                    {
                        strShowVoteFrontPage = strShowVoteFrontPage + votestruct.getName() + "<br>";
                        for(int j = 0; j < votestruct.getLevel(); j++)
                            strShowVoteFrontPage = strShowVoteFrontPage + "&nbsp;";

                        strShowVoteFrontPage = strShowVoteFrontPage + "<textarea name='" + votestruct.getFrontpagename() + "' class='text-area' cols='" + vt_parameter_1 + "' rows='" + vt_parameter_2 + "'></textarea>";
                    }
                }
                strShowVoteFrontPage = strShowVoteFrontPage + "</td></tr>";
            }

        }
        return strShowVoteFrontPage;
    }

    public String ShowVoteResultFrontPageTree(String treeid)
    {
        String strShowVoteResultFrontPageTree = "";
        if(vectorVoteTitle != null)
        {
            int intLineNum = 0;
            for(int i = 0; i < vectorVoteTitle.size(); i++)
            {
                VoteStruct votestruct = new VoteStruct();
                votestruct = (VoteStruct)vectorVoteTitle.get(i);
                if(intLineNum % 2 == 0)
                    strShowVoteResultFrontPageTree = strShowVoteResultFrontPageTree + "<tr width='100%' class='line-even'>";
                else
                    strShowVoteResultFrontPageTree = strShowVoteResultFrontPageTree + "<tr width='100%' class='line-odd'>";
                intLineNum++;
                strShowVoteResultFrontPageTree = strShowVoteResultFrontPageTree + "<td align='left' width='85%'>";
                for(int j = 0; j < votestruct.getLevel(); j++)
                    strShowVoteResultFrontPageTree = strShowVoteResultFrontPageTree + "&nbsp;";

                if(votestruct.getType().equals("title"))
                {
                    if(votestruct.getName().equals(""))
                        strShowVoteResultFrontPageTree = strShowVoteResultFrontPageTree + "<font color='#aaaaaa'>[\u7A7A]</font>";
                    if(!votestruct.getName().equals(""))
                        strShowVoteResultFrontPageTree = strShowVoteResultFrontPageTree + votestruct.getName();
                }
                if(votestruct.getType().equals("radio"))
                {
                    if(votestruct.getName().equals(""))
                        strShowVoteResultFrontPageTree = strShowVoteResultFrontPageTree + "<input type='radio' name='" + votestruct.getFrontpagename() + "' value='" + votestruct.getDbname() + "'><font color='#aaaaaa'>[\u7A7A]</font>";
                    if(!votestruct.getName().equals(""))
                        strShowVoteResultFrontPageTree = strShowVoteResultFrontPageTree + "<input type='radio' name='" + votestruct.getFrontpagename() + "' value='" + votestruct.getDbname() + "'>" + votestruct.getName();
                }
                if(votestruct.getType().equals("checkbox"))
                {
                    if(votestruct.getName().equals(""))
                        strShowVoteResultFrontPageTree = strShowVoteResultFrontPageTree + "<input type='checkbox' name='" + votestruct.getFrontpagename() + "' value='" + votestruct.getDbname() + "'><font color='#aaaaaa'>[\u7A7A]</font>";
                    if(!votestruct.getName().equals(""))
                        strShowVoteResultFrontPageTree = strShowVoteResultFrontPageTree + "<input type='checkbox' name='" + votestruct.getFrontpagename() + "' value='" + votestruct.getDbname() + "'>" + votestruct.getName();
                }
                if(votestruct.getType().equals("text") || votestruct.getType().equals("textarea"))
                {
                    String vt_parameter_1 = "";
                    String vt_parameter_2 = "";
                    String temp[] = votestruct.getParameter().split(",");
                    for(int n = 0; n < temp.length; n++)
                    {
                        if(n == 0)
                            vt_parameter_1 = temp[0];
                        if(n == 1)
                            vt_parameter_2 = temp[1];
                    }

                    if(votestruct.getType().equals("text"))
                    {
                        if(votestruct.getName().equals(""))
                            strShowVoteResultFrontPageTree = strShowVoteResultFrontPageTree + "<font color='#aaaaaa'>[\u7A7A]</font><input type='text' name='" + votestruct.getFrontpagename() + "' class='text-area' size='" + vt_parameter_1 + "' maxlength='" + vt_parameter_2 + "'>";
                        if(!votestruct.getName().equals(""))
                            strShowVoteResultFrontPageTree = strShowVoteResultFrontPageTree + votestruct.getName() + "<input type='text' name='" + votestruct.getFrontpagename() + "' class='text-area' size='" + vt_parameter_1 + "' maxlength='" + vt_parameter_2 + "'>";
                    }
                    if(votestruct.getType().equals("textarea"))
                    {
                        if(votestruct.getName().equals(""))
                            strShowVoteResultFrontPageTree = strShowVoteResultFrontPageTree + "<font color='#aaaaaa'>[\u7A7A]</font><br>";
                        if(!votestruct.getName().equals(""))
                            strShowVoteResultFrontPageTree = strShowVoteResultFrontPageTree + votestruct.getName() + "<br>";
                        for(int j = 0; j < votestruct.getLevel(); j++)
                            strShowVoteResultFrontPageTree = strShowVoteResultFrontPageTree + "&nbsp;";

                        strShowVoteResultFrontPageTree = strShowVoteResultFrontPageTree + "<textarea name='" + votestruct.getFrontpagename() + "' class='text-area' cols='" + vt_parameter_1 + "' rows='" + vt_parameter_2 + "'></textarea>";
                    }
                }
                strShowVoteResultFrontPageTree = strShowVoteResultFrontPageTree + "</td>";
                strShowVoteResultFrontPageTree = strShowVoteResultFrontPageTree + "<td align='center' width='5%'><a href='info.jsp?OType=Add&upperid=" + votestruct.getId() + "&treeid=" + treeid + "'><img src='../../../images/new.gif' border='0' title='\u65B0\u5EFA'></a></td>";
                strShowVoteResultFrontPageTree = strShowVoteResultFrontPageTree + "<td align='center' width='5%'><a href='info.jsp?OType=Edit&editid=" + votestruct.getId() + "&upperid=" + votestruct.getUpperid() + "&treeid=" + treeid + "'><img src='../../../images/modi.gif' border='0' title='\u4FEE\u6539'></a></td>";
                strShowVoteResultFrontPageTree = strShowVoteResultFrontPageTree + "<td align='center'><input type=text class=text-line name=module" + votestruct.getId() + " value='" + votestruct.getSequence() + "' size=4></td>";
                strShowVoteResultFrontPageTree = strShowVoteResultFrontPageTree + "</tr>";
            }

        }
        return strShowVoteResultFrontPageTree;
    }

    public String ShowVoteResultFrontPage(String id, int num)
    {
        String strShowVoteResultFrontPage = "";
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        int intShowVote = num;
        String strTableName = "TB_VOTEDIY" + id;
        int totalvotenum = 0;
        String sqlStr_totalvotenum = "select count(*) num from " + strTableName;
        Hashtable content_strnum = dImpl.getDataInfo(sqlStr_totalvotenum);
        if(content_strnum != null)
            totalvotenum = Integer.parseInt(CTools.dealNull(content_strnum.get("num"), "0"));
        if(num != 0)
        {
            int numfrom = ((num - 1) / 10) * 10 + 1;
            int numto = (numfrom + 10) - 1;
            if(numto > totalvotenum)
                numto = totalvotenum;
            String sqlStr_voteresultsub = "select * from (select rownum num,a.* from " + strTableName + " a) where num between " + numfrom + " and " + numto;
            int voteindexnum = num - numfrom;
            Vector vPage_voteresultsub = dImpl.splitPage(sqlStr_voteresultsub, 10000, 1);
            int intLineNum = 0;
            if(vectorVoteTitle != null)
            {
                for(int i = 0; i < vectorVoteTitle.size(); i++)
                {
                    VoteStruct votestruct = new VoteStruct();
                    votestruct = (VoteStruct)vectorVoteTitle.get(i);
                    if(intLineNum % 2 == 0)
                        strShowVoteResultFrontPage = strShowVoteResultFrontPage + "<tr width='100%' class='line-even'>";
                    else
                        strShowVoteResultFrontPage = strShowVoteResultFrontPage + "<tr width='100%' class='line-odd'>";
                    intLineNum++;
                    int intSubLineNum = 0;
                    if(vPage_voteresultsub != null)
                        if(votestruct.getType().equals("title"))
                        {
                            for(int j = 0; j < vPage_voteresultsub.size(); j++)
                            {
                                if(intSubLineNum % 2 == 0)
                                    strShowVoteResultFrontPage = strShowVoteResultFrontPage + "<td width='1%' bgcolor='#eeeeee'>&nbsp;</td>";
                                else
                                    strShowVoteResultFrontPage = strShowVoteResultFrontPage + "<td width='1%' bgcolor='#ffffff'>&nbsp;</td>";
                                intSubLineNum++;
                            }

                        } else
                        {
                            for(int j = 0; j < vPage_voteresultsub.size(); j++)
                            {
                                Hashtable content_voteresultsub = (Hashtable)vPage_voteresultsub.get(j);
                                if(intSubLineNum % 2 == 0)
                                    strShowVoteResultFrontPage = strShowVoteResultFrontPage + "<td width='1%' bgcolor='#eeeeee'>";
                                else
                                    strShowVoteResultFrontPage = strShowVoteResultFrontPage + "<td width='1%' bgcolor='#ffffff'>";
                                intSubLineNum++;
                                if(!content_voteresultsub.get(votestruct.getDbname()).toString().equals(""))
                                    strShowVoteResultFrontPage = strShowVoteResultFrontPage + "\u2605</td>";
                                else
                                    strShowVoteResultFrontPage = strShowVoteResultFrontPage + "\u2606</td>";
                            }

                        }
                    if(votestruct.getType().equals("title"))
                    {
                        strShowVoteResultFrontPage = strShowVoteResultFrontPage + "<td align='left' colspan='3' width='90%'>";
                        for(int j = 0; j < votestruct.getLevel(); j++)
                            strShowVoteResultFrontPage = strShowVoteResultFrontPage + "&nbsp;";

                        strShowVoteResultFrontPage = strShowVoteResultFrontPage + votestruct.getName();
                        strShowVoteResultFrontPage = strShowVoteResultFrontPage + "</td>";
                    }
                    Hashtable content_voteresultsub = (Hashtable)vPage_voteresultsub.get(voteindexnum);
                    if(votestruct.getType().equals("radio") || votestruct.getType().equals("checkbox"))
                    {
                        strShowVoteResultFrontPage = strShowVoteResultFrontPage + "<td align='left' width='70%'>";
                        for(int j = 0; j < votestruct.getLevel(); j++)
                            strShowVoteResultFrontPage = strShowVoteResultFrontPage + "&nbsp;";

                        if(content_voteresultsub.get(votestruct.getDbname()).toString().equals("1"))
                            strShowVoteResultFrontPage = strShowVoteResultFrontPage + "<span style='background-color: #FFFF00'>" + votestruct.getName() + "</span>";
                        else
                            strShowVoteResultFrontPage = strShowVoteResultFrontPage + votestruct.getName();
                        strShowVoteResultFrontPage = strShowVoteResultFrontPage + "</td>";
                        String sqlStr_itemvotenum = "select count(*) num from " + strTableName + " where " + votestruct.getDbname() + " = '1'";
                        Hashtable content_itemvotenum = dImpl.getDataInfo(sqlStr_itemvotenum);
                        int itemvotenum = Integer.parseInt(content_itemvotenum.get("num").toString());
                        double percent = 0.0D;
                        if(totalvotenum != 0)
                            percent = (double)itemvotenum / (double)totalvotenum;
                        strShowVoteResultFrontPage = strShowVoteResultFrontPage + "<td align=\"left\" width='5%'>" + (double)(int)(percent * 1000D) / 10D + "%</td>\n";
                        strShowVoteResultFrontPage = strShowVoteResultFrontPage + "<td align=\"left\" width='15%'><img src=\"/system/images/bar.gif\" width='" + percent * 60D + "' height=\"5\">&nbsp;&nbsp;" + itemvotenum + "\u7968</td>";
                    }
                    if(votestruct.getType().equals("text") || votestruct.getType().equals("textarea"))
                    {
                        strShowVoteResultFrontPage = strShowVoteResultFrontPage + "<td align='left' width='90%' colspan='3'>";
                        for(int j = 0; j < votestruct.getLevel(); j++)
                            strShowVoteResultFrontPage = strShowVoteResultFrontPage + "&nbsp;";

                        String vt_parameter_1 = "";
                        String vt_parameter_2 = "";
                        String temp[] = votestruct.getParameter().split(",");
                        for(int n = 0; n < temp.length; n++)
                        {
                            if(n == 0)
                                vt_parameter_1 = temp[0];
                            if(n == 1)
                                vt_parameter_2 = temp[1];
                        }

                        if(votestruct.getType().equals("text"))
                            strShowVoteResultFrontPage = strShowVoteResultFrontPage + votestruct.getName() + "<input type='text' name='" + votestruct.getFrontpagename() + "' class='text-area' size='" + vt_parameter_1 + "' maxlength='" + vt_parameter_2 + "' value='" + content_voteresultsub.get(votestruct.getDbname()).toString() + "' readonly>";
                        if(votestruct.getType().equals("textarea"))
                        {
                            strShowVoteResultFrontPage = strShowVoteResultFrontPage + votestruct.getName() + "<br>";
                            for(int j = 0; j < votestruct.getLevel(); j++)
                                strShowVoteResultFrontPage = strShowVoteResultFrontPage + "&nbsp;";

                            strShowVoteResultFrontPage = strShowVoteResultFrontPage + "<textarea name='" + votestruct.getFrontpagename() + "' class='text-area' cols='" + vt_parameter_1 + "' rows='" + vt_parameter_2 + "' readonly>" + content_voteresultsub.get(votestruct.getDbname()).toString() + "</textarea>";
                        }
                        strShowVoteResultFrontPage = strShowVoteResultFrontPage + "</td>";
                    }
                    strShowVoteResultFrontPage = strShowVoteResultFrontPage + "</tr>";
                }

            }
        } else
        {
            strShowVoteResultFrontPage = strShowVoteResultFrontPage + "<tr><td>\u65E0\u6295\u7968</td></tr>";
        }
        dImpl.closeStmt();
        dCn.closeCn();
        return strShowVoteResultFrontPage;
    }

    public String ShowAllResult(String id)
    {
        String strShowAllResult = "";
        String strTableName = "TB_VOTEDIY" + id;
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        String sqlStr_vote = "select * from " + strTableName;
        Vector vPage_vote = dImpl.splitPage(sqlStr_vote, 10000, 1);
        if(vectorVoteTitle != null)
        {
            for(int i = 0; i < vectorVoteTitle.size(); i++)
            {
                VoteStruct votestruct = new VoteStruct();
                votestruct = (VoteStruct)vectorVoteTitle.get(i);
                strShowAllResult = strShowAllResult + "<tr>";
                strShowAllResult = strShowAllResult + "<td>";
                strShowAllResult = strShowAllResult + votestruct.getName();
                strShowAllResult = strShowAllResult + "</td>";
                if(vPage_vote != null)
                {
                    for(int j = 0; j < vPage_vote.size(); j++)
                    {
                        Hashtable content_vote = (Hashtable)vPage_vote.get(j);
                        if(!votestruct.getType().equals("title"))
                            if(!content_vote.get(votestruct.getDbname()).toString().equals(""))
                                strShowAllResult = strShowAllResult + "<td>" + content_vote.get(votestruct.getDbname()).toString() + "</td>";
                            else
                                strShowAllResult = strShowAllResult + "<td>&nbsp;</td>";
                    }

                }
                strShowAllResult = strShowAllResult + "</tr>";
            }

        }
        dImpl.closeStmt();
        dCn.closeCn();
        return strShowAllResult;
    }

    public String CreateVoteDB(String id)
    {
        String strCreateVoteDBStr = "";
        strCreateVoteDBStr = strCreateVoteDBStr + "CREATE TABLE TB_VOTEDIY" + id + "(";
        strCreateVoteDBStr = strCreateVoteDBStr + "VS_ID NUMBER NOT NULL";
        strCreateVoteDBStr = strCreateVoteDBStr + ")";
        CDataCn dCn = new CDataCn();
        Connection conn = dCn.getConnection();
        try
        {
            Statement stmt = conn.createStatement();
            stmt.executeUpdate(strCreateVoteDBStr);
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        dCn.closeCn();
        return strCreateVoteDBStr;
    }

    public String AlterTable(String tablename, String id, String length, String type)
    {
        String strAlterTable = "";
        if(type.equals("add"))
            strAlterTable = "ALTER TABLE " + tablename + " ADD o" + id + " VARCHAR2(" + length + ")";
        if(type.equals("del"))
            strAlterTable = "ALTER TABLE " + tablename + " DROP (o" + id + ")";
        if(type.equals("edit"))
        {
            Vote vote = new Vote();
            vote.AlterTable(tablename, id, length, "del");
            vote.AlterTable(tablename, id, length, "add");
        }
        CDataCn dCn = new CDataCn();
        Connection conn = dCn.getConnection();
        try
        {
            if(!"".equals(strAlterTable))
            {
                Statement stmt = conn.createStatement();
                stmt.executeUpdate(strAlterTable);
            }
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        dCn.closeCn();
        return strAlterTable;
    }

    public String DelItem(String id, String upperid, String type)
    {
        CDataCn dCn_dptable = new CDataCn();
        CDataImpl dImpl_dptable = new CDataImpl(dCn_dptable);
        if(upperid.equals("0"))
        {
            String sqlStr_dptable = "select * from sys.all_all_tables where owner = 'PUDONG' and table_name='TB_VOTEDIY" + id + "'";
            Vector vPage_dptable = dImpl_dptable.splitPage(sqlStr_dptable, 100, 1);
            String strDropTable = "";
            if(vPage_dptable != null)
            {
                strDropTable = "drop table tb_votediy" + id;
                Connection conn = dCn_dptable.getConnection();
                try
                {
                    Statement stmt = conn.createStatement();
                    stmt.executeUpdate(strDropTable);
                }
                catch(SQLException e)
                {
                    e.printStackTrace();
                }
            }
        }
        if(!upperid.equals("0") && !type.equals("title"))
        {
            String tempupperid = upperid;
            String tablename;
            Hashtable content;
            for(tablename = ""; !tempupperid.equals("0"); tablename = "tb_votediy" + content.get("vt_id").toString())
            {
                String sqlStr = "select * from tb_votediy where vt_id= " + tempupperid;
                content = dImpl_dptable.getDataInfo(sqlStr);
                tempupperid = content.get("vt_upperid").toString();
            }

            Vote vote = new Vote();
            vote.AlterTable(tablename, id, "", "del");
        }
        dImpl_dptable.closeStmt();
        dCn_dptable.closeCn();
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        String vote = "select * from tb_votediy where vt_upperid = " + id;
        Vector vPage = dImpl.splitPage(vote, 1000, 1);
        if(vPage != null)
        {
            for(int i = 0; i < vPage.size(); i++)
            {
                Hashtable content = (Hashtable)vPage.get(i);
                DelItem(content.get("vt_id").toString(), content.get("vt_upperid").toString(), content.get("vt_type").toString());
            }

        }
        dImpl.delete("tb_votediy", "vt_id", id);
        dImpl.closeStmt();
        dCn.closeCn();
        return "del success";
    }

    public Vector RetuenVectorVoteTitle()
    {
        return vectorVoteTitle;
    }

    public Hashtable putVal(String vt_id)
    {
        String sql = "select * from tb_votediy" + vt_id;
        String str = "0";
        String strVal = "";
        int sum = 0;
        int colNum = 0;
        ResultSetMetaData rsmd = null;
        ResultSet rs = null;
        Hashtable hVal = new Hashtable();
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        rs = dImpl.executeQuery(sql);
        try
        {
            rsmd = rs.getMetaData();
            colNum = rsmd.getColumnCount();
            for(int i = 1; i <= colNum; i++)
                hVal.put(rsmd.getColumnName(i).toLowerCase(), str);

            while(rs.next()) 
            {
                for(int j = 1; j <= colNum; j++)
                    if(rs.getObject(j) != null && !"".equals(rs.getObject(j).toString()))
                    {
                        str = (String)hVal.get(rsmd.getColumnName(j).toLowerCase());
                        hVal.remove(rsmd.getColumnName(j).toLowerCase());
                        sum = Integer.parseInt(str) + 1;
                        strVal = String.valueOf(sum);
                        hVal.put(rsmd.getColumnName(j).toLowerCase(), strVal);
                    }

            }
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        dImpl.closeStmt();
        dCn.closeCn();
        return hVal;
    }

    public Hashtable putVal(String vt_id, String vs_id)
    {
        String sql = "select * from tb_votediy" + vt_id + " where vs_id = " + vs_id;
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        Vector vectorPage = dImpl.splitPage(sql, 1000, 1);
        Hashtable hashVal = (Hashtable)vectorPage.get(0);
        dImpl.closeStmt();
        dCn.closeCn();
        return hashVal;
    }

    public String showManSay(String vt_id, String vs_id)
    {
        Hashtable hashVal = putVal(vt_id, vs_id);
        String strShowVoteFrontPage = "";
        String rec = "";
        if(vectorVoteTitle != null)
        {
            for(int i = 0; i < vectorVoteTitle.size(); i++)
            {
                VoteStruct votestruct = new VoteStruct();
                votestruct = (VoteStruct)vectorVoteTitle.get(i);
                strShowVoteFrontPage = strShowVoteFrontPage + "<tr align='left'><td>";
                for(int j = 0; j < votestruct.getLevel(); j++)
                    strShowVoteFrontPage = strShowVoteFrontPage + "&nbsp;";

                if(votestruct.getType().equals("title"))
                    strShowVoteFrontPage = strShowVoteFrontPage + votestruct.getName();
                if(votestruct.getType().equals("radio") || votestruct.getType().equals("checkbox"))
                {
                    rec = reChk(hashVal.get(votestruct.getDbname()).toString());
                    if(!"".equals(rec))
                        strShowVoteFrontPage = strShowVoteFrontPage + "<span style='background-color: #FFFF00'>" + votestruct.getName() + "</span>";
                    else
                        strShowVoteFrontPage = strShowVoteFrontPage + votestruct.getName();
                }
                if(votestruct.getType().equals("text") || votestruct.getType().equals("textarea"))
                {
                    String vt_parameter_1 = "";
                    String vt_parameter_2 = "";
                    String temp[] = votestruct.getParameter().split(",");
                    for(int n = 0; n < temp.length; n++)
                    {
                        if(n == 0)
                            vt_parameter_1 = temp[0];
                        if(n == 1)
                            vt_parameter_2 = temp[1];
                    }

                    if(votestruct.getType().equals("text"))
                        strShowVoteFrontPage = strShowVoteFrontPage + votestruct.getName() + "<input type='text' name='" + votestruct.getFrontpagename() + "' class='text-area' readOnly size='" + vt_parameter_1 + "' maxlength='" + vt_parameter_2 + "' value='" + hashVal.get(votestruct.getDbname()).toString() + "'>";
                    if(votestruct.getType().equals("textarea"))
                    {
                        strShowVoteFrontPage = strShowVoteFrontPage + votestruct.getName() + "<br>";
                        for(int j = 0; j < votestruct.getLevel(); j++)
                            strShowVoteFrontPage = strShowVoteFrontPage + "&nbsp;";

                        strShowVoteFrontPage = strShowVoteFrontPage + "<textarea name='" + votestruct.getFrontpagename() + "' class='text-area' readOnly cols='" + vt_parameter_1 + "' rows='" + vt_parameter_2 + "'>" + hashVal.get(votestruct.getDbname()).toString() + "</textarea>";
                    }
                }
                strShowVoteFrontPage = strShowVoteFrontPage + "</td></tr>";
            }

        }
        return strShowVoteFrontPage;
    }

    public String showTotal(String vt_id)
    {
        Hashtable vVal = putVal(vt_id);
        String strShowVoteFrontPage = "";
        double father = 0.0D;
        double mother = 0.0D;
        int son = 0;
        father = Double.parseDouble((String)vVal.get("vs_id"));
        if(vectorVoteTitle != null)
        {
            for(int i = 0; i < vectorVoteTitle.size(); i++)
            {
                VoteStruct votestruct = new VoteStruct();
                votestruct = (VoteStruct)vectorVoteTitle.get(i);
                if(votestruct.getType().equals("title"))
                    strShowVoteFrontPage = strShowVoteFrontPage + "<tr><td>" + votestruct.getName() + "</td></tr>";
                if(votestruct.getType().equals("radio") || votestruct.getType().equals("checkbox"))
                {
                    if(father != 0.0D)
                    {
                        mother = Double.parseDouble((String)vVal.get(votestruct.getDbname()));
                        if(mother != 0.0D)
                            son = (new Double((mother / father) * 100D)).intValue();
                        else
                            son = 0;
                    } else
                    {
                        son = 0;
                    }
                    strShowVoteFrontPage = strShowVoteFrontPage + "<tr class='line-odd'><td>&nbsp;&nbsp;" + votestruct.getName() + "&nbsp;&nbsp;(" + son + "%)&nbsp;&nbsp;<img src='/system/images/bar.gif' width='" + 0.29999999999999999D * (double)son + "' height='5'>&nbsp;&nbsp;" + (new Double(mother)).intValue() + "\u4EBA</td></tr>";
                }
            }

        }
        return strShowVoteFrontPage;
    }

    public Vector revtDetailTitle()
    {
        return vtDetailTitle;
    }

    public Hashtable rehashDetailTitle()
    {
        return hashDetailTitle;
    }

    public Hashtable rehashrdNoSum()
    {
        return hashrdNoSum;
    }

    public String detailManTitle(String vt_id, int endnum)
    {
        String strHtm = "";
        String id = "";
        String reType = "";
        boolean bool = false;
        int vti = 0;
        if(vectorVoteTitle != null)
        {
            strHtm = "  <tr class='bttn'>\n";
            for(int i = 0; i < vectorVoteTitle.size(); i++)
            {
                VoteStruct votestruct = new VoteStruct();
                votestruct = (VoteStruct)vectorVoteTitle.get(i);
                if(votestruct.getType().equals("title") || votestruct.getType().equals("text") || votestruct.getType().equals("textarea") || votestruct.getType().equals("checkbox"))
                {
                    if(votestruct.getType().equals("title"))
                    {
                        id = String.valueOf(votestruct.getId());
                        reType = chkNext(id);
                        if(!reType.equals("1"))
                            bool = true;
                    }
                    if(!bool)
                    {
                        strHtm = strHtm + "    <td class='outset-table'>" + resubString(votestruct.getName(), endnum) + "</td>\n";
                        vtDetailTitle.add(vti, votestruct);
                        vti++;
                    }
                }
                bool = false;
            }

            strHtm = strHtm + "    <td class='outset-table'>\u67E5\u770B</td>\n    <td class='outset-table'>\u5220\u9664</td>\n";
            strHtm = strHtm + "  </tr>\n";
        }
        return strHtm;
    }

    public Vector getvtTitle(String id)
    {
        String sql = "select vt_id,vt_dbname,vt_name from tb_votediy where vt_upperid = " + id;
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        Vector vPage = dImpl.splitPage(sql, 1000, 1);
        dImpl.closeStmt();
        dCn.closeCn();
        return vPage;
    }

    public String getTitleHtm(Vector vt, String upperid)
    {
        Hashtable hash = null;
        String reStr = "";
        String vt_id = "";
        if(vt != null)
        {
            for(int i = 0; i < vt.size(); i++)
            {
                hash = (Hashtable)vt.get(i);
                vt_id = hash.get("vt_id").toString();
                if(!vt_id.equals(upperid))
                    continue;
                reStr = hash.get("vt_name").toString();
                break;
            }

        } else
        {
            reStr = "";
        }
        return reStr;
    }

    public String chkNext(String id)
    {
        String reStr = "0";
        String sql = "select vt_type,vt_dbname,vt_name from tb_votediy where vt_upperid = " + id + " order by vt_id desc";
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        Vector vPage = dImpl.splitPage(sql, 1000, 1);
        if(vPage != null)
        {
            for(int i = 0; i < vPage.size(); i++)
            {
                Hashtable hashVal = (Hashtable)vPage.get(i);
                if(hashVal.get("vt_type").toString().equals("radio"))
                    reStr = "1";
                if(hashVal.get("vt_type").toString().equals("checkbox"))
                    reStr = "2";
                if(hashVal.get("vt_type").toString().equals("title"))
                    reStr = "3";
            }

        }
        if("1".equals(reStr) || "2".equals(reStr))
            hashDetailTitle.put(id, vPage);
        dImpl.closeStmt();
        dCn.closeCn();
        return reStr;
    }

    public String reDetailMainSe(String vt_id, int endnum, String vt_sort, String tr_code)
    {
        String reHtm = "";
        String id = "";
        Hashtable content = null;
        Vector vtHash = null;
        Hashtable hashvPage = null;
        String vtDbName = "";
        String vtName = "";
        String diyField = "";
        String getType = "";
        String boolName = "";
        String typeNext = "";
        String sql = "select a.* from tb_votediy" + vt_id + " a,tb_remip b where a.vs_id = b.vs_id " + "and b.tr_code = '" + tr_code + "' order by a.vs_id desc";
        String cls = "";
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        Vector vPage = dImpl.splitPage(sql, 10000, 1);
        dImpl.closeStmt();
        dCn.closeCn();
        if(vPage != null)
        {
            for(int i = 0; i < vPage.size(); i++)
            {
                cls = i % 2 != 0 ? "class='line-odd'" : " class='line-even'";
                reHtm = reHtm + "  <tr " + cls + ">\n";
                content = (Hashtable)vPage.get(i);
                if(vtDetailTitle != null)
                {
                    for(int j = 0; j < vtDetailTitle.size(); j++)
                    {
                        VoteStruct votestruct = new VoteStruct();
                        votestruct = (VoteStruct)vtDetailTitle.get(j);
                        getType = votestruct.getType();
                        id = String.valueOf(votestruct.getId());
                        vtHash = (Vector)hashDetailTitle.get(id);
                        if(getType.equals("title"))
                        {
                            if(vtHash != null)
                            {
                                for(int k = 0; k < vtHash.size(); k++)
                                {
                                    hashvPage = (Hashtable)vtHash.get(k);
                                    vtDbName = hashvPage.get("vt_dbname").toString();
                                    vtName = hashvPage.get("vt_name").toString();
                                    typeNext = hashvPage.get("vt_type").toString();
                                    diyField = content.get(vtDbName).toString();
                                    if(!"".equals(diyField))
                                        boolName = vtName;
                                }

                            }
                            boolName = reNum(boolName);
                            if("".equals(boolName))
                                reHtm = reHtm + "    <td>&nbsp;</td>\n";
                            else
                                reHtm = reHtm + "    <td>" + resubString(boolName, endnum) + "</td>\n";
                            boolName = "";
                        } else
                        {
                            vtDbName = votestruct.getDbname().toString();
                            vtName = content.get(vtDbName).toString();
                            if("".equals(vtName))
                                vtName = "&nbsp";
                            else
                            if("1".equals(vtName))
                                vtName = "\u221A";
                            reHtm = reHtm + "    <td>" + resubString(vtName, endnum) + "</td>\n";
                        }
                    }

                }
                reHtm = reHtm + "    <td><a href='votestat.jsp?id=" + vt_id + "&vote_num=" + content.get("vs_id").toString() + "'><img class='hand' border='0' src='../../../images/modi.gif' title='\u67E5\u770B' WIDTH='16' HEIGHT='16'></a></td>\n";
                reHtm = reHtm + "    <td><a href='voteDel.jsp?id=" + vt_id + "&vote_num=" + content.get("vs_id").toString() + "&tr_code=" + tr_code + "&vt_sort=" + vt_sort + "'><img class='hand' border='0' src='../../../images/delete.gif' title='\u5220\u9664' WIDTH='16' HEIGHT='16'></a></td>\n";
                reHtm = reHtm + "  </tr>\n";
            }

        }
        return reHtm;
    }

    public String totalManTitle(String vt_id, int endnum)
    {
        String strHtm = "";
        String id = "";
        String reType = "";
        boolean bool = false;
        int vti = 0;
        if(vectorVoteTitle != null)
        {
            strHtm = "  <tr class='bttn'>\n    <td class='outset-table'>\u6709\u6548\u95EE\u5377\uFF08\u4EFD\uFF09</td>\n    <td class='outset-table'>\u90E8\u95E8</td>\n";
            for(int i = 0; i < vectorVoteTitle.size(); i++)
            {
                VoteStruct votestruct = new VoteStruct();
                votestruct = (VoteStruct)vectorVoteTitle.get(i);
                if(votestruct.getType().equals("title") || votestruct.getType().equals("text") || votestruct.getType().equals("textarea") || votestruct.getType().equals("checkbox"))
                {
                    if(votestruct.getType().equals("title"))
                    {
                        id = String.valueOf(votestruct.getId());
                        reType = chkNext(id);
                        if(!reType.equals("1"))
                            bool = true;
                    }
                    if(!bool)
                    {
                        strHtm = strHtm + "    <td class='outset-table'>" + resubString(votestruct.getName(), endnum) + "</td>\n";
                        vtDetailTitle.add(vti, votestruct);
                        vti++;
                    }
                }
                bool = false;
            }

            strHtm = strHtm + "    <td class='outset-table'>\u67E5\u770B</td>\n";
            strHtm = strHtm + "  </tr>\n";
        }
        return strHtm;
    }

    public String reTotalDept_Date(String vt_id, String vt_sort)
    {
        String reHtm = "";
        String dd_code = "";
        String dd_name = "";
        String vtDbName = "";
        String upId = "";
        String strVal = "";
        String totalSum = "";
        String sixNum = "";
        String cls = "";
        String vtType = "";
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        String sqlStr = "select dd_id,dd_code,dd_name from tb_datatdictionary where dd_parentid = (select dd_id from tb_datatdictionary where dd_code = '" + vt_sort + "') order by dd_sequence";
        Vector vPage = dImpl.splitPage(sqlStr, 1000, 1);
        Hashtable content = null;
        Hashtable hVal = new Hashtable();
        Hashtable hCon = new Hashtable();
        Hashtable hNoSum = new Hashtable();
        Vector vChk = null;
        if(vPage != null)
        {
            for(int i = 0; i < vPage.size(); i++)
            {
                content = (Hashtable)vPage.get(i);
                dd_code = content.get("dd_code").toString();
                hVal.put(dd_code, reTotalMain(vt_id, dd_code));
            }

            for(int i = 0; i < vPage.size(); i++)
            {
                cls = i % 2 != 0 ? "class='line-odd'" : " class='line-even'";
                content = (Hashtable)vPage.get(i);
                dd_code = content.get("dd_code").toString();
                dd_name = content.get("dd_name").toString();
                hNoSum = (Hashtable)hashrdNoSum.get(dd_code);
                hCon = (Hashtable)hVal.get(dd_code);
                totalSum = hCon.get("totalSum").toString();
                reHtm = reHtm + "  <tr" + cls + ">\n    <td>" + totalSum + "</td>\n    <td>" + dd_name + "</td>\n";
                if(vtDetailTitle != null)
                {
                    for(int k = 0; k < vtDetailTitle.size(); k++)
                    {
                        VoteStruct votestruct = new VoteStruct();
                        votestruct = (VoteStruct)vtDetailTitle.get(k);
                        vtDbName = votestruct.getDbname();
                        upId = String.valueOf(votestruct.getId());
                        strVal = hCon.get(vtDbName).toString();
                        vtType = votestruct.getType();
                        if(vtType.equals("title"))
                        {
                            vChk = (Vector)hashDetailTitle.get(upId);
                            if(vChk != null)
                            {
                                sixNum = hNoSum.get(vtDbName) == null ? "0" : hNoSum.get(vtDbName).toString();
                                strVal = reAvg(totalSum, sixNum, strVal);
                            }
                        }
                        reHtm = reHtm + "    <td>" + strVal + "</td>\n";
                    }

                }
                reHtm = reHtm + "    <td><a href='manList.jsp?id=" + vt_id + "&vt_sort=" + vt_sort + "&cSort=" + dd_code + "&dd_name=" + dd_name + "'>\u67E5\u770B</td>\n  </tr>\n";
            }

        }
        dImpl.closeStmt();
        dCn.closeCn();
        return reHtm;
    }

    public String reAvg(String totalSum, String sixNum, String divisor)
    {
        int totNum = Integer.parseInt(totalSum);
        int sNum = Integer.parseInt(sixNum);
        String dividend = String.valueOf(totNum - sNum);
        double dvor = Double.parseDouble(divisor);
        double dvnd = Double.parseDouble(dividend);
        double avg = 0.0D;
        avg = dvor / dvnd;
        String reStr = String.valueOf(avg);
        String div1 = "0";
        String div2 = "0";
        for(int i = 0; i < reStr.length(); i++)
            if(reStr.substring(i, i + 1).equals("."))
            {
                div1 = reStr.substring(0, i);
                div2 = reStr.substring(i + 1, reStr.length());
            }

        String str = div2.length() <= 1 ? div2 : div2.substring(0, 1);
        reStr = div1 + "." + str;
        return reStr;
    }

    public String reTotalDept(String vt_id, String vt_sort)
    {
        String reHtm = "";
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        String sqlStr = "select dd_id,dd_code,dd_name from tb_datatdictionary where dd_parentid = (select dd_id from tb_datatdictionary where dd_code = '" + vt_sort + "') order by dd_sequence";
        String dd_code = "";
        String dd_name = "";
        String vtDbName = "";
        String strVal = "";
        ResultSet rs = dImpl.executeQuery(sqlStr);
        Hashtable reHash = new Hashtable();
        Hashtable content = new Hashtable();
        try
        {
            while(rs.next()) 
            {
                dd_code = rs.getString("dd_code").toString();
                dd_name = rs.getString("dd_name").toString();
                reHash.put(dd_code, reTotalMain(vt_id, dd_code));
                reHtm = reHtm + "  <tr>\n    <td>" + dd_name + "</td>\n";
                content = (Hashtable)reHash.get(dd_code);
                for(int i = 0; i < vtDetailTitle.size(); i++)
                {
                    VoteStruct votestruct = new VoteStruct();
                    votestruct = (VoteStruct)vtDetailTitle.get(i);
                    vtDbName = votestruct.getDbname();
                    strVal = content.get(vtDbName).toString();
                    reHtm = reHtm + "    <td>" + strVal + "</td>\n";
                }

                reHtm = reHtm + "  </tr>\n";
            }
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        dImpl.closeStmt();
        dCn.closeCn();
        return reHtm;
    }

    private Hashtable reTotalMain(String vt_id, String dd_code)
    {
        String id = "";
        Hashtable content = null;
        Vector vtHash = null;
        Hashtable hashvPage = null;
        String vtDbName = "";
        String vtName = "";
        String diyField = "";
        String vt_name = "";
        String getType = "";
        String typeNext = "";
        Hashtable hNoSum = new Hashtable();
        Hashtable hVal = new Hashtable();
        String reVal = "";
        String str = "";
        int rdVal = 0;
        String sql = "select c.dd_name,c.dd_code,a.* from tb_votediy" + vt_id + " a,tb_remip b,tb_datatdictionary c w" + "here a.vs_id = b.vs_id and b.dd_id = c.dd_id and b.vt_id = " + vt_id + " and b.tr_code = '" + dd_code + "'";
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        Vector vPage = dImpl.splitPage(sql, 0x186a0, 1);
        dImpl.closeStmt();
        dCn.closeCn();
        if(vtDetailTitle != null)
        {
            for(int j = 0; j < vtDetailTitle.size(); j++)
            {
                VoteStruct votestruct = new VoteStruct();
                votestruct = (VoteStruct)vtDetailTitle.get(j);
                getType = votestruct.getType();
                vtName = votestruct.getDbname();
                id = String.valueOf(votestruct.getId());
                vtHash = (Vector)hashDetailTitle.get(id);
                if(vtHash != null)
                {
                    if(vPage != null)
                    {
                        for(int i = 0; i < vPage.size(); i++)
                        {
                            content = (Hashtable)vPage.get(i);
                            for(int k = 0; k < vtHash.size(); k++)
                            {
                                hashvPage = (Hashtable)vtHash.get(k);
                                vtDbName = hashvPage.get("vt_dbname").toString();
                                vt_name = hashvPage.get("vt_name").toString();
                                typeNext = hashvPage.get("vt_type").toString();
                                diyField = content.get(vtDbName).toString();
                                if(!"".equals(diyField))
                                {
                                    rdVal = Integer.parseInt(reNum(vt_name));
                                    if(rdVal == 6)
                                    {
                                        reVal = hNoSum.get(vtName) == null ? "" : hNoSum.get(vtName).toString();
                                        if("".equals(reVal))
                                            reVal = "0";
                                        str = String.valueOf(Integer.parseInt(reVal) + 1);
                                        hNoSum.remove(vtName);
                                        hNoSum.put(vtName, str);
                                        rdVal = 0;
                                    } else
                                    {
                                        reVal = hVal.get(vtName) == null ? "" : hVal.get(vtName).toString();
                                        if("".equals(reVal))
                                            reVal = "0";
                                        str = String.valueOf(Integer.parseInt(reVal) + rdVal);
                                        hVal.remove(vtName);
                                        hVal.put(vtName, str);
                                    }
                                } else
                                {
                                    reVal = hVal.get(vtName) == null ? "0" : hVal.get(vtName).toString();
                                    hVal.put(vtName, reVal);
                                }
                            }

                        }

                    } else
                    {
                        hVal.put(vtName, "0");
                    }
                } else
                if(vPage != null)
                {
                    for(int i = 0; i < vPage.size(); i++)
                    {
                        content = (Hashtable)vPage.get(i);
                        diyField = content.get(vtName).toString();
                        if(!"".equals(diyField))
                        {
                            reVal = hVal.get(vtName) == null ? "" : hVal.get(vtName).toString();
                            if("".equals(reVal))
                                reVal = "0";
                            str = String.valueOf(Integer.parseInt(reVal) + 1);
                            hVal.remove(vtName);
                            hVal.put(vtName, str);
                        } else
                        {
                            reVal = hVal.get(vtName) == null ? "0" : hVal.get(vtName).toString();
                            hVal.put(vtName, reVal);
                        }
                    }

                } else
                {
                    hVal.put(vtName, "0");
                }
            }

        }
        int totalSum = 0;
        totalSum = vPage == null ? 0 : vPage.size();
        hVal.put("totalSum", String.valueOf(totalSum));
        hashrdNoSum.put(dd_code, hNoSum);
        return hVal;
    }

    public String reDetailMain(String vt_id, int endnum)
    {
        String reHtm = "";
        String id = "";
        Hashtable content = null;
        Vector vtHash = null;
        Hashtable hashvPage = null;
        String vtDbName = "";
        String vtName = "";
        String diyField = "";
        String getType = "";
        String boolName = "";
        String typeNext = "";
        String sql = "select * from tb_votediy" + vt_id + " order by vs_id desc";
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        Vector vPage = dImpl.splitPage(sql, 10000, 1);
        dImpl.closeStmt();
        dCn.closeCn();
        if(vPage != null)
        {
            for(int i = 0; i < vPage.size(); i++)
            {
                reHtm = reHtm + "  <tr>\n";
                content = (Hashtable)vPage.get(i);
                for(int j = 0; j < vtDetailTitle.size(); j++)
                {
                    VoteStruct votestruct = new VoteStruct();
                    votestruct = (VoteStruct)vtDetailTitle.get(j);
                    getType = votestruct.getType();
                    id = String.valueOf(votestruct.getId());
                    vtHash = (Vector)hashDetailTitle.get(id);
                    if(getType.equals("title"))
                    {
                        if(vtHash != null)
                        {
                            for(int k = 0; k < vtHash.size(); k++)
                            {
                                hashvPage = (Hashtable)vtHash.get(k);
                                vtDbName = hashvPage.get("vt_dbname").toString();
                                vtName = hashvPage.get("vt_name").toString();
                                typeNext = hashvPage.get("vt_type").toString();
                                diyField = content.get(vtDbName).toString();
                                if(!"".equals(diyField))
                                    if(typeNext.equals("checkbox"))
                                        boolName = vtName + "," + boolName;
                                    else
                                        boolName = vtName;
                            }

                        }
                        if("".equals(boolName))
                            reHtm = reHtm + "    <td>&nbsp;</td>\n";
                        else
                            reHtm = reHtm + "    <td>" + resubString(boolName, endnum) + "</td>\n";
                        boolName = "";
                    } else
                    {
                        vtDbName = votestruct.getDbname().toString();
                        vtName = content.get(vtDbName).toString();
                        reHtm = reHtm + "    <td>" + resubString(vtName, endnum) + "</td>\n";
                    }
                }

                reHtm = reHtm + "    <td><a href='votestat.jsp?id=" + vt_id + "&vote_num=" + content.get("vs_id").toString() + "'><img class='hand' border='0' src='../../../images/modi.gif' title='\u67E5\u770B' WIDTH='16' HEIGHT='16'></a></td>\n";
                reHtm = reHtm + "    <td><a href='voteDel.jsp?vote_num=" + content.get("vs_id").toString() + "'><img class='hand' border='0' src='../../../images/delete.gif' title='\u5220\u9664' WIDTH='16' HEIGHT='16'></a></td>\n";
                reHtm = reHtm + "  </tr>\n";
            }

        }
        return reHtm;
    }

    public String showStyleAcross(int num)
    {
        String strShowVoteFrontPage = "";
        int x = 0;
        if(vectorVoteTitle != null)
        {
            for(int i = 0; i < vectorVoteTitle.size(); i++)
            {
                VoteStruct votestruct = new VoteStruct();
                votestruct = (VoteStruct)vectorVoteTitle.get(i);
                if(!votestruct.getType().equals("radio") && !votestruct.getType().equals("checkbox"))
                {
                    if(x != 0)
                        strShowVoteFrontPage = strShowVoteFrontPage + "    </td>\n  </tr>\n<tr height='" + num + "'><td></td></tr>\n";
                    strShowVoteFrontPage = strShowVoteFrontPage + "  <tr>\n    <td>";
                    x = 0;
                } else
                if(x == 0)
                {
                    strShowVoteFrontPage = strShowVoteFrontPage + "  <tr>\n    <td>\n";
                    x++;
                }
                for(int j = 0; j < votestruct.getLevel(); j++)
                    strShowVoteFrontPage = strShowVoteFrontPage + "&nbsp;";

                if(votestruct.getType().equals("title"))
                    strShowVoteFrontPage = strShowVoteFrontPage + votestruct.getName();
                if(votestruct.getType().equals("radio"))
                    strShowVoteFrontPage = strShowVoteFrontPage + "<input type='radio' name='" + votestruct.getFrontpagename() + "' value='" + votestruct.getDbname() + "'>" + votestruct.getName() + "\n";
                if(votestruct.getType().equals("checkbox"))
                    strShowVoteFrontPage = strShowVoteFrontPage + "<input type='checkbox' name='" + votestruct.getFrontpagename() + "' value='" + votestruct.getDbname() + "'>" + votestruct.getName() + "\n";
                if(votestruct.getType().equals("text") || votestruct.getType().equals("textarea"))
                {
                    String vt_parameter_1 = "";
                    String vt_parameter_2 = "";
                    String temp[] = votestruct.getParameter().split(",");
                    for(int n = 0; n < temp.length; n++)
                    {
                        if(n == 0)
                            vt_parameter_1 = temp[0];
                        if(n == 1)
                            vt_parameter_2 = temp[1];
                    }

                    if(votestruct.getType().equals("text"))
                        strShowVoteFrontPage = strShowVoteFrontPage + votestruct.getName() + "<input type='text' name='" + votestruct.getFrontpagename() + "' class='text-area' size='" + vt_parameter_1 + "' maxlength='" + vt_parameter_2 + "'>";
                    if(votestruct.getType().equals("textarea"))
                    {
                        strShowVoteFrontPage = strShowVoteFrontPage + votestruct.getName() + "<br>";
                        for(int j = 0; j < votestruct.getLevel(); j++)
                            strShowVoteFrontPage = strShowVoteFrontPage + "&nbsp;";

                        strShowVoteFrontPage = strShowVoteFrontPage + "<textarea name='" + votestruct.getFrontpagename() + "' class='text-area' cols='" + vt_parameter_1 + "' rows='" + vt_parameter_2 + "'></textarea>";
                    }
                }
                if(!votestruct.getType().equals("radio") && !votestruct.getType().equals("checkbox"))
                    strShowVoteFrontPage = strShowVoteFrontPage + "</td>\n  </tr>\n";
                if(votestruct.getType().equals("text") || votestruct.getType().equals("textarea"))
                    strShowVoteFrontPage = strShowVoteFrontPage + "<tr height='" + num + "'><td></td></tr>\n";
            }

        }
        return strShowVoteFrontPage;
    }

    public String reChk(String str)
    {
        if("".equals(str))
            return "";
        else
            return "checked";
    }

    public String resubString(String str, int i)
    {
        String reStr = "";
        reStr = str.length() <= i + 1 ? str : str.substring(0, i) + "..";
        return reStr;
    }

    public String reNum(String str)
    {
        String agree = "\u6EE1\u610F";
        String agreer = "\u6BD4\u8F83\u6EE1\u610F";
        String generl = "\u4E00\u822C";
        String noagree = "\u4E0D\u6EE1\u610F";
        String sonoagree = "\u5F88\u4E0D\u6EE1\u610F";
        String unknow = "\u4E0D\u4E86\u89E3";
        if(str.equals(agree))
            return "1";
        if(str.equals(agreer))
            return "2";
        if(str.equals(generl))
            return "3";
        if(str.equals(noagree))
            return "4";
        if(str.equals(sonoagree))
            return "5";
        if(str.equals(unknow))
            return "6";
        if(str.equals(""))
            return "";
        else
            return str;
    }

    public String getVtName(String id)
    {
        String reVtname = "";
        String vt_desc = "";
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        String sqlStr = "select vt_name,vt_desc from tb_votediy where vt_id = " + id;
        Hashtable hashVal = dImpl.getDataInfo(sqlStr);
        if(hashVal != null)
        {
            reVtname = hashVal.get("vt_name").toString();
            vt_desc = hashVal.get("vt_desc").toString();
            this.vt_desc = vt_desc;
        } else
        {
            reVtname = "";
        }
        dImpl.closeStmt();
        dCn.closeCn();
        return reVtname;
    }

    public String getVt_desc()
    {
        return vt_desc;
    }

    public String getDeptOpt(String id, String vt_sort, String cSort)
    {
        String reHtm = "<script>\n\tfunction doChange(obj) {\n\t\tlocation.href = 'detailList.jsp?id=" + id + "&vt_sort=" + vt_sort + "&cSort='+obj.options[obj.selectedIndex].value;\n\t}\n</script>\n";
        reHtm = reHtm + "<select name='dept_sel' class='text-line' onChange='doChange(this);'>\n";
        String dd_code = "";
        String dd_name = "";
        String selected = "";
        Hashtable content = null;
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        String sqlStr = "select dd_id,dd_name,dd_code from tb_datatdictionary where dd_parentid = (select dd_id from tb_datatdictionary where dd_code = '" + vt_sort + "') order by dd_id";
        Vector vPage = dImpl.splitPage(sqlStr, 1000, 1);
        if(vPage != null)
        {
            for(int i = 0; i < vPage.size(); i++)
            {
                content = (Hashtable)vPage.get(i);
                dd_code = content.get("dd_code").toString();
                dd_name = content.get("dd_name").toString();
                if("".equals(cSort))
                {
                    cSort = dd_code;
                    this.cSort = cSort;
                }
                selected = dd_code.equals(cSort) ? "selected" : "";
                reHtm = reHtm + "  <option value='" + dd_code + "' " + selected + ">" + dd_name + "</option>\n";
            }

        } else
        {
            return "";
        }
        reHtm = reHtm + "</select>";
        dImpl.closeStmt();
        dCn.closeCn();
        return reHtm;
    }

    public String getSort()
    {
        return cSort;
    }

    public boolean chkIp(String ip, String cSort)
    {
        boolean rebool = false;
        CDataCn dCn = new CDataCn();
        CDataImpl dImpl = new CDataImpl(dCn);
        String sql = "select tr_id from tb_remip where tr_ip = '" + ip + "' and tr_code = '" + cSort + "'";
        Hashtable hashVal = dImpl.getDataInfo(sql);
        if(hashVal != null)
            rebool = true;
        else
            rebool = false;
        dImpl.closeStmt();
        dCn.closeCn();
        return rebool;
    }
}