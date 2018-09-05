package com.yy.young.pms.service.impl;

import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.dal.util.Page;
import com.yy.young.pms.model.Education;
import com.yy.young.pms.util.PmsConstants;
import com.yy.young.common.service.ICommonService;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.annotation.Resource;
import java.util.List;

/**
 * 教育经历服务实现
 * Created by rookie on 2018-03-27.
 */
@Service("educationService")
public class EducationServiceImpl implements ICommonService<Education> {

    @Resource(name = "dataAccessService")
    IDataAccessService dataAccessService;//数据层服务

    private static final Logger logger = LoggerFactory.getLogger(EducationServiceImpl.class);

    //获取数据列表
    @Override
    public List<Education> getList(Education education) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_EDUCATION + ".getEducationList", education);
    }

    //获取数据列表(分页)
    @Override
    public List<Education> getPage(Education education, Page page) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_EDUCATION + ".getEducationList", education, page);
    }

    //查询单条
    @Override
    public Education get(Education education) throws Exception {
        return (Education)dataAccessService.getObject(PmsConstants.MAPPER.PMS_EDUCATION + ".getEducationById", education);
    }

    //修改
    @Override
    public int update(Education education) throws Exception {
        return dataAccessService.update(PmsConstants.MAPPER.PMS_EDUCATION + ".update", education);
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
        return dataAccessService.delete(PmsConstants.MAPPER.PMS_EDUCATION + ".delete", id);
    }

    //插入
    @Override
    public int insert(Education education) throws Exception {
        if (StringUtils.isBlank(education.getId())){//未传入id则默认使用uuid作为主键
            education.setId(CommonUtil.getUUID());
        }
        return dataAccessService.insert(PmsConstants.MAPPER.PMS_EDUCATION + ".insert", education);
    }

    //批量插入
    @Override
    public int batchInsert(List<Education> list) throws Exception {
        int i = 0;
        for(Education item : list){
            i += this.insert(item);
        }
        return i;
    }

}