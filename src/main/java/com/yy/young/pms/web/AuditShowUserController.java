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
import java.util.List;

/**
* xxx服务
* Created by rookie on 2018-04-03.
*/
@Controller
@RequestMapping("/pms/auditShowUser")
public class AuditShowUserController {

    @Resource(name="auditShowUserService")
    IAuditShowUserService service;

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

    @Resource(name="auditRecordCommunicationService")
    IAuditRecordCommunicationService auditRecordCommunicationService;

    @Resource(name="auditRecordBaseinfoService")
    IAuditRecordBaseinfoService auditRecordBaseinfoService;

    @Resource(name="auditShowUserService")
    IAuditShowUserService auditShowUserService;
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
    public Object getList(AuditShowUser obj, HttpServletRequest request) throws Exception{
        List<AuditShowUser> list = service.getList(obj);
        return new Result(list);
    }

    @Log("将过去信息加入审核库")
    @RequestMapping("/oldToAudit")
    @ResponseBody
    public Object oldToAudit(AuditShowUser obj, HttpServletRequest request) throws Exception{
        List<PmsUser> educationList = pmsUserService2.getList(new PmsUser());
        for (PmsUser item : educationList) {
            String userId = item.getId();
            AuditShowUser AuditShowUser = new AuditShowUser();
            AuditShowUser.setUserId(userId);
            int size = service.getList(AuditShowUser).size();
            AuditShowUser.setPersonalShow(1);
            if (size > 0) {
            }else {
                service.insert(AuditShowUser);
            }
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
    @RequestMapping("/ogetPage")
    @ResponseBody
    public Object ogetPage(AuditShowUser obj,HttpServletRequest request) throws Exception{
        Page page = CommonUtil.getPageFromRequest(request);
        obj.setPersonalShow(1);
        List<AuditShowUser> list = service.getPage(obj, page);
        List<PmsUser> pmsUserList = new ArrayList<PmsUser>();
        PmsUser pmsUser = new PmsUser();
        for (AuditShowUser auditShowUser : list) {
            String userId = auditShowUser.getUserId();
            pmsUser.setId(userId);
            PmsUser temp = pmsUserService2.get(pmsUser);
            if (temp != null) {
                pmsUserList.add(temp);
            }
        }
        page.setData(pmsUserList);
        return page;
    }

    /**
     * 临时使用新的方法获取分页数据
     * @param obj
     * @param request
     * @return
     * @throws Exception
     */
    @Log("分页查询人员审核列表")
    @RequestMapping("/getPage")
    @ResponseBody
    public Object getPage(PmsUser obj,HttpServletRequest request) throws Exception{
        Page page = CommonUtil.getPageFromRequest(request);
        List<PmsUser> ofPmsUserList = pmsUserService2.getList(obj);
        AuditShowUser auditShowUser = new AuditShowUser();
        auditShowUser.setPersonalShow(1);
        String allUserId = "";
        for (int i=0;i<ofPmsUserList.size();i++) {
            PmsUser pmsUser = ofPmsUserList.get(i);
            allUserId += "," + pmsUser.getId();
        }
        if (ofPmsUserList.size() > 0) {
            if (StringUtils.isNotBlank(allUserId)) {
                allUserId = allUserId.substring(1);
            }
            String[] userIdArr = null;
            if(StringUtils.isNotBlank(allUserId)){
                userIdArr = allUserId.split(",");
            }
/*        String aaa = "";
        for (int i=0;i<userIdArr.length;i++) {
            aaa +=",'"+userIdArr[i] + "'";
        }
        System.out.println("用户ID：" + aaa.substring(1));*/
            auditShowUser.setUserIdArr(userIdArr);
            List<AuditShowUser> auList = service.getPage(auditShowUser,page);
            if (userIdArr != null) {
                System.out.println("审核库用户显示total：" + page.getTotal() + "长度：" + userIdArr.length);
            }
            System.out.println("正式库人员数据：" + ofPmsUserList.size() + auList.size());
            List<PmsUser> pmsUserList = new ArrayList<PmsUser>();
            for (int i=0;i<auList.size();i++) {
                for (int j=0;j<ofPmsUserList.size();j++) {
                    if ((auList.get(i).getUserId()).equals(ofPmsUserList.get(j).getId())) {
                        pmsUserList.add(ofPmsUserList.get(j));
                    }
                }
            }
            page.setData(pmsUserList);
        }
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
        AuditShowUser obj = service.get(id);
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
    public Object count(AuditShowUser obj, HttpServletRequest request) throws Exception{
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
    public Object insert(AuditShowUser obj, HttpServletRequest request) throws Exception{
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
    public Object update(AuditShowUser obj, HttpServletRequest request) throws Exception{
        service.update(obj);
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
                List<AuditShowUser> list = ei.getImportDataAsBean(AuditShowUser.class);
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
    public void exportExcel(AuditShowUser obj, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<AuditShowUser> list = service.getList(obj);
        if (list != null && list.size() > 0){
            IExcelExport ee = new ExcelExport();
            ee.insertBeanList(list, AuditShowUser.class);
            ee.write2Response(response, "excel_" + System.currentTimeMillis() + ".xls");
        }else{
            response.getWriter().write("数据为空!");
        }
    }

}