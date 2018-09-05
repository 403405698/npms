package com.yy.young.pms.service.impl.audit;

import com.yy.young.common.util.CommonUtil;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.dal.util.Page;
import com.yy.young.pms.model.AuditFieldSelfeval;
import com.yy.young.pms.service.IAuditFieldSelfevalService;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.annotation.Resource;
import java.util.List;

/**
* xxx服务实现
* Created by rookie on 2018-04-03.
*/
@Service("auditFieldSelfevalService")
public class AuditFieldSelfevalServiceImpl implements IAuditFieldSelfevalService {

    @Resource(name = "auditDataAccessService")
    IDataAccessService dataAccessService;//数据层服务

    private static final Logger logger = LoggerFactory.getLogger(AuditFieldSelfevalServiceImpl.class);

    private static final String MAPPER = "com.yy.young.pms.mapper.auditFieldSelfeval";//mapper的namespace

    //获取数据列表
    @Override
    public List<AuditFieldSelfeval> getList(AuditFieldSelfeval obj) throws Exception {
        return dataAccessService.getList(MAPPER + ".getList", obj);
    }

    //获取数据列表(分页)
    @Override
    public List<AuditFieldSelfeval> getPage(AuditFieldSelfeval obj, Page page) throws Exception {
        return dataAccessService.getList(MAPPER + ".getList", obj, page);
    }

    //查询单条
    @Override
    public AuditFieldSelfeval get(String id) throws Exception {
        return (AuditFieldSelfeval)dataAccessService.getObject(MAPPER + ".get", id);
    }

    //统计数量
    @Override
    public int count(AuditFieldSelfeval obj) throws Exception {
        return (Integer)dataAccessService.getObject(MAPPER + ".count", obj);
    }

    //修改
    @Override
    public int update(AuditFieldSelfeval obj) throws Exception {
        return dataAccessService.update(MAPPER + ".update", obj);
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
        return dataAccessService.delete(MAPPER + ".delete", id);
    }

    //插入
    @Override
    public int insert(AuditFieldSelfeval obj) throws Exception {
        return dataAccessService.insert(MAPPER + ".insert", obj);
    }

    //批量插入
    @Override
    public int batchInsert(List<AuditFieldSelfeval> list) throws Exception {
        int i = 0;
        for(AuditFieldSelfeval item : list){
            i += this.insert(item);
        }
        return i;
    }

}