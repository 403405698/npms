package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
/**
 * 技术支撑信息实体类
 * Created by rookie on 2018-03-27.
 */
public class TechnologyBrace{


    @ExcelColumn(value = "编号，主键，无意义", order = 1)
    private String id;//编号，主键，无意义

    @ExcelColumn(value = "用户编号", order = 2)
    private String userId;//用户编号

    @ExcelColumn(value = "序号", order = 3)
    private String serialNumber;//序号

    @ExcelColumn(value = "发布/采纳时间", order = 4)
    private String release;//发布/采纳时间

    @ExcelColumn(value = "成果名称", order = 5)
    private String achievementsName;//成果名称

    @ExcelColumn(value = "发布/采纳部门", order = 6)
    private String releaseDept;//发布/采纳部门

    @ExcelColumn(value = "发布/采纳形式", order = 7)
    private String releaseName;//发布/采纳名称

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
    public String getRelease() {
        return release;
    }
    public void setRelease(String release) {
        this.release = release;
    }
    public String getAchievementsName() {
        return achievementsName;
    }
    public void setAchievementsName(String achievementsName) {
        this.achievementsName = achievementsName;
    }
    public String getReleaseDept() {
        return releaseDept;
    }
    public void setReleaseDept(String releaseDept) {
        this.releaseDept = releaseDept;
    }
    public String getReleaseName() {
        return releaseName;
    }
    public void setReleaseName(String releaseName) {
        this.releaseName = releaseName;
    }

    public AuditPmsTechnologyBrace toAnother() {
        AuditPmsTechnologyBrace obj = new AuditPmsTechnologyBrace();
        obj.setId(this.id);
        obj.setUserId(this.userId);
        obj.setSerialNumber(this.serialNumber);
        obj.setRelease(this.release);
        obj.setAchievementsName(this.achievementsName);
        obj.setReleaseDept(this.releaseDept);
        obj.setReleaseName(this.releaseName);
        obj.setStatus(this.status);
        obj.setLockStatus(this.lockStatus);
        return obj;
    }
}