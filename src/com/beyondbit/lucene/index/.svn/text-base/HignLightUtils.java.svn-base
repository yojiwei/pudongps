/*
 * Copyright (c)Beyondbit Internet Software Co., Ltd.
 *
 * This software is the confidential and proprietary information of
 * Beyondbit Internet Software  Co., Ltd. ("Confidential Information").
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you
 * entered into with Beyondbit Internet Software Co., Ltd.
 */
package com.beyondbit.lucene.index;

import java.io.IOException;
import java.io.StringReader;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.queryParser.MultiFieldQueryParser;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.highlight.Highlighter;
import org.apache.lucene.search.highlight.QueryScorer;
import org.apache.lucene.search.highlight.SimpleFragmenter;
import org.apache.lucene.search.highlight.SimpleHTMLFormatter;
import org.apache.lucene.index.TermPositionVector;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.search.highlight.TokenSources;

/**
 * @author liuyang <br>
 * @date 2007-9-19 <br>
 * @description:
 */
public class HignLightUtils {
	//html文本转换对象
	private SimpleHTMLFormatter sHtmlF;
	//关键字高亮显示器
	private Highlighter highlighter;
	private Analyzer analyzer;

	public SimpleHTMLFormatter getSHtmlF() {
		return sHtmlF;
	}
	public void setSHtmlF(SimpleHTMLFormatter htmlF) {
		sHtmlF = htmlF;
	}
	public Analyzer getAnalyzer() {
		return analyzer;
	}
	public void setAnalyzer(Analyzer analyzer) {
		this.analyzer = analyzer;
	}
	/**
	 * 构造函数
	 * @param fieldName 分析域名
	 * @param searchValue 搜索值

	 */
	public HignLightUtils(String fieldName, String searchValue, Analyzer userAnalyzer) {
		Query query = null;
		try {
			analyzer = userAnalyzer;
			query = MultiFieldQueryParser.parse(new String[]{searchValue}, new String[]{fieldName}, analyzer);
			sHtmlF = new SimpleHTMLFormatter(
					"<font color='red'>", "</font>");
			highlighter = new Highlighter(sHtmlF, new QueryScorer(
					query));
			highlighter.setTextFragmenter(new SimpleFragmenter(100));
		} catch (ParseException e) {
			throw new RuntimeException(e);
		}
	}

    public static void main(String args[]) throws Exception {
        System.out.println("dd:"+LuceneUtils.analyzerSearchValue("的"));
        new HignLightUtils("content",LuceneUtils.analyzerSearchValue("的"),LuceneUtils.getAnalyzer() );
    }
	/**
	 * 转换文本
	 * @param field
	 * @param text
	 * @return
	 * @throws IOException
	 */
	public String parseText(String field, String text) throws Exception {
		if(analyzer == null) {
			throw new Exception("Analyzer has not setter");
		}
		TokenStream tokenStream = analyzer.tokenStream(field, new StringReader(text));
		String temp = highlighter.getBestFragment(tokenStream,
				text);
		text = (temp == null) ? text : temp;
		temp = null;
		return text;
	}

    public String parseText(int id, String field, String text
                            ) throws Exception {
        IndexReader reader = (IndexReader)LuceneUtils.tlir.get();
        if (analyzer == null) {
            throw new Exception("Analyzer has not setter");
        }
        int maxNumFragmentsRequired = 2;
        String fragmentSeparator = "...";
        TermPositionVector tpv = (TermPositionVector) reader.
            getTermFreqVector(id, field);
        TokenStream tokenStream =  null;

        String result = null;
        try {
            tokenStream = TokenSources.getTokenStream(
            tpv);
             result =

                highlighter.getBestFragments(
                tokenStream,
                text,
                maxNumFragmentsRequired,
                fragmentSeparator);
        }
        catch (Exception ex) {
            ex.printStackTrace();
            result = text;
        }finally{
            if(tokenStream != null){
                tokenStream.close();
            }
        }

//        text = (temp == null) ? text : temp;
//        temp = null;
        return result;
    }

}
