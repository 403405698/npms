package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
/**
 * 年度考核表实体类
 * Created by rookie on 2018-03-27.
 */
public class PmsYearCheck{


    @ExcelColumn(value = "编号", order = 1)
    private String id;//编号，主键，无意义

    @ExcelColumn(value = "用户编号", order = 2)
    private String userId;//用户编号

    @ExcelColumn(value = "序号", order = 3)
    private String serialNumber;//序号

    @ExcelColumn(value = "年", order = 4)
    private String years;//年

    @ExcelColumn(value = "考核分数", order = 5)
    private String checkScore;//考核分数/等级

    @ExcelColumn(value = "考核类型", order = 6)
    private String stype;//考核类型,1年度考核or0季度考核

    @ExcelColumn(value = "季度", order = 7)
    private Integer quarter;//季度,季度考核时必填

    @ExcelColumn(value = "第一季度", order = 8)
    private String quarterOne;//第一季度

    @ExcelColumn(value = "第二季度", order = 9)
    private String quarterTwo;//第二季度

    @ExcelColumn(value = "第三季度", order = 10)
    private String quarterThree;//第三季度

    @ExcelColumn(value = "第四季度", order = 11)
    private String quarterFour;//第四季度


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

    public String getStype() {
        return stype;
    }

    public void setStype(String stype) {
        this.stype = stype;
    }

    public Integer getQuarter() {
        return quarter;
    }

    public void setQuarter(Integer quarter) {
        this.quarter = quarter;
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
    public String getCheckScore() {
        return checkScore;
    }
    public void setCheckScore(String checkScore) {
        this.checkScore = checkScore;
    }

    public String getQuarterOne() {
        return quarterOne;
    }

    public void setQuarterOne(String quarterOne) {
        this.quarterOne = quarterOne;
    }

    public String getQuarterTwo() {
        return quarterTwo;
    }

    public void setQuarterTwo(String quarterTwo) {
        this.quarterTwo = quarterTwo;
    }

    public String getQuarterThree() {
        return quarterThree;
    }

    public void setQuarterThree(String quarterThree) {
        this.quarterThree = quarterThree;
    }

    public String getQuarterFour() {
        return quarterFour;
    }

    public void setQuarterFour(String quarterFour) {
        this.quarterFour = quarterFour;
    }


    public AuditPmsYearCheck toAnother() {
        AuditPmsYearCheck obj = new AuditPmsYearCheck();
        obj.setId(this.id);
        obj.setUserId(this.userId);
        obj.setYears(this.years);
        obj.setCheckScore(this.checkScore);
        obj.setStype(this.stype);
        obj.setQuarter(this.quarter);
        obj.setQuarterOne(this.quarterOne);
        obj.setQuarterTwo(this.quarterTwo);
        obj.setQuarterThree(this.quarterThree);
        obj.setQuarterFour(this.quarterFour);
        obj.setStatus(this.status);
        obj.setLockStatus(this.lockStatus);
        return obj;
    }
}