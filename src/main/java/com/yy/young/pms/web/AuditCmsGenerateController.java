//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package com.yy.young.pms.web;

import com.yy.young.cms.model.Column;
import com.yy.young.cms.model.template.Model;
import com.yy.young.cms.model.template.ModelAttribute;
import com.yy.young.cms.service.ICmsDBService;
import com.yy.young.common.util.Result;
import com.yy.young.common.util.StringUtils;
import com.yy.young.dal.EDBType;
import com.yy.young.dal.service.IDataAccessService;
import com.yy.young.interfaces.log.annotation.Log;
import com.yy.young.pms.util.DataSourceHolder;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping({"/pms"})
public class AuditCmsGenerateController {
    @Resource(
        name = "cmsDBService"
    )
    ICmsDBService dbService;
    @Resource(
        name = "dataAccessService"
    )
    IDataAccessService dataAccessService;
    private static Logger logger = LoggerFactory.getLogger(AuditCmsGenerateController.class);

    public AuditCmsGenerateController() {
    }

    @Log("代码智能生成")
    @RequestMapping({"/generate"})
    @ResponseBody
    public Object generate(Model model, HttpServletRequest request) throws Exception {
        Result result = new Result();
        if (!StringUtils.isBlank(model.getPackageName()) && !StringUtils.isBlank(model.getModuleName())) {
            if (StringUtils.isBlank(model.getTableName())) {
                result.setCode(-1);
                result.setInfo("表名不允许为空");
            } else if (StringUtils.isBlank(request.getParameter("rootPath"))) {
                result.setCode(-1);
                result.setInfo("请填写正确的存放目录");
            } else {
                List<Column> list = this.dbService.getColumsByTableName(model.getTableName());
                if (list != null && list.size() > 0) {
                    if (StringUtils.isBlank(model.getClassName())) {
                        String[] arr = model.getTableName().split("_");
                        StringBuilder sb = new StringBuilder();

                        for(int i = 0; i < arr.length; ++i) {
                            sb.append(arr[i].substring(0, 1).toUpperCase()).append(arr[i].substring(1).toLowerCase());
                        }

                        model.setClassName(sb.toString());
                    }

                    List<ModelAttribute> attributeList = new ArrayList();
                    Iterator i$ = list.iterator();

                    while(i$.hasNext()) {
                        Column column = (Column)i$.next();
                        attributeList.add(new ModelAttribute(column));
                    }

                    model.setAttributeList(attributeList);
                    model.setCreateTime(new Date());
                    Map<String, Object> map = new HashMap();
                    map.put("model", model);
                    String rootPath = request.getParameter("rootPath");
                    String packagePath = rootPath + File.separator + "src" + File.separator + "main" + File.separator + "java" + File.separator + model.getPackageName().replace(".", File.separator) + File.separator + model.getModuleName();
                    String resourcePath = rootPath + File.separator + "src" + File.separator + "main" + File.separator + "resources" + File.separator + model.getPackageName().replace(".", File.separator) + File.separator + model.getModuleName();
                    String pagePath = rootPath + File.separator + "src" + File.separator + "main" + File.separator + "webapp" + File.separator + "page" + File.separator + model.getModuleName();
                    String path_model = packagePath + File.separator + "model";
                    String path_service = packagePath + File.separator + "service";
                    String path_service_impl = packagePath + File.separator + "service" + File.separator + "impl";
                    String path_util = packagePath + File.separator + "util";
                    String path_web = packagePath + File.separator + "web";
                    String path_mapper;
                    logger.info("genate dbtype:" + this.dataAccessService.getDBType());
                    if (this.dataAccessService.getDBType() == EDBType.MYSQL) {
                        path_mapper = resourcePath + File.separator + "mapper" + File.separator + "mysql";
                    } else if (this.dataAccessService.getDBType() == EDBType.ORACLE) {
                        path_mapper = resourcePath + File.separator + "mapper" + File.separator + "oracle";
                    } else {
                        if (this.dataAccessService.getDBType() != EDBType.POSTGRESQL) {
                            result.setCode(-1);
                            result.setInfo("数据库类型不匹配");
                            return result;
                        }

                        path_mapper = resourcePath + File.separator + "mapper" + File.separator + "postgres";
                    }

                    String[] dirs = new String[]{path_model, path_service, path_service_impl, path_util, path_web, path_mapper, pagePath};
                    String[] arr$ = dirs;
                    int len$ = dirs.length;

                    for(int j$ = 0; j$ < len$; ++j$) {
                        String dir = arr$[j$];
                        File f = new File(dir);
                        if (!f.exists()) {
                            f.mkdirs();
                            logger.info("[代码生成] 成功创建目录: {}", f.getAbsolutePath());
                        }
                    }

                    Configuration configuration = new Configuration();
                    configuration.setClassForTemplateLoading(this.getClass(), "/template/");

                    Template template;
                    BufferedWriter fw;
                    try {
                        template = configuration.getTemplate("Model.ftl", "UTF-8");

                        try {
                            fw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path_model + File.separator + model.getClassName() + ".java"), "UTF-8"));
                            template.process(map, fw);
                            fw.flush();
                            fw.close();
                            logger.info("[代码生成] 成功创建实体类: {}", model.getClassName() + ".java");
                        } catch (TemplateException var35) {
                            var35.printStackTrace();
                            result.setCode(-1);
                            result.setInfo("写入文件失败");
                        }
                    } catch (IOException var36) {
                        var36.printStackTrace();
                        result.setCode(-1);
                        result.setInfo("获取模板失败");
                    }

                    try {
                        template = configuration.getTemplate("Mapper.ftl", "UTF-8");

                        try {
                            fw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path_mapper + File.separator + model.getClassName() + "Mapper.xml"), "UTF-8"));
                            template.process(map, fw);
                            fw.flush();
                            fw.close();
                            logger.info("[代码生成] 成功创建Mapper.xml: {}", model.getClassName() + "Mapper.xml");
                        } catch (TemplateException var33) {
                            var33.printStackTrace();
                            result.setCode(-1);
                            result.setInfo("写入文件失败");
                        }
                    } catch (IOException var34) {
                        var34.printStackTrace();
                        result.setCode(-1);
                        result.setInfo("获取模板失败");
                    }

                    try {
                        template = configuration.getTemplate("Service.ftl", "UTF-8");

                        try {
                            fw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path_service + File.separator + "I" + model.getClassName() + "Service.java"), "UTF-8"));
                            template.process(map, fw);
                            fw.flush();
                            fw.close();
                            logger.info("[代码生成] 成功创建service接口: {}", "I" + model.getClassName() + "Service.java");
                        } catch (TemplateException var31) {
                            var31.printStackTrace();
                            result.setCode(-1);
                            result.setInfo("写入文件失败");
                        }
                    } catch (IOException var32) {
                        var32.printStackTrace();
                        result.setCode(-1);
                        result.setInfo("获取模板失败");
                    }

                    try {
                        template = configuration.getTemplate("ServiceImpl.ftl", "UTF-8");

                        try {
                            fw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path_service_impl + File.separator + model.getClassName() + "ServiceImpl.java"), "UTF-8"));
                            template.process(map, fw);
                            fw.flush();
                            fw.close();
                            logger.info("[代码生成] 成功创建service实现类: {}", model.getClassName() + "ServiceImpl.java");
                        } catch (TemplateException var29) {
                            var29.printStackTrace();
                            result.setCode(-1);
                            result.setInfo("写入文件失败");
                        }
                    } catch (IOException var30) {
                        var30.printStackTrace();
                        result.setCode(-1);
                        result.setInfo("获取模板失败");
                    }

                    try {
                        template = configuration.getTemplate("Controller.ftl", "UTF-8");

                        try {
                            fw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path_web + File.separator + model.getClassName() + "Controller.java"), "UTF-8"));
                            template.process(map, fw);
                            fw.flush();
                            fw.close();
                            logger.info("[代码生成] 成功创建Controller类: {}", model.getClassName() + "Controller.java");
                        } catch (TemplateException var27) {
                            var27.printStackTrace();
                            result.setCode(-1);
                            result.setInfo("写入文件失败");
                        }
                    } catch (IOException var28) {
                        var28.printStackTrace();
                        result.setCode(-1);
                        result.setInfo("获取模板失败");
                    }

                    try {
                        template = configuration.getTemplate("List.ftl", "UTF-8");

                        try {
                            fw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(pagePath + File.separator + model.getClassName().substring(0, 1).toLowerCase() + model.getClassName().substring(1) + "List.jsp"), "UTF-8"));
                            template.process(map, fw);
                            fw.flush();
                            fw.close();
                            logger.info("[代码生成] 成功创建视图页: {}", model.getClassName().substring(0, 1).toLowerCase() + model.getClassName().substring(1) + "List.jsp");
                        } catch (TemplateException var25) {
                            var25.printStackTrace();
                            result.setCode(-1);
                            result.setInfo("写入文件失败");
                        }
                    } catch (IOException var26) {
                        var26.printStackTrace();
                        result.setCode(-1);
                        result.setInfo("获取模板失败");
                    }

                    try {
                        template = configuration.getTemplate("Form.ftl", "UTF-8");

                        try {
                            fw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(pagePath + File.separator + model.getClassName().substring(0, 1).toLowerCase() + model.getClassName().substring(1) + "Form.jsp"), "UTF-8"));
                            template.process(map, fw);
                            fw.flush();
                            fw.close();
                            logger.info("[代码生成] 成功创建表单页: {}", model.getClassName().substring(0, 1).toLowerCase() + model.getClassName().substring(1) + "Form.jsp");
                        } catch (TemplateException var23) {
                            var23.printStackTrace();
                            result.setCode(-1);
                            result.setInfo("写入文件失败");
                        }
                    } catch (IOException var24) {
                        var24.printStackTrace();
                        result.setCode(-1);
                        result.setInfo("获取模板失败");
                    }
                } else {
                    result.setCode(-1);
                    result.setInfo("无效的表信息!");
                }
            }
        } else {
            result.setCode(-1);
            result.setInfo("包名和模块名不允许为空");
        }

        return new Result();
    }
}
