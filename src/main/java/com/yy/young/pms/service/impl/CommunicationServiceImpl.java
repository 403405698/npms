package com.yy.young.pms.service.impl;

import com.yy.young.base.exception.YoungBaseException;
import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.dal.util.Page;
import com.yy.young.interfaces.model.User;
import com.yy.young.interfaces.ums.service.IUmsOutService;
import com.yy.young.pms.model.Communication;
import com.yy.young.pms.util.PmsConstants;
import com.yy.young.common.service.ICommonService;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.annotation.Resource;
import java.net.URLDecoder;
import java.util.List;

/**
 * 通讯信息服务实现
 * Created by rookie on 2018-03-27.
 */
@Service("communicationService")
public class CommunicationServiceImpl implements ICommonService<Communication> {

    @Resource(name = "dataAccessService")
    IDataAccessService dataAccessService;//数据层服务

    @Resource(name = "umsOutService")
    IUmsOutService outService;//ums对外服务

    private static final Logger logger = LoggerFactory.getLogger(CommunicationServiceImpl.class);

    //获取数据列表
    @Override
    public List<Communication> getList(Communication communication) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_COMMUNICATION + ".getCommunicationList", communication);
    }

    //获取数据列表(分页)
    @Override
    public List<Communication> getPage(Communication communication, Page page) throws Exception {
        return dataAccessService.getList(PmsConstants.MAPPER.PMS_COMMUNICATION + ".getCommunicationList", communication, page);
    }

    //查询单条
    @Override
    public Communication get(Communication communication) throws Exception {
        if (StringUtils.isNotBlank(communication.getId()) && communication.getId().indexOf("%") > -1){
            communication.setId(URLDecoder.decode(communication.getId(), "UTF-8"));
        }
        return (Communication)dataAccessService.getObject(PmsConstants.MAPPER.PMS_COMMUNICATION + ".getCommunicationById", communication);
    }

    //修改
    @Override
    public int update(Communication communication) throws Exception {
        int i = dataAccessService.update(PmsConstants.MAPPER.PMS_COMMUNICATION + ".update", communication);
        if (StringUtils.isNotBlank(communication.getId())){
            //更新ums中的手机和邮箱
            User user = new User();
            user.setId(communication.getId());

            user.setTel(communication.getMobilePhone());
            user.setEmail(communication.getEmailAddress());
            if (outService.updateUser(user) < 0){
                throw new YoungBaseException("操作失败!");
            }
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
        return dataAccessService.delete(PmsConstants.MAPPER.PMS_COMMUNICATION + ".delete", id);
    }

    //插入
    @Override
    public int insert(Communication communication) throws Exception {
        int i = dataAccessService.insert(PmsConstants.MAPPER.PMS_COMMUNICATION + ".insert", communication);
        if (StringUtils.isNotBlank(communication.getId())){
            //更新ums中的手机和邮箱
            User user = new User();
            user.setId(communication.getId());
            user.setTel(communication.getMobilePhone());
            user.setEmail(communication.getEmailAddress());
            if (outService.updateUser(user) < 0){
                throw new YoungBaseException("操作失败!");
            }
        }
        return i;
    }

    //批量插入
    @Override
    public int batchInsert(List<Communication> list) throws Exception {
        int i = 0;
        for(Communication item : list){
            i += this.insert(item);
        }
        return i;
    }

}