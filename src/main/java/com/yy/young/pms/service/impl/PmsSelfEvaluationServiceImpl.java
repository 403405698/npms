package com.yy.young.pms.service.impl;

import com.yy.young.common.service.ICommonService;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.dal.util.Page;
import com.yy.young.pms.model.PmsSelfEvaluation;
import com.yy.young.pms.util.PmsConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.net.URLDecoder;
import java.util.List;

/**
 * 自我评价表服务实现
 * Created by rookie on 2018-03-27.
 */
@Service("pmsSelfEvaluationService")
public class PmsSelfEvaluationServiceImpl implements ICommonService<PmsSelfEvaluation> {

    @Resource(name = "dataAccessService")
    IDataAccessService dataAccessService;//数据层服务

    private static final Logger logger = LoggerFactory.getLogger(PmsSelfEvaluationServiceImpl.class);

    //获取数据列表
    @Override
    public List<PmsSelfEvaluation> getList(PmsSelfEvaluation pmsSelfEvaluation) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_SELF_EVALUATION + ".getPmsSelfEvaluationList", pmsSelfEvaluation);
    }

    //获取数据列表(分页)
    @Override
    public List<PmsSelfEvaluation> getPage(PmsSelfEvaluation pmsSelfEvaluation, Page page) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_SELF_EVALUATION + ".getPmsSelfEvaluationList", pmsSelfEvaluation, page);
    }

    //查询单条
    @Override
    public PmsSelfEvaluation get(PmsSelfEvaluation pmsSelfEvaluation) throws Exception {
        if (StringUtils.isNotBlank(pmsSelfEvaluation.getId()) && pmsSelfEvaluation.getId().indexOf("%") > -1){
            pmsSelfEvaluation.setId(URLDecoder.decode(pmsSelfEvaluation.getId(), "UTF-8"));
        }
        return (PmsSelfEvaluation)dataAccessService.getObject(PmsConstants.MAPPER.PMS_SELF_EVALUATION + ".getPmsSelfEvaluationById", pmsSelfEvaluation);
    }

    //修改
    @Override
    public int update(PmsSelfEvaluation pmsSelfEvaluation) throws Exception {
        return dataAccessService.update(PmsConstants.MAPPER.PMS_SELF_EVALUATION + ".update", pmsSelfEvaluation);
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
        return dataAccessService.delete(PmsConstants.MAPPER.PMS_SELF_EVALUATION + ".delete", id);
    }

    //插入
    @Override
    public int insert(PmsSelfEvaluation pmsSelfEvaluation) throws Exception {
        return dataAccessService.insert(PmsConstants.MAPPER.PMS_SELF_EVALUATION + ".insert", pmsSelfEvaluation);
    }

    //批量插入
    @Override
    public int batchInsert(List<PmsSelfEvaluation> list) throws Exception {
        int i = 0;
        for(PmsSelfEvaluation item : list){
            i += this.insert(item);
        }
        return i;
    }

}