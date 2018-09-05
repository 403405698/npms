package com.yy.young.pms.service.impl;

import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.dal.util.Page;
import com.yy.young.pms.model.Communication;
import com.yy.young.pms.model.PmsDictionary;
import com.yy.young.pms.service.IDictionaryService;
import com.yy.young.pms.util.PmsConstants;
import com.yy.young.common.service.ICommonService;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.annotation.Resource;
import java.util.List;

/**
 * 数据字典表服务实现
 * Created by rookie on 2018-04-02.
 */
@Service("pmsDictionaryService")
public class PmsDictionaryServiceImpl implements ICommonService<PmsDictionary>,IDictionaryService {

    @Resource(name = "dataAccessService")
    IDataAccessService dataAccessService;//数据层服务

    private static final Logger logger = LoggerFactory.getLogger(PmsDictionaryServiceImpl.class);

    //获取数据列表
    @Override
    public List<PmsDictionary> getList(PmsDictionary pmsDictionary) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_DICTIONARY + ".getPmsDictionaryList", pmsDictionary);
    }

    //获取数据列表(分页)
    @Override
    public List<PmsDictionary> getPage(PmsDictionary pmsDictionary, Page page) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_DICTIONARY + ".getPmsDictionaryList", pmsDictionary, page);
    }

    //查询单条
    @Override
    public PmsDictionary get(PmsDictionary pmsDictionary) throws Exception {
        return (PmsDictionary)dataAccessService.getObject(PmsConstants.MAPPER.PMS_DICTIONARY + ".getPmsDictionaryById", pmsDictionary);
    }

    //修改
    @Override
    public int update(PmsDictionary pmsDictionary) throws Exception {
        return dataAccessService.update(PmsConstants.MAPPER.PMS_DICTIONARY + ".update", pmsDictionary);
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
        return dataAccessService.delete(PmsConstants.MAPPER.PMS_DICTIONARY + ".delete", id);
    }

    //插入
    @Override
    public int insert(PmsDictionary pmsDictionary) throws Exception {
        if (StringUtils.isBlank(pmsDictionary.getId())){//未传入id则默认使用uuid作为主键
            pmsDictionary.setId(CommonUtil.getUUID());
        }
        return dataAccessService.insert(PmsConstants.MAPPER.PMS_DICTIONARY + ".insert", pmsDictionary);
    }

    //批量插入
    @Override
    public int batchInsert(List<PmsDictionary> list) throws Exception {
        int i = 0;
        for(PmsDictionary item : list){
            i += this.insert(item);
        }
        return i;
    }

    @Override
    public List<Communication> getDictionaryCatalog() throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_DICTIONARY + ".getDictionaryCatalog", null);
    }
}