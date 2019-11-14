package com.timer.confige;

public class ConfigeLoaderFactory {
	public static final int LOADFROMXMLFILE = 1;

	public static final int LOADFROMDATABASE = 2;

	public IConfigeLoader getConfigeLoader(int type) {
		switch (type) {
		case LOADFROMXMLFILE:
			return XMLConfigeLoader.getInstance();
		case LOADFROMDATABASE:
			return SQLConfigeLoader.getInstance();
		}
		return null;
	}
}
