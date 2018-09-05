package com.yy.young.pms.service.impl;

import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.pms.model.PmsDictionary;
import com.yy.young.pms.model.Statistic;
import com.yy.young.pms.model.UserDept;
import com.yy.young.pms.service.IStatisticService;
import com.yy.young.pms.util.PmsConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 人事统计服务实现
 * Created by rookie on 2018-03-27.
 */
@Service("pmsStatisticService")
public class PmsStatisticServiceImpl  implements IStatisticService {

    @Resource(name = "dataAccessService")
    IDataAccessService dataAccessService;//数据层服务

    private static final Logger logger = LoggerFactory.getLogger(PmsStatisticServiceImpl.class);

    /**
     * 查询人才梯队建设
     * @param statistic
     * @return
     * @throws Exception
     */
    @Override
    public Statistic getTalentEchelon(Statistic statistic) throws Exception {

        //存储部门编号
        String deptId = statistic.getAttr10();

        //存储职称
        String zcStr = statistic.getAttr9();
        String[] zcs = null;
        if(StringUtils.isNotBlank(zcStr)){
            zcs = zcStr.split(",");
        }

        //存储职务
        String zwStr = statistic.getAttr8();
        String[] zws = null;
        if(StringUtils.isNotBlank(zwStr)){
            zws = zwStr.split(",");
        }

        //存储人员类型
        String personTypeStr = statistic.getPersonType();
        String[] personTypes = null;
        if(StringUtils.isNotBlank(personTypeStr)){
            personTypes = personTypeStr.split(",");
        }

        //创建返回Bean
        Statistic returnStatistic = new Statistic();
        //得到当前日期
        Date day=new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy");
        //得到当前日期
        int currentDate = Integer.parseInt(df.format(day));
        System.out.println("当前日期：" +currentDate);
        if(!StringUtils.isNotBlank(currentDate+"")){
            logger.info("[人事统计-人才梯队查询]当前年份获取失败！");
        }
        //得到出生日期节点
        int attr0 = 3000;//设置为公元3000
        int attr1 = currentDate - PmsConstants.AGE.AGE_30;//1988
        int attr2 = currentDate - PmsConstants.AGE.AGE_35;//1983
        int attr3 = currentDate - PmsConstants.AGE.AGE_40;//1978
        int attr4 = currentDate - PmsConstants.AGE.AGE_45;//1972
        int attr5 = currentDate - PmsConstants.AGE.AGE_50;//1967
        int attr6 = 1900;//设置为公元1900
        //select (select count(*) from pms_user where birth>'1988' and birth < '2002')
        //查询30岁以下的数量
        statistic.setAttr1(attr1+"");
        statistic.setAttr2(attr0+"");
        statistic.setAttr10(deptId);//部门编号
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("数量："+attr1+"参数2："+attr0+"设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic = (Statistic)dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getTalentEchelon", statistic);
        returnStatistic.setAttr1(statistic.getAttr1());
        logger.debug("[查询人才梯队建设,小于30岁人数-"+statistic.getAttr1()+"]");
        //大于30，小于等于35
        statistic.setAttr1(attr2+"");
        statistic.setAttr2(attr1+"");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic = (Statistic)dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getTalentEchelon", statistic);
        returnStatistic.setAttr2(statistic.getAttr1());
        logger.debug("[查询人才梯队建设,小于等于35岁且大于30岁的人数-"+statistic.getAttr1()+"]");
        //大于35，小于等于40
        statistic.setAttr1(attr3+"");
        statistic.setAttr2(attr2+"");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic = (Statistic)dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getTalentEchelon", statistic);
        returnStatistic.setAttr3(statistic.getAttr1());
        logger.debug("[查询人才梯队建设,小于等于40岁且大于35岁的人数-"+statistic.getAttr1()+"]");
        //大于40，小于等于45
        statistic.setAttr1(attr4+"");
        statistic.setAttr2(attr3+"");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic = (Statistic)dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getTalentEchelon", statistic);
        returnStatistic.setAttr4(statistic.getAttr1());
        logger.debug("[查询人才梯队建设,小于等于45岁且大于40岁的人数-"+statistic.getAttr1()+"]");
        //大于45，小于等于50
        statistic.setAttr1(attr5+"");
        statistic.setAttr2(attr4+"");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic = (Statistic)dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getTalentEchelon", statistic);
        returnStatistic.setAttr5(statistic.getAttr1());
        logger.debug("[查询人才梯队建设,小于等于50岁且大于45岁的人数-"+statistic.getAttr1()+"]");
        //大于50
        statistic.setAttr1(attr6+"");
        statistic.setAttr2(attr5+"");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic = (Statistic)dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getTalentEchelon", statistic);
        returnStatistic.setAttr6(statistic.getAttr1());
        logger.debug("[查询人才梯队建设,大于50岁的人数-"+statistic.getAttr1()+"]");
        return returnStatistic;
    }

