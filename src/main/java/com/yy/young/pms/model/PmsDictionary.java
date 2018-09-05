package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
/**
 * 数据字典表实体类
 * Created by rookie on 2018-04-02.
 */
public class PmsDictionary{


    @ExcelColumn(value = "编号，主键，无意义", order = 1)
    private String id;//编号，主键，无意义

    @ExcelColumn(value = "父编号", order = 2)
    private String pdicId;//父编号

    @ExcelColumn(value = "字典值", order = 3)
    private String dicValue;//字典值

    @ExcelColumn(value = "字典描述", order = 4)
    private String dicDesc;//字典描述

    @ExcelColumn(value = "字典类型", order = 5)
    private String dicType;//字典类型

    @ExcelColumn(value = "字典顺序", order = 6)
    private String dicNum;//字典顺序

    @ExcelColumn(value = "数据字典简称编号", order = 7)
    private String bedicId;//数据字典简称编号

    @ExcelColumn(value = "备注", order = 8)
    private String remark;//备注
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getPdicId() {
        return pdicId;
    }
    public void setPdicId(String pdicId) {
        this.pdicId = pdicId;
    }
    public String getDicValue() {
        return dicValue;
    }
    public void setDicValue(String dicValue) {
        this.dicValue = dicValue;
    }
    public String getDicDesc() {
        return dicDesc;
    }
    public void setDicDesc(String dicDesc) {
        this.dicDesc = dicDesc;
    }
    public String getDicType() {
        return dicType;
    }
    public void setDicType(String dicType) {
        this.dicType = dicType;
    }
    public String getDicNum() {
        return dicNum;
    }
    public void setDicNum(String dicNum) {
        this.dicNum = dicNum;
    }
    public String getBedicId() {
        return bedicId;
    }
    public void setBedicId(String bedicId) {
        this.bedicId = bedicId;
    }
    public String getRemark() {
        return remark;
    }
    public void setRemark(String remark) {
        this.remark = remark;
    }
}