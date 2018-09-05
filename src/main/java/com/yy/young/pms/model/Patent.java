package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
/**
 * 专利实体类
 * Created by rookie on 2018-03-27.
 */
public class Patent{


    @ExcelColumn(value = "编号，主键，无意义", order = 1)
    private String id;//编号，主键，无意义

    @ExcelColumn(value = "用户编号", order = 2)
    private String userId;//用户编号

    @ExcelColumn(value = "序号", order = 3)
    private String serialNumber;//序号

    @ExcelColumn(value = "年月", order = 4)
    private String years;//年月

    @ExcelColumn(value = "专利名称", order = 5)
    private String patentName;//专利名称

    @ExcelColumn(value = "专利号", order = 6)
    private String patentNumber;//专利号

    @ExcelColumn(value = "专利类型", order = 7)
    private String patentType;//专利类型

    @ExcelColumn(value = "排名", order = 8)
    private String ranking;//排名

    @ExcelColumn(value = "是否转让", order = 9)
    private String isAttorn;//是否转让

    @ExcelColumn(value = "转让金额", order = 10)
    private String attornMoney;//转让金额

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
    public String getPatentName() {
        return patentName;
    }
    public void setPatentName(String patentName) {
        this.patentName = patentName;
    }
    public String getPatentNumber() {
        return patentNumber;
    }
    public void setPatentNumber(String patentNumber) {
        this.patentNumber = patentNumber;
    }
    public String getPatentType() {
        return patentType;
    }
    public void setPatentType(String patentType) {
        this.patentType = patentType;
    }
    public String getRanking() {
        return ranking;
    }
    public void setRanking(String ranking) {
        this.ranking = ranking;
    }
    public String getIsAttorn() {
        return isAttorn;
    }
    public void setIsAttorn(String isAttorn) {
        this.isAttorn = isAttorn;
    }
    public String getAttornMoney() {
        return attornMoney;
    }
    public void setAttornMoney(String attornMoney) {
        this.attornMoney = attornMoney;
    }

    public AuditPmsPatent toAnother() {
        AuditPmsPatent obj = new AuditPmsPatent();
        obj.setId(this.id);
        obj.setUserId(this.userId);
        obj.setSerialNumber(this.serialNumber);
        obj.setYears(this.years);
        obj.setPatentName(this.patentName);
        obj.setPatentNumber(this.patentNumber);
        obj.setPatentType(this.patentType);
        obj.setRanking(this.ranking);
        obj.setIsAttorn(this.isAttorn);
        obj.setAttornMoney(this.attornMoney);
        obj.setStatus(this.status);
        obj.setLockStatus(this.lockStatus);
        return obj;
    }
}