/*
 * Copyright (c)Beyondbit Internet Software Co., Ltd. 
 * 
 * This software is the confidential and proprietary information of 
 * Beyondbit Internet Software  Co., Ltd. ("Confidential Information").
 * You shall not disclose such Confidential Information and shall use it 
 * only in accordance with the terms of the license agreement you 
 * entered into with Beyondbit Internet Software Co., Ltd.
 */
package com.beyondbit.lucene.index.handler;

import org.apache.lucene.document.Document;

/**
 * @author liuyang <br>
 * @date 2007-9-19 <br>
 * @description: 当用户搜索到对象的时候用于把索引对象转换为自己所需求的对象
 */
public interface CreateObjectAfterSearchIndex {
	/**
	 * 创建用户对象
	 * @param doc 搜索到的文档对象
	 * @return
	 */
	public Object createObject(Document doc) ;
}
