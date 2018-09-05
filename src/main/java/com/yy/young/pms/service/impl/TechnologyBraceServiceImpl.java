package com.yy.young.pms.service.impl;

import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.dal.util.Page;
import com.yy.young.pms.model.TechnologyBrace;
import com.yy.young.pms.util.PmsConstants;
import com.yy.young.common.service.ICommonService;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.annotation.Resource;
import java.util.List;

/**
 * 技术支撑信息服务实现
 * Created by rookie on 2018-03-27.
 */
@Service("technologyBraceService")
public class TechnologyBraceServiceImpl implements ICommonService<TechnologyBrace> {

    @Resource(name = "dataAccessService")
    IDataAccessService dataAccessService;//数据层服务

    private static final Logger logger = LoggerFactory.getLogger(TechnologyBraceServiceImpl.class);

    //获取数据列表
    @Override
    public List<TechnologyBrace> getList(TechnologyBrace technologyBrace) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_TECHNOLOGY_BRACE + ".getTechnologyBraceList", technologyBrace);
    }

    //获取数据列表(分页)
    @Override
    public List<TechnologyBrace> getPage(TechnologyBrace technologyBrace, Page page) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_TECHNOLOGY_BRACE + ".getTechnologyBraceList", technologyBrace, page);
    }

    //查询单条
    @Override
    public TechnologyBrace get(TechnologyBrace technologyBrace) throws Exception {
        return (TechnologyBrace)dataAccessService.getObject(PmsConstants.MAPPER.PMS_TECHNOLOGY_BRACE + ".getTechnologyBraceById", technologyBrace);
    }

    //修改
    @Override
    public int update(TechnologyBrace technologyBrace) throws Exception {
        return dataAccessService.update(PmsConstants.MAPPER.PMS_TECHNOLOGY_BRACE + ".update", technologyBrace);
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
        return dataAccessService.delete(PmsConstants.MAPPER.PMS_TECHNOLOGY_BRACE + ".delete", id);
    }

    //插入
    @Override
    public int insert(TechnologyBrace technologyBrace) throws Exception {
        if (StringUtils.isBlank(technologyBrace.getId())){//未传入id则默认使用uuid作为主键
            technologyBrace.setId(CommonUtil.getUUID());
        }
        return dataAccessService.insert(PmsConstants.MAPPER.PMS_TECHNOLOGY_BRACE + ".insert", technologyBrace);
    }

    //批量插入
    @Override
    public int batchInsert(List<TechnologyBrace> list) throws Exception {
        int i = 0;
        for(TechnologyBrace item : list){
            i += this.insert(item);
        }
        return i;
    }

}