package com.yy.young.pms.web;

import com.yy.young.pms.model.Work;
import com.yy.young.common.service.ICommonService;
import com.yy.young.common.util.SpringContextHolder;
import com.yy.young.common.web.AbstractCommonController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpServletRequest;

/**
 * 工作经历服务
 * Created by rookie on 2018-03-27.
 */
@Controller
@RequestMapping("/pms/work")
public class WorkController extends AbstractCommonController<Work> {

    /**
     * 初始化服务实例
     */
    @Override
    public void initService() {
        this.service = SpringContextHolder.getBean("workService");
    }

    /**
     * 服务设置,当this.service为null时,会调用此方法返回一个service实例
     */
    @Override
    public ICommonService<Work> getServiceFromRequest(HttpServletRequest httpServletRequest) {
        return null;
    }

    /**
     * service方法参数加工,在此方法中对即将调用的服务参数做自定义处理并返回
     */
    @Override
    public Work backFinalParameter(Work work, HttpServletRequest httpServletRequest) {
        return work;
    }

    //除了常规的增删改查导入导出之外的操作,需要自行实现

}