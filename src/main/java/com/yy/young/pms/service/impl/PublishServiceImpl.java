package com.yy.young.pms.service.impl;

import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.dal.util.Page;
import com.yy.young.pms.model.Publish;
import com.yy.young.pms.util.PmsConstants;
import com.yy.young.common.service.ICommonService;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.annotation.Resource;
import java.util.List;

/**
 * 出版著作服务实现
 * Created by rookie on 2018-03-27.
 */
@Service("publishService")
public class PublishServiceImpl implements ICommonService<Publish> {

    @Resource(name = "dataAccessService")
    IDataAccessService dataAccessService;//数据层服务

    private static final Logger logger = LoggerFactory.getLogger(PublishServiceImpl.class);

    //获取数据列表
    @Override
    public List<Publish> getList(Publish publish) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_PUBLISH + ".getPublishList", publish);
    }

    //获取数据列表(分页)
    @Override
    public List<Publish> getPage(Publish publish, Page page) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_PUBLISH + ".getPublishList", publish, page);
    }

    //查询单条
    @Override
    public Publish get(Publish publish) throws Exception {
        return (Publish)dataAccessService.getObject(PmsConstants.MAPPER.PMS_PUBLISH + ".getPublishById", publish);
    }

    //修改
    @Override
    public int update(Publish publish) throws Exception {
        return dataAccessService.update(PmsConstants.MAPPER.PMS_PUBLISH + ".update", publish);
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
        return dataAccessService.delete(PmsConstants.MAPPER.PMS_PUBLISH + ".delete", id);
    }

    //插入
    @Override
    public int insert(Publish publish) throws Exception {
        if (StringUtils.isBlank(publish.getId())){//未传入id则默认使用uuid作为主键
            publish.setId(CommonUtil.getUUID());
        }
        return dataAccessService.insert(PmsConstants.MAPPER.PMS_PUBLISH + ".insert", publish);
    }

    //批量插入
    @Override
    public int batchInsert(List<Publish> list) throws Exception {
        int i = 0;
        for(Publish item : list){
            i += this.insert(item);
        }
        return i;
    }

}