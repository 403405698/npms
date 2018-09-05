package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;

/**
 * 统计模块实体类
 * Created by rookie on 2018-03-27.
 */
public class Statistic {

    @ExcelColumn(value = "属性1", order = 1)
    private String attr1;//属性1

    @ExcelColumn(value = "属性2", order = 2)
    private String attr2;//属性2

    @ExcelColumn(value = "属性3", order = 3)
    private String attr3;//属性3

    @ExcelColumn(value = "属性4", order = 4)
    private String attr4;//属性4

    @ExcelColumn(value = "属性5", order = 5)
    private String attr5;//属性5

    @ExcelColumn(value = "属性6", order = 6)
    private String attr6;//属性6

    @ExcelColumn(value = "属性7", order = 7)
    private String attr7;//属性7

    @ExcelColumn(value = "属性8", order = 8)
    private String attr8;//属性8

    @ExcelColumn(value = "属性9", order = 9)
    private String attr9;//属性9

    @ExcelColumn(value = "属性10", order = 10)
    private String attr10;//属性10


    @ExcelColumn(value = "职称", order = 11)
    private String[] zc;//职称数组

    @ExcelColumn(value = "职务", order = 12)
    private String[] zw;//职务数组

    @ExcelColumn(value = "人员类型", order = 13)
    private String personType;//人员类型

    @ExcelColumn(value = "人员类型数组", order = 14)
    private String[] personTypeArr;//人员类型数组

    public void setAttr1(String attr1) {
        this.attr1 = attr1;
    }

    public void setAttr2(String attr2) {
        this.attr2 = attr2;
    }

    public void setAttr3(String attr3) {
        this.attr3 = attr3;
    }

    public void setAttr4(String attr4) {
        this.attr4 = attr4;
    }

    public void setAttr5(String attr5) {
        this.attr5 = attr5;
    }

    public void setAttr6(String attr6) {
        this.attr6 = attr6;
    }

    public void setAttr7(String attr7) {
        this.attr7 = attr7;
    }

    public void setAttr8(String attr8) {
        this.attr8 = attr8;
    }

    public void setAttr9(String attr9) {
        this.attr9 = attr9;
    }

    public void setAttr10(String attr10) {
        this.attr10 = attr10;
    }

    public String getAttr1() {
        return attr1;
    }

    public String getAttr2() {
        return attr2;
    }

    public String getAttr3() {
        return attr3;
    }

    public String getAttr4() {
        return attr4;
    }

    public String getAttr5() {
        return attr5;
    }

    public String getAttr6() {
        return attr6;
    }

    public String getAttr7() {
        return attr7;
    }

    public String getAttr8() {
        return attr8;
    }

    public String getAttr9() {
        return attr9;
    }

    public String getAttr10() {
        return attr10;
    }

    public String[] getZc() {
        return zc;
    }

    public void setZc(String[] zc) {
        this.zc = zc;
    }

    public String[] getZw() {
        return zw;
    }

    public void setZw(String[] zw) {
        this.zw = zw;
    }

    public String getPersonType() {
        return personType;
    }

    public void setPersonType(String personType) {
        this.personType = personType;
    }

    public String[] getPersonTypeArr() {
        return personTypeArr;
    }

    public void setPersonTypeArr(String[] personTypeArr) {
        this.personTypeArr = personTypeArr;
    }
}