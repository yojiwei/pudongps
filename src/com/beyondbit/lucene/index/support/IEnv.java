package com.beyondbit.lucene.index.support;

import java.util.Map;

public interface IEnv extends Map{
    void initEnv() throws Exception;
    void release();

}
