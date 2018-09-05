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
import com.yy.young.pms.service.IAuditFieldService;
import com.yy.young.pms.service.IAuditPmsCommunicationService;
import com.yy.young.pms.service.IAuditPmsUserService;
import com.yy.young.pms.service.IAuditShowUserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
* xxx服务
* Created by rookie on 2018-04-03.
*/
@Controller
@RequestMapping("/pms/auditPmsCommunication")
public class AuditPmsCommunicationController {

    @Resource(name="auditPmsCommunicationService")
    IAuditPmsCommunicationService service;

    @Resource(name = "auditPmsUserService")
    IAuditPmsUserService auditPmsUserService;

    @Resource(name = "pmsUserService")
    ICommonService<PmsUser> pmsUserService;

    @Resource(name = "communicationService")
    ICommonService<Communication> communicationService;

    @Resource(name="auditFieldService")
    IAuditFieldService auditFieldService;

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
    public Object getList(AuditPmsCommunication obj, HttpServletRequest request) throws Exception{
        List<AuditPmsCommunication> list = service.getList(obj);
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
    public Object getPage(AuditPmsCommunication obj, HttpServletRequest request) throws Exception{
        Page page = CommonUtil.getPageFromRequest(request);
        List<AuditPmsCommunication> list = service.getPage(obj, page);
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
        AuditPmsCommunication obj = service.get(id);
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
    public Object count(AuditPmsCommunication obj, HttpServletRequest request) throws Exception{
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
    public Object insert(AuditPmsCommunication obj, HttpServletRequest request) throws Exception{

        if (service.get(obj.getId()) == null) {
            service.insert(obj);
        }else {
            service.update(obj);
        }
        return new Result();
    }

    @Log("将过去信息加入审核库")
    @RequestMapping("/oldToAudit")
    @ResponseBody
    public Object oldToAudit(AuditPmsCommunication obj, HttpServletRequest request) throws Exception{
        List<Communication> educationList = communicationService.getList(null);
        for (Communication item : educationList) {
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
    * 修改
    * @param obj
    * @param request
    * @return
    * @throws Exception
    */
    @Log("修改xxx")
    @RequestMapping("/update")
    @ResponseBody
    public Object update(AuditPmsCommunication obj, HttpServletRequest request) throws Exception{
        //废弃暂且没用,使用单字段审核
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
            Communication communication = new Communication();
            communication.setId(obj.getId());
            if (communicationService.get(communication) != null) {
                communicationService.update(obj.toAnother());
            }else {
                communicationService.insert(obj.toAnother());
            }
            //添加正式库end
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
                Communication communication = new Communication();
                communication.setId(obj.getId());
                if (communicationService.get(communication) != null) {
                    communicationService.update(obj.toAnother());
                }else {
                    communicationService.insert(obj.toAnother());
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
                List<AuditPmsCommunication> list = ei.getImportDataAsBean(AuditPmsCommunication.class);
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
    public void exportExcel(AuditPmsCommunication obj, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<AuditPmsCommunication> list = service.getList(obj);
        if (list != null && list.size() > 0){
            IExcelExport ee = new ExcelExport();
            ee.insertBeanList(list, AuditPmsCommunication.class);
            ee.write2Response(response, "excel_" + System.currentTimeMillis() + ".xls");
        }else{
            response.getWriter().write("数据为空!");
        }
    }

}