package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
import java.util.Date;
/**
* xxx实体类
* Created by rookie on 2018-7-3.
*/
public class AuditFieldSelfeval{

    @ExcelColumn(value = "id", order = 1)
    private String id;//id

    @ExcelColumn(value = "tableName", order = 2)
    private String tableName;//tableName

    @ExcelColumn(value = "field", order = 3)
    private String field;//field

    @ExcelColumn(value = "fieldVal", order = 4)
    private String fieldVal;//fieldVal

    @ExcelColumn(value = "userId", order = 5)
    private String userId;//userId

    @ExcelColumn(value = "status", order = 6)
    private Integer status;//status

    public AuditFieldSelfeval(){
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
    public String getField() {
        return field;
    }
    public void setField(String field) {
        this.field = field;
    }
    public String getFieldVal() {
        return fieldVal;
    }
    public void setFieldVal(String fieldVal) {
        this.fieldVal = fieldVal;
    }
    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public Integer getStatus() {
        return status;
    }
    public void setStatus(Integer status) {
        this.status = status;
    }

}