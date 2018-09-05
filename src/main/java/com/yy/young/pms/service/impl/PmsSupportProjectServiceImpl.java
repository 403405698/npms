package com.yy.young.pms.service.impl;

import com.yy.young.common.service.ICommonService;
import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.dal.util.Page;
import com.yy.young.pms.model.PmsSupportProject;
import com.yy.young.pms.util.PmsConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 入选人才培养计划、资助项目名称表服务实现
 * Created by rookie on 2018-03-27.
 */
@Service("pmsSupportProjectService")
public class PmsSupportProjectServiceImpl implements ICommonService<PmsSupportProject> {

    @Resource(name = "dataAccessService")
    IDataAccessService dataAccessService;//数据层服务

    private static final Logger logger = LoggerFactory.getLogger(PmsSupportProjectServiceImpl.class);

    //获取数据列表
    @Override
    public List<PmsSupportProject> getList(PmsSupportProject pmsSupportProject) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_SUPPORT_PROJECT + ".getPmsSupportProjectList", pmsSupportProject);
    }

    //获取数据列表(分页)
    @Override
    public List<PmsSupportProject> getPage(PmsSupportProject pmsSupportProject, Page page) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_SUPPORT_PROJECT + ".getPmsSupportProjectList", pmsSupportProject, page);
    }

    //查询单条
    @Override
    public PmsSupportProject get(PmsSupportProject pmsSupportProject) throws Exception {
        return (PmsSupportProject)dataAccessService.getObject(PmsConstants.MAPPER.PMS_SUPPORT_PROJECT + ".getPmsSupportProjectById", pmsSupportProject);
    }

    //修改
    @Override
    public int update(PmsSupportProject pmsSupportProject) throws Exception {
        return dataAccessService.update(PmsConstants.MAPPER.PMS_SUPPORT_PROJECT + ".update", pmsSupportProject);
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
        return dataAccessService.delete(PmsConstants.MAPPER.PMS_SUPPORT_PROJECT + ".delete", id);
    }

    //插入
    @Override
    public int insert(PmsSupportProject pmsSupportProject) throws Exception {
        if (StringUtils.isBlank(pmsSupportProject.getId())){//未传入id则默认使用uuid作为主键
            pmsSupportProject.setId(CommonUtil.getUUID());
        }
        return dataAccessService.insert(PmsConstants.MAPPER.PMS_SUPPORT_PROJECT + ".insert", pmsSupportProject);
    }

    //批量插入
    @Override
    public int batchInsert(List<PmsSupportProject> list) throws Exception {
        int i = 0;
        for(PmsSupportProject item : list){
            i += this.insert(item);
        }
        return i;
    }

}