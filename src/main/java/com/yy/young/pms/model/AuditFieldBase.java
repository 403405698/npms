package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
import java.util.Date;
/**
* xxx实体类
* Created by rookie on 2018-7-3.
*/
public class AuditFieldBase{

    @ExcelColumn(value = "id", order = 1)
    private String id;//id

    @ExcelColumn(value = "tableName", order = 2)
    private String tableName;//tableName

    @ExcelColumn(value = "field", order = 3)
    private String field;//field

    @ExcelColumn(value = "fieldVal", order = 4)
    private String fieldVal;//fieldVal

    @ExcelColumn(value = "userId", order = 5)
    private String userId;//userId

    @ExcelColumn(value = "status", order = 6)
    private Integer status;//status

    //增加lock_status
    private Integer lockStatus;
    public Integer getLockStatus() {
        return lockStatus;
    }
    public void setLockStatus(Integer lockStatus) {
        this.lockStatus = lockStatus;
    }

    public AuditFieldBase(){
        super();
    }

    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getTableName() {
        return tableName;
    }
    public void setTableName(String tableName) {
        this.tableName = tableName;
    }
    public String getField() {
        return field;
    }
    public void setField(String field) {
        this.field = field;
    }
    public String getFieldVal() {
        return fieldVal;
    }
    public void setFieldVal(String fieldVal) {
        this.fieldVal = fieldVal;
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

    public PmsUser toAnother() {
        PmsUser obj = new PmsUser();
        if (("userName").equals(this.field)) {
            obj.setUserName(this.fieldVal);
        }
        if (("oldName").equals(this.field)) {
            obj.setOldName(this.fieldVal);
        }
        if (("sex").equals(this.field)) {
            obj.setSex(this.fieldVal);
        }
        if (("birth").equals(this.field)) {
            obj.setBirth(this.fieldVal);
        }
        if (("nation").equals(this.field)) {
            obj.setNation(this.fieldVal);
        }
        if (("placeOfOrigin").equals(this.field)) {
            obj.setPlaceOfOrigin(this.fieldVal);
        }
        if (("placeOfBirth").equals(this.field)) {
            obj.setPlaceOfBirth(this.fieldVal);
        }
        if (("workStartTime").equals(this.field)) {
            obj.setWorkStartTime(this.fieldVal);
        }
        if (("politicalOutlook").equals(this.field)) {
            obj.setPoliticalOutlook(this.fieldVal);
        }
        if (("joinPartyTime").equals(this.field)) {
            obj.setJoinPartyTime(this.fieldVal);
        }
        if (("technicalPosition").equals(this.field)) {
            obj.setTechnicalPosition(this.fieldVal);
        }
        if (("getTime").equals(this.field)) {
            obj.setGetTime(this.fieldVal);
        }
        if (("appointmentTime").equals(this.field)) {
            obj.setAppointmentTime(this.fieldVal);
        }
        if (("technicalLevel").equals(this.field)) {
            obj.setTechnicalLevel(this.fieldVal);
        }
        if (("administrativeDuty").equals(this.field)) {
            obj.setAdministrativeDuty(this.fieldVal);
        }
        if (("tenureTime").equals(this.field)) {
            obj.setTenureTime(this.fieldVal);
        }
        if (("administrativeLevel").equals(this.field)) {
            obj.setAdministrativeLevel(this.fieldVal);
        }
        if (("researchField").equals(this.field)) {
            obj.setResearchField(this.fieldVal);
        }
        if (("specialty").equals(this.field)) {
            obj.setSpecialty(this.fieldVal);
        }
        if (("highestEducation").equals(this.field)) {
            obj.setHighestEducation(this.fieldVal);
        }
        if (("highestDegree").equals(this.field)) {
            obj.setHighestDegree(this.fieldVal);
        }
        if (("idCard").equals(this.field)) {
            obj.setIdCard(this.fieldVal);
        }
        if (("overseasStudyExperience").equals(this.field)) {
            obj.setOverseasStudyExperience(this.fieldVal);
        }
        if (("englishLevel").equals(this.field)) {
            obj.setEnglishLevel(this.fieldVal);
        }
        if (("photoAddress").equals(this.field)) {
            obj.setPhotoAddress(this.fieldVal);
        }
        if (("remark").equals(this.field)) {
            obj.setRemark(this.fieldVal);
        }
        if (("firstEducation").equals(this.field)) {
            obj.setFirstEducation(this.fieldVal);
        }
        if (("jobEducation").equals(this.field)) {
            obj.setJobEducation(this.fieldVal);
        }
        if (("personType").equals(this.field)) {
            obj.setPersonType(this.fieldVal);
        }
        if (("trashFlag").equals(this.field)) {
            obj.setTrashFlag(this.fieldVal);
        }
        if (("firstDegree").equals(this.field)) {
            obj.setFirstDegree(this.fieldVal);
        }
        if (("station").equals(this.field)) {
            obj.setStation(this.fieldVal);
        }
        if (("takeWork").equals(this.field)) {
            obj.setTakeWork(this.fieldVal);
        }
        if (("researchFieldDetail").equals(this.field)) {
            obj.setResearchFieldDetail(this.fieldVal);
        }
        if (("jobDegree").equals(this.field)) {
            obj.setJobDegree(this.fieldVal);
        }
//        部门暂且不考虑，用户自己无法更改部门
/*        if (("deptIds").equals(this.field)) {
            obj.setDeptIds(this.fieldVal);
        }*/
        if (("deptNames").equals(this.field)) {
            obj.setDeptNames(this.fieldVal);
        }

        return obj;
    }

    /**
     * 转为记录实体类
     * @return
     */
    public AuditRecordBaseinfo toRecord() {
        AuditRecordBaseinfo obj = new AuditRecordBaseinfo();
        obj.setId(this.id);
        obj.setFieldKey(this.field);
        obj.setFieldVal(this.fieldVal);
        obj.setUserId(this.userId);
        obj.setAuditStatus(this.status);
        obj.setLockStatus(this.lockStatus);
        return  obj;
    }
}