package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
import java.util.Date;
/**
* 家庭成员和社会关系实体类
* Created by rookie on 2018-5-27.
*/
public class Relation{

    @ExcelColumn(value = "主键", order = 1)
    private String id;//主键

    @ExcelColumn(value = "人员编号", order = 2)
    private String userId;//人员编号

    @ExcelColumn(value = "关系类型,家庭成员/社会关系", order = 3)
    private String stype;//关系类型,家庭成员/社会关系

    @ExcelColumn(value = "关系", order = 4)
    private String relation;//关系

    @ExcelColumn(value = "姓名", order = 5)
    private String name;//姓名

    @ExcelColumn(value = "性别", order = 6)
    private String sex;//性别

    @ExcelColumn(value = "出生年月", order = 7)
    private String birthday;//出生年月

    @ExcelColumn(value = "工作单位", order = 8)
    private String unit;//工作单位

    @ExcelColumn(value = "联系电话", order = 9)
    private String tel;//联系电话

    @ExcelColumn(value = "显示顺序", order = 10)
    private Integer num;//显示顺序

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

    public Relation(){
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
    public String getStype() {
        return stype;
    }
    public void setStype(String stype) {
        this.stype = stype;
    }
    public String getRelation() {
        return relation;
    }
    public void setRelation(String relation) {
        this.relation = relation;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getSex() {
        return sex;
    }
    public void setSex(String sex) {
        this.sex = sex;
    }
    public String getBirthday() {
        return birthday;
    }
    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }
    public String getUnit() {
        return unit;
    }
    public void setUnit(String unit) {
        this.unit = unit;
    }
    public Integer getNum() {
        return num;
    }
    public void setNum(Integer num) {
        this.num = num;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }


    public AuditPmsRelations toAnother() {
        AuditPmsRelations relation = new AuditPmsRelations();
        relation.setId(this.id);
        relation.setUserId(this.userId);
        relation.setStype(this.stype);
        relation.setRelation(this.relation);
        relation.setName(this.name);
        relation.setSex(this.sex);
        relation.setBirthday(this.birthday);
        relation.setUnit(this.unit);
        relation.setTel(this.tel);
        relation.setNum(this.num);
        relation.setStatus(this.status);
        relation.setLockStatus(this.lockStatus);
        return relation;
    }
}