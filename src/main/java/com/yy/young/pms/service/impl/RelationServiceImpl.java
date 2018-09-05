package com.yy.young.pms.service.impl;

import com.yy.young.base.exception.ParameterException;
import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.dal.util.Page;
import com.yy.young.pms.model.Relation;
import com.yy.young.pms.service.IRelationService;
import com.yy.young.pms.util.PmsConstants;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.annotation.Resource;
import java.util.List;

/**
* 家庭成员和社会关系服务实现
* Created by rookie on 2018-04-03.
*/
@Service("relationService")
public class RelationServiceImpl implements IRelationService {

    @Resource(name = "dataAccessService")
    IDataAccessService dataAccessService;//数据层服务

    private static final Logger logger = LoggerFactory.getLogger(RelationServiceImpl.class);

    private static final String MAPPER = PmsConstants.MAPPER.PMS_RELATIONS;//mapper的namespace

    //获取数据列表
    @Override
    public List<Relation> getList(Relation obj) throws Exception {
        return dataAccessService.getList(MAPPER + ".getList", obj);
    }

    //获取数据列表(分页)
    @Override
    public List<Relation> getPage(Relation obj, Page page) throws Exception {
        return dataAccessService.getList(MAPPER + ".getList", obj, page);
    }

    //查询单条
    @Override
    public Relation get(String id) throws Exception {
        return (Relation)dataAccessService.getObject(MAPPER + ".get", id);
    }

    //统计数量
    @Override
    public int count(Relation obj) throws Exception {
        return (Integer)dataAccessService.getObject(MAPPER + ".count", obj);
    }

    //修改
    @Override
    public int update(Relation obj) throws Exception {
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
    public int insert(Relation obj) throws Exception {
        if (StringUtils.isBlank(obj.getUserId())){
            throw new ParameterException("人员编号无效!");
        }
        if (StringUtils.isBlank(obj.getId())){
            obj.setId(CommonUtil.getUUID());
        }
        if (obj.getNum() == null){
            obj.setNum(99);
        }
        return dataAccessService.insert(MAPPER + ".insert", obj);
    }

    //批量插入
    @Override
    public int batchInsert(List<Relation> list) throws Exception {
        int i = 0;
        for(Relation item : list){
            i += this.insert(item);
        }
        return i;
    }

}