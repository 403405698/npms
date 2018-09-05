package com.yy.young.pms.service;

import com.yy.young.dal.util.Page;
import com.yy.young.pms.model.AuditPmsRelations;
import com.yy.young.pms.model.AuditPmsTechnologyBrace;
import java.util.List;

/**
* xxx服务接口
* Created by rookie on 2018-04-03.
*/
public interface IAuditPmsTechnologyBraceService {

    /**
    * 查询
    * @param obj
    * @return
    * @throws Exception
    */
    List<AuditPmsTechnologyBrace> getList(AuditPmsTechnologyBrace obj) throws Exception;

    /**
    * 分页查询
    * @param obj
    * @param page
    * @return
    * @throws Exception
    */
    List<AuditPmsTechnologyBrace> getPage(AuditPmsTechnologyBrace obj, Page page) throws Exception;

    /**
    * 查询单条
    * @param id
    * @return
    * @throws Exception
    */
    AuditPmsTechnologyBrace get(String id) throws Exception;

    /**
    * 统计数量
    * @param obj
    * @return Integer 满足xx条件的数据有多少条
    * @throws Exception
    */
    int count(AuditPmsTechnologyBrace obj) throws Exception;

    /**
    * 修改
    * @param obj
    * @return
    * @throws Exception
    */
    int update(AuditPmsTechnologyBrace obj) throws Exception;

    /**
    * 删除
    * @param id
    * @return
    * @throws Exception
    */
    int delete(String id) throws Exception;

    /**
    * 批量删除
    * @param idArr
    * @return
    * @throws Exception
    */
    int delete(String[] idArr) throws Exception;

    /**
    * 插入
    * @param obj
    * @return
    * @throws Exception
    */
    int insert(AuditPmsTechnologyBrace obj) throws Exception;

    /**
    * 批量插入
    * @param list
    * @return
    * @throws Exception
    */
    int batchInsert(List<AuditPmsTechnologyBrace> list) throws Exception;
    int batchUpdate(List<AuditPmsTechnologyBrace> list) throws Exception;
}