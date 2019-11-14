package com.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.w3c.dom.Node;
import org.w3c.dom.xpath.XPathResult;

import com.PermuteData.Permunte;
import com.util.CTools;
/**
 * 
 * @author Administrator
 *
 */
public class HBJServlet extends HttpServlet {
	/**
	 * 
	 */
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		org.w3c.dom.Document doc = XMLUtil.inputStream2Doc(req.getInputStream());
        if(doc != null)
            try
            {
                XPathResult result = XMLUtil.parseConfig(doc, "//办事信息");
                XPathResult res = XMLUtil.parseConfig(doc, "//回复意见");
                Node node = result.iterateNext();
                String wo_id = CTools.dealNull(node.getAttributes().getNamedItem("办事ID").getNodeValue()).trim();
                String wo_name = CTools.dealNull(node.getAttributes().getNamedItem("办事事项名称").getNodeValue()).trim();
                String wo_status = CTools.dealNull(node.getAttributes().getNamedItem("状态").getNodeValue()).trim();
                String wo_usuid = CTools.dealNull(node.getAttributes().getNamedItem("用户UID").getNodeValue()).trim();
                Node nores = res.iterateNext();
                String huifu = CTools.dealNull(nores.getFirstChild().getNodeValue()).trim();
                Permunte perm = new Permunte();
                if(wo_status.equals("1"))
                    wo_status = "0";
                perm.setHbjStatus(wo_id,wo_name, huifu, wo_status,wo_usuid);
                System.out.println("环保局办事——接收政务网数据！" + wo_id);
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
        else
            System.out.println("接收非XML");
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.doGet(req, resp);
	}
	
	public void destroy() {
		// TODO Auto-generated method stub
		super.destroy();
	}
	
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		super.init();
	}
}
