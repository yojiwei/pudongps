package com.beyondbit.security;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.Security;
import java.security.spec.InvalidKeySpecException;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class DESUtil {
	private String Algorithm = "DES";
	private KeyGenerator keygen;
	private SecretKey deskey;
	private Cipher c;
	private byte[] cipherByte;
	private BASE64Encoder base64encoder = new BASE64Encoder();
	public DESUtil() throws InvalidKeyException, NoSuchAlgorithmException, InvalidKeySpecException,
			NoSuchPaddingException {
		init();
	}

	public void init() throws InvalidKeyException, NoSuchAlgorithmException, InvalidKeySpecException,
			NoSuchPaddingException {
		Security.addProvider(new com.sun.crypto.provider.SunJCE());
		//keygen = KeyGenerator.getInstance(Algorithm);
		//deskey = keygen.generateKey();
		byte[] keyBytes = new byte[8];
		keyBytes[0] = (byte)1;
		keyBytes[0] = (byte)9;//keyBytes[1] = (byte)9;
		keyBytes[0] = (byte)8;//keyBytes[2] = (byte)8;
		keyBytes[0] = (byte)1;//keyBytes[3] = (byte)1;
		keyBytes[0] = (byte)0;//keyBytes[4] = (byte)0;
		keyBytes[0] = (byte)4;//keyBytes[5] = (byte)4;
		keyBytes[0] = (byte)1;//keyBytes[6] = (byte)1;
		keyBytes[0] = (byte)2;//keyBytes[7] = (byte)2;
		DESKeySpec dks = new DESKeySpec(keyBytes);
		// 创建一个密钥工厂，然后用它把DESKeySpec转换成Secret Key对象
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
		deskey = keyFactory.generateSecret(dks);
		c = Cipher.getInstance(Algorithm);
	}

	/**
	 * 对 String 进行加密
	 * 
	 * @param str
	 *            要加密的数据
	 * @return 返回加密后的 byte 数组
	 */
	public byte[] createEncryptor(String str) {
		try {
			c.init(Cipher.ENCRYPT_MODE, deskey);
			cipherByte = c.doFinal(str.getBytes());
		} catch (java.security.InvalidKeyException ex) {
			ex.printStackTrace();
		} catch (javax.crypto.BadPaddingException ex) {
			ex.printStackTrace();
		} catch (javax.crypto.IllegalBlockSizeException ex) {
			ex.printStackTrace();
		}
		return cipherByte;
	}

	/**
	 * 对 Byte 数组进行解密
	 * 
	 * @param buff
	 *            要解密的数据
	 * @return 返回加密后的 String
	 * @throws InvalidKeyException
	 * @throws BadPaddingException
	 * @throws IllegalBlockSizeException
	 * @throws IllegalStateException
	 */
	public String createDecryptor(byte[] buff) throws InvalidKeyException, IllegalStateException,
			IllegalBlockSizeException, BadPaddingException {

		c.init(Cipher.DECRYPT_MODE, deskey);
		cipherByte = c.doFinal(buff);

		return (new String(cipherByte));
	}
	
	
	/**
	 * 加密方法
	 * @param source  需要加密的字符串
	 * @return 加密后的字符串
	 * @throws UnsupportedEncodingException
	 */
	public String encrypt(String source) throws UnsupportedEncodingException{
		return base64encoder.encodeBuffer(createEncryptor(source));
		
	}


}
