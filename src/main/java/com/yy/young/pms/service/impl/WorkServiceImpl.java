package com.yy.young.pms.service.impl;

import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.dal.util.Page;
import com.yy.young.pms.model.Work;
import com.yy.young.pms.util.PmsConstants;
import com.yy.young.common.service.ICommonService;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.annotation.Resource;
import java.util.List;

/**
 * 工作经历服务实现
 * Created by rookie on 2018-03-27.
 */
@Service("workService")
public class WorkServiceImpl implements ICommonService<Work> {

    @Resource(name = "dataAccessService")
    IDataAccessService dataAccessService;//数据层服务

    private static final Logger logger = LoggerFactory.getLogger(WorkServiceImpl.class);

    //获取数据列表
    @Override
    public List<Work> getList(Work work) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_WORK + ".getWorkList", work);
    }

    //获取数据列表(分页)
    @Override
    public List<Work> getPage(Work work, Page page) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_WORK + ".getWorkList", work, page);
    }

    //查询单条
    @Override
    public Work get(Work work) throws Exception {
        return (Work)dataAccessService.getObject(PmsConstants.MAPPER.PMS_WORK + ".getWorkById", work);
    }

    //修改
    @Override
    public int update(Work work) throws Exception {
        return dataAccessService.update(PmsConstants.MAPPER.PMS_WORK + ".update", work);
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
        return dataAccessService.delete(PmsConstants.MAPPER.PMS_WORK + ".delete", id);
    }

    //插入
    @Override
    public int insert(Work work) throws Exception {
        if (StringUtils.isBlank(work.getId())){//未传入id则默认使用uuid作为主键
            work.setId(CommonUtil.getUUID());
        }
        return dataAccessService.insert(PmsConstants.MAPPER.PMS_WORK + ".insert", work);
    }

    //批量插入
    @Override
    public int batchInsert(List<Work> list) throws Exception {
        int i = 0;
        for(Work item : list){
            i += this.insert(item);
        }
        return i;
    }

}