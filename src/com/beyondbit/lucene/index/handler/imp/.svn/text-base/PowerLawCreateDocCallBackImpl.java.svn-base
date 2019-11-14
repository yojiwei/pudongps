package com.beyondbit.lucene.index.handler.imp;

import java.util.Hashtable;

import org.apache.log4j.Logger;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;

import com.beyondbit.lucene.index.handler.IndexCreateDocCallBack;
import com.util.CTools;

/**
 * @author chentianyu
 * ΪȨf�>ݴ���Document����
 */
public class PowerLawCreateDocCallBackImpl implements IndexCreateDocCallBack {
	private static Logger logger = Logger.getLogger(PowerLawCreateDocCallBackImpl.class);

	public void createIndexDoc(Document doc, Object object) {
		try {
			Hashtable result = (Hashtable)object;
			doc.add(new Field("uuid", CTools.dealNull(result.get("id")), Field.Store.YES,
					Field.Index.UN_TOKENIZED));
			doc.add(new Field("lawname", CTools.dealNull(result.get("lawname")), Field.Store.YES,
					Field.Index.TOKENIZED,
					Field.TermVector.WITH_POSITIONS_OFFSETS));
			doc.add(new Field("describe", CTools.dealNull(result.get("describe")), Field.Store.YES,
					Field.Index.TOKENIZED,
					Field.TermVector.WITH_POSITIONS_OFFSETS));
			doc.add(new Field("authorityby", CTools.dealNull(result.get("authorityby")), Field.Store.YES,
					Field.Index.TOKENIZED));
			doc.add(new Field("bykind", CTools.dealNull(result.get("bykind")), Field.Store.YES,
					Field.Index.TOKENIZED));
			doc.add(new Field("consteorgan", CTools.dealNull(result.get("consteorgan")), Field.Store.YES,
					Field.Index.TOKENIZED));
		} catch (Exception e) {
			logger.error("ΪȨf�>ݴ���Document������",e);
		}
	}

}
