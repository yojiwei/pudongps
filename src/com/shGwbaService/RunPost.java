package com.shGwbaService;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import org.apache.commons.io.FileUtils;
import com.alibaba.fastjson.JSONObject;

public class RunPost {
	public static void main(String[] args) {
		Map<String, Object> map = new HashMap<String, Object>();

		String ret = "";

		try {
			HashMap<String, Object> record = new HashMap();
			record.put("rowguid", UUID.randomUUID().toString());
			record.put("doctitle", UUID.randomUUID().toString() + "测试信息");
			record.put("filenumber1", "测试");
			record.put("filenumber2", "2018");
			record.put("filenumber3", "111");
			record.put("archdate", "2018-10-01");
			record.put("pubdate", "2018-10-01");
			record.put("openurl", "http://www.shanghai.gov.cn");
			record.put("content", "1234");
			record.put("opentype", "001");
			record.put("syid", UUID.randomUUID().toString() + "_syid");

			List<HashMap> attachFiles = new ArrayList<HashMap>();
			File file1 = new File("C:\\Users\\Administrator\\Downloads\\微信图片_20190918085734.jpg");
			HashMap att1 = new HashMap();
			att1.put("attcontent", FileUtils.readFileToByteArray(file1));
			att1.put("attfilename", file1.getName());
//			attachFiles.add(att1);
			record.put("attachfiles", attachFiles);
			map.put("params", JSONObject.toJSONString(record));
			
			//ret = post("http://58.210.84.242:8510/EpointSHzwdt/rest/archivebaserestaction/addoreditarchive_web", map);
			System.out.println(ret);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static String post(String actionUrl, Map<String, Object> param) {
		String seamStr = "";
		HttpURLConnection conn = null;
		DataOutputStream outStream = null;
		try {
			String BOUNDARY = java.util.UUID.randomUUID().toString();
			String PREFIX = "--", LINEND = "\r\n";
			String MULTIPART_FROM_DATA = "multipart/form-data";
			String CHARSET = "UTF-8";

			URL uri = new URL(actionUrl);
			conn = (HttpURLConnection) uri.openConnection();
			// 缓存的最长时间
			conn.setReadTimeout(30 * 1000);
			// 允许输入
			conn.setDoInput(true);
			// 允许输出
			conn.setDoOutput(true);
			// 不允许使用缓存
			conn.setUseCaches(false);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("connection", "keep-alive");
			conn.setRequestProperty("Charsert", "UTF-8");
			conn.setRequestProperty("Content-Type", MULTIPART_FROM_DATA + ";boundary=" + BOUNDARY);
			

			outStream = new DataOutputStream(conn.getOutputStream());
			if (param != null) {
				// 首先组拼文本类型的参数
				StringBuilder sb = new StringBuilder();
				Map<String, File> files = new HashMap<String, File>();
				for (Map.Entry<String, Object> entry : param.entrySet()) {
					if (entry.getValue() != null && entry.getValue() instanceof File) {
						files.put(entry.getKey(), (File) entry.getValue());
					} else {
						sb.append(PREFIX);
						sb.append(BOUNDARY);
						sb.append(LINEND);
						sb.append("Content-Disposition: form-data; name=\"" + entry.getKey() + "\"" + LINEND);
						sb.append("Content-Type: text/plain; charset=" + CHARSET + LINEND);
						sb.append("Content-Transfer-Encoding: 8bit" + LINEND);
						sb.append(LINEND);
						sb.append(entry.getValue());
						sb.append(LINEND);
					}
				}
				outStream.write(sb.toString().getBytes("UTF-8"));
				// 发送文件数据
				for (Map.Entry<String, File> file : files.entrySet()) {
					StringBuilder sb1 = new StringBuilder();
					sb1.append(PREFIX);
					sb1.append(BOUNDARY);
					sb1.append(LINEND);
					sb1.append("Content-Disposition: form-data; name=\"file\"; filename=\""
							+ URLEncoder.encode(file.getKey(), "utf-8") + "\"" + LINEND);
					sb1.append("Content-Type: application/octet-stream; charset=" + CHARSET + LINEND);
					sb1.append(LINEND);
					outStream.write(sb1.toString().getBytes());
					InputStream is = new FileInputStream(file.getValue());

					byte[] buffer = new byte[1024];
					int len = 0;
					while ((len = is.read(buffer)) != -1) {
						outStream.write(buffer, 0, len);
					}
					is.close();
					outStream.write(LINEND.getBytes());
				}
			}
			// 请求结束标志
			byte[] end_data = (PREFIX + BOUNDARY + PREFIX + LINEND).getBytes();
			outStream.write(end_data);
			outStream.flush();

			// 从服务器读取响应
			String encoding = conn.getContentEncoding();
			// 得到响应码
			if (conn.getResponseCode() == HttpURLConnection.HTTP_OK) {
				InputStream in = conn.getInputStream();
				byte[] b = getContentFromInputStream(in);
				if (encoding == null) {
					encoding = "utf-8";
				}
				seamStr = new String(b, encoding);
			} else {
				seamStr = "time connected out";
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("提交Post数据请求(采用http原生实现)执行发生了异常  sorry -_-", e);
		} finally {
			if (outStream != null) {
				try {
					outStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (conn != null) {
				conn.disconnect();
			}
		}
		return seamStr;
	}

	public static byte[] getContentFromInputStream(InputStream fis) {
		byte[] content = null;
		if (fis != null) {
			ByteArrayOutputStream baos = null;
			try {
				// 缓冲区
				byte[] buffer = new byte[1024 * 4];
				// 头信息
				// byte[] head = new byte[4];
				// 打开一个输出流
				baos = new ByteArrayOutputStream();
				// 记录读到缓冲buffer中的字节长度
				int ch = 0;
				while ((ch = fis.read(buffer)) != -1) {
					// 因为有可能出现ch与buffer的length不一致的问题,所以用下面的写法
					baos.write(buffer, 0, ch);
				}
				content = baos.toByteArray();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					if (fis != null) {
						fis.close();
					}
					if (baos != null) {
						baos.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return content;
	}
}
