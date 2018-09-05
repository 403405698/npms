package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
import java.util.Date;
/**
* xxx实体类
* Created by rookie on 2018-7-1.
*/
public class ShowUser{

    @ExcelColumn(value = "id", order = 1)
    private String id;//id

    @ExcelColumn(value = "userId", order = 2)
    private String userId;//userId

    @ExcelColumn(value = "status", order = 3)
    private Integer status;//status

    public ShowUser(){
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
    public Integer getStatus() {
        return status;
    }
    public void setStatus(Integer status) {
        this.status = status;
    }

}