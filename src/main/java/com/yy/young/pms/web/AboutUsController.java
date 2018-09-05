package com.yy.young.pms.web;

import com.yy.young.common.util.Result;
import com.yy.young.interfaces.log.annotation.Log;
import com.yy.young.pms.model.AuditPmsRelations;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping({"/pms/aboutus"})
public class AboutUsController {
    @Log("修改家庭成员和社会关系")
    @RequestMapping("/getInfo")
    @ResponseBody
    public Object getInfo() throws Exception{
        return "page/aboutUs.jsp";
    }
}
