package com.yy.young.pms.web;

import com.alibaba.druid.support.json.JSONParser;
import com.yy.young.cms.model.Column;
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
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JSONString;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

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
@RequestMapping("/pms/auditFieldBase")
public class AuditFieldBaseController {

    @Resource(name="auditFieldBaseService")
    IAuditFieldBaseService service;

    @Resource(name = "pmsUserService")
    IPmsUserExtService pmsUserService;

    @Resource(name = "pmsUserService")
    ICommonService<PmsUser> pmsUserService2;

    @Resource(name="auditPmsCommunicationService")
    IAuditPmsCommunicationService auditPmsCommunicationService;

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

    @Resource(name="auditRecordBaseinfoService")
    IAuditRecordBaseinfoService auditRecordBaseinfoService;

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
    public Object getList(AuditFieldBase obj, HttpServletRequest request) throws Exception{
        List<AuditFieldBase> list = service.getList(obj);
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
    public Object getPage(AuditFieldBase obj, HttpServletRequest request) throws Exception{
        Page page = CommonUtil.getPageFromRequest(request);
        List<AuditFieldBase> list = service.getPage(obj, page);
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
        AuditFieldBase obj = service.get(id);
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
    public Object count(AuditFieldBase obj, HttpServletRequest request) throws Exception{
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
    public Object insert(AuditFieldBase obj, HttpServletRequest request) throws Exception{
        service.insert(obj);
        return new Result();
    }

    @Log("将过去信息加入审核库")
    @RequestMapping("/oldToAudit")
    @ResponseBody
    public Object oldToAudit(AuditFieldBase obj, HttpServletRequest request) throws Exception{
        List<PmsUser> educationList = pmsUserService2.getList(new PmsUser());
        for (PmsUser item : educationList) {
            JSONObject jsonObject = JSONObject.fromObject(item);
            Iterator keys = jsonObject.keys();
            String userId = jsonObject.getString("id");
            while(keys.hasNext()) {
                String key = keys.next().toString();
                String val = jsonObject.getString(key);
                AuditFieldBase auditFieldBase = new AuditFieldBase();
                auditFieldBase.setField(key);
                auditFieldBase.setUserId(userId);
                int size = service.getList(auditFieldBase).size();
                auditFieldBase.setFieldVal(val);
                if (("id").equals(key) || ("userId").equals(key) || ("num").equals(key) || ("photoAddress").equals(key) || ("trashFlag").equals(key) ) {
                    auditFieldBase.setStatus(1);
                }else {
                    auditFieldBase.setStatus(5);
                }
                if (size > 0) {
                    service.update(auditFieldBase);
                }else {
                    service.insert(auditFieldBase);
                }
            }
        }
        return new Result();
    }

    /**
     * 修改
     * @param pData
     * @param request
     * @return
     * @throws Exception
     */
    @Log("用户修改信息提交审核")
    @RequestMapping("/userUpdate")
    @ResponseBody
//    {"id":"1","oldName":"李晓峰1","placeOfOrigin":"河北1","workStartTime":"2018-07-26"}提交所有
    public Object userUpdate(String pData, HttpServletRequest request) throws Exception{
        Result result = new Result();
        System.out.println("传递过来的数据（用户修改信息提交审核）："+pData);
        JSONObject obj = JSONObject.fromObject(pData);

        System.out.println("用户ID（用户修改信息提交审核）:" + obj.get("id"));

        Iterator iterator = obj.keys();
        String userId = obj.get("id").toString();
        while (iterator.hasNext()) {
            String key = iterator.next().toString();
            String val = obj.getString(key);
            System.out.println("获取到的字段名：" + key + "     字段值：" + val);
            //根据用户ID和字段名判断审核库中是否含有，含有则修改
            AuditFieldBase auditFieldBase = new AuditFieldBase();
            auditFieldBase.setUserId(userId);
            auditFieldBase.setField(key);
            List<AuditFieldBase> list =  service.getList(auditFieldBase);
            int counts = list.size();
            if (!key.equals("deptList")) {
                auditFieldBase.setFieldVal(val);//设置字段值，先不判断部门信息
            }

            //设置条目审核状态，是否需要通知管理员审核，==5为待审核，start
            //判断依据：条目不存在、条目值不一样则为待审核。

            String UUID = CommonUtil.getUUID();
            if (counts > 0) {
                System.out.println("有");
                String oval = list.get(0).getFieldVal();
                if (oval != null) {
                }else {
                    oval = "";
                }
                if (val != null) {
                }else {
                    val = "";
                }
                System.out.println("两个值是否一样,原值：" + oval + "  现值：" + val);
                if (!oval.equals(val)) {
                    //审核库有，但是值不一样

                    auditFieldBase.setStatus(5);
                    AuditRecordBaseinfo auditRecordBaseinfo = auditFieldBase.toRecord();
                    auditRecordBaseinfo.setId(UUID);
                    //用户真真修改，插入记录库，让管理员改状态
                    auditRecordBaseinfoService.insert(auditRecordBaseinfo);
                    System.out.println("插入记录库时候的1值" + auditFieldBase.getId() + "审核状态：" + auditFieldBase.getStatus());
                }
            }else {
                System.out.println("无");
                //审核库中无
                auditFieldBase.setStatus(5);
                AuditRecordBaseinfo auditRecordBaseinfo = auditFieldBase.toRecord();
                auditRecordBaseinfo.setId(UUID);
                //用户真真修改，插入记录库，让管理员改状态
                auditRecordBaseinfoService.insert(auditRecordBaseinfo);
                System.out.println("插入记录库时候的2值" + UUID + "审核状态：" + auditFieldBase.getStatus());
            }
            //设置条目审核状态，是否需要通知管理员审核，==5为待审核，end
            AuditField AuditField = new AuditField();//判断是否需要审核
            AuditField.setTableName("pms_user");//判断是否需要审核
            AuditField.setTableField(key);

            if (counts > 0) {

                System.out.println("单一字段：数据库中有");
                System.out.println("单一字段状态：字段名称：" + key + "字段值：" + val);
                auditFieldBase.setId(list.get(0).getId());
                System.out.println("status" + auditFieldBase.getStatus());
                System.out.println("status" + auditFieldBase.getId());
                //新增判断是否需要审核start

                System.out.println("字段不需要审核" + key + "   Y/N? " + (auditFieldService.get(AuditField) == null || auditFieldService.get(AuditField).getStatus() != 1));
                if (auditFieldService.get(AuditField) == null || auditFieldService.get(AuditField).getStatus() != 1) {
                    //不需要审核，可以直接修改正式库
                    System.out.println("不需要审核更改正式库：start");
                    System.out.println("----------修改内容相关信息------------");
                    System.out.println("字段名称：" + key + "字段值：" + val + auditFieldBase.getUserId());
                    PmsUser pmsUser = auditFieldBase.toAnother();
                    pmsUser.setId(auditFieldBase.getUserId());
                    pmsUserService2.update(pmsUser);
                    System.out.println("不需要审核更改正式库：end");
                    auditFieldBase.setStatus(1);//直接设置为审核通过
                    //新增：不需要审核，更改记录审核状态start
                    System.out.println("不需要审核");
                    System.out.println("更改记录审核状态：" + auditFieldBase.getId()+ "  key:" + key + "审核状态：" + auditFieldBase.getStatus());
                    AuditRecordBaseinfo auditRecordBaseinfo = auditFieldBase.toRecord();
                    auditRecordBaseinfo.setId(UUID);
                    auditRecordBaseinfoService.update(auditRecordBaseinfo);

                    //新增：不需要审核，更改记录审核状态start
                }
                //新增判断是否需要审核end
                service.update(auditFieldBase);//此时已经更改两个库，不需要审核的信息应该是相同的
            }else {
                //此处对于修改方来说,插入修改信息，先修改才有审核
                System.out.println("单一字段：数据库无则插入：" + auditFieldBase.getStatus() + "字段名称：" + auditFieldBase.getField() + "字段值：" + auditFieldBase.getFieldVal());
                //不需要审核更改状态1  start
                if (auditFieldService.get(AuditField) == null || auditFieldService.get(AuditField).getStatus() != 1) {
                    auditFieldBase.setStatus(1);//直接通过
                    PmsUser pmsUser = auditFieldBase.toAnother();
                    pmsUser.setId(auditFieldBase.getUserId());
                    pmsUserService2.update(pmsUser);
                    //新增：不需要审核，更改记录审核状态start
                    System.out.println("更改记录审核状态2：" + UUID + "审核状态：" + auditFieldBase.getStatus());
                    AuditRecordBaseinfo auditRecordBaseinfo = auditFieldBase.toRecord();
                    auditRecordBaseinfo.setId(UUID);
                    auditRecordBaseinfoService.update(auditRecordBaseinfo);
                    //新增：不需要审核，更改记录审核状态start
                }
                service.insert(auditFieldBase);
                //不需要审核则更改状态1 end
            }
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
        AuditFieldBase AuditFieldBase = new AuditFieldBase();
        AuditFieldBase.setStatus(5);
        AuditFieldBase.setUserId(userId);
        if (service.getList(AuditFieldBase).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditFieldCommu AuditFieldCommu = new AuditFieldCommu();
        AuditFieldCommu.setStatus(5);
        AuditFieldCommu.setUserId(userId);
        if (auditFieldCommuService.getList(AuditFieldCommu).size() > 0) {
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

        AuditPmsSelfEvaluation AuditPmsSelfEvaluation = new AuditPmsSelfEvaluation();
        AuditPmsSelfEvaluation.setId(userId);
        AuditPmsSelfEvaluation.setStatus(5);
        if (auditPmsSelfEvaluationService.getList(AuditPmsSelfEvaluation).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsLeaderEvaluation AuditPmsLeaderEvaluation = new AuditPmsLeaderEvaluation();
        AuditPmsLeaderEvaluation.setUserId(userId);
        AuditPmsLeaderEvaluation.setStatus(5);
        if (auditPmsLeaderEvaluationService.getList(AuditPmsLeaderEvaluation).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        System.out.println("showuser人员ID；" + userId + "如果是1则展示：" + AuditShowUser.getPersonalShow());

        auditShowUserService.update(AuditShowUser);
        //end

        return result;
    }

    /**
     * 修改,
     * @param
     * @param request
     * @return
     * @throws Exception
     */
    @Log("修改xxx")
    @RequestMapping("/changeStatus")
    @ResponseBody
    public Object changeStatus(String ids,Integer auditStatus,Integer lockStatus,String userId, HttpServletRequest request) throws Exception{
        Result result = new Result();
        System.out.println("传递过来的ids：" + ids);
        System.out.println("传递过来的用户ID：" + userId);
        System.out.println("传递过来的数据锁定状态：" + lockStatus);
        System.out.println("传递过来的数据审核状态：" + auditStatus);
        if(StringUtils.isNotBlank(ids)) {
            String[] idArr = ids.split(",");
            for (int i=0;i<idArr.length;i++) {
                AuditFieldBase obj = new AuditFieldBase();
                obj.setId(idArr[i]);
                obj.setStatus(auditStatus);
                obj.setLockStatus(lockStatus);
                service.update(obj);
            }
        }else{
            result.setCode(-1);
            result.setInfo("删除失败:待删除编号无效!");
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
        AuditFieldBase AuditFieldBase = new AuditFieldBase();
        AuditFieldBase.setStatus(5);
        AuditFieldBase.setUserId(userId);
        if (service.getList(AuditFieldBase).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditFieldCommu AuditFieldCommu = new AuditFieldCommu();
        AuditFieldCommu.setStatus(5);
        AuditFieldCommu.setUserId(userId);
        if (auditFieldCommuService.getList(AuditFieldCommu).size() > 0) {
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

        AuditPmsSelfEvaluation AuditPmsSelfEvaluation = new AuditPmsSelfEvaluation();
        AuditPmsSelfEvaluation.setId(userId);
        AuditPmsSelfEvaluation.setStatus(5);
        if (auditPmsSelfEvaluationService.getList(AuditPmsSelfEvaluation).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsLeaderEvaluation AuditPmsLeaderEvaluation = new AuditPmsLeaderEvaluation();
        AuditPmsLeaderEvaluation.setUserId(userId);
        AuditPmsLeaderEvaluation.setStatus(5);
        if (auditPmsLeaderEvaluationService.getList(AuditPmsLeaderEvaluation).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        System.out.println("showuser人员ID；" + userId + "修改后" + AuditShowUser.getPersonalShow());

        auditShowUserService.update(AuditShowUser);
        //end

        return result;
    }

    /**
    * 修改,此方法废弃，普通人员和审核人员分离
    * @param pData
    * @param request
    * @return
    * @throws Exception
    */
    @Log("修改xxx")
    @RequestMapping("/update")
    @ResponseBody
//    {""pdata:{"dep" : "xxx","name":"zhangsna"}}
    public Object update(String pData, HttpServletRequest request) throws Exception{
        Result result = new Result();
        System.out.println("ppp"+pData);
        JSONObject obj = JSONObject.fromObject(pData);


        if (!obj.has("status")) {
            obj.put("status",5);
        }

        System.out.println("AUDITFIELD:" + obj.get("id"));

        Iterator iterator = obj.keys();
        String userId = obj.get("id").toString();
        while (iterator.hasNext()) {
            String key = iterator.next().toString();
            String val = obj.getString(key);
            System.out.println("初步into：" + obj.get("status") + "字段名称：" + key + "字段值：" + val);
            //判断数据库中是否含有，含有则修改
            AuditFieldBase auditFieldBase = new AuditFieldBase();
            auditFieldBase.setUserId(userId);
            auditFieldBase.setField(key);
            List<AuditFieldBase> list =  service.getList(auditFieldBase);

            if (!key.equals("deptList")) {
               auditFieldBase.setFieldVal(val);
            }
            auditFieldBase.setStatus((Integer) obj.get("status"));

            AuditField AuditField = new AuditField();//判断是否需要审核
            AuditField.setTableName("pms_user");//判断是否需要审核
            AuditField.setTableField(key);

            if (list.size() > 0) {

                System.out.println("单一字段：数据库中有");
                System.out.println("单一字段状态：" + obj.get("status") + "字段名称：" + key + "字段值：" + val);
                auditFieldBase.setId(list.get(0).getId());
                System.out.println("status" + auditFieldBase.getStatus());
                System.out.println("status" + auditFieldBase.getId());
                //新增判断是否需要审核start

                System.out.println("字段是否需要审核" + key + "   Y/N? " + (auditFieldService.get(AuditField) == null || auditFieldService.get(AuditField).getStatus() != 1));
                if (auditFieldService.get(AuditField) == null || auditFieldService.get(AuditField).getStatus() != 1) {
                    //不需要审核，可以直接修改正式库
                    System.out.println("不需要审核更改正式库：start");
                    System.out.println("----------修改内容相关信息------------");
                    System.out.println("" + obj.getInt("status") + "字段名称：" + key + "字段值：" + val + auditFieldBase.getUserId());
                    System.out.println("不需要审核更改正式库：end");
                    PmsUser pmsUser = auditFieldBase.toAnother();
                    pmsUser.setId(auditFieldBase.getUserId());
                    pmsUserService2.update(pmsUser);
                    auditFieldBase.setStatus(1);//直接设置为审核通过
                }
                //新增判断是否需要审核end
                service.update(auditFieldBase);//此时已经更改两个库，不需要审核的信息应该是相同的
                if (obj.getInt("status") == 1) {
                    System.out.println("更改正式库：start");
                    System.out.println("----------修改内容相关信息------------");
                    System.out.println("" + obj.getInt("status") + "字段名称：" + key + "字段值：" + val + auditFieldBase.getUserId());
                    System.out.println("更改正式库：end");
                    PmsUser pmsUser = auditFieldBase.toAnother();
                    pmsUser.setId(auditFieldBase.getUserId());
                    pmsUserService2.update(pmsUser);
                }
            }else {
                //此处对于修改方来说,插入修改信息，先修改才有审核
                System.out.println("单一字段：数据库无则插入");
                System.out.println("单一字段：数据库无则插入：" + auditFieldBase.getStatus() + "字段名称：" + auditFieldBase.getField() + "字段值：" + auditFieldBase.getFieldVal());
                //不需要审核更改状态0  start
                if (auditFieldService.get(AuditField) == null || auditFieldService.get(AuditField).getStatus() != 1) {
                    auditFieldBase.setStatus(1);//直接通过
                    PmsUser pmsUser = auditFieldBase.toAnother();
                    pmsUser.setId(auditFieldBase.getUserId());
                    pmsUserService2.update(pmsUser);
                }
                //不需要审核则更改状态0 end

                service.insert(auditFieldBase);
            }
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
        AuditFieldBase AuditFieldBase = new AuditFieldBase();
        AuditFieldBase.setStatus(5);
        AuditFieldBase.setUserId(userId);
        if (service.getList(AuditFieldBase).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditFieldCommu AuditFieldCommu = new AuditFieldCommu();
        AuditFieldCommu.setStatus(5);
        AuditFieldCommu.setUserId(userId);
        if (auditFieldCommuService.getList(AuditFieldCommu).size() > 0) {
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

        AuditPmsSelfEvaluation AuditPmsSelfEvaluation = new AuditPmsSelfEvaluation();
        AuditPmsSelfEvaluation.setId(userId);
        AuditPmsSelfEvaluation.setStatus(5);
        if (auditPmsSelfEvaluationService.getList(AuditPmsSelfEvaluation).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        AuditPmsLeaderEvaluation AuditPmsLeaderEvaluation = new AuditPmsLeaderEvaluation();
        AuditPmsLeaderEvaluation.setUserId(userId);
        AuditPmsLeaderEvaluation.setStatus(5);
        if (auditPmsLeaderEvaluationService.getList(AuditPmsLeaderEvaluation).size() > 0) {
            AuditShowUser.setPersonalShow(1);
        }

        System.out.println("showuser人员ID；" + userId + "修改后" + AuditShowUser.getPersonalShow());

        auditShowUserService.update(AuditShowUser);
        //end

        return result;
    }

    /**
     * 获取用户审核信息，用于用户查看时信息对比请求USERID，返回信息不相同改变状态而且判断一下状态。
     */
    @Log("获取用户审核信息")
    @RequestMapping("/getUserAuditInfo")
    @ResponseBody
    public Object getUserAuditInfo (AuditFieldBase obj,HttpServletRequest request) throws Exception {
        System.out.println("获取用户审核信息:ID" + obj.getId() + "   状态：" + obj.getStatus() + "     用户ID：" + obj.getUserId());
        List<AuditFieldBase> auditList = service.getList(obj);
        List<Object> list = new ArrayList<Object>();
        list.add(auditList);
        return new Result(list);
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
                List<AuditFieldBase> list = ei.getImportDataAsBean(AuditFieldBase.class);
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
    public void exportExcel(AuditFieldBase obj, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<AuditFieldBase> list = service.getList(obj);
        if (list != null && list.size() > 0){
            IExcelExport ee = new ExcelExport();
            ee.insertBeanList(list, AuditFieldBase.class);
            ee.write2Response(response, "excel_" + System.currentTimeMillis() + ".xls");
        }else{
            response.getWriter().write("数据为空!");
        }
    }

}