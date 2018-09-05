package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
/**
 * 出版著作实体类
 * Created by rookie on 2018-03-27.
 */
public class Publish{


    @ExcelColumn(value = "编号，主键，无意义", order = 1)
    private String id;//编号，主键，无意义

    @ExcelColumn(value = "用户编号", order = 2)
    private String userId;//用户编号

    @ExcelColumn(value = "序号", order = 3)
    private String serialNumber;//序号

    @ExcelColumn(value = "年月", order = 4)
    private String years;//年月

    @ExcelColumn(value = "书名", order = 5)
    private String bookName;//书名

    @ExcelColumn(value = "出版社", order = 6)
    private String press;//出版社

    @ExcelColumn(value = "著作类型", order = 7)
    private String workType;//著作类型

    @ExcelColumn(value = "排名", order = 8)
    private String ranking;//排名

    @ExcelColumn(value = "撰写章节", order = 9)
    private String writeChapter;//撰写章节

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
    public String getBookName() {
        return bookName;
    }
    public void setBookName(String bookName) {
        this.bookName = bookName;
    }
    public String getPress() {
        return press;
    }
    public void setPress(String press) {
        this.press = press;
    }
    public String getWorkType() {
        return workType;
    }
    public void setWorkType(String workType) {
        this.workType = workType;
    }
    public String getRanking() {
        return ranking;
    }
    public void setRanking(String ranking) {
        this.ranking = ranking;
    }
    public String getWriteChapter() {
        return writeChapter;
    }
    public void setWriteChapter(String writeChapter) {
        this.writeChapter = writeChapter;
    }

    public AuditPmsPublish toAnother() {
        AuditPmsPublish obj = new AuditPmsPublish();
        obj.setId(this.id);
        obj.setUserId(this.userId);
        obj.setSerialNumber(this.serialNumber);
        obj.setYears(this.years);
        obj.setBookName(this.bookName);
        obj.setPress(this.press);
        obj.setWorkType(this.workType);
        obj.setRanking(this.ranking);
        obj.setWriteChapter(this.writeChapter);
        obj.setStatus(this.status);
        obj.setLockStatus(this.lockStatus);
        return obj;
    }
}