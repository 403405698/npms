package com.yy.young.pms.service.impl;

import com.yy.young.base.exception.YoungBaseException;
import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.dal.util.Page;
import com.yy.young.interfaces.model.User;
import com.yy.young.interfaces.ums.service.IUmsOutService;
import com.yy.young.pms.model.*;
import com.yy.young.pms.service.IAuditRecordBaseinfoService;
import com.yy.young.pms.service.IPmsUserExtService;
import com.yy.young.pms.service.IUserDeptService;
import com.yy.young.pms.util.PmsConstants;
import com.yy.young.common.service.ICommonService;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.annotation.Resource;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

/**
 * 用户基础信息服务实现
 * Created by rookie on 2018-03-27.
 */
@Service("pmsUserService")
public class PmsUserServiceImpl implements ICommonService<PmsUser>,IPmsUserExtService {

    @Resource(name = "dataAccessService")
    IDataAccessService dataAccessService;//数据层服务

    @Resource(name = "umsOutService")
    IUmsOutService outService;//ums对外服务

    @Resource(name = "userDeptService")
    IUserDeptService userDeptService;

    @Resource(name = "communicationService")
    ICommonService<Communication> communicationService;

    @Resource(name = "pmsSelfEvaluationService")
    ICommonService<PmsSelfEvaluation> pmsSelfEvaluationService;

    private static final Logger logger = LoggerFactory.getLogger(PmsUserServiceImpl.class);

    //获取数据列表,默认查询作废标识!=1的人员
    @Override
    public List<PmsUser> getList(PmsUser pmsUser) throws Exception {
        //多选部门查询
        if (pmsUser != null && StringUtils.isNotBlank(pmsUser.getDeptIds())){
            String[] depts = pmsUser.getDeptIds().split(",");
            if (depts != null && depts.length > 0){
                List<UserDept> list = new ArrayList<UserDept>();
                for(String deptId : depts){
                    UserDept userDept = new UserDept();
                    userDept.setDeptId(deptId);
                    list.add(userDept);
                }
                if (list != null && list.size() > 0){
                    pmsUser.setDeptList(list);
                }
            }
        }
        //行政级别多选
        if (StringUtils.isNotBlank(pmsUser.getAdministrativeLevel())){
            //格式化为带单引号形式,在sql中使用in关键字
            pmsUser.setAdministrativeLevel("'"+pmsUser.getAdministrativeLevel().replaceAll(",", "','")+"'");
        }
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_USER + ".getPmsUserList", pmsUser);
    }

    //获取数据列表(分页),默认查询作废标识!=1的人员
    @Override
    public List<PmsUser> getPage(PmsUser pmsUser, Page page) throws Exception {
        //多选部门查询
        if (pmsUser != null && StringUtils.isNotBlank(pmsUser.getDeptIds())){
            String[] depts = pmsUser.getDeptIds().split(",");
            if (depts != null && depts.length > 0){
                List<UserDept> list = new ArrayList<UserDept>();
                for(String deptId : depts){
                    UserDept userDept = new UserDept();
                    userDept.setDeptId(deptId);
                    list.add(userDept);
                }
                if (list != null && list.size() > 0){
                    pmsUser.setDeptList(list);
                }
            }
        }
        //行政级别多选
        if (StringUtils.isNotBlank(pmsUser.getAdministrativeLevel())){
            //格式化为带单引号形式,在sql中使用in关键字
            pmsUser.setAdministrativeLevel("'"+pmsUser.getAdministrativeLevel().replaceAll(",", "','")+"'");
        }
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_USER + ".getPmsUserList", pmsUser, page);
    }

    //查询管辖部门内人员
    @Override
    public List<PmsUser> getPageInDept(PmsUser pmsUser, Page page) throws Exception {
        if (pmsUser == null || pmsUser.getDeptList() == null || pmsUser.getDeptList().size() == 0){
            return null;
        }
        //行政级别多选
        if (StringUtils.isNotBlank(pmsUser.getAdministrativeLevel())){
            //格式化为带单引号形式,在sql中使用in关键字
            pmsUser.setAdministrativeLevel("'"+pmsUser.getAdministrativeLevel().replaceAll(",", "','")+"'");
        }
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_USER + ".getPmsUserListInDept", pmsUser, page);
    }

    //查询单条
    @Override
    public PmsUser get(PmsUser pmsUser) throws Exception {
        if (StringUtils.isNotBlank(pmsUser.getId()) && pmsUser.getId().indexOf("%") > -1){
            pmsUser.setId(URLDecoder.decode(pmsUser.getId(), "UTF-8"));
        }
        return (PmsUser)dataAccessService.getObject(PmsConstants.MAPPER.PMS_USER + ".getPmsUserById", pmsUser);
    }

    //修改
    @Override
    public int update(PmsUser pmsUser) throws Exception {
        int i = dataAccessService.update(PmsConstants.MAPPER.PMS_USER + ".update", pmsUser);//更新人员信息
        //不修改账号和单位
        User user = pmsUser.toUser();
        user.setAccount(null);//userid
        user.setCompanyId(null);
        if (outService.updateUser(user) < 0){
            throw new YoungBaseException("操作失败!");
        }
        return i;
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
        userDeptService.deleteUserDeptByUserId(id);//删除用户部门关联关系
        //删除人员联系方式
        communicationService.delete(id);
        //删除自我评价
        pmsSelfEvaluationService.delete(id);
        //删除其余人员信息--放在PmsUserMapper中统一删除(快),有需要的话可以将删除放在各个服务中
        dataAccessService.delete(PmsConstants.MAPPER.PMS_USER + ".deleteAllInfoAboutUser", id);
        int i = dataAccessService.delete(PmsConstants.MAPPER.PMS_USER + ".delete", id);//删除人员信息
        //删除ums中的用户信息,放在人员删除后面是为了控制事务
        if (outService.deleteUser(id) < 0){
            throw new YoungBaseException("操作失败!");
        }
        return i;
    }

