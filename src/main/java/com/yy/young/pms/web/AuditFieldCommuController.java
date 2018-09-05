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
@RequestMapping("/pms/auditFieldCommu")
public class AuditFieldCommuController {

    @Resource(name="auditFieldCommuService")
    IAuditFieldCommuService service;


    @Resource(name="auditFieldService")
    IAuditFieldService auditFieldService;

    @Resource(name="auditShowUserService")
    IAuditShowUserService auditShowUserService;

    @Resource(name = "communicationService")
    ICommonService<Communication> communicationService;

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
    public Object getList(AuditFieldCommu obj, HttpServletRequest request) throws Exception{
        List<AuditFieldCommu> list = service.getList(obj);
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
    public Object getPage(AuditFieldCommu obj, HttpServletRequest request) throws Exception{
        Page page = CommonUtil.getPageFromRequest(request);
        List<AuditFieldCommu> list = service.getPage(obj, page);
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
        AuditFieldCommu obj = service.get(id);
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
    public Object count(AuditFieldCommu obj, HttpServletRequest request) throws Exception{
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
    public Object insert(AuditFieldCommu obj, HttpServletRequest request) throws Exception{
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
    public Object update(AuditFieldCommu obj, HttpServletRequest request) throws Exception{
        service.update(obj);
        return new Result();
    }
    /**
     * 获取用户审核信息，用于用户查看时信息对比请求USERID，返回信息不相同改变状态而且判断一下状态。
     */
    @Log("获取审核信息")
    @RequestMapping("/getUserAuditInfo")
    @ResponseBody
    public Object getUserAuditInfo (AuditFieldCommu obj,HttpServletRequest request) throws Exception {
        System.out.println("getUserAuditInfoid:" + obj.getId() + "statrus" + obj.getStatus());
        List<AuditFieldCommu> auditList = service.getList(obj);
        List<Object> list = new ArrayList<Object>();
        list.add(auditList);
        return new Result(list);
    }

    @Log("将过去信息加入审核库")
    @RequestMapping("/oldToAudit")
    @ResponseBody
    public Object oldToAudit(AuditFieldCommu obj, HttpServletRequest request) throws Exception{
        List<Communication> educationList = communicationService.getList(null);
        for (Communication item : educationList) {
            JSONObject jsonObject = JSONObject.fromObject(item);
            Iterator keys = jsonObject.keys();
            String userId = jsonObject.getString("id");
            while(keys.hasNext()) {
                String key = keys.next().toString();
                String val = jsonObject.getString(key);
                AuditFieldCommu auditFieldBase = new AuditFieldCommu();
                auditFieldBase.setField(key);
                auditFieldBase.setUserId(userId);
                int size = service.getList(auditFieldBase).size();
                auditFieldBase.setFieldVal(val);
                if (("id").equals(key) || ("userId").equals(key)) {
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
    @Log("修改xxx")
    @RequestMapping("/updateSingle")
    @ResponseBody
    public Object updateSingle(String pData, HttpServletRequest request) throws Exception{
        //单字段ID=puserID
        Result result = new Result();
        System.out.println("ppp"+pData);
        JSONObject obj = JSONObject.fromObject(pData);


        if (!obj.has("status")) {
            obj.put("status",5);//页面记得传
            System.out.println("JSONOBJECT不含有status，设置为5");
        }
        //修复ums_user.mapper的updateuserobj   start
        // 异常内容：UPDATE TB_UMS_USER WHERE ID='1'
        // 解决方法：随便传递一个必要字段如果NULL则设置为""
        Communication temp = new Communication();
        temp.setId(obj.getString("id"));
        String old_mobilePhone = communicationService.get(temp).getMobilePhone();
        String temp_mobilePhone = old_mobilePhone;
        System.out.println("旧手机号：" + old_mobilePhone + "    新手机号：" + obj.getString("mobilePhone"));

        //修复结束 end
        System.out.println("AUDITFIELD:" + obj.get("id"));

        Iterator iterator = obj.keys();
        String userId = obj.get("id").toString();

        //对人员审核判断
        AuditShowUser AuditShowUser = new AuditShowUser();
        AuditShowUser.setUserId(userId);
        if (auditShowUserService.getList(AuditShowUser).size() > 0) {
//            System.out.println("showuser含有该成员，");
        }else {
            auditShowUserService.insert(AuditShowUser);//无需设置status，查询时设置了
//            System.out.println("showuser不含有该成员，插入");
        }
        AuditShowUser.setPersonalShow(0);

        while (iterator.hasNext()) {
            String key = iterator.next().toString();
            String val = obj.getString(key);
            if (("mobilePhone").equals(key)) {
                old_mobilePhone = val;
                System.out.println("初步into：" + old_mobilePhone);
            }else {
                old_mobilePhone = temp_mobilePhone;
            }
            System.out.println("初步into：" + obj.get("status") + "字段名称：" + key + "字段值：" + val);
            //判断数据库中是否含有，含有则修改
            AuditFieldCommu AuditFieldCommu = new AuditFieldCommu();
            AuditFieldCommu.setUserId(userId);
            AuditFieldCommu.setField(key);
            List<AuditFieldCommu> list = service.getList(AuditFieldCommu);

            AuditFieldCommu.setFieldVal(val);
            AuditFieldCommu.setStatus((Integer) obj.get("status"));

            AuditField AuditField = new AuditField();//判断是否需要审核
            AuditField.setTableName("pms_communication");//判断是否需要审核
            AuditField.setTableField(key);

            if (list.size() > 0) {

                System.out.println("单一字段：数据库中有");
                System.out.println("单一字段状态：" + obj.get("status") + "字段名称：" + key + "字段值：" + val);
                AuditFieldCommu.setId(list.get(0).getId());
                System.out.println("status" + AuditFieldCommu.getStatus() + "id" + AuditFieldCommu.getId());
                //新增判断是否需要审核start

                System.out.println("字段是否需要审核" + key + "   不需要：" + (auditFieldService.get(AuditField) == null || auditFieldService.get(AuditField).getStatus() != 1));
                if (auditFieldService.get(AuditField) == null || auditFieldService.get(AuditField).getStatus() != 1) {
                    //不需要审核，可以直接修改正式库
                    System.out.println("不需要审核更改正式库：start");
                    System.out.println("----------修改内容相关信息------------");
                    System.out.println("" + obj.getInt("status") + "字段名称：" + key + "字段值：" + val + AuditFieldCommu.getUserId());
                    Communication pmsUser = AuditFieldCommu.toAnother();
                    pmsUser.setId(AuditFieldCommu.getUserId());
                    pmsUser.setMobilePhone(old_mobilePhone);
                    System.out.println("存在且不需要审核：" + old_mobilePhone);
                    communicationService.update(pmsUser);
                    System.out.println("不需要审核更改正式库：end");
                    AuditFieldCommu.setStatus(1);//直接设置为审核通过
                }
                System.out.println("存在且不需要审核此处为需要：" + old_mobilePhone);
                //新增判断是否需要审核end
                System.out.println("存在且不需要审核hou ：" + AuditFieldCommu.getStatus());
                service.update(AuditFieldCommu);//此时已经更改两个库前面设置了status，不需要审核的信息应该是相同的
                if (obj.getInt("status") == 1) {
                    System.out.println("更改正式库：start");
                    System.out.println("----------修改内容相关信息------------");
                    System.out.println("" + obj.getInt("status") + "字段名称：" + key + "字段值：" + val + AuditFieldCommu.getUserId());
                    System.out.println("更改正式库：end");
                    Communication pmsUser = AuditFieldCommu.toAnother();
                    pmsUser.setId(AuditFieldCommu.getUserId());
                    pmsUser.setMobilePhone(old_mobilePhone);
                    System.out.println("管理员审核通过：" + old_mobilePhone);
                    communicationService.update(pmsUser);
                }
            }else {
                //此处对于修改方来说,插入修改信息，先修改才有审核
                System.out.println("单一字段：数据库无则插入");
                System.out.println("单一字段：数据库无则插入：" + AuditFieldCommu.getStatus() + "字段名称：" + AuditFieldCommu.getField() + "字段值：" + AuditFieldCommu.getFieldVal());
                //不需要审核更改状态 start
                if (auditFieldService.get(AuditField) == null || auditFieldService.get(AuditField).getStatus() != 1) {
                    System.out.println("直接通过");

                    Communication pmsUser = AuditFieldCommu.toAnother();
                    pmsUser.setId(AuditFieldCommu.getUserId());
                    pmsUser.setMobilePhone(old_mobilePhone);
                    System.out.println("不不存在且不要审核：" + old_mobilePhone);
                    System.out.println("-----------------------------" + pmsUser.getId());
                    communicationService.update(pmsUser);
                    AuditFieldCommu.setStatus(1);//直接通过
                }
                System.out.println("-----------------------------");

                //不需要审核则更改状态 end

                service.insert(AuditFieldCommu);
            }
        }


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
                List<AuditFieldCommu> list = ei.getImportDataAsBean(AuditFieldCommu.class);
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
    public void exportExcel(AuditFieldCommu obj, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<AuditFieldCommu> list = service.getList(obj);
        if (list != null && list.size() > 0){
            IExcelExport ee = new ExcelExport();
            ee.insertBeanList(list, AuditFieldCommu.class);
            ee.write2Response(response, "excel_" + System.currentTimeMillis() + ".xls");
        }else{
            response.getWriter().write("数据为空!");
        }
    }

}