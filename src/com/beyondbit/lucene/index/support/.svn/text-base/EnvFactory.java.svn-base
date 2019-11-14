package com.beyondbit.lucene.index.support;

import java.util.Map;
import java.util.HashMap;
import java.lang.reflect.*;

public class EnvFactory {
    private static Map jobenvMap = new HashMap();
    public EnvFactory() {
    }
    public static IEnv createEnv(IJob job){
        try {
            return (IEnv) ( (Class) jobenvMap.get(job.getClass())).
                getConstructor(new Class[] {IJob.class}).newInstance(new
                Object[] {job});
        }
        catch (Exception ex) {
            try {
                return (IEnv) ( (Class) jobenvMap.get(job.getClass())).
                    newInstance();
            }
            catch (Exception ex1) {
                return null;
            }

        }

    }

    public static Class getEnvClass(IJob job){
        return (Class) jobenvMap.get(job.getClass());
    }

    public static void registerEnv(Class job,Class env){

        jobenvMap.put(job,env);
    }
}
