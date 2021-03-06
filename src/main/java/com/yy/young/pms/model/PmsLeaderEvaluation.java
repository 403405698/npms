package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
/**
 * 领导评价表实体类
 * Created by rookie on 2018-03-27.
 */
public class PmsLeaderEvaluation{


    @ExcelColumn(value = "编号，主键，无意义", order = 1)
    private String id;//编号，主键，无意义

    @ExcelColumn(value = "用户编号", order = 2)
    private String userId;//用户编号

    @ExcelColumn(value = "领导编号", order = 3)
    private String leaderId;//领导编号

    @ExcelColumn(value = "领导评价", order = 4)
    private String leaderEvaluation;//领导评价

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
    public String getLeaderId() {
        return leaderId;
    }
    public void setLeaderId(String leaderId) {
        this.leaderId = leaderId;
    }
    public String getLeaderEvaluation() {
        return leaderEvaluation;
    }
    public void setLeaderEvaluation(String leaderEvaluation) {
        this.leaderEvaluation = leaderEvaluation;
    }

    public AuditPmsLeaderEvaluation toAnother() {
        AuditPmsLeaderEvaluation obj = new AuditPmsLeaderEvaluation();
        obj.setId(this.id);
        obj.setUserId(this.userId);
        obj.setLeaderId(this.leaderId);
        obj.setLeaderEvaluation(this.leaderEvaluation);
        obj.setStatus(this.status);
        obj.setLockStatus(this.lockStatus);
        return obj;
    }
}