    /**
     * 查询研究领域情况
     * @param statistic
     * @return
     * @throws Exception
     */
    @Override
    public Statistic getResearchField(Statistic statistic) throws Exception {

        //存储部门编号
        String deptId = statistic.getAttr10();

        //存储职称
        String zcStr = statistic.getAttr9();
        String[] zcs = null;
        if(StringUtils.isNotBlank(zcStr)){
            zcs = zcStr.split(",");
        }

        //存储职务
        String zwStr = statistic.getAttr8();
        String[] zws = null;
        if(StringUtils.isNotBlank(zwStr)){
            zws = zwStr.split(",");
        }

        //存储人员类型
        String personTypeStr = statistic.getPersonType();
        String[] personTypes = null;
        if(StringUtils.isNotBlank(personTypeStr)){
            personTypes = personTypeStr.split(",");
        }

        //创建返回Bean
        Statistic returnStatistic = new Statistic();
        //设置研究领域为大气环境研究
        statistic.setAttr2("大气环境研究");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic =(Statistic) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getResearchField", statistic);
        logger.debug("[查询研究领域情况,获取研究领域数量为-"+statistic.getAttr1()+"]");
        returnStatistic.setAttr1(statistic.getAttr1());

        //设置研究领域为水环境研究
        statistic.setAttr2("水环境研究");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic =(Statistic) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getResearchField", statistic);
        logger.debug("[查询研究领域情况,获取研究领域数量为-"+statistic.getAttr1()+"]");
        returnStatistic.setAttr2(statistic.getAttr1());

        //设置研究领域为生态环境研究
        statistic.setAttr2("生态环境研究");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic =(Statistic) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getResearchField", statistic);
        logger.debug("[查询研究领域情况,获取研究领域数量为-"+statistic.getAttr1()+"]");
        returnStatistic.setAttr3(statistic.getAttr1());

        //设置研究领域为土壤与固体废物环境研究
        statistic.setAttr2("土壤与固体废物环境研究");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic =(Statistic) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getResearchField", statistic);
        logger.debug("[查询研究领域情况,获取研究领域数量为-"+statistic.getAttr1()+"]");
        returnStatistic.setAttr4(statistic.getAttr1());

        //设置研究领域为清洁生产与循环经济环境研究
        statistic.setAttr2("清洁生产与循环经济环境研究");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic =(Statistic) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getResearchField", statistic);
        logger.debug("[查询研究领域情况,获取研究领域数量为-"+statistic.getAttr1()+"]");
        returnStatistic.setAttr5(statistic.getAttr1());

        //设置研究领域为环境安全与健康研究
        statistic.setAttr2("环境安全与健康研究");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic =(Statistic) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getResearchField", statistic);
        logger.debug("[查询研究领域情况,获取研究领域数量为-"+statistic.getAttr1()+"]");
        returnStatistic.setAttr6(statistic.getAttr1());

        //设置研究领域为环境工程和环境影响评价研究
        statistic.setAttr2("环境工程和环境影响评价研究");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic =(Statistic) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getResearchField", statistic);
        logger.debug("[查询研究领域情况,获取研究领域数量为-"+statistic.getAttr1()+"]");
        returnStatistic.setAttr7(statistic.getAttr1());

        //设置研究领域为其他研究
        statistic.setAttr2("其他研究");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic =(Statistic) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getResearchField", statistic);
        logger.debug("[查询研究领域情况,获取研究领域数量为-"+statistic.getAttr1()+"]");
        returnStatistic.setAttr8(statistic.getAttr1());

        return returnStatistic;
    }

    /**
     * 查询男女比例情况
     * @param statistic
     * @return
     * @throws Exception
     */
    @Override
    public Statistic getMenAndWomen(Statistic statistic) throws Exception {

        //存储部门编号
        String deptId = statistic.getAttr10();

        //存储职称
        String zcStr = statistic.getAttr9();
        String[] zcs = null;
        if(StringUtils.isNotBlank(zcStr)){
            zcs = zcStr.split(",");
        }

        //存储职务
        String zwStr = statistic.getAttr8();
        String[] zws = null;
        if(StringUtils.isNotBlank(zwStr)){
            zws = zwStr.split(",");
        }

        //存储人员类型
        String personTypeStr = statistic.getPersonType();
        String[] personTypes = null;
        if(StringUtils.isNotBlank(personTypeStr)){
            personTypes = personTypeStr.split(",");
        }

        //创建返回Bean
        Statistic returnStatistic = new Statistic();
        //设置性别为男
        statistic.setAttr2("男");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic =(Statistic) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getMenAndWomen", statistic);
        logger.debug("[查询男女比例情况,男人数量为-"+statistic.getAttr1()+"]");
        returnStatistic.setAttr1(statistic.getAttr1());
        //设置性别为女
        statistic.setAttr2("女");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic =(Statistic) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getMenAndWomen", statistic);
        logger.debug("[查询男女比例情况,女人数量为-"+statistic.getAttr1()+"]");
        returnStatistic.setAttr2(statistic.getAttr1());
        return returnStatistic;
    }

