package com.timer.util;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

public class WriteFile {
	public static void write(StringBuffer content, String savepath,
			String filename) {
		File file = new File(savepath);
		if (!file.exists()) {
			file.mkdirs();
		}
		file = new File(savepath + filename);

		try {
			try {
				file.createNewFile();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			PrintWriter pr = new PrintWriter(new BufferedOutputStream(
					new FileOutputStream(file)));
			pr.write(content.toString());
			pr.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}

	public static void main(String[] args) {
		StringBuffer sb = new StringBuffer("test");
		WriteFile.write(sb, "d:\\test\\", "test.html");
	}
}
