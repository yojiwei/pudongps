package com.website;

import com.util.CDate;
import java.io.PrintStream;
import java.util.TimerTask;

public class HTMLClient extends TimerTask{
	
	public HTMLClient()
    {
    }

    public void run()
    {
        stratXml();
    }

    public void stratXml()
    {
        CDate d = new CDate();
        System.out.println(d.getNowTime() + "--------------------\u81EA\u52A8\u751F\u6210\u9759\u6001\u9875\u9762-----------");
        NewHtmlCreate.VectHtml();
        System.out.println(d.getNowTime() + "--------------------\u81EA\u52A8\u751F\u6210\u9759\u6001\u9875\u9762-----------");
    }
}
