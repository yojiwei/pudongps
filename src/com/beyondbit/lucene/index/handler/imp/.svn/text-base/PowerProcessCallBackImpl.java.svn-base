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
 * @author chentianyu
 * 为权力过程创建Document对象
 */
public class PowerProcessCallBackImpl implements IndexCreateDocCallBack{
	private static Logger logger = Logger.getLogger(PowerProcessCallBackImpl.class); 
	public void createIndexDoc(Document doc, Object object) {
		try {
			Hashtable result = (Hashtable)object;
			doc.add(new Field("uuid", CTools.dealNull(result.get("ppid")), Field.Store.NO,
					Field.Index.UN_TOKENIZED));
			doc.add(new Field("ppid", CTools.dealNull(result.get("ppid")), Field.Store.YES,
					Field.Index.UN_TOKENIZED));
			doc.add(new Field("code", CTools.dealNull(result.get("code")), Field.Store.YES,
					Field.Index.UN_TOKENIZED));
			doc.add(new Field("unitid", CTools.dealNull(result.get("unitid")), Field.Store.YES,
					Field.Index.UN_TOKENIZED));
			doc.add(new Field("unitname", CTools.dealNull(result.get("unitname")).trim(), Field.Store.YES,
					Field.Index.UN_TOKENIZED));
			doc.add(new Field("createuserid", CTools.dealNull(result.get("createuserid")).trim().toLowerCase(), Field.Store.YES,
					Field.Index.UN_TOKENIZED));
			doc.add(new Field("createusername", CTools.dealNull(result.get("createusername")).trim(), Field.Store.YES,
					Field.Index.UN_TOKENIZED));
			doc.add(new Field("des", CTools.dealNull(result.get("des")), Field.Store.YES,
					Field.Index.TOKENIZED,
					Field.TermVector.WITH_POSITIONS_OFFSETS));
			doc.add(new Field("supervisedes", CTools.dealNull(result.get("supervisedes")), Field.Store.YES,
					Field.Index.TOKENIZED,
					Field.TermVector.WITH_POSITIONS_OFFSETS));
		} catch (Exception e) {
			logger.error("为权力过程创建Document对象出错",e);
		}		
		
	}

}
