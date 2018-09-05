package com.yy.young.pms.service.impl;

import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.dal.util.Page;
import com.yy.young.pms.model.Patent;
import com.yy.young.pms.util.PmsConstants;
import com.yy.young.common.service.ICommonService;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.annotation.Resource;
import java.util.List;

/**
 * 专利服务实现
 * Created by rookie on 2018-03-27.
 */
@Service("patentService")
public class PatentServiceImpl implements ICommonService<Patent> {

    @Resource(name = "dataAccessService")
    IDataAccessService dataAccessService;//数据层服务

    private static final Logger logger = LoggerFactory.getLogger(PatentServiceImpl.class);

    //获取数据列表
    @Override
    public List<Patent> getList(Patent patent) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_PATENT + ".getPatentList", patent);
    }

    //获取数据列表(分页)
    @Override
    public List<Patent> getPage(Patent patent, Page page) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_PATENT + ".getPatentList", patent, page);
    }

    //查询单条
    @Override
    public Patent get(Patent patent) throws Exception {
        return (Patent)dataAccessService.getObject(PmsConstants.MAPPER.PMS_PATENT + ".getPatentById", patent);
    }

    //修改
    @Override
    public int update(Patent patent) throws Exception {
        return dataAccessService.update(PmsConstants.MAPPER.PMS_PATENT + ".update", patent);
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
        return dataAccessService.delete(PmsConstants.MAPPER.PMS_PATENT + ".delete", id);
    }

    //插入
    @Override
    public int insert(Patent patent) throws Exception {
        if (StringUtils.isBlank(patent.getId())){//未传入id则默认使用uuid作为主键
            patent.setId(CommonUtil.getUUID());
        }
        return dataAccessService.insert(PmsConstants.MAPPER.PMS_PATENT + ".insert", patent);
    }

    //批量插入
    @Override
    public int batchInsert(List<Patent> list) throws Exception {
        int i = 0;
        for(Patent item : list){
            i += this.insert(item);
        }
        return i;
    }

}