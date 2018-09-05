package com.yy.young.pms.service;

import com.yy.young.interfaces.ums.model.Dept;
import com.yy.young.pms.model.PmsDictionary;
import com.yy.young.pms.model.Statistic;
import com.yy.young.pms.model.UserDept;

import java.util.List;

/**
 * 统计服务
 * Created by rookie on 2018/4/5.
 */
public interface IStatisticService {
    /**
     * 查询人才梯队建设
     * @param statistic
     * @return
     * @throws Exception
     */
    public Statistic getTalentEchelon(Statistic statistic) throws Exception;

    /**
     * 查询研究领域情况
     * @param statistic
     * @return
     * @throws Exception
     */
    public Statistic getResearchField(Statistic statistic) throws Exception;

    /**
     * 查询男女比例情况
     * @param statistic
     * @return
     * @throws Exception
     */
    public Statistic getMenAndWomen(Statistic statistic) throws Exception;

    /**
     * 查询学历分布情况
     * @param statistic
     * @return
     * @throws Exception
     */
    public Statistic getEducationSpread(Statistic statistic) throws Exception;

    /**
     * 查询国外经历情况
     * @param statistic
     * @return
     * @throws Exception
     */
    public Statistic getForeignExperience(Statistic statistic) throws Exception;


    /**
     * 查询工作年限情况
     * @param statistic
     * @return
     * @throws Exception
     */
    public Statistic getWorkYear(Statistic statistic) throws Exception;

    /**
     * 查询奖励层次情况
     * @param statistic
     * @return
     * @throws Exception
     */
    public Statistic getAwardLevel(Statistic statistic) throws Exception;

    /**
     * 查询系统内所有用户数量
     * @param statistic
     * @return
     * @throws Exception
     */
    public Statistic getAllUserCount(Statistic statistic) throws Exception;

    /**
     * 查询系统内录入的所有人数
     * @param statistic
     * @return
     * @throws Exception
     */
    public Statistic getSystemInputCount(Statistic statistic) throws Exception;


    /**
     * 查询系统内所有科技奖数量
     * @param statistic
     * @return
     * @throws Exception
     */
    public Statistic getAllTechAwardsCount(Statistic statistic) throws Exception;


    /**
     * 查询所有一级单位列表
     * @return
     * @throws Exception
     */
    public List<UserDept> getDeptList(String roleName,String deptName) throws Exception;

    /**
     * 获取数据字典值
     * @return
     * @throws Exception
     */
    public List<PmsDictionary> getDicValue(PmsDictionary  dic) throws Exception;

    /**
     * 获取到部门完整名称
     * @return
     * @throws Exception
     */
    public UserDept getWholeName(UserDept dept) throws Exception;

    /**
     * 获取到部门完整编号
     * @return
     * @throws Exception
     */
    public UserDept getWholeId(UserDept dept) throws Exception;

}
