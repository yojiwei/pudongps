package com.timer.confige;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.MapListHandler;

import com.component.database.CDataCn;

public class SQLConfigeLoader implements IConfigeLoader {
	private static IConfigeLoader instance = null;

	private Map config = null;

	public static void main(String [] args){
		IConfigeLoader loader = SQLConfigeLoader.getInstance();
	}
	
	private void load() {
		String sql = "select SJ_ID, TS_URL, TS_FILENAME, TS_PATH from TB_SUBJECTSTATIC ";
		CDataCn dcn = null;
		config = new HashMap();
		try {
			dcn = new CDataCn();
			QueryRunner qr = new QueryRunner();
			MapListHandler handler = new MapListHandler();
			List list = (List)(qr.query(dcn.getConnection(), sql, null, handler));
			if (list!=null && list.size()>0){
				Map map = null;
				for (int i=0;i<list.size();i++){
					map = (Map)list.get(i);
					Map newmap = new HashMap();
					String url = String.valueOf(map.get("ts_url"));
					newmap.put("url", map.get("ts_url"));
					newmap.put("filename", map.get("ts_filename"));
					newmap.put("savepath", map.get("ts_path"));
					config.put(url, newmap);
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (dcn != null) {
				dcn.closeCn();
			}
		}
	}

	private SQLConfigeLoader() {
		load();
	}

	public static synchronized IConfigeLoader getInstance() {
		if (instance == null) {
			instance = new SQLConfigeLoader();
		}
		return instance;
	}

	public void reset() {
		// TODO Auto-generated method stub
		config = null;
	}

	public synchronized Map getConfig() {
		// TODO Auto-generated method stub
		if (config == null) {
			load();
		}
		return config;
	}

}
