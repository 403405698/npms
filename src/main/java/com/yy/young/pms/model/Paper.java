package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
/**
 * 论文情况实体类
 * Created by rookie on 2018-03-27.
 */
public class Paper{


    @ExcelColumn(value = "编号，主键，无意义", order = 1)
    private String id;//编号，主键，无意义

    @ExcelColumn(value = "用户编号", order = 2)
    private String userId;//用户编号

    @ExcelColumn(value = "序号", order = 3)
    private String serialNumber;//序号

    @ExcelColumn(value = "年月", order = 4)
    private String years;//年月

    @ExcelColumn(value = "题目", order = 5)
    private String title;//题目

    @ExcelColumn(value = "期刊名称", order = 6)
    private String periodicalName;//期刊名称

    @ExcelColumn(value = "卷期", order = 7)
    private String volume;//卷期

    @ExcelColumn(value = "页", order = 8)
    private String page;//页

    @ExcelColumn(value = "期刊类型", order = 9)
    private String periodicalType;//期刊类型

    @ExcelColumn(value = "排名", order = 10)
    private String ranking;//排名

    @ExcelColumn(value = "影响因子", order = 11)
    private String influenceFactor;//影响因子

    @ExcelColumn(value = "他引次数", order = 12)
    private String hisCitation;//他引次数

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
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getPeriodicalName() {
        return periodicalName;
    }
    public void setPeriodicalName(String periodicalName) {
        this.periodicalName = periodicalName;
    }
    public String getVolume() {
        return volume;
    }
    public void setVolume(String volume) {
        this.volume = volume;
    }
    public String getPage() {
        return page;
    }
    public void setPage(String page) {
        this.page = page;
    }
    public String getPeriodicalType() {
        return periodicalType;
    }
    public void setPeriodicalType(String periodicalType) {
        this.periodicalType = periodicalType;
    }
    public String getRanking() {
        return ranking;
    }
    public void setRanking(String ranking) {
        this.ranking = ranking;
    }
    public String getInfluenceFactor() {
        return influenceFactor;
    }
    public void setInfluenceFactor(String influenceFactor) {
        this.influenceFactor = influenceFactor;
    }
    public String getHisCitation() {
        return hisCitation;
    }
    public void setHisCitation(String hisCitation) {
        this.hisCitation = hisCitation;
    }

    public AuditPmsPaper toAnother() {
        AuditPmsPaper obj = new AuditPmsPaper();
        obj.setId(this.id);
        obj.setUserId(this.userId);
        obj.setSerialNumber(this.serialNumber);
        obj.setYears(this.years);
        obj.setTitle(this.title);
        obj.setPeriodicalName(this.periodicalName);
        obj.setVolume(this.volume);
        obj.setPage(this.page);
        obj.setPeriodicalType(this.periodicalType);
        obj.setRanking(this.ranking);
        obj.setInfluenceFactor(this.influenceFactor);
        obj.setHisCitation(this.hisCitation);
        obj.setStatus(this.status);
        obj.setLockStatus(this.lockStatus);
        return obj;
    }
}