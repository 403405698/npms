package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
/**
 * 科技奖情况表实体类
 * Created by rookie on 2018-03-27.
 */
public class PmsTechAwards{


    @ExcelColumn(value = "编号，主键，无意义", order = 1)
    private String id;//编号，主键，无意义

    @ExcelColumn(value = "用户编号", order = 2)
    private String userId;//用户编号

    @ExcelColumn(value = "序号", order = 3)
    private String serialNumber;//序号

    @ExcelColumn(value = "年月", order = 4)
    private String years;//年月

    @ExcelColumn(value = "奖励类别", order = 5)
    private String awardType;//奖励类别

    @ExcelColumn(value = "奖励层次", order = 6)
    private String awardLevel;//奖励层次

    @ExcelColumn(value = "获奖项目名称", order = 7)
    private String awardWinProjectName;//获奖项目名称

    @ExcelColumn(value = "获奖等级", order = 8)
    private String awardWinProjectLevel;//获奖等级

    @ExcelColumn(value = "排名", order = 9)
    private String ranking;//排名

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
    public String getAwardType() {
        return awardType;
    }
    public void setAwardType(String awardType) {
        this.awardType = awardType;
    }
    public String getAwardLevel() {
        return awardLevel;
    }
    public void setAwardLevel(String awardLevel) {
        this.awardLevel = awardLevel;
    }
    public String getAwardWinProjectName() {
        return awardWinProjectName;
    }
    public void setAwardWinProjectName(String awardWinProjectName) {
        this.awardWinProjectName = awardWinProjectName;
    }
    public String getAwardWinProjectLevel() {
        return awardWinProjectLevel;
    }
    public void setAwardWinProjectLevel(String awardWinProjectLevel) {
        this.awardWinProjectLevel = awardWinProjectLevel;
    }
    public String getRanking() {
        return ranking;
    }
    public void setRanking(String ranking) {
        this.ranking = ranking;
    }

    public AuditPmsTechAwards toAnother() {
        AuditPmsTechAwards obj = new AuditPmsTechAwards();
        obj.setId(this.id);
        obj.setUserId(this.userId);
        obj.setSerialNumber(this.serialNumber);
        obj.setYears(this.years);
        obj.setAwardType(this.awardType);
        obj.setAwardLevel(this.awardLevel);
        obj.setAwardWinProjectLevel(this.awardWinProjectLevel);
        obj.setAwardWinProjectName(this.awardWinProjectName);
        obj.setRanking(this.ranking);
        obj.setStatus(this.status);
        obj.setLockStatus(this.lockStatus);
        return obj;
    }
}