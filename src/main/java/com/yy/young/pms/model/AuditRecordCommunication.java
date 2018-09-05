package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
import java.util.Date;
/**
* xxx实体类
* Created by rookie on 2018-7-18.
*/
public class AuditRecordCommunication{

    @ExcelColumn(value = "id", order = 1)
    private String id;//id

    @ExcelColumn(value = "fieldKey", order = 2)
    private String fieldKey;//fieldKey

    @ExcelColumn(value = "fieldVal", order = 3)
    private String fieldVal;//fieldVal

    @ExcelColumn(value = "userId", order = 4)
    private String userId;//userId

    @ExcelColumn(value = "auditStatus", order = 5)
    private Integer auditStatus;//auditStatus

    @ExcelColumn(value = "lockStatus", order = 6)
    private Integer lockStatus;//lockStatus

    @ExcelColumn(value = "itemId", order = 7)
    private Integer itemId;//itemId

    public AuditRecordCommunication(){
        super();
    }

    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getFieldKey() {
        return fieldKey;
    }
    public void setFieldKey(String fieldKey) {
        this.fieldKey = fieldKey;
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
    public Integer getAuditStatus() {
        return auditStatus;
    }
    public void setAuditStatus(Integer auditStatus) {
        this.auditStatus = auditStatus;
    }
    public Integer getLockStatus() {
        return lockStatus;
    }
    public void setLockStatus(Integer lockStatus) {
        this.lockStatus = lockStatus;
    }
    public Integer getItemId() {
        return itemId;
    }
    public void setItemId(Integer itemId) {
        this.itemId = itemId;
    }

    public Communication toAnother() {
        Communication obj = new Communication();
        if (("officePhone").equals(this.fieldKey)) {
            obj.setOfficePhone(this.fieldVal);
        }
        if (("mobilePhone").equals(this.fieldKey)) {
            obj.setMobilePhone(this.fieldVal);
        }

        if (("faxNumber").equals(this.fieldKey)) {
            obj.setFaxNumber(this.fieldVal);
        }
        if (("emailAddress").equals(this.fieldKey)) {
            obj.setEmailAddress(this.fieldVal);
        }
        if (("postalAddress").equals(this.fieldKey)) {
            obj.setPostalAddress(this.fieldVal);
        }
        if (("relationshipOne").equals(this.fieldKey)) {
            obj.setRelationshipOne(this.fieldVal);
        }
        if (("nameOne").equals(this.fieldKey)) {
            obj.setNameOne(this.fieldVal);
        }
        if (("emergencyContactOne").equals(this.fieldKey)) {
            obj.setEmergencyContactOne(this.fieldVal);
        }
        if (("relationshipTwo").equals(this.fieldKey)) {
            obj.setRelationshipTwo(this.fieldVal);
        }
        if (("nameTwo").equals(this.fieldKey)) {
            obj.setNameTwo(this.fieldVal);
        }
        if (("emergencyContactTwo").equals(this.fieldKey)) {
            obj.setEmergencyContactTwo(this.fieldVal);
        }
        return obj;
    }

    public Communication noOkItem() {
        Communication obj = new Communication();
        if (("officePhone").equals(this.fieldKey)) {
            obj.setOfficePhone("");
        }
        if (("mobilePhone").equals(this.fieldKey)) {
            obj.setMobilePhone("");
        }

        if (("faxNumber").equals(this.fieldKey)) {
            obj.setFaxNumber("");
        }
        if (("emailAddress").equals(this.fieldKey)) {
            obj.setEmailAddress("");
        }
        if (("postalAddress").equals(this.fieldKey)) {
            obj.setPostalAddress("");
        }
        if (("relationshipOne").equals(this.fieldKey)) {
            obj.setRelationshipOne("");
        }
        if (("nameOne").equals(this.fieldKey)) {
            obj.setNameOne("");
        }
        if (("emergencyContactOne").equals(this.fieldKey)) {
            obj.setEmergencyContactOne("");
        }
        if (("relationshipTwo").equals(this.fieldKey)) {
            obj.setRelationshipTwo("");
        }
        if (("nameTwo").equals(this.fieldKey)) {
            obj.setNameTwo("");
        }
        if (("emergencyContactTwo").equals(this.fieldKey)) {
            obj.setEmergencyContactTwo("");
        }
        return obj;
    }
}