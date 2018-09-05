package com.yy.young.pms.web;

import com.yy.young.cms.service.ICmsDBService;
import com.yy.young.common.core.excel.ExcelExport;
import com.yy.young.common.core.excel.ExcelImport;
import com.yy.young.common.core.excel.IExcelExport;
import com.yy.young.common.core.excel.IExcelImport;
import com.yy.young.common.service.ICommonService;
import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.Result;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.util.Page;
import com.yy.young.interfaces.log.annotation.Log;
import com.yy.young.pms.model.*;
import com.yy.young.pms.service.*;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
* xxx服务
* Created by rookie on 2018-04-03.
*/
@Controller
@RequestMapping("/pms/auditRecordCommunication")
public class AuditRecordCommunicationController {

    @Resource(name="auditRecordCommunicationService")
    IAuditRecordCommunicationService service;

    @Resource(name="auditRecordBaseinfoService")
    IAuditRecordBaseinfoService auditRecordBaseinfoService;

    @Resource(name="auditFieldBaseService")
    IAuditFieldBaseService auditFieldBaseService;

    @Resource(name = "pmsUserService")
    IPmsUserExtService pmsUserService;

    @Resource(name = "pmsUserService")
    ICommonService<PmsUser> pmsUserService2;

    @Resource(name="auditPmsDeptService")
    IAuditPmsDeptService auditPmsDeptService;

    @Resource(name="auditPmsEducationService")
    IAuditPmsEducationService auditPmsEducationService;

    @Resource(name="auditPmsHonorTitleService")
    IAuditPmsHonorTitleService auditPmsHonorTitleService;

    @Resource(name="auditPmsJoinProjectService")
    IAuditPmsJoinProjectService auditPmsJoinProjectService;

    @Resource(name="auditPmsLeaderEvaluationService")
    IAuditPmsLeaderEvaluationService auditPmsLeaderEvaluationService;

    @Resource(name="auditPmsMainTechGroupService")
    IAuditPmsMainTechGroupService auditPmsMainTechGroupService;

    @Resource(name="auditPmsPaperService")
    IAuditPmsPaperService auditPmsPaperService;

    @Resource(name="auditPmsPatentService")
    IAuditPmsPatentService auditPmsPatentService;

    @Resource(name="auditPmsPublishService")
    IAuditPmsPublishService auditPmsPublishService;

    @Resource(name="auditPmsRelationsService")
    IAuditPmsRelationsService auditPmsRelationsService;

    @Resource(name="auditPmsSelfEvaluationService")
    IAuditPmsSelfEvaluationService auditPmsSelfEvaluationService;

    @Resource(name="auditPmsSupportProjectService")
    IAuditPmsSupportProjectService auditPmsSupportProjectService;

    @Resource(name="auditPmsTechAwardsService")
    IAuditPmsTechAwardsService auditPmsTechAwardsService;

    @Resource(name="auditPmsTechnologyBraceService")
    IAuditPmsTechnologyBraceService auditPmsTechnologyBraceService;

    @Resource(name="auditPmsWorkService")
    IAuditPmsWorkService auditPmsWorkService;

    @Resource(name="auditPmsYearCheckService")
    IAuditPmsYearCheckService auditPmsYearCheckService;

    @Resource(name = "cmsDBService")
    ICmsDBService cmsDBService;

    @Resource(name="auditFieldService")
    IAuditFieldService auditFieldService;

    @Resource(name="auditShowUserService")
    IAuditShowUserService auditShowUserService;

    @Resource(name="auditFieldCommuService")
    IAuditFieldCommuService auditFieldCommuService;

    @Resource(name = "communicationService")
    ICommonService<Communication> communicationService;
    /**
    * 获取数据列表
    * @param obj
    * @param request
    * @return
    * @throws Exception
    */
    @Log("查询xxx列表")
    @RequestMapping("/getList")
    @ResponseBody
    public Object getList(AuditRecordCommunication obj, HttpServletRequest request) throws Exception{
        List<AuditRecordCommunication> list = service.getList(obj);
        return new Result(list);
    }

