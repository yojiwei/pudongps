package com.beyondbit.hibernate;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.math.BigDecimal;
import org.apache.commons.beanutils.ConvertUtils;
import com.beyondbit.struts.converter.BigDecimalConverter;

public class ContextSupport {
    public ContextSupport() {
    }

    private static ApplicationContext context = null;
    static {
        context = new ClassPathXmlApplicationContext(
            "applicationContext.xml");
        ConvertUtils.deregister(BigDecimal.class);
        ConvertUtils.register(new BigDecimalConverter(), BigDecimal.class);
    }

    public static ApplicationContext getContext(){
        return context;
    }
}
