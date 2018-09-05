package com.yy.young.pms.web;

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
import org.apache.poi.ss.formula.functions.T;
import org.springframework.stereotype.Controller;
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
@RequestMapping("/pms/auditPmsUser")
public class AuditPmsUserController {

    @Resource(name = "auditPmsUserService")
    IAuditPmsUserService service;

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

    @Resource(name="auditFieldBaseService")
    IAuditFieldBaseService auditFieldBaseService;

    @Resource(name="auditFieldCommuService")
    IAuditFieldCommuService auditFieldCommuService;

    @Resource(name="auditRecordBaseinfoService")
    IAuditRecordBaseinfoService auditRecordBaseinfoService;

    @Resource(name="auditRecordCommunicationService")
    IAuditRecordCommunicationService auditRecordCommunicationService;

    /**
     * 获取数据列表
     *
     * @param obj
     * @param request
     * @return
     * @throws Exception
     */
    @Log("查询xxx列表")
    @RequestMapping("/getList")
    @ResponseBody
    public Object getList(AuditPmsUser obj, HttpServletRequest request) throws Exception {
        List<AuditPmsUser> list = service.getList(obj);
        return new Result(list);
    }

    /**
     * 获取分页数据
     *
     * @param obj
     * @param request
     * @return
     * @throws Exception
     */
    @Log("分页查询xxx列表")
    @RequestMapping("/getPage")
    @ResponseBody
    public Object getPage(AuditPmsUser obj, HttpServletRequest request) throws Exception {
        Page page = CommonUtil.getPageFromRequest(request);
        obj.setStatus(5);
        List<AuditPmsUser> list = service.getPage(obj, page);
        page.setData(list);
        return page;
    }

    /**
     * 获取单条数据
     *
     * @param id
     * @param request
     * @return
     * @throws Exception
     */
    @Log("查询xxx")
    @RequestMapping("/get")
    @ResponseBody
    public Object get(String id, HttpServletRequest request) throws Exception {
        AuditPmsUser obj = service.get(id);
        PmsUser old = pmsUserService.getByAccount(obj.getUserId());//查询历史信息用作对比.
        List<Object> list = new ArrayList<Object>();
        list.add(obj);
        list.add(old);
        System.out.println("auditpmsuser-get-obj:" + obj.getOldName() + "old" + old.getOldName());
        return new Result(list);
    }

