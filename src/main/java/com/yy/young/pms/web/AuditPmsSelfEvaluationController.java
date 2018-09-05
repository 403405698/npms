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
@RequestMapping("/pms/auditPmsSelfEvaluation")
public class AuditPmsSelfEvaluationController {

    @Resource(name="auditPmsSelfEvaluationService")
    IAuditPmsSelfEvaluationService service;

    @Resource(name = "auditPmsUserService")
    IAuditPmsUserService auditPmsUserService;

    @Resource(name = "pmsUserService")
    ICommonService<PmsUser> pmsUserService;

    @Resource(name = "pmsSelfEvaluationService")
    ICommonService<PmsSelfEvaluation> pmsSelfEvaluationService;

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
    public Object getList(AuditPmsSelfEvaluation obj, HttpServletRequest request) throws Exception{
        List<AuditPmsSelfEvaluation> list = service.getList(obj);
        return new Result(list);
    }


    @Log("将过去信息加入审核库")
    @RequestMapping("/oldToAudit")
    @ResponseBody
    public Object oldToAudit(AuditPmsSelfEvaluation obj, HttpServletRequest request) throws Exception{
        List<PmsSelfEvaluation> educationList = pmsSelfEvaluationService.getList(null);
        for (PmsSelfEvaluation item : educationList) {
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
    public Object getPage(AuditPmsSelfEvaluation obj, HttpServletRequest request) throws Exception{
        Page page = CommonUtil.getPageFromRequest(request);
        List<AuditPmsSelfEvaluation> list = service.getPage(obj, page);
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
        AuditPmsSelfEvaluation obj = service.get(id);
        return new Result(obj);
    }


    /**
     * 获取用户审核信息，用于用户查看时信息对比请求USERID，返回信息不相同改变状态而且判断一下状态。
     */
    @Log("获取审核信息")
    @RequestMapping("/getUserAuditInfo")
    @ResponseBody
    public Object getUserAuditInfo (AuditPmsSelfEvaluation obj,HttpServletRequest request) throws Exception {
        System.out.println("getUserAuditInfoid:" + obj.getId() + "statrus" + obj.getStatus());
        List<AuditPmsSelfEvaluation> auditList = service.getList(obj);
        List<Object> list = new ArrayList<Object>();
        list.add(auditList);
        return new Result(list);
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
    public Object count(AuditPmsSelfEvaluation obj, HttpServletRequest request) throws Exception{
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
    public Object insert(AuditPmsSelfEvaluation obj, HttpServletRequest request) throws Exception{
        service.insert(obj);


        return new Result();
    }

    @Log("审核新增")
    @RequestMapping("/auditInsert")
    @ResponseBody
    public Object auditInsert(AuditPmsSelfEvaluation obj, HttpServletRequest request) throws Exception{

        AuditField AuditField = new AuditField();
        AuditField.setTableName("pms_self_evaluation");

        //判断是否需要随意填 是start
        if (auditFieldService.get(AuditField) == null || auditFieldService.get(AuditField).getStatus() != 1) {
            System.out.println("该表不需要审核");
            pmsSelfEvaluationService.insert(obj.toAnother());
        }else {
            service.insert(obj);
            //通知showuser
            String userId = obj.getId();
            AuditShowUser AuditShowUser = new AuditShowUser();
            AuditShowUser.setUserId(userId);
            if (auditShowUserService.getList(AuditShowUser).size() > 0) {
            }else {
                auditShowUserService.insert(AuditShowUser);
            }
        }
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
    public Object update(AuditPmsSelfEvaluation obj, HttpServletRequest request) throws Exception{
        if (obj.getStatus() == null) {
            obj.setStatus(5);
        }
        if (service.get(obj.getId()) != null) {
            service.update(obj);//直接进来更新
        }else {
            service.insert(obj);
        }


        if (obj.getStatus() == 5 || obj.getStatus() == null) {
            if(auditPmsUserService.get(obj.getId()) != null) {
                AuditPmsUser auditPmsUser = auditPmsUserService.get(obj.getId());
                System.out.println("插入对象：" + auditPmsUser.getId());
                auditPmsUser.setStatus(5);
                auditPmsUserService.update(auditPmsUser);
                System.out.println("commu-更新了user5");
            }else {
                PmsUser pmsUser = new PmsUser();
                pmsUser.setId(obj.getId());
                AuditPmsUser auditPmsUser = pmsUserService.get(pmsUser).toAnother();
                System.out.println("插入对象：" + auditPmsUser.getId());
                auditPmsUser.setStatus(5);
                auditPmsUserService.insert(auditPmsUser);

                System.out.println("否则从正式库获取插入");
            }
        }

        if (obj.getStatus() == 1) {
            PmsSelfEvaluation selfEvaluation = new PmsSelfEvaluation();
            selfEvaluation.setId(obj.getId());
            if (pmsSelfEvaluationService.get(selfEvaluation) != null) {
                pmsSelfEvaluationService.update(obj.toAnother());
            }else {
                pmsSelfEvaluationService.insert(obj.toAnother());
            }
        }
        return new Result();
    }


    @Log("修改xxx")
    @RequestMapping("/updateSingle")
    @ResponseBody
    public Object updateSingle(AuditPmsSelfEvaluation obj, HttpServletRequest request) throws Exception{
        System.out.println("updatecommu---" + obj.getId() + "userid--" + obj.getStatus());
        System.out.println("STATUS;;;" + obj.getStatus());
        if (obj.getStatus() == null) {
            obj.setStatus(5);
        }

        AuditField AuditField = new AuditField();//判断是否需要审核
        AuditField.setTableName("pms_self_evaluation");//判断是否需要审核
//        AuditField.setTableField("");//不设置key
        if (auditFieldService.get(AuditField) == null || auditFieldService.get(AuditField).getStatus() != 1) {
            //不需要审核
            //处理临时库start
            if (service.get(obj.getId()) != null) {
                service.update(obj);
            }else {
                service.insert(obj);
            }
            //处理临时库end
            //添加正式库start
            PmsSelfEvaluation PmsSelfEvaluation = new PmsSelfEvaluation();
            PmsSelfEvaluation.setId(obj.getId());
            if (pmsSelfEvaluationService.get(PmsSelfEvaluation) != null) {
                pmsSelfEvaluationService.update(obj.toAnother());
            }else {
                pmsSelfEvaluationService.insert(obj.toAnother());
            }
            //添加正式库end
            //先需要审核后改为不要审核，但是审核库中有数据，直接删除
            service.delete(obj.getId());//审核库有出现脏数据，不需要审，管理员还在审核
        }else {
            //需要管理员审核
            //处理临时库start
            if (service.get(obj.getId()) != null) {
                service.update(obj);
            }else {
                service.insert(obj);
            }
            //处理临时库end
            if (obj.getStatus() == 1) {
                PmsSelfEvaluation PmsSelfEvaluation = new PmsSelfEvaluation();
                PmsSelfEvaluation.setId(obj.getId());
                if (pmsSelfEvaluationService.get(PmsSelfEvaluation) != null) {
                    pmsSelfEvaluationService.update(obj.toAnother());
                }else {
                    pmsSelfEvaluationService.insert(obj.toAnother());
                }
            }

        }

        //处理showuser
        String userId = obj.getId();//通讯信息ID = pmsuserID
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
        if (auditFieldBaseService.getList(AuditFieldBase).size() > 0) {
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
                List<AuditPmsSelfEvaluation> list = ei.getImportDataAsBean(AuditPmsSelfEvaluation.class);
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
    public void exportExcel(AuditPmsSelfEvaluation obj, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<AuditPmsSelfEvaluation> list = service.getList(obj);
        if (list != null && list.size() > 0){
            IExcelExport ee = new ExcelExport();
            ee.insertBeanList(list, AuditPmsSelfEvaluation.class);
            ee.write2Response(response, "excel_" + System.currentTimeMillis() + ".xls");
        }else{
            response.getWriter().write("数据为空!");
        }
    }

}