    /**
     * 查询学历分布情况
     * @param statistic
     * @return
     * @throws Exception
     */
    @Override
    public Statistic getEducationSpread(Statistic statistic) throws Exception {

        //存储部门编号
        String deptId = statistic.getAttr10();

        //存储职称
        String zcStr = statistic.getAttr9();
        String[] zcs = null;
        if(StringUtils.isNotBlank(zcStr)){
            zcs = zcStr.split(",");
        }

        //存储职务
        String zwStr = statistic.getAttr8();
        String[] zws = null;
        if(StringUtils.isNotBlank(zwStr)){
            zws = zwStr.split(",");
        }

        //存储人员类型
        String personTypeStr = statistic.getPersonType();
        String[] personTypes = null;
        if(StringUtils.isNotBlank(personTypeStr)){
            personTypes = personTypeStr.split(",");
        }

        //创建返回Bean
        Statistic returnStatistic = new Statistic();
        //设置学历为小学
        statistic.setAttr2("小学");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic =(Statistic) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getEducationSpread", statistic);
        logger.debug("[查询学历分布情况,获取学历为小学的数量为-"+statistic.getAttr1()+"]");
        returnStatistic.setAttr1(statistic.getAttr1());


        //设置学历为初中
        statistic.setAttr2("初中");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic =(Statistic) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getEducationSpread", statistic);
        logger.debug("[查询学历分布情况,获取学历为初中的数量为-"+statistic.getAttr1()+"]");
        returnStatistic.setAttr2(statistic.getAttr1());

        //设置学历为中专/高中
        statistic.setAttr2("中专/高中");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic =(Statistic) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getEducationSpread", statistic);
        logger.debug("[查询学历分布情况,获取学历为中专/高中的数量为-"+statistic.getAttr1()+"]");
        returnStatistic.setAttr3(statistic.getAttr1());

        //设置学历为专科
        statistic.setAttr2("大专");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic =(Statistic) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getEducationSpread", statistic);
        logger.debug("[查询学历分布情况,获取学历为专科/本科的数量为-"+statistic.getAttr1()+"]");
        returnStatistic.setAttr4(statistic.getAttr1());



        //设置学历为本科
        statistic.setAttr2("大学");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic =(Statistic) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getEducationSpread", statistic);
        logger.debug("[查询学历分布情况,获取学历为专科/本科的数量为-"+statistic.getAttr1()+"]");
        returnStatistic.setAttr5(statistic.getAttr1());



        //设置学历为硕士研究生
        statistic.setAttr2("硕士研究生");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic =(Statistic) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getEducationSpread", statistic);
        logger.debug("[查询学历分布情况,获取学历为硕士研究生的数量为-"+statistic.getAttr1()+"]");
        returnStatistic.setAttr6(statistic.getAttr1());

        //设置学历为博士研究生
        statistic.setAttr2("博士研究生");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic =(Statistic) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getEducationSpread", statistic);
        logger.debug("[查询学历分布情况,获取学历为博士研究生的数量为-"+statistic.getAttr1()+"]");
        returnStatistic.setAttr7(statistic.getAttr1());

        return returnStatistic;
    }

