package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
import java.util.Date;
/**
* xxx实体类
* Created by rookie on 2018-6-29.
*/
public class AuditPmsSupportProject{

    @ExcelColumn(value = "编号，主键，无意义", order = 1)
    private String id;//编号，主键，无意义

    @ExcelColumn(value = "用户编号", order = 2)
    private String userId;//用户编号

    @ExcelColumn(value = "序号", order = 3)
    private String serialNumber;//序号

    @ExcelColumn(value = "年月", order = 4)
    private String years;//年月

    @ExcelColumn(value = "计划项目名称", order = 5)
    private String planProjectName;//计划项目名称

    @ExcelColumn(value = "人才层次", order = 6)
    private String personnelLevel;//人才层次

    @ExcelColumn(value = "itemId", order = 7)
    private String itemId;//itemId

    @ExcelColumn(value = "status", order = 8)
    private Integer status;//status

    //增加lock_status
    private Integer lockStatus;
    public Integer getLockStatus() {
        return lockStatus;
    }
    public void setLockStatus(Integer lockStatus) {
        this.lockStatus = lockStatus;
    }

    public AuditPmsSupportProject(){
        super();
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
    public String getPlanProjectName() {
        return planProjectName;
    }
    public void setPlanProjectName(String planProjectName) {
        this.planProjectName = planProjectName;
    }
    public String getPersonnelLevel() {
        return personnelLevel;
    }
    public void setPersonnelLevel(String personnelLevel) {
        this.personnelLevel = personnelLevel;
    }
    public String getItemId() {
        return itemId;
    }
    public void setItemId(String itemId) {
        this.itemId = itemId;
    }
    public Integer getStatus() {
        return status;
    }
    public void setStatus(Integer status) {
        this.status = status;
    }


    public PmsSupportProject toAnother() {
        PmsSupportProject obj = new PmsSupportProject();
        obj.setId(this.id);
        obj.setUserId(this.userId);
        obj.setSerialNumber(this.serialNumber);
        obj.setYears(this.years);
        obj.setPlanProjectName(this.planProjectName);
        obj.setPersonnelLevel(this.personnelLevel);
        obj.setStatus(this.status);
        obj.setLockStatus(this.lockStatus);
        return obj;
    }
}