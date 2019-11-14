/*
 * Copyright (c)Beyondbit Internet Software Co., Ltd. 
 * 
 * This software is the confidential and proprietary information of 
 * Beyondbit Internet Software  Co., Ltd. ("Confidential Information").
 * You shall not disclose such Confidential Information and shall use it 
 * only in accordance with the terms of the license agreement you 
 * entered into with Beyondbit Internet Software Co., Ltd.
 */
package com.beyondbit.lucene.index.handler.imp;

import java.util.Hashtable;

import org.apache.log4j.Logger;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;

import com.beyondbit.lucene.index.handler.IndexCreateDocCallBack;
import com.util.CTools;

/**
 * @author liuyang <br>
 * @date 2007-9-19 <br>
 * @description: 
 */
/**
 * @author chentianyu
 * 为权力事项创建Document对象
 */
public class PowerStdCreateDocCallBackImpl implements IndexCreateDocCallBack {
	private static Logger logger = Logger.getLogger(PowerStdCreateDocCallBackImpl.class); 

	public void createIndexDoc(Document doc, Object object) {
		try {
			Hashtable result = (Hashtable)object;
			doc.add(new Field("uuid", CTools.dealNull(result.get("psid")), Field.Store.NO,
					Field.Index.UN_TOKENIZED));
			doc.add(new Field("psid", CTools.dealNull(result.get("psid")), Field.Store.YES,
					Field.Index.UN_TOKENIZED));
			doc.add(new Field("cateid", CTools.dealNull(result.get("cateid")), Field.Store.YES,
					Field.Index.UN_TOKENIZED));
			doc.add(new Field("pscode", CTools.dealNull(result.get("pscode")), Field.Store.YES,
					Field.Index.TOKENIZED));
			doc.add(new Field("aunitcode", CTools.dealNull(result.get("aunitcode")).trim().toLowerCase(), Field.Store.YES,
					Field.Index.TOKENIZED));
			doc.add(new Field("aunitname", CTools.dealNull(result.get("aunitname")).trim().toLowerCase(), Field.Store.YES,
					Field.Index.TOKENIZED));
			doc.add(new Field("attr1name", CTools.dealNull(result.get("attr1name")).trim(), Field.Store.YES,
					Field.Index.TOKENIZED));
			doc.add(new Field("psname", CTools.dealNull(result.get("psname")), Field.Store.YES,
					Field.Index.TOKENIZED,
					Field.TermVector.WITH_POSITIONS_OFFSETS));
			doc.add(new Field("des", CTools.dealNull(result.get("des")), Field.Store.YES,
					Field.Index.TOKENIZED,
					Field.TermVector.WITH_POSITIONS_OFFSETS));
		} catch (Exception e) {
			logger.error("为权力事项创建Document对象出错",e);
		}

	}

}
