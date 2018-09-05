package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
/**
 * 通讯信息实体类
 * Created by rookie on 2018-03-27.
 */
public class Communication{


    @ExcelColumn(value = "编号，主键，无意义", order = 1)
    private String id;//编号，主键，无意义

    @ExcelColumn(value = "用户编号", order = 2)
    private String userId;//用户编号

    @ExcelColumn(value = "办公电话", order = 3)
    private String officePhone;//办公电话

    @ExcelColumn(value = "手机号", order = 4)
    private String mobilePhone;//手机号

    @ExcelColumn(value = "传真号", order = 5)
    private String faxNumber;//传真号

    @ExcelColumn(value = "通讯地址", order = 6)
    private String postalAddress;//通讯地址

    @ExcelColumn(value = "邮箱地址", order = 7)
    private String emailAddress;//邮箱地址

    @ExcelColumn(value = "紧急联系人1电话", order = 8)
    private String emergencyContactOne;//紧急联系人1电话

    @ExcelColumn(value = "关系1", order = 9)
    private String relationshipOne;//关系1

    @ExcelColumn(value = "紧急联系人2电话", order = 10)
    private String emergencyContactTwo;//紧急联系人2电话

    @ExcelColumn(value = "关系2", order = 11)
    private String relationshipTwo;//关系2

    @ExcelColumn(value = "紧急联系人1姓名", order = 12)
    private String nameOne;//紧急联系人1姓名

    @ExcelColumn(value = "紧急联系人2姓名", order = 13)
    private String nameTwo;//紧急联系人2姓名



    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public String getOfficePhone() {
        return officePhone;
    }
    public void setOfficePhone(String officePhone) {
        this.officePhone = officePhone;
    }
    public String getMobilePhone() {
        return mobilePhone;
    }
    public void setMobilePhone(String mobilePhone) {
        this.mobilePhone = mobilePhone;
    }
    public String getFaxNumber() {
        return faxNumber;
    }
    public void setFaxNumber(String faxNumber) {
        this.faxNumber = faxNumber;
    }
    public String getPostalAddress() {
        return postalAddress;
    }
    public void setPostalAddress(String postalAddress) {
        this.postalAddress = postalAddress;
    }
    public String getEmailAddress() {
        return emailAddress;
    }
    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }
    public String getEmergencyContactOne() {
        return emergencyContactOne;
    }
    public void setEmergencyContactOne(String emergencyContactOne) {
        this.emergencyContactOne = emergencyContactOne;
    }
    public String getRelationshipOne() {
        return relationshipOne;
    }
    public void setRelationshipOne(String relationshipOne) {
        this.relationshipOne = relationshipOne;
    }
    public String getEmergencyContactTwo() {
        return emergencyContactTwo;
    }
    public void setEmergencyContactTwo(String emergencyContactTwo) {
        this.emergencyContactTwo = emergencyContactTwo;
    }
    public String getRelationshipTwo() {
        return relationshipTwo;
    }
    public void setRelationshipTwo(String relationshipTwo) {
        this.relationshipTwo = relationshipTwo;
    }

    public String getNameOne() {
        return nameOne;
    }

    public void setNameOne(String nameOne) {
        this.nameOne = nameOne;
    }

    public String getNameTwo() {
        return nameTwo;
    }

    public void setNameTwo(String nameTwo) {
        this.nameTwo = nameTwo;
    }

    public AuditPmsCommunication toAnother() {
        AuditPmsCommunication obj = new AuditPmsCommunication();
        obj.setId(this.id);
        obj.setUserId(this.userId);
        obj.setOfficePhone(this.officePhone);
        obj.setMobilePhone(this.mobilePhone);
        obj.setFaxNumber(this.faxNumber);
        obj.setPostalAddress(this.postalAddress);
        obj.setEmailAddress(this.emailAddress);
        obj.setEmergencyContactOne(this.emergencyContactOne);
        obj.setRelationshipOne(this.relationshipOne);
        obj.setEmergencyContactTwo(this.emergencyContactTwo);
        obj.setRelationshipTwo(this.relationshipTwo);
        obj.setNameOne(this.nameOne);
        obj.setNameTwo(this.nameTwo);
        return obj;
    }
}