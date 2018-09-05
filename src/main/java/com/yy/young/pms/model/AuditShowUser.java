package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
import java.util.Date;
/**
* xxx实体类
* Created by rookie on 2018-7-4.
*/
public class AuditShowUser{

    @ExcelColumn(value = "id", order = 1)
    private String id;//id

    @ExcelColumn(value = "userId", order = 2)
    private String userId;//userId

    @ExcelColumn(value = "personalShow", order = 3)
    private Integer personalShow;//personalShow

    @ExcelColumn(value = "modelShow", order = 4)
    private Integer modelShow;//modelShow

    private String[] userIdArr;

    public String[] getUserIdArr() {
        return userIdArr;
    }

    public void setUserIdArr(String[] userIdArr) {
        this.userIdArr = userIdArr;
    }

    public AuditShowUser(){
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
    public Integer getPersonalShow() {
        return personalShow;
    }
    public void setPersonalShow(Integer personalShow) {
        this.personalShow = personalShow;
    }
    public Integer getModelShow() {
        return modelShow;
    }
    public void setModelShow(Integer modelShow) {
        this.modelShow = modelShow;
    }

}