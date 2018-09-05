package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
/**
 * 工作经历实体类
 * Created by rookie on 2018-03-27.
 */
public class Work{


    @ExcelColumn(value = "编号，主键，无意义", order = 1)
    private String id;//编号，主键，无意义

    @ExcelColumn(value = "用户编号", order = 2)
    private String userId;//用户编号

    @ExcelColumn(value = "起始时间", order = 3)
    private String startTime;//起始时间

    @ExcelColumn(value = "终止时间", order = 4)
    private String stopTime;//终止时间

    @ExcelColumn(value = "工作单位", order = 5)
    private String workCompany;//工作单位

    @ExcelColumn(value = "工作部门", order = 6)
    private String workDept;//工作部门

    @ExcelColumn(value = "职务职称", order = 7)
    private String post;//职务职称

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

    //增加排序
    private Integer orderNum;

    public Integer getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(Integer orderNum) {
        this.orderNum = orderNum;
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
    public String getWorkCompany() {
        return workCompany;
    }
    public void setWorkCompany(String workCompany) {
        this.workCompany = workCompany;
    }
    public String getWorkDept() {
        return workDept;
    }
    public void setWorkDept(String workDept) {
        this.workDept = workDept;
    }
    public String getPost() {
        return post;
    }
    public void setPost(String post) {
        this.post = post;
    }

    public AuditPmsWork toAnother() {
        AuditPmsWork obj = new AuditPmsWork();
        obj.setId(this.id);
        obj.setUserId(this.userId);
        obj.setStartTime(this.startTime);
        obj.setStopTime(this.stopTime);
        obj.setWorkCompany(this.workCompany);
        obj.setWorkDept(this.workDept);
        obj.setPost(this.post);
        obj.setStatus(this.status);
        obj.setLockStatus(this.lockStatus);
        obj.setContent(this.content);//new
        obj.setOrderNum(this.orderNum);
        obj.setCollectStatus(this.collectStatus);
        return obj;
    }

}