/*    //插入
    @Override
    public int insert(PmsUser pmsUser) throws Exception {
        if (StringUtils.isBlank(pmsUser.getUserId())){//账号验证
            throw new YoungBaseException("人员账号无效!");
        }
        //先在pms中添加人员
        PmsUser pu = this.getByAccount(pmsUser.getUserId());//根据账号查询人员,判断是否存在
        if(pu != null){
            throw new YoungBaseException("人员帐号已被使用!");
        }
        pmsUser.setId(CommonUtil.getUUID());//设置人员编号为uuid
        int i = dataAccessService.insert(PmsConstants.MAPPER.PMS_USER + ".insert", pmsUser);
        if (outService.existUserIdOrAccount(pmsUser.getId())){//ums存在此用户
            logger.info("[人员档案新增] UMS存在编号或账号为{}的用户!", pmsUser.getId());
            //throw new YoungBaseException("人员编号已被使用!");
        }else if(outService.existUserIdOrAccount(pmsUser.getUserId())){
            logger.info("[人员档案新增] UMS存在编号或账号为{}的用户!", pmsUser.getUserId());
        }else{//ums无此用户
            User user = pmsUser.toUser();
            user.setState("1");//用户状态
            user.setPassword(PmsConstants.DEF_USER_PASSWORD);//默认密码
            if (!outService.insertUser(user)){//调用ums服务创建用户信息
                throw new YoungBaseException("操作失败!");
            }
        }
        //添加用户-部门关联
        if(StringUtils.isNotBlank(pmsUser.getDeptIds())){
            String[] deptIdArr = pmsUser.getDeptIds().split(",");
            if (deptIdArr != null && deptIdArr.length > 0){
                for (String deptId : deptIdArr){
                    userDeptService.insertUserDept(pmsUser.getId(), deptId);//插入关联
                }
            }
        }
        return i;
    }*/

    //插入
    @Override
    public int insert(PmsUser pmsUser) throws Exception {
        if (StringUtils.isBlank(pmsUser.getUserId())){//账号验证
            throw new YoungBaseException("人员账号无效!");
        }
        //先在pms中添加人员
        PmsUser pu = this.getByAccount(pmsUser.getUserId());//根据账号查询人员,判断是否存在
        if(pu != null){
            throw new YoungBaseException("人员帐号已被使用!");
        }
//        pmsUser.setId(CommonUtil.getUUID());//old设置人员编号为uuid
        if (StringUtils.isBlank(pmsUser.getId())){
            pmsUser.setId(CommonUtil.getUUID());
        }
        int i = dataAccessService.insert(PmsConstants.MAPPER.PMS_USER + ".insert", pmsUser);
        if (outService.existUserIdOrAccount(pmsUser.getId())){//ums存在此用户
            logger.info("[人员档案新增] UMS存在编号或账号为{}的用户!", pmsUser.getId());
            //throw new YoungBaseException("人员编号已被使用!");
        }else if(outService.existUserIdOrAccount(pmsUser.getUserId())){
            logger.info("[人员档案新增] UMS存在编号或账号为{}的用户!", pmsUser.getUserId());
        }else{//ums无此用户
            User user = pmsUser.toUser();//设置了单位ID
            user.setState("1");//用户状态
            user.setPassword(PmsConstants.DEF_USER_PASSWORD);//默认密码
            if (!outService.insertUser(user)){//调用ums服务创建用户信息
                throw new YoungBaseException("操作失败!");
            }
        }
        //添加用户-部门关联
        if(StringUtils.isNotBlank(pmsUser.getDeptIds())){
            String[] deptIdArr = pmsUser.getDeptIds().split(",");
            if (deptIdArr != null && deptIdArr.length > 0){
                for (String deptId : deptIdArr){
                    userDeptService.insertUserDept(pmsUser.getId(), deptId);//插入关联
                }
            }
        }
        return i;
    }

    //批量插入
    @Override
    public int batchInsert(List<PmsUser> list) throws Exception {
        int i = 0;
        for(PmsUser item : list){
            i += this.insert(item);
        }
        return i;
    }


    //作废人员
    @Override
    public void trashUser(String userId) throws Exception {
        if (StringUtils.isNotBlank(userId)){
            //作废用户
            dataAccessService.update(PmsConstants.MAPPER.PMS_USER + ".trashUser", userId);
            //ums禁用用户登录
            User user = new User();
            user.setId(userId);
            user.setState("0");//状态为0则禁止登陆
            if (outService.updateUser(user) < 0){
                throw new YoungBaseException("操作失败!");
            }
        }
    }

    //批量作废
    @Override
    public void trashUser(String[] userIds) throws Exception {
        if (userIds != null){
            for (String userId : userIds){
                this.trashUser(userId);
            }
        }
    }

    @Override
    public PmsUser getByAccount(String account) throws Exception {
        return (PmsUser)dataAccessService.getObject(PmsConstants.MAPPER.PMS_USER + ".getByAccount", account);
    }
}