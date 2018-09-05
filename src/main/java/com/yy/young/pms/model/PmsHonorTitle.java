package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
/**
 * 荣誉称号表实体类
 * Created by rookie on 2018-03-27.
 */
public class PmsHonorTitle{


    @ExcelColumn(value = "编号，主键，无意义", order = 1)
    private String id;//编号，主键，无意义

    @ExcelColumn(value = "用户编号", order = 2)
    private String userId;//用户编号

    @ExcelColumn(value = "序号", order = 3)
    private String serialNumber;//序号

    @ExcelColumn(value = "年月", order = 4)
    private String years;//年月

    @ExcelColumn(value = "荣誉称号名称", order = 5)
    private String honorName;//荣誉称号名称

    @ExcelColumn(value = "颁发单位", order = 6)
    private String awardDept;//颁发单位

    @ExcelColumn(value = "称号级别", order = 7)
    private String titleLevel;//称号级别

    private Integer status;//status
    public Integer getStatus() {
        return status;
    }
    public void setStatus(Integer status) {
        this.status = status;
    }

    //增加lock_status
    private Integer lockStatus;
    public Integer getLockStatus() {
        return lockStatus;
    }
    public void setLockStatus(Integer lockStatus) {
        this.lockStatus = lockStatus;
    }

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
    public String getSerialNumber() {
        return serialNumber;
    }
    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }
    public String getYears() {
        return years;
    }
    public void setYears(String years) {
        this.years = years;
    }
    public String getHonorName() {
        return honorName;
    }
    public void setHonorName(String honorName) {
        this.honorName = honorName;
    }
    public String getAwardDept() {
        return awardDept;
    }
    public void setAwardDept(String awardDept) {
        this.awardDept = awardDept;
    }
    public String getTitleLevel() {
        return titleLevel;
    }
    public void setTitleLevel(String titleLevel) {
        this.titleLevel = titleLevel;
    }


    public AuditPmsHonorTitle toAnother() {
        AuditPmsHonorTitle obj = new AuditPmsHonorTitle();
        obj.setId(this.id);
        obj.setUserId(this.userId);
        obj.setSerialNumber(this.serialNumber);
        obj.setYears(this.years);
        obj.setHonorName(this.honorName);
        obj.setAwardDept(this.awardDept);
        obj.setTitleLevel(this.titleLevel);
        obj.setStatus(this.status);
        obj.setLockStatus(this.lockStatus);
        return obj;
    }
}