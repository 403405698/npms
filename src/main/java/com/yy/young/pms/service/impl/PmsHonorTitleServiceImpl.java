package com.yy.young.pms.service.impl;

import com.yy.young.common.service.ICommonService;
import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.dal.util.Page;
import com.yy.young.pms.model.PmsHonorTitle;
import com.yy.young.pms.util.PmsConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 荣誉称号表服务实现
 * Created by rookie on 2018-03-27.
 */
@Service("pmsHonorTitleService")
public class PmsHonorTitleServiceImpl implements ICommonService<PmsHonorTitle> {

    @Resource(name = "dataAccessService")
    IDataAccessService dataAccessService;//数据层服务

    private static final Logger logger = LoggerFactory.getLogger(PmsHonorTitleServiceImpl.class);

    //获取数据列表
    @Override
    public List<PmsHonorTitle> getList(PmsHonorTitle pmsHonorTitle) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_HONOR_TITLE + ".getPmsHonorTitleList", pmsHonorTitle);
    }

    //获取数据列表(分页)
    @Override
    public List<PmsHonorTitle> getPage(PmsHonorTitle pmsHonorTitle, Page page) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_HONOR_TITLE + ".getPmsHonorTitleList", pmsHonorTitle, page);
    }

    //查询单条
    @Override
    public PmsHonorTitle get(PmsHonorTitle pmsHonorTitle) throws Exception {
        return (PmsHonorTitle)dataAccessService.getObject(PmsConstants.MAPPER.PMS_HONOR_TITLE + ".getPmsHonorTitleById", pmsHonorTitle);
    }

    //修改
    @Override
    public int update(PmsHonorTitle pmsHonorTitle) throws Exception {
        return dataAccessService.update(PmsConstants.MAPPER.PMS_HONOR_TITLE + ".update", pmsHonorTitle);
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
        return dataAccessService.delete(PmsConstants.MAPPER.PMS_HONOR_TITLE + ".delete", id);
    }

    //插入
    @Override
    public int insert(PmsHonorTitle pmsHonorTitle) throws Exception {
        if (StringUtils.isBlank(pmsHonorTitle.getId())){//未传入id则默认使用uuid作为主键
            pmsHonorTitle.setId(CommonUtil.getUUID());
        }
        return dataAccessService.insert(PmsConstants.MAPPER.PMS_HONOR_TITLE + ".insert", pmsHonorTitle);
    }

    //批量插入
    @Override
    public int batchInsert(List<PmsHonorTitle> list) throws Exception {
        int i = 0;
        for(PmsHonorTitle item : list){
            i += this.insert(item);
        }
        return i;
    }

}