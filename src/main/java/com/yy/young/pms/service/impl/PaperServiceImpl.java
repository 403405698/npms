package com.yy.young.pms.service.impl;

import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.dal.util.Page;
import com.yy.young.pms.model.Paper;
import com.yy.young.pms.util.PmsConstants;
import com.yy.young.common.service.ICommonService;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.annotation.Resource;
import java.util.List;

/**
 * 论文情况服务实现
 * Created by rookie on 2018-03-27.
 */
@Service("paperService")
public class PaperServiceImpl implements ICommonService<Paper> {

    @Resource(name = "dataAccessService")
    IDataAccessService dataAccessService;//数据层服务

    private static final Logger logger = LoggerFactory.getLogger(PaperServiceImpl.class);

    //获取数据列表
    @Override
    public List<Paper> getList(Paper paper) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_PAPER + ".getPaperList", paper);
    }

    //获取数据列表(分页)
    @Override
    public List<Paper> getPage(Paper paper, Page page) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_PAPER + ".getPaperList", paper, page);
    }

    //查询单条
    @Override
    public Paper get(Paper paper) throws Exception {
        return (Paper)dataAccessService.getObject(PmsConstants.MAPPER.PMS_PAPER + ".getPaperById", paper);
    }

    //修改
    @Override
    public int update(Paper paper) throws Exception {
        return dataAccessService.update(PmsConstants.MAPPER.PMS_PAPER + ".update", paper);
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
        return dataAccessService.delete(PmsConstants.MAPPER.PMS_PAPER + ".delete", id);
    }

    //插入
    @Override
    public int insert(Paper paper) throws Exception {
        if (StringUtils.isBlank(paper.getId())){//未传入id则默认使用uuid作为主键
            paper.setId(CommonUtil.getUUID());
        }
        return dataAccessService.insert(PmsConstants.MAPPER.PMS_PAPER + ".insert", paper);
    }

    //批量插入
    @Override
    public int batchInsert(List<Paper> list) throws Exception {
        int i = 0;
        for(Paper item : list){
            i += this.insert(item);
        }
        return i;
    }

}