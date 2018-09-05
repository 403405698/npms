package com.yy.young.pms.service.impl;

import com.yy.young.common.service.ICommonService;
import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.dal.util.Page;
import com.yy.young.pms.model.PmsLeaderEvaluation;
import com.yy.young.pms.util.PmsConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 领导评价表服务实现
 * Created by rookie on 2018-03-27.
 */
@Service("pmsLeaderEvaluationService")
public class PmsLeaderEvaluationServiceImpl implements ICommonService<PmsLeaderEvaluation> {

    @Resource(name = "dataAccessService")
    IDataAccessService dataAccessService;//数据层服务

    private static final Logger logger = LoggerFactory.getLogger(PmsLeaderEvaluationServiceImpl.class);

    //获取数据列表
    @Override
    public List<PmsLeaderEvaluation> getList(PmsLeaderEvaluation pmsLeaderEvaluation) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_LEADER_EVALUATION + ".getPmsLeaderEvaluationList", pmsLeaderEvaluation);
    }

    //获取数据列表(分页)
    @Override
    public List<PmsLeaderEvaluation> getPage(PmsLeaderEvaluation pmsLeaderEvaluation, Page page) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_LEADER_EVALUATION + ".getPmsLeaderEvaluationList", pmsLeaderEvaluation, page);
    }

    //查询单条
    @Override
    public PmsLeaderEvaluation get(PmsLeaderEvaluation pmsLeaderEvaluation) throws Exception {
        return (PmsLeaderEvaluation)dataAccessService.getObject(PmsConstants.MAPPER.PMS_LEADER_EVALUATION + ".getPmsLeaderEvaluationById", pmsLeaderEvaluation);
    }

    //修改
    @Override
    public int update(PmsLeaderEvaluation pmsLeaderEvaluation) throws Exception {
        return dataAccessService.update(PmsConstants.MAPPER.PMS_LEADER_EVALUATION + ".update", pmsLeaderEvaluation);
    }

    //批量删除
    @Override
    public int delete(String[] idArr) throws Exception {
        int i = 0;
        for(String id : idArr){
            i += this.delete(id);
        }
        return i;
    }

    //删除单条
    @Override
    public int delete(String id) throws Exception {
        return dataAccessService.delete(PmsConstants.MAPPER.PMS_LEADER_EVALUATION + ".delete", id);
    }

    //插入
    @Override
    public int insert(PmsLeaderEvaluation pmsLeaderEvaluation) throws Exception {
        if (StringUtils.isBlank(pmsLeaderEvaluation.getId())){//未传入id则默认使用uuid作为主键
            pmsLeaderEvaluation.setId(CommonUtil.getUUID());
        }
        return dataAccessService.insert(PmsConstants.MAPPER.PMS_LEADER_EVALUATION + ".insert", pmsLeaderEvaluation);
    }

    //批量插入
    @Override
    public int batchInsert(List<PmsLeaderEvaluation> list) throws Exception {
        int i = 0;
        for(PmsLeaderEvaluation item : list){
            i += this.insert(item);
        }
        return i;
    }

}