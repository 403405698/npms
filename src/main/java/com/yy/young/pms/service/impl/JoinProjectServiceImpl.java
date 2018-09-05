package com.yy.young.pms.service.impl;

import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.dal.util.Page;
import com.yy.young.pms.model.JoinProject;
import com.yy.young.pms.util.PmsConstants;
import com.yy.young.common.service.ICommonService;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.annotation.Resource;
import java.util.List;

/**
 * 参加项目信息服务实现
 * Created by rookie on 2018-03-27.
 */
@Service("joinProjectService")
public class JoinProjectServiceImpl implements ICommonService<JoinProject> {

    @Resource(name = "dataAccessService")
    IDataAccessService dataAccessService;//数据层服务

    private static final Logger logger = LoggerFactory.getLogger(JoinProjectServiceImpl.class);

    //获取数据列表
    @Override
    public List<JoinProject> getList(JoinProject joinProject) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_JOIN_PROJECT + ".getJoinProjectList", joinProject);
    }

    //获取数据列表(分页)
    @Override
    public List<JoinProject> getPage(JoinProject joinProject, Page page) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_JOIN_PROJECT + ".getJoinProjectList", joinProject, page);
    }

    //查询单条
    @Override
    public JoinProject get(JoinProject joinProject) throws Exception {
        return (JoinProject)dataAccessService.getObject(PmsConstants.MAPPER.PMS_JOIN_PROJECT + ".getJoinProjectById", joinProject);
    }

    //修改
    @Override
    public int update(JoinProject joinProject) throws Exception {
        return dataAccessService.update(PmsConstants.MAPPER.PMS_JOIN_PROJECT + ".update", joinProject);
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
        return dataAccessService.delete(PmsConstants.MAPPER.PMS_JOIN_PROJECT + ".delete", id);
    }

    //插入
    @Override
    public int insert(JoinProject joinProject) throws Exception {
        if (StringUtils.isBlank(joinProject.getId())){//未传入id则默认使用uuid作为主键
            joinProject.setId(CommonUtil.getUUID());
        }
        return dataAccessService.insert(PmsConstants.MAPPER.PMS_JOIN_PROJECT + ".insert", joinProject);
    }

    //批量插入
    @Override
    public int batchInsert(List<JoinProject> list) throws Exception {
        int i = 0;
        for(JoinProject item : list){
            i += this.insert(item);
        }
        return i;
    }

}