    /**
     * 查询国外经历情况
     * @param statistic
     * @return
     * @throws Exception
     */
    @Override
    public Statistic getForeignExperience(Statistic statistic) throws Exception {
        //存储部门编号
        String deptId = statistic.getAttr10();

        //存储职称
        String zcStr = statistic.getAttr9();
        String[] zcs = null;
        if(StringUtils.isNotBlank(zcStr)){
            zcs = zcStr.split(",");
        }

        //存储职务
        String zwStr = statistic.getAttr8();
        String[] zws = null;
        if(StringUtils.isNotBlank(zwStr)){
            zws = zwStr.split(",");
        }

        //存储人员类型
        String personTypeStr = statistic.getPersonType();
        String[] personTypes = null;
        if(StringUtils.isNotBlank(personTypeStr)){
            personTypes = personTypeStr.split(",");
        }

        //创建返回Bean
        Statistic returnStatistic = new Statistic();
        //设置国外经历为有
        statistic.setAttr2("有");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic =(Statistic) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getForeignExperience", statistic);
        logger.debug("[查询国外经历情况,获取有国外经历数为-"+statistic.getAttr1()+"]");
        returnStatistic.setAttr1(statistic.getAttr1());
        //设置国外经历为无
        statistic.setAttr2("无");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic =(Statistic) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getForeignExperience", statistic);
        logger.debug("[查询国外经历情况,获取没有国外经历数为-"+statistic.getAttr1()+"]");
        returnStatistic.setAttr2(statistic.getAttr1());
        return returnStatistic;
    }


    /**
     * 查询工作年限情况
     * @param statistic
     * @return
     * @throws Exception
     */
    @Override
    public Statistic getWorkYear(Statistic statistic) throws Exception {
        //存储部门编号
        String deptId = statistic.getAttr10();

        //存储职称
        String zcStr = statistic.getAttr9();
        String[] zcs = null;
        if(StringUtils.isNotBlank(zcStr)){
            zcs = zcStr.split(",");
        }

        //存储职务
        String zwStr = statistic.getAttr8();
        String[] zws = null;
        if(StringUtils.isNotBlank(zwStr)){
            zws = zwStr.split(",");
        }

        //存储人员类型
        String personTypeStr = statistic.getPersonType();
        String[] personTypes = null;
        if(StringUtils.isNotBlank(personTypeStr)){
            personTypes = personTypeStr.split(",");
        }

        //创建返回Bean
        Statistic returnStatistic = new Statistic();
        //得到当前日期
        Date day=new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy");
        //得到当前日期
        int currentDate = Integer.parseInt(df.format(day));
        if(!StringUtils.isNotBlank(currentDate+"")){
            logger.info("[人事统计-工作年限情况查询]当前年份获取失败！");
        }
        //得到出生日期节点
        int attr0 = 3000;//设置为公元3000
        int attr1 = currentDate - PmsConstants.WORK_YEAR.WORK_YEAR_5;//2013
        int attr2 = currentDate - PmsConstants.WORK_YEAR.WORK_YEAR_10;//2008
        int attr3 = currentDate - PmsConstants.WORK_YEAR.WORK_YEAR_20;//1998
        int attr4 = currentDate - PmsConstants.WORK_YEAR.WORK_YEAR_30;//1988
        int attr5 = currentDate - PmsConstants.WORK_YEAR.WORK_YEAR_40;//1978
        int attr6 = 1900;//设置为公元1900
        //select (select count(*) from pms_user where birth>'1988' and birth < '2002')
        //查询30岁以下的数量
        statistic.setAttr1(attr1+"");
        statistic.setAttr2(attr0+"");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic = (Statistic)dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getWorkYear", statistic);
        returnStatistic.setAttr1(statistic.getAttr1());
        logger.debug("[查询工作年限,小于5年的人数-"+statistic.getAttr1()+"]");

        //大于30，小于等于35
        statistic.setAttr1(attr2+"");
        statistic.setAttr2(attr1+"");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic = (Statistic)dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getWorkYear", statistic);
        returnStatistic.setAttr2(statistic.getAttr1());
        logger.debug("[查询工作年限,小于等于10年且大于5年的人数-"+statistic.getAttr1()+"]");

        //大于35，小于等于40
        statistic.setAttr1(attr3+"");
        statistic.setAttr2(attr2+"");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic = (Statistic)dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getWorkYear", statistic);
        returnStatistic.setAttr3(statistic.getAttr1());
        logger.debug("[查询工作年限,小于等于20年且大于10年的人数-"+statistic.getAttr1()+"]");

        //大于40，小于等于45
        statistic.setAttr1(attr4+"");
        statistic.setAttr2(attr3+"");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic = (Statistic)dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getWorkYear", statistic);
        returnStatistic.setAttr4(statistic.getAttr1());
        logger.debug("[查询工作年限,小于等于30年且大于20年的人数-"+statistic.getAttr1()+"]");

        //大于45，小于等于50
        statistic.setAttr1(attr5+"");
        statistic.setAttr2(attr4+"");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic = (Statistic)dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getWorkYear", statistic);
        returnStatistic.setAttr5(statistic.getAttr1());
        logger.debug("[查询工作年限,小于等于40年且大于30年的人数-"+statistic.getAttr1()+"]");

        //大于50
        statistic.setAttr1(attr6+"");
        statistic.setAttr2(attr5+"");
        statistic.setAttr10(deptId);
        statistic.setZc(zcs);//职称
        statistic.setZw(zws);//职务
        statistic.setPersonTypeArr(personTypes);//人员类型
        logger.debug("设置部门编号-"+statistic.getAttr10()+"，设置职称"+statistic.getZc()+"，设置职务"+statistic.getZw()+"，设置人员类型"+statistic.getPersonType());
        statistic = (Statistic)dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getWorkYear", statistic);
        returnStatistic.setAttr6(statistic.getAttr1());
        logger.debug("[查询工作年限,大于40年的人数-"+statistic.getAttr1()+"]");
        return returnStatistic;
    }

