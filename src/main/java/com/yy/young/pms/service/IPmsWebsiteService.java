package com.yy.young.pms.service;

import com.yy.young.dal.util.Page;
import com.yy.young.pms.model.PmsWebsite;
import java.util.List;

/**
 * @author hu_xuanhua_hua
 * @ClassName: IPmsWebsiteService
 * @Description: TODO
 * @date 2018-09-03 22:16
 * @versoin 1.0
 **/
public interface IPmsWebsiteService {
    public List<PmsWebsite> getList(PmsWebsite pmsWebsite) throws Exception;

    public List<PmsWebsite> getPage(PmsWebsite pmsWebsite, Page page)throws Exception;

    public PmsWebsite get(String  id) throws Exception;

    public int update(PmsWebsite pmsWebsite)throws Exception;

    public int delete(String s)throws Exception;

    public int delete(String[] strings) throws Exception;

    public int insert(PmsWebsite pmsWebsite) throws Exception;

    public int batchInsert(List<PmsWebsite> list) throws Exception;
}
