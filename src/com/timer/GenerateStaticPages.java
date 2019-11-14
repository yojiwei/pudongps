package com.timer;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.TimerTask;
import java.util.Map.Entry;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.timer.confige.ConfigeLoaderFactory;
import com.timer.confige.IConfigeLoader;
import com.timer.util.LoadPage;
import com.timer.util.WriteFile;

/**
 * 将动态的jsp、asp、aspx、php等网页抓取下来，生成静态的html页面 以降低服务器的负载，加快常用页面的访问速度。
 * 
 * @author wanghk
 * 
 */
public class GenerateStaticPages extends TimerTask {
	// private Log log = LogFactory.getLog(GenerateStaticPages.class);

	private static TimerTask instance = null;

	private Map config = null;

	private String[] urlToParse = null;

	private static Map lastLoadedCode = new HashMap();

	private GenerateStaticPages() {
		init();
	}

	/**
	 * 采用singleTon模式，构造一个GenerateStaticPages的实例
	 * 
	 * @return
	 */
	public static synchronized TimerTask getInstance() {
		if (instance == null) {
			instance = new GenerateStaticPages();
		}
		return instance;
	}

	private void init() {
		IConfigeLoader configeloader = new ConfigeLoaderFactory()
				.getConfigeLoader(ConfigeLoaderFactory.LOADFROMDATABASE);
		config = configeloader.getConfig();
		Iterator iter = config.entrySet().iterator();
		urlToParse = new String[config.entrySet().size()];
		int i = 0;
		while (iter.hasNext()) {
			Entry entry = (Entry) iter.next();
			urlToParse[i++] = (String) entry.getKey();
		}
	}

	/**
	 * 抓取页面内容并生成静态页面
	 */
	public void run() {
		// TODO Auto-generated method stub
		try {
			LoadPage loader = new LoadPage();
			for (int i = 0; i < urlToParse.length; i++) {
				String url = urlToParse[i];
				System.out.println(url);
				Map map = (Map) config.get(urlToParse[i]);
				String filename = (String) map.get("filename");
				String savepath = (String) map.get("savepath");
				// 抓取指定url的页面HTML代码
				StringBuffer pageContent = loader.load(url);
				// 取得该url的上一次HTML代码
				StringBuffer lastContent = (StringBuffer) lastLoadedCode
						.get(url);
				// 比较前后的html代码，如果有不同之处，则重新生成html页面
				if (lastLoadedCode != null || !lastContent.equals(pageContent)) {
					lastLoadedCode.put(url, pageContent);
					WriteFile.write(pageContent, savepath, filename);
				}
			}
		} catch (Exception ex) {
			// log.info(ex.getMessage());
			ex.printStackTrace();
		}
	}

	public static void main(String[] args) {
		TimerTask gp = GenerateStaticPages.getInstance();
		gp.run();
	}
}