    /**
     * 查询奖励层次情况
     * @param statistic
     * @return
     * @throws Exception
     */
    @Override
    public Statistic getAwardLevel(Statistic statistic) throws Exception {
        //创建返回Bean
        Statistic returnStatistic = new Statistic();
        //设置奖励层次为国家级
        statistic.setAttr2("国家级");
        statistic =(Statistic) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getAwardLevel", statistic);
        logger.debug("[查询奖励层次情况,获取科技奖为国家级数为-"+statistic.getAttr1()+"]");
        returnStatistic.setAttr1(statistic.getAttr1());

        //设置奖励层次为省部级
        statistic.setAttr2("省部级");
        statistic =(Statistic) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getAwardLevel", statistic);
        logger.debug("[查询奖励层次情况,获取科技奖为省部级数为-"+statistic.getAttr1()+"]");
        returnStatistic.setAttr2(statistic.getAttr1());

        //设置奖励层次为厅级及以下
        statistic.setAttr2("厅级及以下");
        statistic =(Statistic) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getAwardLevel", statistic);
        logger.debug("[查询奖励层次情况,获取科技奖为厅级及以下数为-"+statistic.getAttr1()+"]");
        returnStatistic.setAttr3(statistic.getAttr1());

        return returnStatistic;
    }

    /**
     * 查询系统内所有用户数量
     * @param statistic
     * @return
     * @throws Exception
     */
    @Override
    public Statistic getAllUserCount(Statistic statistic) throws Exception {

        //存储部门编号
        String deptId = statistic.getAttr10();
        if(StringUtils.isNotBlank(deptId)){
            statistic.setAttr10(deptId);
        }

        //存储职称
        String zcStr = statistic.getAttr9();
        String[] zcs = null;
        if(StringUtils.isNotBlank(zcStr)){
            zcs = zcStr.split(",");
            statistic.setZc(zcs);
        }

        //存储职务
        String zwStr = statistic.getAttr8();
        String[] zws = null;
        if(StringUtils.isNotBlank(zwStr)){
            zws = zwStr.split(",");
            statistic.setZw(zws);
        }


        return (Statistic)dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getAllUserCount", statistic);
    }

    /**
     * 查询系统内所有录入用户数量
     * @param statistic
     * @return
     * @throws Exception
     */
    @Override
    public Statistic getSystemInputCount(Statistic statistic) throws Exception {
        return (Statistic)dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getSystemInputCount", statistic);
    }

    /**
     * 查询系统内所有科技奖数量
     * @param statistic
     * @return
     * @throws Exception
     */
    @Override
    public Statistic getAllTechAwardsCount(Statistic statistic) throws Exception {
        return (Statistic)dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getAllTechAwardsCount", statistic);
    }

    /**
     * 查询系统内所有一级部门列表
     * @return
     * @throws Exception
     */
    @Override
    public List<UserDept> getDeptList(String roleName,String deptName) throws Exception{
        UserDept dept = new UserDept();
        //设置部门级别
        dept.setDeptLevel(2);

        if ("二级单位领导".equals(roleName)){
            dept.setDeptName(deptName);
        }

        return dataAccessService.getList(PmsConstants.MAPPER.PMS_STATISTIC + ".getDeptList",dept);
    }

    /**
     * 查询数据字典值
     * @return
     * @throws Exception
     */
    @Override
    public List<PmsDictionary> getDicValue(PmsDictionary  dic) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_STATISTIC + ".getDicValue",dic);
    }

    /**
     * 根据deptId查询到whole_name
     * @return
     * @throws Exception
     */
    @Override
    public UserDept getWholeName(UserDept dept) throws Exception {
        return (UserDept)dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getWholeName", dept);
    }

    /**
     * 根据deptId查询到whole_id
     * @return
     * @throws Exception
     */
    @Override
    public UserDept getWholeId(UserDept dept) throws Exception {
        return (UserDept) dataAccessService.getObject(PmsConstants.MAPPER.PMS_STATISTIC + ".getWholeId", dept);
    }

}