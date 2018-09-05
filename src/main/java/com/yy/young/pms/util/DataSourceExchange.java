package com.yy.young.pms.util;

import org.aspectj.lang.JoinPoint;

public class DataSourceExchange {
    /**
     * @param point
     */
    public void before(JoinPoint point) {
        //获取目标对象的类类型
        Class<?> aClass = point.getTarget().getClass();
        String[] ss = aClass.getName().split("\\.");
        String packageName = ss[2];
        if ((aClass.getName()).contains("audit")) {
            DataSourceHolder.setDataSources(DataSourceConstants.DS2);
        } else {
            DataSourceHolder.setDataSources(DataSourceConstants.DS1);
        }
    }
    /**
     * 执行后将数据源置为空
     */
    public void after() {
        DataSourceHolder.setDataSources(null);
    }
}
