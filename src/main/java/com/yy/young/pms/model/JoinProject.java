package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
/**
 * 参加项目信息实体类
 * Created by rookie on 2018-03-27.
 */
public class JoinProject{


    @ExcelColumn(value = "编号，主键，无意义", order = 1)
    private String id;//编号，主键，无意义

    @ExcelColumn(value = "用户编号", order = 2)
    private String userId;//用户编号

    @ExcelColumn(value = "序号", order = 3)
    private String serialNumber;//序号

    @ExcelColumn(value = "课题/专项类别", order = 4)
    private String projectType;//课题/专项类别

    @ExcelColumn(value = "起始时间", order = 5)
    private String startTime;//起始时间

    @ExcelColumn(value = "结束时间", order = 6)
    private String stopTime;//结束时间

    @ExcelColumn(value = "项目名称", order = 7)
    private String projectName;//项目名称

    @ExcelColumn(value = "经费", order = 8)
    private String funds;//经费

    @ExcelColumn(value = "担任角色", order = 9)
    private String role;//担任角色

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
    public String getProjectType() {
        return projectType;
    }
    public void setProjectType(String projectType) {
        this.projectType = projectType;
    }
    public String getStartTime() {
        return startTime;
    }
    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }
    public String getStopTime() {
        return stopTime;
    }
    public void setStopTime(String stopTime) {
        this.stopTime = stopTime;
    }
    public String getProjectName() {
        return projectName;
    }
    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }
    public String getFunds() {
        return funds;
    }
    public void setFunds(String funds) {
        this.funds = funds;
    }
    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }

    public AuditPmsJoinProject toAnother() {
        AuditPmsJoinProject obj = new AuditPmsJoinProject();
        obj.setId(this.id);
        obj.setUserId(this.userId);
        obj.setSerialNumber(this.serialNumber);
        obj.setProjectType(this.projectType);
        obj.setStartTime(this.startTime);
        obj.setStopTime(this.stopTime);
        obj.setProjectName(this.projectName);
        obj.setFunds(this.funds);
        obj.setRole(this.role);
        obj.setStatus(this.status);
        obj.setLockStatus(this.lockStatus);
        return obj;
    }
}