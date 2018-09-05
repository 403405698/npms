package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
import java.util.Date;
/**
* xxx实体类
* Created by rookie on 2018-6-29.
*/
public class AuditField{

    @ExcelColumn(value = "主键，无意义", order = 1)
    private String id;//主键，无意义

    @ExcelColumn(value = "表名", order = 2)
    private String tableName;//表名

    @ExcelColumn(value = "表字段", order = 3)
    private String tableField;//表字段

    @ExcelColumn(value = "状态：1开启审核  2不审核   4删除", order = 4)
    private Integer status;//状态：1开启审核  2不审核   4删除

    public AuditField(){
        super();
    }

    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getTableName() {
        return tableName;
    }
    public void setTableName(String tableName) {
        this.tableName = tableName;
    }
    public String getTableField() {
        return tableField;
    }
    public void setTableField(String tableField) {
        this.tableField = tableField;
    }
    public Integer getStatus() {
        return status;
    }
    public void setStatus(Integer status) {
        this.status = status;
    }

}