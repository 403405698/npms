package com.yy.young.pms.model;

import com.yy.young.common.core.excel.ExcelColumn;
import java.util.Date;
/**
* xxx实体类
* Created by rookie on 2018-7-18.
*/
public class AuditRecordBaseinfo{

    @ExcelColumn(value = "id", order = 1)
    private String id;//id

    @ExcelColumn(value = "fieldKey", order = 2)
    private String fieldKey;//fieldKey

    @ExcelColumn(value = "fieldVal", order = 3)
    private String fieldVal;//fieldVal

    @ExcelColumn(value = "userId", order = 4)
    private String userId;//userId

    @ExcelColumn(value = "auditStatus", order = 5)
    private Integer auditStatus;//auditStatus

    @ExcelColumn(value = "lockStatus", order = 6)
    private Integer lockStatus;//lockStatus

    @ExcelColumn(value = "itemId", order = 7)
    private Integer itemId;//itemId

    public AuditRecordBaseinfo(){
        super();
    }

    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getFieldKey() {
        return fieldKey;
    }
    public void setFieldKey(String fieldKey) {
        this.fieldKey = fieldKey;
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
    public Integer getAuditStatus() {
        return auditStatus;
    }
    public void setAuditStatus(Integer auditStatus) {
        this.auditStatus = auditStatus;
    }
    public Integer getLockStatus() {
        return lockStatus;
    }
    public void setLockStatus(Integer lockStatus) {
        this.lockStatus = lockStatus;
    }
    public Integer getItemId() {
        return itemId;
    }
    public void setItemId(Integer itemId) {
        this.itemId = itemId;
    }

    public PmsUser toAnother() {
        PmsUser obj = new PmsUser();
        if (("userName").equals(this.fieldKey)) {
            obj.setUserName(this.fieldVal);
        }
        if (("oldName").equals(this.fieldKey)) {
            obj.setOldName(this.fieldVal);
        }
        if (("sex").equals(this.fieldKey)) {
            obj.setSex(this.fieldVal);
        }
        if (("birth").equals(this.fieldKey)) {
            obj.setBirth(this.fieldVal);
        }
        if (("nation").equals(this.fieldKey)) {
            obj.setNation(this.fieldVal);
        }
        if (("placeOfOrigin").equals(this.fieldKey)) {
            obj.setPlaceOfOrigin(this.fieldVal);
        }
        if (("placeOfBirth").equals(this.fieldKey)) {
            obj.setPlaceOfBirth(this.fieldVal);
        }
        if (("workStartTime").equals(this.fieldKey)) {
            obj.setWorkStartTime(this.fieldVal);
        }
        if (("politicalOutlook").equals(this.fieldKey)) {
            obj.setPoliticalOutlook(this.fieldVal);
        }
        if (("joinPartyTime").equals(this.fieldKey)) {
            obj.setJoinPartyTime(this.fieldVal);
        }
        if (("technicalPosition").equals(this.fieldKey)) {
            obj.setTechnicalPosition(this.fieldVal);
        }
        if (("getTime").equals(this.fieldKey)) {
            obj.setGetTime(this.fieldVal);
        }
        if (("appointmentTime").equals(this.fieldKey)) {
            obj.setAppointmentTime(this.fieldVal);
        }
        if (("technicalLevel").equals(this.fieldKey)) {
            obj.setTechnicalLevel(this.fieldVal);
        }
        if (("administrativeDuty").equals(this.fieldKey)) {
            obj.setAdministrativeDuty(this.fieldVal);
        }
        if (("tenureTime").equals(this.fieldKey)) {
            obj.setTenureTime(this.fieldVal);
        }
        if (("administrativeLevel").equals(this.fieldKey)) {
            obj.setAdministrativeLevel(this.fieldVal);
        }
        if (("researchField").equals(this.fieldKey)) {
            obj.setResearchField(this.fieldVal);
        }
        if (("specialty").equals(this.fieldKey)) {
            obj.setSpecialty(this.fieldVal);
        }
        if (("highestEducation").equals(this.fieldKey)) {
            obj.setHighestEducation(this.fieldVal);
        }
        if (("highestDegree").equals(this.fieldKey)) {
            obj.setHighestDegree(this.fieldVal);
        }
        if (("idCard").equals(this.fieldKey)) {
            obj.setIdCard(this.fieldVal);
        }
        if (("overseasStudyExperience").equals(this.fieldKey)) {
            obj.setOverseasStudyExperience(this.fieldVal);
        }
        if (("englishLevel").equals(this.fieldKey)) {
            obj.setEnglishLevel(this.fieldVal);
        }
        if (("photoAddress").equals(this.fieldKey)) {
            obj.setPhotoAddress(this.fieldVal);
        }
        if (("remark").equals(this.fieldKey)) {
            obj.setRemark(this.fieldVal);
        }
        if (("firstEducation").equals(this.fieldKey)) {
            obj.setFirstEducation(this.fieldVal);
        }
        if (("jobEducation").equals(this.fieldKey)) {
            obj.setJobEducation(this.fieldVal);
        }
        if (("personType").equals(this.fieldKey)) {
            obj.setPersonType(this.fieldVal);
        }
        if (("trashFlag").equals(this.fieldKey)) {
            obj.setTrashFlag(this.fieldVal);
        }
        if (("firstDegree").equals(this.fieldKey)) {
            obj.setFirstDegree(this.fieldVal);
        }
        if (("station").equals(this.fieldKey)) {
            obj.setStation(this.fieldVal);
        }
        if (("takeWork").equals(this.fieldKey)) {
            obj.setTakeWork(this.fieldVal);
        }
        if (("researchFieldDetail").equals(this.fieldKey)) {
            obj.setResearchFieldDetail(this.fieldVal);
        }
        if (("jobDegree").equals(this.fieldKey)) {
            obj.setJobDegree(this.fieldVal);
        }
        if (("tempWorkExperience").equals(this.fieldKey)) {
            obj.setTempWorkExperience(this.fieldVal);
        }
        if (("toThereTime").equals(this.fieldKey)) {
            obj.setToThereTime(this.fieldVal);
        }
        if (("remarkModifyTime").equals(this.fieldKey)) {
            obj.setRemarkModifyTime(this.fieldVal);
        }
//        部门暂且不考虑，用户自己无法更改部门
/*        if (("deptIds").equals(this.field)) {
            obj.setDeptIds(this.fieldVal);
        }*/
/*        if (("deptNames").equals(this.fieldKey)) {
            obj.setDeptNames(this.fieldVal);
        }*/

        return obj;
    }

    public PmsUser noOkItem() {
        PmsUser obj = new PmsUser();
        if (("userName").equals(this.fieldKey)) {
            obj.setUserName("");
        }
        if (("oldName").equals(this.fieldKey)) {
            obj.setOldName("");
        }
        if (("sex").equals(this.fieldKey)) {
            obj.setSex("");
        }
        if (("birth").equals(this.fieldKey)) {
            obj.setBirth("");
        }
        if (("nation").equals(this.fieldKey)) {
            obj.setNation("");
        }
        if (("placeOfOrigin").equals(this.fieldKey)) {
            obj.setPlaceOfOrigin("");
        }
        if (("placeOfBirth").equals(this.fieldKey)) {
            obj.setPlaceOfBirth("");
        }
        if (("workStartTime").equals(this.fieldKey)) {
            obj.setWorkStartTime("");
        }
        if (("politicalOutlook").equals(this.fieldKey)) {
            obj.setPoliticalOutlook("");
        }
        if (("joinPartyTime").equals(this.fieldKey)) {
            obj.setJoinPartyTime("");
        }
        if (("technicalPosition").equals(this.fieldKey)) {
            obj.setTechnicalPosition("");
        }
        if (("getTime").equals(this.fieldKey)) {
            obj.setGetTime("");
        }
        if (("appointmentTime").equals(this.fieldKey)) {
            obj.setAppointmentTime("");
        }
        if (("technicalLevel").equals(this.fieldKey)) {
            obj.setTechnicalLevel("");
        }
        if (("administrativeDuty").equals(this.fieldKey)) {
            obj.setAdministrativeDuty("");
        }
        if (("tenureTime").equals(this.fieldKey)) {
            obj.setTenureTime("");
        }
        if (("administrativeLevel").equals(this.fieldKey)) {
            obj.setAdministrativeLevel("");
        }
        if (("researchField").equals(this.fieldKey)) {
            obj.setResearchField("");
        }
        if (("specialty").equals(this.fieldKey)) {
            obj.setSpecialty("");
        }
        if (("highestEducation").equals(this.fieldKey)) {
            obj.setHighestEducation("");
        }
        if (("highestDegree").equals(this.fieldKey)) {
            obj.setHighestDegree("");
        }
        if (("idCard").equals(this.fieldKey)) {
            obj.setIdCard("");
        }
        if (("overseasStudyExperience").equals(this.fieldKey)) {
            obj.setOverseasStudyExperience("");
        }
        if (("englishLevel").equals(this.fieldKey)) {
            obj.setEnglishLevel("");
        }
        if (("photoAddress").equals(this.fieldKey)) {
            obj.setPhotoAddress("");
        }
        if (("remark").equals(this.fieldKey)) {
            obj.setRemark("");
        }
        if (("firstEducation").equals(this.fieldKey)) {
            obj.setFirstEducation("");
        }
        if (("jobEducation").equals(this.fieldKey)) {
            obj.setJobEducation("");
        }
/*        if (("personType").equals(this.fieldKey)) {
            obj.setPersonType("");
        }*/
/*        if (("trashFlag").equals(this.fieldKey)) {
            obj.setTrashFlag("");
        }*/
        if (("firstDegree").equals(this.fieldKey)) {
            obj.setFirstDegree("");
        }
        if (("station").equals(this.fieldKey)) {
            obj.setStation("");
        }
        if (("takeWork").equals(this.fieldKey)) {
            obj.setTakeWork("");
        }
        if (("researchFieldDetail").equals(this.fieldKey)) {
            obj.setResearchFieldDetail("");
        }
        if (("jobDegree").equals(this.fieldKey)) {
            obj.setJobDegree("");
        }
        if (("tempWorkExperience").equals(this.fieldKey)) {
            obj.setTempWorkExperience("");
        }
        if (("toThereTime").equals(this.fieldKey)) {
            obj.setToThereTime("");
        }
        if (("remarkModifyTime").equals(this.fieldKey)) {
            obj.setRemarkModifyTime("");
        }
//        部门暂且不考虑，用户自己无法更改部门
/*        if (("deptIds").equals(this.field)) {
            obj.setDeptIds(this);
        }*/
/*        if (("deptNames").equals(this.fieldKey)) {
            obj.setDeptNames(this);
        }*/

        return obj;
    }
}