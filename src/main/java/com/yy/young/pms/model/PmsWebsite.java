package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;

/**
 * @author hu_xuanhua_hua
 * @ClassName: Website
 * @Description: TODO
 * @date 2018-09-03 22:05
 * @versoin 1.0
 **/
public class PmsWebsite {
    @ExcelColumn(value = "编号，主键，无意义", order = 1)
    private String id;//编号，主键，无意义

    @ExcelColumn(value = "用户编号", order = 2)
    private String userId;//用户编号

    @ExcelColumn(value = "中文名字", order = 3)
    private String chinese_name;

    @ExcelColumn(value = "网址", order = 4)
    private String website;
    @ExcelColumn(value = "添加时间", order = 5)
    private String add_time;
    @ExcelColumn(value = "排序", order = 5)
    private Integer sort;

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

    public String getChinese_name() {
        return chinese_name;
    }

    public void setChinese_name(String chinese_name) {
        this.chinese_name = chinese_name;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getAdd_time() {
        return add_time;
    }

    public void setAdd_time(String add_time) {
        this.add_time = add_time;
    }

    public AuditPmsWebsite toAnother() {
        AuditPmsWebsite obj = new AuditPmsWebsite();
        obj.setId(this.id);
        obj.setUserId(this.userId);
        obj.setChinese_name(this.chinese_name);
        obj.setWebsite(this.website);
        this.setAdd_time(this.add_time);
        obj.setSort(this.sort);
        return obj;
    }
}