    /**
    * 获取分页数据
    * @param obj
    * @param request
    * @return
    * @throws Exception
    */
    @Log("分页查询xxx列表")
    @RequestMapping("/getPage")
    @ResponseBody
    public Object getPage(AuditRecordCommunication obj, HttpServletRequest request) throws Exception{
        Page page = CommonUtil.getPageFromRequest(request);
        List<AuditRecordCommunication> list = service.getPage(obj, page);
        page.setData(list);
        return page;
    }

    /**
    * 获取单条数据
    * @param id
    * @param request
    * @return
    * @throws Exception
    */
    @Log("查询xxx")
    @RequestMapping("/get")
    @ResponseBody
    public Object get(String id, HttpServletRequest request) throws Exception{
        AuditRecordCommunication obj = service.get(id);
        return new Result(obj);
    }

    /**
    * 统计数量
    * @param obj
    * @param request
    * @return
    * @throws Exception
    */
    @Log("统计xxx数量")
    @RequestMapping("/count")
    @ResponseBody
    public Object count(AuditRecordCommunication obj, HttpServletRequest request) throws Exception{
        return new Result(service.count(obj));
    }

    /**
    * 新增
    * @param obj
    * @param request
    * @return
    * @throws Exception
    */
    @Log("新增xxx")
    @RequestMapping("/insert")
    @ResponseBody
    public Object insert(AuditRecordCommunication obj, HttpServletRequest request) throws Exception{
        service.insert(obj);
        return new Result();
    }

    /**
    * 修改
    * @param obj
    * @param request
    * @return
    * @throws Exception
    */
    @Log("修改xxx")
    @RequestMapping("/update")
    @ResponseBody
    public Object update(AuditRecordCommunication obj, HttpServletRequest request) throws Exception{
        service.update(obj);
        return new Result();
    }

    @Log("将过去信息加入审核库")
    @RequestMapping("/oldToAudit")
    @ResponseBody
    public Object oldToAudit(AuditRecordCommunication obj, HttpServletRequest request) throws Exception{
        List<Communication> educationList = communicationService.getList(null);
        for (Communication item : educationList) {
            JSONObject jsonObject = JSONObject.fromObject(item);
            Iterator keys = jsonObject.keys();
            String userId = jsonObject.getString("id");
            while(keys.hasNext()) {
                String key = keys.next().toString();
                String val = jsonObject.getString(key);
                AuditRecordCommunication AuditRecordCommunication = new AuditRecordCommunication();
                AuditRecordCommunication.setFieldKey(key);
                AuditRecordCommunication.setUserId(userId);
                int size = service.getList(AuditRecordCommunication).size();
                AuditRecordCommunication.setFieldVal(val);
                if (("id").equals(key) || ("userId").equals(key)) {
                    AuditRecordCommunication.setAuditStatus(1);
                }else {
                    AuditRecordCommunication.setAuditStatus(5);
                }
                AuditRecordCommunication.setLockStatus(2);
                AuditRecordCommunication.setItemId(1);//临时处理，一定没有数据
                if (size > 0) {
                    service.update(AuditRecordCommunication);
                }else {
                    service.insert(AuditRecordCommunication);
                }
            }
        }

        return new Result();
    }



    /**
     * 获取用户审核信息，用于用户查看时信息对比请求USERID，返回信息不相同改变状态而且判断一下状态。
     */
    @Log("获取用户审核信息")
    @RequestMapping("/getUserAuditInfo")
    @ResponseBody
    public Object getUserAuditInfo (AuditRecordCommunication obj,HttpServletRequest request) throws Exception {

        //筛选最后一次start
        AuditRecordCommunication AuditRecordCommunication = new AuditRecordCommunication();
        AuditRecordCommunication.setUserId(obj.getUserId());
        List<AuditRecordCommunication> tempList = service.getList(AuditRecordCommunication);
        if (tempList.size() > 0) {
            obj.setItemId(tempList.get(0).getItemId());
        }
        //筛选最后一次 end

        List<AuditRecordCommunication> auditList = service.getList(obj);
        List<Object> list = new ArrayList<Object>();
        list.add(auditList);
        return new Result(list);
    }


