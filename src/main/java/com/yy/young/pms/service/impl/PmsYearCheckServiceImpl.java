package com.yy.young.pms.service.impl;

import com.yy.young.base.exception.ParameterException;
import com.yy.young.common.service.ICommonService;
import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.dal.util.Page;
import com.yy.young.pms.model.PmsYearCheck;
import com.yy.young.pms.util.PmsConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 年度考核表服务实现
 * Created by rookie on 2018-03-27.
 */
@Service("pmsYearCheckService")
public class PmsYearCheckServiceImpl implements ICommonService<PmsYearCheck> {

    @Resource(name = "dataAccessService")
    IDataAccessService dataAccessService;//数据层服务

    private static final Logger logger = LoggerFactory.getLogger(PmsYearCheckServiceImpl.class);

    //获取数据列表
    @Override
    public List<PmsYearCheck> getList(PmsYearCheck pmsYearCheck) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_YEAR_CHECK + ".getPmsYearCheckList", pmsYearCheck);
    }

    //获取数据列表(分页)
    @Override
    public List<PmsYearCheck> getPage(PmsYearCheck pmsYearCheck, Page page) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_YEAR_CHECK + ".getPmsYearCheckList", pmsYearCheck, page);
    }

    //查询单条
    @Override
    public PmsYearCheck get(PmsYearCheck pmsYearCheck) throws Exception {
        return (PmsYearCheck)dataAccessService.getObject(PmsConstants.MAPPER.PMS_YEAR_CHECK + ".getPmsYearCheckById", pmsYearCheck);
    }

    //修改
    @Override
    public int update(PmsYearCheck pmsYearCheck) throws Exception {
        return dataAccessService.update(PmsConstants.MAPPER.PMS_YEAR_CHECK + ".update", pmsYearCheck);
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
        return dataAccessService.delete(PmsConstants.MAPPER.PMS_YEAR_CHECK + ".delete", id);
    }

    //插入
    @Override
    public int insert(PmsYearCheck pmsYearCheck) throws Exception {
       /* if ("1".equals(pmsYearCheck.getStype())){//年度考核
            pmsYearCheck.setQuarter(null);
        }else if ("0".equals(pmsYearCheck.getStype())){//季度考核
            if (pmsYearCheck.getQuarter() == null){
                throw new ParameterException("操作失败:季度考核必须填写所属季度!");
            }
        }else{
            throw new ParameterException("操作失败:考核类型无效,请选择正确的考核类型(年度/季度)!");
        }*/
        if (StringUtils.isBlank(pmsYearCheck.getId())){//未传入id则默认使用uuid作为主键
            pmsYearCheck.setId(CommonUtil.getUUID());
        }
        return dataAccessService.insert(PmsConstants.MAPPER.PMS_YEAR_CHECK + ".insert", pmsYearCheck);
    }

    //批量插入
    @Override
    public int batchInsert(List<PmsYearCheck> list) throws Exception {
        int i = 0;
        for(PmsYearCheck item : list){
            i += this.insert(item);
        }
        return i;
    }

}