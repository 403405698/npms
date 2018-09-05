package com.yy.young.pms.web;

import com.yy.young.common.core.excel.ExcelExport;
import com.yy.young.common.core.excel.ExcelImport;
import com.yy.young.common.core.excel.IExcelExport;
import com.yy.young.common.core.excel.IExcelImport;
import com.yy.young.common.util.CommonUtil;
import com.yy.young.common.util.Result;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.util.Page;
import com.yy.young.interfaces.log.annotation.Log;
import com.yy.young.pms.model.AuditField;
import com.yy.young.pms.model.AuditFieldSelfeval;
import com.yy.young.pms.service.IAuditFieldSelfevalService;
import com.yy.young.pms.service.IAuditFieldService;
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
@RequestMapping("/pms/auditFieldSelfeval")
public class AuditFieldSelfevalController {

    @Resource(name="auditFieldSelfevalService")
    IAuditFieldSelfevalService service;

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
    public Object getList(AuditFieldSelfeval obj, HttpServletRequest request) throws Exception{
        List<AuditFieldSelfeval> list = service.getList(obj);
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
    public Object getPage(AuditFieldSelfeval obj, HttpServletRequest request) throws Exception{
        Page page = CommonUtil.getPageFromRequest(request);
        List<AuditFieldSelfeval> list = service.getPage(obj, page);
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
        AuditFieldSelfeval obj = service.get(id);
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
    public Object count(AuditFieldSelfeval obj, HttpServletRequest request) throws Exception{
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
    public Object insert(AuditFieldSelfeval obj, HttpServletRequest request) throws Exception{
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
    public Object update(AuditFieldSelfeval obj, HttpServletRequest request) throws Exception{
        //废除，暂且没用，使用全审核communication
        if (obj.getStatus() == null) {
            obj.setStatus(5);
        }
        AuditField AuditField = new AuditField();//判断是否需要审核
        AuditField.setTableName("pms_self_evaluation");//判断是否需要审核
//        AuditField.setTableField("");//不设置key
        if (auditFieldService.get(AuditField) == null || auditFieldService.get(AuditField).getStatus() != 1) {
            //不需要审核

        }
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
                List<AuditFieldSelfeval> list = ei.getImportDataAsBean(AuditFieldSelfeval.class);
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
    public void exportExcel(AuditFieldSelfeval obj, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<AuditFieldSelfeval> list = service.getList(obj);
        if (list != null && list.size() > 0){
            IExcelExport ee = new ExcelExport();
            ee.insertBeanList(list, AuditFieldSelfeval.class);
            ee.write2Response(response, "excel_" + System.currentTimeMillis() + ".xls");
        }else{
            response.getWriter().write("数据为空!");
        }
    }

}