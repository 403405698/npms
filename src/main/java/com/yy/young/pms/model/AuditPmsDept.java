package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
import java.util.Date;
/**
* xxx实体类
* Created by rookie on 2018-6-29.
*/
public class AuditPmsDept{

    @ExcelColumn(value = "编号，主键，无意义", order = 1)
    private String id;//编号，主键，无意义

    @ExcelColumn(value = "部门编号", order = 2)
    private String deptId;//部门编号

    @ExcelColumn(value = "部门名称", order = 3)
    private String deptName;//部门名称

    @ExcelColumn(value = "部门类型", order = 4)
    private String deptType;//部门类型

    @ExcelColumn(value = "部门地址", order = 5)
    private String deptAddress;//部门地址

    @ExcelColumn(value = "itemId", order = 6)
    private String itemId;//itemId

    @ExcelColumn(value = "status", order = 7)
    private Integer status;//status

    public AuditPmsDept(){
        super();
    }

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
    public String getDeptName() {
        return deptName;
    }
    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
    public String getDeptType() {
        return deptType;
    }
    public void setDeptType(String deptType) {
        this.deptType = deptType;
    }
    public String getDeptAddress() {
        return deptAddress;
    }
    public void setDeptAddress(String deptAddress) {
        this.deptAddress = deptAddress;
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

}