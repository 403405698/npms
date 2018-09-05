//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package com.yy.young.pms.service.impl.audit;

import com.yy.young.dal.EDBType;
import com.yy.young.dal.dao.IDataAccessDao;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.dal.util.DalRowBounds;
import com.yy.young.dal.util.Page;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

@Service("auditDataAccessService")
public class DataAccessServiceImpl implements IDataAccessService<Object> {
    @Resource(
        name = "dataAccessDao2"
    )
    IDataAccessDao dataAccessDao;

    public DataAccessServiceImpl() {
    }

    public IDataAccessDao getDataSourceDao() {
        return this.dataAccessDao;
    }

    public void setDataSourceDao(IDataAccessDao dataAccessDao) {
        this.dataAccessDao = dataAccessDao;
    }

    public EDBType getDBType() {
        return this.dataAccessDao.getDBType();
    }

    public int insert(String method, Object parameter) throws Exception {
        return this.dataAccessDao.insert(method, parameter);
    }

    public int delete(String method, Object parameter) throws Exception {
        return this.dataAccessDao.delete(method, parameter);
    }

    public List<?> getList(String method, Object parameter) throws Exception {
        return this.dataAccessDao.getList(method, parameter);
    }

    public List<?> getList(String method, Object parameter, Page page) throws Exception {
        return page == null ? this.getList(method, parameter) : this.dataAccessDao.getList(method, parameter, new DalRowBounds(page));
    }

    public int update(String method, Object parameter) throws Exception {
        return this.dataAccessDao.update(method, parameter);
    }

    public Object getObject(String method, Object parameter) throws Exception {
        return this.dataAccessDao.getObject(method, parameter);
    }
}