    @Log("查询xxx")
    @RequestMapping("/getAuditItem")
    @ResponseBody
    public Object getAuditItem(String userId, HttpServletRequest request) throws Exception {
        List<Object> list = new ArrayList<Object>();

/*        AuditFieldBase AuditFieldBase = new AuditFieldBase();
        AuditFieldBase.setStatus(5);
        AuditFieldBase.setUserId(userId);
        list.add(auditFieldBaseService.getList(AuditFieldBase).size());*/

/*        AuditFieldCommu AuditFieldCommu = new AuditFieldCommu();
        AuditFieldCommu.setStatus(5);
        AuditFieldCommu.setUserId(userId);
        list.add(auditFieldCommuService.getList(AuditFieldCommu).size());
        AuditPmsRelations AuditPmsRelations = new AuditPmsRelations();
        AuditPmsRelations.setStatus(5);
        AuditPmsRelations.setUserId(userId);
        list.add(auditPmsRelationsService.getList(AuditPmsRelations).size());*/

        //字段类改为使用record表
        AuditRecordBaseinfo AuditRecordBaseinfo = new AuditRecordBaseinfo();
        AuditRecordBaseinfo.setUserId(userId);
        List<AuditRecordBaseinfo> tempList = auditRecordBaseinfoService.getList(AuditRecordBaseinfo);
        if (tempList.size() > 0) {
            AuditRecordBaseinfo.setItemId(tempList.get(0).getItemId());
        }
        AuditRecordBaseinfo.setAuditStatus(5);
        list.add(auditRecordBaseinfoService.getList(AuditRecordBaseinfo).size());

        AuditRecordCommunication AuditRecordCommunication = new AuditRecordCommunication();
        AuditRecordCommunication.setUserId(userId);
        List<AuditRecordCommunication> comuTempList = auditRecordCommunicationService.getList(AuditRecordCommunication);
        if (comuTempList.size() > 0) {
            AuditRecordCommunication.setItemId(comuTempList.get(0).getItemId());
        }
        AuditRecordCommunication.setAuditStatus(5);
        list.add(auditRecordCommunicationService.getList(AuditRecordCommunication).size());

        AuditPmsRelations AuditPmsRelations = new AuditPmsRelations();
        AuditPmsRelations.setStatus(5);
        AuditPmsRelations.setUserId(userId);
        list.add(auditPmsRelationsService.getList(AuditPmsRelations).size());

        AuditPmsEducation AuditPmsEducation = new AuditPmsEducation();
        AuditPmsEducation.setUserId(userId);
        AuditPmsEducation.setStatus(5);
        list.add(auditPmsEducationService.getList(AuditPmsEducation).size());

        AuditPmsWork AuditPmsWork = new AuditPmsWork();
        AuditPmsWork.setUserId(userId);
        AuditPmsWork.setStatus(5);
        list.add(auditPmsWorkService.getList(AuditPmsWork).size());

        AuditPmsMainTechGroup AuditPmsMainTechGroup = new AuditPmsMainTechGroup();
        AuditPmsMainTechGroup.setUserId(userId);
        AuditPmsMainTechGroup.setStatus(5);
        list.add(auditPmsMainTechGroupService.getList(AuditPmsMainTechGroup).size());

        AuditPmsHonorTitle AuditPmsHonorTitle = new AuditPmsHonorTitle();
        AuditPmsHonorTitle.setUserId(userId);
        AuditPmsHonorTitle.setStatus(5);
        list.add(auditPmsHonorTitleService.getList(AuditPmsHonorTitle).size());

        AuditPmsTechAwards AuditPmsTechAwards = new AuditPmsTechAwards();
        AuditPmsTechAwards.setUserId(userId);
        AuditPmsTechAwards.setStatus(5);
        list.add(auditPmsTechAwardsService.getList(AuditPmsTechAwards).size());

        AuditPmsPaper AuditPmsPaper = new AuditPmsPaper();
        AuditPmsPaper.setUserId(userId);
        AuditPmsPaper.setStatus(5);
        list.add(auditPmsPaperService.getList(AuditPmsPaper).size());

        AuditPmsPublish AuditPmsPublish = new AuditPmsPublish();
        AuditPmsPublish.setUserId(userId);
        AuditPmsPublish.setStatus(5);
        list.add(auditPmsPublishService.getList(AuditPmsPublish).size());

        AuditPmsPatent AuditPmsPatent = new AuditPmsPatent();
        AuditPmsPatent.setUserId(userId);
        AuditPmsPatent.setStatus(5);
        list.add(auditPmsPatentService.getList(AuditPmsPatent).size());

        AuditPmsJoinProject AuditPmsJoinProject = new AuditPmsJoinProject();
        AuditPmsJoinProject.setUserId(userId);
        AuditPmsJoinProject.setStatus(5);
        list.add(auditPmsJoinProjectService.getList(AuditPmsJoinProject).size());

        AuditPmsTechnologyBrace AuditPmsTechnologyBrace = new AuditPmsTechnologyBrace();
        AuditPmsTechnologyBrace.setUserId(userId);
        AuditPmsTechnologyBrace.setStatus(5);
        list.add(auditPmsTechnologyBraceService.getList(AuditPmsTechnologyBrace).size());

        AuditPmsSupportProject AuditPmsSupportProject = new AuditPmsSupportProject();
        AuditPmsSupportProject.setUserId(userId);
        AuditPmsSupportProject.setStatus(5);
        list.add(auditPmsSupportProjectService.getList(AuditPmsSupportProject).size());

        AuditPmsYearCheck AuditPmsYearCheck = new AuditPmsYearCheck();
        AuditPmsYearCheck.setUserId(userId);
        AuditPmsYearCheck.setStatus(5);
        list.add(auditPmsYearCheckService.getList(AuditPmsYearCheck).size());

        AuditPmsSelfEvaluation AuditPmsSelfEvaluation = new AuditPmsSelfEvaluation();
        AuditPmsSelfEvaluation.setId(userId);
        AuditPmsSelfEvaluation.setStatus(5);
        list.add(auditPmsSelfEvaluationService.getList(AuditPmsSelfEvaluation).size());

        AuditPmsLeaderEvaluation AuditPmsLeaderEvaluation = new AuditPmsLeaderEvaluation();
        AuditPmsLeaderEvaluation.setUserId(userId);
        AuditPmsLeaderEvaluation.setStatus(5);
        list.add(auditPmsLeaderEvaluationService.getList(AuditPmsLeaderEvaluation).size());

        for (int i = 0;i < list.size();i++) {
            System.out.println("---ITEM" + list.get(i));
        }
        return new Result(list);
    }

    /**
     * 统计数量
     *
     * @param obj
     * @param request
     * @return
     * @throws Exception
     */
    @Log("统计xxx数量")
    @RequestMapping("/count")
    @ResponseBody
    public Object count(AuditPmsUser obj, HttpServletRequest request) throws Exception {
        return new Result(service.count(obj));
    }

