//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package com.yy.young.pms.service.impl.audit;

import com.yy.young.dal.EDBType;
import com.yy.young.dal.dao.IDataAccessDao;
import java.util.List;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;

public class DataAccessDaoImpl implements IDataAccessDao {
    private SqlSessionTemplate sqlSessionTemplate;

    public DataAccessDaoImpl() {
    }

    public SqlSessionTemplate getSqlSessionTemplate() {
        return this.sqlSessionTemplate;
    }

    public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate = sqlSessionTemplate;
    }

    public EDBType getDBType() {
        String dbId = this.sqlSessionTemplate.getConfiguration().getDatabaseId();
        if ("MySQL".equalsIgnoreCase(dbId)) {
            return EDBType.MYSQL;
        } else if ("Oracle".equalsIgnoreCase(dbId)) {
            return EDBType.ORACLE;
        } else {
            return "PostgreSQL".equalsIgnoreCase(dbId) ? EDBType.POSTGRESQL : EDBType.OTHER;
        }
    }

    public int insert(String method, Object parameter) throws Exception {
        return this.sqlSessionTemplate.insert(method, parameter);
    }

    public int delete(String method, Object parameter) throws Exception {
        return this.sqlSessionTemplate.delete(method, parameter);
    }

    public List<?> getList(String method, Object parameter) throws Exception {
        return this.sqlSessionTemplate.selectList(method, parameter);
    }

    public List<?> getList(String method, Object parameter, RowBounds rowBounds) throws Exception {
        return this.sqlSessionTemplate.selectList(method, parameter, rowBounds);
    }

    public int update(String method, Object parameter) throws Exception {
        return this.sqlSessionTemplate.update(method, parameter);
    }

    public Object getObject(String method, Object parameter) throws Exception {
        return this.sqlSessionTemplate.selectOne(method, parameter);
    }
}
