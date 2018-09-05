package com.yy.young.pms.web;

import com.yy.young.common.util.Result;
import com.yy.young.common.util.StringUtils;
import com.yy.young.interfaces.log.annotation.Log;
import com.yy.young.pms.model.PmsDictionary;
import com.yy.young.common.service.ICommonService;
import com.yy.young.common.util.SpringContextHolder;
import com.yy.young.common.web.AbstractCommonController;
import com.yy.young.pms.service.IDictionaryService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 数据字典表服务
 * Created by rookie on 2018-04-02.
 */
@Controller
@RequestMapping("/pms/pmsDictionary")
public class PmsDictionaryController extends AbstractCommonController<PmsDictionary> {

    @Resource(name = "pmsDictionaryService")
    IDictionaryService dictionaryService;
    /**
     * 初始化服务实例
     */
    @Override
    public void initService() {
        this.service = SpringContextHolder.getBean("pmsDictionaryService");
    }

    /**
     * 服务设置,当this.service为null时,会调用此方法返回一个service实例
     */
    @Override
    public ICommonService<PmsDictionary> getServiceFromRequest(HttpServletRequest httpServletRequest) {
        return null;
    }

    /**
     * service方法参数加工,在此方法中对即将调用的服务参数做自定义处理并返回
     */
    @Override
    public PmsDictionary backFinalParameter(PmsDictionary pmsDictionary, HttpServletRequest httpServletRequest) {
        return pmsDictionary;
    }

    //除了常规的增删改查导入导出之外的操作,需要自行实现

    /**
     * 根据字典名查询字典数据
     * @param did 字典编号
     * @param request
     * @return
     * @throws Exception
     */
    //@Log("根据字典名查询字典数据")
    @RequestMapping({"/getListByDictionary/{did}"})
    @ResponseBody
    public Object getListByDictionary(@PathVariable("did")String did, HttpServletRequest request) throws Exception {
        if (StringUtils.isNotBlank(did)){
            PmsDictionary dictionary = new PmsDictionary();
            dictionary.setBedicId(did);
            return new Result(service.getList(dictionary));
        }
        return new Result();
    }

    /**
     * 查询字典目录
     * @param request
     * @return
     * @throws Exception
     */
    @Log("查询字典目录")
    @RequestMapping({"/getDictionaryCatalog"})
    @ResponseBody
    public Object getDictionaryCatalog(HttpServletRequest request) throws Exception {
        return new Result(dictionaryService.getDictionaryCatalog());
    }
}