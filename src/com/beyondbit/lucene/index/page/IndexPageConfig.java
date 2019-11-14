/*
 * Copyright (c)Beyondbit Internet Software Co., Ltd. 
 * 
 * This software is the confidential and proprietary information of 
 * Beyondbit Internet Software  Co., Ltd. ("Confidential Information").
 * You shall not disclose such Confidential Information and shall use it 
 * only in accordance with the terms of the license agreement you 
 * entered into with Beyondbit Internet Software Co., Ltd.
 */
package com.beyondbit.lucene.index.page;

import java.util.ArrayList;
import java.util.List;

/**
 * @author liuyang <br>
 * @date 2007-9-19 <br>
 * @description: 全文检索分页控制类
 */
public class IndexPageConfig {
	private int currentPage = 1;
	private int pageSize = 12;
	private int pageCount = 0;
	private List results = new ArrayList();
	private int resultCount = 0;
	private String depleteTime;
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public String getDepleteTime() {
		return depleteTime;
	}
	public void setDepleteTime(String depleteTime) {
		this.depleteTime = depleteTime;
	}
	public int getPageCount() {
		pageCount = resultCount / pageSize;
		if((pageCount * pageSize) < resultCount) {
			pageCount += 1;
		}
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getResultCount() {
		return resultCount;
	}
	public void setResultCount(int resultCount) {
		this.resultCount = resultCount;
	}
	public List getResults() {
		return results;
	}
	public void setResults(List results) {
		this.results = results;
	}
}
