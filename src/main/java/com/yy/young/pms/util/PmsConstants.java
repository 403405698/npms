package com.yy.young.pms.util;

/**
 * Created by rookie on 2018/3/27.
 */
public class PmsConstants {
    public static final String DEF_USER_PASSWORD = "craes@2018";//默认密码
    //Mapper配置文件
    public interface MAPPER{
        String PMS_USER = "com.yy.young.pms.mapper.pmsUser";
        String PMS_WEBSITE = "com.yy.young.pms.mapper.pmsWebsite";

        String PMS_COMMUNICATION = "com.yy.young.pms.mapper.communication";
        String PMS_EDUCATION = "com.yy.young.pms.mapper.education";
        String PMS_WORK = "com.yy.young.pms.mapper.work";
        String PMS_PAPER = "com.yy.young.pms.mapper.paper";
        String PMS_PUBLISH = "com.yy.young.pms.mapper.publish";
        String PMS_PATENT = "com.yy.young.pms.mapper.patent";
        String PMS_JOIN_PROJECT = "com.yy.young.pms.mapper.joinProject";
        String PMS_TECHNOLOGY_BRACE = "com.yy.young.pms.mapper.technologyBrace";

        String PMS_TECH_AWARDS = "com.yy.young.pms.mapper.pmsTechAwards";
        String PMS_MAIN_TECH_GROUP = "com.yy.young.pms.mapper.pmsMainTechGroup";
        String PMS_SUPPORT_PROJECT = "com.yy.young.pms.mapper.pmsSupportProject";
        String PMS_HONOR_TITLE = "com.yy.young.pms.mapper.pmsHonorTitle";
        String PMS_YEAR_CHECK = "com.yy.young.pms.mapper.pmsYearCheck";
        String PMS_SELF_EVALUATION = "com.yy.young.pms.mapper.pmsSelfEvaluation";
        String PMS_LEADER_EVALUATION = "com.yy.young.pms.mapper.pmsLeaderEvaluation";
        String PMS_DICTIONARY = "com.yy.young.pms.mapper.pmsDictionary";
        String PMS_STATISTIC = "com.yy.young.pms.mapper.statistic";
        String PMS_USER_DEPT = "com.yy.young.pms.mapper.userDept";
        String PMS_RELATIONS = "com.yy.young.pms.mapper.relation";

        //审核新增start
        String AUDIT_PMS_USER = "com.yy.young.pms.mapper.auditPmsUser";
        String AUDIT_PMS_COMMUNICATION = "com.yy.young.pms.mapper.auditPmsCommunication";
        String AUDIT_PMS_EDUCATION = "com.yy.young.pms.mapper.auditPmsEducation";
        String AUDIT_PMS_WORK = "com.yy.young.pms.mapper.auditPmsWork";
        String AUDIT_PMS_PAPER = "com.yy.young.pms.mapper.auditPmsPaper";
        String AUDIT_PMS_PUBLISH = "com.yy.young.pms.mapper.auditPmsPublish";
        String AUDIT_PMS_PATENT = "com.yy.young.pms.mapper.auditPmsPatent";
        String AUDIT_PMS_JOIN_PROJECT = "com.yy.young.pms.mapper.auditPmsJoinProject";
        String AUDIT_PMS_TECHNOLOGY_BRACE = "com.yy.young.pms.mapper.auditPmsTechnologyBrace";
        String AUDIT_PMS_TECH_AWARDS = "com.yy.young.pms.mapper.auditPmsTechAwards";
        String AUDIT_PMS_MAIN_TECH_GROUP = "com.yy.young.pms.mapper.pmsMainTechGroup";
        String AUDIT_PMS_SUPPORT_PROJECT = "com.yy.young.pms.mapper.auditPmsSupportProject";
        String AUDIT_PMS_HONOR_TITLE = "com.yy.young.pms.mapper.auditPmsHonorTitle";
        String AUDIT_PMS_YEAR_CHECK = "com.yy.young.pms.mapper.auditPmsYearCheck";
        String AUDIT_PMS_SELF_EVALUATION = "com.yy.young.pms.mapper.auditPmsSelfEvaluation";
        String AUDIT_PMS_LEADER_EVALUATION = "com.yy.young.pms.mapper.auditPmsLeaderEvaluation";
        String AUDIT_PMS_DICTIONARY = "com.yy.young.pms.mapper.auditPmsDictionary";
        String AUDIT_PMS_STATISTIC = "com.yy.young.pms.mapper.statistic";
        String AUDIT_PMS_USER_DEPT = "com.yy.young.pms.mapper.userDept";
        String AUDIT_PMS_RELATIONS = "com.yy.young.pms.mapper.auditPmsRelations";
        //审核新增end

    }
    //年龄节点
    public interface AGE{
        int AGE_30 = 30;
        int AGE_35 = 35;
        int AGE_40 = 40;
        int AGE_45 = 45;
        int AGE_50 = 50;
    }
    //环科院单位id
    public static final String HKY_COMPANY_ID = "449143d6374445488e11d6fb2812a730";

    //工龄
    public interface WORK_YEAR{
        int WORK_YEAR_5 = 5;
        int WORK_YEAR_10 = 10;
        int WORK_YEAR_20 = 20;
        int WORK_YEAR_30 = 30;
        int WORK_YEAR_40 = 40;
    }

    //角色名称
    public interface ROLENAME{
        String RSC_ROLE = "人事处";
        String HKYGLY_ROLE = "环科院管理员";
        String EJDWLD_ROLE = "二级单位领导";
        String YLD_ROLE = "院领导";
        String PTYG_ROLE = "普通员工";
    }
}
