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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
* xxx服务
* Created by rookie on 2018-04-03.
*/
@Controller
@RequestMapping("/pms/auditPmsWork")
public class AuditPmsWorkController {

    @Resource(name="auditPmsWorkService")
    IAuditPmsWorkService service;

    @Resource(name = "auditPmsUserService")
    IAuditPmsUserService auditPmsUserService;

    @Resource(name = "pmsUserService")
    ICommonService<PmsUser> pmsUserService;

    @Resource(name = "workService")
    ICommonService<Work> workService;

    @Resource(name="auditFieldService")
    IAuditFieldService auditFieldService;

    @Resource(name="auditShowUserService")
    IAuditShowUserService auditShowUserService;

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

    @Resource(name="auditFieldCommuService")
    IAuditFieldCommuService auditFieldCommuService;

    @Resource(name="auditFieldBaseService")
    IAuditFieldBaseService auditFieldBaseService;

    @Resource(name="auditRecordCommunicationService")
    IAuditRecordCommunicationService auditRecordCommunicationService;

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
    public Object getList(AuditPmsWork obj, HttpServletRequest request) throws Exception{
        List<AuditPmsWork> list = service.getList(obj);
        return new Result(list);
    }

    @Log("将过去信息加入审核库")
    @RequestMapping("/oldToAudit")
    @ResponseBody
    public Object oldToAudit(AuditPmsWork obj, HttpServletRequest request) throws Exception{
        List<Work> educationList = workService.getList(null);
        for (Work item : educationList) {
            if (service.get(item.getId()) != null) {
                service.update(item.toAnother());
            }else {
                service.insert(item.toAnother());
            }
            item.toAnother().setStatus(5);
            service.update(item.toAnother());
        }
        return new Result();
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
    public Object getPage(AuditPmsWork obj, HttpServletRequest request) throws Exception{
        Page page = CommonUtil.getPageFromRequest(request);
        List<AuditPmsWork> list = service.getPage(obj, page);
        page.setData(list);

        //getpage change start
        if (obj != null) {
            String userId = obj.getUserId();
            if (userId != null) {
                AuditShowUser AuditShowUser = new AuditShowUser();
                AuditShowUser.setUserId(userId);

                if (auditShowUserService.getList(AuditShowUser).size() > 0) {

                }else {
                    auditShowUserService.insert(AuditShowUser);
                }
                AuditShowUser.setPersonalShow(0);

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
                AuditRecordCommunication.setUserId(userId);
                List<AuditRecordCommunication> listComRec = auditRecordCommunicationService.getList(AuditRecordCommunication);
                if (listComRec.size() > 0) {
                    int comItemId = listComRec.get(0).getItemId();
                    AuditRecordCommunication.setItemId(comItemId);
                    AuditRecordCommunication.setAuditStatus(5);
                    if (auditRecordCommunicationService.getList(AuditRecordCommunication).size() > 0) {
                        AuditShowUser.setPersonalShow(1);
                    }
                    System.out.println("用户"+userId+"有通讯审核记录最后一次为" + comItemId);
                }else {
                    System.out.println("用户没有通讯审核记录" + userId);
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
                //outer
                System.out.println("最后为：" + AuditShowUser.getPersonalShow());
                auditShowUserService.update(AuditShowUser);
            }
        }
        //end
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
        AuditPmsWork obj = service.get(id);
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
    public Object count(AuditPmsWork obj, HttpServletRequest request) throws Exception{
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
    public Object insert(AuditPmsWork obj, HttpServletRequest request) throws Exception{
        service.insert(obj);

        return new Result();
    }

    @Log("审核新增")
    @RequestMapping("/auditInsert")
    @ResponseBody
    public Object auditInsert(AuditPmsWork obj, HttpServletRequest request) throws Exception{
        String rs = request.getParameter("sf");
        if (("rs").equals(rs)) {
            obj.setStatus(1);//新增：不需要审核直接通过，两张表都插入
//            obj.setLockStatus(1);
            service.insert(obj);
            workService.insert(obj.toAnother());
        }else {
            AuditField AuditField = new AuditField();
            AuditField.setTableName("pms_work");

            //判断是否需要随意填 是start
            if (auditFieldService.get(AuditField) == null || auditFieldService.get(AuditField).getStatus() != 1) {
                obj.setStatus(1);//新增：不需要审核直接通过，两张表都插入
                service.insert(obj);
                workService.insert(obj.toAnother());
            }else {
                obj.setStatus(5);
                service.insert(obj);
                workService.insert(obj.toAnother());
            }
        }


        String userId = obj.getUserId();
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
        AuditRecordCommunication.setUserId(userId);
        List<AuditRecordCommunication> listComRec = auditRecordCommunicationService.getList(AuditRecordCommunication);
        if (listComRec.size() > 0) {
            int comItemId = listComRec.get(0).getItemId();
            AuditRecordCommunication.setItemId(comItemId);
            AuditRecordCommunication.setAuditStatus(5);
            if (auditRecordCommunicationService.getList(AuditRecordCommunication).size() > 0) {
                AuditShowUser.setPersonalShow(1);
            }
            System.out.println("用户"+userId+"有通讯审核记录最后一次为" + comItemId);
        }else {
            System.out.println("用户没有通讯审核记录" + userId);
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
        return new Result();
    }

    @Log("切换锁定状态")
    @RequestMapping("/lockUpdate")
    @ResponseBody
    public Object lockUpdate(AuditPmsWork obj, HttpServletRequest request) throws Exception{
        service.update(obj);
        workService.update(obj.toAnother());
        return new Result();
    }


    /**
    * 修改不需要审核的不插入临时库
    * @param obj
    * @param request
    * @return
    * @throws Exception
    */
    @Log("修改xxx")
    @RequestMapping("/update")
    @ResponseBody
    public Object update(AuditPmsWork obj, HttpServletRequest request) throws Exception{
        String rs = request.getParameter("sf");
        if (("rs").equals(rs)) {
            Work work = new Work();
            work.setUserId(obj.getUserId());
            work.setId(obj.getId());

            if (workService.get(work) != null) {
                obj.setStatus(1);
//                obj.setLockStatus(1);
                workService.update(obj.toAnother());
            }else {
                obj.setStatus(1);
//                obj.setLockStatus(1);
                workService.insert(obj.toAnother());
            }

            if (service.get(work.getId()) != null) {
                obj.setStatus(1);
//                obj.setLockStatus(1);
                service.update(obj);
            }else {
                obj.setStatus(1);
//                obj.setLockStatus(1);
                service.insert(obj);
            }
        }else {
            if (obj.getStatus() == null) {
                //修改编辑不带status参数，设置待审核
                obj.setStatus(5);
            }

            AuditField AuditField = new AuditField();
            AuditField.setTableName("pms_work");

            //判断是否需要随意填 是start
            if (auditFieldService.get(AuditField) == null || auditFieldService.get(AuditField).getStatus() != 1) {
                Work work = new Work();
                work.setUserId(obj.getUserId());
                work.setId(obj.getId());

                if (workService.get(work) != null) {
                    workService.update(obj.toAnother());
                }else {
                    workService.insert(obj.toAnother());
                }

                if (service.get(work.getId()) != null) {
                    service.update(obj);
                }else {
                    service.insert(obj);
                }
                //随便改，end
                //先需要审核后改为不要审核，但是审核库中有数据，直接删除
//            service.delete(obj.getId());//审核库有出现脏数据，不需要审，管理员还在审核
            }else {
                //要审核
                if (service.get(obj.getId()) != null) {
                    service.update(obj);
                }else {
                    service.insert(obj);
                }

                if (workService.get(obj.toAnother()) != null) {
                    workService.update(obj.toAnother());
                }else {
                    workService.insert(obj.toAnother());
                }

                //对于管理员来说
                if (obj.getStatus() == 1) {
                    Work work = new Work();
                    work.setUserId(obj.getUserId());
                    work.setId(obj.getId());
                    if (workService.get(work) != null) {
                        workService.update(obj.toAnother());
                    }else {
                        workService.insert(obj.toAnother());
                    }
                }

            }

        }


        String userId = obj.getUserId();
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
        AuditRecordCommunication.setUserId(userId);
        List<AuditRecordCommunication> listComRec = auditRecordCommunicationService.getList(AuditRecordCommunication);
        if (listComRec.size() > 0) {
            int comItemId = listComRec.get(0).getItemId();
            AuditRecordCommunication.setItemId(comItemId);
            AuditRecordCommunication.setAuditStatus(5);
            if (auditRecordCommunicationService.getList(AuditRecordCommunication).size() > 0) {
                AuditShowUser.setPersonalShow(1);
            }
            System.out.println("用户"+userId+"有通讯审核记录最后一次为" + comItemId);
        }else {
            System.out.println("用户没有通讯审核记录" + userId);
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
        return new Result();
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
            workService.delete(idArr);//新改：两个库都删除
        }else if(StringUtils.isNotBlank(id)){
            service.delete(id);
            workService.delete(id);//新改：两个库都删除
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
                List<AuditPmsWork> list = ei.getImportDataAsBean(AuditPmsWork.class);
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
    public void exportExcel(AuditPmsWork obj, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<AuditPmsWork> list = service.getList(obj);
        if (list != null && list.size() > 0){
            IExcelExport ee = new ExcelExport();
            ee.insertBeanList(list, AuditPmsWork.class);
            ee.write2Response(response, "excel_" + System.currentTimeMillis() + ".xls");
        }else{
            response.getWriter().write("数据为空!");
        }
    }

    /**
     * 主要用于列表类顶部按钮
     * @param ids
     * @param lockStatus
     * @param request
     * @return
     * @throws Exception
     */
    @Log("批量切换锁定状态")
    @RequestMapping("/lockBatchUpdate")
    @ResponseBody
    public Object lockBatchUpdate(String ids,int lockStatus, HttpServletRequest request) throws Exception{
        Result result = new Result();
        if(StringUtils.isNotBlank(ids)) {
            String[] idArr = ids.split(",");
            List<AuditPmsWork> list = new ArrayList<AuditPmsWork>();
            for (int i = 0; i < idArr.length;i++) {
                AuditPmsWork relations = new AuditPmsWork();
                relations.setId(idArr[i]);
                relations.setLockStatus(lockStatus);
                list.add(relations);
            }
            service.batchUpdate(list);
        }else{
            result.setCode(-1);
            result.setInfo("操作失败：编号无效!");
        }
        return result;
    }

    @Log("批量更新xxx")
    @RequestMapping("/batchUpdate")
    @ResponseBody
    public Object batchUpdate(String ids, int status, HttpServletRequest request) throws Exception{
        Result result = new Result();
        if(StringUtils.isNotBlank(ids)) {
            String[] idArr = ids.split(",");
            List<AuditPmsWork> list = new ArrayList<AuditPmsWork>();
            for (int i = 0; i < idArr.length;i++) {
                AuditPmsWork relations = new AuditPmsWork();
                relations.setId(idArr[i]);
                relations.setStatus(status);
                list.add(relations);
            }
            service.batchUpdate(list);
        }else{
            result.setCode(-1);
            result.setInfo("操作失败：编号无效!");
        }
        return result;
    }

    //新增方法
    @Log("管理员批量修改教育、工作")
    @RequestMapping("/rsBatchUpdate")
    @ResponseBody
    public Object rsBatchUpdate(@RequestBody List<AuditPmsWork> list, HttpServletRequest request) throws Exception{
        Result result = new Result();
        service.batchUpdate(list);
        return result;
    }

    @Log("管理员批量修改主要工作，教育")
    @RequestMapping("/rsBatchInsert")
    @ResponseBody
    public Object rsBatchInsert(@RequestBody List<AuditPmsWork> list, HttpServletRequest request) throws Exception{
        Result result = new Result();
        service.batchInsert(list);
        return result;
    }

}