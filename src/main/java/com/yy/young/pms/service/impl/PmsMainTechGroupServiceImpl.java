package com.yy.young.pms.service.impl;

import com.yy.young.common.service.ICommonService;
import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.dal.util.Page;
import com.yy.young.pms.model.PmsMainTechGroup;
import com.yy.young.pms.util.PmsConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 主要专业技术团体/机构任/兼职表服务实现
 * Created by rookie on 2018-03-27.
 */
@Service("pmsMainTechGroupService")
public class PmsMainTechGroupServiceImpl implements ICommonService<PmsMainTechGroup> {

    @Resource(name = "dataAccessService")
    IDataAccessService dataAccessService;//数据层服务

    private static final Logger logger = LoggerFactory.getLogger(PmsMainTechGroupServiceImpl.class);

    //获取数据列表
    @Override
    public List<PmsMainTechGroup> getList(PmsMainTechGroup pmsMainTechGroup) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_MAIN_TECH_GROUP + ".getPmsMainTechGroupList", pmsMainTechGroup);
    }

    //获取数据列表(分页)
    @Override
    public List<PmsMainTechGroup> getPage(PmsMainTechGroup pmsMainTechGroup, Page page) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_MAIN_TECH_GROUP + ".getPmsMainTechGroupList", pmsMainTechGroup, page);
    }

    //查询单条
    @Override
    public PmsMainTechGroup get(PmsMainTechGroup pmsMainTechGroup) throws Exception {
        return (PmsMainTechGroup)dataAccessService.getObject(PmsConstants.MAPPER.PMS_MAIN_TECH_GROUP + ".getPmsMainTechGroupById", pmsMainTechGroup);
    }

    //修改
    @Override
    public int update(PmsMainTechGroup pmsMainTechGroup) throws Exception {
        return dataAccessService.update(PmsConstants.MAPPER.PMS_MAIN_TECH_GROUP + ".update", pmsMainTechGroup);
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
        return dataAccessService.delete(PmsConstants.MAPPER.PMS_MAIN_TECH_GROUP + ".delete", id);
    }

    //插入
    @Override
    public int insert(PmsMainTechGroup pmsMainTechGroup) throws Exception {
        if (StringUtils.isBlank(pmsMainTechGroup.getId())){//未传入id则默认使用uuid作为主键
            pmsMainTechGroup.setId(CommonUtil.getUUID());
        }
        return dataAccessService.insert(PmsConstants.MAPPER.PMS_MAIN_TECH_GROUP + ".insert", pmsMainTechGroup);
    }

    //批量插入
    @Override
    public int batchInsert(List<PmsMainTechGroup> list) throws Exception {
        int i = 0;
        for(PmsMainTechGroup item : list){
            i += this.insert(item);
        }
        return i;
    }

}