package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
import java.util.Date;
/**
* xxx实体类
* Created by rookie on 2018-7-3.
*/
public class AuditFieldCommu{

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

    //增加lock_status
    private Integer lockStatus;
    public Integer getLockStatus() {
        return lockStatus;
    }
    public void setLockStatus(Integer lockStatus) {
        this.lockStatus = lockStatus;
    }

    public AuditFieldCommu(){
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

    public Communication toAnother() {
        Communication obj = new Communication();
        if (("officePhone").equals(this.field)) {
            obj.setOfficePhone(this.fieldVal);
        }
        if (("mobilePhone").equals(this.field)) {
            obj.setMobilePhone(this.fieldVal);
        }

        if (("faxNumber").equals(this.field)) {
            obj.setFaxNumber(this.fieldVal);
        }
        if (("emailAddress").equals(this.field)) {
            obj.setEmailAddress(this.fieldVal);
        }
        if (("postalAddress").equals(this.field)) {
            obj.setPostalAddress(this.fieldVal);
        }
        if (("relationshipOne").equals(this.field)) {
            obj.setRelationshipOne(this.fieldVal);
        }
        if (("nameOne").equals(this.field)) {
            obj.setNameOne(this.fieldVal);
        }
        if (("emergencyContactOne").equals(this.field)) {
            obj.setEmergencyContactOne(this.fieldVal);
        }
        if (("relationshipTwo").equals(this.field)) {
            obj.setRelationshipTwo(this.fieldVal);
        }
        if (("nameTwo").equals(this.field)) {
            obj.setNameTwo(this.fieldVal);
        }
        if (("emergencyContactTwo").equals(this.field)) {
            obj.setEmergencyContactTwo(this.fieldVal);
        }
        return obj;
    }
}