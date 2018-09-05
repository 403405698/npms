package com.yy.young.pms.model;

/**
 * 用户部门实体类
 * Created by rookie on 2018-04-14.
 */
public class UserDept{

    private String id;//id
    private String deptId;//deptId
    private String deptName;//deptName
    private String userId;//userId
    private Integer deptLevel;
    private String wholeName;
    private String wholeId;


    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getDeptId() {
        return deptId;
    }
    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }
    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public String getDeptName() {
        return deptName;
    }
    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public Integer getDeptLevel() {
        return deptLevel;
    }

    public void setDeptLevel(Integer deptLevel) {
        this.deptLevel = deptLevel;
    }

    public String getWholeName() {
        return wholeName;
    }

    public void setWholeName(String wholeName) {
        this.wholeName = wholeName;
    }

    public String getWholeId() {
        return wholeId;
    }

    public void setWholeId(String wholeId) {
        this.wholeId = wholeId;
    }
}