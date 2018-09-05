package com.yy.young.pms.service.impl;

import com.yy.young.common.service.ICommonService;
import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.dal.util.Page;
import com.yy.young.pms.model.PmsTechAwards;
import com.yy.young.pms.util.PmsConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 科技奖情况表服务实现
 * Created by rookie on 2018-03-27.
 */
@Service("pmsTechAwardsService")
public class PmsTechAwardsServiceImpl implements ICommonService<PmsTechAwards> {

    @Resource(name = "dataAccessService")
    IDataAccessService dataAccessService;//数据层服务

    private static final Logger logger = LoggerFactory.getLogger(PmsTechAwardsServiceImpl.class);

    //获取数据列表
    @Override
    public List<PmsTechAwards> getList(PmsTechAwards pmsTechAwards) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_TECH_AWARDS + ".getPmsTechAwardsList", pmsTechAwards);
    }

    //获取数据列表(分页)
    @Override
    public List<PmsTechAwards> getPage(PmsTechAwards pmsTechAwards, Page page) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_TECH_AWARDS + ".getPmsTechAwardsList", pmsTechAwards, page);
    }

    //查询单条
    @Override
    public PmsTechAwards get(PmsTechAwards pmsTechAwards) throws Exception {
        return (PmsTechAwards)dataAccessService.getObject(PmsConstants.MAPPER.PMS_TECH_AWARDS + ".getPmsTechAwardsById", pmsTechAwards);
    }

    //修改
    @Override
    public int update(PmsTechAwards pmsTechAwards) throws Exception {
        return dataAccessService.update(PmsConstants.MAPPER.PMS_TECH_AWARDS + ".update", pmsTechAwards);
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
        return dataAccessService.delete(PmsConstants.MAPPER.PMS_TECH_AWARDS + ".delete", id);
    }

    //插入
    @Override
    public int insert(PmsTechAwards pmsTechAwards) throws Exception {
        if (StringUtils.isBlank(pmsTechAwards.getId())){//未传入id则默认使用uuid作为主键
            pmsTechAwards.setId(CommonUtil.getUUID());
        }
        return dataAccessService.insert(PmsConstants.MAPPER.PMS_TECH_AWARDS + ".insert", pmsTechAwards);
    }

    //批量插入
    @Override
    public int batchInsert(List<PmsTechAwards> list) throws Exception {
        int i = 0;
        for(PmsTechAwards item : list){
            i += this.insert(item);
        }
        return i;
    }

}