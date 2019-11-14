package com.beyondbit.lucene.index.support;

public interface IJob {
    /**
     * �����Ƿ�ɹ�
     * @param env Object
     * @return boolean
     */
    boolean run(IEnv env);

    /**
     * ʧ���ˣ��Ƿ���Ҫ�������<=0 Ϊ����Ҫ����
     * @return long
     */
    long getFailureRedoTime();





}
