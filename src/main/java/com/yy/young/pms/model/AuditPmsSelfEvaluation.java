package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
import java.util.Date;
/**
* xxx实体类
* Created by rookie on 2018-6-29.
*/
public class AuditPmsSelfEvaluation{

    @ExcelColumn(value = "编号，主键，无意义", order = 1)
    private String id;//编号，主键，无意义

    @ExcelColumn(value = "用户编号", order = 2)
    private String userId;//用户编号

    @ExcelColumn(value = "自我评价", order = 3)
    private String selfEvaluation;//自我评价

    @ExcelColumn(value = "itemId", order = 4)
    private String itemId;//itemId

    @ExcelColumn(value = "status", order = 5)
    private Integer status;//status

    //增加lock_status
    private Integer lockStatus;
    public Integer getLockStatus() {
        return lockStatus;
    }
    public void setLockStatus(Integer lockStatus) {
        this.lockStatus = lockStatus;
    }

    public AuditPmsSelfEvaluation(){
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
    public String getSelfEvaluation() {
        return selfEvaluation;
    }
    public void setSelfEvaluation(String selfEvaluation) {
        this.selfEvaluation = selfEvaluation;
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

    public PmsSelfEvaluation toAnother() {
        PmsSelfEvaluation obj = new PmsSelfEvaluation();
        obj.setId(this.id);
        obj.setUserId(this.userId);
        obj.setSelfEvaluation(this.selfEvaluation);
        obj.setLockStatus(this.lockStatus);
        return obj;
    }

}