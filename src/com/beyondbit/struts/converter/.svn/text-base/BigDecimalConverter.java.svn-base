package com.beyondbit.struts.converter;

import org.apache.commons.beanutils.Converter;
import java.math.BigDecimal;

public class BigDecimalConverter implements Converter {
    public BigDecimalConverter() {
    }

    /**
     * convert
     *
     * @param class0 Class
     * @param object Object
     * @return Object
     */
    public Object convert(Class class0, Object value) {
        if (value == null || "".equals(value))return null;

        if (value instanceof BigDecimal) {
            return (value);
        }
        return (new BigDecimal(value.toString()));

    }
}