    /**
     * @param
     * @param request
     * @return
     * @throws Exception
     */
    @Log("管理员审核通讯信息")
    @RequestMapping("/changeStatus")
    @ResponseBody
    public Object changeStatus(String ids,Integer auditStatus,Integer lockStatus,Integer itemId,String userId,String vStr,String vName, HttpServletRequest request) throws Exception{
        Result result = new Result();

        //修复ums_user.mapper的updateuserobj   start
        // 异常内容：UPDATE TB_UMS_USER WHERE ID='1'
        // 解决方法：随便传递一个必要字段如果NULL则设置为""
        Communication commu = new Communication();
        commu.setId(userId);
        Communication old_commu = communicationService.get(commu);
        String old_mobilePhone;
        if (old_commu != null) {
            old_mobilePhone = old_commu.getMobilePhone();
        }else {
            old_mobilePhone = "";
        }
        String temp_mobilePhone = old_mobilePhone;

        //修复结束 end

        if(StringUtils.isNotBlank(ids)) {
            String[] idArr = ids.split(",");
            String[] vStrArr = vStr.split(",",-1);
            String[] vNameArr = vName.split(",");
            for (int i=0;i<idArr.length;i++) {
                AuditRecordCommunication obj = new AuditRecordCommunication();
                if (!("on").equals(idArr[i])) {
                    obj.setId(idArr[i]);
                }else {
                    obj.setId(CommonUtil.getUUID());
                }
                obj.setAuditStatus(auditStatus);

                if (auditStatus != null && 2 == auditStatus) {
                    lockStatus = 2;//审核不通过，自动解锁条目，让用户可以修改
                }

                obj.setLockStatus(lockStatus);
                obj.setFieldVal(vStrArr[i]);//新增,ke edit
                if (("on").equals(idArr[i])) {
                    //设置item_id start以上次为基准，如果上次为0，则这次为1；
                    int _itemId;
                    AuditRecordCommunication temp = new AuditRecordCommunication();
                    temp.setUserId(userId);
                    List<AuditRecordCommunication> tempList =  service.getList(temp);//降序
                    if (tempList.size() > 0) {
                        _itemId = tempList.get(0).getItemId();
                    }else {
                        _itemId = 1;
                    }
                    obj.setFieldKey(vNameArr[i]);
                    obj.setItemId(_itemId);
                    obj.setUserId(userId);
                    //设置item_id end
                    service.insert(obj);
                }
                else {
                    service.update(obj);
                }
                idArr[i] = obj.getId();

                //设置手机号start
                AuditRecordCommunication auditRecordCommunication = service.get(idArr[i]);
                if (("mobilePhone").equals(auditRecordCommunication.getFieldKey())) {
                    old_mobilePhone = auditRecordCommunication.getFieldVal();
                }else {
                    old_mobilePhone = temp_mobilePhone;
                }
                //设置手机号end

                if (auditStatus != null) {
                    if (1 == auditStatus) {
                        Communication pmsUser = auditRecordCommunication.toAnother();
                        pmsUser.setId(userId);
                        pmsUser.setMobilePhone(old_mobilePhone);//新增
                        if (communicationService.get(pmsUser) != null) {
                            communicationService.update(pmsUser);
                        }else {
                            communicationService.insert(pmsUser);
                        }
                    }
                    if (2 == auditStatus) {
                        AuditRecordCommunication toShow = new AuditRecordCommunication();
                        toShow.setUserId(userId);
                        toShow.setAuditStatus(1);
                        toShow.setFieldKey(auditRecordCommunication.getFieldKey());
                        List<AuditRecordCommunication> toShows = service.getList(toShow);
                        Communication pmsUser;
                        if (toShows.size() > 0) {
                            pmsUser = toShows.get(0).toAnother();
                        }else{
                            //没有审核通过的记录，把信息置为空
                            pmsUser = auditRecordCommunication.noOkItem();
                        }
                        pmsUser.setId(userId);
                        pmsUser.setMobilePhone(old_mobilePhone);//新增
                        communicationService.update(pmsUser);
                    }
                }
            }
        }else{
            result.setCode(-1);
            result.setInfo("操作失败：编号无效!");
        }

        //对人员审核判断
        AuditShowUser AuditShowUser = new AuditShowUser();
        AuditShowUser.setUserId(userId);
        if (auditShowUserService.getList(AuditShowUser).size() > 0) {

        }else {
            auditShowUserService.insert(AuditShowUser);
        }
        AuditShowUser.setPersonalShow(0);
        //start
        AuditRecordBaseinfo AuditRecordBaseinfo = new AuditRecordBaseinfo();
        AuditRecordBaseinfo.setUserId(userId);
        //TODO 用户修改和审核不一样，使用库中最新的item_id 判断是否需要显示用户
        List<AuditRecordBaseinfo> tempList =  auditRecordBaseinfoService.getList(AuditRecordBaseinfo);//降序
        if (tempList.size() > 0) {
            AuditRecordBaseinfo.setItemId(tempList.get(0).getItemId());
            AuditRecordBaseinfo.setAuditStatus(5);
            if (auditRecordBaseinfoService.getList(AuditRecordBaseinfo).size() > 0) {
                AuditShowUser.setPersonalShow(1);
            }
        }

        AuditRecordCommunication AuditRecordCommunication = new AuditRecordCommunication();
        AuditRecordCommunication.setUserId(userId);
        List<AuditRecordCommunication> tempList1 =  service.getList(AuditRecordCommunication);//降序
        if (tempList1.size() > 0) {
            AuditRecordCommunication.setItemId(tempList1.get(0).getItemId());
            AuditRecordCommunication.setAuditStatus(5);
            if (service.getList(AuditRecordCommunication).size() > 0) {
                AuditShowUser.setPersonalShow(1);
            }
        }

        AuditPmsRelations AuditPmsRelations = new AuditPmsRelations();
        AuditPmsRelations.setStatus(5);
        AuditPmsRelations.setUserId(userId);
        if (auditPmsRelationsService.getList(AuditPmsRelations).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsEducation AuditPmsEducation = new AuditPmsEducation();
        AuditPmsEducation.setUserId(userId);
        AuditPmsEducation.setStatus(5);
        if (auditPmsEducationService.getList(AuditPmsEducation).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsWork AuditPmsWork = new AuditPmsWork();
        AuditPmsWork.setUserId(userId);
        AuditPmsWork.setStatus(5);
        if (auditPmsWorkService.getList(AuditPmsWork).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsMainTechGroup AuditPmsMainTechGroup = new AuditPmsMainTechGroup();
        AuditPmsMainTechGroup.setUserId(userId);
        AuditPmsMainTechGroup.setStatus(5);
        if (auditPmsMainTechGroupService.getList(AuditPmsMainTechGroup).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsHonorTitle AuditPmsHonorTitle = new AuditPmsHonorTitle();
        AuditPmsHonorTitle.setUserId(userId);
        AuditPmsHonorTitle.setStatus(5);
        if (auditPmsHonorTitleService.getList(AuditPmsHonorTitle).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsTechAwards AuditPmsTechAwards = new AuditPmsTechAwards();
        AuditPmsTechAwards.setUserId(userId);
        AuditPmsTechAwards.setStatus(5);
        if (auditPmsTechAwardsService.getList(AuditPmsTechAwards).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsPaper AuditPmsPaper = new AuditPmsPaper();
        AuditPmsPaper.setUserId(userId);
        AuditPmsPaper.setStatus(5);
        if (auditPmsPaperService.getList(AuditPmsPaper).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsPublish AuditPmsPublish = new AuditPmsPublish();
        AuditPmsPublish.setUserId(userId);
        AuditPmsPublish.setStatus(5);
        if (auditPmsPublishService.getList(AuditPmsPublish).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsPatent AuditPmsPatent = new AuditPmsPatent();
        AuditPmsPatent.setUserId(userId);
        AuditPmsPatent.setStatus(5);
        if (auditPmsPatentService.getList(AuditPmsPatent).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsJoinProject AuditPmsJoinProject = new AuditPmsJoinProject();
        AuditPmsJoinProject.setUserId(userId);
        AuditPmsJoinProject.setStatus(5);
        if (auditPmsJoinProjectService.getList(AuditPmsJoinProject).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsTechnologyBrace AuditPmsTechnologyBrace = new AuditPmsTechnologyBrace();
        AuditPmsTechnologyBrace.setUserId(userId);
        AuditPmsTechnologyBrace.setStatus(5);
        if (auditPmsTechnologyBraceService.getList(AuditPmsTechnologyBrace).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsSupportProject AuditPmsSupportProject = new AuditPmsSupportProject();
        AuditPmsSupportProject.setUserId(userId);
        AuditPmsSupportProject.setStatus(5);
        if (auditPmsSupportProjectService.getList(AuditPmsSupportProject).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsYearCheck AuditPmsYearCheck = new AuditPmsYearCheck();
        AuditPmsYearCheck.setUserId(userId);
        AuditPmsYearCheck.setStatus(5);
        if (auditPmsYearCheckService.getList(AuditPmsYearCheck).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        System.out.println("最后为：" + AuditShowUser.getPersonalShow());
        auditShowUserService.update(AuditShowUser);
        //end

        return result;
    }



    /**
     * 用户修改提交审核，一直插入
     * @param pData
     * @param request
     * @return
     * @throws Exception
     */
    @Log("用户修改信息提交审核")
    @RequestMapping("/userUpdate")
    @ResponseBody
//    {"id":"1","oldName":"李晓峰1","placeOfOrigin":"河北1","workStartTime":"2018-07-26"}提交所有数据
    public Object userUpdate(String pData, HttpServletRequest request) throws Exception{
        String rs = request.getParameter("sf");
        Result result = new Result();
        JSONObject obj = JSONObject.fromObject(pData);

        Iterator iterator = obj.keys();
        String userId = obj.get("id").toString();

        //修复ums_user.mapper的updateuserobj   start
        // 异常内容：UPDATE TB_UMS_USER WHERE ID='1'
        // 解决方法：随便传递一个必要字段如果NULL则设置为""
        Communication commu = new Communication();
        commu.setId(userId);
        Communication old_commu = communicationService.get(commu);
        String old_mobilePhone;
        if (old_commu != null) {
            old_mobilePhone = old_commu.getMobilePhone();
        }else {
            old_mobilePhone = "";
        }
        String temp_mobilePhone = old_mobilePhone;

        //修复结束 end

        //设置item_id start以上次为基准，如果上次为0，则这次为1；
        int itemId;
        AuditRecordCommunication temp = new AuditRecordCommunication();
        temp.setUserId(userId);
        List<AuditRecordCommunication> tempList =  service.getList(temp);//降序
        if (tempList.size() > 0) {
            itemId = tempList.get(0).getItemId() + 1;
        }else {
            itemId = 1;
        }
        //设置item_id end
        while (iterator.hasNext()) {
            String key = iterator.next().toString();
            String val = obj.getString(key);

            if (("mobilePhone").equals(key)) {
                old_mobilePhone = val;
            }else {
                old_mobilePhone = temp_mobilePhone;
            }

            //用户修改直接插入，字段和上次一样则用上次的状态，
            //获取上次记录start
            //TODO 根据用户ID判断，如果不存在（第一次插入），则使用状态5，2
            AuditRecordCommunication AuditRecordBaseinfo = new AuditRecordCommunication();
            AuditRecordBaseinfo.setUserId(userId);
            AuditRecordBaseinfo.setFieldKey(key);
            List<AuditRecordCommunication> list =  service.getList(AuditRecordBaseinfo);//降序
            //获取上次记录 end
            int counts = list.size();
            int status;
            int lockStatus;
            if (counts > 0) {
                AuditRecordCommunication recordBaseinfo = list.get(0);
                lockStatus = recordBaseinfo.getLockStatus();
                if (val.equals(recordBaseinfo.getFieldVal())) {
                    status = recordBaseinfo.getAuditStatus();
                    //新增：如果数值一样，用户还是提交，库中字段为审核不通过2，则将状态置为待审核5
                    if (status == 2) {
                        status = 5;
                    }
                }else {
                    status = 5;
                }
            }else {
                status = 5;
                lockStatus = 2;
            }

/*            if (("rs").equals(rs)) {
                lockStatus = 1;
            }*/
            AuditRecordBaseinfo.setLockStatus(lockStatus);
            AuditRecordBaseinfo.setItemId(itemId);
            AuditRecordBaseinfo.setFieldVal(val);//设置字段值


            //判断是否需要审核，不需要审核就更改正式库信息，正式库信息只用于对外显示。
            AuditField AuditField = new AuditField();//判断是否需要审核
            AuditField.setTableName("pms_communication");//判断是否需要审核
            AuditField.setTableField(key);

            //新增RS条件判断
            if (auditFieldService.get(AuditField) == null || auditFieldService.get(AuditField).getStatus() != 1 || ("rs").equals(rs)) {
                Communication pmsUser = AuditRecordBaseinfo.toAnother();
                pmsUser.setId(userId);
                pmsUser.setMobilePhone(old_mobilePhone);
                if (communicationService.get(pmsUser) != null) {
                    communicationService.update(pmsUser);
                }else {
                    communicationService.insert(pmsUser);
                }
                status = 1;
            }
            //每次修改插入记录库
/*            if (("rs").equals(rs)) {
                status = 1;
            }*/
            AuditRecordBaseinfo.setAuditStatus(status);//TODO 最后设置
            service.insert(AuditRecordBaseinfo);//TODO 最后插
        }

        //对人员审核判断
        AuditShowUser AuditShowUser = new AuditShowUser();
        AuditShowUser.setUserId(userId);
        if (auditShowUserService.getList(AuditShowUser).size() > 0) {

        }else {
            auditShowUserService.insert(AuditShowUser);
        }
        AuditShowUser.setPersonalShow(0);
        //start
        AuditRecordBaseinfo AuditRecordBaseinfo = new AuditRecordBaseinfo();
        AuditRecordBaseinfo.setUserId(userId);
        List<AuditRecordBaseinfo> listBaseRec = auditRecordBaseinfoService.getList(AuditRecordBaseinfo);
        if (listBaseRec.size() > 0) {
            int comItemId = listBaseRec.get(0).getItemId();
            AuditRecordBaseinfo.setItemId(comItemId);
            AuditRecordBaseinfo.setAuditStatus(5);
            if (auditRecordBaseinfoService.getList(AuditRecordBaseinfo).size() > 0) {
                AuditShowUser.setPersonalShow(1);
            }
            System.out.println("用户"+userId+"有基本信息审核记录最后一次为" + comItemId);
        }else {
            System.out.println("用户没有基本信息审核记录" + userId);
        }

        AuditRecordCommunication AuditRecordCommunication = new AuditRecordCommunication();
        AuditRecordCommunication.setAuditStatus(5);
        AuditRecordCommunication.setItemId(itemId);
        AuditRecordCommunication.setUserId(userId);
        System.out.println("用户"+userId+"通讯信息最后审核条目ID" + itemId);
        if (service.getList(AuditRecordCommunication).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsRelations AuditPmsRelations = new AuditPmsRelations();
        AuditPmsRelations.setStatus(5);
        AuditPmsRelations.setUserId(userId);
        if (auditPmsRelationsService.getList(AuditPmsRelations).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsEducation AuditPmsEducation = new AuditPmsEducation();
        AuditPmsEducation.setUserId(userId);
        AuditPmsEducation.setStatus(5);
        if (auditPmsEducationService.getList(AuditPmsEducation).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsWork AuditPmsWork = new AuditPmsWork();
        AuditPmsWork.setUserId(userId);
        AuditPmsWork.setStatus(5);
        if (auditPmsWorkService.getList(AuditPmsWork).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsMainTechGroup AuditPmsMainTechGroup = new AuditPmsMainTechGroup();
        AuditPmsMainTechGroup.setUserId(userId);
        AuditPmsMainTechGroup.setStatus(5);
        if (auditPmsMainTechGroupService.getList(AuditPmsMainTechGroup).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsHonorTitle AuditPmsHonorTitle = new AuditPmsHonorTitle();
        AuditPmsHonorTitle.setUserId(userId);
        AuditPmsHonorTitle.setStatus(5);
        if (auditPmsHonorTitleService.getList(AuditPmsHonorTitle).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsTechAwards AuditPmsTechAwards = new AuditPmsTechAwards();
        AuditPmsTechAwards.setUserId(userId);
        AuditPmsTechAwards.setStatus(5);
        if (auditPmsTechAwardsService.getList(AuditPmsTechAwards).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsPaper AuditPmsPaper = new AuditPmsPaper();
        AuditPmsPaper.setUserId(userId);
        AuditPmsPaper.setStatus(5);
        if (auditPmsPaperService.getList(AuditPmsPaper).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsPublish AuditPmsPublish = new AuditPmsPublish();
        AuditPmsPublish.setUserId(userId);
        AuditPmsPublish.setStatus(5);
        if (auditPmsPublishService.getList(AuditPmsPublish).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsPatent AuditPmsPatent = new AuditPmsPatent();
        AuditPmsPatent.setUserId(userId);
        AuditPmsPatent.setStatus(5);
        if (auditPmsPatentService.getList(AuditPmsPatent).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsJoinProject AuditPmsJoinProject = new AuditPmsJoinProject();
        AuditPmsJoinProject.setUserId(userId);
        AuditPmsJoinProject.setStatus(5);
        if (auditPmsJoinProjectService.getList(AuditPmsJoinProject).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsTechnologyBrace AuditPmsTechnologyBrace = new AuditPmsTechnologyBrace();
        AuditPmsTechnologyBrace.setUserId(userId);
        AuditPmsTechnologyBrace.setStatus(5);
        if (auditPmsTechnologyBraceService.getList(AuditPmsTechnologyBrace).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsSupportProject AuditPmsSupportProject = new AuditPmsSupportProject();
        AuditPmsSupportProject.setUserId(userId);
        AuditPmsSupportProject.setStatus(5);
        if (auditPmsSupportProjectService.getList(AuditPmsSupportProject).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsYearCheck AuditPmsYearCheck = new AuditPmsYearCheck();
        AuditPmsYearCheck.setUserId(userId);
        AuditPmsYearCheck.setStatus(5);
        if (auditPmsYearCheckService.getList(AuditPmsYearCheck).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        System.out.println("最后为：" + AuditShowUser.getPersonalShow());
        auditShowUserService.update(AuditShowUser);
        //end

        return result;
    }



    /**
    * 删除
    * @param ids
    * @param id
    * @param request
    * @return
    * @throws Exception
    */
    @Log("删除xxx")
    @RequestMapping("/delete")
    @ResponseBody
    public Object delete(String ids, String id, HttpServletRequest request) throws Exception{
        Result result = new Result();
        if(StringUtils.isNotBlank(ids)) {
            String[] idArr = ids.split(",");
            service.delete(idArr);
        }else if(StringUtils.isNotBlank(id)){
            service.delete(id);
        }else{
            result.setCode(-1);
            result.setInfo("删除失败:待删除编号无效!");
        }
        return result;
    }

    /**
    * 导入
    * @param file
    * @param request
    * @return
    * @throws Exception
    */
    @Log("导入xxx")
    @RequestMapping("/import")
    @ResponseBody
    public Object importExcel(MultipartFile file, HttpServletRequest request) throws Exception{
        Result result = new Result();
        try {
            if (file != null && !file.isEmpty()) {
                //excel导入处理,返回excel中的数据集合
                IExcelImport ei = new ExcelImport(file);//将文件转为ExcelImport对象
                //从excel读取数据
                List<AuditRecordCommunication> list = ei.getImportDataAsBean(AuditRecordCommunication.class);
                if (list != null && list.size() > 0){
                    int num = service.batchInsert(list);//批量插入
                    result.setInfo("成功导入数据" + num + "条!");
                }else {
                    result.setCode(-1);
                    result.setInfo("导入失败:excel解析后结果为空!");
                }
            } else {
                result.setCode(-1);
                result.setInfo("导入失败:文件为空!");
            }
        } catch (IOException e) {
            e.printStackTrace();
            result.setCode(-1);
            result.setInfo("导入失败!");
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
            result.setCode(-1);
            result.setInfo("导入失败!");
        } catch (Exception e) {
            e.printStackTrace();
            result.setCode(-1);
            result.setInfo("导入失败!");
        }
        return result;
    }

    /**
    * 导出
    * @param obj 查询的参数
    * @param request
    * @param response
    * @throws Exception
    */
    @Log("导出xxx")
    @RequestMapping("/export")
    public void exportExcel(AuditRecordCommunication obj, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<AuditRecordCommunication> list = service.getList(obj);
        if (list != null && list.size() > 0){
            IExcelExport ee = new ExcelExport();
            ee.insertBeanList(list, AuditRecordCommunication.class);
            ee.write2Response(response, "excel_" + System.currentTimeMillis() + ".xls");
        }else{
            response.getWriter().write("数据为空!");
        }
    }

}