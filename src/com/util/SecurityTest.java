package com.util;

/**
 * 加密类----牛
 */
import java.lang.Math;

public class SecurityTest {
	interface Constants {
		public static final int INT_PRIM_NUMBER = 95;

		public static final int INT_RETURN_LOOP = 94;
	}

	/**
	 * SysBean constructor comment.
	 */
	public SecurityTest() {
		super();
	}

	/**
	 * 解密方法 zhg 创建日期 (2002-12-15 10:17:08) strCode 需解密的字符串 解密后的字符串 1.0
	 */
	public static String decode(String strCode) {
		String strOriginal;
		int intRnd;
		String strRnd;
		int intStrLen;
		String strDecodeMe = "";
		if (strCode.equals(""))
			return strDecodeMe;
		intStrLen = strCode.length() - 1;
		strRnd = strCode.substring(intStrLen / 2, intStrLen / 2 + 1);
		intRnd = strRnd.hashCode() - new SecurityTest().startChar();
		strCode = strCode.substring(0, intStrLen / 2)
				+ strCode.substring(intStrLen / 2 + 1, intStrLen + 1);
		strOriginal = new SecurityTest().loopCode(strCode,
				Constants.INT_RETURN_LOOP - intRnd);
		strDecodeMe = strOriginal;
		return strDecodeMe;
	}

	/**
	 * 加密方法.随机取得加密的循环次数，使得每次加密所得的秘文会有所不同 zhg 创建日期 (2002-12-15 10:17:08)
	 * strOriginal 需加密的字符串 加密后的字符串 1.0
	 */
	public static String encode(String strOriginal) {
		String strCode;
		int intRnd;
		char rnd;
		int intStrLen;
		String strCodeMe = "";
		if (strOriginal.equals(""))
			return strCodeMe;
		// 2 到 93 之间的随即数，即同一原文可能获得93种不同的秘文
		intRnd = (int) (Math.random() * (Constants.INT_RETURN_LOOP - 2) + 2);
		strCode = new SecurityTest().loopCode(strOriginal, intRnd);
		// 对随机数作偏移加密
		rnd = (char) (intRnd + new SecurityTest().startChar());
		intStrLen = strCode.length();
		strCodeMe = strCode.substring(0, intStrLen / 2) + rnd
				+ strCode.substring(intStrLen / 2, intStrLen);
		if (strCodeMe.indexOf("'") >= 0)
			return encode(strOriginal);
		else
			return strCodeMe;
	}

	// 基础的凯撒算法,并对于每一位增加了偏移
	private String kaiserCode(String strOriginal) {
		int intChar;
		String strCode;
		int i;
		int intStrLen;
		int intTmp;
		intStrLen = strOriginal.length();
		strCode = "";
		for (i = 0; i < intStrLen; i++) {
			intChar = strOriginal.substring(i, i + 1).hashCode();
			intTmp = intChar - this.startChar();
			intTmp = (intTmp * Constants.INT_PRIM_NUMBER + i + 1)
					% this.maxChar() + this.startChar();
			strCode = strCode + (char) (intTmp);
		}
		return strCode;
	}

	// 循环调用凯撒算法一定次数后，可以取得原文
	private String loopCode(String strOriginal, int intLoopCount) {
		String strCode;
		int i;
		strCode = strOriginal;
		for (i = 0; i < intLoopCount; i++)
			strCode = this.kaiserCode(strCode);
		return strCode;
	}

	public static void main(String[] args) throws Exception {
		String pw = "1";
		System.out.println(pw);
		pw = new sun.misc.BASE64Encoder().encode(pw.getBytes());
		System.out.println("加密中......"+pw);
		// 加密
		String pw1 = encode(pw);
		System.out.println("加密后......"+pw1);
		// 解密
		String pw2 = decode(pw1);
		System.out.println("解密中......."+pw2);
		byte[] bt = new sun.misc.BASE64Decoder().decodeBuffer(pw2);
		pw2 = new String(bt);
		System.out.println("解密后......"+pw2);
	}

	private int maxChar() {
		String str1 = "~";
		String str2 = "!";
		return str1.hashCode() - str2.hashCode() + 1;
	}

	private int startChar() {
		String str1 = "!";
		return str1.hashCode();
	}
}
