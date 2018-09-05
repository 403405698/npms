package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
/**
 * 教育经历实体类
 * Created by rookie on 2018-03-27.
 */
public class Education{


    @ExcelColumn(value = "编号，主键，无意义", order = 1)
    private String id;//编号，主键，无意义

    @ExcelColumn(value = "用户编号", order = 2)
    private String userId;//用户编号

    @ExcelColumn(value = "起始时间", order = 3)
    private String startTime;//起始时间

    @ExcelColumn(value = "终止时间", order = 4)
    private String stopTime;//终止时间

    @ExcelColumn(value = "院校名称", order = 5)
    private String universityName;//院校名称

    @ExcelColumn(value = "专业名称", order = 6)
    private String professionalName;//专业名称

    @ExcelColumn(value = "学位", order = 7)
    private String degree;//学位

    @ExcelColumn(value = "学历", order = 8)
    private String education;//学历

    @ExcelColumn(value = "培养方式", order = 9)
    private String cultureMode;//培养方式

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

    //增加排序
    private Integer orderNum;

    public Integer getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(Integer orderNum) {
        this.orderNum = orderNum;
    }

    private Integer collectStatus;

    public Integer getCollectStatus() {
        return collectStatus;
    }

    public void setCollectStatus(Integer collectStatus) {
        this.collectStatus = collectStatus;
    }

    //增加content allinone
    private String content;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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
    public String getUniversityName() {
        return universityName;
    }
    public void setUniversityName(String universityName) {
        this.universityName = universityName;
    }
    public String getProfessionalName() {
        return professionalName;
    }
    public void setProfessionalName(String professionalName) {
        this.professionalName = professionalName;
    }
    public String getDegree() {
        return degree;
    }
    public void setDegree(String degree) {
        this.degree = degree;
    }
    public String getEducation() {
        return education;
    }
    public void setEducation(String education) {
        this.education = education;
    }
    public String getCultureMode() {
        return cultureMode;
    }
    public void setCultureMode(String cultureMode) {
        this.cultureMode = cultureMode;
    }

    public AuditPmsEducation toAnother() {
        AuditPmsEducation obj = new AuditPmsEducation();
        obj.setId(this.id);
        obj.setUserId(this.userId);
        obj.setStartTime(this.startTime);
        obj.setStopTime(this.stopTime);
        obj.setUniversityName(this.universityName);
        obj.setProfessionalName(this.professionalName);
        obj.setDegree(this.degree);
        obj.setEducation(this.education);
        obj.setCultureMode(this.cultureMode);
        obj.setStatus(this.status);
        obj.setLockStatus(this.lockStatus);
        obj.setContent(this.content);//new
        obj.setOrderNum(this.orderNum);
        obj.setCollectStatus(this.collectStatus);
        return obj;
    }
}