    /**
     * 新增
     *
     * @param obj
     * @param request
     * @return
     * @throws Exception
     */
    @Log("新增xxx")
    @RequestMapping("/insert")
    @ResponseBody
    public Object insert(AuditPmsUser obj, HttpServletRequest request) throws Exception {
        if (service.get(obj.getId()) == null) {
            service.insert(obj);
        }else {
            service.update(obj);
        }
        return new Result();
    }


    /**
     * 修改
     *
     * @param obj
     * @param request
     * @return
     * @throws Exception
     */
    @Log("修改xxx")
    @RequestMapping("/update")
    @ResponseBody
    public Object update(AuditPmsUser obj, HttpServletRequest request) throws Exception {
        System.out.println("ididiid" + obj.getId() + "status" + obj.getStatus() + "HASDIFF" + obj.getHasDiff());
        Result result = new Result();
        if (obj.getStatus() == null) {
            obj.setStatus(5);
        }


        //审核通过更改正式库start
        if (obj.getStatus() == 1) {
            PmsUser pmsUser = obj.toAnother();
            if (pmsUserService.getByAccount(obj.getUserId()) != null) {
                pmsUserService2.update(pmsUser);
            } else {
                pmsUserService2.insert(pmsUser);
            }
        }
        //审核通过更改正式库end

        //13张无论保存还是修改将正式库的人员基本信息插入pmsuser//此service应为auditpmsuser
        System.out.println("页面userID账户----" + obj.getUserId());
        if (service.get(obj.getId()) == null) {
            AuditPmsUser auditPmsUser = pmsUserService.getByAccount(obj.getUserId()).toAnother();//getuserbyid获取正式库信息
            auditPmsUser.setStatus(5);//设置为该人员待审核。
            service.insert(auditPmsUser);
        } else {
            service.update(obj);
        }



        //判断
        String userId = obj.getId();


        AuditFieldBase AuditFieldBase = new AuditFieldBase();
        AuditFieldBase.setStatus(5);
        AuditFieldBase.setUserId(userId);
        if (auditFieldBaseService.getList(AuditFieldBase).size() > 0) {
            obj.setStatus(5);
            service.update(obj);
            return result;
        }
        AuditPmsCommunication AuditPmsCommunication = new AuditPmsCommunication();
        AuditPmsCommunication.setStatus(5);
        AuditPmsCommunication.setId(userId);
        if (auditPmsCommunicationService.getList(AuditPmsCommunication).size() > 0) {
            obj.setStatus(5);
            service.update(obj);
            return result;
        }

        AuditPmsRelations AuditPmsRelations = new AuditPmsRelations();
        AuditPmsRelations.setStatus(5);
        AuditPmsRelations.setUserId(userId);
        if (auditPmsRelationsService.getList(AuditPmsRelations).size() > 0) {
            obj.setStatus(5);
            service.update(obj);
            return result;
        }

        AuditPmsEducation AuditPmsEducation = new AuditPmsEducation();
        AuditPmsEducation.setUserId(userId);
        AuditPmsEducation.setStatus(5);
        if (auditPmsEducationService.getList(AuditPmsEducation).size() > 0) {
            obj.setStatus(5);
            service.update(obj);
            return result;
        }

        AuditPmsWork AuditPmsWork = new AuditPmsWork();
        AuditPmsWork.setUserId(userId);
        AuditPmsWork.setStatus(5);
        if (auditPmsWorkService.getList(AuditPmsWork).size() > 0) {
            obj.setStatus(5);
            service.update(obj);
            return result;
        }

        AuditPmsMainTechGroup AuditPmsMainTechGroup = new AuditPmsMainTechGroup();
        AuditPmsMainTechGroup.setUserId(userId);
        AuditPmsMainTechGroup.setStatus(5);
        if (auditPmsMainTechGroupService.getList(AuditPmsMainTechGroup).size() > 0) {
            obj.setStatus(5);
            service.update(obj);
            return result;
        }

        AuditPmsHonorTitle AuditPmsHonorTitle = new AuditPmsHonorTitle();
        AuditPmsHonorTitle.setUserId(userId);
        AuditPmsHonorTitle.setStatus(5);
        if (auditPmsHonorTitleService.getList(AuditPmsHonorTitle).size() > 0) {
            obj.setStatus(5);
            service.update(obj);
            return result;
        }

        AuditPmsTechAwards AuditPmsTechAwards = new AuditPmsTechAwards();
        AuditPmsTechAwards.setUserId(userId);
        AuditPmsTechAwards.setStatus(5);
        if (auditPmsTechAwardsService.getList(AuditPmsTechAwards).size() > 0) {
            obj.setStatus(5);
            service.update(obj);
            return result;
        }

        AuditPmsPaper AuditPmsPaper = new AuditPmsPaper();
        AuditPmsPaper.setUserId(userId);
        AuditPmsPaper.setStatus(5);
        if (auditPmsPaperService.getList(AuditPmsPaper).size() > 0) {
            obj.setStatus(5);
            service.update(obj);
            return result;
        }

        AuditPmsPublish AuditPmsPublish = new AuditPmsPublish();
        AuditPmsPublish.setUserId(userId);
        AuditPmsPublish.setStatus(5);
        if (auditPmsPublishService.getList(AuditPmsPublish).size() > 0) {
            obj.setStatus(5);
            service.update(obj);
            return result;
        }

        AuditPmsPatent AuditPmsPatent = new AuditPmsPatent();
        AuditPmsPatent.setUserId(userId);
        AuditPmsPatent.setStatus(5);
        if (auditPmsPatentService.getList(AuditPmsPatent).size() > 0) {
            obj.setStatus(5);
            service.update(obj);
            return result;
        }

        AuditPmsJoinProject AuditPmsJoinProject = new AuditPmsJoinProject();
        AuditPmsJoinProject.setUserId(userId);
        AuditPmsJoinProject.setStatus(5);
        if (auditPmsJoinProjectService.getList(AuditPmsJoinProject).size() > 0) {
            obj.setStatus(5);
            service.update(obj);
            return result;
        }

        AuditPmsTechnologyBrace AuditPmsTechnologyBrace = new AuditPmsTechnologyBrace();
        AuditPmsTechnologyBrace.setUserId(userId);
        AuditPmsTechnologyBrace.setStatus(5);
        if (auditPmsTechnologyBraceService.getList(AuditPmsTechnologyBrace).size() > 0) {
            obj.setStatus(5);
            service.update(obj);
            return result;
        }

        AuditPmsSupportProject AuditPmsSupportProject = new AuditPmsSupportProject();
        AuditPmsSupportProject.setUserId(userId);
        AuditPmsSupportProject.setStatus(5);
        if (auditPmsSupportProjectService.getList(AuditPmsSupportProject).size() > 0) {
            obj.setStatus(5);
            service.update(obj);
            return result;
        }

        AuditPmsYearCheck AuditPmsYearCheck = new AuditPmsYearCheck();
        AuditPmsYearCheck.setUserId(userId);
        AuditPmsYearCheck.setStatus(5);
        if (auditPmsYearCheckService.getList(AuditPmsYearCheck).size() > 0) {
            obj.setStatus(5);
            service.update(obj);
            return result;
        }

        AuditPmsSelfEvaluation AuditPmsSelfEvaluation = new AuditPmsSelfEvaluation();
        AuditPmsSelfEvaluation.setId(userId);
        AuditPmsSelfEvaluation.setStatus(5);
        if (auditPmsSelfEvaluationService.getList(AuditPmsSelfEvaluation).size() > 0) {
            obj.setStatus(5);
            service.update(obj);
            return result;
        }

        AuditPmsLeaderEvaluation AuditPmsLeaderEvaluation = new AuditPmsLeaderEvaluation();
        AuditPmsLeaderEvaluation.setUserId(userId);
        AuditPmsLeaderEvaluation.setStatus(5);
        if (auditPmsLeaderEvaluationService.getList(AuditPmsLeaderEvaluation).size() > 0) {
            obj.setStatus(5);
            service.update(obj);
            return result;
        }

        return result;
    }

