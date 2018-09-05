package com.yy.young.pms.service.impl;

import com.yy.young.common.service.ICommonService;
import com.yy.young.common.util.CommonUtil;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.dal.util.Page;
import com.yy.young.pms.model.PmsWebsite;
import com.yy.young.pms.service.IPmsWebsiteService;
import com.yy.young.pms.util.PmsConstants;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author hu_xuanhua_hua
 * @ClassName: PmsWebsiteService
 * @Description: TODO
 * @date 2018-09-03 22:17
 * @versoin 1.0
 **/
@Service("pmsWebsiteService")
public class PmsWebsiteService implements IPmsWebsiteService {
    @Resource(name = "dataAccessService")
    IDataAccessService dataAccessService;//数据层服务

    @Override
    public List<PmsWebsite> getList(PmsWebsite pmsWebsite) throws Exception {
        return null;
    }

    @Override
    public List<PmsWebsite> getPage(PmsWebsite obj, Page page) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_WEBSITE + ".getList", obj, page);
    }

    @Override
    public PmsWebsite get(String  obj) throws Exception {
        return (PmsWebsite)dataAccessService.getObject(PmsConstants.MAPPER.PMS_WEBSITE + ".get", obj);
    }

    @Override
    public int update(PmsWebsite pmsWebsite) throws Exception {
        return 0;
    }

    @Override
    public int delete(String id)  throws Exception{
        return dataAccessService.delete(PmsConstants.MAPPER.PMS_WEBSITE + ".delete", id);

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

    @Override
    public int insert(PmsWebsite pmsWebsite) throws Exception {
        pmsWebsite.setId(CommonUtil.getUUID());
        int result = dataAccessService.insert(PmsConstants.MAPPER.PMS_WEBSITE + ".insert", pmsWebsite);
        return result;
    }

    @Override
    public int batchInsert(List<PmsWebsite> list) throws Exception {
        return 0;
    }
}
