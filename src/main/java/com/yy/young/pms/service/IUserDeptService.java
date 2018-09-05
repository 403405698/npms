package com.yy.young.pms.service;

import com.yy.young.pms.model.UserDept;

import java.util.List;

/**
 * 部门用户服务
 * Created by rookie on 2018/4/14.
 */
public interface IUserDeptService {

    /**
     * 删除单条关联关系
     * @param id
     * @return
     * @throws Exception
     */
    int deleteUserDeptById(String id) throws Exception;

    /**
     * 根据用户id删除用户部门关联关系
     * @param userId
     * @return
     * @throws Exception
     */
    int deleteUserDeptByUserId(String userId) throws Exception;

    /**
     * 刷新用户部门关系
     * @param userId
     * @param deptIds
     * @return
     * @throws Exception
     */
    int refreshUserDept(String userId, String deptIds) throws Exception;

    /**
     * 插入用户部门关联关系
     * @param userId
     * @param deptId
     * @return
     * @throws Exception
     */
    int insertUserDept(String userId, String deptId) throws Exception;

    /**
     * 根据用户id查询所有关联关系
     * @param userId
     * @return
     * @throws Exception
     */
    List<UserDept> getUserDeptByUserId(String userId) throws Exception;
}
