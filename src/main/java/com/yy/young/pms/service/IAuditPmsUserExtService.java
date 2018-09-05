package com.yy.young.pms.service;

import com.yy.young.dal.util.Page;
import com.yy.young.pms.model.PmsUser;

import java.util.List;

/**
 * Created by rookie on 2018/4/15.
 */
public interface IAuditPmsUserExtService<T> {
    /**
     * 查询管辖内的用户列表
     * @param pmsUser
     * @param page
     * @return
     * @throws Exception
     */
    List<T> getPageInDept(T pmsUser, Page page) throws Exception;

    /**
     * 作废用户
     * @param userId 用户id
     * @throws Exception
     */
    void trashUser(String userId) throws Exception;

    /**
     * 批量作废
     * @param userIds
     * @throws Exception
     */
    void trashUser(String[] userIds) throws Exception;

    /**
     * 根据账号查询人员信息
     * @param account 账号,即user_id字段(与用户表中的account对应)
     * @return
     * @throws Exception
     */
    T getByAccount(String account) throws Exception;
}
