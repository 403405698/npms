package com.yy.young.pms.util;

import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

public class DynamicDataSource extends AbstractRoutingDataSource {
    @Override
    protected Object determineCurrentLookupKey() {
        System.out.println("into dynamicdb-method");
        System.out.println("dynamicdb:" + DataSourceHolder.getDataSources());
        return DataSourceHolder.getDataSources();
    }
}