    /**
     * 删除
     *
     * @param ids
     * @param id
     * @param request
     * @return
     * @throws Exception
     */
    @Log("删除xxx")
    @RequestMapping("/delete")
    @ResponseBody
    public Object delete(String ids, String id, HttpServletRequest request) throws Exception {
        Result result = new Result();
        if (StringUtils.isNotBlank(ids)) {
            String[] idArr = ids.split(",");
            service.delete(idArr);
        } else if (StringUtils.isNotBlank(id)) {
            service.delete(id);
        } else {
            result.setCode(-1);
            result.setInfo("删除失败:待删除编号无效!");
        }
        return result;
    }

    /**
     * 导入
     *
     * @param file
     * @param request
     * @return
     * @throws Exception
     */
    @Log("导入xxx")
    @RequestMapping("/import")
    @ResponseBody
    public Object importExcel(MultipartFile file, HttpServletRequest request) throws Exception {
        Result result = new Result();
        try {
            if (file != null && !file.isEmpty()) {
                //excel导入处理,返回excel中的数据集合
                IExcelImport ei = new ExcelImport(file);//将文件转为ExcelImport对象
                //从excel读取数据
                List<AuditPmsUser> list = ei.getImportDataAsBean(AuditPmsUser.class);
                if (list != null && list.size() > 0) {
                    int num = service.batchInsert(list);//批量插入
                    result.setInfo("成功导入数据" + num + "条!");
                } else {
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

}