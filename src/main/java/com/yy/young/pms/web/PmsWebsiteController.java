package com.yy.young.pms.web;

import com.yy.young.cms.service.ICmsDBService;
import com.yy.young.common.service.ICommonService;
import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.Result;
import com.yy.young.common.util.StringUtils;
import com.yy.young.common.web.AbstractCommonController;
import com.yy.young.dal.util.Page;
import com.yy.young.interfaces.log.annotation.Log;
import com.yy.young.pms.model.*;
import com.yy.young.pms.service.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author hu_xuanhua_hua
 * @ClassName: PmsWebsiteController
 * @Description: TODO
 * @date 2018-09-03 22:02
 * @versoin 1.0
 **/
@RestController
@RequestMapping("/pms/website")
public class PmsWebsiteController {


    @Resource(name = "pmsUserService")
    ICommonService<PmsUser> pmsUserService;

    @Resource(name="auditFieldService")
    IAuditFieldService auditFieldService;

    @Resource(name="auditShowUserService")
    IAuditShowUserService auditShowUserService;

    @Resource(name="auditPmsCommunicationService")
    IAuditPmsCommunicationService auditPmsCommunicationService;



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
    @Resource(name = "pmsWebsiteService")
    IPmsWebsiteService service;
   /* @Resource(name = "pmsWebsiteService")
    ICommonService<PmsWebsite> pmsWebsiteService;*/

    @RequestMapping("/insert")
    public Object insert(PmsWebsite pmsWebsite, HttpServletRequest request) throws Exception {
        pmsWebsite.setUserId(pmsWebsite.getUserId().replaceAll(",",""));
        service.insert(pmsWebsite);
        return new Result();
    }
    @RequestMapping("/delete")
    public Object delete(String ids, String id, HttpServletRequest request) throws Exception {
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
   @RequestMapping("/get")
    public Object get(String   id, HttpServletRequest request) throws Exception {
//        obj.setId(obj.getId().replaceAll(",",""));
        PmsWebsite obj =  service.get(id);
        return new Result(obj);
    }
   /* @Override
    public void initService() {

    }

    @Override
    public ICommonService<PmsWebsite> getServiceFromRequest(HttpServletRequest httpServletRequest) {
        return null;
    }

    @Override
    public PmsWebsite backFinalParameter(PmsWebsite pmsWebsite, HttpServletRequest httpServletRequest) {
        return null;
    }*/
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
    public Object getPage(PmsWebsite obj, HttpServletRequest request) throws Exception{
        Page page = CommonUtil.getPageFromRequest(request);
        obj.setChinese_name(obj.getChinese_name().replaceAll(",",""));
        List<PmsWebsite> list = service.getPage(obj, page);
        page.setData(list);
        return page;
    }

}
