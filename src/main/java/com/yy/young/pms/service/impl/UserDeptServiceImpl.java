package com.yy.young.pms.service.impl;

import com.yy.young.base.exception.ParameterException;
import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.pms.model.UserDept;
import com.yy.young.pms.service.IUserDeptService;
import com.yy.young.pms.util.PmsConstants;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 用户部门服务实现
 * Created by rookie on 2018/4/14.
 */
@Service("userDeptService")
public class UserDeptServiceImpl implements IUserDeptService {

    @Resource(name = "dataAccessService")
    IDataAccessService dataAccessService;//数据层服务

    @Override
    public int deleteUserDeptById(String id) throws Exception {
        return dataAccessService.delete(PmsConstants.MAPPER.PMS_USER_DEPT + ".delete", id);
    }

    @Override
    public int deleteUserDeptByUserId(String userId) throws Exception {
        return dataAccessService.delete(PmsConstants.MAPPER.PMS_USER_DEPT + ".deleteByUserId", userId);
    }

    //刷新用户的部门关联关系
    @Override
    public int refreshUserDept(String userId, String deptIds) throws Exception {
        if (StringUtils.isBlank(userId)){
            throw new ParameterException("操作失败:用户编号不允许为空!");
        }
        //删除用户原有的关联关系
        int i = this.deleteUserDeptByUserId(userId);
        //新增关联关系
        if (StringUtils.isNotBlank(deptIds)){
            String[] arr = deptIds.split(",");
            if (arr != null && arr.length > 0){
                for (String deptId : arr){
                    this.insertUserDept(userId, deptId);//插入关联
                }
            }
        }
        return i;
    }

    @Override
    public int insertUserDept(String userId, String deptId) throws Exception {
        Map<String,String> map = new HashMap<String,String>();
        map.put("id", CommonUtil.getUUID());
        map.put("deptId", deptId);
        map.put("userId", userId);
        return dataAccessService.insert(PmsConstants.MAPPER.PMS_USER_DEPT + ".insert", map);
    }

    @Override
    public List<UserDept> getUserDeptByUserId(String userId) throws Exception {
        if (StringUtils.isBlank(userId)){
            throw new ParameterException("操作失败:用户编号不允许为空!");
        }
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_USER_DEPT + ".getUserDeptByUserId", userId);
    }
}
